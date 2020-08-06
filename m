Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DBF221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738700;
	bh=41DB04g7bnvHlbjYbY4BAew/yHdDAUU2eHUM/YHd6eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+W6lDCIAv9W0eZbyG46VxzAwDEeQjaIhckyxcYGbaJ7pfc5riOgBpXh5wDwjbicb
	 c4nFjNpXDQu6FgivwsffdMoHwbYosWngfdaRVKyAFvHFSdcJwwbZejnR/Z//A/5VwO
	 Oz7TzQWWsvUJePl70odwZZiVzT+SfcxzGqaNqTBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHFSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgHFSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F303122D06;
        Thu,  6 Aug 2020 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738136;
        bh=41DB04g7bnvHlbjYbY4BAew/yHdDAUU2eHUM/YHd6eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsUMJwrOd4mJyKpNs/CIMXd3noEkrz6TxA8z2JExxEjdCSb3IJJHPuk97wtbWPoNL
         32tVAIKOcDTCI80KbmrW63jnaPqRJp0bKqJ+sE67JAp/icDA8uMjs47IXI8dmZquco
         2hUCicQHgZrDi4A0MumUHAwH2dDYkERdiTunAEqM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 09/41] usb: gadget: s3c-hsudc: remove platform header dependency
Date:   Thu,  6 Aug 2020 20:20:26 +0200
Message-Id: <20200806182059.2431-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is no real phy driver, so s3c-hsudc just pokes the registers
itself. Improve this a little by making it a platform data callback
like we do for gpios.

There is only one board using this driver, and it's unlikely
that another would be added, so this is a minimal workaround.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[krzk: Include regs-s3c2443-clock.h in ifdef to fixup build on s3c6400]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Include regs-s3c2443-clock.h in ifdef to fixup build on s3c640
---
 .../include/mach/regs-s3c2443-clock.h         | 49 +++++++++++++++++
 arch/arm/plat-samsung/devs.c                  |  6 ++
 drivers/usb/gadget/udc/s3c-hsudc.c            | 55 ++-----------------
 include/linux/platform_data/s3c-hsudc.h       |  2 +
 4 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
index 6bf924612b06..682759549e63 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARM_REGS_S3C2443_CLOCK
 #define __ASM_ARM_REGS_S3C2443_CLOCK
 
+#include <linux/delay.h>
+
 #define S3C2443_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
 
 #define S3C2443_PLLCON_MDIVSHIFT	16
@@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned int baseclk)
 	return (unsigned int)fvco;
 }
 
