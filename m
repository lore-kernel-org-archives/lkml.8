Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9BEC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13EB206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AckcgKfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGPHbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGPHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:31:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:31:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so5968969wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/i9PCKOCxOxu4SRcOi7vK0YyNCDzghOeDeevWUIH7To=;
        b=AckcgKfMYbGwj8QC6ufyR/SK4kB50ZZ9JhrPHhPEORrSv+SPnhFN51TVAHzEeG7mkT
         h93Jk9nE9+Hf2cNhaELGV3lmkol16bU3jjRGG7s/SfNI1d7g0ADXSPoKY433qsJ31b3h
         T2v9jwJWruNo6QL48n40prtCEBAgmotwyE/l1z/5IUa6OS2lXm5RHF/omkzpYP5KbIHt
         oCStWDAGFOuO/pU8pjozuoKnRGRfja35xZNuH4DTuWVx5Vf61gK+SuCNbXJ4aKXcwniV
         wUZg1HOkrx7y0lp2gfwJ6+NtykRj/muN+H7qBtwVLyr4grC7kcxO0M/ZMn8ba2tdSQ5X
         dSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/i9PCKOCxOxu4SRcOi7vK0YyNCDzghOeDeevWUIH7To=;
        b=HyofoWaz2tdsAtH5NGQWSF56NAp166bUOlQVGouCQSYmYJBm/En/h7rsHA12CZxaIq
         PrNDHQVkWzNdldnlnQQqiYHGi931wqtcU4ep3tjSWbsz12Gu6ktQlMgod0ImDWi60RnD
         nm5sik0c7ZGRqsnlcVC4Eqrgfysy1lSfhVsQjorIVZDPm4/pqtQgiKzGyISb8PEhZocz
         GHJYguhFM1/XvHhJhJh56q80wgkqtwgEnOzwSSMea71GefmmsG2zZs6GgDUpOE0sJ9xc
         8MwBiQi52rbK88ZcEGYYyeumDw9N1a/dwIRsrkhAFE8ZjurrBsqWF4v/ECssN2OrMqDY
         rhAw==
X-Gm-Message-State: AOAM531lbPnRY61V2XyPYQOM/OjRwN16VgD7AqRFMOr14HGK3p9X7rO2
        nWo/vtBjuZQnRhuxBh3IOKpEPbZC
X-Google-Smtp-Source: ABdhPJyBAezeRjdMwjMpH0E1kDpuPiTvJxFoN1LI4/xogUNLQOUQYAycDBZho9utImqpq6rbxzUCMQ==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3793195wrq.104.1594884693956;
        Thu, 16 Jul 2020 00:31:33 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a2sm7352017wrn.68.2020.07.16.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:31:33 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: create internal CB pool
Date:   Thu, 16 Jul 2020 10:31:28 +0300
Message-Id: <20200716073129.5924-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Create a device MMU-mapped internal command buffer pool, in order to allow
the driver to allocate CBs for the signal/wait operations
that are fetched by the queues when they are configured with the user's
address space ID.

We must pre-map this internal pool due to performance issues.

This pool is needed for future ASIC support and it is currently unused in
GOYA and GAUDI.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/common/command_buffer.c   | 82 ++++++++++++-------
 .../habanalabs/common/command_submission.c    | 13 +--
 drivers/misc/habanalabs/common/context.c      |  8 ++
 drivers/misc/habanalabs/common/habanalabs.h   | 18 +++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 20 +++--
 drivers/misc/habanalabs/goya/goya.c           | 18 ++--
 6 files changed, 106 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 02d13f71b1df..7c38c4f7f9c0 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -10,12 +10,18 @@
 
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/genalloc.h>
 
 static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 {
-	hdev->asic_funcs->asic_dma_free_coherent(hdev, cb->size,
-			(void *) (uintptr_t) cb->kernel_address,
-			cb->bus_address);
+	if (cb->is_internal)
+		gen_pool_free(hdev->internal_cb_pool,
+				cb->kernel_address, cb->size);
+	else
+		hdev->asic_funcs->asic_dma_free_coherent(hdev, cb->size,
+				(void *) (uintptr_t) cb->kernel_address,
+				cb->bus_address);
+
 	kfree(cb);
 }
 
