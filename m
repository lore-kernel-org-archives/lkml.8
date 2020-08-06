Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B416DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA41F22C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739066;
	bh=SjPJsYrN3QRqHdDAx/ThlGF33s4qIJNCl4XoopDuY6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUq+OWQ3sMR6t803Gpr1w9fjdX9zEQmZIdSijbuPmiiGuRbzxcMm/z2RU9NJ0FZQW
	 eYOrulZKPjVN2nmF0iGk5vsmOBXQVXODtQOmJiKOq4sXVKJhDYy4xVyyN62Rve9H3L
	 teu7KjThmqPiw17rSGa0sn485Nsp2JsDrhmLZvZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHFShn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgHFSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F2222D0B;
        Thu,  6 Aug 2020 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738144;
        bh=SjPJsYrN3QRqHdDAx/ThlGF33s4qIJNCl4XoopDuY6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVykUEsX/OUpnsTlsq0nkF0ICVW5WxJlXQtVx00AL3zeBRe2rLWePXLOsQWqllsjX
         xgY9+r4wcRkKmXizwubDy6mngreyoyOko3SoeJxMdfEMTcn4WAV6QOnOqtOj286dH3
         wq4S1Ub0nRxKjOS5+WnXA68R1fhzB9WEX2tlnWsk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 12/41] ARM: samsung: make pm-debug platform independent
Date:   Thu,  6 Aug 2020 20:20:29 +0200
Message-Id: <20200806182059.2431-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The pm-debug code is one of the few things shared between
s3c24xx/s3c64xx and the newer s5pv210. In order to make s5pv210
independent of plat-samsung, change the common bits of this code to no
longer reference the s3c specific bits.

In particular, all the CPU checks need to be moved out of the common
code into platform specific files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/include/mach/pm-core.h  |  5 --
 arch/arm/mach-s3c64xx/include/mach/pm-core.h  | 42 ----------------
 arch/arm/mach-s3c64xx/pm.c                    | 50 +++++++++++++++++++
 arch/arm/mach-s5pv210/pm.c                    |  4 +-
 .../arm/plat-samsung/include/plat/pm-common.h | 19 +++++--
 arch/arm/plat-samsung/pm-debug.c              | 16 ++----
 arch/arm/plat-samsung/pm.c                    |  5 +-
 7 files changed, 74 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index cd6406820cb1..8f87606c4cdc 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -77,11 +77,6 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
 				s3c_irqwake_eintmask);
 }
 
-static inline void s3c_pm_arch_update_uart(void __iomem *regs,
-					   struct pm_uart_save *save)
-{
-}
-
 static inline void s3c_pm_restored_gpios(void) { }
 static inline void samsung_pm_saved_gpios(void) { }
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index 1c7d179a86f3..33cf242734a0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -65,48 +65,6 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
 #define s3c_irqwake_intallow  0
 #endif
 
