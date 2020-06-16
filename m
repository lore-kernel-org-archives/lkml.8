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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51530C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2781E208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWwRMzhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgFPGNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so19369883wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgyOLSFJ5bQTfGa08R4nY2HmoLSV39fHTBBBdZJG4Q8=;
        b=QWwRMzhwppc/FPxcqAQm/jScGR+314vtkifE3g65MHaPfIF1WNZx6NaFulMRzxbZyD
         aHYWawW8yrjYRN9YzeN8TmSYQ9bSU0nS44OucPxg9tQSs+WfyppYHYZkCE12OVkqLAeG
         f3/JCaC7Gr25nfdG0aRql3KU/+3xSHB7EpoJ4WVGavbBUzKhq/A8XbTdqD91z1Vlm3Ab
         T8katPHEeevzalrtdK8vAE/dELIAyjJO5m9NCAGbRxEAl74HbkXPXy56uWAypwhomRjC
         3FpJGlSkkYsZYrrOXVMAimZ0KxjkQYJ3Ch6ufuVEOt4m/UnXKOZUIN6ShitM2FTgdUye
         kwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgyOLSFJ5bQTfGa08R4nY2HmoLSV39fHTBBBdZJG4Q8=;
        b=oh1Fp1ukde+EJ7fW6WS0hLhY1+V/zjQxiCmkHqY/gBA1w1gyN3klLePWtP4PYVtzwv
         KBG7fNCcQ9+kxQF8i/zmvdGzj8IJzmpwLIletR/f9Y6vc7rBcaSLvMUy6xHMoCno/tFF
         JNGGiVPxkOd/bjYu9lGLPRshS10Dq6o0VYyCUsoT5syWwZcZtGVOWwP4CX3iiEXN5m43
         BosznVwWgz6pakZdGhgtCGGUAlwI8qnvtK394pi5QJxgS+2iDRC9BE1NSrmOsaxnpFMG
         P8JMKTutCJX9WsSXK49w2wkJ8X5w2v9iSwHQHCJNkMTY8n3cIk3ZHgINQWI2w/Q3i4ch
         qHmg==
X-Gm-Message-State: AOAM530vVcouW0oU8WEuF2GIDkX2Z63qHrUF/gc0FpjpoOP5ffODvS/l
        7lm6SzHD1yQs+KYugbZQq0FzjXpiMLk=
X-Google-Smtp-Source: ABdhPJz4u1Zj8gM7CiUTWZee3eW97HGtlNAe/ziuAOBWK3I8097amQ/gUEJfnNLoiVuebco0cMCw1Q==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr1226647wrv.174.1592288018068;
        Mon, 15 Jun 2020 23:13:38 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:36 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/7] habanalabs: sync stream generic functionality
Date:   Tue, 16 Jun 2020 09:13:23 +0300
Message-Id: <20200616061327.12006-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently sync stream is limited only for external queues. We want to
remove this constraint by adding a new queue property dedicated for sync
stream. In addition we move the initialization and reset methods to the
common code since we can re-use them with slight changes.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  6 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 46 ++-----------------
 drivers/misc/habanalabs/gaudi/gaudiP.h       |  2 -
 drivers/misc/habanalabs/goya/goya.c          | 12 -----
 drivers/misc/habanalabs/habanalabs.h         | 19 ++++++--
 drivers/misc/habanalabs/hw_queue.c           | 48 ++++++++++++++++++--
 6 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index e156803f4a99..7b410bff72e0 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -727,6 +727,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
+	enum hl_queue_type q_type;
 	u64 *signal_seq_arr = NULL, signal_seq;
 	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
 	int rc;
