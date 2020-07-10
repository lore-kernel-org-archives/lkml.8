Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE04D2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ0M5TLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGJRgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:36:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE0C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so6698658wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDWqWzY09ZxiWlOD/uoEl2bbF7qQmNSTVsWjPpUm1Lo=;
        b=oQ0M5TLLjJGtEW0sXxcPltfr+7sJ0AoYufwRx/8Z6a3+l+ytQCbx0cuhfJp3XCt+Mc
         KUZEj7zLPXaKONFru0A5/BVAbTp2ua33Do3xvnCMUyAutRwRaKAQndD9xZQOCT/QTFhX
         jHQOdaJil0i1zh9mgik/KrF0mJTt7rsCUZW88HUPvWAxRbje9g3va646a2ifUl57zNa4
         U6C/qCuizkg8P8eJ/jeE87yp7ukCYAR1U9mLPCUbFxy5Bv6/i89QA+9AqqHF0tDw+Qfp
         GqNcsiEHAWIXjx57VEmvj/l/vjxcGHMjysfIBIh6qyk4tZ94GgJXFrODZzqpRXaU/kP/
         fL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDWqWzY09ZxiWlOD/uoEl2bbF7qQmNSTVsWjPpUm1Lo=;
        b=dipNMIZSCeh1SfZ+9l/mrM+uLwCiS4HJi/Hjt+HF7PEIXsLZ+7xJj5ihAK1F6d42iG
         ViqTAbqXutJPBZ0AqpIrZ67WnE6/tq4c8M9WXXQouiT51rEg4xH1gzFISK5Yj3dNhMR/
         kICrt8dE3QkYj+uigFuvGR9eJaW7h55AUPtXnxwP8OlvtDGjzwIRlWatxAoJzIR4tBJT
         PSAZo6WXNmtiEwnkL8wxXENcgDlGfJEHznsF8MLoY3nzJOPNSJWSb/YFWnmvxerk8Im3
         yXinYfO7i+62F7OjAtvDeIMNAgFSZAgJ54EZGLLDb3qg1bYO3QoFl20gvzCyZY/Lv21p
         8h2w==
X-Gm-Message-State: AOAM531MkBgODR7r+dzGI55YCGZG4fALYjBBsi5YvxYg5aBtH+ct0ji5
        JVtYMLjgfZhNbucQQwbkY3Z0ZHiZ
X-Google-Smtp-Source: ABdhPJyeJsje3iS8CsZXQkywgJOD2W9DIN7xHvBonJqBCGGtwlgWyeN+FoD5Oxoa+/vKP8sfP8wqBQ==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr6163033wml.170.1594402612130;
        Fri, 10 Jul 2020 10:36:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n16sm9903857wmc.40.2020.07.10.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:36:51 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs: Assign each CQ with its own work queue
