Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270CC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A478208A9
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="jpdRxShk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgH3UHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:07:50 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:35462 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgH3UHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598817505; bh=QzAeVYpYDa+eOPYZmACi/MSD1bPQEKu+AV/VR9tJsqM=;
        h=From:To:Subject:Date:Message-Id;
        b=jpdRxShkyVbzINtV+MN1wQoj8yhpcZVj8N2YCQMrvFjf4PFaanH0ML/MRgcgfdjYB
         lujqnqJLhsakaBgl61KZ+yr73aIXBFBUZaYrUq29aCxbDW2z57Ldxc/9P30EYfae4J
         eobMguopFY+f3SHel3Bk2MvLx6Ss48f0qIa62ClYE9CLSZzUO5/H2H4srZ0OM+l8Cv
         IiQoy07A9hGnhCPp/jKVsEHzaVXk7xr04FfZ5ZLQSKK0z/tKYKSDmdMzZklZ3YN10g
         8Xt8XqOWwLYaiiiRC5fW+BIqiD52753gI/XBo46OoJ4qd3GH8uXPCqpO04rl8EnrNV
         SBHHpOUjw4bBQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 303A35401FF;
        Sun, 30 Aug 2020 19:58:25 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     patrice.chotard@st.com, avolmat@me.com
Subject: [PATCH v2 1/2] arm: use DEBUG_UART_PHYS and DEBUG_UART_VIRT for sti LL_UART
Date:   Sun, 30 Aug 2020 21:57:47 +0200
Message-Id: <20200830195748.30221-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830195748.30221-1-avolmat@me.com>
References: <20200830195748.30221-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-30_07:2020-08-28,2020-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008300163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the sti platform LL_UART support to rely on
CONFIG_DEBUG_UART_PHYS and CONFIG_DEBUG_UART_VIRT from Kconfig

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/Kconfig.debug       | 23 ++++++++++++-----------
 arch/arm/include/debug/sti.S | 26 ++------------------------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 80000a66a4e3..e97d6e5c8898 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1184,10 +1184,9 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on ST SPEAr13xx based platforms.
 
-	config STIH41X_DEBUG_ASC2
+	config DEBUG_STIH41X_ASC2
 		bool "Use StiH415/416 ASC2 UART for low-level debug"
 		depends on ARCH_STI
-		select DEBUG_STI_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on STiH415/416 based platforms like b2000, which has
@@ -1195,10 +1194,9 @@ choice
 
 		  If unsure, say N.
 
-	config STIH41X_DEBUG_SBC_ASC1
+	config DEBUG_STIH41X_SBC_ASC1
 		bool "Use StiH415/416 SBC ASC1 UART for low-level debug"
 		depends on ARCH_STI
-		select DEBUG_STI_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on STiH415/416 based platforms like b2020. which has
@@ -1534,10 +1532,6 @@ config DEBUG_TEGRA_UART
 	bool
 	depends on ARCH_TEGRA
 
-config DEBUG_STI_UART
-	bool
-	depends on ARCH_STI
-
 config DEBUG_STM32_UART
 	bool
 	depends on ARCH_STM32
@@ -1591,7 +1585,8 @@ config DEBUG_LL_INCLUDE
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART || DEBUG_S3C64XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
 	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
-	default "debug/sti.S" if DEBUG_STI_UART
+	default "debug/sti.S" if DEBUG_STIH41X_ASC2
+	default "debug/sti.S" if DEBUG_STIH41X_SBC_ASC1
 	default "debug/stm32.S" if DEBUG_STM32_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
@@ -1723,7 +1718,9 @@ config DEBUG_UART_PHYS
 	default 0xfc00c000 if DEBUG_AT91_SAMA5D4_USART3
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfd883000 if DEBUG_ALPINE_UART0
+	default 0xfe531000 if DEBUG_STIH41X_SBC_ASC1
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xfed32000 if DEBUG_STIH41X_ASC2
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART0
 	default 0xffc02100 if DEBUG_SOCFPGA_ARRIA10_UART1
@@ -1752,7 +1749,8 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART || DEBUG_STM32_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART || \
+		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1817,7 +1815,9 @@ config DEBUG_UART_VIRT
 	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_BCM63XX_UART
 	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
+	default 0xfd531000 if DEBUG_STIH41X_SBC_ASC1
 	default 0xfd883000 if DEBUG_ALPINE_UART0
+	default 0xfdd32000 if DEBUG_STIH41X_ASC2
 	default 0xfe010000 if STM32MP1_DEBUG_UART
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
@@ -1863,7 +1863,8 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART || DEBUG_STM32_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART || \
+		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/sti.S b/arch/arm/include/debug/sti.S
index 6b42c91f217d..a903a60b81c6 100644
--- a/arch/arm/include/debug/sti.S
+++ b/arch/arm/include/debug/sti.S
@@ -6,28 +6,6 @@
  * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
  */
 
-#define STIH41X_COMMS_BASE              0xfed00000
-#define STIH41X_ASC2_BASE               (STIH41X_COMMS_BASE+0x32000)
-
-#define STIH41X_SBC_LPM_BASE            0xfe400000
-#define STIH41X_SBC_COMMS_BASE          (STIH41X_SBC_LPM_BASE + 0x100000)
-#define STIH41X_SBC_ASC1_BASE           (STIH41X_SBC_COMMS_BASE + 0x31000)
-
-
-#define VIRT_ADDRESS(x)		(x - 0x1000000)
-
-#if IS_ENABLED(CONFIG_STIH41X_DEBUG_ASC2)
-#define DEBUG_LL_UART_BASE	STIH41X_ASC2_BASE
-#endif
-
-#if IS_ENABLED(CONFIG_STIH41X_DEBUG_SBC_ASC1)
-#define DEBUG_LL_UART_BASE	STIH41X_SBC_ASC1_BASE
-#endif
-
-#ifndef DEBUG_LL_UART_BASE
-#error "DEBUG UART is not Configured"
-#endif
-
 #define ASC_TX_BUF_OFF  0x04
 #define ASC_CTRL_OFF    0x0c
 #define ASC_STA_OFF     0x14
@@ -37,8 +15,8 @@
 
 
 		.macro	addruart, rp, rv, tmp
-		ldr	\rp,      =DEBUG_LL_UART_BASE	@ physical base
-		ldr	\rv,      =VIRT_ADDRESS(DEBUG_LL_UART_BASE) @ virt base
+		ldr	\rp,      =CONFIG_DEBUG_UART_PHYS	@ physical base
+		ldr	\rv,      =CONFIG_DEBUG_UART_VIRT	@ virt base
 		.endm
 
                 .macro  senduart,rd,rx
-- 
2.17.1

