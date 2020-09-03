Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8CC2BD11
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B420709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="rD5Fivw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgICUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgICUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:19:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D7C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:19:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id f11so1971426qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YBgbnJYAAdJ88MVog+hw4aGCXypBEDTuqg8HzJEqcw=;
        b=rD5Fivw9uNQPfweTkmzpNdPcRG41y8hxdlZgs8CoXgO3TG7TavOIBvvXJdtKE83fIW
         IN7peYMu5YstwD2N36tU3kFu1BxeQvHPImXGXW1ZL54eH0wKXqgbCsnFZW2+SxPVCOJy
         mYhA3k9IDFv19z7vVWv9HfwxnnwiOBE2zFi6SVNI89kqClFZb7/XJEUCrgC3UylwC1gV
         oMTH+oLj2NAUEpm21fbkNblOOGU8fLMAgDRzWNlxFeOpriI51jRIDiLc3JEblzMoHo4/
         aBbVrbhDQkPf4KW/lfdof87Zqe6+KBG4WxOzIg+KmqsHN3Yl4N75yUFW4hyn1qnpK+HS
         tdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YBgbnJYAAdJ88MVog+hw4aGCXypBEDTuqg8HzJEqcw=;
        b=WGTK+pu21nSqs9KhQFdn723ipkJmgPJ5PUgfzxj/L/H11UQPzWuTrlqpAORSUQQi9r
         KLpUFPMwihzg30FA7qfUAzqFfZNGSsDXEtklJ2JnMsVVYDXSUT56qyp3qRXKXorg63PZ
         wJoykAFZGBb6E2o9JZR1tTK66+C5+tsBMtBw0lhS9wqBoA7/NvRu7PRaoFCJm8SN4aRH
         GC0z5PxB9NI6KJy8jyLt3htzg+h8Vg3OrS9mXMOcZJUwkoH8TQe9A+691MNqJpT26Ju9
         rb8/Fwf1BwWWpnNPAIKxt/W2MSgK5r0LSuhcUG7hd7xlbOb8F5oZlLLkTXtb7JoTJWFF
         l7Lg==
X-Gm-Message-State: AOAM533QMOcWp0sPGPeVZiIdSdKG60MKWh/D/zljK4+3M8jnBugJl1CV
        +hn9XauSpOwFgX+TfgG6U+ke2g==
X-Google-Smtp-Source: ABdhPJxM+YrROioBdam/i9eR08En5U4QYE2+Uta25yRCVxe0aE6LlyX1j2tFkUSOHr1lLb4HTmDKKQ==
X-Received: by 2002:a0c:a481:: with SMTP id x1mr3583290qvx.6.1599164388657;
        Thu, 03 Sep 2020 13:19:48 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
        by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:19:48 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] iommu: allow the dma-iommu api to use bounce buffers
Date:   Thu,  3 Sep 2020 21:18:35 +0100
Message-Id: <20200903201839.7327-4-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the dma-iommu api to use bounce buffers for untrusted devices.
This is a copy of the intel bounce buffer code.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c   | 94 ++++++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c |  6 +++
 drivers/iommu/iommu.c       | 10 ++++
 include/linux/iommu.h       |  7 +++
 4 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 33f3f4f5edc5..185cd504ca5a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,9 +21,11 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -498,26 +500,87 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
+static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_off = iova_offset(iovad, dma_addr);
+	size_t aligned_size = iova_align(iovad, size + iova_off);
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_addr);
+	if (WARN_ON(!phys))
+		return;
+
+	__iommu_dma_unmap(dev, dma_addr, size);
+
+#ifdef CONFIG_SWIOTLB
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size,
+				aligned_size, dir, attrs);
+#endif
+}
+
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, u64 dma_mask)
+		size_t org_size, dma_addr_t dma_mask, bool coherent,
+		enum dma_data_direction dir, unsigned long attrs)
 {
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
+	size_t aligned_size = iova_align(iovad, org_size + iova_off);
+	void *padding_start;
+	size_t padding_size;
 	dma_addr_t iova;
 
 	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
 		return DMA_MAPPING_ERROR;
 
-	size = iova_align(iovad, size + iova_off);
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (iommu_needs_bounce_buffer(dev)
+			&& !iova_offset(iovad, phys | org_size)) {
+		phys = swiotlb_tbl_map_single(dev,
+				__phys_to_dma(dev, io_tlb_start),
+				phys, org_size, aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE ||
+		     dir == DMA_BIDIRECTIONAL)) {
+			padding_start += org_size;
+			padding_size -= org_size;
+		}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+		memset(padding_start, 0, padding_size);
+	}
+#endif
+
+	iova = iommu_dma_alloc_iova(domain, aligned_size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
-	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+	if (iommu_map_atomic(domain, iova, phys - iova_off, aligned_size,
+				prot)) {
+
+		if (unlikely(is_swiotlb_buffer(phys)))
+			swiotlb_tbl_unmap_single(dev, phys, aligned_size,
+					aligned_size, dir, attrs);
+		iommu_dma_free_iova(cookie, iova, aligned_size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -751,10 +814,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
+	dma_handle = __iommu_dma_map(dev, phys, size, dma_get_mask(dev),
+			coherent, dir, attrs);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(phys, size, dir);
@@ -766,7 +829,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
 /*
@@ -950,21 +1013,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+	__iommu_dma_unmap_swiotlb(dev, start, end - start, dir, attrs);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			dma_get_mask(dev));
+	return __iommu_dma_map(dev, phys, size, dma_get_mask(dev), false, dir,
+			attrs);
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_unmap_swiotlb(dev, handle, size, dir, attrs);
 }
 
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
@@ -1046,7 +1108,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	struct page *page = NULL;
 	void *cpu_addr;
 
@@ -1065,8 +1126,9 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-			dev->coherent_dma_mask);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size,
+			dev->coherent_dma_mask, coherent, DMA_BIDIRECTIONAL,
+			attrs);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 03699860880b..ba47623f0f12 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5713,6 +5713,11 @@ static void intel_iommu_probe_finalize(struct device *dev)
 		set_dma_ops(dev, NULL);
 }
 
+static int intel_iommu_needs_bounce_buffer(struct device *d)
+{
+	return !intel_no_bounce && dev_is_pci(d) && to_pci_dev(d)->untrusted;
+}
+
 static void intel_iommu_get_resv_regions(struct device *device,
 					 struct list_head *head)
 {
@@ -6079,6 +6084,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
+	.needs_bounce_buffer	= intel_iommu_needs_bounce_buffer,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b6858adc4f17..8da26c73122f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2497,6 +2497,16 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_needs_bounce_buffer(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->needs_bounce_buffer)
+		return ops->needs_bounce_buffer(dev);
+
+	return 0;
+}
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e3eafb3cf4ba..4c2d2619fd8c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -263,6 +263,7 @@ struct iommu_ops {
 			       enum iommu_attr attr, void *data);
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
+	int (*needs_bounce_buffer)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -474,6 +475,7 @@ static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
 	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
 }
 
+extern int iommu_needs_bounce_buffer(struct device *dev);
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void generic_iommu_put_resv_regions(struct device *dev,
@@ -779,6 +781,11 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
+static inline int iommu_needs_bounce_buffer(struct device *dev)
+{
+	return 0;
+}
+
 static inline void iommu_get_resv_regions(struct device *dev,
 					struct list_head *list)
 {
-- 
2.20.1

