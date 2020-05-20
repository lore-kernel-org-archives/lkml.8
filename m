Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6933BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473FA20748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgETGMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:12:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36253 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgETGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:12:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so2249243ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ghJ7YD5IKfP3MQ40D3G+jaGxHwF3RHwj0WPAFD2ZV8=;
        b=Dd2xAIh27pOkyIrthZWkmc9+7wbz5hMyRnTcn5HhFcJ0cP9yW/Sk8pQRpn5nH/o4dm
         78vUAYi/V8HpO1XtXRCS+lv7FlLyc/avuew7we6zB0MIFp5UzG7IaXeafeOpkoz1pmjt
         /RRsGQcR7StEG08ochuj3idOYFh2RVudQK4gA+El+7QFhn6n6FoglF/XUtWeenl7FPR6
         fnec/cM6XaLmdfAJkQut4w6mQdGhQJk0DMzQDptYB0qJ7pS/L8CTBoqdMHplnYcqL5R4
         x8WPShY1iU9rjqmqQAvCEXW+369M4f0Ckaor7XUFN9dpL8zOOxWwek8D/8Y9fzvNO3ZD
         3oNQ==
X-Gm-Message-State: AOAM530/BL0sD0Sxla9nGcfB609B8RicC39VGUoGbofUpze7rLCmT569
        OeUhOG/oK1A3CEcreoGRItU=
X-Google-Smtp-Source: ABdhPJyv/Nq0OWXLumQiNzZqonAnmvwioyJ6M5G5V0B7+wtfc0ATfT6NGqGNJyYErwAAHf3AyyU7+Q==
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr1766008lja.56.1589955126784;
        Tue, 19 May 2020 23:12:06 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id r15sm789162lfp.34.2020.05.19.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 23:12:06 -0700 (PDT)
Date:   Wed, 20 May 2020 09:11:28 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        SebastianReichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management ICs
Message-ID: <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for maintaining power management IC drivers for ROHM
BD71837, BD71847, BD71850, BD71828, BD71878, BD70528 and BD99954.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 MAINTAINERS | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..63a2ca70540e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14490,6 +14490,12 @@ L:	linux-serial@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
 
+ROHM BD99954 CHARGER IC
+R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+S:	Supported
+F:	drivers/power/supply/bd99954-charger.c
+F:	drivers/power/supply/bd99954-charger.h
+
 ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
@@ -14507,6 +14513,30 @@ F:	drivers/mfd/bd9571mwv.c
 F:	drivers/regulator/bd9571mwv-regulator.c
 F:	include/linux/mfd/bd9571mwv.h
 
+ROHM POWER MANAGEMENT IC DEVICE DRIVERS
+R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+F:	Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
+F:	drivers/clk/clk-bd718x7.c
+F:	drivers/gpio/gpio-bd70528.c
+F:	drivers/gpio/gpio-bd71828.c
+F:	drivers/mfd/rohm-bd70528.c
+F:	drivers/mfd/rohm-bd71828.c
+F:	drivers/mfd/rohm-bd718x7.c
+F:	drivers/power/supply/bd70528-charger.c
+F:	drivers/regulator/bd70528-regulator.c
+F:	drivers/regulator/bd71828-regulator.c
+F:	drivers/regulator/bd718x7-regulator.c
+F:	drivers/regulator/rohm-regulator.c
+F:	drivers/rtc/rtc-bd70528.c
+F:	drivers/watchdog/bd70528_wdt.c
+F:	include/linux/mfd/rohm-shared.h
+F:	include/linux/mfd/rohm-bd71828.h
+F:	include/linux/mfd/rohm-bd70528.h
+F:	include/linux/mfd/rohm-generic.h
+F:	include/linux/mfd/rohm-bd718x7.h
+
 ROSE NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