@@ -44,9 +50,10 @@ static void cb_release(struct kref *ref)
 }
 
 static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
-					int ctx_id)
+					int ctx_id, bool internal_cb)
 {
 	struct hl_cb *cb;
+	u32 cb_offset;
 	void *p;
 
 	/*
@@ -65,13 +72,25 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 	if (!cb)
 		return NULL;
 
-	if (ctx_id == HL_KERNEL_ASID_ID)
+	if (internal_cb) {
+		p = (void *) gen_pool_alloc(hdev->internal_cb_pool, cb_size);
+		if (!p) {
+			kfree(cb);
+			return NULL;
+		}
+
+		cb_offset = p - hdev->internal_cb_pool_virt_addr;
+		cb->is_internal = true;
+		cb->bus_address =  hdev->internal_cb_va_base + cb_offset;
+	} else if (ctx_id == HL_KERNEL_ASID_ID) {
 		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address, GFP_ATOMIC);
-	else
+	} else {
 		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
 						&cb->bus_address,
 						GFP_USER | __GFP_ZERO);
+	}
+
 	if (!p) {
 		dev_err(hdev->dev,
 			"failed to allocate %d of dma memory for CB\n",
@@ -87,7 +106,7 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 }
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			u32 cb_size, u64 *handle, int ctx_id)
+			u32 cb_size, u64 *handle, int ctx_id, bool internal_cb)
 {
 	struct hl_cb *cb;
 	bool alloc_new_cb = true;
@@ -112,28 +131,30 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 		goto out_err;
 	}
 
-	/* Minimum allocation must be PAGE SIZE */
-	if (cb_size < PAGE_SIZE)
-		cb_size = PAGE_SIZE;
-
-	if (ctx_id == HL_KERNEL_ASID_ID &&
-			cb_size <= hdev->asic_prop.cb_pool_cb_size) {
-
-		spin_lock(&hdev->cb_pool_lock);
-		if (!list_empty(&hdev->cb_pool)) {
-			cb = list_first_entry(&hdev->cb_pool, typeof(*cb),
-					pool_list);
-			list_del(&cb->pool_list);
-			spin_unlock(&hdev->cb_pool_lock);
-			alloc_new_cb = false;
-		} else {
-			spin_unlock(&hdev->cb_pool_lock);
-			dev_dbg(hdev->dev, "CB pool is empty\n");
+	if (!internal_cb) {
+		/* Minimum allocation must be PAGE SIZE */
+		if (cb_size < PAGE_SIZE)
+			cb_size = PAGE_SIZE;
+
+		if (ctx_id == HL_KERNEL_ASID_ID &&
+				cb_size <= hdev->asic_prop.cb_pool_cb_size) {
+
+			spin_lock(&hdev->cb_pool_lock);
+			if (!list_empty(&hdev->cb_pool)) {
+				cb = list_first_entry(&hdev->cb_pool,
+						typeof(*cb), pool_list);
+				list_del(&cb->pool_list);
+				spin_unlock(&hdev->cb_pool_lock);
+				alloc_new_cb = false;
+			} else {
+				spin_unlock(&hdev->cb_pool_lock);
+				dev_dbg(hdev->dev, "CB pool is empty\n");
+			}
 		}
 	}
 
 	if (alloc_new_cb) {
-		cb = hl_cb_alloc(hdev, cb_size, ctx_id);
+		cb = hl_cb_alloc(hdev, cb_size, ctx_id, internal_cb);
 		if (!cb) {
 			rc = -ENOMEM;
 			goto out_err;
@@ -229,8 +250,8 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 			rc = -EINVAL;
 		} else {
 			rc = hl_cb_create(hdev, &hpriv->cb_mgr,
-						args->in.cb_size, &handle,
-						hpriv->ctx->asid);
+					args->in.cb_size, &handle,
+					hpriv->ctx->asid, false);
 		}
 
 		memset(args, 0, sizeof(*args));
@@ -398,14 +419,15 @@ void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr)
 	idr_destroy(&mgr->cb_handles);
 }
 
-struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size)
+struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
+					bool internal_cb)
 {
 	u64 cb_handle;
 	struct hl_cb *cb;
 	int rc;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, cb_size, &cb_handle,
-			HL_KERNEL_ASID_ID);
+			HL_KERNEL_ASID_ID, internal_cb);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate CB for the kernel driver %d\n", rc);
@@ -437,7 +459,7 @@ int hl_cb_pool_init(struct hl_device *hdev)
 
 	for (i = 0 ; i < hdev->asic_prop.cb_pool_cb_cnt ; i++) {
 		cb = hl_cb_alloc(hdev, hdev->asic_prop.cb_pool_cb_size,
-				HL_KERNEL_ASID_ID);
+				HL_KERNEL_ASID_ID, false);
 		if (cb) {
 			cb->is_pool = true;
 			list_add(&cb->pool_list, &hdev->cb_pool);
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 54f2f5afdd2a..272d79256ed2 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -911,7 +911,13 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto put_cs;
 	}
 
