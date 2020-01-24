Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7223DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F8C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vsxVRIio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbgAXR1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:27:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34475 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390492AbgAXR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:27:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so4498940wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPe1QyM9pg0o9jHIbKLfLW6eev5iWc7ZaqvBHVpC/2Q=;
        b=vsxVRIio+PfR3OgENurb0AQErrdDCGgO9tg9gpj1qXgfsoes92u5wd9trTmWsNxqkE
         EAeG7nZTuQn9vjsEhuuJCZXE59ptX5sEW8iubnQmvhfcGDoP/3als1H0+qe7bsgi60/U
         Yr0MKCn9DNRwVbdn6V7LI29EhrFM0NGGlA4V/LYScxrGBwAPdRrN5I6db0rrlsBQYbQF
         vpwTbytUtyViTokwH+UuU0YSrJi/E6vlFd4suYesuzc3veEdgE3uxYyh0j2XFAzEjJ5U
         7BUSnCNvTpnhUuHX065jpooNjpyF+/6Bs1L+7nf8EWa6gVGjHg+FTQxMPo4EcuFCMNuM
         Kh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPe1QyM9pg0o9jHIbKLfLW6eev5iWc7ZaqvBHVpC/2Q=;
        b=NGSAQNaIkG/V1niZQpuQTo1mHPY6haqIBgM6qncyzRRG48PQk0Au5Q4LUm5DqTi9f2
         zqEsZK+HVOePvO5gR3T5Op9WR86ZU8SFWz34loX59bnvF1bHA9PoWWo0JpSVDT6sGrZN
         5maYL0Hr4vlqSvSkLVwZwC/RPkU7cYoU4Xwmb5aOnUXDHIP/oNp9cM+TUx1PkeqldEld
         Ncl6UiHyLknxGH6SeHcwGPjIa8gsy9DPFH4tmTC1vAE92TTUxcjuh4q3KQSqXJjIfQw0
         cEF28U7/NBn624lmDkqiGUQ1RyEeT+d8ewbSsS1ZaMO7lW5qcmmdnCV/mk/J6VIQLhSH
         r/1g==
X-Gm-Message-State: APjAAAWsR43r8eF+CltAJ0BuN4E+cjDIgGcZkIbVb/B9+S+GjEoSc/v5
        XwTS4a8Cib3SanjxZ3oTE1Ty6g==
X-Google-Smtp-Source: APXvYqwR70yxAmPZKcdj4ju3jhmHUura2OnG4kzxieCPz0NIpiHTUXLcd/8HVOGLN1FC01FlKCZZPg==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr26876wml.88.1579886841655;
        Fri, 24 Jan 2020 09:27:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t8sm8358585wrp.69.2020.01.24.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:27:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 5/7] gpiolib: provide a dedicated function for setting lineinfo
Date:   Fri, 24 Jan 2020 18:27:08 +0100
Message-Id: <20200124172710.20776-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200124172710.20776-1-brgl@bgdev.pl>
References: <20200124172710.20776-1-brgl@bgdev.pl>
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
index 4ce34958e335..d6d13c7e4b9e 100644
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
2.23.0