@@ -759,9 +760,10 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	chunk = &cs_chunk_array[0];
 	q_idx = chunk->queue_index;
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
+	q_type = hw_queue_prop->type;
 
 	if ((q_idx >= HL_MAX_QUEUES) ||
-			(hw_queue_prop->type != QUEUE_TYPE_EXT)) {
+			(!hw_queue_prop->supports_sync_stream)) {
 		dev_err(hdev->dev, "Queue index %d is invalid\n", q_idx);
 		rc = -EINVAL;
 		goto free_cs_chunk_array;
@@ -858,7 +860,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	*cs_seq = cs->sequence;
 
-	job = hl_cs_allocate_job(hdev, QUEUE_TYPE_EXT, true);
+	job = hl_cs_allocate_job(hdev, q_type, true);
 	if (!job) {
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		rc = -ENOMEM;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 35e9080f6976..9ce032466243 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -345,10 +345,12 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
 			prop->hw_queues_props[i].driver_only = 0;
 			prop->hw_queues_props[i].requires_kernel_cb = 1;
+			prop->hw_queues_props[i].supports_sync_stream = 1;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_CPU) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
 			prop->hw_queues_props[i].driver_only = 1;
 			prop->hw_queues_props[i].requires_kernel_cb = 0;
+			prop->hw_queues_props[i].supports_sync_stream = 0;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_INT) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
 			prop->hw_queues_props[i].driver_only = 0;
@@ -357,6 +359,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
 			prop->hw_queues_props[i].driver_only = 0;
 			prop->hw_queues_props[i].requires_kernel_cb = 0;
+			prop->hw_queues_props[i].supports_sync_stream = 0;
 		}
 	}
 
@@ -364,7 +367,8 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 		prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
 
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
-
+	prop->sync_stream_first_sob = 0;
+	prop->sync_stream_first_mon = 0;
 	prop->dram_base_address = DRAM_PHYS_BASE;
 	prop->dram_size = GAUDI_HBM_SIZE_32GB;
 	prop->dram_end_address = prop->dram_base_address +
@@ -6263,44 +6267,6 @@ static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 	return gaudi_cq_assignment[cq_idx];
 }
 
