Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B438DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F63207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+FNQPOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIJSWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIJSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81739C06179A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id r7so10070520ejs.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bzSWJz/yD18dSLJVN4DXcq/iHHHTtiAbEBAhXiPwRw=;
        b=L+FNQPOhRg+Gbu3Wfm1JS1Qjm0EJoSNkPOjeh9oYespdMAytchQgsJlnalEjPnsvuk
         7DJQ8zd4Dvqa05knSmYYhPG7quOQOQImPV2ndujkD/XmMLvMWw5wGRoecf8pKx917mXt
         y8Nwc2Vr1OEtaoqUH1eSTC19SWmUtN1tOZ0ctGZcDedzN5F7CkOEsdI2nZcHMbmRinKp
         uYaL2/VQJlCOLhmCczCBy3COVsOqauKq3Ad3SknL+9fkK8d7cuPo9s2nFBvueWSvM12x
         bwvc0FIFcHd5BS9CLKHYYXH0hv9/u8vgOkklau3fwZX2TFG5KhzfK6P0CGvYGVyKL0B1
         AoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bzSWJz/yD18dSLJVN4DXcq/iHHHTtiAbEBAhXiPwRw=;
        b=um9F3OmJAVfH2xsQyCmL0og4nOvFwuyNZC0ozg0mOlcPGmR6GEW5Kxvrlhs4o2GORR
         nlIaMKGHUbmur+e7valNKGOtQWrapsilGCQoAC66UDJhYDjtmtVreSAV1Ju/SqVwj626
         5nR/MkRTASwwPeDnvDtIED+K2+P6mEYc+7rZ0XcRRjJvSSr8AWwpB2ITVkiF9Y6MGZGG
         nd1/n76Ep7o/3P+DtRRG0phU9SvURWAkBJzFHchoY2ZIkvvwOTgmZq1PL2D0iXk0/+By
         UKEJcQB+NfXoQ0vUjwQ40Ubr/Uki/mxyVinnQ/2pH6soasMeO5Ujrfss2HuE9rwQsZMr
         0uYg==
X-Gm-Message-State: AOAM533WWPl5JKFrak9JfOBickp/QiPVlxRhNg3c2/Yukt82+3O3ItZW
        d24LroBDNHm0zUaZohndRrSz8QWSFXU=
X-Google-Smtp-Source: ABdhPJzo0c7XhAsJoM/VkkAPyYIBLXYhZUjIz4FLbq0xpzP9GBZDBwMV/HaCXtQaTF10mrANfhhi6g==
X-Received: by 2002:a17:906:4a53:: with SMTP id a19mr10783246ejv.56.1599761749220;
        Thu, 10 Sep 2020 11:15:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 10/11] habanalabs: Add an option to map CB to device MMU
Date:   Thu, 10 Sep 2020 21:15:23 +0300
Message-Id: <20200910181524.21460-10-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

There are cases in which the device should access the host memory of a
CB through the device MMU, and thus this memory should be mapped.
The patch adds a flag to the CB IOCTL, in which a user can ask the
driver to perform the mapping when creating a CB.
The mapping is allowed only if a dedicated VA range was allocated for
the specific ASIC.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/common/command_buffer.c   | 197 +++++++++++++++++-
 drivers/misc/habanalabs/common/context.c      |  12 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  20 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |   4 +-
 drivers/misc/habanalabs/goya/goya.c           |   4 +-
 include/uapi/misc/habanalabs.h                |  12 +-
 6 files changed, 238 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 0cb556fb4a8b..8e23fba2557e 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -13,6 +13,132 @@
 #include <linux/uaccess.h>
 #include <linux/genalloc.h>
 
