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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A3C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE552075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNK4mY30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGHry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:47:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D696C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:47:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so2619303pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q5Ur7h/8oNS0E2jiQqG3CicZ1bVNQn1Ydx7PFOHfa0s=;
        b=nNK4mY30ZNBYGbfOU+9i5o2jliUC1LdhvxIJ2ZO87SudcPGAnnFGXbZTMsiXEhwf7m
         Jxa73CekYqgCYnngBhiH1dCEkQZx5geSyKkBb4tD3ed0mreP1TbtJF6I7utnMGZuxlJv
         UODBWl6EmEvGefGxcmQyFBCQHVuBAYlKkj8VIut7+kLcEFiUF9992hEEULeLWFjr8smb
         6fTBJ/6SdubUjWLX2TdgTQd6rFTb7xmuk6po5xbC9TphHS4l5Wu+/tjRoN7j98f/G8n4
         XX7RU/9p/ZlZQR8NDpC6S+VulMYfNZti2D9v2v+LZAwczBAjrT0ZAigxbfSzHUbTgaya
         g8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5Ur7h/8oNS0E2jiQqG3CicZ1bVNQn1Ydx7PFOHfa0s=;
        b=hfiHATlCIzGIJGfmcHpYqR9roN8IAIvgT/dxI30DLxl2ssM6odf+C2Ty3zwMr7KRV+
         jp3DFRCmdyvRnwm8K9M1MTWoX3me9CrkvAatZZMKxvoG7kRe0yrOjla7zC0HBWbQbXSP
         OyBjoz/6ar3r/jbsR9UPzpVLlhiRCESiGTi7QVtznQ66phoSL9VttxygB0TJxfPArntz
         Gqma+m0HG58LDu0oP12dIhsicFrMZeE0GPPPNSij6Fo0JWNURaTQrGeZDG7t9sValtTc
         gtZ+c+BHOg0Xns13R1I8qiJ/2AfUH/mNt+Fn1Q9ONWnm9TN5ywiH5IbUcZoC2YOvDOfh
         lOrg==
X-Gm-Message-State: AGi0PuZP607c246ueRnDH2MjdJHlcpgDILDGmq3zowIEPC5eW+M3LyeF
        bYdULl2p4e1qYWk0v6XKDUU=
X-Google-Smtp-Source: APiQypK4+BjtFPLf7XUZYBks21yWMjx7sY/apqXRD4CHcybnZTffrS+tMmDbVXT+H0leMJa4udLt0A==
X-Received: by 2002:a63:41c2:: with SMTP id o185mr10336106pga.139.1588837673184;
        Thu, 07 May 2020 00:47:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id w192sm1146271pff.126.2020.05.07.00.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:47:52 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 4/4] i2c: stm32f4: Fix stmpe811 get xyz data timeout issue
Date:   Thu,  7 May 2020 15:47:49 +0800
Message-Id: <1588837669-14362-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

As stm32f429's internal flash is 2Mbytes and compiled kernel
image bigger than 2Mbytes, so we have to load kernel image
to sdram on stm32f429-disco board which has 8Mbytes sdram space.

based on above context, as you knows kernel running on external
sdram is more slower than internal flash. besides, we need read 4
bytes to get touch screen xyz(x, y, pressure) coordinate data in
stmpe811 interrupt.

so, in stm32f4_i2c_handle_rx_done, as i2c read slower than running
in xip mode, have to adjust 'STOP/START bit set time' from last two
bytes to last one bytes. else, will get i2c timeout in reading
touch screen coordinate.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index d6a69df..83004f2 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -439,7 +439,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 	int i;
 
 	switch (msg->count) {
-	case 2:
+	case 1:
 		/*
 		 * In order to correctly send the Stop or Repeated Start
 		 * condition on the I2C bus, the STOP/START bit has to be set
@@ -454,7 +454,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 		else
 			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
 
-		for (i = 2; i > 0; i--)
+		for (i = 1; i > 0; i--)
 			stm32f4_i2c_read_msg(i2c_dev);
 
 		reg = i2c_dev->base + STM32F4_I2C_CR2;
@@ -463,7 +463,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 
 		complete(&i2c_dev->complete);
 		break;
-	case 3:
+	case 2:
 		/*
 		 * In order to correctly generate the NACK pulse after the last
 		 * received data byte, we have to enable NACK before reading N-2
-- 
2.7.4

