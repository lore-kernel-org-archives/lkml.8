Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC9C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86620721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LZqE8iUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBCNaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:30:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33204 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgBCNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so4861184wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1xJqaqAPEC794SAD7Tt6YXPm/qB2065vemTtgGyHK8=;
        b=LZqE8iUrg07qQSSghcH6r2uhuQys1bYFFy08ATpEC7Et1fhYnaKAZj6SzReNq2FN/s
         FSQ2z2IAojwof95jzWFXS2sEnF37ErJCWjQ+cq3OXp0PZ+lj2m7grzm5LAWlYnsfNlAX
         zA0jYiTWqpk3UlfrcqMGUjeeZ35uL0iQu6x/yYah/08bvCEa1yYtIFhlVe5kyp3u1wRg
         jDGhEbAf5tbLch8TSeD9E1kl4p0jLAaD/EA3JFIEfAWlVG+9SaKLbbsrkLvN1dsRyndd
         HhG+vwWPd0PYornZtWaJHlVhkvtXylne1iWlo4dYjUrvEHzLoGD/ehkCNCLM6LeydD0o
         yJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1xJqaqAPEC794SAD7Tt6YXPm/qB2065vemTtgGyHK8=;
        b=lb/RVL5a+cCGnYkhJAUHDG6Ut3fLI9WdYRuJV4OiUNjEaHdcJQ1acvZnjln+xG2krt
         w9sWD9UP/J3FlYUl2KLrtCEC3pHgbYdmjQ7kJsnrHWv0I7M/2WANjtaxv19CtMUOWHLL
         9HVxypoGhx4S5Fln2CMUZjlpHrKDvYWubyzulvShzDSu1LLfaaGjI7N8fttxsZNyPN3E
         V+cUsdIu5yLN193T9Po6hxgDeuXbM2teKfGDnu5VrPstfgnfN/aamaQd3dmFeVTcmuyL
         LBW3Unk5l/kxiO11prKoLHDzTgsrVkagF5rKurBpCJg5IoCUTZRs8tziRvL5QG8J+fkh
         IUZg==
X-Gm-Message-State: APjAAAU3kUPDmelpwRmmmpq8yKgXp9KsjOwLD3oMYVN1vX0ADJPIXBoX
        DA7ROxaJT7veNfQu6OC5S51XzA==
X-Google-Smtp-Source: APXvYqwpb5h+57G+AaJyFbBjUKenLrDEE6o8zM17QKKlB6PXdRXabKQvPh2C4N8tVfrcI4GjOGMY5w==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr11550295wrr.41.1580736633291;
        Mon, 03 Feb 2020 05:30:33 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id l8sm7594540wmj.2.2020.02.03.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:30:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] Revert "gpiolib: remove set but not used variable 'config'"
Date:   Mon,  3 Feb 2020 14:30:25 +0100
Message-Id: <20200203133026.22930-3-brgl@bgdev.pl>
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

This reverts commit e5e42ad224a040f93bf112e96f82b3a0ed97ffab.

This patch came on top of another patch that introduced a regression.
Revert it before addressing the culprit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0673daeaca00..13982056c14e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3047,6 +3047,7 @@ static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
 static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			   enum pin_config_param mode)
 {
+	unsigned long config;
 	unsigned arg;
 
 	switch (mode) {
@@ -3060,6 +3061,7 @@ static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 		arg = 0;
 	}
 
+	config = PIN_CONF_PACKED(mode, arg);
 	return gpio_do_set_config(gc, offset, mode);
 }
 
-- 
2.23.0