-static void gaudi_ext_queue_init(struct hl_device *hdev, u32 q_idx)
-{
-	struct gaudi_device *gaudi = hdev->asic_specific;
-	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
-	struct hl_hw_sob *hw_sob;
-	int sob, ext_idx = gaudi->ext_queue_idx++;
-
-	/*
-	 * The external queues might not sit sequentially, hence use the
-	 * real external queue index for the SOB/MON base id.
-	 */
-	hw_queue->base_sob_id = ext_idx * HL_RSVD_SOBS;
-	hw_queue->base_mon_id = ext_idx * HL_RSVD_MONS;
-	hw_queue->next_sob_val = 1;
-	hw_queue->curr_sob_offset = 0;
-
-	for (sob = 0 ; sob < HL_RSVD_SOBS ; sob++) {
-		hw_sob = &hw_queue->hw_sob[sob];
-		hw_sob->hdev = hdev;
-		hw_sob->sob_id = hw_queue->base_sob_id + sob;
-		hw_sob->q_idx = q_idx;
-		kref_init(&hw_sob->kref);
-	}
-}
-
-static void gaudi_ext_queue_reset(struct hl_device *hdev, u32 q_idx)
-{
-	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
-
-	/*
-	 * In case we got here due to a stuck CS, the refcnt might be bigger
-	 * than 1 and therefore we reset it.
-	 */
-	kref_init(&hw_queue->hw_sob[hw_queue->curr_sob_offset].kref);
-	hw_queue->curr_sob_offset = 0;
-	hw_queue->next_sob_val = 1;
-}
-
 static u32 gaudi_get_signal_cb_size(struct hl_device *hdev)
 {
 	return sizeof(struct packet_msg_short) +
@@ -6603,8 +6569,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.read_device_fw_version = gaudi_read_device_fw_version,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
-	.ext_queue_init = gaudi_ext_queue_init,
-	.ext_queue_reset = gaudi_ext_queue_reset,
 	.get_signal_cb_size = gaudi_get_signal_cb_size,
 	.get_wait_cb_size = gaudi_get_wait_cb_size,
 	.gen_signal_cb = gaudi_gen_signal_cb,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 76c3f840e05a..8c654711d543 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -234,7 +234,6 @@ struct gaudi_internal_qman_info {
  *                      engine.
  * @multi_msi_mode: whether we are working in multi MSI single MSI mode.
  *                  Multi MSI is possible only with IOMMU enabled.
- * @ext_queue_idx: helper index for external queues initialization.
  */
 struct gaudi_device {
 	int (*armcp_info_get)(struct hl_device *hdev);
@@ -253,7 +252,6 @@ struct gaudi_device {
 	u32				events_stat_aggregate[GAUDI_EVENT_SIZE];
 	u32				hw_cap_initialized;
 	u8				multi_msi_mode;
-	u8				ext_queue_idx;
 };
 
 void gaudi_init_security(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e872099a3f7a..547fd766667a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5160,16 +5160,6 @@ u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 	return cq_idx;
 }
 
-static void goya_ext_queue_init(struct hl_device *hdev, u32 q_idx)
-{
-
-}
-
-static void goya_ext_queue_reset(struct hl_device *hdev, u32 q_idx)
-{
-
-}
-
 static u32 goya_get_signal_cb_size(struct hl_device *hdev)
 {
 	return 0;
@@ -5283,8 +5273,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.read_device_fw_version = goya_read_device_fw_version,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
-	.ext_queue_init = goya_ext_queue_init,
-	.ext_queue_reset = goya_ext_queue_reset,
 	.get_signal_cb_size = goya_get_signal_cb_size,
 	.get_wait_cb_size = goya_get_wait_cb_size,
 	.gen_signal_cb = goya_gen_signal_cb,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 64d9b2dd3e19..8cd4b55d0608 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -50,6 +50,10 @@
 /* MMU */
 #define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
+/*
+ * HL_RSVD_SOBS 'sync stream' reserved sync objects per QMAN stream
+ * HL_RSVD_MONS 'sync stream' reserved monitors per QMAN stream
+ */
 #define HL_RSVD_SOBS			4
 #define HL_RSVD_MONS			2
 
@@ -141,11 +145,13 @@ struct hl_hw_sob {
  *               false otherwise.
  * @requires_kernel_cb: true if a CB handle must be provided for jobs on this
  *                      queue, false otherwise (a CB address must be provided).
+ * @supports_sync_stream: True if queue supports sync stream
  */
 struct hw_queue_properties {
 	enum hl_queue_type	type;
 	u8			driver_only;
 	u8			requires_kernel_cb;
+	u8			supports_sync_stream;
 };
 
 /**
@@ -245,6 +251,9 @@ struct hl_mmu_properties {
  * @cb_pool_cb_cnt: number of CBs in the CB pool.
  * @cb_pool_cb_size: size of each CB in the CB pool.
  * @tpc_enabled_mask: which TPCs are enabled.
+ * @sync_stream_first_sob: first sync object available for sync stream use
+ * @sync_stream_first_mon: first monitor available for sync stream use
+ * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  */
 struct asic_fixed_properties {
@@ -286,6 +295,8 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_cnt;
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
+	u16				sync_stream_first_sob;
+	u16				sync_stream_first_mon;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 };
@@ -423,6 +434,7 @@ struct hl_cs_job;
  *         exist).
  * @curr_sob_offset: the id offset to the currently used SOB from the
  *                   HL_RSVD_SOBS that are being used by this queue.
+ * @supports_sync_stream: True if queue supports sync stream
  */
 struct hl_hw_queue {
 	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
@@ -441,6 +453,7 @@ struct hl_hw_queue {
 	u16			base_mon_id;
 	u8			valid;
 	u8			curr_sob_offset;
+	u8			supports_sync_stream;
 };
 
 /**
@@ -603,8 +616,6 @@ enum hl_pll_frequency {
  *                          contained in registers
  * @load_firmware_to_device: load the firmware to the device's memory
  * @load_boot_fit_to_device: load boot fit to device's memory
- * @ext_queue_init: Initialize the given external queue.
- * @ext_queue_reset: Reset the given external queue.
  * @get_signal_cb_size: Get signal CB size.
  * @get_wait_cb_size: Get wait CB size.
  * @gen_signal_cb: Generate a signal CB.
@@ -707,8 +718,6 @@ struct hl_asic_funcs {
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
-	void (*ext_queue_init)(struct hl_device *hdev, u32 hw_queue_id);
-	void (*ext_queue_reset)(struct hl_device *hdev, u32 hw_queue_id);
 	u32 (*get_signal_cb_size)(struct hl_device *hdev);
 	u32 (*get_wait_cb_size)(struct hl_device *hdev);
 	void (*gen_signal_cb)(struct hl_device *hdev, void *data, u16 sob_id);
@@ -1436,6 +1445,7 @@ struct hl_device_idle_busy_ts {
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
  * @stop_on_err: true if engines should stop on error.
  * @supports_sync_stream: is sync stream supported.
+ * @sync_stream_queue_idx: helper index for sync stream queues initialization.
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
  */
@@ -1523,6 +1533,7 @@ struct hl_device {
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
 	u8				supports_sync_stream;
+	u8				sync_stream_queue_idx;
 	u8				supports_coresight;
 	u8				supports_soft_reset;
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 29b96d24edc2..a8fa8021c617 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -663,9 +663,6 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	q->ci = 0;
 	q->pi = 0;
 
-	if (!is_cpu_queue)
-		hdev->asic_funcs->ext_queue_init(hdev, q->hw_queue_id);
-
 	return 0;
 
 free_queue:
@@ -732,6 +729,42 @@ static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 	return 0;
 }
 
+static void sync_stream_queue_init(struct hl_device *hdev, u32 q_idx)
+{
+	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_hw_sob *hw_sob;
+	int sob, queue_idx = hdev->sync_stream_queue_idx++;
+
+	hw_queue->base_sob_id =
+		prop->sync_stream_first_sob + queue_idx * HL_RSVD_SOBS;
+	hw_queue->base_mon_id =
+		prop->sync_stream_first_mon + queue_idx * HL_RSVD_MONS;
+	hw_queue->next_sob_val = 1;
+	hw_queue->curr_sob_offset = 0;
+
+	for (sob = 0 ; sob < HL_RSVD_SOBS ; sob++) {
+		hw_sob = &hw_queue->hw_sob[sob];
+		hw_sob->hdev = hdev;
+		hw_sob->sob_id = hw_queue->base_sob_id + sob;
+		hw_sob->q_idx = q_idx;
+		kref_init(&hw_sob->kref);
+	}
+}
+
+void sync_stream_queue_reset(struct hl_device *hdev, u32 q_idx)
+{
+	struct hl_hw_queue *hw_queue = &hdev->kernel_queues[q_idx];
+
+	/*
+	 * In case we got here due to a stuck CS, the refcnt might be bigger
+	 * than 1 and therefore we reset it.
+	 */
+	kref_init(&hw_queue->hw_sob[hw_queue->curr_sob_offset].kref);
+	hw_queue->curr_sob_offset = 0;
+	hw_queue->next_sob_val = 1;
+}
+
 /*
  * queue_init - main initialization function for H/W queue object
  *
@@ -774,6 +807,9 @@ static int queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 		break;
 	}
 
+	if (q->supports_sync_stream)
+		sync_stream_queue_init(hdev, q->hw_queue_id);
+
 	if (rc)
 		return rc;
 
@@ -848,6 +884,8 @@ int hl_hw_queues_create(struct hl_device *hdev)
 			i < HL_MAX_QUEUES ; i++, q_ready_cnt++, q++) {
 
 		q->queue_type = asic->hw_queues_props[i].type;
+		q->supports_sync_stream =
+				asic->hw_queues_props[i].supports_sync_stream;
 		rc = queue_init(hdev, q, i);
 		if (rc) {
 			dev_err(hdev->dev,
@@ -889,7 +927,7 @@ void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset)
 			continue;
 		q->pi = q->ci = 0;
 
-		if (q->queue_type == QUEUE_TYPE_EXT)
-			hdev->asic_funcs->ext_queue_reset(hdev, q->hw_queue_id);
+		if (q->supports_sync_stream)
+			sync_stream_queue_reset(hdev, q->hw_queue_id);
 	}
 }
-- 
2.17.1

