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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E85DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B122075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjJPO+MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGENN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGENMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A2C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so36332707wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9QHvp8CJ5oVj5mR5mC5jinLDq3jS8NgJRJZvh1W4uh8=;
        b=AjJPO+MVFPsr59alCN0Tk7c3ZZo4/owsw811lc/tI8Tk8TijeFiM7GLYPVfcAQ0+Xd
         hNLP4H1XseAThr+cKSMNjmOWRnOmkpYKAD1wju1BF+Vs6DXx4huvnPx+Up8zLsQ5gDxr
         09zbKsBLvrUAeKv4VRPR/yUU2558IjQ97Z4sNpMW2lKIn8Kqrbtwhf3bhrqDBfn2h77o
         JC6+Nv8m1cHu1qCa3++Pt0OXDkxsdIa6xtGU23fezCqMdqVOeYm8qAx19WsbtgX9q+6l
         MpSH2F5U1Ub/SaZf2wZWQYLCcbjHlVtTOStExysjIg/ldH1/x/ieZfaILPqMpV+0YxKV
         SauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9QHvp8CJ5oVj5mR5mC5jinLDq3jS8NgJRJZvh1W4uh8=;
        b=XWBZEYjRsuRtD83lw+49gEGrhPZuxP0rd8vd8e6uv0I8tXHVLos25Oz7eXeNVeP27m
         57aVmz0HZpAXCVDrk9QzQ4HSXgBxTk9kqpQC+0rXubLD0711wwUqipSChGmAWOJIa7KS
         0GwEkgIE2DB7WObmitrMcIYESz9TYJLQ3FRgXkHRYNWfjaZHh+cNicrjmFBqaOtZ1q0d
         zrIaBlT0yaYNnrXWuX+mQ0JjQfPHGsLV6Pulu3fkiBYPZlDx0lCE3IMxog6YeChziU4/
         4vu6LmXfOv+QjkJ3v0n2Efzd9xitFoRCJTkOcGA+qUcb24lENucU9j6kG3kRkJqUAHxP
         BRAA==
X-Gm-Message-State: AOAM531s8xzS604YFbzdIRuGQhYe96YmZNFYmmnQvHNP6pPPlYDO7ZXU
        pT03oLDndl+1ZZQO7CastHFdzvBd
X-Google-Smtp-Source: ABdhPJxvitHv3SWFhI+CxCZVRUT3cWQJ2WI061DuKoZRl8OmF0404sC8d8wa9x7/w36WhwOLDotb1g==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr31422283wmb.147.1593954770018;
        Sun, 05 Jul 2020 06:12:50 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:49 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/9] habanalabs: Add dropped cs statistics info struct
Date:   Sun,  5 Jul 2020 16:12:40 +0300
Message-Id: <20200705131245.9368-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Add command submission statistics structure which can be obtained
through the info ioctl. Each drop counter describes the reason for
which the command submission was dropped.
This information is needed for the user to be aware of the specific
reason for which the submitted work was dropped. The user can then
utilize the driver more efficiently.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 24 +++++++++++++++++++-
 drivers/misc/habanalabs/habanalabs.h         |  5 ++++
 drivers/misc/habanalabs/habanalabs_ioctl.c   | 24 ++++++++++++++++++++
 drivers/misc/habanalabs/hw_queue.c           |  5 +++-
 include/uapi/misc/habanalabs.h               | 21 +++++++++++++++++
 5 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index f81d6685e011..777f88d25acd 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -246,6 +246,18 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	kfree(job);
 }
 
+static void cs_counters_aggregate(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	hdev->aggregated_cs_counters.device_in_reset_drop_cnt +=
+			ctx->cs_counters.device_in_reset_drop_cnt;
+	hdev->aggregated_cs_counters.out_of_mem_drop_cnt +=
+			ctx->cs_counters.out_of_mem_drop_cnt;
+	hdev->aggregated_cs_counters.parsing_drop_cnt +=
+			ctx->cs_counters.parsing_drop_cnt;
+	hdev->aggregated_cs_counters.queue_full_drop_cnt +=
+			ctx->cs_counters.queue_full_drop_cnt;
+}
+
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs,
@@ -349,6 +361,8 @@ static void cs_do_release(struct kref *ref)
 	dma_fence_signal(cs->fence);
 	dma_fence_put(cs->fence);
 
+	cs_counters_aggregate(hdev, cs->ctx);
+
 	kfree(cs);
 }
 
@@ -632,12 +646,15 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 		rc = validate_queue_index(hdev, chunk, &queue_type,
 						&is_kernel_allocated_cb);