-static inline void s3c_pm_arch_update_uart(void __iomem *regs,
-					   struct pm_uart_save *save)
-{
-	u32 ucon = __raw_readl(regs + S3C2410_UCON);
-	u32 ucon_clk = ucon & S3C6400_UCON_CLKMASK;
-	u32 save_clk = save->ucon & S3C6400_UCON_CLKMASK;
-	u32 new_ucon;
-	u32 delta;
-
-	/* S3C64XX UART blocks only support level interrupts, so ensure that
-	 * when we restore unused UART blocks we force the level interrupt
-	 * settigs. */
-	save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
-
-	/* We have a constraint on changing the clock type of the UART
-	 * between UCLKx and PCLK, so ensure that when we restore UCON
-	 * that the CLK field is correctly modified if the bootloader
-	 * has changed anything.
-	 */
-	if (ucon_clk != save_clk) {
-		new_ucon = save->ucon;
-		delta = ucon_clk ^ save_clk;
-
-		/* change from UCLKx => wrong PCLK,
-		 * either UCLK can be tested for by a bit-test
-		 * with UCLK0 */
-		if (ucon_clk & S3C6400_UCON_UCLK0 &&
-		    !(save_clk & S3C6400_UCON_UCLK0) &&
-		    delta & S3C6400_UCON_PCLK2) {
-			new_ucon &= ~S3C6400_UCON_UCLK0;
-		} else if (delta == S3C6400_UCON_PCLK2) {
-			/* as an precaution, don't change from
-			 * PCLK2 => PCLK or vice-versa */
-			new_ucon ^= S3C6400_UCON_PCLK2;
-		}
-
-		S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
-			  ucon, new_ucon, save->ucon);
-		save->ucon = new_ucon;
-	}
-}
-
 static inline void s3c_pm_restored_gpios(void)
 {
 	/* ensure sleep mode has been cleared from the system */
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index fd6dbb263ed5..a612e9779057 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -305,6 +305,56 @@ static void s3c64xx_pm_prepare(void)
 	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT), S3C64XX_WAKEUP_STAT);
 }
 
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
+void s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
+{
+	u32 ucon;
+	u32 ucon_clk
+	u32 save_clk;
+	u32 new_ucon;
+	u32 delta;
+
+	if (!soc_is_s3c64xx())
+		return;
+
+	ucon = __raw_readl(regs + S3C2410_UCON);
+	ucon_clk = ucon & S3C6400_UCON_CLKMASK;
+	sav_clk = save->ucon & S3C6400_UCON_CLKMASK;
+
+	/* S3C64XX UART blocks only support level interrupts, so ensure that
+	 * when we restore unused UART blocks we force the level interrupt
+	 * settigs. */
+	save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
+
+	/* We have a constraint on changing the clock type of the UART
+	 * between UCLKx and PCLK, so ensure that when we restore UCON
+	 * that the CLK field is correctly modified if the bootloader
+	 * has changed anything.
+	 */
+	if (ucon_clk != save_clk) {
+		new_ucon = save->ucon;
+		delta = ucon_clk ^ save_clk;
+
+		/* change from UCLKx => wrong PCLK,
+		 * either UCLK can be tested for by a bit-test
+		 * with UCLK0 */
+		if (ucon_clk & S3C6400_UCON_UCLK0 &&
+		    !(save_clk & S3C6400_UCON_UCLK0) &&
+		    delta & S3C6400_UCON_PCLK2) {
+			new_ucon &= ~S3C6400_UCON_UCLK0;
+		} else if (delta == S3C6400_UCON_PCLK2) {
+			/* as an precaution, don't change from
+			 * PCLK2 => PCLK or vice-versa */
+			new_ucon ^= S3C6400_UCON_PCLK2;
+		}
+
+		S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
+			  ucon, new_ucon, save->ucon);
+		save->ucon = new_ucon;
+	}
+}
+#endif
+
 int __init s3c64xx_pm_init(void)
 {
 	int i;
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 725e6746f345..efdb5a27c060 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -111,7 +111,7 @@ static int s5pv210_suspend_enter(suspend_state_t state)
 		return -EINVAL;
 	}
 
-	s3c_pm_save_uarts();
+	s3c_pm_save_uarts(false);
 	s5pv210_pm_prepare();
 	flush_cache_all();
 	s3c_pm_check_store();
@@ -120,7 +120,7 @@ static int s5pv210_suspend_enter(suspend_state_t state)
 	if (ret)
 		return ret;
 
-	s3c_pm_restore_uarts();
+	s3c_pm_restore_uarts(false);
 
 	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
 			__raw_readl(S5P_WAKEUP_STAT));
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index 467e7c867c46..87fa97fd6e8b 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -71,13 +71,24 @@ extern void s3c_pm_dbg(const char *msg, ...);
 
 #define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
 
