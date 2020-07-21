Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6295C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9388F2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="PzWnn8lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgGUODw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:03:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1531C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:03:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so6479416wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfVwMqC0uQWqEXEYVAIidH5sBEC97K0Eu+a0jsNaLKY=;
        b=PzWnn8luK9wl6PGEsGK2ImTxulWmPdYNOiSWEyzjQfRdbJk4gQfgX7qUATANX0nAjW
         bbL0yFiwhqAgEcu63UZper1tkX/FFfdod5D4hQ5uM4O9Jtbe9I27IJU7B5dgNSCmqxLB
         P0HVj9sqNaJycs6cItW8xGlLod2JtT5TaDS0F/BRxuFkOEJdrTCmq2SSzpLYUSDsDfc/
         YG54UEQOeaSAfG8qhctZh30yNjWcrS3MgXofd9toe731uJmd8ZDHHqs9il5wffvRezqW
         4cTLSbPPm0SA9zLhQ82hxtNcUul7NN/Rra6mpFERTIAI5rN/rTXVhnRoOHLj2Rwg2mHf
         jm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfVwMqC0uQWqEXEYVAIidH5sBEC97K0Eu+a0jsNaLKY=;
        b=H8QYEXMid0YvusjPQmCYs4+dOgBqaaX1ZZkTgIUhT2u4DYmecVDB/0EnUxgxKwmK1X
         Aogiv+CCl92w7J2w7k+4/bPhMah/acddzmqWqrJSkNRzIkBwUQxAz7TuFN9Xlh3shHH/
         co4aI3Kz0OGF5D0FDnlp4CZKu0RIBVH8YvSDGUT6iDV/N/0dt0VqXIDlUEHBnW1buTNX
         gmotp5ZWwfNXv+KVYPCi2937O80TH1BAA0wqyOdBb5yNqmuMoqLYZBHEj16an1/VsvSq
         OiniogxmUZsc45nuM72Us6GHf1icG4Vo6/USdemin+hildUAnHN3DXcI/NChvBojoDXK
         kAsA==
X-Gm-Message-State: AOAM533K6zY6N8o/yBfxyDAUs6sShgpiKIhsGAqaS2vOZ3I9oIOx2XG2
        w+7XfibRxYtcjtpXR/IzT9l83Q==
X-Google-Smtp-Source: ABdhPJxkr+yVQH10n0lVsc27YqVqO+bGf0Gx8/dmhlMhsEiD6eVWN29Tmcqw0W+PtL2RxJv4RUcuOQ==
X-Received: by 2002:a5d:69d2:: with SMTP id s18mr14514125wrw.408.1595340230395;
        Tue, 21 Jul 2020 07:03:50 -0700 (PDT)
Received: from localhost.localdomain (103.red-88-29-77.staticip.rima-tde.net. [88.29.77.103])
        by smtp.gmail.com with ESMTPSA id c194sm3740003wme.8.2020.07.21.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:03:49 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3] pinctrl: core: print gpio in pins debugfs file
Date:   Tue, 21 Jul 2020 16:02:34 +0200
Message-Id: <20200721140233.2063475-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a gpio range mapping for the pin, then print out the gpio
chip and line index for the pin in the debugfs 'pins' file with the
format: "[gpiochip-label]:line-[index] "

For example, here is a section of 'pins' the PocketBeagle (AM3358):
/sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins

pin 25 (PIN25) gpio-32-63:line-25 44e10864 00000037 pinctrl-single 
pin 26 (PIN26) gpio-32-63:line-26 44e10868 00000037 pinctrl-single 
pin 27 (PIN27) gpio-32-63:line-27 44e1086c 00000037 pinctrl-single 
pin 28 (PIN28) NA 44e10870 00000036 pinctrl-single 
pin 29 (PIN29) NA 44e10874 00000006 pinctrl-single 
pin 30 (PIN30) gpio-32-63:line-28 44e10878 00000027 pinctrl-single 
pin 31 (PIN31) gpio-32-63:line-29 44e1087c 00000037 pinctrl-single 
pin 32 (PIN32) gpio-32-63:line-30 44e10880 00000037 pinctrl-single 
pin 33 (PIN33) gpio-32-63:line-31 44e10884 00000037 pinctrl-single 
pin 34 (PIN34) gpio-64-95:line-0 44e10888 00000037 pinctrl-single 
pin 35 (PIN35) gpio-64-95:line-1 44e1088c 00000037 pinctrl-single 

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>

v3 changes:
- gpio column is now gpiochip label and line index

v2 changes:
- print 'NA' if pin does not have a GPIO number
- change gpio_num from unsigned to unsigned int per checkpatch
---
 drivers/pinctrl/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 821242bb4b16..a23dc264cae7 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -27,6 +27,7 @@
 #include <linux/pinctrl/machine.h>
 
 #ifdef CONFIG_GPIOLIB
+#include "../gpio/gpiolib.h"
 #include <asm-generic/gpio.h>
 #endif
 
@@ -1601,6 +1602,9 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned i, pin;
+	struct pinctrl_gpio_range *range;
+	unsigned int gpio_num;
+	struct gpio_chip *chip;
 
 	seq_printf(s, "registered pins: %d\n", pctldev->desc->npins);
 
@@ -1618,6 +1622,23 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 
 		seq_printf(s, "pin %d (%s) ", pin, desc->name);
 
+#ifdef CONFIG_GPIOLIB
+		gpio_num = 0;
+		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
+			if ((pin >= range->pin_base) &&
+			    (pin < (range->pin_base + range->npins))) {
+				gpio_num = range->base + (pin - range->pin_base);
+				break;
+			}
+		}
+		chip = gpio_to_chip(gpio_num);
+		if (chip && chip->gpiodev && chip->gpiodev->base)
+			seq_printf(s, "%s:line-%u ", chip->label,
+				gpio_num - chip->gpiodev->base);
+		else
+			seq_puts(s, "NA ");
+#endif
+
 		/* Driver-specific info per pin */
 		if (ops->pin_dbg_show)
 			ops->pin_dbg_show(pctldev, s, pin);
-- 
2.25.1

