Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5FBC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E9820842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DCSekVjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBKJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:19:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgBKJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:19:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so11304351wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bjFfRaoe6bcpA5LjoqOnbJHbr4ACu2dba3wQsv/x2w=;
        b=DCSekVjSd7fSXHWSfN56ZjRrP6nb6vnCkyuN6FadddxCIsATDvTwBAU5Teo8A76x9q
         Ysb1TvTN+u3n0x9jmZPHPQGd9ILKMeeXmVKG+z9O0WH9JxE5dKCvpSszm6PDQInr3DGM
         /woq5HSnZMKrG4hOpZG3b4eIxU/W9c+5aXzzqzhwQgDgdBClVpr0v8+TDNjhcg2ibjtQ
         W5P+BBKRY19Bx9ay49+N6kWmsun83mPpgh8JSNLypjAcSOCoQ4nZnSxXy5+SUkRCtI/s
         NmnAN6Ts4lFLSBMkxATOkj9d1el+1iJ64g53X4iOZ/3+Rtn45iJS1dePmfDh66eQkfax
         pv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bjFfRaoe6bcpA5LjoqOnbJHbr4ACu2dba3wQsv/x2w=;
        b=XbNR9uOHCB3hmBrTQ7cHirdAyZ+H8kdkol3hLx90Q4yibb4fbUgRgURurfQeTAhmUU
         ry5SXW5AdfD5tzYItqIRZB3sh92NmaZzFZO7GpCZe/YhrrSVMz1+ztYL75UysZuq+jhO
         2vShkBX4ldvshqTzIVn0OjCLIXjcvWJOIM8ONIyKgXMKPJFMTakjr6l+u5991MOLqHMv
         JfTsdG8yc13l9dw+4lCLBJo1I8vI8X0ay5pBBYzTVcvCdxoXk+WjE+G9kixgKBNlBXWe
         P9DPJUPWyDZkByxxcB0jx4efLbHfcwGs5HNRSPkYr5WXjIzceYQhqoEDMkRpaKP5MmFM
         PCDw==
X-Gm-Message-State: APjAAAXX48QjmtSq/vqaxdVhSEyA0iU2mEBHDFMKYIFkkvWenS0KQN1K
        QbQbGLWvH4UgyuqcA87P5t7IrvbUDi4=
X-Google-Smtp-Source: APXvYqyGAVF3BRS+q0BcnATJlRGGbeHehL4U1NWQRRiEkexDOaZXvjP/DVG2Eiuvs0pU1eX2qz097Q==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr7339360wre.404.1581412790421;
        Tue, 11 Feb 2020 01:19:50 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id y131sm2958622wmc.13.2020.02.11.01.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:19:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 5/7] gpiolib: provide a dedicated function for setting lineinfo
Date:   Tue, 11 Feb 2020 10:19:35 +0100
Message-Id: <20200211091937.29558-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211091937.29558-1-brgl@bgdev.pl>
References: <20200211091937.29558-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon be filling out the gpioline_info structure in multiple
places. Add a separate function that given a gpio_desc sets all relevant
fields.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 98 ++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 36afe0b2b150..443321f9cf63 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1147,6 +1147,60 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	return ret;
 }
 
+static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
+				  struct gpioline_info *info)
+{
+	struct gpio_chip *chip = desc->gdev->chip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	if (desc->name) {
+		strncpy(info->name, desc->name, sizeof(info->name));
+		info->name[sizeof(info->name) - 1] = '\0';
+	} else {
+		info->name[0] = '\0';
+	}
+
+	if (desc->label) {
+		strncpy(info->consumer, desc->label, sizeof(info->consumer));
+		info->consumer[sizeof(info->consumer) - 1] = '\0';
+	} else {
+		info->consumer[0] = '\0';
+	}
+
+	/*
+	 * Userspace only need to know that the kernel is using this GPIO so
+	 * it can't use it.
+	 */
+	info->flags = 0;
+	if (test_bit(FLAG_REQUESTED, &desc->flags) ||
+	    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
+	    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
+	    test_bit(FLAG_EXPORT, &desc->flags) ||
+	    test_bit(FLAG_SYSFS, &desc->flags) ||
+	    !pinctrl_gpio_can_use_line(chip->base + info->line_offset))
+		info->flags |= GPIOLINE_FLAG_KERNEL;
+	if (test_bit(FLAG_IS_OUT, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_IS_OUT;
+	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_ACTIVE_LOW;
+	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
+		info->flags |= (GPIOLINE_FLAG_OPEN_DRAIN |
+				GPIOLINE_FLAG_IS_OUT);
+	if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
+		info->flags |= (GPIOLINE_FLAG_OPEN_SOURCE |
+				GPIOLINE_FLAG_IS_OUT);
+	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_DISABLE;
+	if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_PULL_DOWN;
+	if (test_bit(FLAG_PULL_UP, &desc->flags))
+		info->flags |= GPIOLINE_FLAG_BIAS_PULL_UP;
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
 /*
  * gpio_ioctl() - ioctl handler for the GPIO chardev
  */
@@ -1187,49 +1241,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
-		if (desc->name) {
-			strncpy(lineinfo.name, desc->name,
-				sizeof(lineinfo.name));
-			lineinfo.name[sizeof(lineinfo.name)-1] = '\0';
-		} else {
-			lineinfo.name[0] = '\0';
-		}
-		if (desc->label) {
-			strncpy(lineinfo.consumer, desc->label,
-				sizeof(lineinfo.consumer));
-			lineinfo.consumer[sizeof(lineinfo.consumer)-1] = '\0';
-		} else {
-			lineinfo.consumer[0] = '\0';
-		}
-
-		/*
-		 * Userspace only need to know that the kernel is using
-		 * this GPIO so it can't use it.
-		 */
-		lineinfo.flags = 0;
-		if (test_bit(FLAG_REQUESTED, &desc->flags) ||
-		    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
-		    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
-		    test_bit(FLAG_EXPORT, &desc->flags) ||
-		    test_bit(FLAG_SYSFS, &desc->flags) ||
-		    !pinctrl_gpio_can_use_line(chip->base + lineinfo.line_offset))
-			lineinfo.flags |= GPIOLINE_FLAG_KERNEL;
-		if (test_bit(FLAG_IS_OUT, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_IS_OUT;
-		if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_ACTIVE_LOW;
-		if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
-			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_DRAIN |
-					   GPIOLINE_FLAG_IS_OUT);
-		if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
-			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_SOURCE |
-					   GPIOLINE_FLAG_IS_OUT);
-		if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_DISABLE;
-		if (test_bit(FLAG_PULL_DOWN, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_PULL_DOWN;
-		if (test_bit(FLAG_PULL_UP, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_BIAS_PULL_UP;
+		gpio_desc_to_lineinfo(desc, &lineinfo);
 
 		if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
 			return -EFAULT;
-- 
2.25.0

