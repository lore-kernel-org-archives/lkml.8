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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B844C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85A92073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLZbIxHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgEGOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgEGOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:37:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F2C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:37:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h9so6708211wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Zg3yJkE410ym7fzTS+fnsjrx2NHEjSUpxFyQgSXJx4=;
        b=BLZbIxHL3oY5ggbftVSjVGA7QvZJ3vW7uLDP38Rm7J4B8rO84x1CUBWObHoHprgELm
         bgSugjgtABViXIPdclx5HehU3/HoKOv2FmXMoKBCRefqtj/S68U45BR/j1Ax/V0jAuRS
         2jJ+LCvSYT3HeRT/9F1xfc6Ocbzxcqf5UpLv28mXyA02kpsQfP9b7GuptZNveKsqEFgI
         gtRQYwDCYKJmSZCdbSqOmyLaw2Dw+pyAgG0/AisZlQ2PIE135ZKeDCteLjUx72dWmy8/
         z8a3u0eYQqM1W9/D/o8R1cadmjyHqQ01Z5UgX6YLxnn9wY8dWbIoRCFbV2c1sIRe43Mn
         Uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Zg3yJkE410ym7fzTS+fnsjrx2NHEjSUpxFyQgSXJx4=;
        b=rqhv4IvTE/TS8Y0SUW5c/dKrweXg/geyuxz9gN/F6lv5u70laPO9vNx9pm11Cza8cl
         HiVPk/Aay0vtc/vhLNSAAQCUBVLN8XTa6+nhOBqsbK5OLGNbB9KMHPSK86Usk9/weyrn
         4JJkn4fspvCO+PxOXF6YL3H9Sbt7h8hAb+PtYE4/Ase5byIF5MOsX23AbGIveiYD1PMH
         vdn8pyoB1w26j1BbzYNdJdYpCphfu9wjb9mv4qjzYNj4pIMz0nvpXq1q5OcgOIzR47nX
         fRPn5alc1R8aXicvfKlYEkhtR2gL0f7n7gQB9i/UG7ZzZfvEgWvuOu48qqBoqO1vDjZ6
         fC9w==
X-Gm-Message-State: AGi0PuZYSiGt04WnB15CWNcw4yldMZYBd01XxsW5MUXP0DBAxgu7lbLD
        SuRzE+fcPRcHfsh/xo9CRJVHIXM/
X-Google-Smtp-Source: APiQypI0DLEFOnhawyx4le1REuATyrPv9kEuNUIFyi9lN7dX+iJRbJWuBat1gdfkaSCiSZqJMCilAA==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr4525696wrt.286.1588862226585;
        Thu, 07 May 2020 07:37:06 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o6sm8808095wrw.63.2020.05.07.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:37:05 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/4] uapi: habanalabs: add signal/wait operations
Date:   Thu,  7 May 2020 17:36:58 +0300
Message-Id: <20200507143701.32456-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This is a pre-requisite to upstreaming GAUDI support.

Signal/wait operations are done by the user to perform sync between two
Primary Queues (PQs). The sync is done using the sync manager and it is
usually resolved inside the device, but sometimes it can be resolved in the
host, i.e. the user should be able to wait in the host until a signal has
been completed.

The mechanism to define signal and wait operations is done by the driver
because it needs atomicity and serialization, which is already done in the
driver when submitting work to the different queues.

To implement this feature, the driver "takes" a couple of h/w resources,
and this is reflected by the defines added to the uapi file.

The signal/wait operations are done via the existing CS IOCTL, and they use
the same data structure. There is a difference in the meaning of some of
the parameters, and for that we added unions to make the code more
readable.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 13 +++-
 drivers/misc/habanalabs/habanalabs.h         |  2 +
 include/uapi/misc/habanalabs.h               | 67 +++++++++++++++-----
 3 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 6680e183d881..f7d03a35e6a8 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -11,6 +11,8 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+#define HL_CS_FLAGS_SIG_WAIT	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT)
+
 static void job_wq_completion(struct work_struct *work);
 static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
@@ -659,7 +661,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	union hl_cs_args *args = data;
 	struct hl_ctx *ctx = hpriv->ctx;
 	void __user *chunks_execute, *chunks_restore;
-	u32 num_chunks_execute, num_chunks_restore;
+	u32 num_chunks_execute, num_chunks_restore, sig_wait_flags;
 	u64 cs_seq = ULONG_MAX;
 	int rc, do_ctx_switch;
 	bool need_soft_reset = false;
@@ -672,6 +674,15 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		goto out;
 	}
 