-extern void s3c_pm_save_uarts(void);
-extern void s3c_pm_restore_uarts(void);
+extern void s3c_pm_save_uarts(bool is_s3c24xx);
+extern void s3c_pm_restore_uarts(bool is_s3c24xx);
+
+#ifdef CONFIG_ARCH_S3C64XX
+extern void s3c_pm_arch_update_uart(void __iomem *regs,
+				    struct pm_uart_save *save);
+#else
+static inline void
+s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
+{
+}
+#endif
+
 #else
 #define S3C_PMDBG(fmt...) pr_debug(fmt)
 
-static inline void s3c_pm_save_uarts(void) { }
-static inline void s3c_pm_restore_uarts(void) { }
+static inline void s3c_pm_save_uarts(bool is_s3c24xx) { }
+static inline void s3c_pm_restore_uarts(bool is_s3c24xx) { }
 #endif
 
 /* suspend memory checking */
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index 105b61f3304e..482d53753e93 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -18,14 +18,6 @@
 #include <plat/cpu.h>
 #include <plat/pm-common.h>
 
-#ifdef CONFIG_SAMSUNG_ATAGS
-#include <plat/pm.h>
-#include <mach/pm-core.h>
-#else
-static inline void s3c_pm_arch_update_uart(void __iomem *regs,
-					   struct pm_uart_save *save) {}
-#endif
-
 static struct pm_uart_save uart_save;
 
 extern void printascii(const char *);
@@ -52,7 +44,7 @@ static inline void __iomem *s3c_pm_uart_base(void)
 	return (void __iomem *)vaddr;
 }
 
-void s3c_pm_save_uarts(void)
+void s3c_pm_save_uarts(bool is_s3c2410)
 {
 	void __iomem *regs = s3c_pm_uart_base();
 	struct pm_uart_save *save = &uart_save;
@@ -63,14 +55,14 @@ void s3c_pm_save_uarts(void)
 	save->umcon = __raw_readl(regs + S3C2410_UMCON);
 	save->ubrdiv = __raw_readl(regs + S3C2410_UBRDIV);
 
-	if (!soc_is_s3c2410())
+	if (!is_s3c2410)
 		save->udivslot = __raw_readl(regs + S3C2443_DIVSLOT);
 
 	S3C_PMDBG("UART[%p]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
 		  regs, save->ulcon, save->ucon, save->ufcon, save->ubrdiv);
 }
 
-void s3c_pm_restore_uarts(void)
+void s3c_pm_restore_uarts(bool is_s3c2410)
 {
 	void __iomem *regs = s3c_pm_uart_base();
 	struct pm_uart_save *save = &uart_save;
@@ -83,6 +75,6 @@ void s3c_pm_restore_uarts(void)
 	__raw_writel(save->umcon, regs + S3C2410_UMCON);
 	__raw_writel(save->ubrdiv, regs + S3C2410_UBRDIV);
 
-	if (!soc_is_s3c2410())
+	if (!is_s3c2410)
 		__raw_writel(save->udivslot, regs + S3C2443_DIVSLOT);
 }
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index b40ab7abe6a9..03c22a9dee21 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -25,6 +25,7 @@
 
 #include <asm/irq.h>
 
+#include <plat/cpu.h>
 #include <plat/pm.h>
 #include <mach/pm-core.h>
 
@@ -99,7 +100,7 @@ static int s3c_pm_enter(suspend_state_t state)
 		samsung_pm_saved_gpios();
 	}
 
-	s3c_pm_save_uarts();
+	s3c_pm_save_uarts(soc_is_s3c2410());
 	s3c_pm_save_core();
 
 	/* set the irq configuration for wake */
@@ -136,7 +137,7 @@ static int s3c_pm_enter(suspend_state_t state)
 	/* restore the system state */
 
 	s3c_pm_restore_core();
-	s3c_pm_restore_uarts();
+	s3c_pm_restore_uarts(soc_is_s3c2410());
 
 	if (!of_have_populated_dt()) {
 		samsung_pm_restore_gpios();
-- 
2.17.1