Date:   Fri, 10 Jul 2020 20:36:50 +0300
Message-Id: <20200710173652.31039-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710173652.31039-1-oded.gabbay@gmail.com>
References: <20200710173652.31039-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We identified a possible race during job completion when working
with a single multi-threaded work queue. In order to overcome this
race we suggest using a single threaded work queue per completion
queue, hence we guarantee jobs completion in order.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  4 +-
 drivers/misc/habanalabs/device.c             | 39 ++++++++++++++++----
 drivers/misc/habanalabs/habanalabs.h         |  7 +++-
 drivers/misc/habanalabs/irq.c                |  2 +-
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 1ba937b9a22e..54f2f5afdd2a 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -487,10 +487,12 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 
 void hl_cs_rollback_all(struct hl_device *hdev)
 {
+	int i;
 	struct hl_cs *cs, *tmp;
 
 	/* flush all completions */
-	flush_workqueue(hdev->cq_wq);
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		flush_workqueue(hdev->cq_wq[i]);
 
 	/* Make sure we don't have leftovers in the H/W queues mirror list */
 	list_for_each_entry_safe(cs, tmp, &hdev->hw_queues_mirror_list,
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index df709767c7ea..84800efec10d 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -249,7 +249,8 @@ static void device_cdev_sysfs_del(struct hl_device *hdev)
  */
 static int device_early_init(struct hl_device *hdev)
 {
-	int rc;
+	int i, rc;
+	char workq_name[32];
 
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
@@ -274,11 +275,24 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto early_fini;
 
-	hdev->cq_wq = alloc_workqueue("hl-free-jobs", WQ_UNBOUND, 0);
-	if (hdev->cq_wq == NULL) {
-		dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
-		rc = -ENOMEM;
-		goto asid_fini;
+	if (hdev->asic_prop.completion_queues_count) {
+		hdev->cq_wq = kcalloc(hdev->asic_prop.completion_queues_count,
+				sizeof(*hdev->cq_wq),
+				GFP_ATOMIC);
+		if (!hdev->cq_wq) {
+			rc = -ENOMEM;
+			goto asid_fini;
+		}
+	}
+
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
+		snprintf(workq_name, 32, "hl-free-jobs-%u", i);
+		hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
+		if (hdev->cq_wq == NULL) {
+			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
+			rc = -ENOMEM;
+			goto free_cq_wq;
+		}
 	}
 
 	hdev->eq_wq = alloc_workqueue("hl-events", WQ_UNBOUND, 0);
@@ -321,7 +335,10 @@ static int device_early_init(struct hl_device *hdev)
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
-	destroy_workqueue(hdev->cq_wq);
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		if (hdev->cq_wq[i])
+			destroy_workqueue(hdev->cq_wq[i]);
+	kfree(hdev->cq_wq);
 asid_fini:
 	hl_asid_fini(hdev);
 early_fini:
@@ -339,6 +356,8 @@ static int device_early_init(struct hl_device *hdev)
  */
 static void device_early_fini(struct hl_device *hdev)
 {
+	int i;
+
 	mutex_destroy(&hdev->mmu_cache_lock);
 	mutex_destroy(&hdev->debug_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
@@ -351,7 +370,10 @@ static void device_early_fini(struct hl_device *hdev)
 	kfree(hdev->hl_chip_info);
 
 	destroy_workqueue(hdev->eq_wq);
-	destroy_workqueue(hdev->cq_wq);
+
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		destroy_workqueue(hdev->cq_wq[i]);
+	kfree(hdev->cq_wq);
 
 	hl_asid_fini(hdev);
 
@@ -1181,6 +1203,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 				"failed to initialize completion queue\n");
 			goto cq_fini;
 		}
+		hdev->completion_queue[i].cq_idx = i;
 	}
 
 	/*
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index ea0fd178accb..01fb45887a5a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -479,6 +479,7 @@ struct hl_hw_queue {
  * @hdev: pointer to the device structure
  * @kernel_address: holds the queue's kernel virtual address
  * @bus_address: holds the queue's DMA address
+ * @cq_idx: completion queue index in array
  * @hw_queue_id: the id of the matching H/W queue
  * @ci: ci inside the queue
  * @pi: pi inside the queue
@@ -488,6 +489,7 @@ struct hl_cq {
 	struct hl_device	*hdev;
 	u64			kernel_address;
 	dma_addr_t		bus_address;
+	u32			cq_idx;
 	u32			hw_queue_id;
 	u32			ci;
 	u32			pi;
@@ -1396,7 +1398,8 @@ struct hl_device_idle_busy_ts {
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
- * @cq_wq: work queue of completion queues for executing work in process context
+ * @cq_wq: work queues of completion queues for executing work in process
+ *         context.
  * @eq_wq: work queue of event queue for executing work in process context.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
@@ -1492,7 +1495,7 @@ struct hl_device {
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
-	struct workqueue_struct		*cq_wq;
+	struct workqueue_struct		**cq_wq;
 	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 195a5ecba0e8..c8db717023f5 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -119,7 +119,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 
 		if ((shadow_index_valid) && (!hdev->disabled)) {
 			job = queue->shadow_queue[hl_pi_2_offset(shadow_index)];
-			queue_work(hdev->cq_wq, &job->finish_work);
+			queue_work(hdev->cq_wq[cq->cq_idx], &job->finish_work);
 		}
 
 		atomic_inc(&queue->ci);
-- 
2.17.1

