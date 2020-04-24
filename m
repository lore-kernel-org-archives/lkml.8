Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90032C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4418A20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="omq3j1vG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:27:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDXW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:27:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OMRfqS071890;
        Fri, 24 Apr 2020 17:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587767261;
        bh=Gd0x8yGKYprwuJgwtffInggvkL8eAwTBMWfMla89pww=;
        h=From:To:CC:Subject:Date;
        b=omq3j1vGxYzkS8ttslAOcSzGdXHIJJTI8aGzhLejFsmzdR8qUNE2KFM/xUMxp5p4k
         CJbOx8fPCkqZda+bFL0mi5b55AdrkllH4bxnLjjtDh59EBNI5IAvcIffoS5JiJwDGs
         Zxb6UAzcIsYbemUwvxf21vl9UC4zq0yVjtSV9fIs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OMRfMt128815;
        Fri, 24 Apr 2020 17:27:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 17:27:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 17:27:40 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OMRe76082357;
        Fri, 24 Apr 2020 17:27:40 -0500
Received: from localhost ([10.250.38.163])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 03OMReN2078792;
        Fri, 24 Apr 2020 17:27:40 -0500
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
Date:   Fri, 24 Apr 2020 18:27:40 -0400
Message-ID: <20200424222740.16259-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new export type exposes to userspace the SRAM area as a DMA-Heap,
this allows for allocations as DMA-BUFs that can be consumed by various
DMA-BUF supporting devices.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/sram/sram.yaml        |   8 +
 drivers/misc/Kconfig                          |   7 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/sram-dma-heap.c                  | 243 ++++++++++++++++++
 drivers/misc/sram.c                           |  20 +-
 drivers/misc/sram.h                           |  17 ++
 6 files changed, 292 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/sram-dma-heap.c

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7b83cc6c9bfa..b8e33c8d205d 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -105,6 +105,14 @@ patternProperties:
           manipulation of the page attributes.
         type: boolean
 
+      dma-heap-export:
+        description:
+          Similar to 'pool' and 'export' this region will be exported for use
+          by drivers, devices, and userspace using the DMA-Heaps framework.
+          NOTE: This region must be page aligned on start and end in order to
+          properly allow manipulation of the page attributes.
+        type: boolean
+
       label:
         description:
           The name for the reserved partition, if omitted, the label is taken
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 99e151475d8f..10a9aed531c4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,13 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config SRAM_DMA_HEAP
+	bool "Export on-chip SRAM pools using DMA-Heaps"
+	depends on DMABUF_HEAPS && SRAM
+	help
+	  This driver allows the export of on-chip SRAM marked as exportable
+	  to userspace using the DMA-Heaps interface.
+
 config VEXPRESS_SYSCFG
 	bool "Versatile Express System Configuration driver"
 	depends on VEXPRESS_CONFIG
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9abf2923d831..c5b5db26ebb2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
new file mode 100644
index 000000000000..38df0397f294
--- /dev/null
+++ b/drivers/misc/sram-dma-heap.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SRAM DMA-Heap userspace exporter
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+
+#include "sram.h"
+
+struct sram_dma_heap {
+	struct dma_heap *heap;
+	struct gen_pool *pool;
+};
+
+struct sram_dma_heap_buffer {
+	struct gen_pool *pool;
+	struct list_head attachments;
+	struct mutex attachments_lock;
+	unsigned long len;
+	void *vaddr;
+	phys_addr_t paddr;
+};
+
+struct dma_heap_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a;
+	struct sg_table *table;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		kfree(a);
+		return -ENOMEM;
+	}
+	if (sg_alloc_table(table, 1, GFP_KERNEL)) {
+		kfree(table);
+		kfree(a);
+		return -ENOMEM;
+	}
+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);
+
+	a->table = table;
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->attachments_lock);
+
+	return 0;
+}
+
+static void dma_heap_detatch(struct dma_buf *dmabuf,
+			     struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a = attachment->priv;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->attachments_lock);
+
+	sg_free_table(a->table);
+	kfree(a->table);
+	kfree(a);
+}
+
+static struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+					     enum dma_data_direction direction)
+{
+	struct dma_heap_attachment *a = attachment->priv;
+	struct sg_table *table = a->table;
+
+	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+			      direction, DMA_ATTR_SKIP_CPU_SYNC))
+		return ERR_PTR(-ENOMEM);
+
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
+			   direction, DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+	kfree(buffer);
+}
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	int ret;
+
+	/* SRAM mappings are not cached */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	ret = vm_iomap_memory(vma, buffer->paddr, buffer->len);
+	if (ret)
+		pr_err("Could not map buffer to userspace\n");
+
+	return ret;
+}
+
+static void *dma_heap_vmap(struct dma_buf *dmabuf)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	return buffer->vaddr;
+}
+
+const struct dma_buf_ops sram_dma_heap_buf_ops = {
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detatch,
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.release = dma_heap_dma_buf_release,
+	.mmap = dma_heap_mmap,
+	.vmap = dma_heap_vmap,
+};
+
+static int sram_dma_heap_allocate(struct dma_heap *heap,
+				  unsigned long len,
+				  unsigned long fd_flags,
+				  unsigned long heap_flags)
+{
+	struct sram_dma_heap *sram_dma_heap = dma_heap_get_drvdata(heap);
+	struct sram_dma_heap_buffer *buffer;
+
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+	buffer->pool = sram_dma_heap->pool;
+	INIT_LIST_HEAD(&buffer->attachments);
+	mutex_init(&buffer->attachments_lock);
+	buffer->len = len;
+
+	buffer->vaddr = (void *)gen_pool_alloc(buffer->pool, buffer->len);
+	if (!buffer->vaddr) {
+		ret = -ENOMEM;
+		goto free_buffer;
+	}
+
+	buffer->paddr = gen_pool_virt_to_phys(buffer->pool, (unsigned long)buffer->vaddr);
+	if (buffer->paddr == -1) {
+		ret = -ENOMEM;
+		goto free_pool;
+	}
+
+	/* create the dmabuf */
+	exp_info.ops = &sram_dma_heap_buf_ops;
+	exp_info.size = buffer->len;
+	exp_info.flags = fd_flags;
+	exp_info.priv = buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pool;
+	}
+
+	ret = dma_buf_fd(dmabuf, fd_flags);
+	if (ret < 0) {
+		dma_buf_put(dmabuf);
+		/* just return, as put will call release and that will free */
+		return ret;
+	}
+
+	return ret;
+
+free_pool:
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+free_buffer:
+	kfree(buffer);
+
+	return ret;
+}
+
+static struct dma_heap_ops sram_dma_heap_ops = {
+	.allocate = sram_dma_heap_allocate,
+};
+
+int sram_dma_heap_export(struct sram_dev *sram,
+			 struct sram_reserve *block,
+			 phys_addr_t start,
+			 struct sram_partition *part)
+{
+	struct sram_dma_heap *sram_dma_heap;
+	struct dma_heap_export_info exp_info;
+
+	dev_info(sram->dev, "Exporting SRAM pool '%s'\n", block->label);
+
+	sram_dma_heap = kzalloc(sizeof(*sram_dma_heap), GFP_KERNEL);
+	if (!sram_dma_heap)
+		return -ENOMEM;
+	sram_dma_heap->pool = part->pool;
+
+	exp_info.name = kasprintf(GFP_KERNEL, "sram_%s", block->label);
+	exp_info.ops = &sram_dma_heap_ops;
+	exp_info.priv = sram_dma_heap;
+	sram_dma_heap->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(sram_dma_heap->heap)) {
+		int ret = PTR_ERR(sram_dma_heap->heap);
+		kfree(sram_dma_heap);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 6c1a23cb3e8c..0337e271cfe2 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -109,6 +109,15 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 		if (ret)
 			return ret;
 	}
