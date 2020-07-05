Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05276C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68092075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN5nqLYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGENNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgGENNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:13:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A1C08C5DF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:13:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so38791803wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jloKtVeYMDh72L4ANCYc+9UlE0wG9ni/nPKTHtLsOHM=;
        b=sN5nqLYfz4NDHiRonmta4mkVPUjtmRt+rHyLG0jevDYYBVzouey8SSRXA+DrgrTLJ2
         o6pMbyMYUOPc/9vaS0LuBNuM7jysuRr4GEO6DfyxtMqwo69sPAv5IVjzlZlE69i7uwwN
         +fQ6M52LAvt57IBLPTuQ3QhCBLN3MzupaVtPiCAXYQRwQ22uGPE1Va2FoLGoLT0cwdu0
         xTRlAY4ysUfmIXFaVp8vtMnDhqXCBwemXji6uMH/7qaqIlqA2FrAKrQ0q2czYRmJ+e+x
         zGvmHGbbt5RERWwsPI8aP7zyqejGBGM8Qjhx3jkkyEvD1FMZvfpstOIlyUhzbjUFhoqM
         f64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jloKtVeYMDh72L4ANCYc+9UlE0wG9ni/nPKTHtLsOHM=;
        b=INvg/GgQb8uh0tCf67lYgvZJKNntA25UyLonD9aP3N3/s37KNPUxI0A5bWLTKFNpzL
         2q+SA79Su6c5JTdWAeXyqvwxcMAmvUM4BXRi4Lt0T6BGmMxZkGMONDTrVm5pRrcinLBy
         p5FmjuELmG3fVtdWxzi4Vv1kkQUqkG1AwyoYNHaaKIS3CrMi3V1Uqhy9aGEb/QGQOEE7
         lr2rDt8bIr4uxAJw9q3cAhiRK7QLkUc2qDMs3iWL2mTqsTyie3+M18Njrh3t56QAoPIq
         lYOUCROiJ/BTMpWFWzU54RzbmjSSt9ogagp7HfPltbhGF6ZYlHIxLuGg7MwzmsSE77y+
         mDIA==
X-Gm-Message-State: AOAM532KFRFpa89sCsDbPZY88uBHlxhznaLOIicFpGf4aJEd/l5o4wST
        BYqK67Ap8iFP1UINZ3vFPhppZ4vn
X-Google-Smtp-Source: ABdhPJwrsStYlcFCndeWaUbMDh3oYGek/FucPVhfc2DQxfa6I09mzbvi9XF4x9U+S4dvSUMdIgbxFA==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr47060322wmj.160.1593954778225;
        Sun, 05 Jul 2020 06:12:58 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:57 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 8/9] habanalabs: configure maximum queues per asic
Date:   Sun,  5 Jul 2020 16:12:44 +0300
Message-Id: <20200705131245.9368-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently the amount of maximum queues is statically configured.
Using a static value is causing redundunt cycles when traversing
all queues and consumes more memory than actually needed.
In this patch we configure each asic with the exact number of
queues needed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 14 ++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c        | 33 +++++++++++--------
 drivers/misc/habanalabs/goya/goya.c          | 34 +++++++++++++++-----
 drivers/misc/habanalabs/goya/goyaP.h         |  6 +---
 drivers/misc/habanalabs/habanalabs.h         | 10 +++---
 drivers/misc/habanalabs/hw_queue.c           | 19 +++++++----
 6 files changed, 74 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 777f88d25acd..1ba937b9a22e 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -363,6 +363,7 @@ static void cs_do_release(struct kref *ref)
 
 	cs_counters_aggregate(hdev, cs->ctx);
 
+	kfree(cs->jobs_in_queue_cnt);
 	kfree(cs);
 }
 
@@ -435,13 +436,19 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	other = ctx->cs_pending[cs_cmpl->cs_seq &
 				(hdev->asic_prop.max_pending_cs - 1)];
 	if ((other) && (!dma_fence_is_signaled(other))) {
-		spin_unlock(&ctx->cs_lock);
 		dev_dbg(hdev->dev,
 			"Rejecting CS because of too many in-flights CS\n");
 		rc = -EAGAIN;
 		goto free_fence;
 	}
 
+	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
+			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
+	if (!cs->jobs_in_queue_cnt) {
+		rc = -ENOMEM;
+		goto free_fence;
+	}
+
 	dma_fence_init(&cs_cmpl->base_fence, &hl_fence_ops, &cs_cmpl->lock,
 			ctx->asid, ctx->cs_sequence);
 
