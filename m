Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFEFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08AE20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="pjKTUAGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgICUTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgICUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:19:38 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD6C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:19:38 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h1so1943031qvo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PX6joUw5WN/wR+AVIANPEzCWT93Q3UvjqpxbOSmJP78=;
        b=pjKTUAGMEOW9k3y+u0jzOeBKouIQ4cbAnrLlrxH6OJG2qn9Tqr1zj0WlB7zPm2n8CJ
         pipY4b3BqR3/jjcMmPaWwyD9d/TY7Y8nYhUCKVudQqH5MGeMHC+nR8ciYn/CAZOT9CyW
         yRfGlobYBHPjJMmbEDs1v4W2g5+ZvsG3qFN7OIyYPM95+6Yz8Xg7IUuX9nhYoe34aFNE
         58H/7IAYjL3D18D7gdNOmesFRc58VlPYrskrwhFoM2i0eqDIaTYVUKvdV64Hmhb2hXkv
         x5+xNCfmdg+fCfTSHfaA2aPgcPO6MtjTid6CJcHZoxAwu5XHmvVFt5XLyLJHdJJxUINE
         YL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PX6joUw5WN/wR+AVIANPEzCWT93Q3UvjqpxbOSmJP78=;
        b=DgsyIrne7FvrV4DXiaxu5FQjodej1HcliYicVYFWhZPRCjwwtjKfESYJJowRHfXsB7
         1pZBIPDL/lVXK6U6FNbwyPbUW+YgSA31ZhUR7pQxhLgXZEPSaEU5GK1OUqIWevRa+bR7
         BwDJbG01s9B7gISWZgvz6U+4ZoYKQeY7AQXnR1VMy4VV4SqNMrOaYDGLt7N1tgZhKx6Z
         p5wK7VQzsrsMNa0EKYiSVVPm9kbq0n+cKIeHhIYBel+4veTtgn0BAbPcNB52zmLZB/Za
         elC/h/QDjlciNfTntHQCoo4CkQL7lm21+CTXzI4SuHeCg5K3OdV+ABsPQrlmRRgenfaN
         RNfg==
X-Gm-Message-State: AOAM532Gt8XHxD4nctsJGO4k2KOAXTnorThT9MmJjf0Zqg/qDiBjc7W7
        9SJPyd/PtVNrdb+g/dNOFjG37g+5ZO538g==
X-Google-Smtp-Source: ABdhPJyISdY1PMFqi1zp1XFHNEpfab2tQkm3sW4MTvEWKJSCCcOwK6BlJ4NmDIwwEInWX/BY6GsHfw==
X-Received: by 2002:a0c:ca87:: with SMTP id a7mr4577935qvk.17.1599164377193;
        Thu, 03 Sep 2020 13:19:37 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
        by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:19:36 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] iommu: Handle freelists when using deferred flushing in iommu drivers
Date:   Thu,  3 Sep 2020 21:18:33 +0100
Message-Id: <20200903201839.7327-2-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the iommu_unmap_fast to return newly freed page table pages and
pass the freelist to queue_iova in the dma-iommu ops path.

This is useful for iommu drivers (in this case the intel iommu driver)
which need to wait for the ioTLB to be flushed before newly
free/unmapped page table pages can be freed. This way we can still batch
ioTLB free operations and handle the freelists.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c   | 30 ++++++++++++++------
 drivers/iommu/intel/iommu.c | 55 ++++++++++++++++++++++++-------------
 include/linux/iommu.h       |  1 +
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..f69dc9467d71 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,18 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static void iommu_dma_entry_dtor(unsigned long data)
+{
+	struct page *freelist = (struct page *)data;
+
+	while (freelist != NULL) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -344,7 +356,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
 		cookie->fq_domain = domain;
-		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
+				iommu_dma_entry_dtor);
 	}
 
 	if (!dev)
@@ -438,7 +451,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size)
+		dma_addr_t iova, size_t size, struct page *freelist)
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
@@ -447,7 +460,8 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		cookie->msi_iova -= size;
 	else if (cookie->fq_domain)	/* non-strict mode */
 		queue_iova(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad), 0);
+				size >> iova_shift(iovad),
+				(unsigned long) freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -472,7 +486,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_tlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size);
+	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -494,7 +508,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size);
+		iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -649,7 +663,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -900,7 +914,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len);
+	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -1194,7 +1208,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 237a470e1e9c..03699860880b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1160,17 +1160,17 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
    pages can only be freed after the IOTLB flush has been done. */
 static struct page *domain_unmap(struct dmar_domain *domain,
 				 unsigned long start_pfn,
-				 unsigned long last_pfn)
+				 unsigned long last_pfn,
+				 struct page *freelist)
 {
-	struct page *freelist;
-
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
 	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-				       domain->pgd, 0, start_pfn, last_pfn, NULL);
+				       domain->pgd, 0, start_pfn, last_pfn,
+				       freelist);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1924,7 +1924,8 @@ static void domain_exit(struct dmar_domain *domain)
 	if (domain->pgd) {
 		struct page *freelist;
 
-		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw),
+				NULL);
 		dma_free_pagelist(freelist);
 	}
 
@@ -3480,7 +3481,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	if (dev_is_pci(dev))
 		pdev = to_pci_dev(dev);
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+	freelist = domain_unmap(domain, start_pfn, last_pfn, NULL);
 	if (intel_iommu_strict || (pdev && pdev->untrusted) ||
 			!has_iova_flush_queue(&domain->iovad)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -4575,7 +4576,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct page *freelist;
 
 			freelist = domain_unmap(si_domain,
-						start_vpfn, last_vpfn);
+						start_vpfn, last_vpfn,
+						NULL);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
@@ -5543,10 +5545,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct page *freelist = NULL;
 	unsigned long start_pfn, last_pfn;
-	unsigned int npages;
-	int iommu_id, level = 0;
+	int level = 0;
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
@@ -5558,22 +5558,38 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	freelist = domain_unmap(dmar_domain, start_pfn, last_pfn);
-
-	npages = last_pfn - start_pfn + 1;
-
-	for_each_domain_iommu(iommu_id, dmar_domain)
-		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-				      start_pfn, npages, !freelist, 0);
-
-	dma_free_pagelist(freelist);
+	gather->freelist = domain_unmap(dmar_domain, start_pfn, last_pfn,
+			gather->freelist);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
+	iommu_iotlb_gather_add_page(domain, gather, iova, size);
+
 	return size;
 }
 
+static void intel_iommu_tlb_sync(struct iommu_domain *domain,
+		struct iommu_iotlb_gather *gather)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long iova_pfn = IOVA_PFN(gather->start);
+	size_t size = gather->end - gather->start;
+	unsigned long start_pfn, last_pfn;
+	unsigned long nrpages;
+	int iommu_id;
+
+	nrpages = aligned_nrpages(gather->start, size);
+	start_pfn = mm_to_dma_pfn(iova_pfn);
+	last_pfn = start_pfn + nrpages - 1;
+
+	for_each_domain_iommu(iommu_id, dmar_domain)
+		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
+			start_pfn, nrpages, !gather->freelist, 0);
+
+	dma_free_pagelist(gather->freelist);
+}
+
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
@@ -6058,6 +6074,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
+	.iotlb_sync		= intel_iommu_tlb_sync,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..e3eafb3cf4ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -186,6 +186,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
+	struct page		*freelist;
 };
 
 /**
-- 
2.20.1