-	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	if (cs->type == CS_TYPE_WAIT)
+		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
+	else
+		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
+
+	cb = hl_cb_kernel_create(hdev, cb_size,
+				q_type == QUEUE_TYPE_HW && hdev->mmu_enable);
 	if (!cb) {
 		ctx->cs_counters.out_of_mem_drop_cnt++;
 		kfree(job);
@@ -919,11 +925,6 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto put_cs;
 	}
 
-	if (cs->type == CS_TYPE_WAIT)
-		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
-	else
-		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
-
 	job->id = 0;
 	job->cs = cs;
 	job->user_cb = cb;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 1e3e5b19ecd9..b75a20364fad 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -153,10 +153,18 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 			rc = -ENOMEM;
 			goto mem_ctx_err;
 		}
+
+		rc = hdev->asic_funcs->ctx_init(ctx);
+		if (rc) {
+			dev_err(hdev->dev, "ctx_init failed\n");
+			goto ctx_init_err;
+		}
 	}
 
 	return 0;
 
+ctx_init_err:
+	hl_vm_ctx_fini(ctx);
 mem_ctx_err:
 	if (ctx->asid != HL_KERNEL_ASID_ID)
 		hl_asid_free(hdev, ctx->asid);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 82532f1f94cb..bf9abfa47b7a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -392,6 +392,7 @@ struct hl_cb_mgr {
  * @ctx_id: holds the ID of the owner's context.
  * @mmap: true if the CB is currently mmaped to user.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
+ * @is_internal: internaly allocated
  */
 struct hl_cb {
 	struct kref		refcount;
@@ -408,6 +409,7 @@ struct hl_cb {
 	u32			ctx_id;
 	u8			mmap;
 	u8			is_pool;
+	u8			is_internal;
 };
 
 
@@ -643,6 +645,7 @@ enum div_select_defs {
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
  * @halt_coresight: stop the ETF and ETR traces.
+ * @ctx_init: context dependent initialization.
  * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
  * @read_device_fw_version: read the device's firmware versions that are
@@ -745,6 +748,7 @@ struct hl_asic_funcs {
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 	void (*halt_coresight)(struct hl_device *hdev);
+	int (*ctx_init)(struct hl_ctx *ctx);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
 	void (*read_device_fw_version)(struct hl_device *hdev,
@@ -1432,6 +1436,10 @@ struct hl_device_idle_busy_ts {
  * @hl_debugfs: device's debugfs manager.
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
+ * @internal_cb_pool_virt_addr: internal command buffer pool virtual address.
+ * @internal_cb_pool_dma_addr: internal command buffer pool dma address.
+ * @internal_cb_pool: internal command buffer memory pool.
+ * @internal_cb_va_base: internal cb pool mmu virtual address base
  * @fpriv_list: list of file private data structures. Each structure is created
  *              when a user opens the device
  * @fpriv_list_lock: protects the fpriv_list
@@ -1531,6 +1539,11 @@ struct hl_device {
 	struct list_head		cb_pool;
 	spinlock_t			cb_pool_lock;
 
+	void				*internal_cb_pool_virt_addr;
+	dma_addr_t			internal_cb_pool_dma_addr;
+	struct gen_pool			*internal_cb_pool;
+	u64				internal_cb_va_base;
+
 	struct list_head		fpriv_list;
 	struct mutex			fpriv_list_lock;
 
@@ -1741,7 +1754,7 @@ int hl_hwmon_init(struct hl_device *hdev);
 void hl_hwmon_fini(struct hl_device *hdev);
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr, u32 cb_size,
-		u64 *handle, int ctx_id);
+		u64 *handle, int ctx_id, bool internal_cb);
 int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
 int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
@@ -1749,7 +1762,8 @@ struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
 void hl_cb_put(struct hl_cb *cb);
 void hl_cb_mgr_init(struct hl_cb_mgr *mgr);
 void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr);
-struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size);
+struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
+					bool internal_cb);
 int hl_cb_pool_init(struct hl_device *hdev);
 int hl_cb_pool_fini(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 57b2b9392cb2..86cfaf73ad74 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -635,7 +635,7 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 	u8 tpc_id;
 	int rc;
 
-	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	cb = hl_cb_kernel_create(hdev, PAGE_SIZE, false);
 	if (!cb)
 		return -EFAULT;
 
@@ -4048,9 +4048,8 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	parser->patched_cb_size = parser->user_cb_size +
 			sizeof(struct packet_msg_prot) * 2;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
-				parser->patched_cb_size,
-				&patched_cb_handle, HL_KERNEL_ASID_ID);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
+			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -4122,9 +4121,8 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
-				parser->patched_cb_size,
-				&patched_cb_handle, HL_KERNEL_ASID_ID);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
+			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
@@ -4257,7 +4255,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	struct hl_cb *cb;
 	int rc;
 
-	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	cb = hl_cb_kernel_create(hdev, PAGE_SIZE, false);
 	if (!cb)
 		return -EFAULT;
 
@@ -6229,6 +6227,11 @@ static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
+int gaudi_ctx_init(struct hl_ctx *ctx)
+{
+	return 0;
+}
+
 static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return gaudi_cq_assignment[cq_idx];
@@ -6532,6 +6535,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
 	.halt_coresight = gaudi_halt_coresight,
+	.ctx_init = gaudi_ctx_init,
 	.get_clk_rate = gaudi_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.read_device_fw_version = gaudi_read_device_fw_version,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2b0937d950c1..4473ded313d6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3771,9 +3771,8 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	parser->patched_cb_size = parser->user_cb_size +
 			sizeof(struct packet_msg_prot) * 2;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
-				parser->patched_cb_size,
-				&patched_cb_handle, HL_KERNEL_ASID_ID);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
+			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -3845,9 +3844,8 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
-				parser->patched_cb_size,
-				&patched_cb_handle, HL_KERNEL_ASID_ID);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
+			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
@@ -4693,7 +4691,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 	lin_dma_pkts_cnt = DIV_ROUND_UP_ULL(size, SZ_2G);
 	cb_size = lin_dma_pkts_cnt * sizeof(struct packet_lin_dma) +
 						sizeof(struct packet_msg_prot);
-	cb = hl_cb_kernel_create(hdev, cb_size);
+	cb = hl_cb_kernel_create(hdev, cb_size, false);
 	if (!cb)
 		return -ENOMEM;
 
@@ -5223,6 +5221,11 @@ static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
+int goya_ctx_init(struct hl_ctx *ctx)
+{
+	return 0;
+}
+
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return cq_idx;
@@ -5336,6 +5339,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
 	.halt_coresight = goya_halt_coresight,
+	.ctx_init = goya_ctx_init,
 	.get_clk_rate = goya_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.read_device_fw_version = goya_read_device_fw_version,
-- 
2.17.1