+static inline void s3c_hsudc_init_phy(void)
+{
+	u32 cfg;
+
+	cfg = readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
+	writel(cfg, S3C2443_PWRCFG);
+
+	cfg = readl(S3C2443_URSTCON);
+	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
+	writel(cfg, S3C2443_URSTCON);
+	mdelay(1);
+
+	cfg = readl(S3C2443_URSTCON);
+	cfg &= ~(S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
+	writel(cfg, S3C2443_URSTCON);
+
+	cfg = readl(S3C2443_PHYCTRL);
+	cfg &= ~(S3C2443_PHYCTRL_CLKSEL | S3C2443_PHYCTRL_DSPORT);
+	cfg |= (S3C2443_PHYCTRL_EXTCLK | S3C2443_PHYCTRL_PLLSEL);
+	writel(cfg, S3C2443_PHYCTRL);
+
+	cfg = readl(S3C2443_PHYPWR);
+	cfg &= ~(S3C2443_PHYPWR_FSUSPEND | S3C2443_PHYPWR_PLL_PWRDN |
+		S3C2443_PHYPWR_XO_ON | S3C2443_PHYPWR_PLL_REFCLK |
+		S3C2443_PHYPWR_ANALOG_PD);
+	cfg |= S3C2443_PHYPWR_COMMON_ON;
+	writel(cfg, S3C2443_PHYPWR);
+
+	cfg = readl(S3C2443_UCLKCON);
+	cfg |= (S3C2443_UCLKCON_DETECT_VBUS | S3C2443_UCLKCON_FUNC_CLKEN |
+		S3C2443_UCLKCON_TCLKEN);
+	writel(cfg, S3C2443_UCLKCON);
+}
+
+static inline void s3c_hsudc_uninit_phy(void)
+{
+	u32 cfg;
+
+	cfg = readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
+	writel(cfg, S3C2443_PWRCFG);
+
+	writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
+
+	cfg = readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
+	writel(cfg, S3C2443_UCLKCON);
+}
+
 #endif /*  __ASM_ARM_REGS_S3C2443_CLOCK */
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 2ed3ef604a25..0607d2984841 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -40,6 +40,10 @@
 #include <mach/irqs.h>
 #include <mach/map.h>
 
+#ifdef CONFIG_PLAT_S3C24XX
+#include <mach/regs-s3c2443-clock.h>
+#endif /* CONFIG_PLAT_S3C24XX */
+
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/adc.h>
@@ -1037,6 +1041,8 @@ struct platform_device s3c_device_usb_hsudc = {
 void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
 {
 	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
+	pd->phy_init = s3c_hsudc_init_phy;
+	pd->phy_uninit = s3c_hsudc_uninit_phy;
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index aaca1b0a2f59..7bd5182ce3ef 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -30,8 +30,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 
-#include <mach/regs-s3c2443-clock.h>
-
 #define S3C_HSUDC_REG(x)	(x)
 
 /* Non-Indexed Registers */
@@ -186,53 +184,6 @@ static inline void __orr32(void __iomem *ptr, u32 val)
 	writel(readl(ptr) | val, ptr);
 }
 
-static void s3c_hsudc_init_phy(void)
-{
-	u32 cfg;
-
-	cfg = readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
-	writel(cfg, S3C2443_PWRCFG);
-
-	cfg = readl(S3C2443_URSTCON);
-	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
-	writel(cfg, S3C2443_URSTCON);
-	mdelay(1);
-
-	cfg = readl(S3C2443_URSTCON);
-	cfg &= ~(S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
-	writel(cfg, S3C2443_URSTCON);
-
-	cfg = readl(S3C2443_PHYCTRL);
-	cfg &= ~(S3C2443_PHYCTRL_CLKSEL | S3C2443_PHYCTRL_DSPORT);
-	cfg |= (S3C2443_PHYCTRL_EXTCLK | S3C2443_PHYCTRL_PLLSEL);
-	writel(cfg, S3C2443_PHYCTRL);
-
-	cfg = readl(S3C2443_PHYPWR);
-	cfg &= ~(S3C2443_PHYPWR_FSUSPEND | S3C2443_PHYPWR_PLL_PWRDN |
-		S3C2443_PHYPWR_XO_ON | S3C2443_PHYPWR_PLL_REFCLK |
-		S3C2443_PHYPWR_ANALOG_PD);
-	cfg |= S3C2443_PHYPWR_COMMON_ON;
-	writel(cfg, S3C2443_PHYPWR);
-
-	cfg = readl(S3C2443_UCLKCON);
-	cfg |= (S3C2443_UCLKCON_DETECT_VBUS | S3C2443_UCLKCON_FUNC_CLKEN |
-		S3C2443_UCLKCON_TCLKEN);
-	writel(cfg, S3C2443_UCLKCON);
-}
-
-static void s3c_hsudc_uninit_phy(void)
-{
-	u32 cfg;
-
-	cfg = readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
-	writel(cfg, S3C2443_PWRCFG);
-
-	writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
-
-	cfg = readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
-	writel(cfg, S3C2443_UCLKCON);
-}
-
 /**
  * s3c_hsudc_complete_request - Complete a transfer request.
  * @hsep: Endpoint to which the request belongs.
@@ -1188,7 +1139,8 @@ static int s3c_hsudc_start(struct usb_gadget *gadget,
 
 	pm_runtime_get_sync(hsudc->dev);
 
-	s3c_hsudc_init_phy();
+	if (hsudc->pd->phy_init)
+		hsudc->pd->phy_init();
 	if (hsudc->pd->gpio_init)
 		hsudc->pd->gpio_init();
 
@@ -1210,7 +1162,8 @@ static int s3c_hsudc_stop(struct usb_gadget *gadget)
 
 	spin_lock_irqsave(&hsudc->lock, flags);
 	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
-	s3c_hsudc_uninit_phy();
+	if (hsudc->pd->phy_uninit)
+		hsudc->pd->phy_uninit();
 
 	pm_runtime_put(hsudc->dev);
 
diff --git a/include/linux/platform_data/s3c-hsudc.h b/include/linux/platform_data/s3c-hsudc.h
index 4dc9b8760166..a170939832d5 100644
--- a/include/linux/platform_data/s3c-hsudc.h
+++ b/include/linux/platform_data/s3c-hsudc.h
@@ -26,6 +26,8 @@ struct s3c24xx_hsudc_platdata {
 	unsigned int	epnum;
 	void		(*gpio_init)(void);
 	void		(*gpio_uninit)(void);
+	void		(*phy_init)(void);
+	void		(*phy_uninit)(void);
 };
 
 #endif	/* __LINUX_USB_S3C_HSUDC_H */
-- 
2.17.1

