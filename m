Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C42C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F8A2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgAPO3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:29:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbgAPO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:29:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2DF8B5B4D71153D8AD43;
        Thu, 16 Jan 2020 22:29:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 22:29:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] gpiolib: Remove duplicated function gpio_do_set_config()
Date:   Thu, 16 Jan 2020 22:29:27 +0800
Message-ID: <20200116142927.58908-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_set_config() simply call gpio_do_set_config(),
so remove the duplicated function.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpio/gpiolib.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0630059..e9f168b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3058,8 +3058,8 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
-			      enum pin_config_param mode)
+static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+			   enum pin_config_param mode)
 {
 	if (!gc->set_config)
 		return -ENOTSUPP;
@@ -3067,25 +3067,6 @@ static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
 	return gc->set_config(gc, offset, mode);
 }
 
-static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
-			   enum pin_config_param mode)
-{
-	unsigned arg;
-
-	switch (mode) {
-	case PIN_CONFIG_BIAS_DISABLE:
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = 1;
-		break;
-
-	default:
-		arg = 0;
-	}
-
-	return gpio_do_set_config(gc, offset, mode);
-}
-
 static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
 {
 	int bias = 0;
@@ -3319,7 +3300,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 	chip = desc->gdev->chip;
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -3353,7 +3334,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
 					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = gpio_do_set_config(chip, gpio, packed);
+	rc = gpio_set_config(chip, gpio, packed);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
-- 
2.7.4


