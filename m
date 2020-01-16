Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD2C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A620748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbgAPVb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53590 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbgAPVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjO-0001Z4-57; Thu, 16 Jan 2020 22:31:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD1921C1995;
        Thu, 16 Jan 2020 22:31:02 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:02 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Fix Kconfig miscues
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        x86 <x86@kernel.org>
In-Reply-To: <4deb42a9-82f2-72f9-891f-972a9a399f4f@infradead.org>
References: <4deb42a9-82f2-72f9-891f-972a9a399f4f@infradead.org>
MIME-Version: 1.0
Message-ID: <157921026273.396.8016577236649393946.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     062934634dc3ae38baeb9961dcc80c44a00ffcf2
Gitweb:        https://git.kernel.org/tip/062934634dc3ae38baeb9961dcc80c44a00ffcf2
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 27 Nov 2019 21:10:22 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:06:57 +01:00

clocksource: Fix Kconfig miscues

Fix lots of typo, spelling, punctuation, and grammar miscues in
drivers/clocksource/Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/4deb42a9-82f2-72f9-891f-972a9a399f4f@infradead.org
---
 drivers/clocksource/Kconfig | 46 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c981ff6..94192fb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -88,7 +88,7 @@ config ROCKCHIP_TIMER
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  Enables the support for the rockchip timer driver.
+	  Enables the support for the Rockchip timer driver.
 
 config ARMADA_370_XP_TIMER
 	bool "Armada 370 and XP timer driver" if COMPILE_TEST
@@ -162,13 +162,13 @@ config NPCM7XX_TIMER
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
-	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
+	  where TIMER0 serves as clockevent and TIMER1 serves as clocksource.
 
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
 	help
-	  Enables support for the cadence ttc driver.
+	  Enables support for the Cadence TTC driver.
 
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
@@ -190,10 +190,10 @@ config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Use the always on PRCMU Timer as clocksource
+	  Use the always on PRCMU Timer as clocksource.
 
 config CLPS711X_TIMER
-	bool "Cirrus logic timer driver" if COMPILE_TEST
+	bool "Cirrus Logic timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Cirrus Logic PS711 timer.
@@ -205,11 +205,11 @@ config ATLAS7_TIMER
 	  Enables support for the Atlas7 timer.
 
 config MXS_TIMER
-	bool "Mxs timer driver" if COMPILE_TEST
+	bool "MXS timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select STMP_DEVICE
 	help
-	  Enables support for the Mxs timer.
+	  Enables support for the MXS timer.
 
 config PRIMA2_TIMER
 	bool "Prima2 timer driver" if COMPILE_TEST
@@ -238,10 +238,10 @@ config KEYSTONE_TIMER
 	  Enables support for the Keystone timer.
 
 config INTEGRATOR_AP_TIMER
-	bool "Integrator-ap timer driver" if COMPILE_TEST
+	bool "Integrator-AP timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
-	  Enables support for the Integrator-ap timer.
+	  Enables support for the Integrator-AP timer.
 
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
@@ -283,8 +283,8 @@ config CLKSRC_NPS
 	select TIMER_OF if OF
 	help
 	  NPS400 clocksource support.
-	  Got 64 bit counter with update rate up to 1000MHz.
-	  This counter is accessed via couple of 32 bit memory mapped registers.
+	  It has a 64-bit counter with update rate up to 1000MHz.
+	  This counter is accessed via couple of 32-bit memory-mapped registers.
 
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
@@ -305,14 +305,14 @@ config ARC_TIMERS
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
 	  (ARC700 as well as ARC HS38).
-	  TIMER0 serves as clockevent while TIMER1 provides clocksource
+	  TIMER0 serves as clockevent while TIMER1 provides clocksource.
 
 config ARC_TIMERS_64BIT
 	bool "Support for 64-bit counters in ARC HS38 cores" if COMPILE_TEST
 	depends on ARC_TIMERS
 	select TIMER_OF
 	help
-	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP)
+	  This enables 2 different 64-bit timers: RTC (for UP) and GFRC (for SMP).
 	  RTC is implemented inside the core, while GFRC sits outside the core in
 	  ARConnect IP block. Driver automatically picks one of them for clocksource
 	  as appropriate.
@@ -390,7 +390,7 @@ config ARM_GLOBAL_TIMER
 	select TIMER_OF if OF
 	depends on ARM
 	help
-	  This options enables support for the ARM global timer unit
+	  This option enables support for the ARM global timer unit.
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
@@ -403,14 +403,14 @@ config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	depends on ARM_GLOBAL_TIMER
 	default y
 	help
-	 Use ARM global timer clock source as sched_clock
+	  Use ARM global timer clock source as sched_clock.
 
 config ARMV7M_SYSTICK
 	bool "Support for the ARMv7M system time" if COMPILE_TEST
 	select TIMER_OF if OF
 	select CLKSRC_MMIO
 	help
-	  This options enables support for the ARMv7M system timer unit
+	  This option enables support for the ARMv7M system timer unit.
 
 config ATMEL_PIT
 	bool "Atmel PIT support" if COMPILE_TEST
@@ -460,7 +460,7 @@ config VF_PIT_TIMER
 	bool
 	select CLKSRC_MMIO
 	help
-	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
+	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
 
 config OXNAS_RPS_TIMER
 	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
@@ -523,7 +523,7 @@ config SH_TIMER_MTU2
 	help
 	  This enables build of a clockevent driver for the Multi-Function
 	  Timer Pulse Unit 2 (MTU2) hardware available on SoCs from Renesas.
-	  This hardware comes with 16 bit-timer registers.
+	  This hardware comes with 16-bit timer registers.
 
 config RENESAS_OSTM
 	bool "Renesas OSTM timer driver" if COMPILE_TEST
@@ -580,7 +580,7 @@ config CLKSRC_TANGO_XTAL
 	select TIMER_OF
 	select CLKSRC_MMIO
 	help
-	  This enables the clocksource for Tango SoC
+	  This enables the clocksource for Tango SoC.
 
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
@@ -601,14 +601,14 @@ config H8300_TMR16
 	depends on HAS_IOMEM
 	help
 	  This enables the 16 bits timer for the H8300 platform with the
-	  H83069 cpu.
+	  H83069 CPU.
 
 config H8300_TPU
 	bool "Clocksource for the H8300 platform" if COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables the clocksource for the H8300 platform with the
-	  H8S2678 cpu.
+	  H8S2678 CPU.
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
@@ -666,8 +666,8 @@ config CSKY_MP_TIMER
 	help
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
 	  system.
-	  csky,mptimer is not only used in SMP system, it also could be used
-	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+	  csky,mptimer is not only used in SMP system, it also could be used in
+	  single core system. It's not a mmio reg and it uses mtcr/mfcr instruction.
 
 config GX6605S_TIMER
 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
