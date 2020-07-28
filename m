Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5C121744
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDkxxbCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgG1FBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG1FBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:01:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9BC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:01:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so10855266pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4pKXaMuOlGwMHlDLnZu9Cz9lkFD59XhRBqZiSEbtv8=;
        b=oDkxxbCK/1e5KTy2PMxsxDlEKDP/PckexYNzdyba1nmoemexJVCBu4DXY6RLi3qrwB
         8i8rQiW5ra2VU+OkBse5V8BusACTyvXQ3ls6jCnvWqtYad6On+gaVRzx3lGURPZa9LhS
         Yxv/jagEWQdcROc//XCqMqWbLYgaFKgHM17VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4pKXaMuOlGwMHlDLnZu9Cz9lkFD59XhRBqZiSEbtv8=;
        b=nNkA7U29ahLNZXmD5tlrlFQ8xUfVsc1IoJGSg8+7CSWtaN445feBx4pNnGaglVO9B/
         WlotXRcM9CqVYAkNXChS15FgKhCD/9wJQaNrRABfCPAgMI/0MnjJfULRJ+H1XLP02MJa
         RB4830IxUYF904F86SWnug/nPGCga1xlyJFsdMms/Uh9do8IXmWNgqgi4nHuOw6Bh7L/
         jLO+AEJxRgAtlsRLP9aq+mnT1kvBH+QpGNty2/qt64JYNoUChJfK6QEH619iKw2MkGA/
         EAmVElVzYMQKsVGYm/eoukNbrWxhFDqwCPATiPazlGKRSgKc5cuJz6aVxttYGgUoGBFf
         qb2Q==
X-Gm-Message-State: AOAM531A1IF1CfpkOJViRADapklHCfbZfWUxofXHBiH0OfGcVsT1jic8
        bHo+7kVMuDIo2x3PLZPUiJIHtg==
X-Google-Smtp-Source: ABdhPJyqZFgBEnGWFMq1KbkTteHW8RPRbkE10JzHa20PqcTfnP/0j4cPIqOcsy7pi2Ns8nza/X9EfA==
X-Received: by 2002:a17:90b:f0a:: with SMTP id br10mr2653647pjb.77.1595912511500;
        Mon, 27 Jul 2020 22:01:51 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id e16sm17165903pff.180.2020.07.27.22.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 22:01:50 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        drinkcat@chromium.org, tfiga@chromium.org, tientzu@chromium.org