+	sig_wait_flags = args->in.cs_flags & HL_CS_FLAGS_SIG_WAIT;
+
+	if (unlikely((sig_wait_flags & HL_CS_FLAGS_SIG_WAIT) &&
+			(!hdev->supports_sync_stream))) {
+		dev_err(hdev->dev, "Sync stream CS is not supported\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
 	chunks_execute = (void __user *) (uintptr_t) args->in.chunks_execute;
 	num_chunks_execute = args->in.num_chunks_execute;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index b1dc6a22ba0d..7cd9a8d72451 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1347,6 +1347,7 @@ struct hl_device_idle_busy_ts {
  *                           only to POWER9 machines.
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
  * @stop_on_err: true if engines should stop on error.
+ * @supports_sync_stream: is sync stream supported.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1429,6 +1430,7 @@ struct hl_device {
 	u8                              power9_64bit_dma_enable;
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
+	u8				supports_sync_stream;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 523e511e6cff..70dfccea7038 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2020 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -241,52 +241,87 @@ union hl_cb_args {
  * compatibility
  */
 struct hl_cs_chunk {
-	/*
-	 * For external queue, this represents a Handle of CB on the Host
-	 * For internal queue, this represents an SRAM or DRAM address of the
-	 * internal CB
-	 */
-	__u64 cb_handle;
+	union {
+		/* For external queue, this represents a Handle of CB on the
+		 * Host.
+		 * For internal queue in Goya, this represents an SRAM or
+		 * a DRAM address of the internal CB. In Gaudi, this might also
+		 * represent a mapped host address of the CB.
+		 *
+		 * A mapped host address is in the device address space, after
+		 * a host address was mapped by the device MMU.
+		 */
+		__u64 cb_handle;
+
+		/* Relevant only when HL_CS_FLAGS_WAIT is set.
+		 * This holds address of array of u64 values that contain
+		 * signal CS sequence numbers. The wait described by this job
+		 * will listen on all those signals (wait event per signal)
+		 */
+		__u64 signal_seq_arr;
+	};
+
 	/* Index of queue to put the CB on */
 	__u32 queue_index;
-	/*
-	 * Size of command buffer with valid packets
-	 * Can be smaller then actual CB size
-	 */
-	__u32 cb_size;
+
+	union {
+		/*
+		 * Size of command buffer with valid packets
+		 * Can be smaller then actual CB size
+		 */
+		__u32 cb_size;
+
+		/* Relevant only when HL_CS_FLAGS_WAIT is set.
+		 * Number of entries in signal_seq_arr
+		 */
+		__u32 num_signal_seq_arr;
+	};
+
 	/* HL_CS_CHUNK_FLAGS_* */
 	__u32 cs_chunk_flags;
+
 	/* Align structure to 64 bytes */
 	__u32 pad[11];
 };
 
+/* SIGNAL and WAIT flags are mutually exclusive */
 #define HL_CS_FLAGS_FORCE_RESTORE	0x1
+#define HL_CS_FLAGS_SIGNAL		0x2
+#define HL_CS_FLAGS_WAIT		0x4
 
 #define HL_CS_STATUS_SUCCESS		0
 
 #define HL_MAX_JOBS_PER_CS		512
 
 struct hl_cs_in {
+
 	/* this holds address of array of hl_cs_chunk for restore phase */
 	__u64 chunks_restore;
-	/* this holds address of array of hl_cs_chunk for execution phase */
+
+	/* holds address of array of hl_cs_chunk for execution phase */
 	__u64 chunks_execute;
+
 	/* this holds address of array of hl_cs_chunk for store phase -
 	 * Currently not in use
 	 */
 	__u64 chunks_store;
+
 	/* Number of chunks in restore phase array. Maximum number is
 	 * HL_MAX_JOBS_PER_CS
 	 */
 	__u32 num_chunks_restore;
+
 	/* Number of chunks in execution array. Maximum number is
 	 * HL_MAX_JOBS_PER_CS
 	 */
 	__u32 num_chunks_execute;
+
 	/* Number of chunks in restore phase array - Currently not in use */
 	__u32 num_chunks_store;
+
 	/* HL_CS_FLAGS_* */
 	__u32 cs_flags;
+
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
 };
@@ -597,8 +632,8 @@ struct hl_debug_args {
  * For jobs on external queues, the user needs to create command buffers
  * through the CB ioctl and give the CB's handle to the CS ioctl. For jobs on
  * internal queues, the user needs to prepare a "command buffer" with packets
- * on either the SRAM or DRAM, and give the device address of that buffer to
- * the CS ioctl.
+ * on either the device SRAM/DRAM or the host, and give the device address of
+ * that buffer to the CS ioctl.
  *
  * This IOCTL is asynchronous in regard to the actual execution of the CS. This
  * means it returns immediately after ALL the JOBS were enqueued on their
@@ -610,7 +645,7 @@ struct hl_debug_args {
  * external JOBS have been completed. Note that if the CS has internal JOBS
  * which can execute AFTER the external JOBS have finished, the driver might
  * report that the CS has finished executing BEFORE the internal JOBS have
- * actually finish executing.
+ * actually finished executing.
  *
  * Even though the sequence number increments per CS, the user can NOT
  * automatically assume that if CS with sequence number N finished, then CS
-- 
2.17.1

