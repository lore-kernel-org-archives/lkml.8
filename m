Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1502CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E610820774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miEUbzjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgFIN1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgFIN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:27:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB6C03E97C;
        Tue,  9 Jun 2020 06:27:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so10075016pfn.3;
        Tue, 09 Jun 2020 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSIhf0lGTJhWcv+DccCkvFsMqMLpno9qIeBkBoJLMSQ=;
        b=miEUbzjcd4ryUuKvQRtvf6dPM1igWZ99p8Q6FEwRjbx4OnKVBKqoYcgFbYQa5F0CiQ
         rad6clrM7rHVgJjWaSGo+06n0jk3qugJoFhZ4uC0qWxdyIT7OsuLI2/YDruuF8Z4O1tE
         3XN5SBV4IyX/VaBuWAY0GE0AqxS6UYPKNE6P36cTd2+X9MqvjpDifrfLKMc7i/xQMqjI
         0Jpz/z0K3veRZWdMO4osYMwcAjH9FlU16JqTA5cQjsc0gOOqUvfPxAU2tZRhWde0L8Zi
         TU7lbJxux9j2OvqpbG0zJUIieSCW7zCWuGtwSDwgsR2FLhku1pZlyh+CPVWh2iayMnyj
         JFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSIhf0lGTJhWcv+DccCkvFsMqMLpno9qIeBkBoJLMSQ=;
        b=QlHxvw72+rQXqChrF6J1Rkbftgb0XvH1WCWi/a2IvjEPKBD0wB2OUCWRSbz8la4BqW
         49HiiS0rJrUyluBXxePnpz2/xUu+5Jp1STYzjg6+nXSpq1U98XwRHwtdLvqb9yQgnyCC
         DC6L7rcdcVEgJv8qaMN2Arf8KVV1J/kdWNRXwNdcePVEioc6qh92rCenu4whBKG91GpD
         hw8PF5Ovzdjxlx0dv4ntOe69d2Ql16iIVF5nAr7DihdOwHisL88f27sf2XDPmD449/FQ
         eyT3cLrgCXqBx33z4ygW5WbR3m/Q6I6umfu3ofrbmk8tP1vs4WfI2fFZNOQB/ZIWoh0g
         OA/g==
X-Gm-Message-State: AOAM531wwOMYVSKgmRI6axUdpHB1j79F7UutAqjmDSIT1sZ1v8SFx4SK
        PfKPSFcvhhIabD+AaJKd670=
X-Google-Smtp-Source: ABdhPJygotx9ln59z0STkYKtMU1xO9pxH7iXYS1GxlB8u1JiD2/tkQhL5M40gjWnv1oxbN80JE9mRA==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr23872632pgn.378.1591709222448;
        Tue, 09 Jun 2020 06:27:02 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.42])
        by smtp.gmail.com with ESMTPSA id b5sm2624348pjz.34.2020.06.09.06.26.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:27:02 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, p.zabel@pengutronix.de,
        pierre-yves.mordret@st.com, philippe.schenker@toradex.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 4/4] i2c: stm32f4: Fix stmpe811 get xyz data timeout issue
Date:   Tue,  9 Jun 2020 21:26:43 +0800
Message-Id: <1591709203-12106-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591709203-12106-1-git-send-email-dillon.minfei@gmail.com>
References: <1591709203-12106-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

as stm32f429's internal flash is 2Mbytes and compiled kernel
image bigger than 2Mbytes, so we have to load kernel image
to sdram on stm32f429-disco board which has 8Mbytes sdram space.

based on above context, as you knows kernel running on external
sdram is more slower than internal flash. besides, we need read 4
bytes to get touch screen xyz(x, y, pressure) coordinate data in
stmpe811 interrupt.

so, in stm32f4_i2c_handle_rx_done, as i2c read slower than running
in xip mode, have to adjust 'STOP/START bit set position' from last
two bytes to last one bytes. else, will get i2c timeout in reading
touch screen coordinate.

to not take side effect, introduce IIC_LAST_BYTE_POS to support xip
kernel or has mmu platform.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

V4: indroduce 'IIC_LAST_BYTE_POS' to compatible with xipkernel boot

 drivers/i2c/busses/i2c-stm32f4.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index d6a69dfcac3f..97cf42ae7fa0 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -93,6 +93,12 @@
 #define STM32F4_I2C_MAX_FREQ		46U
 #define HZ_TO_MHZ			1000000
 
+#if !defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
+#define IIC_LAST_BYTE_POS 1
+#else
+#define IIC_LAST_BYTE_POS 2
+#endif
+
 /**
  * struct stm32f4_i2c_msg - client specific data
  * @addr: 8-bit slave addr, including r/w bit
@@ -439,7 +445,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 	int i;
 
 	switch (msg->count) {
-	case 2:
+	case IIC_LAST_BYTE_POS:
 		/*
 		 * In order to correctly send the Stop or Repeated Start
 		 * condition on the I2C bus, the STOP/START bit has to be set
@@ -454,7 +460,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 		else
 			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
 
-		for (i = 2; i > 0; i--)
+		for (i = IIC_LAST_BYTE_POS; i > 0; i--)
 			stm32f4_i2c_read_msg(i2c_dev);
 
 		reg = i2c_dev->base + STM32F4_I2C_CR2;
@@ -463,7 +469,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 
 		complete(&i2c_dev->complete);
 		break;
-	case 3:
+	case (IIC_LAST_BYTE_POS+1):
 		/*
 		 * In order to correctly generate the NACK pulse after the last
 		 * received data byte, we have to enable NACK before reading N-2
-- 
2.7.4

