Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D56C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EFB2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1QKDsrCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgBCNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:30:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgBCNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id g1so15880379wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLtMqSU8FnRsT2MznAhbMw8rQbBTInq5OoP1ERtOceE=;
        b=1QKDsrCaCPaOPwzfA0FDJLinhHQzKsaIXL3gF8PGxysnLGvwAgNZkJ7H39PuQ4Rya3
         BRjQiBg2Jn3kdyv9rjI9uADsD98t2ZIGLF8ZCW1+c04Ex4lHnjwOEvdkoVQpKeaF3isj
         wIbnVw3VBV9lbZ9i76GLrWga9xj0dJiYvrOCU6ASeTzMdCXmu5dqC0aZe1mGayAadrx2
         eU+u345NVa9skEcz7x4bxfUi/nayVfdxY26cyqGLxTcLGTXNvRhpPcNfzCU742nWGoF3
         VS0dRw5uFIMMd28SDMDJz15qClXcCOS6fyf43fU0zdbLJtdC/SGojLjYktlLNXErLnI9
         9SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLtMqSU8FnRsT2MznAhbMw8rQbBTInq5OoP1ERtOceE=;
        b=RsCYvqKKZWMILF3DMkRUNmUuW1U6Fg/DRsdfFqWdfoKPdPh3WbBzTz3RqiOm6jZWT6
         FsMvrngYzLvCYsjTnBhGsjL1Xi0Gbm08YzMB8zyGfnUh+nlGSXHZtFGXIjMapxKuXIUb
         ZVu5cnnh6h9jUedkAo2QDzk0H5q/klfGjMJCXobFrh1fubmGYNz5rRVsppVZjpaQKpUM
         7Sh0uZcaQioHlk3lwgxQwlCz51Dj5Oebmn0GPCQEyXeDVAj1UKtUcjk43g5QGWZXs9g2
         Rqj9fy3wYK897qOuUVHTFIY3VkGGjRyQl9P8cef6Kbb6s4EVs8L/DpjRIW3TTyEZSLJa
         Ev2g==
X-Gm-Message-State: APjAAAWkKT6Le8EPdqNSsV5d3Ogb8LPhxAQ/Hs8DKcR0l7XriRptTHYL
        Iq1gFENMiJBscHCASxQ7onyCRw==
X-Google-Smtp-Source: APXvYqy0ibNKoyqFGzrTQe7H1FcOYKrZp2jxqp0RBHxgKiXqgpIsqzORUmM5PumAbk2EDiaMVY3zeQ==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr30878623wmg.52.1580736634354;
        Mon, 03 Feb 2020 05:30:34 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id l8sm7594540wmj.2.2020.02.03.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:30:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] gpiolib: fix gpio_do_set_config()
Date:   Mon,  3 Feb 2020 14:30:26 +0100
Message-Id: <20200203133026.22930-4-brgl@bgdev.pl>
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

Commit d90f36851d65 ("gpiolib: have a single place of calling
set_config()") introduced a regression where we don't pass the right
variable as argument to the set_config() callback of gpio driver from
gpio_set_config(). After reverting two additional patches that came
on top of it - this addresses the issue by changing the type of the last
argument of gpio_do_set_config() to unsigned long and making sure the
packed config variable is actually used in gpio_set_config().

Fixes: d90f36851d65 ("gpiolib: have a single place of calling set_config()")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 13982056c14e..760ae0707c01 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3036,12 +3036,12 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  */
 
 static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
-			      enum pin_config_param mode)
+			      unsigned long config)
 {
 	if (!gc->set_config)
 		return -ENOTSUPP;
 
-	return gc->set_config(gc, offset, mode);
+	return gc->set_config(gc, offset, config);
 }
 
 static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
@@ -3062,7 +3062,7 @@ static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 	}
 
 	config = PIN_CONF_PACKED(mode, arg);
-	return gpio_do_set_config(gc, offset, mode);
+	return gpio_do_set_config(gc, offset, config);
 }
 
 static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
-- 
2.23.0