-		if (rc)
+		if (rc) {
+			hpriv->ctx->cs_counters.parsing_drop_cnt++;
 			goto free_cs_object;
+		}
 
 		if (is_kernel_allocated_cb) {
 			cb = get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
 			if (!cb) {
+				hpriv->ctx->cs_counters.parsing_drop_cnt++;
 				rc = -EINVAL;
 				goto free_cs_object;
 			}
@@ -651,6 +668,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		job = hl_cs_allocate_job(hdev, queue_type,
 						is_kernel_allocated_cb);
 		if (!job) {
+			hpriv->ctx->cs_counters.out_of_mem_drop_cnt++;
 			dev_err(hdev->dev, "Failed to allocate a new job\n");
 			rc = -ENOMEM;
 			if (is_kernel_allocated_cb)
@@ -683,6 +701,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 		rc = cs_parser(hpriv, job);
 		if (rc) {
+			hpriv->ctx->cs_counters.parsing_drop_cnt++;
 			dev_err(hdev->dev,
 				"Failed to parse JOB %d.%llu.%d, err %d, rejecting the CS\n",
 				cs->ctx->asid, cs->sequence, job->id, rc);
@@ -691,6 +710,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	}
 
 	if (int_queues_only) {
+		hpriv->ctx->cs_counters.parsing_drop_cnt++;
 		dev_err(hdev->dev,
 			"Reject CS %d.%llu because only internal queues jobs are present\n",
 			cs->ctx->asid, cs->sequence);
@@ -875,6 +895,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	job = hl_cs_allocate_job(hdev, q_type, true);
 	if (!job) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
 		dev_err(hdev->dev, "Failed to allocate a new job\n");
 		rc = -ENOMEM;
 		goto put_cs;
@@ -882,6 +903,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
 	if (!cb) {
+		ctx->cs_counters.out_of_mem_drop_cnt++;
 		kfree(job);
 		rc = -EFAULT;
 		goto put_cs;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index e4d6f7c91194..ae781453a509 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -10,6 +10,7 @@
 
 #include "include/armcp_if.h"
 #include "include/qman_if.h"
+#include <uapi/misc/habanalabs.h>
 
 #include <linux/cdev.h>
 #include <linux/iopoll.h>
@@ -787,6 +788,7 @@ struct hl_ctx {
 	struct mutex		mem_hash_lock;
 	struct mutex		mmu_lock;
 	struct list_head	debugfs_list;
+	struct hl_cs_counters	cs_counters;
 	u64			cs_sequence;
 	u64			*dram_default_hops;
 	spinlock_t		cs_lock;
@@ -1391,6 +1393,7 @@ struct hl_device_idle_busy_ts {
  * @compute_ctx: current compute context executing.
  * @idle_busy_ts_arr: array to hold time stamps of transitions from idle to busy
  *                    and vice-versa
+ * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -1489,6 +1492,8 @@ struct hl_device {
 
 	struct hl_device_idle_busy_ts	*idle_busy_ts_arr;
 
+	struct hl_cs_counters		aggregated_cs_counters;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 52eedd3a6c3a..5af1c03da473 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -276,6 +276,27 @@ static int time_sync_info(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(time_sync))) ? -EFAULT : 0;
 }
 
+static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_info_cs_counters cs_counters = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	memcpy(&cs_counters.cs_counters, &hdev->aggregated_cs_counters,
+			sizeof(struct hl_cs_counters));
+
+	if (hpriv->ctx)
+		memcpy(&cs_counters.ctx_cs_counters, &hpriv->ctx->cs_counters,
+				sizeof(struct hl_cs_counters));
+
+	return copy_to_user(out, &cs_counters,
+		min((size_t) max_size, sizeof(cs_counters))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -336,6 +357,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_TIME_SYNC:
 		return time_sync_info(hdev, args);
 
+	case HL_INFO_CS_COUNTERS:
+		return cs_counters_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index f5a10a5ac300..da66ffb528f8 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -514,6 +514,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
+		ctx->cs_counters.device_in_reset_drop_cnt++;
 		dev_err(hdev->dev,
 			"device is disabled or in reset, CS rejected!\n");
 		rc = -EPERM;
@@ -543,8 +544,10 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 				break;
 			}
 
-			if (rc)
+			if (rc) {
+				ctx->cs_counters.queue_full_drop_cnt++;
 				goto unroll_cq_resv;
+			}
 
 			if (q->queue_type == QUEUE_TYPE_EXT ||
 					q->queue_type == QUEUE_TYPE_HW)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index f218d1c62c62..d5c4f983b7a8 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -263,6 +263,7 @@ enum hl_device_status {
  *                         time the driver was loaded.
  * HL_INFO_TIME_SYNC     - Retrieve the device's time alongside the host's time
  *                         for synchronization.
+ * HL_INFO_CS_COUNTERS   - Retrieve command submission counters
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -274,6 +275,7 @@ enum hl_device_status {
 #define HL_INFO_CLK_RATE		8
 #define HL_INFO_RESET_COUNT		9
 #define HL_INFO_TIME_SYNC		10
+#define HL_INFO_CS_COUNTERS		11
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -338,6 +340,25 @@ struct hl_info_time_sync {
 	__u64 host_time;
 };
 
+/**
+ * struct hl_info_cs_counters - command submission counters
+ * @out_of_mem_drop_cnt: dropped due to memory allocation issue
+ * @parsing_drop_cnt: dropped due to error in packet parsing
+ * @queue_full_drop_cnt: dropped due to queue full
+ * @device_in_reset_drop_cnt: dropped due to device in reset
+ */
+struct hl_cs_counters {
+	__u64 out_of_mem_drop_cnt;
+	__u64 parsing_drop_cnt;
+	__u64 queue_full_drop_cnt;
+	__u64 device_in_reset_drop_cnt;
+};
+
+struct hl_info_cs_counters {
+	struct hl_cs_counters cs_counters;
+	struct hl_cs_counters ctx_cs_counters;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
-- 
2.17.1

