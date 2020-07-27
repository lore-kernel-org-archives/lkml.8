Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38945C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A24420738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTEt2lrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgG0Haw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0Haw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:30:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F3C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:30:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so16055887ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5fEgGpWVjcw3GRcV8W7F39oPVxz0g7j7zQ9WmB3YxM=;
        b=wTEt2lrn6iDyN6guMCNKvxo53XxAT/Od7zPDoyQMdhtpeUAX5wPigM0QD2nn4VpV0T
         +tga4M2lbQ6K5gxHGjd8/VLgGkQX7lAM3tHTJBM1pxUcxnOGI6BqxL63qLaiQG9u2liO
         JVghUkOvKiBdsSaZadHafzaz5HjI/2NKxUJOMT60/hhY5GaHUKodBPAJnt19a06CiTGE
         59gEeAq1r2nAVNCw+kIh0UQbCxP0B9d7rLbfIFmXLz2EU7V8XJKb5m5rLrsrk1Tx1PTY
         5gpTqQmgjqLg13zQ50BY7xmTeD8ybY8kVvVgm/KrLci13tpk34460t8OjNi3bwA+i4rA
         RUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5fEgGpWVjcw3GRcV8W7F39oPVxz0g7j7zQ9WmB3YxM=;
        b=Rt/27YecUwVpmqksEiTck+r+6WONI966rha//tLi1nZd5BHRObhiV8B6NJmF5wpDc+
         4cgPZz/4SKtKswJIlP475ucMKXtZh4glgqVyC+uYLVW4WlHPn0sfbFO1NON/mjzlaBZK
         madHSJDRZg/KnwegadSmcV5M55Rwtu0EJjXf/+3WyNPqNJrduDsBWkw/gqHo0EsCRBp/
         g2Y0epRaUWdQiZ9vLpS/axXfngTX9V2iVGWQocwfFZlclsQOb36ofwQn/oxKZCH/PIWY
         mk5ZI7OGu2xcNdGRIo3Y595KLlnV5i33OtChjM1B4eOvGDrjeq/53m+tITQ0W0yKRN7E
         q5RQ==
X-Gm-Message-State: AOAM5313q3KNlbqpmILqHO+FnTsgCLV7KHG+fFTWw8r8DZaYoJdopWuC
        TrwcBl/MlRUhBHFcIFcMSct3zw==
X-Google-Smtp-Source: ABdhPJyuLjVh2cOZgL9pZNyZcOlOQDP8GFllPafx2uYt1/WePcdJCVxUQEx21L80AXYxJIgK2bmYOQ==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr10116088ljj.424.1595835049441;
        Mon, 27 Jul 2020 00:30:49 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id b204sm2840514lfd.48.2020.07.27.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:30:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] mfd: dm355evm_msp: Convert LEDs to GPIO descriptor table
Date:   Mon, 27 Jul 2020 09:28:44 +0200
Message-Id: <20200727072844.195723-1-linus.walleij@linaro.org>
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
 drivers/mfd/dm355evm_msp.c | 49 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 151c36ce7343..af24712d605e 100644
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
@@ -260,31 +261,55 @@ static int add_children(struct i2c_client *client)
 
 	/* LED output */
 	if (msp_has_leds()) {
-#define GPIO_LED(l)	.name = l, .active_low = true
 		static struct gpio_led evm_leds[] = {
-			{ GPIO_LED("dm355evm::ds14"),
+			{ .name = "dm355evm::ds14",
 				.default_trigger = "heartbeat", },
-			{ GPIO_LED("dm355evm::ds15"),
+			{ .name = "dm355evm::ds15",
 				.default_trigger = "mmc0", },
-			{ GPIO_LED("dm355evm::ds16"),
+			{ .name = "dm355evm::ds16",
 				/* could also be a CE-ATA drive */
 				.default_trigger = "mmc1", },
-			{ GPIO_LED("dm355evm::ds17"),
+			{ .name = "dm355evm::ds17",
 				.default_trigger = "nand-disk", },
-			{ GPIO_LED("dm355evm::ds18"), },
-			{ GPIO_LED("dm355evm::ds19"), },
-			{ GPIO_LED("dm355evm::ds20"), },
-			{ GPIO_LED("dm355evm::ds21"), },
+			{ .name = "dm355evm::ds18", },
+			{ .name = "dm355evm::ds19", },
+			{ .name = "dm355evm::ds20", },
+			{ .name = "dm355evm::ds21", },
 		};
-#undef GPIO_LED
 
 		struct gpio_led_platform_data evm_led_data = {
 			.num_leds	= ARRAY_SIZE(evm_leds),
 			.leds		= evm_leds,
 		};
 
-		for (i = 0; i < ARRAY_SIZE(evm_leds); i++)
-			evm_leds[i].gpio = i + dm355evm_msp_gpio.base;
+		static struct gpiod_lookup_table evm_leds_gpio_table = {
+			.dev_id = "leds-gpio",
+			.table = {
+				/*
+				 * These GPIOs are on the dm355evm_msp
+				 * GPIO chip at index 0..7
+				 */
+				GPIO_LOOKUP_IDX("dm355evm_msp", 0, NULL,
+						0, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 1, NULL,
+						1, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 2, NULL,
+						2, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 3, NULL,
+						3, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 4, NULL,
+						4, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 5, NULL,
+						5, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 6, NULL,
+						6, GPIO_ACTIVE_LOW),
+				GPIO_LOOKUP_IDX("dm355evm_msp", 7, NULL,
+						7, GPIO_ACTIVE_LOW),
+				{ },
+			},
+		};
+
+		gpiod_add_lookup_table(&evm_leds_gpio_table);
 
 		/* NOTE:  these are the only fully programmable LEDs
 		 * on the board, since GPIO-61/ds22 (and many signals
-- 
2.26.2

