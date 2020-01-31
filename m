Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB620705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="t0qo3vXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgAaNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:42:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728693AbgAaNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:42:01 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VDbWI5016216;
        Fri, 31 Jan 2020 14:41:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=td/ccdvCFi5JOo4jtfLnLcltlvnCuELMxJV2NiVAr8g=;
 b=t0qo3vXTT2CRxLvOm4p3q3nS4dTlr+C3zTTszpVCXX2rsV2NxTgofxzdbqENl18bmCcp
 IoqtbQtKOeE8gQRvzY8x6KktZODUICiBIaMkhAcJUUozUE20tNa2vtOMacvEHbZC1B0z
 NqTe/01KdDCIFIANzlbwGSWbTLm8nONxovyopglUqLuGYV9Mc0ItKC8GCcWbWh4Knhhr
 KXG1yJuLFWRjdAGde9GiQqWHKmnMpMhoEFSicpQ3wkaOZcP/zBCzxZ1XNURmJ8L94fr2
 8YvoznPwa8wfy4c46/Com7p0xJVlPEpuYmdIpXs1YOHZH8UXcnKB8Y/NHy3CiAKTcauT FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpbec5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 14:41:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 606AA100034;
        Fri, 31 Jan 2020 14:41:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D8E52BC7D8;
        Fri, 31 Jan 2020 14:41:47 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan 2020 14:41:46
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
Subject: [PATCH v2 3/4] ARM: debug: stm32: add UART early console support for STM32H7
Date:   Fri, 31 Jan 2020 14:41:22 +0100
Message-ID: <20200131134123.27775-4-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131134123.27775-1-erwan.leray@st.com>
References: <20200131134123.27775-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of early console for STM32H7. Default UART instance is USART1,
but other UART instances can be configured by setting physical and virtual
base addresses in menuconfig.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ff66c294a5a..e5e1703a89c0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1223,6 +1223,18 @@ choice
 
 		  If unsure, say N.
 
+	config STM32H7_DEBUG_UART
+		bool "Use STM32H7 UART for low-level debug"
+		depends on MACH_STM32H743
+		select DEBUG_STM32_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STM32H7 based platforms, which default UART is wired on
+		  USART1, but another UART instance can be selected by modifying
+		  CONFIG_DEBUG_UART_PHYS.
+
+		  If unsure, say N.
+
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
 		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
@@ -1621,7 +1633,8 @@ config DEBUG_UART_PHYS
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
-	default 0x40011000 if STM32F4_DEBUG_UART || STM32F7_DEBUG_UART
+	default 0x40011000 if STM32F4_DEBUG_UART || STM32F7_DEBUG_UART || \
+				STM32H7_DEBUG_UART
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
index b0c7034b33d9..5a2e2b065340 100644
--- a/arch/arm/include/debug/stm32.S
+++ b/arch/arm/include/debug/stm32.S
@@ -9,7 +9,7 @@
 #define STM32_USART_TDR_OFF		0x04
 #endif
 
-#ifdef CONFIG_STM32F7_DEBUG_UART
+#if defined(CONFIG_STM32F7_DEBUG_UART) || defined(CONFIG_STM32H7_DEBUG_UART)
 #define STM32_USART_SR_OFF		0x1C
 #define STM32_USART_TDR_OFF		0x28
 #endif
-- 
2.17.1

