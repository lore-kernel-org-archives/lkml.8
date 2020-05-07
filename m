Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0799C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55412083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vac2FEAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEGOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgEGOhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:37:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8AC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:37:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so5363262wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XiPjyE6cTZ1ht5B7lJLcN8gL84SaxI5ZK4r5fPX+vHk=;
        b=vac2FEAFp6YD2EZD+YhpIPOA9weGU6wovv37UG7Wk1WKZeykdf7LnTmy2nS91tK7Rz
         Tp6Cy2LoK+y5P5ebY8stQ/SYr2SCK20K/OeATAACSlfxc7Zg+F9ExKoWQ9yxTgGwPs1N
         CgFXbLspdF5sZ0USBF8YHpfJhJf4poy3TPl/dCGH0Cn9q8lDEGnRJlWiMhy+Qj6vsahG
         aL87dpieao2tcI7t01BXLFWHfNvKNQu1I1cSiFfqBbmMy4xMOK8VrdTh3JdXXduky7vs
         ysnYYlMlIZlaWnL9b6Dq1FNhPAMuZWk+9KPhKRAcOje5dKfJ6qw6xAHFl69qXtFICC8s
         qiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XiPjyE6cTZ1ht5B7lJLcN8gL84SaxI5ZK4r5fPX+vHk=;
        b=qdJoDoC9NER5zZ5o+mpYT9s/N7HQ8efbTIlVWgKPqemcnsUYsK5Gw0SzPo9h2NiNYS
         dLsEuG4kjJVR2I1z0Gq9LfW9E5gPdB+ohQ2iGoVxnRMBXTgw7SlNwijYDxzILDFbxpVa
         TRajH8IKxRACxWO0z/hDMAxwXeFFLqOjc9TuPlOvwTK3CiCb1uqKgPv/oYCjV4qGVaT0
         thf9lR0Q/heUt7GsJ+pXTg6CZTChV5jyv8kPDj2ZIx5ZUlAowZjrqOngZpcCnRE9+2Jw
         VSFfgme44Rnp8g5nfYTlcPMd71OzFNPhSTlnFUX9Vo7BKlO/6T8ok4tbol+WL09d0tQJ
         Zo6A==
X-Gm-Message-State: AGi0Pubeu4o1jZDWiVmmJ4O6hYI1SjACWu7ExGpWm9OOYlS0QOQlM3mO
        KTxSRsY/ABi7+Nc6xRHf8ZYyrXwz
X-Google-Smtp-Source: APiQypJbx6wrXFlQW98D/u3CsjdqreGwM6wIKoJspqemz/OmO1y9x9voGml6GUDsczI1avszOnHQqQ==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr2208988wru.292.1588862232452;
        Thu, 07 May 2020 07:37:12 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm8808095wrw.63.2020.05.07.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:37:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/4] habanalabs: handle the h/w sync object
Date:   Thu,  7 May 2020 17:37:00 +0300
Message-Id: <20200507143701.32456-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507143701.32456-1-oded.gabbay@gmail.com>
References: <20200507143701.32456-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Define a structure representing the h/w sync object (SOB).

a SOB can contain up to 2^15 values. Each signal CS will increment the SOB
by 1, so after some time we will reach the maximum number the SOB can
represent. When that happens, the driver needs to move to a different SOB
for the signal operation.

A SOB can be in 1 of 4 states:

1. Working state with value < 2^15

2. We reached a value of 2^15, but the signal operations weren't completed
yet OR there are pending waits on this signal. For the next submission, the
driver will move to another SOB.

3. ALL the signal operations on the SOB have finished AND there are no more
pending waits on the SOB AND we reached a value of 2^15 (This basically
means the refcnt of the SOB is 0 - see explanation below). When that
happens, the driver can clear the SOB by simply doing WREG32 0 to it and
set the refcnt back to 1.

4. The SOB is cleared and can be used next time by the driver when it needs
to reuse an SOB.

Per SOB, the driver will maintain a single refcnt, that will be initialized
to 1. When a signal or wait operation on this SOB is submitted to the PQ,
the refcnt will be incremented. When a signal or wait operation on this SOB
completes, the refcnt will be decremented. After the submission of the
signal operation that increments the SOB to a value of 2^15, the refcnt is
also decremented.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  51 +++++----
 drivers/misc/habanalabs/habanalabs.h         |  57 +++++++++-
 drivers/misc/habanalabs/hw_queue.c           | 107 ++++++++++++++++++-
 3 files changed, 188 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index f7d03a35e6a8..a4211cfc752a 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -25,10 +25,10 @@ static const char *hl_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *hl_fence_get_timeline_name(struct dma_fence *fence)
 {
-	struct hl_dma_fence *hl_fence =
-		container_of(fence, struct hl_dma_fence, base_fence);
+	struct hl_cs_compl *hl_cs_compl =
+		container_of(fence, struct hl_cs_compl, base_fence);
 
-	return dev_name(hl_fence->hdev->dev);
+	return dev_name(hl_cs_compl->hdev->dev);
 }
 
 static bool hl_fence_enable_signaling(struct dma_fence *fence)
