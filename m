Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9184C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA92078D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCYKEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:04:46 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:59658 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCYKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:04:45 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id Ja4k220035USYZQ01a4kxT; Wed, 25 Mar 2020 11:04:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jH2tw-00033y-2V; Wed, 25 Mar 2020 11:04:44 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jH2tw-0003ei-1c; Wed, 25 Mar 2020 11:04:44 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] gpiolib: Remove unused gpio_chip parameter from gpio_set_bias()
Date:   Wed, 25 Mar 2020 11:04:39 +0100
Message-Id: <20200325100439.14000-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325100439.14000-1-geert+renesas@glider.be>
References: <20200325100439.14000-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_set_bias() no longer uses the passed gpio_chip pointer parameter.
Remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8eeb29de12cb5811..7e3c19bd21cdf327 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3264,7 +3264,7 @@ static int gpio_set_config(struct gpio_desc *desc, enum pin_config_param mode)
 	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 
-static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
+static int gpio_set_bias(struct gpio_desc *desc)
 {
 	int bias = 0;
 	int ret = 0;
@@ -3330,7 +3330,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	}
 	if (ret == 0) {
 		clear_bit(FLAG_IS_OUT, &desc->flags);
-		ret = gpio_set_bias(chip, desc);
+		ret = gpio_set_bias(desc);
 	}
 
 	trace_gpio_direction(desc_to_gpio(desc), 1, ret);
@@ -3414,7 +3414,6 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
-	struct gpio_chip *gc;
 	int ret;
 
 	VALIDATE_DESC(desc);
@@ -3432,7 +3431,6 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 		return -EIO;
 	}
 
-	gc = desc->gdev->chip;
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_DRAIN);
@@ -3458,7 +3456,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 	}
 
 set_output_value:
-	ret = gpio_set_bias(gc, desc);
+	ret = gpio_set_bias(desc);
 	if (ret)
 		return ret;
 	return gpiod_direction_output_raw_commit(desc, value);
-- 
2.17.1

