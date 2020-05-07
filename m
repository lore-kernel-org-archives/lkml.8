Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372DCC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE2A2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMmvOE2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEGOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgEGOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:37:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B7C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:37:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so6816080wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcgCFFsU+BKmHmdN5wmfQ7v7w7NQNC274wP1oc1U1T8=;
        b=lMmvOE2OB2qOE3mRQHyvb/nXu9tk2SJ/JE0IS5OcAsCcd+MduDhLiBh1vN7yR+kafl
         oybuJAGPJ2ojJ6Skp1wce1znW/0578IgdtpAwPvUjPZRyhO6Lje399PNi89h/h0vxXUU
         YEGHNBhi1EDhYbzk7L5FYFLyxxSTIRKzCpPzEyUGYrKPCTtLQ20GpN07UVM8Bmpp9HCj
         AwcspO9BQkhDyb3xpNqRj1U7FSlZudYuQESEsIME0oK22tKh1IIGXo7rHtSWreEdgySH
         bJHLWJVqDqRAGz/np/J8sG7pJYqDnVLB6whk7XdPX6jNXFftKx6DaEvVodQvQeIZxATx
         B9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcgCFFsU+BKmHmdN5wmfQ7v7w7NQNC274wP1oc1U1T8=;
        b=lEGBqo/l0ONTGAAiD/yCmgGSg/4xLiJfqU8wimCJg3TR4EjtPItvAFeBAiUEZ6JsAx
         GkX1iaql5iBvr1KBeI9eUoH+6QrRGJbrus42m5vRkr0kLCFUtRslhMzVzEM+Kk0Cf3QN
         K6oyBprjbaM33cwr4WQngxguMHCQkrRWv6UOf0P24caHIOTLO+RI4t0skS4It7dPWa1J
         H1Q6YCcz1h8sT+mvzt0j1BiJfHd+NhCSS+6y/ZdKRt+jJiQX9EoUKCKGWUS4DDmPE0bo
         PtQog3FPXqBWxOyvjOnoE7JISht2v3vHZAjUE7nmneFQWP0gwp7cW6m14tFjHKYW8Szl
         XJvw==
X-Gm-Message-State: AGi0PuaDCcPRFNLmaGinIpbh2EEd7skbSArrKdbpMNh6W4aanSMvid5/
        XRHbiWAZ9lf5HrTt9X3iaSJ3Cddg
X-Google-Smtp-Source: APiQypLOL8WDg/zPcjxV29f0mED6NqVh2XnkT/ozaO58xSZ1rTO4vgZ+7E5L0R70Gc6zL6PiFsrDxQ==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr9985511wme.115.1588862234565;
        Thu, 07 May 2020 07:37:14 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm8808095wrw.63.2020.05.07.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:37:13 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 4/4] habanalabs: add signal/wait to CS IOCTL operations
Date:   Thu,  7 May 2020 17:37:01 +0300
Message-Id: <20200507143701.32456-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507143701.32456-1-oded.gabbay@gmail.com>
References: <20200507143701.32456-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Add the following two operations to the CS IOCTL:

Signal:

The signal operation is basically a command submission, that is created by
the driver upon user request. It will be implemented using a dedicated PQE
that will increment a specific SOB. There will be a new flag:
HL_CS_FLAGS_SIGNAL. When the user set this flag in the CS IOCTL structure,
the driver will execute a dedicated code path that will prepare this
special PQE and submit it. The user only needs to provide a queue index on
which to put the signal.

Wait:

The wait operation is also a command submission that is created by the
driver upon user request. It will be implemented using a dedicated PQE that
will contain packets of "ARM a monitor" + FENCE packet. There will be a new
flag: HL_CS_FLAGS_WAIT. When the user set this flag in the CS structure,
the driver will execute a dedicated code path that will prepare this
special PQE and submit it.

The user needs to provide the following parameters:
1. queue ID
2. an array of signal_seq numbers and the number of signals to wait on
   (the length of signal_seq_arr).

The IOCTL will return the CS sequence number of the wait it put on the
queue ID.

Currently, the code supports signal_seq_nr==1. But this API definition will
allow us to put a single PQE that waits on multiple signals.