@@ -38,10 +38,10 @@ static bool hl_fence_enable_signaling(struct dma_fence *fence)
 
 static void hl_fence_release(struct dma_fence *fence)
 {
-	struct hl_dma_fence *hl_fence =
-		container_of(fence, struct hl_dma_fence, base_fence);
+	struct hl_cs_compl *hl_cs_cmpl =
+		container_of(fence, struct hl_cs_compl, base_fence);
 
-	kfree_rcu(hl_fence, base_fence.rcu);
+	kfree_rcu(hl_cs_cmpl, base_fence.rcu);
 }
 
 static const struct dma_fence_ops hl_fence_ops = {
@@ -189,6 +189,17 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	kfree(job);
 }
 
+void hl_sob_reset_error(struct kref *ref)
+{
+	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
+							kref);
+	struct hl_device *hdev = hw_sob->hdev;
+
+	dev_crit(hdev->dev,
+			"SOB release shouldn't be called here, q_idx: %d, sob_id: %d\n",
+			hw_sob->q_idx, hw_sob->sob_id);
+}
+
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs,
@@ -317,7 +328,7 @@ static void cs_timedout(struct work_struct *work)
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 			struct hl_cs **cs_new)
 {
-	struct hl_dma_fence *fence;
+	struct hl_cs_compl *cs_cmpl;
 	struct dma_fence *other = NULL;
 	struct hl_cs *cs;
 	int rc;
@@ -334,20 +345,20 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	kref_init(&cs->refcount);
 	spin_lock_init(&cs->job_lock);
 
-	fence = kmalloc(sizeof(*fence), GFP_ATOMIC);
-	if (!fence) {
+	cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_ATOMIC);
+	if (!cs_cmpl) {
 		rc = -ENOMEM;
 		goto free_cs;
 	}
 
-	fence->hdev = hdev;
-	spin_lock_init(&fence->lock);
-	cs->fence = &fence->base_fence;
+	cs_cmpl->hdev = hdev;
+	spin_lock_init(&cs_cmpl->lock);
+	cs->fence = &cs_cmpl->base_fence;
 
 	spin_lock(&ctx->cs_lock);
 
-	fence->cs_seq = ctx->cs_sequence;
-	other = ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)];
+	cs_cmpl->cs_seq = ctx->cs_sequence;
+	other = ctx->cs_pending[cs_cmpl->cs_seq & (HL_MAX_PENDING_CS - 1)];
 	if ((other) && (!dma_fence_is_signaled(other))) {
 		spin_unlock(&ctx->cs_lock);
 		dev_dbg(hdev->dev,
@@ -356,16 +367,16 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto free_fence;
 	}
 
-	dma_fence_init(&fence->base_fence, &hl_fence_ops, &fence->lock,
+	dma_fence_init(&cs_cmpl->base_fence, &hl_fence_ops, &cs_cmpl->lock,
 			ctx->asid, ctx->cs_sequence);
 
-	cs->sequence = fence->cs_seq;
+	cs->sequence = cs_cmpl->cs_seq;
 
-	ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)] =
-							&fence->base_fence;
+	ctx->cs_pending[cs_cmpl->cs_seq & (HL_MAX_PENDING_CS - 1)] =
+							&cs_cmpl->base_fence;
 	ctx->cs_sequence++;
 
-	dma_fence_get(&fence->base_fence);
+	dma_fence_get(&cs_cmpl->base_fence);
 
 	dma_fence_put(other);
 
@@ -376,7 +387,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	return 0;
 
 free_fence:
-	kfree(fence);
+	kfree(cs_cmpl);
 free_cs:
 	kfree(cs);
 	return rc;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index dd93cd903f91..630ed43eb410 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -51,6 +51,14 @@
 /* MMU */
 #define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
