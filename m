Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB85C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A320721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hHjJni+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBCNae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:30:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so18094498wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1f5bwMzVaB6wRo16QwdapcC/oluekqbfNJd6d0tVIEc=;
        b=hHjJni+TEKfxWEycbKNRTiT691geYQs4q46qUwNY1c6FnG6Rh757MTHBwgCgbC45/h
         EFR1bWidEOjlaPcGxP/Nf+/yp1DNqAhsj8Dxkch2EiAuZ3jXG+jPuS3HTh60/AnuUNaW
         qDwWXisqn6gbZBYkyrQZtx8jkm26KC547/ppdAHN7lndwBfQYFiKFDduVwLo89MZRYhO
         81epeNGx85akoRGsibe+xj+a+EVow+yQbPp8IGDth/UDp+2qkHbo3aa9yMK03sqDjXfI
         FfCN5GkMi2I5D6b8P+Pn8uqk2frmHjgPzpVOCkkxVjztBHMRas3WuF2TueQWxcvEfSyN
         RaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f5bwMzVaB6wRo16QwdapcC/oluekqbfNJd6d0tVIEc=;
        b=QXRiVk9lAbsUjALrve5RdyftzcKpEpYtT0xJ6UQ4lo4sTfvjfxSFc8wOb2s0WuArZj
         nUi7YyZ5c3pBE238uW5VedToJYbMOnWjo2WSztym1FyEuEElMJYmg/7tS7An03lHlJvJ
         qaGKeMDciFggh3QT8X5cvcbfjUQY65uw7SqFe8Bll2IRdrU6k2Kwd3r0psGzIUcpMRfp
         kWVkAA9irKeeblTkk6yKCOLb1NVQq4lZn72qnT8zf22rb/z8koFjK0PsfdHwQiJ6n0VO
         /3cH263HL0Ru4xOangm9qi1Xqpr8xejmk4YghXbgiKZ+7u62Rgy4xt7oDTEmUuYyMxjY
         K0dg==
X-Gm-Message-State: APjAAAW0FoM+9RQ870P3rWPrtKq4G/VzVxiyY9U8OwyFhMhEzyMkrfXl
        bVn/d0PvnkE5t1sBkVjH3OAXvA==
X-Google-Smtp-Source: APXvYqwihlTRAqU8L8rfD0ugl/hZaBWyHcy/FdrAqB8p6pd6Yd/bh6D5rLLXZ7T4GAbg+1ckLg6yew==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr16579664wrn.128.1580736632030;
        Mon, 03 Feb 2020 05:30:32 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id l8sm7594540wmj.2.2020.02.03.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:30:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] Revert "gpiolib: Remove duplicated function gpio_do_set_config()"
Date:   Mon,  3 Feb 2020 14:30:24 +0100
Message-Id: <20200203133026.22930-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200203133026.22930-1-brgl@bgdev.pl>
References: <20200203133026.22930-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This reverts commit d18fddff061d2796525e6d4a958cb3d30aed8efd.

This patch came on top of another patch that introduced a regression.
Revert it before addressing the culprit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 99ac27a72e28..0673daeaca00 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3035,8 +3035,8 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
-			   enum pin_config_param mode)
+static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
+			      enum pin_config_param mode)
 {
 	if (!gc->set_config)
 		return -ENOTSUPP;
@@ -3044,6 +3044,25 @@ static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 	return gc->set_config(gc, offset, mode);
 }
 
+static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+			   enum pin_config_param mode)
+{
+	unsigned arg;
+
+	switch (mode) {
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_PULL_UP:
+		arg = 1;
+		break;
+
+	default:
+		arg = 0;
+	}
+
+	return gpio_do_set_config(gc, offset, mode);
+}
+
 static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
 {
 	int bias = 0;
@@ -3277,7 +3296,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 	chip = desc->gdev->chip;
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpio_set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -3311,7 +3330,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
 					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = gpio_set_config(chip, gpio, packed);
+	rc = gpio_do_set_config(chip, gpio, packed);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
-- 
2.23.0