To correctly configure the monitor and fence, the driver will need to
retrieve the specified signal CS object that contains the relevant SOB and
its expected value. In case the signal CS has already been completed, there
is no point of adding a wait operation. In this case, the driver will
return to the user *without* putting anything on the PQ. The return code
should reflect to the user that the signal was completed, as we won't
return a CS sequence number for this wait.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 341 +++++++++++++++++--
 drivers/misc/habanalabs/context.c            |   8 -
 drivers/misc/habanalabs/habanalabs.h         |   2 +
 3 files changed, 323 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index a4211cfc752a..7da9847eb9d6 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -18,6 +18,26 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
 static void cs_do_release(struct kref *ref);
 
+static void hl_sob_reset(struct kref *ref)
+{
+	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
+							kref);
+	struct hl_device *hdev = hw_sob->hdev;
+
+	hdev->asic_funcs->reset_sob(hdev, hw_sob);
+}
+
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
 static const char *hl_fence_get_driver_name(struct dma_fence *fence)
 {
 	return "HabanaLabs";
@@ -40,6 +60,37 @@ static void hl_fence_release(struct dma_fence *fence)
 {
 	struct hl_cs_compl *hl_cs_cmpl =
 		container_of(fence, struct hl_cs_compl, base_fence);
+	struct hl_device *hdev = hl_cs_cmpl->hdev;
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
 
 	kfree_rcu(hl_cs_cmpl, base_fence.rcu);
 }
@@ -189,17 +240,6 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 	kfree(job);
 }
 
-void hl_sob_reset_error(struct kref *ref)
-{
-	struct hl_hw_sob *hw_sob = container_of(ref, struct hl_hw_sob,
-							kref);
-	struct hl_device *hdev = hw_sob->hdev;
-
-	dev_crit(hdev->dev,
-			"SOB release shouldn't be called here, q_idx: %d, sob_id: %d\n",
-			hw_sob->q_idx, hw_sob->sob_id);
-}
-
 static void cs_do_release(struct kref *ref)
 {
 	struct hl_cs *cs = container_of(ref, struct hl_cs,
@@ -273,6 +313,12 @@ static void cs_do_release(struct kref *ref)
 
 			spin_unlock(&hdev->hw_queues_mirror_lock);
 		}
+	} else if (cs->type == CS_TYPE_WAIT) {
+		/*
+		 * In case the wait for signal CS was submitted, the put occurs
+		 * in init_signal_wait_cs() right before hanging on the PQ.
+		 */
+		dma_fence_put(cs->signal_fence);
 	}
 
 	/*
@@ -326,7 +372,7 @@ static void cs_timedout(struct work_struct *work)
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
-			struct hl_cs **cs_new)
+			enum hl_cs_type cs_type, struct hl_cs **cs_new)
 {
 	struct hl_cs_compl *cs_cmpl;
 	struct dma_fence *other = NULL;
@@ -340,6 +386,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->ctx = ctx;
 	cs->submitted = false;
 	cs->completed = false;
+	cs->type = cs_type;
 	INIT_LIST_HEAD(&cs->job_list);
 	INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
 	kref_init(&cs->refcount);
@@ -352,6 +399,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 	cs_cmpl->hdev = hdev;
+	cs_cmpl->type = cs->type;
 	spin_lock_init(&cs_cmpl->lock);
 	cs->fence = &cs_cmpl->base_fence;
 
@@ -513,8 +561,8 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 	return job;
 }
 
-static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
-			u32 num_chunks, u64 *cs_seq)
+static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
+				u32 num_chunks, u64 *cs_seq)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_chunk *cs_chunk_array;
@@ -552,7 +600,7 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
 	/* increment refcnt for context */
 	hl_ctx_get(hdev, hpriv->ctx);
 
-	rc = allocate_cs(hdev, hpriv->ctx, &cs);
+	rc = allocate_cs(hdev, hpriv->ctx, CS_TYPE_DEFAULT, &cs);
 	if (rc) {
 		hl_ctx_put(hpriv->ctx);
 		goto free_cs_chunk_array;
@@ -666,12 +714,229 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
 	return rc;
 }
 