+static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_vm_va_block *va_block, *tmp;
+	dma_addr_t bus_addr;
+	u64 virt_addr;
+	u32 page_size = prop->pmmu.page_size;
+	s32 offset;
+	int rc;
+
+	if (!hdev->supports_cb_mapping) {
+		dev_err_ratelimited(hdev->dev,
+				"Cannot map CB because no VA range is allocated for CB mapping\n");
+		return -EINVAL;
+	}
+
+	if (!hdev->mmu_enable) {
+		dev_err_ratelimited(hdev->dev,
+				"Cannot map CB because MMU is disabled\n");
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&cb->va_block_list);
+
+	for (bus_addr = cb->bus_address;
+			bus_addr < cb->bus_address + cb->size;
+			bus_addr += page_size) {
+
+		virt_addr = (u64) gen_pool_alloc(ctx->cb_va_pool, page_size);
+		if (!virt_addr) {
+			dev_err(hdev->dev,
+				"Failed to allocate device virtual address for CB\n");
+			rc = -ENOMEM;
+			goto err_va_pool_free;
+		}
+
+		va_block = kzalloc(sizeof(*va_block), GFP_KERNEL);
+		if (!va_block) {
+			rc = -ENOMEM;
+			gen_pool_free(ctx->cb_va_pool, virt_addr, page_size);
+			goto err_va_pool_free;
+		}
+
+		va_block->start = virt_addr;
+		va_block->end = virt_addr + page_size;
+		va_block->size = page_size;
+		list_add_tail(&va_block->node, &cb->va_block_list);
+	}
+
+	mutex_lock(&ctx->mmu_lock);
+
+	bus_addr = cb->bus_address;
+	offset = 0;
+	list_for_each_entry(va_block, &cb->va_block_list, node) {
+		rc = hl_mmu_map(ctx, va_block->start, bus_addr, va_block->size,
+				list_is_last(&va_block->node,
+						&cb->va_block_list));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to map va %#llx to CB's pa %#llx\n",
+				va_block->start, bus_addr);
+			goto err_va_umap;
+		}
+
+		bus_addr += va_block->size;
+		offset += va_block->size;
+	}
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+	cb->is_mmu_mapped = true;
+
+	return 0;
+
+err_va_umap:
+	list_for_each_entry(va_block, &cb->va_block_list, node) {
+		if (offset <= 0)
+			break;
+		hl_mmu_unmap(ctx, va_block->start, va_block->size,
+				offset <= va_block->size);
+		offset -= va_block->size;
+	}
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+err_va_pool_free:
+	list_for_each_entry_safe(va_block, tmp, &cb->va_block_list, node) {
+		gen_pool_free(ctx->cb_va_pool, va_block->start, va_block->size);
+		list_del(&va_block->node);
+		kfree(va_block);
+	}
+
+	return rc;
+}
+
+static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct hl_vm_va_block *va_block, *tmp;
+
+	mutex_lock(&ctx->mmu_lock);
+
+	list_for_each_entry(va_block, &cb->va_block_list, node)
+		if (hl_mmu_unmap(ctx, va_block->start, va_block->size,
+				list_is_last(&va_block->node,
+						&cb->va_block_list)))
+			dev_warn_ratelimited(hdev->dev,
+					"Failed to unmap CB's va 0x%llx\n",
+					va_block->start);
+
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+	list_for_each_entry_safe(va_block, tmp, &cb->va_block_list, node) {
+		gen_pool_free(ctx->cb_va_pool, va_block->start, va_block->size);
+		list_del(&va_block->node);
+		kfree(va_block);
+	}
+}
+
 static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 {
 	if (cb->is_internal)
@@ -47,6 +173,9 @@ static void cb_release(struct kref *ref)
 
 	hl_debugfs_remove_cb(cb);
 
+	if (cb->is_mmu_mapped)
+		cb_unmap_mem(cb->ctx, cb);
+
 	hl_ctx_put(cb->ctx);
 
 	cb_do_release(hdev, cb);
@@ -110,7 +239,7 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
-			u64 *handle)
+			bool map_cb, u64 *handle)
 {
 	struct hl_cb *cb;
 	bool alloc_new_cb = true;
@@ -169,13 +298,26 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	cb->ctx = ctx;
 	hl_ctx_get(hdev, cb->ctx);
 
+	if (map_cb) {
+		if (ctx_id == HL_KERNEL_ASID_ID) {
+			dev_err(hdev->dev,
+				"CB mapping is not supported for kernel context\n");
+			rc = -EINVAL;
+			goto release_cb;
+		}
+
+		rc = cb_map_mem(ctx, cb);
+		if (rc)
+			goto release_cb;
+	}
+
 	spin_lock(&mgr->cb_lock);
 	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
 	spin_unlock(&mgr->cb_lock);
 
 	if (rc < 0) {
 		dev_err(hdev->dev, "Failed to allocate IDR for a new CB\n");
-		goto release_cb;
+		goto unmap_mem;
 	}
 
 	cb->id = (u64) rc;
@@ -194,6 +336,9 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 
 	return 0;
 
+unmap_mem:
+	if (cb->is_mmu_mapped)
+		cb_unmap_mem(cb->ctx, cb);
 release_cb:
 	hl_ctx_put(cb->ctx);
 	cb_do_release(hdev, cb);
@@ -256,7 +401,9 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 			rc = -EINVAL;
 		} else {
 			rc = hl_cb_create(hdev, &hpriv->cb_mgr, hpriv->ctx,
-					args->in.cb_size, false, &handle);
+					args->in.cb_size, false,
+					!!(args->in.flags & HL_CB_FLAGS_MAP),
+					&handle);
 		}
 
 		memset(args, 0, sizeof(*args));
