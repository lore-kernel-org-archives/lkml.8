Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1B22077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE22e0q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgGAIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgGAIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84507C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so22870217wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0hPzbcINWUoj1nY9cM2w0ma0wuqc7/tUG8vEbWtQrA=;
        b=mE22e0q3mAUq5UOwG3ensFJ5EhJZrqhHNlRDSU67ux4z1BZRpREWDmPL4YfuT1wnn6
         m2RLEhd8Dv5MPRqX6cqHXquHmD2L12W7sfjfJRQmYrhRysoYsNz8O93NA9nCftb3W+xS
         JzLNyESkQxfnJKoZn7Cu11vIBctW0yD5K7zt2InruCHJeqDmZn57cGStUNjVBpmqhN+Z
         1zFlfIDEMmVk5MBoVsiZOSiKOV8gDpCp+DiJyeP4zE3mtncbCr3cW51KBfan6yLnOLvq
         kA85t+L7218ZeEe1pqXUFsyriWNffrSVsd9H+oV1nlB/l2iJVS50V1iqYNL1SWOgJUYt
         AjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0hPzbcINWUoj1nY9cM2w0ma0wuqc7/tUG8vEbWtQrA=;
        b=HeTQo1/q7gT6vO7pSWi20bgSAQenbNzwfmJtqeGb63ZHjU/2mHkJV876kGHlBYA59+
         pnQEWU+mcYexu+hhJxOUqR4HNFxzdNtfLqPEbauY6oz3x568JRpVFAXwT0o5kW+phUNA
         ROLXTl4XZt0mVO+07KDaNNUUtOSdV+aduPWfrEtMy1eAmSxmuG8dbeuebmXY9CXqV4lS
         hUuTRR2R6H4B+0RmAkIVnwppFRdt8g+JgIwNqJ6PUxpUSAxk5ywm2dM5cDPsrtp+wdHM
         lXJlqu9dMvfTs8S/G3fQ6r7VxegHXt4fTLZtvY9b+MrDPC5HlUzh/pBxt0c8dQfTHqBe
         7jfg==
X-Gm-Message-State: AOAM533JRASxONCQlqtMjAZMED6XmZ3TP/cqmWwgL1DJw3V799N/l6J+
        22CVejIuo3YbuEvFXChoLY2a+w==
X-Google-Smtp-Source: ABdhPJyTZ0tkHH1ieRd1Ju6TZzKtoJw3OU+g0mo1V1nc2EKR8bJX6L3Dq1/l5QayHgvJJZDwEFkfVw==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr27049806wrq.358.1593592307243;
        Wed, 01 Jul 2020 01:31:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 20/30] misc: mic: scif: scif_epd: Describe missing 'scifdev' argument(s)
Date:   Wed,  1 Jul 2020 09:31:08 +0100
Message-Id: <20200701083118.45744-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason (copy 'n' paste error?) the passed in pointers to
'struct scif_dev scifdev' weren't described throughout the source
file.  Change that.

Fixes the following W=1 kernel build warning(s):

 drivers/misc/mic/scif/scif_epd.c:120: warning: Function parameter or member 'scifdev' not described in 'scif_cnctreq'
 drivers/misc/mic/scif/scif_epd.c:166: warning: Function parameter or member 'scifdev' not described in 'scif_cnctgnt'
 drivers/misc/mic/scif/scif_epd.c:191: warning: Function parameter or member 'scifdev' not described in 'scif_cnctgnt_ack'
 drivers/misc/mic/scif/scif_epd.c:213: warning: Function parameter or member 'scifdev' not described in 'scif_cnctgnt_nack'
 drivers/misc/mic/scif/scif_epd.c:230: warning: Function parameter or member 'scifdev' not described in 'scif_cnctrej'
 drivers/misc/mic/scif/scif_epd.c:255: warning: Function parameter or member 'scifdev' not described in 'scif_discnct'
 drivers/misc/mic/scif/scif_epd.c:309: warning: Function parameter or member 'scifdev' not described in 'scif_discnt_ack'
 drivers/misc/mic/scif/scif_epd.c:325: warning: Function parameter or member 'scifdev' not described in 'scif_clientsend'
 drivers/misc/mic/scif/scif_epd.c:341: warning: Function parameter or member 'scifdev' not described in 'scif_clientrcvd'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_epd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/mic/scif/scif_epd.c b/drivers/misc/mic/scif/scif_epd.c
index 590baca9dc7bf..426687f6696b5 100644
--- a/drivers/misc/mic/scif/scif_epd.c
+++ b/drivers/misc/mic/scif/scif_epd.c
@@ -104,6 +104,7 @@ void scif_cleanup_zombie_epd(void)
 
 /**
  * scif_cnctreq() - Respond to SCIF_CNCT_REQ interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * This message is initiated by the remote node to request a connection
@@ -155,6 +156,7 @@ void scif_cnctreq(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_cnctgnt() - Respond to SCIF_CNCT_GNT interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * An accept() on the remote node has occurred and sent this message
@@ -181,6 +183,7 @@ void scif_cnctgnt(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_cnctgnt_ack() - Respond to SCIF_CNCT_GNTACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * The remote connection request has finished mapping the local memory.
@@ -203,6 +206,7 @@ void scif_cnctgnt_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_cnctgnt_nack() - Respond to SCIF_CNCT_GNTNACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * The remote connection request failed to map the local memory it was sent.
@@ -221,6 +225,7 @@ void scif_cnctgnt_nack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_cnctrej() - Respond to SCIF_CNCT_REJ interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * The remote end has rejected the connection request.  Set the end
@@ -240,6 +245,7 @@ void scif_cnctrej(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_discnct() - Respond to SCIF_DISCNCT interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * The remote node has indicated close() has been called on its end
@@ -301,6 +307,7 @@ void scif_discnct(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_discnct_ack() - Respond to SCIF_DISCNT_ACK interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remote side has indicated it has not more references to local resources
@@ -317,6 +324,7 @@ void scif_discnt_ack(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_clientsend() - Respond to SCIF_CLIENT_SEND interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remote side is confirming send or receive interrupt handling is complete.
@@ -333,6 +341,7 @@ void scif_clientsend(struct scif_dev *scifdev, struct scifmsg *msg)
 
 /**
  * scif_clientrcvd() - Respond to SCIF_CLIENT_RCVD interrupt message
+ * @scifdev:    SCIF device
  * @msg:        Interrupt message
  *
  * Remote side is confirming send or receive interrupt handling is complete.
-- 
2.25.1

