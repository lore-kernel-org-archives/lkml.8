Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E06C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6282075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCP3wNir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgGMOsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:48:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B819C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so13442336wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R/8Qelj6m7vOdQpSWp43AvBP89kKHuzDIkWd6anDbIQ=;
        b=aCP3wNirvHv6Ts1PPRFSu4QlP74VRSMFCIFKXNSEJSJu3EvnR7/6PHTdVy1OWIQdk0
         tVlkKwPY5vlqm2fvLKGsDedVS5MbHaWzisoJXF06aeDZL4Dsy6bXRGWJaMHpeBX9n4kD
         2KqK/viBE6/K4dBULJtRz9306BKzTTrxy/+y3cYlVxxywCn6SLTxKtywL58+Z6gMB1sS
         0gOaWc9HI5mLMteBboo9ZgCdCxRSM+90PCjhG91qWTsOy0LxP1MA3l6+G0dirP8lVDOk
         GAhCaxzDBtCufFEF00scKfG5Ok0PoI0M8zsXSGSHX4iWalS5GUwy8j18w8ega4SHp1Uw
         UNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R/8Qelj6m7vOdQpSWp43AvBP89kKHuzDIkWd6anDbIQ=;
        b=o13OFt8FCihZFeIJKWWl/6ma3cjVw72/kIbnrgTkL/EfFcKCEV0S+5hB4YRm0O64iS
         KTnyEiPNFzplyCcKGNnt/zN+UZ/7UKE7SDZYCtGclQvHAbXHOPk/Y3EYo3/mXJuir70D
         dqa2NCCwGI9NAYTHfxDGVCVvVXK2Iq+kVJZPxTvQn5LdtAYcxmKpbGWL3GHt5PwMCHzT
         YJfuD1s0Hvg4W1OoW+nut1Qor6/jibSiN9KIN2Q/l6weh5JTSea7op0Pu3g309oKiZy+
         4A2YIr4ys37I1TbOKgiMZ8wlYQzH38fc4e0uzQqALKwKQZ5wrPe/Nlz+8fMrDdi+OwWy
         rtQA==
X-Gm-Message-State: AOAM5322a0dINZcUeE0xQXA7qg3E3MwZhw0DOhjVS5n+tFUzPK5Oaw0f
        OmGiu7KdlssNfHE1tQw23KQ6zFjU
X-Google-Smtp-Source: ABdhPJwVLhUeJGLEqWnqNoAKIVfKxacl2POYGahwcjH+RLSHPy5kXHx0USmRjMBP+MbF4X8rXTtuYA==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr271193wmk.149.1594651688216;
        Mon, 13 Jul 2020 07:48:08 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id u17sm23369080wrp.70.2020.07.13.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:48:07 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Date:   Mon, 13 Jul 2020 18:54:22 +0300
Message-Id: <20200713155424.24721-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Instead of using standard dma-fence mechanism designed for GPU's, we
introduce our own implementation based on the former one. This
implementation is much more sparse than the original, contains only
mandatory functionality required by the driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Makefile             |   2 +-
 drivers/misc/habanalabs/command_submission.c | 120 ++-----
 drivers/misc/habanalabs/context.c            |  10 +-
 drivers/misc/habanalabs/habanalabs.h         |  12 +-
 drivers/misc/habanalabs/hl_dma_fence.c       | 338 +++++++++++++++++++
 drivers/misc/habanalabs/hl_dma_fence.h       | 148 ++++++++
 drivers/misc/habanalabs/hw_queue.c           |   2 +-
 7 files changed, 519 insertions(+), 113 deletions(-)
 create mode 100644 drivers/misc/habanalabs/hl_dma_fence.c
 create mode 100644 drivers/misc/habanalabs/hl_dma_fence.h

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 421ebd903069..83b0e9ac35d6 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -7,7 +7,7 @@ obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
 		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
-		command_submission.o mmu.o firmware_if.o pci.o
+		command_submission.o mmu.o firmware_if.o pci.o hl_dma_fence.o
 
 habanalabs-$(CONFIG_DEBUG_FS) += debugfs.o
 
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 54f2f5afdd2a..a3d9223424c6 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -18,15 +18,6 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
 static void cs_do_release(struct kref *ref);
 