@@ -442,7 +589,7 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 	int rc;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx, cb_size,
-				internal_cb, &cb_handle);
+				internal_cb, false, &cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate CB for the kernel driver %d\n", rc);
@@ -498,3 +645,45 @@ int hl_cb_pool_fini(struct hl_device *hdev)
 
 	return 0;
 }
+
+int hl_cb_va_pool_init(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc;
+
+	if (!hdev->supports_cb_mapping)
+		return 0;
+
+	ctx->cb_va_pool = gen_pool_create(__ffs(prop->pmmu.page_size), -1);
+	if (!ctx->cb_va_pool) {
+		dev_err(hdev->dev,
+			"Failed to create VA gen pool for CB mapping\n");
+		return -ENOMEM;
+	}
+
+	rc = gen_pool_add(ctx->cb_va_pool, prop->cb_va_start_addr,
+			prop->cb_va_end_addr - prop->cb_va_start_addr, -1);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to add memory to VA gen pool for CB mapping\n");
+		goto err_pool_destroy;
+	}
+
+	return 0;
+
+err_pool_destroy:
+	gen_pool_destroy(ctx->cb_va_pool);
+
+	return rc;
+}
+
+void hl_cb_va_pool_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (!hdev->supports_cb_mapping)
+		return;
+
+	gen_pool_destroy(ctx->cb_va_pool);
+}
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index b168a9fce817..df8171a2226c 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -37,6 +37,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		if ((hdev->in_debug) && (hdev->compute_ctx == ctx))
 			hl_device_set_debug_mode(hdev, false);
 
+		hl_cb_va_pool_fini(ctx);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
 	} else {
@@ -155,15 +156,24 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 			goto err_asid_free;
 		}
 
+		rc = hl_cb_va_pool_init(ctx);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to init VA pool for mapped CB\n");
+			goto err_vm_ctx_fini;
+		}
+
 		rc = hdev->asic_funcs->ctx_init(ctx);
 		if (rc) {
 			dev_err(hdev->dev, "ctx_init failed\n");
-			goto err_vm_ctx_fini;
+			goto err_cb_va_pool_fini;
 		}
 	}
 
 	return 0;
 
