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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E4420870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR5ulAiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGLPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgEGLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:15:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCCC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:15:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so2844514pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q5Ur7h/8oNS0E2jiQqG3CicZ1bVNQn1Ydx7PFOHfa0s=;
        b=vR5ulAiFzgiMVcgSPCb6i5yphLLVEtvHKU/b5abZlIFH43323JlPd5KMMStpRnXzBh
         WaI6/rirsojCkduRRV/ISOPLZmdiIuEpB57Y1eFvwFAo8LqTyxDXcix6QMLHG7BFeobo
         jgZi1O968NO0xyNItwoWpBW2XGhT4JWh3z8hpxUjrVpoDc3RGTxwtkEfTzM5pn8eGh4h
         UQdlyay/n0BgUc6MZhoACDDKw6l24cg92w0h6UUWWg0eE2Prim1/PQhMkJcNBe6RLvi2
         XmVGQw0ZN0XpQToieiNZ50lWcepk2YyOIh4UtDooZjjoniNj8hGu+QqrRLEqcvwUpPvn
         uIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5Ur7h/8oNS0E2jiQqG3CicZ1bVNQn1Ydx7PFOHfa0s=;
        b=oHH5Byp1sRJhbVfysSyZ9y+eUZGiu12r5ufNdhRgi3ekSb547F8vs3mVUjA8L0IkLX
         Wb6tp2PPhoagIdWSiS6v/pHlmG1VWXNUSd/UE0OZS1noOlf9SL0IOWeNb+q5vp0x0oy2
         gUGV1sEHANaISiy53+fBvL01q2fcBRM92J/oJeqfQ9NsAl/bz5IDRtskke4GeR35VDBH
         LVlsIPJw40L/tXimBWggXCKEi5yccgKRJZV95y64/doIJiwvD/0FS0ZI/4+lp7o2gxcm
         BjLeCJS/LniSf6rVnBe1NnkQJBSSVpoIuYYFVppKNCAzrSUm5/OgvlCQVQLA+Vxad+oR
         ENZQ==
X-Gm-Message-State: AGi0PuZDbPCEdOXlWPpnhFRYaGDBgSuPht6U5K68/GY9PKjhVA8kR6Bx
        alO3DPKzDCxLlvYEDcApd5I=
X-Google-Smtp-Source: APiQypIkSq2sEnKfRxF2yLpUtwLsawR7IO0elGcrndZ1UHxIKE6n1f7LU+bM9YsoKY6q1jiE71yOWQ==
X-Received: by 2002:a63:f70e:: with SMTP id x14mr10338566pgh.394.1588850154438;
        Thu, 07 May 2020 04:15:54 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id d184sm4492752pfc.130.2020.05.07.04.15.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:15:53 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH V2 4/4] i2c: stm32f4: Fix stmpe811 get xyz data timeout issue
Date:   Thu,  7 May 2020 19:15:49 +0800
Message-Id: <1588850149-24393-1-git-send-email-dillon.minfei@gmail.com>
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

