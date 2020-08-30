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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E79C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0291208A9
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="kwJmUEjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH3UGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:06:03 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:44273 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgH3UGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598817517; bh=GjuN2/fQlJOqjNx2OJHrTJv4BYTPn1KJIHQroxtmaro=;
        h=From:To:Subject:Date:Message-Id;
        b=kwJmUEjDZXMxYmpVjio4hjoqVu5LjzxbSDbO9lZgq/dmW4AJTO9BqhprpzCcGZpGm
         E4Ej1r3LstDqjYpojfKMdvQbvzXrQn62lKLYD/ZAD11nRdpHSdEH7yGThs6709qLD4
         IXJf31OrXhr0dBOcKSivd9bGLNe97qdiIPkWCmGaqMFNnKpY7INKgIrFLGv4QyM5XK
         UpsutB0FVM5x25QPQH6wgFr3+D9WgtjwmD0eFl+19WhsDfk5rHQpbMlsxi4H1WJmoR
         fUUgqi51PmHQv22+rZ98mE1eXmxf6bp5m+eqwbQXGUdYlKwLACaZaXhpz9OfamdI+7
         EVCpuPh3trZqQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 1EDFF8C062B;
        Sun, 30 Aug 2020 19:58:27 +0000 (UTC)
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
Subject: [PATCH v2 2/2] arm: sti LL_UART: add STiH418 SBC UART0 support
Date:   Sun, 30 Aug 2020 21:57:48 +0200
Message-Id: <20200830195748.30221-3-avolmat@me.com>
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

Add the entry for the STiH418 SBC UART0 low level uart.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/Kconfig.debug | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e97d6e5c8898..447d177fcf8d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1204,6 +1204,16 @@ choice
 
 		  If unsure, say N.
 
+	config DEBUG_STIH418_SBC_ASC0
+		bool "Use StiH418 SBC ASC0 UART for low-level debug"
+		depends on ARCH_STI
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STiH418 based platforms which has default UART wired
+		  up to SBC ASC0.
+
+		  If unsure, say N.
+
 	config STM32F4_DEBUG_UART
 		bool "Use STM32F4 UART for low-level debug"
 		depends on MACH_STM32F429 || MACH_STM32F469
@@ -1587,6 +1597,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
 	default "debug/sti.S" if DEBUG_STIH41X_ASC2
 	default "debug/sti.S" if DEBUG_STIH41X_SBC_ASC1
+	default "debug/sti.S" if DEBUG_STIH418_SBC_ASC0
 	default "debug/stm32.S" if DEBUG_STM32_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
@@ -1620,6 +1631,7 @@ config DEBUG_UART_PHYS
 	default 0x03010fe0 if ARCH_RPC
 	default 0x07000000 if DEBUG_SUN9I_UART0
 	default 0x09405000 if DEBUG_ZTE_ZX
+	default 0x09530000 if DEBUG_STIH418_SBC_ASC0
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
@@ -1750,7 +1762,8 @@ config DEBUG_UART_PHYS
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
 		DEBUG_AT91_UART || DEBUG_STM32_UART || \
-		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1
+		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1 || \
+		DEBUG_STIH418_SBC_ASC0
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1796,6 +1809,7 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xf8ffee00 if DEBUG_AT91_SAM9263_DBGU
 	default 0xf8fff200 if DEBUG_AT91_RM9200_DBGU
+	default 0xf9530000 if DEBUG_STIH418_SBC_ASC0
 	default 0xf9e09000 if DEBUG_AM33XXUART1
 	default 0xfa020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0xfa022000 if DEBUG_TI81XXUART2
@@ -1864,7 +1878,8 @@ config DEBUG_UART_VIRT
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
 		DEBUG_AT91_UART || DEBUG_STM32_UART || \
-		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1
+  		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1 || \
+		DEBUG_STIH418_SBC_ASC0
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
-- 
2.17.1

