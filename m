Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAC420774
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cN3/TPOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCTJbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:31:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:31:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so6580130wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxSCMf56EN6cVH20T+jGdX85jkdKPR+q8rPGaI1sQOs=;
        b=cN3/TPOJyvrD0HS5TBISYW40rh8nMYZ30j86g1z+T6XV+5RdbRTwVGZj5kouUMNZkO
         cRLcOwZNI6onvooo7dUMJNkveEKH4kpVjoDs5BfMQ2fgTXFjiD1Yjid8V2uYfzJ9Gyrd
         vH4I+ufH8ZBc58lN2p+/TlqehFjx0I7mIfgf1MTlhTvauKa6YkG78lRqq19W4TBpOK6g
         IyiCLSriyZolMW0bfPaZTiio/MksMpZPufpQllududTgJO7X8yI28h6XYX0k/kpLB2sz
         hEn/C92SqLu3YpKn3ZzwJsbo2EGeA0Nuj2Qel6/USPO+Mmv4qMtqG7TDBnmWcOuLEGyU
         YYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxSCMf56EN6cVH20T+jGdX85jkdKPR+q8rPGaI1sQOs=;
        b=eYEsGjhyOveCbynBLVspsWfwrDY/H3puJV6Ysww47qXMqOkxpAAJi+zE7n2iHDL6HR
         JR4PiK8uPHA0pWBgSo/xKyssP10IJZ1Fm3ithNSNPOd9mwX6gYd4CCuTzxRGxQdcVs55
         pfht6CZmGnqkJmywbfqXuAdimq617NT/EaUt7Bni8jXUyGeeQE+DWhSW+zloWTey9lsJ
         MrFXUtYQHG6Rwim59/TFsHtEk7kd28GM0XYhNUZ8Njjld/30nMvEVs7iHs5x1BaPrgeG
         orvTnyGfc8Z4V/RZ5PNEAcgoGT61QNUYaNxwuDIg2SCmYKRoZS9hQihHVUC69+xlUzd6
         gKhQ==
X-Gm-Message-State: ANhLgQ0WIsvFG0vC3zSzptMsPWz8hfn8VQWYkngB1lHYa9Qsl4c8Udn3
        RGlLlBo8bWonzi80TJFFKEXbglHKTTk=
X-Google-Smtp-Source: ADFU+vsj/SVyNNacr9nRaQjep8JEOA8OAU8YrfS+ziyRE+d8wiTXaRxN9AYeYVYAx9j7j4BYCFujRg==
X-Received: by 2002:adf:afcb:: with SMTP id y11mr9219120wrd.141.1584696688308;
        Fri, 20 Mar 2020 02:31:28 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id r3sm7734017wrm.35.2020.03.20.02.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 02:31:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
Date:   Fri, 20 Mar 2020 10:31:25 +0100
Message-Id: <20200320093125.23092-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We must not call pinctrl_gpio_can_use_line() with the gpio_lock taken
as it takes a mutex internally. Let's move the call before taking the
spinlock and store the return value.

This isn't perfect - there's a moment between calling
pinctrl_gpio_can_use_line() and taking the spinlock where the situation
can change but it isn't a regression either: previously this part wasn't
protected at all and it only affects the information user-space is
seeing.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d2ac25798208 ("gpiolib: provide a dedicated function for setting lineinfo")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 02f8b2b81199..ee20634a522c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1154,8 +1154,19 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 				  struct gpioline_info *info)
 {
 	struct gpio_chip *chip = desc->gdev->chip;
+	bool ok_for_pinctrl;
 	unsigned long flags;
 
+	/*
+	 * This function takes a mutex so we must check this before taking
+	 * the spinlock.
+	 *
+	 * FIXME: find a non-racy way to retrieve this information. Maybe a
+	 * lock common to both frameworks?
+	 */
+	ok_for_pinctrl = pinctrl_gpio_can_use_line(
+				chip->base + info->line_offset);
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	if (desc->name) {
@@ -1182,7 +1193,7 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
 	    test_bit(FLAG_EXPORT, &desc->flags) ||
 	    test_bit(FLAG_SYSFS, &desc->flags) ||
-	    !pinctrl_gpio_can_use_line(chip->base + info->line_offset))
+	    !ok_for_pinctrl)
 		info->flags |= GPIOLINE_FLAG_KERNEL;
 	if (test_bit(FLAG_IS_OUT, &desc->flags))
 		info->flags |= GPIOLINE_FLAG_IS_OUT;
-- 
2.25.0

