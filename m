Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECE42078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyrSn/RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgGAIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgGAIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25002C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so22823012wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbXNfDHMBERrHFjsyxyOToTajDh8zV3mfokRINKpnhg=;
        b=KyrSn/RI0csmKVqgkL/S8K4bDqPSe5oCZdF2YBP8mVEsOVestnsJxpgwutWB2JJnXy
         jw/r28e6dk0riqHZJLTyKDao8Z5GfDi8BToomhxdjQpCPWefkid2xz4N4E2zP5sD9MfD
         zcPqB13RgBDmZMjB0moaK13VgRJG/mLY2d7DgvTWoyKaYzfxciYUK1jxcG9sxg5U5ICi
         em3qbqBkwawIzI7XXyc4tCjho0w3lGmzAdsPrZSt9r8OoGb7gkW5UcsHTC59ulVRTv5+
         iD3YCOMU6wRnPRaYNLvskGmfECUhoRcyouzhAI02DohV/U7/s+NLu11I/kRX530ShMKI
         UGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbXNfDHMBERrHFjsyxyOToTajDh8zV3mfokRINKpnhg=;
        b=CsHlZFqQN4TgsRHdrIirvetRuFPw6zT+Sm9Icsh3MTP9zzfcwA9aBTAonu62r8tkWZ
         PDFrNEdlkB/nOAYuth9rZuDu6zczsO03JzPsEWjV+KibjKdIy2XswJ7jZnvrR5RRL6S+
         eGEZ/Jp87xa9v9ycbMtkeZhSaJvnbnUzzgmBndZQQ7jOIxY49FXwoIPcXMaYxM02IXMu
         8IoY1PYrGKW/AtyjSDYNvohNtCDYbfmqSoheqHkcMA3BmxZjaXmukHpArZBVl+fVTfcD
         JzbdZrRS3dtXA2Y3aXokEDGsUboqkqQ7MaSdQzUBBe76cUxVd+3WuSrr8ATIdAtnopNi
         WLTQ==
X-Gm-Message-State: AOAM530w0FVyDzR3v9fY8qPSvR0+DmYtKGsXFRtKeJn9Rfpgd/erPTV+
        0OwkUQ/z1XyYTNDEboYPnjLnrw==
X-Google-Smtp-Source: ABdhPJxVYEssl6rm+wG8SRl2HNVCOD9VVc4XtRdwIgjFKpfYBDM7iCOPLvJileB79HRYVzHneYskhw==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr23806978wro.382.1593592311771;
        Wed, 01 Jul 2020 01:31:51 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 24/30] misc: mic: scif: scif_fence: Fix a bunch of different documentation issues
Date:   Wed,  1 Jul 2020 09:31:12 +0100
Message-Id: <20200701083118.45744-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