Subject: [RFC v2 1/5] swiotlb: Add io_tlb_mem struct
Date:   Tue, 28 Jul 2020 13:01:36 +0800
Message-Id: <20200728050140.996974-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a new struct, io_tlb_mem, as the IO TLB memory pool descriptor and
moved relevant global variables into that struct.
This will be useful later to allow for per-device swiotlb regions.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/iommu/intel/iommu.c |   2 +-
 drivers/xen/swiotlb-xen.c   |   4 +-
 include/linux/swiotlb.h     |  38 ++++-
 kernel/dma/swiotlb.c        | 286 +++++++++++++++++-------------------
 4 files changed, 172 insertions(+), 158 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3f7c04cf89b3..44c9230251eb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3736,7 +3736,7 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	 */
 	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
 		tlb_addr = swiotlb_tbl_map_single(dev,
-				__phys_to_dma(dev, io_tlb_start),
+				__phys_to_dma(dev, io_tlb_default_mem.start),
 				paddr, size, aligned_size, dir, attrs);
 		if (tlb_addr == DMA_MAPPING_ERROR) {
 			goto swiotlb_error;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b6d27762c6f8..62452424ec8a 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -190,8 +190,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	/*
 	 * IO TLB memory already allocated. Just use it.
 	 */
-	if (io_tlb_start != 0) {
-		xen_io_tlb_start = phys_to_virt(io_tlb_start);
+	if (io_tlb_default_mem.start != 0) {
+		xen_io_tlb_start = phys_to_virt(io_tlb_default_mem.start);
 		goto end;
 	}
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94bd4d6..ab0d571d0826 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -69,11 +69,45 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
-extern phys_addr_t io_tlb_start, io_tlb_end;
+
+/**
+ * struct io_tlb_mem - IO TLB Memory Pool Descriptor
+ *
+ * @start:	The start address of the swiotlb memory pool. Used to do a quick
+ *		range check to see if the memory was in fact allocated by this
+ *		API. For device private swiotlb, this is device tree adjustable.
+ * @end:	The end address of the swiotlb memory pool. Used to do a quick
+ *		range check to see if the memory was in fact allocated by this
+ *		API. For device private swiotlb, this is device tree adjustable.
+ * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
+ *		@end. For system swiotlb, this is command line adjustable via
+ *		setup_io_tlb_npages.
+ * @used:	The number of used IO TLB block.
+ * @list:	The free list describing the number of free entries available
+ *		from each index.
+ * @index:	The index to start searching in the next round.
+ * @orig_addr:	The original address corresponding to a mapped entry for the
+ *		sync operations.
+ * @lock:	The lock to protect the above data structures in the map and
+ *		unmap calls.
+ * @debugfs:	The dentry to debugfs.
+ */
+struct io_tlb_mem {
+	phys_addr_t start;
+	phys_addr_t end;
+	unsigned long nslabs;
+	unsigned long used;
+	unsigned int *list;
+	unsigned int index;
+	phys_addr_t *orig_addr;
+	spinlock_t lock;
+	struct dentry *debugfs;
+};
+extern struct io_tlb_mem io_tlb_default_mem;
 
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
-	return paddr >= io_tlb_start && paddr < io_tlb_end;
+	return paddr >= io_tlb_mem.start && paddr < io_tlb_mem.end;
 }
 
 void __init swiotlb_exit(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..f83911fa14ce 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -61,33 +61,11 @@
  * allocate a contiguous 1MB, we're probably in trouble anyway.
  */
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
+#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
 enum swiotlb_force swiotlb_force;
 
-/*
- * Used to do a quick range check in swiotlb_tbl_unmap_single and
- * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
- * API.
- */
-phys_addr_t io_tlb_start, io_tlb_end;
-
-/*
- * The number of IO TLB blocks (in groups of 64) between io_tlb_start and
- * io_tlb_end.  This is command line adjustable via setup_io_tlb_npages.
- */
-static unsigned long io_tlb_nslabs;
-
-/*
- * The number of used IO TLB block
- */
-static unsigned long io_tlb_used;
-
-/*
- * This is a free list describing the number of free entries available from
- * each index
- */
-static unsigned int *io_tlb_list;
-static unsigned int io_tlb_index;
+struct io_tlb_mem io_tlb_default_mem;
 
 /*
  * Max segment that we can provide which (if pages are contingous) will
@@ -95,27 +73,17 @@ static unsigned int io_tlb_index;
  */
 unsigned int max_segment;
 
-/*
- * We need to save away the original address corresponding to a mapped entry
- * for the sync operations.
- */
-#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
-static phys_addr_t *io_tlb_orig_addr;
-
-/*
- * Protect the above data structures in the map and unmap calls
- */
-static DEFINE_SPINLOCK(io_tlb_lock);
-
 static int late_alloc;
 
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+
 	if (isdigit(*str)) {
-		io_tlb_nslabs = simple_strtoul(str, &str, 0);
+		mem->nslabs = simple_strtoul(str, &str, 0);
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+		mem->nslabs = ALIGN(mem->nslabs, IO_TLB_SEGSIZE);
 	}
 	if (*str == ',')
 		++str;
@@ -123,7 +91,7 @@ setup_io_tlb_npages(char *str)
 		swiotlb_force = SWIOTLB_FORCE;
 	} else if (!strcmp(str, "noforce")) {
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		io_tlb_nslabs = 1;
+		mem->nslabs = 1;
 	}
 
 	return 0;
@@ -134,7 +102,7 @@ static bool no_iotlb_memory;
 
 unsigned long swiotlb_nr_tbl(void)
 {
-	return unlikely(no_iotlb_memory) ? 0 : io_tlb_nslabs;
+	return unlikely(no_iotlb_memory) ? 0 : io_tlb_default_mem.nslabs;
 }
 EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
 
@@ -158,14 +126,14 @@ unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
 
-	size = io_tlb_nslabs << IO_TLB_SHIFT;
+	size = io_tlb_default_mem.nslabs << IO_TLB_SHIFT;
 
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
 void swiotlb_print_info(void)
 {
-	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	unsigned long bytes = io_tlb_default_mem.nslabs << IO_TLB_SHIFT;
 
 	if (no_iotlb_memory) {
 		pr_warn("No low mem\n");
@@ -173,9 +141,9 @@ void swiotlb_print_info(void)
 	}
 
 	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
-	       (unsigned long long)io_tlb_start,
-	       (unsigned long long)io_tlb_end,
-	       bytes >> 20);
+		(unsigned long long)io_tlb_default_mem.start,
+		(unsigned long long)io_tlb_default_mem.end,
+		bytes >> 20);
 }
 
 /*
@@ -192,50 +160,52 @@ void __init swiotlb_update_mem_attributes(void)
 	if (no_iotlb_memory || late_alloc)
 		return;
 
-	vaddr = phys_to_virt(io_tlb_start);
-	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
+	vaddr = phys_to_virt(io_tlb_default_mem.start);
+	bytes = PAGE_ALIGN(io_tlb_default_mem.nslabs << IO_TLB_SHIFT);
 	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 }
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long i, bytes;
 	size_t alloc_size;
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
-	io_tlb_nslabs = nslabs;
-	io_tlb_start = __pa(tlb);
-	io_tlb_end = io_tlb_start + bytes;
+	mem->nslabs = nslabs;
+	mem->start = __pa(tlb);
+	mem->end = mem->start + bytes;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
-	 * between io_tlb_start and io_tlb_end.
+	 * between io_tlb_default_mem.start and io_tlb_default_mem.end.
 	 */
