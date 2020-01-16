Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15912C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68542051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXUTedlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395546AbgAPSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405626AbgAPSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so4811217wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qBNUmHVyRoOy7vlZauOG0eUc8Bfbdt0j+6alacEhE0=;
        b=NXUTedlLtsx4bdIx1FC6GW0FmpKFAHbJ8HGLVfu6vmPev3O/YD/Qij1yvjqFbCW9bt
         jho0D72anvEi9HDUxXOE/NrMq39b1RVvZKmWfaGDYAF6gkQSDwu0CU23aDInw6RpVqqM
         xmj10EUpLsoRblMIG9j2+5k2RBcqzrYBWIPfqIKXi0SInxWxct6b0xhlx5keTPPzS1La
         aDB3P1nfP7idaleLiZS4uwVCjbkrWfOvtTxDFEnzKleaZTFiBqhANV3R6peFTO4t50RH
         nBOtEjABB3PmtNRxD7NUnkVCwoI/NfBdAGL9i/Qx8ay6vW4IgA/Osk024uewLn5eAn35
         Feug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qBNUmHVyRoOy7vlZauOG0eUc8Bfbdt0j+6alacEhE0=;
        b=QoTOWJ8GnJYxFqfT9XQM0TF/IF6AkNhE9fT9pc/F8y2Kp+mbfQckjILpH+tjRT04qZ
         LVqYS9bledKQSpRyDvf4DfIP/twMXi3Kc5oJCynoAxehqnI4fwzgLyNBJGu3tU063g1J
         tITlrVmASVunAbfWIprpvhLlnlKSftOndTtidLbhFGMsM2/IBGP3Voc7sc7ZhkdgMy0U
         TUaHOHYwhxMWowq+NcoS4cAeIMwY2tu3nWGoeObyG8llcWPAKDfn7aGGzVnyZfq+fw9k
         KnNsc71W+zSxvlGxQgJHwxwUf5GtnuTU2b4RsX5gzhetj0Q5myEu77b/X2ZxYXcUlLkk
         kTWQ==
X-Gm-Message-State: APjAAAUXpY6waj776VdiONPsxNaLzrvje7CHL2wme71Bj2n4L0RsbWyy
        t+HcjYlYLwCTGd3FyQN3wJMLrw==
X-Google-Smtp-Source: APXvYqxTiMTxQglBtxLCKYDa57WgpGaTuZaguSrpYzYu7WxZxlR2/85dyhvAWv4P9o9tOuiIzHUqgw==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr344890wme.76.1579199002635;
        Thu, 16 Jan 2020 10:23:22 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH 04/17] clocksource: Fix Kconfig miscues
Date:   Thu, 16 Jan 2020 19:22:51 +0100
Message-Id: <20200116182304.4926-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
 drivers/clocksource/Kconfig | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c981ff64bc13..94192fb0533e 100644
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
-- 
2.17.1