+#define HL_RSVD_SOBS			4
+#define HL_RSVD_MONS			2
+
+#define HL_RSVD_SOBS_IN_USE		2
+#define HL_RSVD_MONS_IN_USE		1
+
+#define HL_MAX_SOB_VAL			(1 << 15)
+
 /**
  * struct pgt_info - MMU hop page info.
  * @node: hash linked-list node for the pgts shadow hash of pgts.
@@ -104,6 +112,26 @@ enum hl_queue_type {
 	QUEUE_TYPE_HW
 };
 
+enum hl_cs_type {
+	CS_TYPE_DEFAULT,
+	CS_TYPE_SIGNAL,
+	CS_TYPE_WAIT
+};
+
+/*
+ * struct hl_hw_sob - H/W SOB info.
+ * @hdev: habanalabs device structure.
+ * @kref: refcount of this SOB. The SOB will reset once the refcount is zero.
+ * @sob_id: id of this SOB.
+ * @q_idx: the H/W queue that uses this SOB.
+ */
+struct hl_hw_sob {
+	struct hl_device	*hdev;
+	struct kref		kref;
+	u32			sob_id;
+	u32			q_idx;
+};
+
 /**
  * struct hw_queue_properties - queue information.
  * @type: queue type.
@@ -260,17 +288,23 @@ struct asic_fixed_properties {
 };
 
 /**
- * struct hl_dma_fence - wrapper for fence object used by command submissions.
+ * struct hl_cs_compl - command submission completion object.
  * @base_fence: kernel fence object.
  * @lock: spinlock to protect fence.
  * @hdev: habanalabs device structure.
+ * @hw_sob: the H/W SOB used in this signal/wait CS.
  * @cs_seq: command submission sequence number.
+ * @type: type of the CS - signal/wait.
+ * @sob_val: the SOB value that is used in this signal/wait CS.
  */
