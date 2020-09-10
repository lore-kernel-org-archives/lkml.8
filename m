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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F95207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3+JXQyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIJSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIJSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBFC061799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so10125064ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Wl+fwizjnv5HZxiMamxKnrlnokBglc59Bt4uvrywQY=;
        b=C3+JXQyQCraOSB2732RkOdnVZJbTnkfg05zVzJAIDFXFm37PIsR/KAueSNtmUQmYeb
         3pWfD4WPlvlKvoLSDvpz1c6H54A7F3LWYj3Psl/Jq6nOU9m1dMc2eKl6D7TYlKE5w2Fi
         keGXXCzDRSuP5wQjxBz4XWOvRM17JzZFaRH2zu+rRFupr2RV5gz8PizfrGNQDPqL9AlI
         Mu/dBsA2Mfa2DrN4XexiePtKWpDY1I12+8SivyQdf0H5ZGgpPgM1RTgo7b7BL4dlkB0O
         +N2aWNihW3yGuBUwWnZB5Oq6n4w/bJchmePfr43zfMuEqSECGOoTxmuC+sqzN9BKo9Dw
         ON9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Wl+fwizjnv5HZxiMamxKnrlnokBglc59Bt4uvrywQY=;
        b=LpBfXPIVsNT+iR3+RG+n83qcoHja9ioUJzx86WIgV1ncteGPiyfK+jOZYduVEV+gb+
         1BeMC7GIHNSShsus2l3xPV7pnvx1Ojx8mhkgbY1Qw9RmO0UxJBBEjPE5sLK6GN6Ywtll
         yNdEUeCLeyhLkR/ajMjo2zFrUZ7FTjCK4rao+JK5Md4xMRUt8qXBqTdxStKeGkTa5vKR
         quU4L/eqs2RhFi6Ka7NnXUPxM0S5CCoim8uEpy5kMXBefB0RjPOtMdLEtVmnu3//WZuC
         ulI9Iy6bfqsD51KSLi3atzySZpxKz3Dd3iFM7h81DqGBKeTnF2vf+UasvRlE0BH1QTnY
         kIuA==
X-Gm-Message-State: AOAM533i+tz0VRFV7pIWljMReZuAIs4XWmrhEuzLsD1DKxaPWBCWV+cC
        ezrz15BYL+IJD8580u4zoMBulTDkz44=
X-Google-Smtp-Source: ABdhPJxKnN6A+7nqeQit2yS2h4z2nTcct2Q4Mas2sZJvmVDV6i3eM6XA/5ePSGoW26qlhIqQyu1aeA==
X-Received: by 2002:a17:906:b04a:: with SMTP id bj10mr10062955ejb.303.1599761746966;
        Thu, 10 Sep 2020 11:15:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/11] habanalabs: Save context in a command buffer object
Date:   Thu, 10 Sep 2020 21:15:22 +0300
Message-Id: <20200910181524.21460-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Future changes require using a context while handling a command buffer,
and thus need to save the context in the command buffer object.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/common/command_buffer.c   | 22 +++++++++++--------
 drivers/misc/habanalabs/common/debugfs.c      |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  9 ++++----
 drivers/misc/habanalabs/gaudi/gaudi.c         | 10 +++++----
 drivers/misc/habanalabs/goya/goya.c           | 10 +++++----
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index ba63cee74050..0cb556fb4a8b 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -47,6 +47,8 @@ static void cb_release(struct kref *ref)
 
 	hl_debugfs_remove_cb(cb);
 
+	hl_ctx_put(cb->ctx);
+
 	cb_do_release(hdev, cb);
 }
 
@@ -107,11 +109,12 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 }
 
 int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
