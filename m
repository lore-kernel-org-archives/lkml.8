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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B471B21744
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLhs3co0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgG1FCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgG1FB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:01:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14913C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:01:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so10263581pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GzlYUZg9l79IbjjLQqSE/48BZ7PWQ7uRxN6Q6PXEhSQ=;
        b=jLhs3co02jfrEEgXDA7ysPbXZIOT6+aQEIY05gAffMbBj6QlSdbkT1FE0S6W0cG6T5
         LU7+PgVpV29MsP3Qg1Yxoh289spWujm0eYaBb+R7lp2zVr4J+NF9fbtPpXlJLSxdVlHy
         UXZIQfVfLs8E8wHYwC6oick+9vhx7X2X4GaVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzlYUZg9l79IbjjLQqSE/48BZ7PWQ7uRxN6Q6PXEhSQ=;
        b=iaRlEPkjbzObiZEXCAQ0jGComNGpt6Mz1sggmc28dnEHnlf3GBYjMowHN2Sokrj8Ih
         xD6vNkoPN+Dvqe85pbnQlDOXrKWaA44EZqBj73MX1EL8aV/2Tg1AnijOhYLLDKtar9KK
         BFloPIHsY4RhQrVdj4mf5qtaFq8E7ihPR2Y22GfArIM14rpib0A/vzm/+EyCmvcSuKxt
         m7Gb/L+JiP5/epPh+0U82S+XICbHEBCRB2pSswBT/WZ8JCSSjIce0+ZvnWzY3YuxdksA
         6Mvoq6HcKZgHSrdEN+eTCw2UgDIgtdfDOrevzF+CIWsXEzWnls2yGmAFCqTX3BLjpTmT
         wsSA==
X-Gm-Message-State: AOAM533xXW6764/kw5wD0FP0mCIRJT8h/hR7uzMYpe9oueNspKTiaZbJ
        AmYQK50SNbYLcOXvUQBx2oHsNw==
X-Google-Smtp-Source: ABdhPJyZAgI1AxksVIP03OkPyiL9SyEpbcrgBE+N4KENj9Tb2I3RCkhBC6+eGBSrdfJEuXkYWgCaQg==
X-Received: by 2002:a63:f814:: with SMTP id n20mr22114160pgh.92.1595912516165;
        Mon, 27 Jul 2020 22:01:56 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id b185sm16194692pfa.148.2020.07.27.22.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 22:01:55 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        drinkcat@chromium.org, tfiga@chromium.org, tientzu@chromium.org
Subject: [RFC v2 2/5] swiotlb: Add device swiotlb pool
Date:   Tue, 28 Jul 2020 13:01:37 +0800
Message-Id: <20200728050140.996974-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initialization function to create device swiotlb pools from
matching reserved-memory nodes in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/device.h |   4 ++
 kernel/dma/swiotlb.c   | 148 +++++++++++++++++++++++++++++++++--------
 2 files changed, 126 insertions(+), 26 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 79ce404619e6..f40f711e43e9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -575,6 +575,10 @@ struct device {
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
 #endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem	*dma_io_tlb_mem;
+#endif
+
 	/* arch specific additions */
 	struct dev_archdata	archdata;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f83911fa14ce..eaa101b3e75b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,10 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -298,20 +302,14 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				    size_t size)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long i, bytes;
-
-	bytes = nslabs << IO_TLB_SHIFT;
+	unsigned long i;
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
-
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	mem->nslabs = size >> IO_TLB_SHIFT;
+	mem->start = start;
+	mem->end = mem->start + size;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -336,11 +334,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	}
 	mem->index = 0;
 
-	swiotlb_print_info();
-
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 	spin_lock_init(&mem->lock);
 
 	return 0;
@@ -354,6 +347,38 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long bytes;
+	int ret;
+
+	bytes = nslabs << IO_TLB_SHIFT;
+
+	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
+	memset(tlb, 0, bytes);
+
+	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
+
+	return 0;
+}
+
+static void swiotlb_free_pages(struct io_tlb_mem *mem)
+{
+	free_pages((unsigned long)mem->orig_addr,
+		   get_order(mem->nslabs * sizeof(phys_addr_t)));
+	free_pages((unsigned long)mem->list,
+		   get_order(mem->nslabs * sizeof(int)));
+}
+
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
@@ -362,10 +387,7 @@ void __init swiotlb_exit(void)
 		return;
 
 	if (late_alloc) {
-		free_pages((unsigned long)mem->orig_addr,
-			   get_order(mem->nslabs * sizeof(phys_addr_t)));
-		free_pages((unsigned long)mem->list, get_order(mem->nslabs *
-							       sizeof(int)));
+		swiotlb_free_pages(mem);
 		free_pages((unsigned long)phys_to_virt(mem->start),
 			   get_order(mem->nslabs << IO_TLB_SHIFT));
 	} else {
@@ -687,16 +709,90 @@ bool is_swiotlb_active(void)
 
 #ifdef CONFIG_DEBUG_FS
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name,
+				   struct dentry *node)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+	mem->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(&io_tlb_default_mem, "swiotlb", NULL);
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
+
+static int device_swiotlb_init(struct reserved_mem *rmem,
+				       struct device *dev)
+{
+	struct io_tlb_mem *mem;
+	int ret;
+
+	if (dev->dma_io_tlb_mem)
+		return 0;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	if (!devm_memremap(dev, rmem->base, rmem->size, MEMREMAP_WB)) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = swiotlb_init_io_tlb_mem(mem, rmem->base, rmem->size);
+	if (ret)
+		goto cleanup;
+
+	swiotlb_create_debugfs(mem, dev_name(dev), io_tlb_default_mem.debugfs);
+
+	dev->dma_io_tlb_mem = mem;
+
+	return 0;
+
+cleanup:
+	kfree(mem);
+
+	return ret;
+}
+
+static void device_swiotlb_release(struct reserved_mem *rmem,
+					   struct device *dev)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	dev->dma_io_tlb_mem = NULL;
+
+	debugfs_remove_recursive(mem->debugfs);
+	swiotlb_free_pages(mem);
+	kfree(mem);
+}
+
+static const struct reserved_mem_ops rmem_device_swiotlb_ops = {
+	.device_init	= device_swiotlb_init,
+	.device_release	= device_swiotlb_release,
+};
+
+static int __init device_swiotlb_pool_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_device_swiotlb_ops;
+	pr_info("Reserved memory: created device swiotlb memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "device-swiotlb-pool", device_swiotlb_pool_setup);
-- 
2.28.0.rc0.142.g3c755180ce-goog

