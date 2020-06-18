Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474E8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F5C20707
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Qk4+YYl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgFRNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:07:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730078AbgFRNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:07:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ID4TDA002369;
        Thu, 18 Jun 2020 15:07:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=5XU/0J3RAI8AZsj9EUAZG/2xnH7KRcguIz1gSCUQgL8=;
 b=Qk4+YYl8GlgAHbuzKtdbXHneDZTRQFNa5antsevYD8QYI4GF/oo1BuJkuqvm/AmvpFS4
 QoT9nIXQaIAK3iw1sw/PAqfaF4o440QgpTwIQzoUees9zH38ExEWZ6LOnHN6liQJFDMH
 X3QviWkhD77oYqlQaT0CRpHaNWx+yG5V+gxtHQy0RHfPS93jro+8LQ3xyHT/jAkMIFuM
 aEbkYfQYoQDNiA2T9ZDS5+LMBhIpFI5LvnPOVghRWSg2cZ/iSATzJcAxf0rZmDvlo6nF
 MuHhtoWJ0+Q+f7RU+z9O2r4x9e1c3vpp4GnWQHdc4lX7ZDfFyFcMkctnw63yT/2VdEhc pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31q649k3gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 15:07:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF2EC100034;
        Thu, 18 Jun 2020 15:06:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC9382AAA9A;
        Thu, 18 Jun 2020 15:06:59 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun 2020 15:06:59
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 1/5] ARM: dts: stm32: add usart2, usart3 and uart7 pins in stm32mp15-pinctrl
Date:   Thu, 18 Jun 2020 15:06:47 +0200
Message-ID: <20200618130651.29836-2-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618130651.29836-1-erwan.leray@st.com>
References: <20200618130651.29836-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds usart2_pins_c, usart3_pins_b, usart3_pins_c and uart7_pins_c pins
configurations in stm32mp15-pinctrl.
- usart2_pins_c pins are connected to Bluetooth chip on dk2 board.
- usart3_pins_b pins are connected to GPIO expansion connector on evx board.
- usart3_pins_c pins are connected to GPIO expansion connector on dkx board.
- uart7_pins_c pins are connected to Arduino Uno connector on dkx board.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

Changes in v2:
 - Update UART7 pins comments. Comments indicated "USART" instead of "UART".

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index fb98a66977fe..21b0906accf3 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1658,6 +1658,36 @@
 		};
 	};
 
+	uart7_pins_c: uart7-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
+			bias-disable;
+		};
+	};
+
+	uart7_idle_pins_c: uart7-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 8, ANALOG)>; /* UART7_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 7, AF7)>; /* UART7_RX */
+			bias-disable;
+		};
+	};
+
+	uart7_sleep_pins_c: uart7-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* UART7_TX */
+				 <STM32_PINMUX('E', 7, ANALOG)>; /* UART7_RX */
+		};
+	};
+
 	uart8_pins_a: uart8-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
@@ -1719,6 +1749,42 @@
 		};
 	};
 
+	usart2_pins_c: usart2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 5, AF7)>, /* USART2_TX */
+				 <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 6, AF7)>, /* USART2_RX */
+				 <STM32_PINMUX('D', 3, AF7)>; /* USART2_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart2_idle_pins_c: usart2-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
+				 <STM32_PINMUX('D', 3, ANALOG)>; /* USART2_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_sleep_pins_c: usart2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
+				 <STM32_PINMUX('D', 6, ANALOG)>, /* USART2_RX */
+				 <STM32_PINMUX('D', 3, ANALOG)>; /* USART2_CTS_NSS */
+		};
+	};
+
 	usart3_pins_a: usart3-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
@@ -1732,6 +1798,78 @@
 		};
 	};
 
+	usart3_pins_b: usart3-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
+				 <STM32_PINMUX('I', 10, AF8)>; /* USART3_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart3_idle_pins_b: usart3-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
+				 <STM32_PINMUX('I', 10, ANALOG)>; /* USART3_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
+			bias-disable;
+		};
+	};
+
+	usart3_sleep_pins_b: usart3-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
+				 <STM32_PINMUX('I', 10, ANALOG)>, /* USART3_CTS_NSS */
+				 <STM32_PINMUX('B', 12, ANALOG)>; /* USART3_RX */
+		};
+	};
+
+	usart3_pins_c: usart3-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
+				 <STM32_PINMUX('B', 13, AF7)>; /* USART3_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart3_idle_pins_c: usart3-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
+				 <STM32_PINMUX('B', 13, ANALOG)>; /* USART3_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
+			bias-disable;
+		};
+	};
+
+	usart3_sleep_pins_c: usart3-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
+				 <STM32_PINMUX('B', 13, ANALOG)>, /* USART3_CTS_NSS */
+				 <STM32_PINMUX('B', 12, ANALOG)>; /* USART3_RX */
+		};
+	};
+
 	usbotg_hs_pins_a: usbotg-hs-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
-- 
2.17.1