-	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
-	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!io_tlb_list)
+	alloc_size = PAGE_ALIGN(mem->nslabs * sizeof(int));
+	mem->list = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!mem->list)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
-	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!io_tlb_orig_addr)
+	alloc_size = PAGE_ALIGN(mem->nslabs * sizeof(phys_addr_t));
+	mem->orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!mem->orig_addr)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
-		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	for (i = 0; i < mem->nslabs; i++) {
+		mem->list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		mem->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
-	io_tlb_index = 0;
 
 	if (verbose)
 		swiotlb_print_info();
 
-	swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
+	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
+	spin_lock_init(&mem->lock);
+
 	return 0;
 }
 
@@ -246,25 +216,26 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 void  __init
 swiotlb_init(int verbose)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	size_t default_size = IO_TLB_DEFAULT_SIZE;
 	unsigned char *vstart;
 	unsigned long bytes;
 
-	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+	if (!mem->nslabs) {
+		mem->nslabs = (default_size >> IO_TLB_SHIFT);
+		mem->nslabs = ALIGN(mem->nslabs, IO_TLB_SEGSIZE);
 	}
 
-	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	bytes = mem->nslabs << IO_TLB_SHIFT;
 
 	/* Get IO TLB memory from the low pages */
 	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
-	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
+	if (vstart && !swiotlb_init_with_tbl(vstart, mem->nslabs, verbose))
 		return;
 
-	if (io_tlb_start)
-		memblock_free_early(io_tlb_start,
-				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	if (mem->start)
+		memblock_free_early(mem->start,
+				    PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT));
 	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory = true;
 }
@@ -277,22 +248,23 @@ swiotlb_init(int verbose)
 int
 swiotlb_late_init_with_default_size(size_t default_size)
 {
-	unsigned long bytes, req_nslabs = io_tlb_nslabs;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long bytes, req_nslabs = mem->nslabs;
 	unsigned char *vstart = NULL;
 	unsigned int order;
 	int rc = 0;
 
-	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+	if (!mem->nslabs) {
+		mem->nslabs = (default_size >> IO_TLB_SHIFT);
+		mem->nslabs = ALIGN(mem->nslabs, IO_TLB_SEGSIZE);
 	}
 
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	order = get_order(io_tlb_nslabs << IO_TLB_SHIFT);
-	io_tlb_nslabs = SLABS_PER_PAGE << order;
-	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	order = get_order(mem->nslabs << IO_TLB_SHIFT);
+	mem->nslabs = SLABS_PER_PAGE << order;
+	bytes = mem->nslabs << IO_TLB_SHIFT;
 
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
 		vstart = (void *)__get_free_pages(GFP_DMA | __GFP_NOWARN,
@@ -303,15 +275,15 @@ swiotlb_late_init_with_default_size(size_t default_size)
 	}
 
 	if (!vstart) {
-		io_tlb_nslabs = req_nslabs;
+		mem->nslabs = req_nslabs;
 		return -ENOMEM;
 	}
 	if (order != get_order(bytes)) {
 		pr_warn("only able to allocate %ld MB\n",
 			(PAGE_SIZE << order) >> 20);
-		io_tlb_nslabs = SLABS_PER_PAGE << order;
+		mem->nslabs = SLABS_PER_PAGE << order;
 	}
-	rc = swiotlb_late_init_with_tbl(vstart, io_tlb_nslabs);
+	rc = swiotlb_late_init_with_tbl(vstart, mem->nslabs);
 	if (rc)
 		free_pages((unsigned long)vstart, order);
 
@@ -320,22 +292,23 @@ swiotlb_late_init_with_default_size(size_t default_size)
 
 static void swiotlb_cleanup(void)
 {
-	io_tlb_end = 0;
-	io_tlb_start = 0;
-	io_tlb_nslabs = 0;
+	io_tlb_default_mem.end = 0;
+	io_tlb_default_mem.start = 0;
+	io_tlb_default_mem.nslabs = 0;
 	max_segment = 0;
 }
 
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long i, bytes;
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
-	io_tlb_nslabs = nslabs;
-	io_tlb_start = virt_to_phys(tlb);
-	io_tlb_end = io_tlb_start + bytes;
+	mem->nslabs = nslabs;
+	mem->start = virt_to_phys(tlb);
+	mem->end = mem->start + bytes;
 
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
@@ -343,38 +316,39 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	/*
 	 * Allocate and initialize the free list array.  This array is used
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
-	 * between io_tlb_start and io_tlb_end.
+	 * between io_tlb_default_mem.start and io_tlb_default_mem.end.
 	 */
-	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
-	                              get_order(io_tlb_nslabs * sizeof(int)));
-	if (!io_tlb_list)
+	mem->list = (unsigned int *)__get_free_pages(GFP_KERNEL,
+				    get_order(mem->nslabs * sizeof(int)));
+	if (!mem->list)
 		goto cleanup3;
 
