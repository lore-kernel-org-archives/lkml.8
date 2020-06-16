Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE67BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BB82074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNIctA3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgFPGNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so19434889wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3E9VSoUOLHhugazwFio3UAs9OvlKnm9aFTThDmcTgz8=;
        b=cNIctA3MdrGgqkHjXnHy0qQc1xxBQx+qOmpE7RSSHODs4sn8NUUnaoWrt4n30dU3Qo
         FM0gHLp5n1Q8EXgvoXweMhqeNPhZjiRfC66JrAjx5v1YOekeAzTzdOUrLT/lqKkTAmw0
         BX4lHim+q6T50HbOm0nIdQoRbKHULQ7bVkrNcPYkK0wqCZIadXPvWCgX+slPp/71cymn
         zyDvVvc7gVc7OXgM2BiW4Z7reWM+Sl3++kO7VN4JTs+SM9VC5qRMpUyQtY46wJAJc3oH
         r6QXWTb8mlTqLPiSghNHLbl9gS4eacnRTaBF6GQX2iyIhpM4M/P8YeqBBnR4wH4seoJM
         PN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3E9VSoUOLHhugazwFio3UAs9OvlKnm9aFTThDmcTgz8=;
        b=P1wSP0tqsFGCn8o9OtRO+d7DxAsRB/GotzihK9V9ZkvlT1YHo0+wbobMNkGSUAHV0j
         W245Mbcz47UXM3hoqwFEjWrVvaQ0gviqGsRvOoxmOHqd26UxWAI00mewIi2MDmN4NGtH
         D121kOu2miDBIIZ9d5u91eks7HRmW6f8qMSf8YOqMuDPJanQTNn+kd1nXeCquqi2L2U2
         oA3t9mou/Inl+9vSO/DE91BfpzhVM0Xt8f6NIKk/ckQAQ46tF+rn5Nl0WWMdsRZQKKHN
         UxqfDOZcgTm0s2xvIVVYdn1p/hlCIbacmaYXSyW1ZlReS6FRTG9RjIGLeW25JnRxAcxj
         tNmw==
X-Gm-Message-State: AOAM531abXAJdctDmg+WYD3vCq4f/uRRD098U/ulTD+mrdJLg3JRWCyT
        H/70rDYL9FXqAIT2PtdNmrybHNAyt7c=
X-Google-Smtp-Source: ABdhPJzMixjYzAd4b/oGpgFZ+vrG4UBuUIu70ofxtEW8MzRZI0JFlruwgOtXidiQan5gGKTpKyBU0w==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr1227350wrw.295.1592288016039;
        Mon, 15 Jun 2020 23:13:36 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:35 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/7] habanalabs: Use pending CS amount per ASIC
Date:   Tue, 16 Jun 2020 09:13:22 +0300
Message-Id: <20200616061327.12006-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Training schemes requires much more concurrent command submissions than
inference does. In addition, training command submissions can be completed
in a non serialized manner. Hence, we add support in which each ASIC will
be able to configure the amount of concurrent pending command submissions,
rather than use a predefined amount. This change will enhance performance
by allowing the user to add more concurrent work without waiting for the
previous work to be completed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  6 ++++--
 drivers/misc/habanalabs/context.c            | 14 +++++++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c        |  2 ++
 drivers/misc/habanalabs/gaudi/gaudiP.h       |  6 ++++++
 drivers/misc/habanalabs/goya/goya.c          |  2 ++
 drivers/misc/habanalabs/goya/goyaP.h         |  6 ++++++
 drivers/misc/habanalabs/habanalabs.h         |  9 +++++----
 drivers/misc/habanalabs/hw_queue.c           |  2 +-
 8 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index f82974a916c3..e156803f4a99 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -405,7 +405,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	spin_lock(&ctx->cs_lock);
 
 	cs_cmpl->cs_seq = ctx->cs_sequence;
