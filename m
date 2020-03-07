Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23733C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C18206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB0ph0r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCGAOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:14:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35029 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:14:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id u68so1170233pfb.2;
        Fri, 06 Mar 2020 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hDYVA9f/L/3nXUZdsuoFqZfc8mAyfA73aRbFdpVcGqc=;
        b=XB0ph0r+2HgvDAqyqb2/Cr6wxaivqkVjhN/an0c4Z18SEDlj3j+4OZbRp++gaoiWE1
         CHoKLbUWDokwbzHNDpAof3rST5/dNaCwTPUN1RHGDgYwfQDDqnv7ckUHmxjMHYPTQIuU
         VTJFP+ADKPDezmK3OZMypVinGO0XVPrEDwQsj2Gtxs7L678WJsknfqVF80FdMom3svQ0
         e2ehbodObuJMWROKY+bLKrttZou1tX2nFH6Hn+NJZpoiH+xqlnnly2BANkp6O0HLcAyn
         zZciGMmvs2lBzbUW1e6FiSNmMoPmOwKfc91+XwVAm8c1cDjWAijCNWF+90lQW9mnPKoI
         +8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hDYVA9f/L/3nXUZdsuoFqZfc8mAyfA73aRbFdpVcGqc=;
        b=ZVxYxY/LKWAu/lP+4z/lkmcph3WbEV/AMbXoGdueJlw0hWUrd15YWlVQQZgtiCilhK
         UIBHmtBsQYbiENQQyIXKa9EWVEaVXKlhDgBsTUWpNSMThcL3UjAwRyObNJBet/U1GYdz
         AYz/DliPmKTu+70Fxl3li11Cz+w6wmzv08g7mDikSi6vM3BECDndwh59D34G6F4/1YuU
         gX5/bdjdwDSLh/xhouZ3VhAIC5zf+BMm2lGjTBZ1XkQLcK8Zh9rg+N0Nnr6WfL0CMRyg
         f6wFJTdKud29e5jIYMJVTxauUfmdFY9KPqKMTMnmVHQJaIjfrvkjcXJY6N9vy/M0T3oT
         etrg==
X-Gm-Message-State: ANhLgQ0CcuaQJnpXw9vC6ATwAiWfk1HN1Q40pDDza19avw6DIXEgmSA6
        XGMnBGkz3OoJOfRrBLjDWwo=
X-Google-Smtp-Source: ADFU+vu081bHBamqDSIur/Av+nz1dI+BeMe/H/ym0Ex6y1uepe0Hnbawqf3vUFGAn/2q6whw0bk7tQ==
X-Received: by 2002:a62:17c8:: with SMTP id 191mr6287295pfx.105.1583540046576;
        Fri, 06 Mar 2020 16:14:06 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h65sm14568846pfg.12.2020.03.06.16.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Mar 2020 16:14:06 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] gpio: brcmstb: support gpio-line-names property
Date:   Fri,  6 Mar 2020 16:13:06 -0800
Message-Id: <1583539986-573-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default handling of the gpio-line-names property by the
gpiolib-of implementation does not work with the multiple
gpiochip banks per device structure used by the gpio-brcmstb
driver.

This commit adds driver level support for the device tree
property so that GPIO lines can be assigned friendly names.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 05e3f99ae59c..e9ab246e2d42 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -603,6 +603,49 @@ static const struct dev_pm_ops brcmstb_gpio_pm_ops = {
 	.resume_noirq = brcmstb_gpio_resume,
 };
 
+static void brcmstb_gpio_set_names(struct device *dev,
+				   struct brcmstb_gpio_bank *bank)
+{
+	struct device_node *np = dev->of_node;
+	const char **names;
+	int nstrings, base;
+	unsigned int i;
+
+	base = bank->id * MAX_GPIO_PER_BANK;
+
+	nstrings = of_property_count_strings(np, "gpio-line-names");
+	if (nstrings <= base)
+		/* Line names not present */
+		return;
+
+	names = devm_kcalloc(dev, MAX_GPIO_PER_BANK, sizeof(char *),
+			     GFP_KERNEL);
+	if (!names)
+		return;
+
+	/*
+	 * Make sure to not index beyond the end of the number of descriptors
+	 * of the GPIO device.
+	 */
+	for (i = 0; i < bank->width; i++) {
+		const char *name;
+		int ret;
+
+		ret = of_property_read_string_index(np, "gpio-line-names",
+						    base + i, &name);
+		if (ret) {
+			if (ret != -ENODATA)
+				dev_err(dev, "unable to name line %d: %d\n",
+					i, ret);
+			break;
+		}
+		if (*name)
+			names[i] = name;
+	}
+
+	bank->gc.names = names;
+}
+
 static int brcmstb_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -726,6 +769,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		need_wakeup_event |= !!__brcmstb_gpio_get_active_irqs(bank);
 		gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
 
+		brcmstb_gpio_set_names(dev, bank);
 		err = gpiochip_add_data(gc, bank);
 		if (err) {
 			dev_err(dev, "Could not add gpiochip for bank %d\n",
-- 
2.7.4

