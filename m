Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAA120724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895489;
	bh=+S5L9C2Rbnk06fAH95bFYq1eiKCq4havkrODwbrzFDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pq+PEay5HP5U5oY8wGpFFTPsflQp//hagoYHP16q1TcrSWepJhnNxrDYfD1zT3RQd
	 jIvKcygOyg6Y0T+xd3/L2Px+Du3kLJnVlQLIESf/yTje9R60lspy4RtsJv9xaIwBDb
	 44OqOq7uokE7zJdkrDLdlwjV5eSDeRzV0yO9TyxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgFWG6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgFWG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:07 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C370A20780;
        Tue, 23 Jun 2020 06:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895486;
        bh=+S5L9C2Rbnk06fAH95bFYq1eiKCq4havkrODwbrzFDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wz1fjZDwJaFie/acSm1CZ0vmTHqlg2Vi+kaYRp3g4WrdOey8A2HqkjVMp6meg1lDW
         GKwgs3j4PgI7Qt2zjBpsYTGLmAO9t9J+MnciRnBHSoCcPiItId9E2zgKS/R9skX4qu
         8YDrn0kJERyMFUcdepfFJirD1htummrAo8HZBmpI=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 5/8] pwm: remove pwm-puv3  driver
Date:   Tue, 23 Jun 2020 09:57:41 +0300
Message-Id: <20200623065744.18393-6-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
References: <20200623065744.18393-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The unicore32 port is removed from the kernel.
There is no point to keep stale PWM driver for this architecture.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/pwm/Kconfig    |   9 ---
 drivers/pwm/Makefile   |   1 -
 drivers/pwm/pwm-puv3.c | 150 -----------------------------------------
 3 files changed, 160 deletions(-)
 delete mode 100644 drivers/pwm/pwm-puv3.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2..7dbcf6973d33 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -370,15 +370,6 @@ config PWM_PCA9685
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pca9685.
 
-config PWM_PUV3
-	tristate "PKUnity NetBook-0916 PWM support"
-	depends on ARCH_PUV3
-	help
-	  Generic PWM framework driver for PKUnity NetBook-0916.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-puv3.
-
 config PWM_PXA
 	tristate "PXA PWM support"
 	depends on ARCH_PXA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710e98c7..2c2ba0a03557 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
-obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
diff --git a/drivers/pwm/pwm-puv3.c b/drivers/pwm/pwm-puv3.c
deleted file mode 100644
index 9d0bd87a425e..000000000000
--- a/drivers/pwm/pwm-puv3.c
+++ /dev/null
@@ -1,150 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/unicore32/kernel/pwm.c
- *
- * Code specific to PKUnity SoC and UniCore ISA
- *
- *	Maintained by GUAN Xue-tao <gxt@mprc.pku.edu.cn>
- *	Copyright (C) 2001-2010 Guan Xuetao
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/pwm.h>
-
-#include <asm/div64.h>
-#include <mach/hardware.h>
-
-struct puv3_pwm_chip {
-	struct pwm_chip chip;
-	void __iomem *base;
-	struct clk *clk;
-};
-
-static inline struct puv3_pwm_chip *to_puv3(struct pwm_chip *chip)
-{
-	return container_of(chip, struct puv3_pwm_chip, chip);
-}
-
-/*
- * period_ns = 10^9 * (PRESCALE + 1) * (PV + 1) / PWM_CLK_RATE
- * duty_ns   = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
- */
-static int puv3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			   int duty_ns, int period_ns)
-{
-	unsigned long period_cycles, prescale, pv, dc;
-	struct puv3_pwm_chip *puv3 = to_puv3(chip);
-	unsigned long long c;
-
-	c = clk_get_rate(puv3->clk);
-	c = c * period_ns;
-	do_div(c, 1000000000);
-	period_cycles = c;
-
-	if (period_cycles < 1)
-		period_cycles = 1;
-
-	prescale = (period_cycles - 1) / 1024;
-	pv = period_cycles / (prescale + 1) - 1;
-
-	if (prescale > 63)
-		return -EINVAL;
-
-	if (duty_ns == period_ns)
-		dc = OST_PWMDCCR_FDCYCLE;
-	else
-		dc = (pv + 1) * duty_ns / period_ns;
-
-	/*
-	 * NOTE: the clock to PWM has to be enabled first
-	 * before writing to the registers
-	 */
-	clk_prepare_enable(puv3->clk);
-
-	writel(prescale, puv3->base + OST_PWM_PWCR);
-	writel(pv - dc, puv3->base + OST_PWM_DCCR);
-	writel(pv, puv3->base + OST_PWM_PCR);
-
-	clk_disable_unprepare(puv3->clk);
-
-	return 0;
-}
-
-static int puv3_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct puv3_pwm_chip *puv3 = to_puv3(chip);
-
-	return clk_prepare_enable(puv3->clk);
-}
-
-static void puv3_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct puv3_pwm_chip *puv3 = to_puv3(chip);
-
-	clk_disable_unprepare(puv3->clk);
-}
-
-static const struct pwm_ops puv3_pwm_ops = {
-	.config = puv3_pwm_config,
-	.enable = puv3_pwm_enable,
-	.disable = puv3_pwm_disable,
-	.owner = THIS_MODULE,
-};
-
-static int pwm_probe(struct platform_device *pdev)
-{
-	struct puv3_pwm_chip *puv3;
-	struct resource *r;
-	int ret;
-
-	puv3 = devm_kzalloc(&pdev->dev, sizeof(*puv3), GFP_KERNEL);
-	if (!puv3)
-		return -ENOMEM;
-
-	puv3->clk = devm_clk_get(&pdev->dev, "OST_CLK");
-	if (IS_ERR(puv3->clk))
-		return PTR_ERR(puv3->clk);
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	puv3->base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(puv3->base))
-		return PTR_ERR(puv3->base);
-
-	puv3->chip.dev = &pdev->dev;
-	puv3->chip.ops = &puv3_pwm_ops;
-	puv3->chip.base = -1;
-	puv3->chip.npwm = 1;
-
-	ret = pwmchip_add(&puv3->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, puv3);
-	return 0;
-}
-
-static int pwm_remove(struct platform_device *pdev)
-{
-	struct puv3_pwm_chip *puv3 = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&puv3->chip);
-}
-
-static struct platform_driver puv3_pwm_driver = {
-	.driver = {
-		.name = "PKUnity-v3-PWM",
-	},
-	.probe = pwm_probe,
-	.remove = pwm_remove,
-};
-module_platform_driver(puv3_pwm_driver);
-
-MODULE_LICENSE("GPL v2");
-- 
2.26.2