-	io_tlb_orig_addr = (phys_addr_t *)
+	mem->orig_addr = (phys_addr_t *)
 		__get_free_pages(GFP_KERNEL,
-				 get_order(io_tlb_nslabs *
+				 get_order(mem->nslabs *
 					   sizeof(phys_addr_t)));
-	if (!io_tlb_orig_addr)
+	if (!mem->orig_addr)
 		goto cleanup4;
 
-	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
-		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	for (i = 0; i < mem->nslabs; i++) {
+		mem->list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
+		mem->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
-	io_tlb_index = 0;
+	mem->index = 0;
 
 	swiotlb_print_info();
 
 	late_alloc = 1;
 
-	swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
+	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
+	spin_lock_init(&mem->lock);
 
 	return 0;
 
 cleanup4:
-	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-	                                                 sizeof(int)));
-	io_tlb_list = NULL;
+	free_pages((unsigned long)mem->list, get_order(mem->nslabs *
+						       sizeof(int)));
+	mem->list = NULL;
 cleanup3:
 	swiotlb_cleanup();
 	return -ENOMEM;
@@ -382,23 +356,25 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 void __init swiotlb_exit(void)
 {
-	if (!io_tlb_orig_addr)
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+
+	if (!mem->orig_addr)
 		return;
 
 	if (late_alloc) {
-		free_pages((unsigned long)io_tlb_orig_addr,
-			   get_order(io_tlb_nslabs * sizeof(phys_addr_t)));
-		free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-								 sizeof(int)));
-		free_pages((unsigned long)phys_to_virt(io_tlb_start),
-			   get_order(io_tlb_nslabs << IO_TLB_SHIFT));
+		free_pages((unsigned long)mem->orig_addr,
+			   get_order(mem->nslabs * sizeof(phys_addr_t)));
+		free_pages((unsigned long)mem->list, get_order(mem->nslabs *
+							       sizeof(int)));
+		free_pages((unsigned long)phys_to_virt(mem->start),
+			   get_order(mem->nslabs << IO_TLB_SHIFT));
 	} else {
-		memblock_free_late(__pa(io_tlb_orig_addr),
-				   PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
-		memblock_free_late(__pa(io_tlb_list),
-				   PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
-		memblock_free_late(io_tlb_start,
-				   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+		memblock_free_late(__pa(mem->orig_addr),
+				   PAGE_ALIGN(mem->nslabs * sizeof(phys_addr_t)));
+		memblock_free_late(__pa(mem->list),
+				   PAGE_ALIGN(mem->nslabs * sizeof(int)));
+		memblock_free_late(mem->start,
+				   PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT));
 	}
 	swiotlb_cleanup();
 }
@@ -451,6 +427,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long flags;
 	phys_addr_t tlb_addr;
 	unsigned int nslots, stride, index, wrap;
@@ -501,13 +478,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * Find suitable number of IO TLB entries size that will fit this
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
-	spin_lock_irqsave(&io_tlb_lock, flags);
+	spin_lock_irqsave(&mem->lock, flags);
 
-	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+	if (unlikely(nslots > mem->nslabs - mem->used))
 		goto not_found;
 
-	index = ALIGN(io_tlb_index, stride);
-	if (index >= io_tlb_nslabs)
+	index = ALIGN(mem->index, stride);
+	if (index >= mem->nslabs)
 		index = 0;
 	wrap = index;
 
@@ -515,7 +492,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		while (iommu_is_span_boundary(index, nslots, offset_slots,
 					      max_slots)) {
 			index += stride;
-			if (index >= io_tlb_nslabs)
+			if (index >= mem->nslabs)
 				index = 0;
 			if (index == wrap)
 				goto not_found;
@@ -526,40 +503,40 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		 * contiguous buffers, we allocate the buffers from that slot
 		 * and mark the entries as '0' indicating unavailable.
 		 */
-		if (io_tlb_list[index] >= nslots) {
+		if (mem->list[index] >= nslots) {
 			int count = 0;
 
 			for (i = index; i < (int) (index + nslots); i++)
-				io_tlb_list[i] = 0;
-			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
-				io_tlb_list[i] = ++count;
-			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
+				mem->list[i] = 0;
+			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && mem->list[i]; i--)
+				mem->list[i] = ++count;
+			tlb_addr = mem->start + (index << IO_TLB_SHIFT);
 
 			/*
 			 * Update the indices to avoid searching in the next
 			 * round.
 			 */
-			io_tlb_index = ((index + nslots) < io_tlb_nslabs
-					? (index + nslots) : 0);
+			mem->index = ((index + nslots) < mem->nslabs
+				      ? (index + nslots) : 0);
 
 			goto found;
 		}
 		index += stride;
-		if (index >= io_tlb_nslabs)
+		if (index >= mem->nslabs)
 			index = 0;
 	} while (index != wrap);
 
 not_found:
-	tmp_io_tlb_used = io_tlb_used;
+	tmp_io_tlb_used = mem->used;
 
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	spin_unlock_irqrestore(&mem->lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
+			 alloc_size, mem->nslabs, tmp_io_tlb_used);
 	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
-	io_tlb_used += nslots;
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	mem->used += nslots;
+	spin_unlock_irqrestore(&mem->lock, flags);
 
 	/*
 	 * Save away the mapping from the original address to the DMA address.
@@ -567,7 +544,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * needed.
 	 */
 	for (i = 0; i < nslots; i++)
-		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+		mem->orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
@@ -582,10 +559,11 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, size_t alloc_size,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long flags;
 	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = mem->orig_addr[index];
 
 	/*
 	 * First, sync the memory before unmapping the entry
@@ -601,36 +579,37 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	 * While returning the entries to the free list, we merge the entries
 	 * with slots below and above the pool being returned.
 	 */
-	spin_lock_irqsave(&io_tlb_lock, flags);
+	spin_lock_irqsave(&mem->lock, flags);
 	{
 		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
-			 io_tlb_list[index + nslots] : 0);
+			 mem->list[index + nslots] : 0);
 		/*
 		 * Step 1: return the slots to the free list, merging the
 		 * slots with superceeding slots
 		 */
 		for (i = index + nslots - 1; i >= index; i--) {
-			io_tlb_list[i] = ++count;
-			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+			mem->list[i] = ++count;
+			mem->orig_addr[i] = INVALID_PHYS_ADDR;
 		}
 		/*
 		 * Step 2: merge the returned slots with the preceding slots,
 		 * if available (non zero)
 		 */
