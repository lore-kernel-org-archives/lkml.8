Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203532074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjDtT5Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgGAIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgGAIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA4C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so11619783wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1zDXtnu4nYqM822JS90Uin0HwiZbzzdDBFpt66EWWs=;
        b=kjDtT5CnnyHoOI//9ZKRCdWsUsDrpb78iN3QmW/EPRi1EjNlnjt73xLQRJ14BuFVXZ
         +TCBypxwQk4NaL10ELB7nmCC//0gKXs+OZ+VDgWn9swpU9AZRkOW8A+4sW478jBbeZv5
         Cl9xpiwLRyjI12R3BmSXnsPbdxX89kApsR6LhwS8plrPBlQ2JgZRLjfqXN2+WWF9V/xJ
         tCVf4rOmkjk+HN6YwW20H2rI+BXoer+ue/go04ER2+LwTV5LvSgML57AGaFPmas4HPwm
         DzXeQ32siFV1f01/T6qIgmq96PwOsIzsnmgGhlvzus1I0xax5ZLiyxVojkM3jPHhsgug
         /88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1zDXtnu4nYqM822JS90Uin0HwiZbzzdDBFpt66EWWs=;
        b=GQOBIiuAX/8XQcwaGDPFEtC1UBgJ26xMskN9C/R2g/N1UAy/0JGLOaqDss0ujtOdAv
         HNYi4mOaaDYSKHEHaT0VteRKjg8ExDSYam2JLYHGcpGYNPJYvlDbC5twS5Tuna7MUdMX
         Yl9Lj2Yvox8+ZHuqxZtjOm0jw/2oeAA8YjIGueXqvHHjOn4QmjBzGjJhyiySvPid/8nl
         TQ9zSIJ6FFj9w/Fpm9KjffHJdUlH8Xsp2U7Q/9WhA7sV0tZpin6t80S0tj/hmfajvBIf
         8PMBGAAPAmfsW37mEGrVRB5cVtxj7gWpx1bstOMxV2Akf3lbQGD0+SMsbJ7IK+PJjZ13
         qzLw==
X-Gm-Message-State: AOAM532+Qct/lLwrelw+xF3LFAK7zeYrw3A0u19Qn/diU0E3SSQqPoNF
        lUozP5o7dyF3nH8IAUwCv7hhPA==
X-Google-Smtp-Source: ABdhPJzQeILaMz/3pbBn9I99fcx2XvYHiAGeoAtPLrPO4Cn+nWNfHzJEjB3d+NMRDC+WpQHQ8M06Sw==
X-Received: by 2002:adf:9525:: with SMTP id 34mr27141922wrs.313.1593592312976;
        Wed, 01 Jul 2020 01:31:52 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 25/30] misc: mic: scif: scif_rma: Repair a bunch of kerneldoc issues
Date:   Wed,  1 Jul 2020 09:31:13 +0100
Message-Id: <20200701083118.45744-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