-static void hl_sob_reset(struct kref *ref)
-{
-	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
-							kref);
-	struct hl_device *hdev = hw_sob->hdev;
-
-	hdev->asic_funcs->reset_sob(hdev, hw_sob);
-}
-
 void hl_sob_reset_error(struct kref *ref)
 {
 	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
@@ -38,77 +29,6 @@ void hl_sob_reset_error(struct kref *ref)
 			hw_sob->q_idx, hw_sob->sob_id);
 }
 
-static const char *hl_fence_get_driver_name(struct dma_fence *fence)
-{
-	return "HabanaLabs";
-}
-
-static const char *hl_fence_get_timeline_name(struct dma_fence *fence)
-{
-	struct hl_cs_compl *hl_cs_compl =
-		container_of(fence, struct hl_cs_compl, base_fence);
-
-	return dev_name(hl_cs_compl->hdev->dev);
-}
-
-static bool hl_fence_enable_signaling(struct dma_fence *fence)
-{
-	return true;
-}
-
-static void hl_fence_release(struct dma_fence *fence)
-{
-	struct hl_cs_compl *hl_cs_cmpl =
-		container_of(fence, struct hl_cs_compl, base_fence);
-	struct hl_device *hdev = hl_cs_cmpl->hdev;
-
-	/* EBUSY means the CS was never submitted and hence we don't have
-	 * an attached hw_sob object that we should handle here
-	 */
-	if (fence->error == -EBUSY)
-		goto free;
-
-	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
-			(hl_cs_cmpl->type == CS_TYPE_WAIT)) {
-
-		dev_dbg(hdev->dev,
-			"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
-			hl_cs_cmpl->cs_seq,
-			hl_cs_cmpl->type,
-			hl_cs_cmpl->hw_sob->sob_id,
-			hl_cs_cmpl->sob_val);
-
-		/*
-		 * A signal CS can get completion while the corresponding wait
-		 * for signal CS is on its way to the PQ. The wait for signal CS
-		 * will get stuck if the signal CS incremented the SOB to its
-		 * max value and there are no pending (submitted) waits on this
-		 * SOB.
-		 * We do the following to void this situation:
-		 * 1. The wait for signal CS must get a ref for the signal CS as
-		 *    soon as possible in cs_ioctl_signal_wait() and put it
-		 *    before being submitted to the PQ but after it incremented
-		 *    the SOB refcnt in init_signal_wait_cs().
-		 * 2. Signal/Wait for signal CS will decrement the SOB refcnt
-		 *    here.
-		 * These two measures guarantee that the wait for signal CS will
-		 * reset the SOB upon completion rather than the signal CS and
-		 * hence the above scenario is avoided.
-		 */
-		kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
-	}
-
-free:
-	kfree_rcu(hl_cs_cmpl, base_fence.rcu);
-}
-
-static const struct dma_fence_ops hl_fence_ops = {
-	.get_driver_name = hl_fence_get_driver_name,
-	.get_timeline_name = hl_fence_get_timeline_name,
-	.enable_signaling = hl_fence_enable_signaling,
-	.release = hl_fence_release
-};
-
 static void cs_get(struct hl_cs *cs)
 {
 	kref_get(&cs->refcount);
@@ -336,7 +256,7 @@ static void cs_do_release(struct kref *ref)
 		 * In case the wait for signal CS was submitted, the put occurs
 		 * in init_signal_wait_cs() right before hanging on the PQ.
 		 */
-		dma_fence_put(cs->signal_fence);
+		hl_dma_fence_put(cs->signal_fence);
 	}
 
 	/*
@@ -352,14 +272,14 @@ static void cs_do_release(struct kref *ref)
 	 * to handle hw_sob for signal/wait
 	 */
 	if (cs->timedout)
-		dma_fence_set_error(cs->fence, -ETIMEDOUT);
+		hl_dma_fence_set_error(cs->fence, -ETIMEDOUT);
 	else if (cs->aborted)