+static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
+				void __user *chunks, u32 num_chunks,
+				u64 *cs_seq)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
+	struct hl_cs_chunk *cs_chunk_array, *chunk;
+	struct hw_queue_properties *hw_queue_prop;
+	struct dma_fence *sig_fence = NULL;
+	struct hl_cs_job *job;
+	struct hl_cs *cs;
+	struct hl_cb *cb;
+	u64 *signal_seq_arr = NULL, signal_seq;
+	u32 size_to_copy, q_idx, signal_seq_arr_len, cb_size;
+	int rc;
+
+	*cs_seq = ULLONG_MAX;
+
+	if (num_chunks > HL_MAX_JOBS_PER_CS) {
+		dev_err(hdev->dev,
+			"Number of chunks can NOT be larger than %d\n",
+			HL_MAX_JOBS_PER_CS);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	cs_chunk_array = kmalloc_array(num_chunks, sizeof(*cs_chunk_array),
+					GFP_ATOMIC);
+	if (!cs_chunk_array) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
+	if (copy_from_user(cs_chunk_array, chunks, size_to_copy)) {
+		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
+		rc = -EFAULT;
+		goto free_cs_chunk_array;
+	}
+
+	/* currently it is guaranteed to have only one chunk */
+	chunk = &cs_chunk_array[0];
+	q_idx = chunk->queue_index;
+	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
+
+	if ((q_idx >= HL_MAX_QUEUES) ||
+			(hw_queue_prop->type != QUEUE_TYPE_EXT)) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n", q_idx);
+		rc = -EINVAL;
+		goto free_cs_chunk_array;
+	}
+
+	if (cs_type == CS_TYPE_WAIT) {
+		struct hl_cs_compl *sig_waitcs_cmpl;
+
+		signal_seq_arr_len = chunk->num_signal_seq_arr;
+
+		/* currently only one signal seq is supported */
+		if (signal_seq_arr_len != 1) {
+			dev_err(hdev->dev,
+				"Wait for signal CS supports only one signal CS seq\n");
+			rc = -EINVAL;
+			goto free_cs_chunk_array;
+		}
+
+		signal_seq_arr = kmalloc_array(signal_seq_arr_len,
+						sizeof(*signal_seq_arr),
+						GFP_ATOMIC);
+		if (!signal_seq_arr) {
+			rc = -ENOMEM;
+			goto free_cs_chunk_array;
+		}
+
+		size_to_copy = chunk->num_signal_seq_arr *
+				sizeof(*signal_seq_arr);
+		if (copy_from_user(signal_seq_arr,
+					(void __user *) chunk->signal_seq_arr,
+					size_to_copy)) {
+			dev_err(hdev->dev,
+				"Failed to copy signal seq array from user\n");
+			rc = -EFAULT;
+			goto free_signal_seq_array;
+		}
+
+		/* currently it is guaranteed to have only one signal seq */
+		signal_seq = signal_seq_arr[0];
+		sig_fence = hl_ctx_get_fence(ctx, signal_seq);
+		if (IS_ERR(sig_fence)) {
+			dev_err(hdev->dev,
+				"Failed to get signal CS with seq 0x%llx\n",
+				signal_seq);
+			rc = PTR_ERR(sig_fence);
+			goto free_signal_seq_array;
+		}
+
+		if (!sig_fence) {
+			/* signal CS already finished */
+			rc = 0;
+			goto free_signal_seq_array;
+		}
+
+		sig_waitcs_cmpl =
+			container_of(sig_fence, struct hl_cs_compl, base_fence);
+
+		if (sig_waitcs_cmpl->type != CS_TYPE_SIGNAL) {
+			dev_err(hdev->dev,
+				"CS seq 0x%llx is not of a signal CS\n",
+				signal_seq);
+			dma_fence_put(sig_fence);
+			rc = -EINVAL;
+			goto free_signal_seq_array;
+		}
+
+		if (dma_fence_is_signaled(sig_fence)) {
+			/* signal CS already finished */
+			dma_fence_put(sig_fence);
+			rc = 0;
+			goto free_signal_seq_array;
+		}
+	}
+
+	/* increment refcnt for context */
+	hl_ctx_get(hdev, ctx);
+
+	rc = allocate_cs(hdev, ctx, cs_type, &cs);
+	if (rc) {
+		if (cs_type == CS_TYPE_WAIT)
+			dma_fence_put(sig_fence);
+		hl_ctx_put(ctx);
+		goto free_signal_seq_array;
+	}
+
+	/*
+	 * Save the signal CS fence for later initialization right before
+	 * hanging the wait CS on the queue.
+	 */
+	if (cs->type == CS_TYPE_WAIT)
+		cs->signal_fence = sig_fence;
+
+	hl_debugfs_add_cs(cs);
+
+	*cs_seq = cs->sequence;
+
+	job = hl_cs_allocate_job(hdev, QUEUE_TYPE_EXT, true);
+	if (!job) {
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		rc = -ENOMEM;
+		goto put_cs;
+	}
+
+	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	if (!cb) {
+		kfree(job);
+		rc = -EFAULT;
+		goto put_cs;
+	}
+
+	if (cs->type == CS_TYPE_WAIT)
+		cb_size = hdev->asic_funcs->get_wait_cb_size(hdev);
+	else
+		cb_size = hdev->asic_funcs->get_signal_cb_size(hdev);
+
+	job->id = 0;
+	job->cs = cs;
+	job->user_cb = cb;
+	job->user_cb->cs_cnt++;
+	job->user_cb_size = cb_size;
+	job->hw_queue_id = q_idx;
+
+	/*
+	 * No need in parsing, user CB is the patched CB.
+	 * We call hl_cb_destroy() out of two reasons - we don't need the CB in
+	 * the CB idr anymore and to decrement its refcount as it was
+	 * incremented inside hl_cb_kernel_create().
+	 */
+	job->patched_cb = job->user_cb;
+	job->job_cb_size = job->user_cb_size;
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+
+	cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+
+	list_add_tail(&job->cs_node, &cs->job_list);
+
+	/* increment refcount as for external queues we get completion */
+	cs_get(cs);
+
+	hl_debugfs_add_job(hdev, job);
+
+	rc = hl_hw_queue_schedule_cs(cs);
+	if (rc) {
+		if (rc != -EAGAIN)
+			dev_err(hdev->dev,
+				"Failed to submit CS %d.%llu to H/W queues, error %d\n",
+				ctx->asid, cs->sequence, rc);
+		goto free_cs_object;
+	}
+
+	rc = HL_CS_STATUS_SUCCESS;
+	goto put_cs;
+
+free_cs_object:
+	cs_rollback(hdev, cs);
+	*cs_seq = ULLONG_MAX;
+	/* The path below is both for good and erroneous exits */
+put_cs:
+	/* We finished with the CS in this function, so put the ref */
+	cs_put(cs);
+free_signal_seq_array:
+	if (cs_type == CS_TYPE_WAIT)
+		kfree(signal_seq_arr);
+free_cs_chunk_array:
+	kfree(cs_chunk_array);
+out:
+	return rc;
+}
+
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	union hl_cs_args *args = data;
 	struct hl_ctx *ctx = hpriv->ctx;
 	void __user *chunks_execute, *chunks_restore;