+	if (block->dma_heap_export) {
+		ret = sram_add_pool(sram, block, start, part);
+		if (ret)
+			return ret;
+
+		ret = sram_dma_heap_export(sram, block, start, part);
+		if (ret)
+			return ret;
+	}
 	if (block->protect_exec) {
 		ret = sram_check_protect_exec(sram, block, part);
 		if (ret)
@@ -209,8 +218,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 		if (of_find_property(child, "protect-exec", NULL))
 			block->protect_exec = true;
 
-		if ((block->export || block->pool || block->protect_exec) &&
-		    block->size) {
+		if (of_find_property(child, "dma-heap-export", NULL))
+			block->dma_heap_export = true;
+
+		if ((block->export || block->pool || block->protect_exec ||
+		     block->dma_heap_export) && block->size) {
 			exports++;
 
 			label = NULL;
@@ -272,8 +284,8 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 			goto err_chunks;
 		}
 
-		if ((block->export || block->pool || block->protect_exec) &&
-		    block->size) {
+		if ((block->export || block->pool || block->protect_exec ||
+		     block->dma_heap_export) && block->size) {
 			ret = sram_add_partition(sram, block,
 						 res->start + block->start);
 			if (ret) {
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index 9c1d21ff7347..e60ab13e8e6b 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -32,6 +32,7 @@ struct sram_reserve {
 	bool export;
 	bool pool;
 	bool protect_exec;
+	bool dma_heap_export;
 	const char *label;
 };
 
@@ -52,4 +53,20 @@ static inline int sram_add_protect_exec(struct sram_partition *part)
 	return -ENODEV;
 }
 #endif /* CONFIG_SRAM_EXEC */
+
+#ifdef CONFIG_SRAM_DMA_HEAP
+int sram_dma_heap_export(struct sram_dev *sram,
+			 struct sram_reserve *block,
+			 phys_addr_t start,
+			 struct sram_partition *part);
+#else
+static inline int sram_dma_heap_export(struct sram_dev *sram,
+				       struct sram_reserve *block,
+				       phys_addr_t start,
+				       struct sram_partition *part)
+{
+	return 0;
+}
+#endif /* CONFIG_SRAM_DMA_HEAP */
+
 #endif /* __SRAM_H */
-- 
2.17.1