-		dma_fence_set_error(cs->fence, -EIO);
+		hl_dma_fence_set_error(cs->fence, -EIO);
 	else if (!cs->submitted)
-		dma_fence_set_error(cs->fence, -EBUSY);
+		hl_dma_fence_set_error(cs->fence, -EBUSY);
 
-	dma_fence_signal(cs->fence);
-	dma_fence_put(cs->fence);
+	hl_dma_fence_signal(cs->fence);
+	hl_dma_fence_put(cs->fence);
 
 	cs_counters_aggregate(hdev, cs->ctx);
 
@@ -402,7 +322,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 			enum hl_cs_type cs_type, struct hl_cs **cs_new)
 {
 	struct hl_cs_compl *cs_cmpl;
-	struct dma_fence *other = NULL;
+	struct hl_dma_fence *other = NULL;
 	struct hl_cs *cs;
 	int rc;
 
@@ -435,7 +355,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs_cmpl->cs_seq = ctx->cs_sequence;
 	other = ctx->cs_pending[cs_cmpl->cs_seq &
 				(hdev->asic_prop.max_pending_cs - 1)];
-	if ((other) && (!dma_fence_is_signaled(other))) {
+
+	if ((other) && (!hl_dma_fence_is_signaled(other))) {
 		dev_dbg(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
 		rc = -EAGAIN;
@@ -449,8 +370,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_fence;
 	}
 
-	dma_fence_init(&cs_cmpl->base_fence, &hl_fence_ops, &cs_cmpl->lock,
-			ctx->asid, ctx->cs_sequence);
+	hl_dma_fence_init(&cs_cmpl->base_fence, &cs_cmpl->lock);
 
 	cs->sequence = cs_cmpl->cs_seq;
 
@@ -459,9 +379,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 							&cs_cmpl->base_fence;
 	ctx->cs_sequence++;
 
-	dma_fence_get(&cs_cmpl->base_fence);
+	hl_dma_fence_get(&cs_cmpl->base_fence);
 
-	dma_fence_put(other);
+	hl_dma_fence_put(other);
 
 	spin_unlock(&ctx->cs_lock);
 
@@ -766,7 +686,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
-	struct dma_fence *sig_fence = NULL;
+	struct hl_dma_fence *sig_fence = NULL;
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
@@ -868,14 +788,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			dev_err(hdev->dev,
 				"CS seq 0x%llx is not of a signal CS\n",
 				signal_seq);
-			dma_fence_put(sig_fence);
+			hl_dma_fence_put(sig_fence);
 			rc = -EINVAL;
 			goto free_signal_seq_array;
 		}
 
-		if (dma_fence_is_signaled(sig_fence)) {
+		if (hl_dma_fence_is_signaled(sig_fence)) {
 			/* signal CS already finished */
-			dma_fence_put(sig_fence);
+			hl_dma_fence_put(sig_fence);
 			rc = 0;
 			goto free_signal_seq_array;
 		}
@@ -887,7 +807,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	rc = allocate_cs(hdev, ctx, cs_type, &cs);
 	if (rc) {
 		if (cs_type == CS_TYPE_WAIT)
-			dma_fence_put(sig_fence);
+			hl_dma_fence_put(sig_fence);
 		hl_ctx_put(ctx);
 		goto free_signal_seq_array;
 	}
@@ -1146,7 +1066,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq)
 {
-	struct dma_fence *fence;
+	struct hl_dma_fence *fence;
 	unsigned long timeout;
 	long rc;
 
@@ -1165,12 +1085,12 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 				"Can't wait on CS %llu because current CS is at seq %llu\n",
 				seq, ctx->cs_sequence);
 	} else if (fence) {
-		rc = dma_fence_wait_timeout(fence, true, timeout);
+		rc = hl_dma_fence_wait(fence, true, timeout);
 		if (fence->error == -ETIMEDOUT)
 			rc = -ETIMEDOUT;
 		else if (fence->error == -EIO)
 			rc = -EIO;
-		dma_fence_put(fence);
+		hl_dma_fence_put(fence);
 	} else {
 		dev_dbg(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 1e3e5b19ecd9..fd1d4ea2854d 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -23,7 +23,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 	 */
 
 	for (i = 0 ; i < hdev->asic_prop.max_pending_cs ; i++)
-		dma_fence_put(ctx->cs_pending[i]);
+		hl_dma_fence_put(ctx->cs_pending[i]);
 
 	kfree(ctx->cs_pending);
 
@@ -128,7 +128,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	atomic_set(&ctx->thread_ctx_switch_token, 1);
 	ctx->thread_ctx_switch_wait_token = 0;
 	ctx->cs_pending = kcalloc(hdev->asic_prop.max_pending_cs,
-				sizeof(struct dma_fence *),
+				sizeof(struct hl_dma_fence *),
 				GFP_KERNEL);
 	if (!ctx->cs_pending)
 		return -ENOMEM;
@@ -174,10 +174,10 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
-struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
+struct hl_dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 {
 	struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
-	struct dma_fence *fence;
+	struct hl_dma_fence *fence;
 
 	spin_lock(&ctx->cs_lock);
 
@@ -191,7 +191,7 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 		return NULL;
 	}
 
-	fence = dma_fence_get(
+	fence = hl_dma_fence_get(
 			ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)]);
 	spin_unlock(&ctx->cs_lock);
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 14def0d26d2d..3f9270ace869 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -15,10 +15,10 @@
 #include <linux/cdev.h>
 #include <linux/iopoll.h>
 #include <linux/irqreturn.h>
-#include <linux/dma-fence.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
+#include "hl_dma_fence.h"
 
 #define HL_NAME				"habanalabs"
 
@@ -353,7 +353,7 @@ struct asic_fixed_properties {
  * @sob_val: the SOB value that is used in this signal/wait CS.
  */
 struct hl_cs_compl {
-	struct dma_fence	base_fence;
+	struct hl_dma_fence	base_fence;
 	spinlock_t		lock;
 	struct hl_device	*hdev;
 	struct hl_hw_sob	*hw_sob;
@@ -823,7 +823,7 @@ struct hl_ctx {
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
 	struct kref		refcount;
-	struct dma_fence	**cs_pending;
+	struct hl_dma_fence	**cs_pending;
 	struct hl_va_range	*host_va_range;
 	struct hl_va_range	*host_huge_va_range;
 	struct hl_va_range	*dram_va_range;
@@ -910,8 +910,8 @@ struct hl_cs {
 	struct list_head	job_list;
 	spinlock_t		job_lock;
 	struct kref		refcount;
-	struct dma_fence	*fence;
-	struct dma_fence	*signal_fence;
+	struct hl_dma_fence	*fence;
+	struct hl_dma_fence	*signal_fence;
 	struct work_struct	finish_work;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
@@ -1716,7 +1716,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
 void hl_ctx_do_release(struct kref *ref);
 void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
-struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
+struct hl_dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
 
diff --git a/drivers/misc/habanalabs/hl_dma_fence.c b/drivers/misc/habanalabs/hl_dma_fence.c
new file mode 100644
index 000000000000..18968d7a0193
--- /dev/null
+++ b/drivers/misc/habanalabs/hl_dma_fence.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fence mechanism for dma-buf and to allow for asynchronous dma access
+ *
+ * Copyright (C) 2012 Canonical Ltd
+ * Copyright (C) 2012 Texas Instruments
+ *
+ * Authors:
+ * Rob Clark <robdclark@gmail.com>
+ * Maarten Lankhorst <maarten.lankhorst@canonical.com>
+ *
+ * The dma_fence module is a copy of dma-fence at drivers/dma-buf.
+ * This was done due to an explicit request by GPU developers who asked not
+ * to use the dma-buf module because we aren't part of DRM subsystem.
+ * This copy was stripped from all extra features that habanalabs driver
+ * doesn't use, including the uapi interface dma-buf exposes.
+ * In addition, we removed the callbacks because the only usage is from inside
+ * habanalabs driver
+ */
+
+#include "hl_dma_fence.h"
+#include "habanalabs.h"
+#include <linux/slab.h>
+#include <linux/export.h>
+#include <linux/atomic.h>
+#include <linux/sched/signal.h>
+
+/**
+ * DOC: DMA fences overview
+ *
+ * DMA fences, represented by &struct hl_dma_fence, are the kernel internal
+ * synchronization primitive for DMA operations like GPU rendering, video
+ * encoding/decoding, or displaying buffers on a screen.
+ *
+ * A fence is initialized using hl_dma_fence_init() and completed using
+ * hl_dma_fence_signal().
+ *
+ */
+
+static inline const char *hl_fence_get_timeline_name(struct hl_dma_fence *fence)
+{
+	struct hl_cs_compl *hl_cs_compl =
+		container_of(fence, struct hl_cs_compl, base_fence);
+
+	return dev_name(hl_cs_compl->hdev->dev);
+}
+
+static void hl_sob_reset(struct kref *ref)
+{
+	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
+							kref);
+	struct hl_device *hdev = hw_sob->hdev;
+
+	hdev->asic_funcs->reset_sob(hdev, hw_sob);
+}
+
+static void hl_fence_release(struct hl_dma_fence *fence)
+{
+	struct hl_cs_compl *hl_cs_cmpl =
+		container_of(fence, struct hl_cs_compl, base_fence);
+	struct hl_device *hdev = hl_cs_cmpl->hdev;
+
+	/* EBUSY means the CS was never submitted and hence we don't have
+	 * an attached hw_sob object that we should handle here
+	 */
+	if (fence->error == -EBUSY)
+		goto free;
+
+	if ((hl_cs_cmpl->type == CS_TYPE_SIGNAL) ||
+			(hl_cs_cmpl->type == CS_TYPE_WAIT)) {
+
+		dev_dbg(hdev->dev,
+			"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
+			hl_cs_cmpl->cs_seq,
+			hl_cs_cmpl->type,
+			hl_cs_cmpl->hw_sob->sob_id,
+			hl_cs_cmpl->sob_val);
+
+		/*
+		 * A signal CS can get completion while the corresponding wait
+		 * for signal CS is on its way to the PQ. The wait for signal CS
+		 * will get stuck if the signal CS incremented the SOB to its
+		 * max value and there are no pending (submitted) waits on this
+		 * SOB.
+		 * We do the following to void this situation:
+		 * 1. The wait for signal CS must get a ref for the signal CS as
+		 *    soon as possible in cs_ioctl_signal_wait() and put it
+		 *    before being submitted to the PQ but after it incremented
+		 *    the SOB refcnt in init_signal_wait_cs().
+		 * 2. Signal/Wait for signal CS will decrement the SOB refcnt
+		 *    here.
+		 * These two measures guarantee that the wait for signal CS will
+		 * reset the SOB upon completion rather than the signal CS and
+		 * hence the above scenario is avoided.
+		 */
+		kref_put(&hl_cs_cmpl->hw_sob->kref, hl_sob_reset);
+	}
+
+free:
+	kfree_rcu(hl_cs_cmpl, base_fence.rcu);
+}
+
+struct wait_task {
+	struct list_head node;
+	struct task_struct *task;
+};
+
+/**
+ * hl_dma_fence_signal_locked - signal completion of a fence
+ * @fence: the fence to signal
+ *
+ * Signal completion for software callbacks on a fence, this will unblock
+ * hl_dma_fence_wait() calls and run all the callbacks added with
+ * hl_dma_fence_add_callback(). Can be called multiple times, but since a fence
+ * can only go from the unsignaled to the signaled state and not back, it will
+ * only be effective the first time.
+ *
+ * Unlike hl_dma_fence_signal(), this function must be called with
+ * &dma_fence.lock held.
+ *
+ * Returns 0 on success and a negative error value when @fence has been
+ * signalled already.
+ */
+static int hl_dma_fence_signal_locked(struct hl_dma_fence *fence)
+{
+	struct wait_task *cur, *tmp;
+	int ret = 0;
+
+	lockdep_assert_held(fence->lock);
+
+	if (WARN_ON(!fence))
+		return -EINVAL;
+
+	if (test_and_set_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)) {
+		ret = -EINVAL;
+
+		/*
+		 * we might have raced with the unlocked hl_dma_fence_signal,
+		 * still run through all callbacks
+		 */
+	} else {
+		set_bit(HL_DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
+	}
+
+	list_for_each_entry_safe(cur, tmp, &fence->wait_list, node) {
+		list_del_init(&cur->node);
+		wake_up_process(cur->task);
+	}
+	return ret;
+}
+
+/**
+ * hl_dma_fence_signal - signal completion of a fence
+ * @fence: the fence to signall
+ *
+ * Signal completion on a fence, this will unblock
+ * hl_dma_fence_wait() calls. Can be called multiple times, but since a fence
+ * can only go from the unsignaled to the signaled state and not back, it will
+ * only be effective the first time.
+ *
+ * Returns 0 on success and a negative error value when @fence has been
+ * signaled already.
+ */
+int hl_dma_fence_signal(struct hl_dma_fence *fence)
+{
+	unsigned long flags;
+
+	if (!fence)
+		return -EINVAL;
+
+	if (test_and_set_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
+		return -EINVAL;
+
+	set_bit(HL_DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
+
+	if (test_bit(HL_DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &fence->flags)) {
+		struct wait_task *cur, *tmp;
+
+		spin_lock_irqsave(fence->lock, flags);
+		list_for_each_entry_safe(cur, tmp, &fence->wait_list, node) {
+			list_del_init(&cur->node);
+			wake_up_process(cur->task);
+		}
+		spin_unlock_irqrestore(fence->lock, flags);
+	}
+	return 0;
+}
+
+/**
+ * hl_dma_fence_wait - sleep until the fence gets signaled
+ * or until timeout elapses
+ * @fence: the fence to wait on
+ * @intr: if true, do an interruptible wait
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
+ *
+ * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or the
+ * remaining timeout in jiffies on success. Other error values may be
+ * returned on custom implementations.
+ *
+ * Performs a synchronous wait on this fence. It is assumed the caller
+ * directly or indirectly (buf-mgr between reservation and committing)
+ * holds a reference to the fence, otherwise the fence might be
+ * freed before return, resulting in undefined behavior.
+ */
+signed long
+hl_dma_fence_wait(struct hl_dma_fence *fence, bool intr, signed long timeout)
+{
+	struct wait_task new_task;
+	unsigned long flags;
+	signed long ret = timeout ? timeout : 1;
+	bool was_set;
+
+	if (WARN_ON(timeout < 0))
+		return -EINVAL;
+
+	if (test_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
+		return ret;
+
+	spin_lock_irqsave(fence->lock, flags);
+
+	if (intr && signal_pending(current)) {
+		ret = -ERESTARTSYS;
+		goto out;
+	}
+
+	was_set = test_and_set_bit(HL_DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+				   &fence->flags);
+
+	if (test_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
+		goto out;
+
+	if (!timeout) {
+		ret = 0;
+		goto out;
+	}
+
+	new_task.task = current;
+	list_add(&new_task.node, &fence->wait_list);
+
+	while (!test_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
+			ret > 0) {
+		if (intr)
+			__set_current_state(TASK_INTERRUPTIBLE);
+		else
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(fence->lock, flags);
+
+		ret = schedule_timeout(ret);
+
+		spin_lock_irqsave(fence->lock, flags);
+		if (ret > 0 && intr && signal_pending(current))
+			ret = -ERESTARTSYS;
+	}
+
+	if (!list_empty(&new_task.node))
+		list_del(&new_task.node);
+	__set_current_state(TASK_RUNNING);
+
+out:
+	spin_unlock_irqrestore(fence->lock, flags);
+	return ret;
+}
+
+/**
+ * hl_dma_fence_release - release function for fences
+ * @kref: &dma_fence.recfount
+ *
+ * This is the default release functions for &dma_fence. Drivers shouldn't call
+ * this directly, but instead call hl_dma_fence_put().
+ */
+void hl_dma_fence_release(struct kref *kref)
+{
+	struct hl_dma_fence *fence =
+		container_of(kref, struct hl_dma_fence, refcount);
+
+	if (WARN(!list_empty(&fence->wait_list),
+		 "Fence HabanaLabs:%s released with pending signals!\n",
+		 hl_fence_get_timeline_name(fence))) {
+		unsigned long flags;
+
+		/*
+		 * Failed to signal before release, likely a refcounting issue.
+		 *
+		 * This should never happen, but if it does make sure that we
+		 * don't leave chains dangling. We set the error flag first
+		 * so that the callbacks know this signal is due to an error.
+		 */
+		spin_lock_irqsave(fence->lock, flags);
+		fence->error = -EDEADLK;
+		hl_dma_fence_signal_locked(fence);
+		spin_unlock_irqrestore(fence->lock, flags);
+	}
+
+	hl_fence_release(fence);
+}
+
+/**
+ * hl_dma_fence_get_status - returns the status upon completion
+ * @fence: the hl_dma_fence to query
+ *
+ * Returns 0 if the fence has not yet been signaled, 1 if the fence has
+ * been signaled without an error condition, or a negative error code
+ * if the fence has been completed in err.
+ */
+int hl_dma_fence_get_status(struct hl_dma_fence *fence)
+{
+	unsigned long flags;
+	int status;
+
+	spin_lock_irqsave(fence->lock, flags);
+
+	if (hl_dma_fence_is_signaled(fence))
+		status = fence->error ?: 1;
+	else
+		status = 0;
+
+	spin_unlock_irqrestore(fence->lock, flags);
+
+	return status;
+}
+
+/**
+ * hl_dma_fence_init - Initialize a custom fence.
+ * @fence: the fence to initialize
+ * @lock: the irqsafe spinlock to use for locking this fence
+ *
+ * Initializes an allocated fence, the caller doesn't have to keep its
+ * refcount after committing with this fence
+ */
+void
+hl_dma_fence_init(struct hl_dma_fence *fence, spinlock_t *lock)
+{
+	kref_init(&fence->refcount);
+	INIT_LIST_HEAD(&fence->wait_list);
+	fence->lock = lock;
+	fence->flags = 0UL;
+	fence->error = 0;
+}
diff --git a/drivers/misc/habanalabs/hl_dma_fence.h b/drivers/misc/habanalabs/hl_dma_fence.h
new file mode 100644
index 000000000000..183455b093c2
--- /dev/null
+++ b/drivers/misc/habanalabs/hl_dma_fence.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Fence mechanism for dma-buf to allow for asynchronous dma access
+ *
+ * Copyright (C) 2012 Canonical Ltd
+ * Copyright (C) 2012 Texas Instruments
+ *
+ * Authors:
+ * Rob Clark <robdclark@gmail.com>
+ * Maarten Lankhorst <maarten.lankhorst@canonical.com>
+ *
+ * The dma_fence module is a copy of dma-fence at drivers/dma-buf.
+ * This was done due to an explicit request by GPU developers who asked not
+ * to use the dma-buf module because we aren't part of DRM subsystem.
+ * This copy was stripped from all extra features that habanalabs driver
+ * doesn't use, including the uapi interface dma-buf exposes.
+ * In addition, we removed the callbacks because the only usage is from inside
+ * habanalabs driver
+ */
+
+#ifndef __HL_DMA_FENCE_H
+#define __HL_DMA_FENCE_H
+
+#include <linux/err.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/bitops.h>
+#include <linux/kref.h>
+#include <linux/sched.h>
+#include <linux/printk.h>
+#include <linux/rcupdate.h>
+
+/**
+ * struct hl_dma_fence - software synchronization primitive
+ * @refcount: refcount for this fence
+ * @rcu: used for releasing fence with kfree_rcu
+ * @wait_list: list of all waiting tasks to call
+ * @lock: spin_lock_irqsave used for locking
+ * @flags: A mask of HL_DMA_FENCE_FLAG_* defined below
+ * @error: Optional, only valid if < 0, must be set before calling
+ *
+ * the flags member must be manipulated and read using the appropriate
+ * atomic ops (bit_*), so taking the spinlock will not be needed most
+ * of the time.
+ *
+ * HL_DMA_FENCE_FLAG_SIGNALED_BIT - fence is already signaled
+ * HL_DMA_FENCE_FLAG_TIMESTAMP_BIT - timestamp recorded for fence signaling
+ * HL_DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT - enable_signaling might have been called
+ * HL_DMA_FENCE_FLAG_USER_BITS - start of the unused bits, can be used by the
+ * implementer of the fence for its own purposes. Can be used in different
+ * ways by different fence implementers, so do not rely on this.
+ *
+ * Since atomic bitops are used, this is not guaranteed to be the case.
+ * Particularly, if the bit was set, but hl_dma_fence_signal was called right
+ * before this bit was set, it would have been able to set the
+ * HL_DMA_FENCE_FLAG_SIGNALED_BIT, before enable_signaling was called.
+ * Adding a check for HL_DMA_FENCE_FLAG_SIGNALED_BIT after setting
+ * HL_DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT closes this race, and makes sure that
+ * after hl_dma_fence_signal was called, any enable_signaling call will have
+ * either been completed, or never called at all.
+ */
+struct hl_dma_fence {
+	struct kref refcount;
+	struct rcu_head rcu;
+	struct list_head wait_list;
+	spinlock_t *lock;
+	unsigned long flags;
+	int error;
+};
+
+enum hl_dma_fence_flag_bits {
+	HL_DMA_FENCE_FLAG_SIGNALED_BIT,
+	HL_DMA_FENCE_FLAG_TIMESTAMP_BIT,
+	HL_DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+	HL_DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
+};
+
+void hl_dma_fence_init(struct hl_dma_fence *fence, spinlock_t *lock);
+void hl_dma_fence_release(struct kref *kref);
+void hl_dma_fence_free(struct hl_dma_fence *fence);
+
+/**
+ * hl_dma_fence_put - decreases refcount of the fence
+ * @fence: fence to reduce refcount of
+ */
+static inline void hl_dma_fence_put(struct hl_dma_fence *fence)
+{
+	if (fence)
+		kref_put(&fence->refcount, hl_dma_fence_release);
+}
+
+/**
+ * hl_dma_fence_get - increases refcount of the fence
+ * @fence: fence to increase refcount of
+ *
+ * Returns the same fence, with refcount increased by 1.
+ */
+static inline struct hl_dma_fence *hl_dma_fence_get(struct hl_dma_fence *fence)
+{
+	if (fence)
+		kref_get(&fence->refcount);
+	return fence;
+}
+
+int hl_dma_fence_signal(struct hl_dma_fence *fence);
+
+/**
+ * hl_dma_fence_is_signaled - Return an indication if the fence is signaled yet.
+ * @fence: the fence to check
+ *
+ * Returns true if the fence was already signaled, false if not.
+ *
+ */
+static inline bool
+hl_dma_fence_is_signaled(struct hl_dma_fence *fence)
+{
+	if (test_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
+		return true;
+
+	return false;
+}
+
+int hl_dma_fence_get_status(struct hl_dma_fence *fence);
+
+/**
+ * hl_dma_fence_set_error - flag an error condition on the fence
+ * @fence: the hl_dma_fence
+ * @error: the error to store
+ *
+ * Drivers can supply an optional error status condition before they signal
+ * the fence, to indicate that the fence was completed due to an error
+ * rather than success. This must be set before signaling (so that the value
+ * is visible before any waiters on the signal callback are woken). This
+ * helper exists to help catching erroneous setting of #dma_fence.error.
+ */
+static inline void hl_dma_fence_set_error(struct hl_dma_fence *fence,
+				       int error)
+{
+	WARN_ON(test_bit(HL_DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags));
+	WARN_ON(error >= 0 || error < -MAX_ERRNO);
+
+	fence->error = error;
+}
+
+signed long hl_dma_fence_wait(struct hl_dma_fence *fence,
+		bool intr, signed long timeout);
+
+#endif /* __HL_DMA_FENCE_H */
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 287681646071..c32796c761ba 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -474,7 +474,7 @@ static void init_signal_wait_cs(struct hl_cs *cs)
 		 * wait CS was submitted.
 		 */
 		mb();
-		dma_fence_put(cs->signal_fence);
+		hl_dma_fence_put(cs->signal_fence);
 		cs->signal_fence = NULL;
 	}
 }
-- 
2.17.1

