Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49A8206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7k/5kR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgF3NwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388459AbgF3Nvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500EC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so18883709wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1zDXtnu4nYqM822JS90Uin0HwiZbzzdDBFpt66EWWs=;
        b=d7k/5kR1qiJB9I8wUeO83oekbSzZU46dMeScb0EzHVURvCyrbXk22BSOWM13XyQfXA
         L3RPHyLinXF2f6JXJeD2Fg1c6YkaXr7SR3yfuhwD2YXqQhVqJ9YX4k8AjZsbGyp4FGQZ
         BzvEp6WPUEno848z2J9xukGRDZ7BFdONeFmHe0p3+qPu7B9kHH4RBtMrYlGJsbmkWDCV
         y7jAs2hIF5HP+6I81qf2QOcBLnlVbmEU4BzDpO0o1Hnb67F4ZTc/SIqxJRriKk7MbTfu
         y8wY4Rz8ziEOXnTvSEN0ADNEg+jEFmj9Hj+jdifuGZusImdpAjBegKAr2hdrfDYj8RzI
         C5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1zDXtnu4nYqM822JS90Uin0HwiZbzzdDBFpt66EWWs=;
        b=nE09fnQ+SZXRkJadMaVoJ62AWi5P+E8PpXhAgIMlwdPLx4FkHpjbTv1e32N8gvSwte
         mPlVzwQ+TavvE+8IC5P2TS+St3uFlReh8/tVCr8aefWTIZSMvxwxc2caq9UPmATws64p
         OAGnGAgd9td839SU1OivTxk15FJ6Lic4CpARv9mDy7sZEqw/wzst6EKjUGZaGuSHMweS
         outriaoO4Zuj6HsEqXvExdRQusumfx81dK7v0Ktg4QnhSeLHkgROAShaNR82f4MFc5T/
         7rmZxDd/SdvgGmivKiVxy3bEooyG7Bw2QLacJ5qomq71j0/6fjuhMtST4jNNoNArjhMP
         E7IQ==
X-Gm-Message-State: AOAM531zG9CgWGhDrqKqG8MsQHeklRE4F151YTGPDBy5Sq9MKoYGgooz
        VzY+ioQtv/aGRZ9XzG53QU2W0Q==
X-Google-Smtp-Source: ABdhPJzsUzBMER02528kWrOC9qgDSaXSh2ak8iFAlndL0t+7FKAxkUl019ETK2s+ggIgnhv+g5sDVQ==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr21391693wme.89.1593525100565;
        Tue, 30 Jun 2020 06:51:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 25/30] misc: mic: scif: scif_rma: Repair a bunch of kerneldoc issues
Date:   Tue, 30 Jun 2020 14:51:05 +0100
Message-Id: <20200630135110.2236389-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, for some reason documentation of all 'scifdev' arguments
are missing, so apply those.  Also remove 2 descriptions of 'ep'
which appear to document non-existent function arguments.

 drivers/misc/mic/scif/scif_rma.c:468: warning: Function parameter or member 'scifdev' not described in 'scif_create_remote_window'
 drivers/misc/mic/scif/scif_rma.c:468: warning: Excess function parameter 'ep' description in 'scif_create_remote_window'
 drivers/misc/mic/scif/scif_rma.c:510: warning: Excess function parameter 'ep' description in 'scif_destroy_remote_window'
 drivers/misc/mic/scif/scif_rma.c:1045: warning: Function parameter or member 'scifdev' not described in 'scif_alloc_req'
 drivers/misc/mic/scif/scif_rma.c:1080: warning: Function parameter or member 'scifdev' not described in 'scif_alloc_gnt_rej'
 drivers/misc/mic/scif/scif_rma.c:1104: warning: Function parameter or member 'scifdev' not described in 'scif_free_virt'
 drivers/misc/mic/scif/scif_rma.c:1142: warning: Function parameter or member 'scifdev' not described in 'scif_recv_reg'
 drivers/misc/mic/scif/scif_rma.c:1178: warning: Function parameter or member 'scifdev' not described in 'scif_recv_unreg'
 drivers/misc/mic/scif/scif_rma.c:1243: warning: Function parameter or member 'scifdev' not described in 'scif_recv_reg_ack'
 drivers/misc/mic/scif/scif_rma.c:1262: warning: Function parameter or member 'scifdev' not described in 'scif_recv_reg_nack'
 drivers/misc/mic/scif/scif_rma.c:1280: warning: Function parameter or member 'scifdev' not described in 'scif_recv_unreg_ack'
 drivers/misc/mic/scif/scif_rma.c:1299: warning: Function parameter or member 'scifdev' not described in 'scif_recv_unreg_nack'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_rma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index 406cd5abfa726..de8f61efaef5c 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -458,7 +458,7 @@ static void scif_destroy_remote_lookup(struct scif_dev *remote_dev,
 
 /**
  * scif_create_remote_window:
- * @ep: end point
+ * @scifdev:  SCIF device
  * @nr_pages: number of pages in window
  *
  * Allocate and prepare a remote registration window.
@@ -500,7 +500,6 @@ scif_create_remote_window(struct scif_dev *scifdev, int nr_pages)
 
 /**
  * scif_destroy_remote_window:
- * @ep: end point
  * @window: remote registration window
  *
  * Deallocate resources for remote window.
@@ -1037,6 +1036,7 @@ void scif_free_window_offset(struct scif_endpt *ep,
 
 /**
  * scif_alloc_req: Respond to SCIF_ALLOC_REQ interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remote side is requesting a memory allocation.
@@ -1072,6 +1072,7 @@ void scif_alloc_req(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_alloc_gnt_rej: Respond to SCIF_ALLOC_GNT/REJ interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remote side responded to a memory allocation.
@@ -1096,6 +1097,7 @@ void scif_alloc_gnt_rej(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_free_virt: Respond to SCIF_FREE_VIRT interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Free up memory kmalloc'd earlier.
@@ -1134,6 +1136,7 @@ scif_fixup_aper_base(struct scif_dev *dev, struct scif_window *window)
 
 /**
  * scif_recv_reg: Respond to SCIF_REGISTER interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Update remote window list with a new registered window.
@@ -1170,6 +1173,7 @@ void scif_recv_reg(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_unreg: Respond to SCIF_UNREGISTER interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remove window from remote registration list;
@@ -1235,6 +1239,7 @@ void scif_recv_unreg(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_reg_ack: Respond to SCIF_REGISTER_ACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Wake up the window waiting to complete registration.
@@ -1253,6 +1258,7 @@ void scif_recv_reg_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_reg_nack: Respond to SCIF_REGISTER_NACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Wake up the window waiting to inform it that registration
@@ -1272,6 +1278,7 @@ void scif_recv_reg_nack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_unreg_ack: Respond to SCIF_UNREGISTER_ACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Wake up the window waiting to complete unregistration.
@@ -1290,6 +1297,7 @@ void scif_recv_unreg_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_recv_unreg_nack: Respond to SCIF_UNREGISTER_NACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Wake up the window waiting to inform it that unregistration
-- 
2.25.1

