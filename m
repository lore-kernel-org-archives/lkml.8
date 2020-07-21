Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3FC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE42208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOzeMSl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgGUJfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:35:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89692C061794;
        Tue, 21 Jul 2020 02:35:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so2131257wmi.3;
        Tue, 21 Jul 2020 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsB8VUw+xyzujE9BO6OtK9sHHD6socSmg3G/9GncBrM=;
        b=bOzeMSl24R0VG6fGaV5ujVc1q+bax9QHr7Jc97OvXFZT5b6MOc6SnLVstFF7kw+JBb
         bsL2XZExHJ4bSc43NQOgj4K1R9HMCnc3kwdb77duZZx9zbEcTforTZrFs1F0WEQuQdp6
         ajrRbtBo31Bmw9BZLhVFs7ZyNvAGaLNtMaqFurLyVNeOEHZLJTZC9yWM7UWRmGLQYrmm
         2ngyIzDpjhbhdGS+LRDGShey2PMsNvZeziJSHqusgmSCad7KY/TLlATkDrSxfOLI9q3a
         1dLlzQxhUuY57mDEJq3qf8IN4ItnUmhGTSIFmjMVa202Dzu2VxigpX3A6u1xXMl4+2gk
         Mi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsB8VUw+xyzujE9BO6OtK9sHHD6socSmg3G/9GncBrM=;
        b=fLyZQNQyI9Gra1r+Np5Zu7lEZnhF8xnE33ZQOcZjhF4AQfwsQgaXfUih+zktpim/Py
         Ai4KJ4PWt2+MOhftDZu+lEF5eahJiGlAw/pix6w3KFyqTrUuJMcmL6f1VkY2rnthyIz6
         9IafeI+7nPbBOUAZeY3kyQTgJ3N86JRtpb0ke1Ats+GeW5BqRAUnJXGSYb5gFnW9dTwf
         zPe+Yq4NSllHV7dDiE/KKchASv4sABLl4qD/2Z8rt9VrxjeJh0CNUtE2+Li+KOKPK5bG
         F1a42ZWjj5K+AY/pMOWPdMc/Vgkcl49//mbCSB0XSnJpWYDIxTtjt9yie85vDcDMllYp
         jy8g==
X-Gm-Message-State: AOAM532HUO/WYKiVL0LXINVIiDuOxT8BOdVMRBJCS0/YQ+9PerN/D65G
        63PerQrOnnZ00M0/dKALcGs=
X-Google-Smtp-Source: ABdhPJwwc1FL3qCPAg16Ji5AFoWRNypB4hHhF+0P3TZVc9lAFfr2ffAWrpGa7RAy+pne2h8EG2HDzg==
X-Received: by 2002:a1c:81c1:: with SMTP id c184mr3122514wmd.120.1595324147270;
        Tue, 21 Jul 2020 02:35:47 -0700 (PDT)
Received: from localhost ([41.37.22.226])
        by smtp.gmail.com with ESMTPSA id g14sm39852092wrw.83.2020.07.21.02.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 02:35:46 -0700 (PDT)
From:   Abanoub Sameh <abanoubsameh8@gmail.com>
X-Google-Original-From: Abanoub Sameh <abanoubsameh@protonmail.com>
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Subject: [PATCH 3/7] gpio: fixed coding style issues in gpio-intel-mid.c
Date:   Tue, 21 Jul 2020 11:35:18 +0200
Message-Id: <20200721093522.2309530-3-abanoubsameh@protonmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20200721093522.2309530-1-abanoubsameh@protonmail.com>
References: <20200721093522.2309530-1-abanoubsameh@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Abanoub Sameh <abanoubsameh@protonmail.com>
---
 drivers/gpio/gpio-intel-mid.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
index 86a10c808ef6..a609964645c1 100644
--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -38,7 +38,7 @@
  * reg_addr = reg_base + GPDR * nreg * 4 + reg * 4;
  *
  * so the bit of reg_addr is to control pin offset's GPDR feature
-*/
+ */
 
 enum GPIO_REG {
 	GPLR = 0,	/* pin level read-only */
@@ -64,27 +64,27 @@ struct intel_mid_gpio {
 	struct pci_dev			*pdev;
 };
 
-static void __iomem *gpio_reg(struct gpio_chip *chip, unsigned offset,
+static void __iomem *gpio_reg(struct gpio_chip *chip, unsigned int offset,
 			      enum GPIO_REG reg_type)
 {
 	struct intel_mid_gpio *priv = gpiochip_get_data(chip);
-	unsigned nreg = chip->ngpio / 32;
+	unsigned int nreg = chip->ngpio / 32;
 	u8 reg = offset / 32;
 
 	return priv->reg_base + reg_type * nreg * 4 + reg * 4;
 }
 
-static void __iomem *gpio_reg_2bit(struct gpio_chip *chip, unsigned offset,
+static void __iomem *gpio_reg_2bit(struct gpio_chip *chip, unsigned int offset,
 				   enum GPIO_REG reg_type)
 {
 	struct intel_mid_gpio *priv = gpiochip_get_data(chip);
-	unsigned nreg = chip->ngpio / 32;
+	unsigned int nreg = chip->ngpio / 32;
 	u8 reg = offset / 16;
 
 	return priv->reg_base + reg_type * nreg * 4 + reg * 4;
 }
 
-static int intel_gpio_request(struct gpio_chip *chip, unsigned offset)
+static int intel_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	void __iomem *gafr = gpio_reg_2bit(chip, offset, GAFR);
 	u32 value = readl(gafr);
@@ -97,14 +97,14 @@ static int intel_gpio_request(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
-static int intel_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int intel_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	void __iomem *gplr = gpio_reg(chip, offset, GPLR);
 
 	return !!(readl(gplr) & BIT(offset % 32));
 }
 
-static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void intel_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	void __iomem *gpsr, *gpcr;
 
@@ -117,7 +117,7 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	}
 }
 
-static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct intel_mid_gpio *priv = gpiochip_get_data(chip);
 	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
@@ -140,7 +140,7 @@ static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int intel_gpio_direction_output(struct gpio_chip *chip,
-			unsigned offset, int value)
+			unsigned int offset, int value)
 {
 	struct intel_mid_gpio *priv = gpiochip_get_data(chip);
 	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
@@ -163,7 +163,7 @@ static int intel_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int intel_mid_irq_type(struct irq_data *d, unsigned type)
+static int intel_mid_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_mid_gpio *priv = gpiochip_get_data(gc);
@@ -297,7 +297,7 @@ static int intel_mid_irq_init_hw(struct gpio_chip *chip)
 {
 	struct intel_mid_gpio *priv = gpiochip_get_data(chip);
 	void __iomem *reg;
-	unsigned base;
+	unsigned int base;
 
 	for (base = 0; base < priv->chip.ngpio; base += 32) {
 		/* Clear the rising-edge detect register */
@@ -317,6 +317,7 @@ static int intel_mid_irq_init_hw(struct gpio_chip *chip)
 static int __maybe_unused intel_gpio_runtime_idle(struct device *dev)
 {
 	int err = pm_schedule_suspend(dev, 500);
+
 	return err ?: -EBUSY;
 }
 
-- 
2.28.0.rc0

