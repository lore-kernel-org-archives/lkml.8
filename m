Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F91C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A12207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgE0Lxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:31 -0400
Received: from 8bytes.org ([81.169.241.247]:44866 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgE0Lx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:27 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D18B53E2; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 04/10] iommu/amd: Allocate page-table in protection_domain_init()
Date:   Wed, 27 May 2020 13:53:07 +0200
Message-Id: <20200527115313.7426-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Consolidate the allocation of the domain page-table in one place.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 48 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c7e47a7f0d45..0d5a5dbee9f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -71,6 +71,8 @@
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 
+#define DEFAULT_PGTABLE_LEVEL	PAGE_MODE_3_LEVEL
+
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 
 /* List of all available dev_data structures */
@@ -99,7 +101,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
-static int protection_domain_init(struct protection_domain *domain);
+static int protection_domain_init(struct protection_domain *domain, int mode);
 static void detach_device(struct device *dev);
 static void update_and_flush_device_table(struct protection_domain *domain,
 					  struct domain_pgtable *pgtable);
@@ -1847,21 +1849,14 @@ static void dma_ops_domain_free(struct protection_domain *domain)
 static struct protection_domain *dma_ops_domain_alloc(void)
 {
 	struct protection_domain *domain;
-	u64 *pt_root, root;
 
 	domain = kzalloc(sizeof(struct protection_domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
-
-	pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!pt_root)
+	if (protection_domain_init(domain, DEFAULT_PGTABLE_LEVEL))
 		goto free_domain;
 
-	root = amd_iommu_domain_encode_pgtable(pt_root, PAGE_MODE_3_LEVEL);
-	atomic64_set(&domain->pt_root, root);
 	domain->flags = PD_DMA_OPS_MASK;
 
 	if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
@@ -2401,18 +2396,31 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
-static int protection_domain_init(struct protection_domain *domain)
+static int protection_domain_init(struct protection_domain *domain, int mode)
 {
+	u64 *pt_root = NULL, root;
+
+	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
+
 	spin_lock_init(&domain->lock);
 	domain->id = domain_id_alloc();
 	if (!domain->id)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&domain->dev_list);
 
+	if (mode != PAGE_MODE_NONE) {
+		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!pt_root)
+			return -ENOMEM;
+	}
+
+	root = amd_iommu_domain_encode_pgtable(pt_root, mode);
+	atomic64_set(&domain->pt_root, root);
+
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(void)
+static struct protection_domain *protection_domain_alloc(int mode)
 {
 	struct protection_domain *domain;
 
@@ -2420,7 +2428,7 @@ static struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
+	if (protection_domain_init(domain, mode))
 		goto out_err;
 
 	return domain;
@@ -2434,23 +2442,13 @@ static struct protection_domain *protection_domain_alloc(void)
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *pdomain;
-	u64 *pt_root, root;
 
 	switch (type) {
 	case IOMMU_DOMAIN_UNMANAGED:
-		pdomain = protection_domain_alloc();
+		pdomain = protection_domain_alloc(DEFAULT_PGTABLE_LEVEL);
 		if (!pdomain)
 			return NULL;
 
-		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pt_root) {
-			protection_domain_free(pdomain);
-			return NULL;
-		}
-
-		root = amd_iommu_domain_encode_pgtable(pt_root, PAGE_MODE_3_LEVEL);
-		atomic64_set(&pdomain->pt_root, root);
-
 		pdomain->domain.geometry.aperture_start = 0;
 		pdomain->domain.geometry.aperture_end   = ~0ULL;
 		pdomain->domain.geometry.force_aperture = true;
@@ -2464,11 +2462,9 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		}
 		break;
 	case IOMMU_DOMAIN_IDENTITY:
-		pdomain = protection_domain_alloc();
+		pdomain = protection_domain_alloc(PAGE_MODE_NONE);
 		if (!pdomain)
 			return NULL;
-
-		atomic64_set(&pdomain->pt_root, PAGE_MODE_NONE);
 		break;
 	default:
 		return NULL;
-- 
2.17.1

