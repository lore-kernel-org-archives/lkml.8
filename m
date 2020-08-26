Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B113C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E0C2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPXbrPtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHZUYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:23:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C658C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:23:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so3847665ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcpNf393ZHztBuMptBRkTJAw3OEg7shY12GozUNXJLY=;
        b=aPXbrPtDX0slok8AaCw10OiyWHR9ecuUvIICS3JJsRN4f+hy2j/O86QjfMglSNTJT4
         kEWXYBxNbfO7Bqyd0JiTBDNKGQ5x66nZW4X1BLrmzxMb7kMBQPPQEs2I/sQ3wViwWO62
         ELeNCzjPthniBbI07LyDeYB/ERz6metmq/HepHgv9NiIOZGIoF7ITeTSrvXQ3mp+Z0J0
         QyBWo094u7v0Wg8ntvi2dFh+vRAE3KjYGeXXcV9y2zqREuAtVJ08olPm72P1kJ9gJaU2
         WiwnOwogBTzhIfb0sxpaCbyPYTTDv0WgWoR4jxarbcN2Sv3aysMfW8YxLnE7mgV3NZ1N
         eQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcpNf393ZHztBuMptBRkTJAw3OEg7shY12GozUNXJLY=;
        b=nAlTWXbVlXqJL2dMxqhmeQ85KP9B/gkXnnzOQryO5U+3PKF3unrTik+rmVA3hfJ/XJ
         8rkZ8SHcRDb8TUKsfyw71eNdzYxd1EdF9qR6NlBPrWKypSO5kTacwkopT+O2E4drp84/
         l0ECpoR/6+Zoq+/9UKum4wVJ9s2p1JjoyUSCBlsZ3Vmzrx1EZp0TrBiXheKIePBdTBdr
         bV465qdQUODESJYcv/BY0e9fGwCYkNJw1Cm6CTWSQm+q7e8zRFTpfqx1TMkCY3ivvAVQ
         DnC52m9ODp53NycpE5vORnC7S53MZnRd1tkA36kqS7+NGtj6k2mkXC9ZqwBjHSk696oL
         9Esw==
X-Gm-Message-State: AOAM530UR0uqGBcjRIepMUqRg3PSnB/z3HkLQJL12OBRZStwceA5Y8AK
        K1Tb107jGtWOTlLuS7d1Wgsux1WuHy3cVw==
X-Google-Smtp-Source: ABdhPJxQjep7vpmpxjmYJA545N97/jQ0anRZvgoU2X0pG3NY9tZQrmDZexIWZlYNHBHuWixYrX4muw==
X-Received: by 2002:a2e:9f4e:: with SMTP id v14mr8503473ljk.72.1598473435416;
        Wed, 26 Aug 2020 13:23:55 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j6sm722576lja.23.2020.08.26.13.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:23:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] mfd: dm355evm_msp: Convert LEDs to GPIO descriptor table
Date:   Wed, 26 Aug 2020 22:21:49 +0200
Message-Id: <20200826202149.174815-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the DaVinci DM355EVM LEDs to use GPIO
descriptor look-ups.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Moved out all the tables and device definition to the top
  of the file to not have static locals inside the function.
---
 drivers/mfd/dm355evm_msp.c | 76 +++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 151c36ce7343..54fb6cbd2aa0 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/mfd/dm355evm_msp.h>
@@ -116,6 +117,54 @@ static const u8 msp_gpios[] = {
 	MSP_GPIO(4, SDMMC), MSP_GPIO(3, SDMMC),	/* mmc1 WP, nCD */
 };
 
+static struct gpio_led evm_leds[] = {
+	{ .name = "dm355evm::ds14",
+	  .default_trigger = "heartbeat", },
+	{ .name = "dm355evm::ds15",
+	  .default_trigger = "mmc0", },
+	{ .name = "dm355evm::ds16",
+	  /* could also be a CE-ATA drive */
+	  .default_trigger = "mmc1", },
+	{ .name = "dm355evm::ds17",
+	  .default_trigger = "nand-disk", },
+	{ .name = "dm355evm::ds18", },
+	{ .name = "dm355evm::ds19", },
+	{ .name = "dm355evm::ds20", },
+	{ .name = "dm355evm::ds21", },
+};
+
+static struct gpio_led_platform_data evm_led_data = {
+	.num_leds	= ARRAY_SIZE(evm_leds),
+	.leds		= evm_leds,
+};
+
+static struct gpiod_lookup_table evm_leds_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		/*
+		 * These GPIOs are on the dm355evm_msp
+		 * GPIO chip at index 0..7
+		 */
+		GPIO_LOOKUP_IDX("dm355evm_msp", 0, NULL,
+				0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 1, NULL,
+				1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 2, NULL,
+				2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 3, NULL,
+				3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 4, NULL,
+				4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 5, NULL,
+				5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 6, NULL,
+				6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("dm355evm_msp", 7, NULL,
+				7, GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 #define MSP_GPIO_REG(offset)	(msp_gpios[(offset)] >> 3)
 #define MSP_GPIO_MASK(offset)	BIT(msp_gpios[(offset)] & 0x07)
 
@@ -260,32 +309,7 @@ static int add_children(struct i2c_client *client)
 
 	/* LED output */
 	if (msp_has_leds()) {
-#define GPIO_LED(l)	.name = l, .active_low = true
-		static struct gpio_led evm_leds[] = {
-			{ GPIO_LED("dm355evm::ds14"),
-				.default_trigger = "heartbeat", },
-			{ GPIO_LED("dm355evm::ds15"),
-				.default_trigger = "mmc0", },
-			{ GPIO_LED("dm355evm::ds16"),
-				/* could also be a CE-ATA drive */
-				.default_trigger = "mmc1", },
-			{ GPIO_LED("dm355evm::ds17"),
-				.default_trigger = "nand-disk", },
-			{ GPIO_LED("dm355evm::ds18"), },
-			{ GPIO_LED("dm355evm::ds19"), },
-			{ GPIO_LED("dm355evm::ds20"), },
-			{ GPIO_LED("dm355evm::ds21"), },
-		};
-#undef GPIO_LED
-
-		struct gpio_led_platform_data evm_led_data = {
-			.num_leds	= ARRAY_SIZE(evm_leds),
-			.leds		= evm_leds,
-		};
-
-		for (i = 0; i < ARRAY_SIZE(evm_leds); i++)
-			evm_leds[i].gpio = i + dm355evm_msp_gpio.base;
-
+		gpiod_add_lookup_table(&evm_leds_gpio_table);
 		/* NOTE:  these are the only fully programmable LEDs
 		 * on the board, since GPIO-61/ds22 (and many signals
 		 * going to DC7) must be used for AEMIF address lines
-- 
2.26.2