+	enum hl_cs_type cs_type;
 	u32 num_chunks_execute, num_chunks_restore, sig_wait_flags;
 	u64 cs_seq = ULONG_MAX;
 	int rc, do_ctx_switch;
@@ -687,6 +952,14 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	sig_wait_flags = args->in.cs_flags & HL_CS_FLAGS_SIG_WAIT;
 
+	if (unlikely(sig_wait_flags == HL_CS_FLAGS_SIG_WAIT)) {
+		dev_err(hdev->dev,
+			"Signal and wait CS flags are mutually exclusive, context %d\n",
+		ctx->asid);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	if (unlikely((sig_wait_flags & HL_CS_FLAGS_SIG_WAIT) &&
 			(!hdev->supports_sync_stream))) {
 		dev_err(hdev->dev, "Sync stream CS is not supported\n");
@@ -694,12 +967,27 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
 
+	if (args->in.cs_flags & HL_CS_FLAGS_SIGNAL)
+		cs_type = CS_TYPE_SIGNAL;
+	else if (args->in.cs_flags & HL_CS_FLAGS_WAIT)
+		cs_type = CS_TYPE_WAIT;
+	else
+		cs_type = CS_TYPE_DEFAULT;
+
 	chunks_execute = (void __user *) (uintptr_t) args->in.chunks_execute;
 	num_chunks_execute = args->in.num_chunks_execute;
 
-	if (!num_chunks_execute) {
+	if (cs_type == CS_TYPE_DEFAULT) {
+		if (!num_chunks_execute) {
+			dev_err(hdev->dev,
+				"Got execute CS with 0 chunks, context %d\n",
+				ctx->asid);
+			rc = -EINVAL;
+			goto out;
+		}
+	} else if (num_chunks_execute != 1) {
 		dev_err(hdev->dev,
-			"Got execute CS with 0 chunks, context %d\n",
+			"Sync stream CS mandates one chunk only, context %d\n",
 			ctx->asid);
 		rc = -EINVAL;
 		goto out;
@@ -745,7 +1033,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 			"Need to run restore phase but restore CS is empty\n");
 			rc = 0;
 		} else {
-			rc = _hl_cs_ioctl(hpriv, chunks_restore,
+			rc = cs_ioctl_default(hpriv, chunks_restore,
 						num_chunks_restore, &cs_seq);
 		}
 
@@ -787,7 +1075,12 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		}
 	}
 
-	rc = _hl_cs_ioctl(hpriv, chunks_execute, num_chunks_execute, &cs_seq);
+	if (cs_type == CS_TYPE_DEFAULT)
+		rc = cs_ioctl_default(hpriv, chunks_execute, num_chunks_execute,
+					&cs_seq);
+	else
+		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks_execute,
+						num_chunks_execute, &cs_seq);
 
 out:
 	if (rc != -EAGAIN) {
@@ -819,6 +1112,10 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 	fence = hl_ctx_get_fence(ctx, seq);
 	if (IS_ERR(fence)) {
 		rc = PTR_ERR(fence);
+		if (rc == -EINVAL)
+			dev_notice_ratelimited(hdev->dev,
+				"Can't wait on seq %llu because current CS is at seq %llu\n",
+				seq, ctx->cs_sequence);
 	} else if (fence) {
 		rc = dma_fence_wait_timeout(fence, true, timeout);
 		if (fence->error == -ETIMEDOUT)
@@ -826,8 +1123,12 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		else if (fence->error == -EIO)
 			rc = -EIO;
 		dma_fence_put(fence);
-	} else
+	} else {
+		dev_dbg(hdev->dev,
+			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
+			seq, ctx->cs_sequence);
 		rc = 1;
+	}
 
 	hl_ctx_put(ctx);
 
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 2df6fb87e7ff..ec92b3506b1f 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -170,24 +170,16 @@ int hl_ctx_put(struct hl_ctx *ctx)
 
 struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 {
-	struct hl_device *hdev = ctx->hdev;
 	struct dma_fence *fence;
 
 	spin_lock(&ctx->cs_lock);
 
 	if (seq >= ctx->cs_sequence) {
-		dev_notice_ratelimited(hdev->dev,
-			"Can't wait on seq %llu because current CS is at seq %llu\n",
-			seq, ctx->cs_sequence);
 		spin_unlock(&ctx->cs_lock);
 		return ERR_PTR(-EINVAL);
 	}
 
-
 	if (seq + HL_MAX_PENDING_CS < ctx->cs_sequence) {
-		dev_dbg(hdev->dev,
-			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
-			seq, ctx->cs_sequence);
 		spin_unlock(&ctx->cs_lock);
 		return NULL;
 	}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 630ed43eb410..a68df32094f1 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -843,6 +843,7 @@ struct hl_userptr {
  * @fence: pointer to the fence object of this CS.
  * @signal_fence: pointer to the fence object of the signal CS (used by wait
  *                CS only).
+ * @finish_work: workqueue object to run when CS is completed by H/W.
  * @work_tdr: delayed work node for TDR.
  * @mirror_node : node in device mirror list of command submissions.
  * @debugfs_list: node in debugfs list of command submissions.
@@ -863,6 +864,7 @@ struct hl_cs {
 	struct kref		refcount;
 	struct dma_fence	*fence;
 	struct dma_fence	*signal_fence;
+	struct work_struct	finish_work;
 	struct delayed_work	work_tdr;
 	struct list_head	mirror_node;
 	struct list_head	debugfs_list;
-- 
2.17.1

