Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E50206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyAGhIIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbgF3Nwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbgF3Nvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD2C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so19687432wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0hPzbcINWUoj1nY9cM2w0ma0wuqc7/tUG8vEbWtQrA=;
        b=NyAGhIIq7tcUSetuycocG2Az7Rg27v0X3CZksZSP3YxgxoL2mqxpSTNv2VQRW+hw24
         I2FpCK17236jluMXVrlB/I/SQORS/Oy3FQt/a3J5d/LQg4whDZBdx1uBcFP/IcCd+bY+
         2Oj03YvKxENikAh+NNcGwqNrA5szR+ChUeWCvRZcOf6HADFgwewaWFba+Yi8IcRQQlfZ
         kWyJ/0Gsl+UgCA02fH0QESE7xvtuIZtaW58qxxurPSnQUIQ9TAqf8KwZ6tqNh+AYLQ0S
         Dfcr4Ci3M1KGdXcdgBDuKtB7jCXXcE0oUft7kdyQrI62CGQkmT8s9zmi1u9BpeTzcWao
         kxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0hPzbcINWUoj1nY9cM2w0ma0wuqc7/tUG8vEbWtQrA=;
        b=BcPhN0CuNojUL5N1Ri3PCs4zhO/AKvb7OFrfJgC07/LT+NXmSPT+ptwmxrfr+5DwSY
         Gy43+/eWnjuUdqReycaUEQ/+qwIi6u1WhHIME3Hp5NUTk8EXGd129HFdQswrlxHc9e4i
         pOrucP+jlaOz0lFT0zwg9S8kucjW8of4AHvifJscMCjOUGlEL/9VzvjMXRxWeYzDaGH+
         +m0c/qK/KhT5qQwvdbVt0BXUlHhTi4tG1W/Rkc61fVXSkOqtrW2nNs/xdXX6Nik7CC9/
         RVQmrh8QmetX5UzFx/TntUux2CfhN1kU66F0ri7FXm+SvH0zTp5v6NEsUBH5rRGd3PNL
         v8pA==
X-Gm-Message-State: AOAM532AviDLyiVPKfvQlO288PtLQN+oifDEcHaGuuMU2QChtlix9CSr
        Dn29a0Ojc/JsDPPKwxvUPcjQncrv3dg=
X-Google-Smtp-Source: ABdhPJxWWWQuwmxxv7qT6mU94toirjTBOKwjxi7sdSOqWkv+QHH/hAXbCM5wLN+DsnyGnN5Bs7fqXw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr22176559wmm.48.1593525095077;
        Tue, 30 Jun 2020 06:51:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 20/30] misc: mic: scif: scif_epd: Describe missing 'scifdev' argument(s)
Date:   Tue, 30 Jun 2020 14:51:00 +0100
Message-Id: <20200630135110.2236389-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