-struct hl_dma_fence {
+struct hl_cs_compl {
 	struct dma_fence	base_fence;
 	spinlock_t		lock;
 	struct hl_device	*hdev;
+	struct hl_hw_sob	*hw_sob;
 	u64			cs_seq;
+	enum hl_cs_type		type;
+	u16			sob_val;
 };
 
 /*
@@ -368,6 +402,7 @@ struct hl_cs_job;
 
 /**
  * struct hl_hw_queue - describes a H/W transport queue.
+ * @hw_sob: array of the used H/W SOBs by this H/W queue.
  * @shadow_queue: pointer to a shadow queue that holds pointers to jobs.
  * @queue_type: type of queue.
  * @kernel_address: holds the queue's kernel virtual address.
@@ -378,10 +413,16 @@ struct hl_cs_job;
  * @cq_id: the id for the corresponding CQ for this H/W queue.
  * @msi_vec: the IRQ number of the H/W queue.
  * @int_queue_len: length of internal queue (number of entries).
+ * @next_sob_val: the next value to use for the currently used SOB.
+ * @base_sob_id: the base SOB id of the SOBs used by this queue.
+ * @base_mon_id: the base MON id of the MONs used by this queue.
  * @valid: is the queue valid (we have array of 32 queues, not all of them
- *		exists).
+ *         exist).
+ * @curr_sob_offset: the id offset to the currently used SOB from the
+ *                   HL_RSVD_SOBS that are being used by this queue.
  */
 struct hl_hw_queue {
+	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
 	struct hl_cs_job	**shadow_queue;
 	enum hl_queue_type	queue_type;
 	u64			kernel_address;
@@ -392,7 +433,11 @@ struct hl_hw_queue {
 	u32			cq_id;
 	u32			msi_vec;
 	u16			int_queue_len;
+	u16			next_sob_val;
+	u16			base_sob_id;
+	u16			base_mon_id;
 	u8			valid;
+	u8			curr_sob_offset;
 };
 
 /**
@@ -796,10 +841,13 @@ struct hl_userptr {
  * @job_lock: spinlock for the CS's jobs list. Needed for free_job.
  * @refcount: reference counter for usage of the CS.
  * @fence: pointer to the fence object of this CS.
+ * @signal_fence: pointer to the fence object of the signal CS (used by wait
+ *                CS only).
  * @work_tdr: delayed work node for TDR.
  * @mirror_node : node in device mirror list of command submissions.
  * @debugfs_list: node in debugfs list of command submissions.
  * @sequence: the sequence number of this CS.
+ * @type: CS_TYPE_*.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
  * @timedout : true if CS was timedout.
@@ -814,10 +862,12 @@ struct hl_cs {
 	spinlock_t		job_lock;
 	struct kref		refcount;
 	struct dma_fence	*fence;
+	struct dma_fence	*signal_fence;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
 	struct list_head	debugfs_list;
 	u64			sequence;
+	enum hl_cs_type		type;
 	u8			submitted;
 	u8			completed;
 	u8			timedout;
@@ -1620,6 +1670,7 @@ int hl_cb_pool_fini(struct hl_device *hdev);
 void hl_cs_rollback_all(struct hl_device *hdev);
 struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 		enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
+void hl_sob_reset_error(struct kref *ref);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index a5abc224399d..f4434b39ef1b 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -403,20 +403,110 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	 * checked in hw_queue_sanity_checks
 	 */
 	cq = &hdev->completion_queue[q->cq_id];
+
 	cq->pi = hl_cq_inc_ptr(cq->pi);
 
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
 
 /*
- * hl_hw_queue_schedule_cs - schedule a command submission
- *
- * @job        : pointer to the CS
+ * init_signal_wait_cs - initialize a signal/wait CS
+ * @cs: pointer to the signal/wait CS
  *
+ * H/W queues spinlock should be taken before calling this function
+ */
+static void init_signal_wait_cs(struct hl_cs *cs)
+{
+	struct hl_ctx *ctx = cs->ctx;
+	struct hl_device *hdev = ctx->hdev;
+	struct hl_hw_queue *hw_queue;
+	struct hl_cs_compl *cs_cmpl =
+			container_of(cs->fence, struct hl_cs_compl, base_fence);
+
+	struct hl_hw_sob *hw_sob;
+	struct hl_cs_job *job;
+	u32 q_idx;
+
+	/* There is only one job in a signal/wait CS */
+	job = list_first_entry(&cs->job_list, struct hl_cs_job,
+				cs_node);
+	q_idx = job->hw_queue_id;
+	hw_queue = &hdev->kernel_queues[q_idx];
+
+	if (cs->type & CS_TYPE_SIGNAL) {
+		hw_sob = &hw_queue->hw_sob[hw_queue->curr_sob_offset];
+
+		cs_cmpl->hw_sob = hw_sob;
+		cs_cmpl->sob_val = hw_queue->next_sob_val++;
+
+		dev_dbg(hdev->dev,
+			"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
+			cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx);
+
+		hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
+					cs_cmpl->hw_sob->sob_id);
+
+		kref_get(&hw_sob->kref);
+
+		/* check for wraparound */
+		if (hw_queue->next_sob_val == HL_MAX_SOB_VAL) {
+			/*
+			 * Decrement as we reached the max value.
+			 * The release function won't be called here as we've
+			 * just incremented the refcount.
+			 */
+			kref_put(&hw_sob->kref, hl_sob_reset_error);
+			hw_queue->next_sob_val = 1;
+			/* only two SOBs are currently in use */
+			hw_queue->curr_sob_offset =
+					(hw_queue->curr_sob_offset + 1) %
+						HL_RSVD_SOBS_IN_USE;
+
+			dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
+					hw_queue->curr_sob_offset, q_idx);
+		}
+	} else if (cs->type & CS_TYPE_WAIT) {
+		struct hl_cs_compl *signal_cs_cmpl;
+
+		signal_cs_cmpl = container_of(cs->signal_fence,
+						struct hl_cs_compl,
+						base_fence);
+
+		/* copy the the SOB id and value of the signal CS */
+		cs_cmpl->hw_sob = signal_cs_cmpl->hw_sob;
+		cs_cmpl->sob_val = signal_cs_cmpl->sob_val;
+
+		dev_dbg(hdev->dev,
+			"generate wait CB, sob_id: %d, sob_val: 0x%x, mon_id: %d, q_idx: %d\n",
+			cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
+			hw_queue->base_mon_id, q_idx);
+
+		hdev->asic_funcs->gen_wait_cb(hdev, job->patched_cb,
+						cs_cmpl->hw_sob->sob_id,
+						cs_cmpl->sob_val,
+						hw_queue->base_mon_id,
+						q_idx);
+
+		kref_get(&cs_cmpl->hw_sob->kref);
+		/*
+		 * Must put the signal fence after the SOB refcnt increment so
+		 * the SOB refcnt won't turn 0 and reset the SOB before the
+		 * wait CS was submitted.
+		 */
+		mb();
+		dma_fence_put(cs->signal_fence);
+		cs->signal_fence = NULL;
+	}
+}
+
+/*
+ * hl_hw_queue_schedule_cs - schedule a command submission
+ * @cs: pointer to the CS
  */
 int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 {
-	struct hl_device *hdev = cs->ctx->hdev;
+	struct hl_ctx *ctx = cs->ctx;
+	struct hl_device *hdev = ctx->hdev;
 	struct hl_cs_job *job, *tmp;
 	struct hl_hw_queue *q;
 	int rc = 0, i, cq_cnt;
@@ -462,6 +552,9 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		}
 	}
 
+	if ((cs->type == CS_TYPE_SIGNAL) || (cs->type == CS_TYPE_WAIT))
+		init_signal_wait_cs(cs);
+
 	spin_lock(&hdev->hw_queues_mirror_lock);
 	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
 
@@ -570,6 +663,9 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	q->ci = 0;
 	q->pi = 0;
 
+	if (!is_cpu_queue)
+		hdev->asic_funcs->ext_queue_init(hdev, q->hw_queue_id);
+
 	return 0;
 
 free_queue:
@@ -792,5 +888,8 @@ void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset)
 			((!hard_reset) && (q->queue_type == QUEUE_TYPE_CPU)))
 			continue;
 		q->pi = q->ci = 0;
+
+		if (q->queue_type == QUEUE_TYPE_EXT)
+			hdev->asic_funcs->ext_queue_reset(hdev, q->hw_queue_id);
 	}
 }
-- 
2.17.1

