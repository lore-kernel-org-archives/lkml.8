Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC18C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35092073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yYkdbvyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgDAIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:39:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14888 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgDAIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:39:53 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318bETg029934;
        Wed, 1 Apr 2020 10:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=na/oKumJJlSOAsC4yLKxdvbCb8WJgv/VEAjKtvvJjY0=;
 b=yYkdbvycJiGc349n5Huur97tzbGMxNG5IIqp+sKnhXkV8S8g838vVKx6TZUSkg2id7/H
 oqOZQUxHYlJmvXfVDUZkxr66BsaK5ttR1oVWOW0ZTPmcFUyWcbboK9a6GVxy/JAfYz+g
 HxM2Ur6tNeMOM4ir4UY/1CGSlaelKt1mJIbtFojO4zW2XZXdrNME/viJgkFiyviR6jLL
 /VsBb1+lozKUvZT3+E1tRdM/WGudDDTo6YVwbKxIe86xWqQKBiY7PjPsamjzzpSfJoV9
 0hSf6ZeFtX1DFkDD8XQoOhMi2RU2dIidAflOoC6Amqa8IukrY/zaOOmN+nso0ulT0ceO 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301vkdvaht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:39:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 426B410003B;
        Wed,  1 Apr 2020 10:39:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3507121CA8F;
        Wed,  1 Apr 2020 10:39:36 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Apr 2020 10:39:35
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v6 2/6] ARM: dts: stm32: Add timer subnodes on stm32mp15 SoCs
Date:   Wed, 1 Apr 2020 10:39:05 +0200
Message-ID: <20200401083909.18886-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200401083909.18886-1-benjamin.gaignard@st.com>
References: <20200401083909.18886-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer subnode and interrupts to low power timer nodes for
all stm32mp15x SoCs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index fb41d0778b00..09e2dc209976 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -358,6 +358,8 @@
 			reg = <0x40009000 0x400>;
 			clocks = <&rcc LPTIM1_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -376,6 +378,11 @@
 				compatible = "st,stm32-lptimer-counter";
 				status = "disabled";
 			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
 		};
 
 		spi2: spi@4000b000 {
@@ -1135,6 +1142,8 @@
 			reg = <0x50021000 0x400>;
 			clocks = <&rcc LPTIM2_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 48 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1153,6 +1162,11 @@
 				compatible = "st,stm32-lptimer-counter";
 				status = "disabled";
 			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
 		};
 
 		lptimer3: timer@50022000 {
@@ -1162,6 +1176,8 @@
 			reg = <0x50022000 0x400>;
 			clocks = <&rcc LPTIM3_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 50 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1175,6 +1191,11 @@
 				reg = <2>;
 				status = "disabled";
 			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
 		};
 
 		lptimer4: timer@50023000 {
@@ -1182,6 +1203,8 @@
 			reg = <0x50023000 0x400>;
 			clocks = <&rcc LPTIM4_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 52 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1189,6 +1212,11 @@
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
 		};
 
 		lptimer5: timer@50024000 {
@@ -1196,6 +1224,8 @@
 			reg = <0x50024000 0x400>;
 			clocks = <&rcc LPTIM5_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 53 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1203,6 +1233,11 @@
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
+
+			timer {
+				compatible = "st,stm32-lptimer-timer";
+				status = "disabled";
+			};
 		};
 
 		vrefbuf: vrefbuf@50025000 {
-- 
2.15.0