@@ -463,6 +470,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	return 0;
 
 free_fence:
+	spin_unlock(&ctx->cs_lock);
 	kfree(cs_cmpl);
 free_cs:
 	kfree(cs);
@@ -517,7 +525,7 @@ static int validate_queue_index(struct hl_device *hdev,
 
 	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
 
-	if ((chunk->queue_index >= HL_MAX_QUEUES) ||
+	if ((chunk->queue_index >= asic->max_queues) ||
 			(hw_queue_prop->type == QUEUE_TYPE_NA)) {
 		dev_err(hdev->dev, "Queue index %d is invalid\n",
 			chunk->queue_index);
@@ -795,7 +803,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
 	q_type = hw_queue_prop->type;
 
-	if ((q_idx >= HL_MAX_QUEUES) ||
+	if ((q_idx >= hdev->asic_prop.max_queues) ||
 			(!hw_queue_prop->supports_sync_stream)) {
 		dev_err(hdev->dev, "Queue index %d is invalid\n", q_idx);
 		rc = -EINVAL;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d3869209dbc6..3404d6b0453f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -340,14 +340,15 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int i;
 
-	if (GAUDI_QUEUE_ID_SIZE >= HL_MAX_QUEUES) {
-		dev_err(hdev->dev,
-			"Number of H/W queues must be smaller than %d\n",
-			HL_MAX_QUEUES);
-		return -EFAULT;
-	}
+	prop->max_queues = GAUDI_QUEUE_ID_SIZE;
+	prop->hw_queues_props = kcalloc(prop->max_queues,
+			sizeof(struct hw_queue_properties),
+			GFP_KERNEL);
 
-	for (i = 0 ; i < GAUDI_QUEUE_ID_SIZE ; i++) {
+	if (!prop->hw_queues_props)
+		return -ENOMEM;
+
+	for (i = 0 ; i < prop->max_queues ; i++) {
 		if (gaudi_queue_type[i] == QUEUE_TYPE_EXT) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
 			prop->hw_queues_props[i].driver_only = 0;
@@ -370,9 +371,6 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 		}
 	}
 
-	for (; i < HL_MAX_QUEUES; i++)
-		prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
-
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 	prop->sync_stream_first_sob = 0;
 	prop->sync_stream_first_mon = 0;
@@ -548,7 +546,8 @@ static int gaudi_early_init(struct hl_device *hdev)
 			(unsigned long long) pci_resource_len(pdev,
 							SRAM_BAR_ID),
 			SRAM_BAR_SIZE);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_queue_props;
 	}
 
 	if (pci_resource_len(pdev, CFG_BAR_ID) != CFG_BAR_SIZE) {
@@ -558,20 +557,26 @@ static int gaudi_early_init(struct hl_device *hdev)
 			(unsigned long long) pci_resource_len(pdev,
 								CFG_BAR_ID),
 			CFG_BAR_SIZE);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_queue_props;
 	}
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
 	rc = hl_pci_init(hdev);
 	if (rc)
-		return rc;
+		goto free_queue_props;
 
 	return 0;
+
+free_queue_props:
+	kfree(hdev->asic_prop.hw_queues_props);
+	return rc;
 }
 
 static int gaudi_early_fini(struct hl_device *hdev)
 {
+	kfree(hdev->asic_prop.hw_queues_props);
 	hl_pci_fini(hdev);
 
 	return 0;
@@ -3466,7 +3471,7 @@ static int gaudi_test_queues(struct hl_device *hdev)
 {
 	int i, rc, ret_val = 0;
 
-	for (i = 0 ; i < HL_MAX_QUEUES ; i++) {
+	for (i = 0 ; i < hdev->asic_prop.max_queues ; i++) {
 		if (hdev->asic_prop.hw_queues_props[i].type == QUEUE_TYPE_EXT) {
 			rc = gaudi_test_queue(hdev, i);
 			if (rc)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5839b5bc9ee3..36db771f391c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -337,11 +337,19 @@ static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev);
 static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 
-void goya_get_fixed_properties(struct hl_device *hdev)
+int goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int i;
 
+	prop->max_queues = GOYA_QUEUE_ID_SIZE;
+	prop->hw_queues_props = kcalloc(prop->max_queues,
+			sizeof(struct hw_queue_properties),
+			GFP_KERNEL);
+
+	if (!prop->hw_queues_props)
+		return -ENOMEM;
+
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
 		prop->hw_queues_props[i].driver_only = 0;
@@ -361,9 +369,6 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 		prop->hw_queues_props[i].requires_kernel_cb = 0;
 	}
 
-	for (; i < HL_MAX_QUEUES; i++)
-		prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
-
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 
 	prop->dram_base_address = DRAM_PHYS_BASE;
@@ -428,6 +433,8 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 		CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
+
+	return 0;
 }
 
 /*
@@ -540,7 +547,11 @@ static int goya_early_init(struct hl_device *hdev)
 	u32 val;
 	int rc;
 
-	goya_get_fixed_properties(hdev);
+	rc = goya_get_fixed_properties(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get fixed properties\n");
+		return rc;
+	}
 
 	/* Check BAR sizes */
 	if (pci_resource_len(pdev, SRAM_CFG_BAR_ID) != CFG_BAR_SIZE) {
@@ -550,7 +561,8 @@ static int goya_early_init(struct hl_device *hdev)
 			(unsigned long long) pci_resource_len(pdev,
 							SRAM_CFG_BAR_ID),
 			CFG_BAR_SIZE);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_queue_props;
 	}
 
 	if (pci_resource_len(pdev, MSIX_BAR_ID) != MSIX_BAR_SIZE) {
@@ -560,14 +572,15 @@ static int goya_early_init(struct hl_device *hdev)
 			(unsigned long long) pci_resource_len(pdev,
 								MSIX_BAR_ID),
 			MSIX_BAR_SIZE);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto free_queue_props;
 	}
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
 	rc = hl_pci_init(hdev);
 	if (rc)
-		return rc;
+		goto free_queue_props;
 
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
@@ -577,6 +590,10 @@ static int goya_early_init(struct hl_device *hdev)
 	}
 
 	return 0;
