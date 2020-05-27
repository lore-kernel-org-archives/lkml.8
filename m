Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B1208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgE0Lxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgE0Lx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88CC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2D471476; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 06/10] iommu/amd: Consolidate domain allocation/freeing
Date:   Wed, 27 May 2020 13:53:09 +0200
Message-Id: <20200527115313.7426-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Merge the allocation code paths of DMA and UNMANAGED domains and
remove code duplication.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 116 +++++++++-----------------------------
 1 file changed, 27 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5282ff6b8ea0..9e0737932e0c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -101,7 +101,6 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
-static int protection_domain_init(struct protection_domain *domain, int mode);
 static void detach_device(struct device *dev);
 static void update_and_flush_device_table(struct protection_domain *domain,
 					  struct domain_pgtable *pgtable);
@@ -1818,58 +1817,6 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-/*
- * Free a domain, only used if something went wrong in the
- * allocation path and we need to free an already allocated page table
- */
-static void dma_ops_domain_free(struct protection_domain *domain)
-{
-	struct domain_pgtable pgtable;
-
-	if (!domain)
-		return;
-
-	iommu_put_dma_cookie(&domain->domain);
-
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	atomic64_set(&domain->pt_root, 0);
-	free_pagetable(&pgtable);
-
-	if (domain->id)
-		domain_id_free(domain->id);
-
-	kfree(domain);
-}
-
-/*
- * Allocates a new protection domain usable for the dma_ops functions.
- * It also initializes the page table and the address allocator data
- * structures required for the dma_ops interface
- */
-static struct protection_domain *dma_ops_domain_alloc(void)
-{
-	struct protection_domain *domain;
-
-	domain = kzalloc(sizeof(struct protection_domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
-	if (protection_domain_init(domain, DEFAULT_PGTABLE_LEVEL))
-		goto free_domain;
-
-	domain->flags = PD_DMA_OPS_MASK;
-
-	if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
-		goto free_domain;
-
-	return domain;
-
-free_domain:
-	dma_ops_domain_free(domain);
-
-	return NULL;
-}
-
 /*
  * little helper function to check whether a given protection domain is a
  * dma_ops domain
@@ -2447,36 +2394,32 @@ static struct protection_domain *protection_domain_alloc(int mode)
 
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
-	struct protection_domain *pdomain;
-
-	switch (type) {
-	case IOMMU_DOMAIN_UNMANAGED:
-		pdomain = protection_domain_alloc(DEFAULT_PGTABLE_LEVEL);
-		if (!pdomain)
-			return NULL;
+	struct protection_domain *domain;
+	int mode = DEFAULT_PGTABLE_LEVEL;
 
-		pdomain->domain.geometry.aperture_start = 0;
-		pdomain->domain.geometry.aperture_end   = ~0ULL;
-		pdomain->domain.geometry.force_aperture = true;
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		mode = PAGE_MODE_NONE;
 
-		break;
-	case IOMMU_DOMAIN_DMA:
-		pdomain = dma_ops_domain_alloc();
-		if (!pdomain) {
-			pr_err("Failed to allocate\n");
-			return NULL;
-		}
-		break;
-	case IOMMU_DOMAIN_IDENTITY:
-		pdomain = protection_domain_alloc(PAGE_MODE_NONE);
-		if (!pdomain)
-			return NULL;
-		break;
-	default:
+	domain = protection_domain_alloc(mode);
+	if (!domain)
 		return NULL;
+
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.force_aperture = true;
+
+	if (type == IOMMU_DOMAIN_DMA) {
+		if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
+			goto free_domain;
+		domain->flags = PD_DMA_OPS_MASK;
 	}
 
-	return &pdomain->domain;
+	return &domain->domain;
+
+free_domain:
+	protection_domain_free(domain);
+
+	return NULL;
 }
 
 static void amd_iommu_domain_free(struct iommu_domain *dom)
@@ -2493,18 +2436,13 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (!dom)
 		return;
 
-	switch (dom->type) {
-	case IOMMU_DOMAIN_DMA:
-		/* Now release the domain */
-		dma_ops_domain_free(domain);
-		break;
-	default:
-		if (domain->flags & PD_IOMMUV2_MASK)
-			free_gcr3_table(domain);
+	if (dom->type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&domain->domain);
 
-		protection_domain_free(domain);
-		break;
-	}
+	if (domain->flags & PD_IOMMUV2_MASK)
+		free_gcr3_table(domain);
+
+	protection_domain_free(domain);
 }
 
 static void amd_iommu_detach_device(struct iommu_domain *dom,
-- 
2.17.1

