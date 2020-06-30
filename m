Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD42C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EB1206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYXvdcqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbgF3Nv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388456AbgF3Nvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so17275182wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbXNfDHMBERrHFjsyxyOToTajDh8zV3mfokRINKpnhg=;
        b=LYXvdcqDzA2qwHzkZ1KiY139X2ckq17/1uJ6MncswuJ14+qyU1/l+amCCdwI3ZI8+I
         mchIzeCBvkv4eAojs/t6eHfgwtVGlgbLhVLiGvmRCZBQb1T9UCg/rDSh7NrQuemXCeja
         EPC8Gveblq/YRqoMvNdbnOIRANIOeT99Ukar2pZrQu/kcIzpQTO+4/Q2jSW/sjdVzkMp
         8Ku7LlikoumI8Cl5D6NtE9RLxUOFH87HIO6YqnrPNQFUa5lZB/S5xU4qBV+S0cWAt26k
         oRtkQCDoMnnEt3xBs9Y15PQvtkMjqkSoIVRgcjYxfCZujByshyOi+7FbcL/umevJ80Rd
         XwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbXNfDHMBERrHFjsyxyOToTajDh8zV3mfokRINKpnhg=;
        b=VCV1NhJmw4oed+pdDJBViovX9LtImrrOmEmJifj5gR6oTplBxVnyZGbXFxRqpNe9oo
         cX34s/g15CDKJFqxhoMVO0/zBG0FcjQGheGEIp501BL4SmTFiWaYRsYCfnWHaQAymJMW
         dmE1tLlnCkzQnlCTXoh72bqyeGvZjDop13pJvaKS7Pqh+3on6qqEJzGfgWLvpfU4h8am
         2aiEpfSl0gr5LKfeMQunTT8+eT0RS+7yVK82baHaKiD9g0kARtQQqE25bkNgV3lZb4vZ
         z7YnV8BppvliP3lE0DfVS98ntLAASrvPUkTxAT1jbZpZtF4G1MnV39igHhzrrsk6Zm3y
         jYnw==
X-Gm-Message-State: AOAM532R07Vusf46NV7AEgsAJV2RMPeI72r8c3gf6oVgfK4OuiYZ0VMH
        4zj02NPWdemo1Od55Zn8j8tlgw==
X-Google-Smtp-Source: ABdhPJys4mwAgYke7AvLq6KmzbX8oSCnKjm8Sx7aH4Z47QBuT+4/XDTnm3Z3UpmhYRqg7Un1vAYsDg==
X-Received: by 2002:adf:aad3:: with SMTP id i19mr22175200wrc.359.1593525099374;
        Tue, 30 Jun 2020 06:51:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 24/30] misc: mic: scif: scif_fence: Fix a bunch of different documentation issues
Date:   Tue, 30 Jun 2020 14:51:04 +0100
Message-Id: <20200630135110.2236389-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly add missing descriptions for every use of 'scifdev', then
correct incorrect formatting of existing function argument descriptions
changing to the expected format of '@.*: ', finally add missing
description for function argument 'mark'.

Fixes the following W=1 warnings:

 drivers/misc/mic/scif/scif_fence.c:19: warning: Function parameter or member 'scifdev' not described in 'scif_recv_mark'
 drivers/misc/mic/scif/scif_fence.c:41: warning: Function parameter or member 'scifdev' not described in 'scif_recv_mark_resp'
 drivers/misc/mic/scif/scif_fence.c:64: warning: Function parameter or member 'scifdev' not described in 'scif_recv_wait'
 drivers/misc/mic/scif/scif_fence.c:101: warning: Function parameter or member 'scifdev' not described in 'scif_recv_wait_resp'
 drivers/misc/mic/scif/scif_fence.c:122: warning: Function parameter or member 'scifdev' not described in 'scif_recv_sig_local'
 drivers/misc/mic/scif/scif_fence.c:143: warning: Function parameter or member 'scifdev' not described in 'scif_recv_sig_remote'
 drivers/misc/mic/scif/scif_fence.c:164: warning: Function parameter or member 'scifdev' not described in 'scif_recv_sig_resp'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'epd' not described in 'scif_send_fence_signal'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'roff' not described in 'scif_send_fence_signal'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'rval' not described in 'scif_send_fence_signal'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'loff' not described in 'scif_send_fence_signal'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'lval' not described in 'scif_send_fence_signal'
 drivers/misc/mic/scif/scif_fence.c:515: warning: Function parameter or member 'flags' not described in 'scif_send_fence_signal'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_fence.c | 34 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
index 657fd4a206565..4fedf6183951c 100644
--- a/drivers/misc/mic/scif/scif_fence.c
+++ b/drivers/misc/mic/scif/scif_fence.c
@@ -11,6 +11,7 @@
 
 /**
  * scif_recv_mark: Handle SCIF_MARK request
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has requested a mark.
@@ -33,6 +34,7 @@ void scif_recv_mark(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_mark_resp: Handle SCIF_MARK_(N)ACK messages.
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has responded to a SCIF_MARK message.
@@ -56,6 +58,7 @@ void scif_recv_mark_resp(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_wait: Handle SCIF_WAIT request
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has requested waiting on a fence.
@@ -93,6 +96,7 @@ void scif_recv_wait(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_wait_resp: Handle SCIF_WAIT_(N)ACK messages.
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has responded to a SCIF_WAIT message.
@@ -114,6 +118,7 @@ void scif_recv_wait_resp(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_sig_local: Handle SCIF_SIG_LOCAL request
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has requested a signal on a local offset.
@@ -135,6 +140,7 @@ void scif_recv_sig_local(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_sig_remote: Handle SCIF_SIGNAL_REMOTE request
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has requested a signal on a remote offset.
@@ -156,6 +162,7 @@ void scif_recv_sig_remote(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_sig_resp: Handle SCIF_SIG_(N)ACK messages.
+ * @scifdev:	SCIF device
  * @msg:	Interrupt message
  *
  * The peer has responded to a signal request.
@@ -280,12 +287,12 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 	return err;
 }
 
-/*
+/**
  * scif_prog_signal:
- * @epd - Endpoint Descriptor
- * @offset - registered address to write @val to
- * @val - Value to be written at @offset
- * @type - Type of the window.
+ * @epd: Endpoint Descriptor
+ * @offset: registered address to write @val to
+ * @val: Value to be written at @offset
+ * @type: Type of the window.
  *
  * Arrange to write a value to the registered offset after ensuring that the
  * offset provided is indeed valid.
@@ -501,12 +508,12 @@ static int _scif_send_fence_signal_wait(struct scif_endpt *ep,
 
 /**
  * scif_send_fence_signal:
- * @epd - endpoint descriptor
- * @loff - local offset
- * @lval - local value to write to loffset
- * @roff - remote offset
- * @rval - remote value to write to roffset
- * @flags - flags
+ * @epd: endpoint descriptor
+ * @loff: local offset
+ * @lval: local value to write to loffset
+ * @roff: remote offset
+ * @rval: remote value to write to roffset
+ * @flags: flags
  *
  * Sends a remote fence signal request
  */
@@ -577,10 +584,11 @@ static void scif_fence_mark_cb(void *arg)
 	atomic_dec(&ep->rma_info.fence_refcount);
 }
 
-/*
+/**
  * _scif_fence_mark:
+ * @epd: endpoint descriptor
+ * @mark: DMA mark to set-up
  *
- * @epd - endpoint descriptor
  * Set up a mark for this endpoint and return the value of the mark.
  */
 int _scif_fence_mark(scif_epd_t epd, int *mark)
-- 
2.25.1

