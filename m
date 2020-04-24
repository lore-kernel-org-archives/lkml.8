Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB921C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A84D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgDXOPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgDXOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:15:20 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A52C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:15:19 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:8134:2f28:3a79:6257])
        by laurent.telenet-ops.be with bizsmtp
        id WeFJ2200D3LKRvX01eFJ3n; Fri, 24 Apr 2020 16:15:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jRz6s-0007cX-Cv; Fri, 24 Apr 2020 16:15:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jRz6s-00031n-Ay; Fri, 24 Apr 2020 16:15:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpiolib: Rename "chip" variables to "gc" in core header file
Date:   Fri, 24 Apr 2020 16:15:17 +0200
Message-Id: <20200424141517.11582-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently use "gc" for "struct gpio *" variables.

This follows the spirit of commit a0b66a73785ccc8f ("gpio: Rename
variable in core APIs").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 853ce681b4a4139d..9ed242316414057d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -81,8 +81,7 @@ struct gpio_array {
 	unsigned long		invert_mask[];
 };
 
-struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
-				    unsigned int hwnum);
+struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
@@ -163,18 +162,18 @@ static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 
 /* With chip prefix */
 
-#define chip_emerg(chip, fmt, ...)					\
-	dev_emerg(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
-#define chip_crit(chip, fmt, ...)					\
-	dev_crit(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
-#define chip_err(chip, fmt, ...)					\
-	dev_err(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
-#define chip_warn(chip, fmt, ...)					\
-	dev_warn(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
-#define chip_info(chip, fmt, ...)					\
-	dev_info(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
-#define chip_dbg(chip, fmt, ...)					\
-	dev_dbg(&chip->gpiodev->dev, "(%s): " fmt, chip->label, ##__VA_ARGS__)
+#define chip_emerg(gc, fmt, ...)					\
+	dev_emerg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define chip_crit(gc, fmt, ...)					\
+	dev_crit(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define chip_err(gc, fmt, ...)					\
+	dev_err(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define chip_warn(gc, fmt, ...)					\
+	dev_warn(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define chip_info(gc, fmt, ...)					\
+	dev_info(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define chip_dbg(gc, fmt, ...)					\
+	dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
 
 #ifdef CONFIG_GPIO_SYSFS
 
-- 
2.17.1