-			u32 cb_size, u64 *handle, int ctx_id, bool internal_cb)
+			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
+			u64 *handle)
 {
 	struct hl_cb *cb;
 	bool alloc_new_cb = true;
-	int rc;
+	int rc, ctx_id = ctx->asid;
 
 	/*
 	 * Can't use generic function to check this because of special case
@@ -163,7 +166,8 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	}
 
 	cb->hdev = hdev;
-	cb->ctx_id = ctx_id;
+	cb->ctx = ctx;
+	hl_ctx_get(hdev, cb->ctx);
 
 	spin_lock(&mgr->cb_lock);
 	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
@@ -191,6 +195,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	return 0;
 
 release_cb:
+	hl_ctx_put(cb->ctx);
 	cb_do_release(hdev, cb);
 out_err:
 	*handle = 0;
@@ -250,9 +255,8 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.cb_size, HL_MAX_CB_SIZE);
 			rc = -EINVAL;
 		} else {
-			rc = hl_cb_create(hdev, &hpriv->cb_mgr,
-					args->in.cb_size, &handle,
-					hpriv->ctx->asid, false);
+			rc = hl_cb_create(hdev, &hpriv->cb_mgr, hpriv->ctx,
+					args->in.cb_size, false, &handle);
 		}
 
 		memset(args, 0, sizeof(*args));
@@ -424,7 +428,7 @@ void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr)
 		if (kref_put(&cb->refcount, cb_release) != 1)
 			dev_err(hdev->dev,
 				"CB %d for CTX ID %d is still alive\n",
-				id, cb->ctx_id);
+				id, cb->ctx->asid);
 	}
 
 	idr_destroy(&mgr->cb_handles);
@@ -437,8 +441,8 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 	struct hl_cb *cb;
 	int rc;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, cb_size, &cb_handle,
-			HL_KERNEL_ASID_ID, internal_cb);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx, cb_size,
+				internal_cb, &cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate CB for the kernel driver %d\n", rc);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 7b1fb49c3501..569d054a6b06 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -111,7 +111,7 @@ static int command_buffers_show(struct seq_file *s, void *data)
 		}
 		seq_printf(s,
 			"   %03llu        %d    0x%08x      %d          %d          %d\n",
-			cb->id, cb->ctx_id, cb->size,
+			cb->id, cb->ctx->asid, cb->size,
 			kref_read(&cb->refcount),
 			cb->mmap, cb->cs_cnt);
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8ef61926ed3b..88c68b664ef6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -417,6 +417,7 @@ struct hl_cb_mgr {
  * struct hl_cb - describes a Command Buffer.
  * @refcount: reference counter for usage of the CB.
  * @hdev: pointer to device this CB belongs to.
+ * @ctx: pointer to the CB owner's context.
  * @lock: spinlock to protect mmap/cs flows.
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
@@ -426,7 +427,6 @@ struct hl_cb_mgr {
  * @mmap_size: Holds the CB's size that was mmaped.
  * @size: holds the CB's size.
  * @cs_cnt: holds number of CS that this CB participates in.
- * @ctx_id: holds the ID of the owner's context.
  * @mmap: true if the CB is currently mmaped to user.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
  * @is_internal: internaly allocated
@@ -434,6 +434,7 @@ struct hl_cb_mgr {
 struct hl_cb {
 	struct kref		refcount;
 	struct hl_device	*hdev;
+	struct hl_ctx		*ctx;
 	spinlock_t		lock;
 	struct list_head	debugfs_list;
 	struct list_head	pool_list;
@@ -443,7 +444,6 @@ struct hl_cb {
 	u32			mmap_size;
 	u32			size;
 	u32			cs_cnt;
-	u32			ctx_id;
 	u8			mmap;
 	u8			is_pool;
 	u8			is_internal;
@@ -1838,8 +1838,9 @@ void hl_sysfs_fini(struct hl_device *hdev);
 int hl_hwmon_init(struct hl_device *hdev);
 void hl_hwmon_fini(struct hl_device *hdev);
 
-int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr, u32 cb_size,
-		u64 *handle, int ctx_id, bool internal_cb);
+int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
+			struct hl_ctx *ctx, u32 cb_size, bool internal_cb,
+			u64 *handle);
 int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
 int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bf010ff31ced..b51cc6c1d541 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4114,8 +4114,9 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	parser->patched_cb_size = parser->user_cb_size +
 			sizeof(struct packet_msg_prot) * 2;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
-			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+				parser->patched_cb_size, false,
+				&patched_cb_handle);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -4187,8 +4188,9 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
-			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+				parser->patched_cb_size, false,
+				&patched_cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6f831cc54d37..6c81a4b148de 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3810,8 +3810,9 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	parser->patched_cb_size = parser->user_cb_size +
 			sizeof(struct packet_msg_prot) * 2;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
-			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+				parser->patched_cb_size, false,
+				&patched_cb_handle);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -3883,8 +3884,9 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	if (rc)
 		goto free_userptr;
 
-	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, parser->patched_cb_size,
-			&patched_cb_handle, HL_KERNEL_ASID_ID, false);
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
+				parser->patched_cb_size, false,
+				&patched_cb_handle);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to allocate patched CB for DMA CS %d\n", rc);
-- 
2.17.1