-	other = ctx->cs_pending[cs_cmpl->cs_seq & (HL_MAX_PENDING_CS - 1)];
+	other = ctx->cs_pending[cs_cmpl->cs_seq &
+				(hdev->asic_prop.max_pending_cs - 1)];
 	if ((other) && (!dma_fence_is_signaled(other))) {
 		spin_unlock(&ctx->cs_lock);
 		dev_dbg(hdev->dev,
@@ -419,7 +420,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cs->sequence = cs_cmpl->cs_seq;
 
-	ctx->cs_pending[cs_cmpl->cs_seq & (HL_MAX_PENDING_CS - 1)] =
+	ctx->cs_pending[cs_cmpl->cs_seq &
+			(hdev->asic_prop.max_pending_cs - 1)] =
 							&cs_cmpl->base_fence;
 	ctx->cs_sequence++;
 
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index ec92b3506b1f..1b96fefa4a65 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -22,9 +22,11 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 	 * to this function unless the ref count is 0
 	 */
 
-	for (i = 0 ; i < HL_MAX_PENDING_CS ; i++)
+	for (i = 0 ; i < hdev->asic_prop.max_pending_cs ; i++)
 		dma_fence_put(ctx->cs_pending[i]);
 
+	kfree(ctx->cs_pending);
+
 	if (ctx->asid != HL_KERNEL_ASID_ID) {
 		/* The engines are stopped as there is no executing CS, but the
 		 * Coresight might be still working by accessing addresses
@@ -126,6 +128,11 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 	spin_lock_init(&ctx->cs_lock);
 	atomic_set(&ctx->thread_ctx_switch_token, 1);
 	ctx->thread_ctx_switch_wait_token = 0;
+	ctx->cs_pending = kcalloc(hdev->asic_prop.max_pending_cs,
+				sizeof(struct dma_fence *),
+				GFP_KERNEL);
+	if (!ctx->cs_pending)
+		return -ENOMEM;
 
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* Kernel driver gets ASID 0 */
@@ -170,6 +177,7 @@ int hl_ctx_put(struct hl_ctx *ctx)
 
 struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 {
+	struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
 	struct dma_fence *fence;
 
 	spin_lock(&ctx->cs_lock);
@@ -179,13 +187,13 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (seq + HL_MAX_PENDING_CS < ctx->cs_sequence) {
+	if (seq + asic_prop->max_pending_cs < ctx->cs_sequence) {
 		spin_unlock(&ctx->cs_lock);
 		return NULL;
 	}
 
 	fence = dma_fence_get(
-			ctx->cs_pending[seq & (HL_MAX_PENDING_CS - 1)]);
+			ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)]);
 	spin_unlock(&ctx->cs_lock);
 
 	return fence;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4d69727bb53b..35e9080f6976 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -429,6 +429,8 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	strncpy(prop->armcp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 					CARD_NAME_MAX_LEN);
 
+	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index a46530d375fa..76c3f840e05a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -57,6 +57,12 @@
 
 #define GAUDI_DEFAULT_CARD_NAME		"HL2000"
 
+#define GAUDI_MAX_PENDING_CS		1024
+
+#if !IS_MAX_PENDING_CS_VALID(GAUDI_MAX_PENDING_CS)
+#error "GAUDI_MAX_PENDING_CS must be power of 2 and greater than 1"
+#endif
+
 #define PCI_DMA_NUMBER_OF_CHNLS		3
 #define HBM_DMA_NUMBER_OF_CHNLS		5
 #define DMA_NUMBER_OF_CHNLS		(PCI_DMA_NUMBER_OF_CHNLS + \
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0d2952bb58df..e872099a3f7a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -426,6 +426,8 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 
 	strncpy(prop->armcp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 		CARD_NAME_MAX_LEN);
+
+	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
 }
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index d36f8d90c9c9..9d8a1761252d 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -57,6 +57,12 @@
 
 #define GOYA_DEFAULT_CARD_NAME		"HL1000"
 
+#define GOYA_MAX_PENDING_CS		64
+
+#if !IS_MAX_PENDING_CS_VALID(GOYA_MAX_PENDING_CS)
+#error "GOYA_MAX_PENDING_CS must be power of 2 and greater than 1"
+#endif
+
 /* DRAM Memory Map */
 
 #define CPU_FW_IMAGE_SIZE		0x10000000	/* 256MB */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 1ecdcf8b763a..64d9b2dd3e19 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -42,9 +42,6 @@
 
 #define HL_MAX_QUEUES			128
 
-/* MUST BE POWER OF 2 and larger than 1 */
-#define HL_MAX_PENDING_CS		64
-
 #define HL_IDLE_BUSY_TS_ARR_SIZE	4096
 
 /* Memory */
@@ -61,6 +58,9 @@
 
 #define HL_MAX_SOB_VAL			(1 << 15)
 
+#define IS_POWER_OF_2(n)		(n != 0 && ((n & (n - 1)) == 0))
+#define IS_MAX_PENDING_CS_VALID(n)	(IS_POWER_OF_2(n) && (n > 1))
+
 /**
  * struct pgt_info - MMU hop page info.
  * @node: hash linked-list node for the pgts shadow hash of pgts.
@@ -285,6 +285,7 @@ struct asic_fixed_properties {
 	u32				high_pll;
 	u32				cb_pool_cb_cnt;
 	u32				cb_pool_cb_size;
+	u32				max_pending_cs;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 };
@@ -782,7 +783,7 @@ struct hl_ctx {
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
 	struct kref		refcount;
-	struct dma_fence	*cs_pending[HL_MAX_PENDING_CS];
+	struct dma_fence	**cs_pending;
 	struct hl_va_range	*host_va_range;
 	struct hl_va_range	*host_huge_va_range;
 	struct hl_va_range	*dram_va_range;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index f4434b39ef1b..29b96d24edc2 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -376,7 +376,7 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	 * write address offset in the SM block (QMAN LBW message).
 	 * The write address offset is calculated as "COMP_OFFSET << 2".
 	 */
-	offset = job->cs->sequence & (HL_MAX_PENDING_CS - 1);
+	offset = job->cs->sequence & (hdev->asic_prop.max_pending_cs - 1);
 	ctl = ((offset << BD_CTL_COMP_OFFSET_SHIFT) & BD_CTL_COMP_OFFSET_MASK) |
 		((q->pi << BD_CTL_COMP_DATA_SHIFT) & BD_CTL_COMP_DATA_MASK);
 
-- 
2.17.1