+err_cb_va_pool_fini:
+	hl_cb_va_pool_fini(ctx);
 err_vm_ctx_fini:
 	hl_vm_ctx_fini(ctx);
 err_asid_free:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 88c68b664ef6..eaa9bf3f82a3 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -291,6 +291,10 @@ struct hl_mmu_properties {
  * @pcie_aux_dbi_reg_addr: Address of the PCIE_AUX DBI register.
  * @mmu_pgt_addr: base physical address in DRAM of MMU page tables.
  * @mmu_dram_default_page_addr: DRAM default page physical address.
+ * @cb_va_start_addr: virtual start address of command buffers which are mapped
+ *                    to the device's MMU.
+ * @cb_va_end_addr: virtual end address of command buffers which are mapped to
+ *                  the device's MMU.
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
  * @mmu_hop_table_size: MMU hop table size.
@@ -339,6 +343,8 @@ struct asic_fixed_properties {
 	u64				pcie_aux_dbi_reg_addr;
 	u64				mmu_pgt_addr;
 	u64				mmu_dram_default_page_addr;
+	u64				cb_va_start_addr;
+	u64				cb_va_end_addr;
 	u32				mmu_pgt_size;
 	u32				mmu_pte_size;
 	u32				mmu_hop_table_size;
@@ -421,6 +427,8 @@ struct hl_cb_mgr {
  * @lock: spinlock to protect mmap/cs flows.
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
+ * @va_block_list: list of virtual addresses blocks of the CB if it is mapped to
+ *                 the device's MMU.
  * @id: the CB's ID.
  * @kernel_address: Holds the CB's kernel virtual address.
  * @bus_address: Holds the CB's DMA address.
@@ -430,6 +438,7 @@ struct hl_cb_mgr {
  * @mmap: true if the CB is currently mmaped to user.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
  * @is_internal: internaly allocated
+ * @is_mmu_mapped: true if the CB is mapped to the device's MMU.
  */
 struct hl_cb {
 	struct kref		refcount;
@@ -438,6 +447,7 @@ struct hl_cb {
 	spinlock_t		lock;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
+	struct list_head	va_block_list;
 	u64			id;
 	u64			kernel_address;
 	dma_addr_t		bus_address;
@@ -447,6 +457,7 @@ struct hl_cb {
 	u8			mmap;
 	u8			is_pool;
 	u8			is_internal;
+	u8			is_mmu_mapped;
 };
 
 
@@ -843,6 +854,8 @@ struct hl_va_range {
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
  *            MMU hash or walking the PGT requires talking this lock.
  * @debugfs_list: node in debugfs list of contexts.
+ * @cb_va_pool: device VA pool for command buffers which are mapped to the
+ *              device's MMU.
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
  *			index to cs_pending array.
@@ -874,6 +887,7 @@ struct hl_ctx {
 	struct mutex		mmu_lock;
 	struct list_head	debugfs_list;
 	struct hl_cs_counters	cs_counters;
+	struct gen_pool		*cb_va_pool;
 	u64			cs_sequence;
 	u64			*dram_default_hops;
 	spinlock_t		cs_lock;
@@ -1574,6 +1588,7 @@ struct hl_mmu_funcs {
  * @sync_stream_queue_idx: helper index for sync stream queues initialization.
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
+ * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1673,6 +1688,7 @@ struct hl_device {
 	u8				sync_stream_queue_idx;
 	u8				supports_coresight;
 	u8				supports_soft_reset;
+	u8				supports_cb_mapping;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
@@ -1840,7 +1856,7 @@ void hl_hwmon_fini(struct hl_device *hdev);
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
-			u64 *handle);
+			bool map_cb, u64 *handle);
 int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
 int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
@@ -1852,6 +1868,8 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 					bool internal_cb);
 int hl_cb_pool_init(struct hl_device *hdev);
 int hl_cb_pool_fini(struct hl_device *hdev);
+int hl_cb_va_pool_init(struct hl_ctx *ctx);
+void hl_cb_va_pool_fini(struct hl_ctx *ctx);
 
 void hl_cs_rollback_all(struct hl_device *hdev);
 struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b51cc6c1d541..6f7f6ad7a358 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4115,7 +4115,7 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 			sizeof(struct packet_msg_prot) * 2;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
-				parser->patched_cb_size, false,
+				parser->patched_cb_size, false, false,
 				&patched_cb_handle);
 
 	if (rc) {
@@ -4189,7 +4189,7 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 		goto free_userptr;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
-				parser->patched_cb_size, false,
+				parser->patched_cb_size, false, false,
 				&patched_cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6c81a4b148de..5cddd46a8fb8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3811,7 +3811,7 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 			sizeof(struct packet_msg_prot) * 2;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
-				parser->patched_cb_size, false,
+				parser->patched_cb_size, false, false,
 				&patched_cb_handle);
 
 	if (rc) {
@@ -3885,7 +3885,7 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 		goto free_userptr;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
-				parser->patched_cb_size, false,
+				parser->patched_cb_size, false, false,
 				&patched_cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index d449f8a31ce6..9705b8adb60c 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -462,6 +462,9 @@ struct hl_info_args {
 /* 2MB minus 32 bytes for 2xMSG_PROT */
 #define HL_MAX_CB_SIZE		(0x200000 - 32)
 
+/* Indicates whether the command buffer should be mapped to the device's MMU */
+#define HL_CB_FLAGS_MAP		0x1
+
 struct hl_cb_in {
 	/* Handle of CB or 0 if we want to create one */
 	__u64 cb_handle;
@@ -473,7 +476,8 @@ struct hl_cb_in {
 	__u32 cb_size;
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
-	__u32 pad;
+	/* HL_CB_FLAGS_* */
+	__u32 flags;
 };
 
 struct hl_cb_out {
@@ -856,6 +860,12 @@ struct hl_debug_args {
  * When creating a new CB, the IOCTL returns a handle of it, and the user-space
  * process needs to use that handle to mmap the buffer so it can access them.
  *
+ * In some instances, the device must access the command buffer through the
+ * device's MMU, and thus its memory should be mapped. In these cases, user can
+ * indicate the driver that such a mapping is required.
+ * The resulting device virtual address will be used internally by the driver,
+ * and won't be returned to user.
+ *
  */
 #define HL_IOCTL_CB		\
 		_IOWR('H', 0x02, union hl_cb_args)
-- 
2.17.1

