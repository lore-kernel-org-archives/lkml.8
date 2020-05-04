Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA257C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47A72071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEDMzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728940AbgEDMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:19 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549AC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:54:18 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 300465BB; Mon,  4 May 2020 14:54:15 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5/5] iommu/amd: Do not flush Device Table in iommu_map_page()
Date:   Mon,  4 May 2020 14:54:13 +0200
Message-Id: <20200504125413.16798-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The flush of the Device Table Entries for the domain has already
happened in increase_address_space(), if necessary. Do no flush them
again in iommu_map_page().

Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2ae1daac888a..1dc3718560d0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1446,15 +1446,18 @@ static bool increase_address_space(struct protection_domain *domain,
 {
 	struct domain_pgtable pgtable;
 	unsigned long flags;
-	bool ret = false;
+	bool ret = true;
 	u64 *pte, root;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
-	if (address <= PM_LEVEL_SIZE(pgtable.mode) ||
-	    WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
+	if (address <= PM_LEVEL_SIZE(pgtable.mode))
+		goto out;
+
+	ret = false;
+	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
@@ -1499,19 +1502,15 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		bool upd = increase_address_space(domain, address, gfp);
-
-		/* Read new values to check if update was successful */
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
-
 		/*
 		 * Return an error if there is no memory to update the
 		 * page-table.
 		 */
-		if (!upd && (address > PM_LEVEL_SIZE(pgtable.mode)))
+		if (!increase_address_space(domain, address, gfp))
 			return NULL;
 
-		*updated = *updated || upd;
+		/* Read new values to check if update was successful */
+		amd_iommu_domain_get_pgtable(domain, &pgtable);
 	}
 
 
@@ -1719,7 +1718,13 @@ static int iommu_map_page(struct protection_domain *dom,
 		unsigned long flags;
 
 		spin_lock_irqsave(&dom->lock, flags);
-		update_domain(dom);
+		/*
+		 * Flush domain TLB(s) and wait for completion. Any Device-Table
+		 * Updates and flushing already happened in
+		 * increase_address_space().
+		 */
+		domain_flush_tlb_pde(dom);
+		domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
-- 
2.17.1

