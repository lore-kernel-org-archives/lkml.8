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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078EBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F5F20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3f15FVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGENN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgGENNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:13:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A92C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:13:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g10so13839182wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9hbQYy5L/6ntF49D1+U8Ej3rAGjVSAQ9ebEHmCBBmM=;
        b=h3f15FVTaGXL2CamNypgAzhOt8fg6KEoK0s8owSZVzHEa7LKwBUBCIJPm069H30HzG
         H1UJWFCWKFdQxvBH4ij5Z4suFmNXwIJPib/2eD+ATgdbg7RJF+8mZZF1m01XNultgucy
         C316flNOnfiQkwTgltKKU0xI12lh/vXLtA2I/uLN9v7SzamE7Qm1e0t0XspQ31RiBd3o
         xirDf2gvXItiNTI3PnWsX+9B2fzgIHDNAfnVOJ5HnUxeolsP/RISOeJ/L60crTJVDeJw
         bVWBpa/6hCfbrVg9uFmw4jq2evwl1njAI4648OXUbtJwwgXtChN4Jc9/OKnM6nbB1cqz
         OIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9hbQYy5L/6ntF49D1+U8Ej3rAGjVSAQ9ebEHmCBBmM=;
        b=hSb1OtRsCpsYg5akktIEpyNqSd0HT5p3f5YwGeJtXoWiPu1pm3bcv5RfyaSSDO5m+B
         tNmmiK2mHK8xTapjtwDVij0KyO+oxrLrzEX+8+1i8fs2CF656QAEbDpaJcPPORrrt1Fw
         lKYZZA4VW8k9FZOI7Lv1C4hIkVzGxeZI9tE4r432O2Zyxv0QoHeXwc0UA7bnJrTKlgN/
         3N2c0SznEIENYE352lUwI2Zy9cNupIKx8B9NI3jZtYRGlrPdCMKAUlLFgfPzoYPMFGQn
         qYkKjfWRqv5axsLYvX2+dIRsYb8QUoOYMciy6lwpY5QLJqXkG2JioW8gQwl7hDbywxKN
         pFuA==
X-Gm-Message-State: AOAM530ueNkEFBrj7p54K+8HsRvqJrDnnqj9P1mc5nkxTBFxExABnnHh
        ckelywXtOmq3f9PK8c/zXwc07sKD
X-Google-Smtp-Source: ABdhPJwLFKv/JmNQNQVf5ngutBZX1ZSnBftHNpnkmp6frdtUMaakVzZLDnfUnMoFFSAyQkDmtaO+kg==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr44957808wma.100.1593954780384;
        Sun, 05 Jul 2020 06:13:00 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:59 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 9/9] habanalabs: use queue pi/ci in order to determine queue occupancy
Date:   Sun,  5 Jul 2020 16:12:45 +0300
Message-Id: <20200705131245.9368-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Instead of using the free slots amount on the compute CQ to determine
whether we can submit work to queues, use the queues pi/ci.

This is needed in future ASICs where we don't have CQ per queue.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c     | 17 +++---
 drivers/misc/habanalabs/habanalabs.h |  2 +-
 drivers/misc/habanalabs/hw_queue.c   | 82 +++++++++-------------------
 drivers/misc/habanalabs/irq.c        |  7 +--
 4 files changed, 39 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 2b38a119704c..65a5a5c52a48 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1144,14 +1144,17 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	 * because there the addresses of the completion queues are being
 	 * passed as arguments to request_irq
 	 */