+
+free_queue_props:
+	kfree(hdev->asic_prop.hw_queues_props);
+	return rc;
 }
 
 /*
@@ -589,6 +606,7 @@ static int goya_early_init(struct hl_device *hdev)
  */
 static int goya_early_fini(struct hl_device *hdev)
 {
+	kfree(hdev->asic_prop.hw_queues_props);
 	hl_pci_fini(hdev);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 9d8a1761252d..8265cc21b45a 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -31,10 +31,6 @@
  */
 #define NUMBER_OF_INTERRUPTS		(NUMBER_OF_CMPLT_QUEUES + 1)
 
-#if (NUMBER_OF_HW_QUEUES >= HL_MAX_QUEUES)
-#error "Number of H/W queues must be smaller than HL_MAX_QUEUES"
-#endif
-
 #if (NUMBER_OF_INTERRUPTS > GOYA_MSIX_ENTRIES)
 #error "Number of MSIX interrupts must be smaller or equal to GOYA_MSIX_ENTRIES"
 #endif
@@ -170,7 +166,7 @@ struct goya_device {
 	u8		device_cpu_mmu_mappings_done;
 };
 
-void goya_get_fixed_properties(struct hl_device *hdev);
+int goya_get_fixed_properties(struct hl_device *hdev);
 int goya_mmu_init(struct hl_device *hdev);
 void goya_init_dma_qmans(struct hl_device *hdev);
 void goya_init_mme_qmans(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 365236589bbf..9213d107b533 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -41,8 +41,6 @@
 
 #define HL_SIM_MAX_TIMEOUT_US		10000000 /* 10s */
 
-#define HL_MAX_QUEUES			128
-
 #define HL_IDLE_BUSY_TS_ARR_SIZE	4096
 
 /* Memory */
@@ -290,14 +288,15 @@ struct hl_mmu_properties {
  * @high_pll: high PLL frequency used by the device.
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
  * @cb_pool_cb_size: size of each CB in the CB pool.
- * @tpc_enabled_mask: which TPCs are enabled.
+ * @max_pending_cs: maximum of concurrent pending command submissions
+ * @max_queues: maximum amount of queues in the system
  * @sync_stream_first_sob: first sync object available for sync stream use
  * @sync_stream_first_mon: first monitor available for sync stream use
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  */
 struct asic_fixed_properties {
-	struct hw_queue_properties	hw_queues_props[HL_MAX_QUEUES];
+	struct hw_queue_properties	*hw_queues_props;
 	struct armcp_info		armcp_info;
 	char				uboot_ver[VERSION_MAX_LEN];
 	char				preboot_ver[VERSION_MAX_LEN];
@@ -336,6 +335,7 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_cnt;
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
+	u32				max_queues;
 	u16				sync_stream_first_sob;
 	u16				sync_stream_first_mon;
 	u8				tpc_enabled_mask;
@@ -901,7 +901,7 @@ struct hl_userptr {
  * @aborted: true if CS was aborted due to some device error.
  */
 struct hl_cs {
-	u16			jobs_in_queue_cnt[HL_MAX_QUEUES];
+	u16			*jobs_in_queue_cnt;
 	struct hl_ctx		*ctx;
 	struct list_head	job_list;
 	spinlock_t		job_lock;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index da66ffb528f8..7965551587fc 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -46,7 +46,7 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
 		goto out;
 
 	q = &hdev->kernel_queues[0];
-	for (i = 0 ; i < HL_MAX_QUEUES ; i++, q++) {
+	for (i = 0 ; i < hdev->asic_prop.max_queues ; i++, q++) {
 		if (q->queue_type == QUEUE_TYPE_INT) {
 			q->ci += cs->jobs_in_queue_cnt[i];
 			q->ci &= ((q->int_queue_len << 1) - 1);
@@ -509,6 +509,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_cs_job *job, *tmp;
 	struct hl_hw_queue *q;
+	u32 max_queues;
 	int rc = 0, i, cq_cnt;
 
 	hdev->asic_funcs->hw_queues_lock(hdev);
@@ -521,8 +522,10 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		goto out;
 	}
 
+	max_queues = hdev->asic_prop.max_queues;
+
 	q = &hdev->kernel_queues[0];
-	for (i = 0, cq_cnt = 0 ; i < HL_MAX_QUEUES ; i++, q++) {
+	for (i = 0, cq_cnt = 0 ; i < max_queues ; i++, q++) {
 		if (cs->jobs_in_queue_cnt[i]) {
 			switch (q->queue_type) {
 			case QUEUE_TYPE_EXT:
@@ -601,7 +604,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 unroll_cq_resv:
 	q = &hdev->kernel_queues[0];
-	for (i = 0 ; (i < HL_MAX_QUEUES) && (cq_cnt > 0) ; i++, q++) {
+	for (i = 0 ; (i < max_queues) && (cq_cnt > 0) ; i++, q++) {
 		if ((q->queue_type == QUEUE_TYPE_EXT ||
 				q->queue_type == QUEUE_TYPE_HW) &&
 				cs->jobs_in_queue_cnt[i]) {
@@ -872,7 +875,7 @@ int hl_hw_queues_create(struct hl_device *hdev)
 	struct hl_hw_queue *q;
 	int i, rc, q_ready_cnt;
 
-	hdev->kernel_queues = kcalloc(HL_MAX_QUEUES,
+	hdev->kernel_queues = kcalloc(asic->max_queues,
 				sizeof(*hdev->kernel_queues), GFP_KERNEL);
 
 	if (!hdev->kernel_queues) {
@@ -882,7 +885,7 @@ int hl_hw_queues_create(struct hl_device *hdev)
 
 	/* Initialize the H/W queues */
 	for (i = 0, q_ready_cnt = 0, q = hdev->kernel_queues;
-			i < HL_MAX_QUEUES ; i++, q_ready_cnt++, q++) {
+			i < asic->max_queues ; i++, q_ready_cnt++, q++) {
 
 		q->queue_type = asic->hw_queues_props[i].type;
 		q->supports_sync_stream =
@@ -909,9 +912,10 @@ int hl_hw_queues_create(struct hl_device *hdev)
 void hl_hw_queues_destroy(struct hl_device *hdev)
 {
 	struct hl_hw_queue *q;
+	u32 max_queues = hdev->asic_prop.max_queues;
 	int i;
 
-	for (i = 0, q = hdev->kernel_queues ; i < HL_MAX_QUEUES ; i++, q++)
+	for (i = 0, q = hdev->kernel_queues ; i < max_queues ; i++, q++)
 		queue_fini(hdev, q);
 
 	kfree(hdev->kernel_queues);
@@ -920,9 +924,10 @@ void hl_hw_queues_destroy(struct hl_device *hdev)
 void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset)
 {
 	struct hl_hw_queue *q;
+	u32 max_queues = hdev->asic_prop.max_queues;
 	int i;
 
-	for (i = 0, q = hdev->kernel_queues ; i < HL_MAX_QUEUES ; i++, q++) {
+	for (i = 0, q = hdev->kernel_queues ; i < max_queues ; i++, q++) {
 		if ((!q->valid) ||
 			((!hard_reset) && (q->queue_type == QUEUE_TYPE_CPU)))
 			continue;
-- 
2.17.1

