Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C8C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896B1208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSsPcfh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEHBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbgEHBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:46:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22512C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:46:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so104127pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YPET1s2LAGhUOXmbuGCWG2lOM9gQW5zcHOoGqo8jUto=;
        b=gSsPcfh/FmLMFO8F/e1XknD3JIM2pA62uVJim6lR2mvj0H1qriC2lddSShZQTFLpbY
         ALw0zklxxW1C0syHhLZO2+HYLZng52g4CfsVoJ3VW6AHVJm7uDAOKY1flF+qs3Wf4Bm3
         eYVMWT+7t8DVeBipQXFDhXGzYD0K5D05DbdOKzIciLjmKU3zbXSojG+zQhsapme9TtBo
         MQjQyMNYSaK+W7ffUF/dJgIoVxP+jeLbxOdzrVzRrioPKheevGY/2FpVBSHWY141IHyo
         9qMhhKzSM+Hbij//nWhXsryAL1LwtW1EC7hJXAkv0WFfynXz+yrvWmBVhTwDL56YQXWD
         E8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YPET1s2LAGhUOXmbuGCWG2lOM9gQW5zcHOoGqo8jUto=;
        b=UQ0Z67sBgoFb/dzkZ7mpy/PRqxXEoM5PT3ybDqTWBsBy/JryD7SZgncwbQv7eMJ5YT
         Lj6wDk1dr5wbCoM9s+I2y8slwK7kUIssIo5MrP839E4wy6jQCbG9vfDJQgOEqWgBg50Q
         z8kb+QtyMYQBfNI7foaK+2NLTiYOoEDdFSiLvVtwqI/dfXlmon2A6y9lTr4dg74ahE7H
         U5cCRS7hAsocLaUXsWRfAMv0hDftXcLfg6LeW/xpkENvGiOlwfzDIK4jwxgafEj7ynRp
         9caXZf6FjPZmKBfZVc0XZzbQClWrXSgrEpo15QHsQf2cf5jZeLBaGszQzkqnrf3uBCDl
         i9gg==
X-Gm-Message-State: AGi0PubXlSu2FwXlnccLa5WW76NbYOT6g/oIZzSM8h2BRYRHswhPhyty
        Mp7lelS+CMrIBvQ6Xeh9HeoCQYUT23g=
X-Google-Smtp-Source: APiQypJTjw+dOAM1QqLaOQi5CNvwAe4OCmBIbk8z5yExLAvE6gesJhmfV1ZtLIG3s6h+kBM4io2Szw==
X-Received: by 2002:a63:6cf:: with SMTP id 198mr128652pgg.59.1588902403750;
        Thu, 07 May 2020 18:46:43 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id f74sm9270816pje.3.2020.05.07.18.46.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 18:46:43 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 4/4] i2c: stm32f4: Fix stmpe811 get xyz data timeout issue
Date:   Fri,  8 May 2020 09:46:28 +0800
Message-Id: <1588902388-4596-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
References: <1588902388-4596-1-git-send-email-dillon.minfei@gmail.com>
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
in xip mode, have to adjust 'STOP/START bit set position' from last two
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