-	hdev->completion_queue = kcalloc(cq_cnt,
-						sizeof(*hdev->completion_queue),
-						GFP_KERNEL);
+	if (cq_cnt) {
+		hdev->completion_queue = kcalloc(cq_cnt,
+				sizeof(*hdev->completion_queue),
+				GFP_KERNEL);
 
-	if (!hdev->completion_queue) {
-		dev_err(hdev->dev, "failed to allocate completion queues\n");
-		rc = -ENOMEM;
-		goto hw_queues_destroy;
+		if (!hdev->completion_queue) {
+			dev_err(hdev->dev,
+				"failed to allocate completion queues\n");
+			rc = -ENOMEM;
+			goto hw_queues_destroy;
+		}
 	}
 
 	for (i = 0, cq_ready_cnt = 0 ; i < cq_cnt ; i++, cq_ready_cnt++) {
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 9213d107b533..a61aab09778c 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -461,7 +461,7 @@ struct hl_hw_queue {
 	u64			kernel_address;
 	dma_addr_t		bus_address;
 	u32			pi;
-	u32			ci;
+	atomic_t		ci;
 	u32			hw_queue_id;
 	u32			cq_id;
 	u32			msi_vec;
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 7965551587fc..474a0e8a7797 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -23,10 +23,14 @@ inline u32 hl_hw_queue_add_ptr(u32 ptr, u16 val)
 	ptr &= ((HL_QUEUE_LENGTH << 1) - 1);
 	return ptr;
 }
+static inline int queue_ci_get(atomic_t *ci, u32 queue_len)
+{
+	return atomic_read(ci) & ((queue_len << 1) - 1);
+}
 
 static inline int queue_free_slots(struct hl_hw_queue *q, u32 queue_len)
 {
-	int delta = (q->pi - q->ci);
+	int delta = (q->pi - queue_ci_get(&q->ci, queue_len));
 
 	if (delta >= 0)
 		return (queue_len - delta);
@@ -40,21 +44,14 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
 	struct hl_hw_queue *q;
 	int i;
 
-	hdev->asic_funcs->hw_queues_lock(hdev);
-
 	if (hdev->disabled)
-		goto out;
+		return;
 
 	q = &hdev->kernel_queues[0];
 	for (i = 0 ; i < hdev->asic_prop.max_queues ; i++, q++) {
-		if (q->queue_type == QUEUE_TYPE_INT) {
-			q->ci += cs->jobs_in_queue_cnt[i];
-			q->ci &= ((q->int_queue_len << 1) - 1);
-		}
+		if (q->queue_type == QUEUE_TYPE_INT)
+			atomic_add(cs->jobs_in_queue_cnt[i], &q->ci);
 	}
-
-out:
-	hdev->asic_funcs->hw_queues_unlock(hdev);
 }
 
 /*
@@ -174,38 +171,26 @@ static int int_queue_sanity_checks(struct hl_device *hdev,
 }
 
 /*
- * hw_queue_sanity_checks() - Perform some sanity checks on a H/W queue.
+ * hw_queue_sanity_checks() - Make sure we have enough space in the h/w queue
  * @hdev: Pointer to hl_device structure.
  * @q: Pointer to hl_hw_queue structure.
  * @num_of_entries: How many entries to check for space.
  *
- * Perform the following:
- * - Make sure we have enough space in the completion queue.
- *   This check also ensures that there is enough space in the h/w queue, as
- *   both queues are of the same size.
- * - Reserve space in the completion queue (needs to be reversed if there
- *   is a failure down the road before the actual submission of work).
+ * Notice: We do not reserve queue entries so this function mustn't be called
+ *         more than once per CS for the same queue
  *
- * Both operations are done using the "free_slots_cnt" field of the completion
- * queue. The CI counters of the queue and the completion queue are not
- * needed/used for the H/W queue type.
  */
 static int hw_queue_sanity_checks(struct hl_device *hdev, struct hl_hw_queue *q,
 					int num_of_entries)
 {
-	atomic_t *free_slots =
-			&hdev->completion_queue[q->cq_id].free_slots_cnt;
+	int free_slots_cnt;
 
-	/*
-	 * Check we have enough space in the completion queue.
-	 * Add -1 to counter (decrement) unless counter was already 0.
-	 * In that case, CQ is full so we can't submit a new CB.
-	 * atomic_add_unless will return 0 if counter was already 0.
-	 */
-	if (atomic_add_negative(num_of_entries * -1, free_slots)) {
-		dev_dbg(hdev->dev, "No space for %d entries on CQ %d\n",
-			num_of_entries, q->hw_queue_id);
-		atomic_add(num_of_entries, free_slots);
+	/* Check we have enough space in the queue */
+	free_slots_cnt = queue_free_slots(q, HL_QUEUE_LENGTH);
+
+	if (free_slots_cnt < num_of_entries) {
+		dev_dbg(hdev->dev, "Queue %d doesn't have room for %d CBs\n",
+			q->hw_queue_id, num_of_entries);
 		return -EAGAIN;
 	}
 
@@ -366,7 +351,6 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 {
 	struct hl_device *hdev = job->cs->ctx->hdev;
 	struct hl_hw_queue *q = &hdev->kernel_queues[job->hw_queue_id];
-	struct hl_cq *cq;
 	u64 ptr;
 	u32 offset, ctl, len;
 
@@ -395,17 +379,6 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	else
 		ptr = (u64) (uintptr_t) job->user_cb;
 
-	/*
-	 * No need to protect pi_offset because scheduling to the
-	 * H/W queues is done under the scheduler mutex
-	 *
-	 * No need to check if CQ is full because it was already
-	 * checked in hw_queue_sanity_checks
-	 */
-	cq = &hdev->completion_queue[q->cq_id];
-
-	cq->pi = hl_cq_inc_ptr(cq->pi);
-
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
 
@@ -552,8 +525,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 				goto unroll_cq_resv;
 			}
 
-			if (q->queue_type == QUEUE_TYPE_EXT ||
-					q->queue_type == QUEUE_TYPE_HW)
+			if (q->queue_type == QUEUE_TYPE_EXT)
 				cq_cnt++;
 		}
 	}
@@ -605,9 +577,8 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 unroll_cq_resv:
 	q = &hdev->kernel_queues[0];
 	for (i = 0 ; (i < max_queues) && (cq_cnt > 0) ; i++, q++) {
-		if ((q->queue_type == QUEUE_TYPE_EXT ||
-				q->queue_type == QUEUE_TYPE_HW) &&
-				cs->jobs_in_queue_cnt[i]) {
+		if ((q->queue_type == QUEUE_TYPE_EXT) &&
+						(cs->jobs_in_queue_cnt[i])) {
 			atomic_t *free_slots =
 				&hdev->completion_queue[i].free_slots_cnt;
 			atomic_add(cs->jobs_in_queue_cnt[i], free_slots);
@@ -631,7 +602,7 @@ void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id)
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[hw_queue_id];
 
-	q->ci = hl_queue_inc_ptr(q->ci);
+	atomic_inc(&q->ci);
 }
 
 static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
@@ -666,7 +637,7 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	}
 
 	/* Make sure read/write pointers are initialized to start of queue */
-	q->ci = 0;
+	atomic_set(&q->ci, 0);
 	q->pi = 0;
 
 	return 0;
@@ -700,7 +671,7 @@ static int int_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 
 	q->kernel_address = (u64) (uintptr_t) p;
 	q->pi = 0;
-	q->ci = 0;
+	atomic_set(&q->ci, 0);
 
 	return 0;
 }
@@ -729,7 +700,7 @@ static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 	q->kernel_address = (u64) (uintptr_t) p;
 
 	/* Make sure read/write pointers are initialized to start of queue */
-	q->ci = 0;
+	atomic_set(&q->ci, 0);
 	q->pi = 0;
 
 	return 0;
@@ -931,7 +902,8 @@ void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset)
 		if ((!q->valid) ||
 			((!hard_reset) && (q->queue_type == QUEUE_TYPE_CPU)))
 			continue;
-		q->pi = q->ci = 0;
+		q->pi = 0;
+		atomic_set(&q->ci, 0);
 
 		if (q->supports_sync_stream)
 			sync_stream_queue_reset(hdev, q->hw_queue_id);
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 7a4878edb1a3..195a5ecba0e8 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -122,12 +122,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 			queue_work(hdev->cq_wq, &job->finish_work);
 		}
 
-		/* Update ci of the context's queue. There is no
-		 * need to protect it with spinlock because this update is
-		 * done only inside IRQ and there is a different IRQ per
-		 * queue
-		 */
-		queue->ci = hl_queue_inc_ptr(queue->ci);
+		atomic_inc(&queue->ci);
 
 		/* Clear CQ entry ready bit */
 		cq_entry->data = cpu_to_le32(le32_to_cpu(cq_entry->data) &
-- 
2.17.1

