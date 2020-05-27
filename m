Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42612C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29209208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgE0Lx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgE0Lx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FFC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A2F9E3D0; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 03/10] iommu/amd: Let free_pagetable() not rely on domain->pt_root
Date:   Wed, 27 May 2020 13:53:06 +0200
Message-Id: <20200527115313.7426-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use 'struct domain_pgtable' instead to free_pagetable(). This solves
the problem that amd_iommu_domain_direct_map() needs to restore
domain->pt_root after the device table has been updated just to make
free_pagetable release the domain page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8368f6b9c17f..c7e47a7f0d45 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1391,20 +1391,19 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 	return freelist;
 }
 
-static void free_pagetable(struct protection_domain *domain)
+static void free_pagetable(struct domain_pgtable *pgtable)
 {
-	struct domain_pgtable pgtable;
 	struct page *freelist = NULL;
 	unsigned long root;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	atomic64_set(&domain->pt_root, 0);
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return;
 
-	BUG_ON(pgtable.mode < PAGE_MODE_NONE ||
-	       pgtable.mode > PAGE_MODE_6_LEVEL);
+	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
+	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
-	root = (unsigned long)pgtable.root;
-	freelist = free_sub_pt(root, pgtable.mode, freelist);
+	root = (unsigned long)pgtable->root;
+	freelist = free_sub_pt(root, pgtable->mode, freelist);
 
 	free_page_list(freelist);
 }
@@ -1823,12 +1822,16 @@ static void free_gcr3_table(struct protection_domain *domain)
  */
 static void dma_ops_domain_free(struct protection_domain *domain)
 {
+	struct domain_pgtable pgtable;
+
 	if (!domain)
 		return;
 
 	iommu_put_dma_cookie(&domain->domain);
 
-	free_pagetable(domain);
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	atomic64_set(&domain->pt_root, 0);
+	free_pagetable(&pgtable);
 
 	if (domain->id)
 		domain_id_free(domain->id);
@@ -2496,9 +2499,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 		break;
 	default:
 		amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-		if (pgtable.mode != PAGE_MODE_NONE)
-			free_pagetable(domain);
+		atomic64_set(&domain->pt_root, 0);
+		free_pagetable(&pgtable);
 
 		if (domain->flags & PD_IOMMUV2_MASK)
 			free_gcr3_table(domain);
@@ -2796,7 +2798,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 	struct domain_pgtable pgtable;
 	unsigned long flags;
-	u64 pt_root;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -2804,18 +2805,13 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	/* Update data structure */
-	pt_root = amd_iommu_domain_encode_pgtable(NULL, PAGE_MODE_NONE);
-	atomic64_set(&domain->pt_root, pt_root);
+	atomic64_set(&domain->pt_root, 0);
 
 	/* Make changes visible to IOMMUs */
 	update_domain(domain);
 
-	/* Restore old pgtable in domain->ptroot to free page-table */
-	pt_root = amd_iommu_domain_encode_pgtable(pgtable.root, pgtable.mode);
-	atomic64_set(&domain->pt_root, pt_root);
-
 	/* Page-table is not visible to IOMMU anymore, so free it */
-	free_pagetable(domain);
+	free_pagetable(&pgtable);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
2.17.1

