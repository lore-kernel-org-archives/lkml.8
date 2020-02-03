Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058EC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1895E21582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="k3DnYPQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBCOE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:04:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6218 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbgBCOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:04:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013E3oVC022136;
        Mon, 3 Feb 2020 15:04:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=AxV9vH56OpkskaoqHe+T5VRZT2jdcBi4jBwKkhXoGY0=;
 b=k3DnYPQDNjhxtNPiF2RJ3QmWkIUG/KZPtH/P/y8CllcAkNECF9rRGTjzFkSqPpzDgmOY
 5cD+mBMSb1kujK/A1p7kQxUl5FIGHwssHTvSbEvVRb2r7WToWBqJztNn+mFmAhMyZs3r
 bMcOggg3PvpVvXrNvDPIXSn/KYVzKP4PU3JS+WXbuumb7K9YwE+6Bohv8vbS0a9a4Xiv
 l4dVaaagzHBV7+VPP4TPVgOgzlQNdUYollYBpDyv9aPpNPqUjyfXjFVT/eyvkAJHmSP9
 uYBNbTTxzXlG8XUkv4Kwksm7PapzIlr4lfifAAKTfqtKDiGA0iTzLB8/k7ALBi7REcTj 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybdspn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 15:04:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6857100034;
        Mon,  3 Feb 2020 15:04:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D5DA2AAB83;
        Mon,  3 Feb 2020 15:04:39 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb 2020 15:04:39
 +0100
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Erwan Le Ray <erwan.leray@st.com>,
        Clement Peron <peron.clem@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v3 1/4] ARM: debug: stm32: add UART early console configuration for STM32F4
Date:   Mon, 3 Feb 2020 15:04:22 +0100
Message-ID: <20200203140425.26579-2-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203140425.26579-1-erwan.leray@st.com>
References: <20200203140425.26579-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_04:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early console is hardcoded on USART1 in current implementation.
With this patch, default UART instance is USART1, but other UART instances
can be configured by setting physical and virtual base addresses in
menuconfig.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8bcbd0cd739b..4f982ef1d0ec 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1201,12 +1201,13 @@ choice
 
 	config STM32F4_DEBUG_UART
 		bool "Use STM32F4 UART for low-level debug"
-		depends on ARCH_STM32
+		depends on MACH_STM32F429 || MACH_STM32F469
 		select DEBUG_STM32_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on STM32F4 based platforms, which default UART is wired on
-		  USART1.
+		  USART1, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS.
 
 		  If unsure, say N.
 
@@ -1619,6 +1620,7 @@ config DEBUG_UART_PHYS
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40011000 if STM32F4_DEBUG_UART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
@@ -1713,7 +1715,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1823,7 +1825,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_STM32_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
index 1abb32f685fd..b0c7034b33d9 100644
--- a/arch/arm/include/debug/stm32.S
+++ b/arch/arm/include/debug/stm32.S
@@ -4,8 +4,6 @@
  * Author:   Gerald Baeza <gerald.baeza@st.com> for STMicroelectronics.
  */
 
-#define STM32_UART_BASE			0x40011000	/* USART1 */
-
 #ifdef CONFIG_STM32F4_DEBUG_UART
 #define STM32_USART_SR_OFF		0x00
 #define STM32_USART_TDR_OFF		0x04
@@ -20,8 +18,8 @@
 #define STM32_USART_TXE			(1 << 7)	/* Tx data reg empty */
 
 .macro	addruart, rp, rv, tmp
-	ldr	\rp,      =STM32_UART_BASE	@ physical base
-	ldr	\rv,      =STM32_UART_BASE      @ virt base /* NoMMU */
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS @ physical base
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT @ virt base
 .endm
 
 .macro  senduart,rd,rx
-- 
2.17.1