-		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
-			io_tlb_list[i] = ++count;
+		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && mem->list[i]; i--)
+			mem->list[i] = ++count;
 
-		io_tlb_used -= nslots;
+		mem->used -= nslots;
 	}
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	spin_unlock_irqrestore(&mem->lock, flags);
 }
 
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
 {
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = mem->orig_addr[index];
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
@@ -663,6 +642,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	phys_addr_t swiotlb_addr;
 	dma_addr_t dma_addr;
 
@@ -670,7 +650,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 			      swiotlb_force);
 
 	swiotlb_addr = swiotlb_tbl_map_single(dev,
-			__phys_to_dma(dev, io_tlb_start),
+			__phys_to_dma(dev, mem->start),
 			paddr, size, size, dir, attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
@@ -699,21 +679,21 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 bool is_swiotlb_active(void)
 {
 	/*
-	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
-	 * address zero, io_tlb_end surely doesn't.
+	 * When SWIOTLB is initialized, even if io_tlb_default_mem.start points
+	 * to physical address zero, io_tlb_default_mem.end surely doesn't.
 	 */
-	return io_tlb_end != 0;
+	return io_tlb_default_mem.end != 0;
 }
 
 #ifdef CONFIG_DEBUG_FS
 
 static int __init swiotlb_create_debugfs(void)
 {
-	struct dentry *root;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 
-	root = debugfs_create_dir("swiotlb", NULL);
-	debugfs_create_ulong("io_tlb_nslabs", 0400, root, &io_tlb_nslabs);
-	debugfs_create_ulong("io_tlb_used", 0400, root, &io_tlb_used);
+	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
+	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
 	return 0;
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

