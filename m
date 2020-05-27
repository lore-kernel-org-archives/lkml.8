Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F45C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C7208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgE0Lxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgE0Lx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A24C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0045E475; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 05/10] iommu/amd: Free page-table in protection_domain_free()
Date:   Wed, 27 May 2020 13:53:08 +0200
Message-Id: <20200527115313.7426-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Align release of the page-table with the place where it is allocated.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0d5a5dbee9f3..5282ff6b8ea0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2387,12 +2387,18 @@ static void cleanup_domain(struct protection_domain *domain)
 
 static void protection_domain_free(struct protection_domain *domain)
 {
+	struct domain_pgtable pgtable;
+
 	if (!domain)
 		return;
 
 	if (domain->id)
 		domain_id_free(domain->id);
 
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	atomic64_set(&domain->pt_root, 0);
+	free_pagetable(&pgtable);
+
 	kfree(domain);
 }
 
@@ -2476,7 +2482,6 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
-	struct domain_pgtable pgtable;
 
 	domain = to_pdomain(dom);
 
@@ -2494,10 +2499,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 		dma_ops_domain_free(domain);
 		break;
 	default:
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
-		atomic64_set(&domain->pt_root, 0);
-		free_pagetable(&pgtable);
-
 		if (domain->flags & PD_IOMMUV2_MASK)
 			free_gcr3_table(domain);
 
-- 
2.17.1

