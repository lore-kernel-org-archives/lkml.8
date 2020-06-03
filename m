Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516FF20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LzQ/sC9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgFCM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:56:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49933 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgFCM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:56:07 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053CrGoA001316;
        Wed, 3 Jun 2020 14:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=eBxkQEjV5LwT97ZezRCcYQScn1j4krELuQFmG3AFDoc=;
 b=LzQ/sC9LCuJ/SM6sagUyko28sHK83J2QMLWpAo/eeVW/jY2CTfiqXl8yzq77z49U+KUe
 IASu65HvUMan1an+k8YEGDyrSZvvLOXRuMzSySXO0zHgX/wXDKJdKy6VvAIJoWRZHzHT
 GwTcSclqXJMms6tEZtHElm7S6tseUu+++E3jOm/4gLywsPv0n2wDg2ressFhD5VzV5nx
 N60fS0Sj+JQMiESD6DA9QTfRnboJKD5gfQkZlwq4uIWSzT6Xp3vtvuQcUnpuxnSF7Bb1
 alf9FQNEt5nLofVabDBhXgnAss5QMN8F+JqmZTlX0p0W3dpFaC7vF3x7ES0kRqTTZhP0 DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31bd8w4npg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 14:55:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ACD99100038;
        Wed,  3 Jun 2020 14:55:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8866A2CBE8C;
        Wed,  3 Jun 2020 14:55:38 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 3 Jun 2020 14:54:43
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fabrice.gasnier@st.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux@armlinux.org.uk>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RESEND v7 2/6] ARM: dts: stm32: Add timer subnodes on stm32mp15 SoCs
Date:   Wed, 3 Jun 2020 14:54:35 +0200
Message-ID: <20200603125439.23275-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200603125439.23275-1-benjamin.gaignard@st.com>
References: <20200603125439.23275-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_12:2020-06-02,2020-06-03 signatures=0
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
index 3ea05ba48215..5e881e8d0f58 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -359,6 +359,8 @@
 			reg = <0x40009000 0x400>;
 			clocks = <&rcc LPTIM1_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -377,6 +379,11 @@
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
@@ -1144,6 +1151,8 @@
 			reg = <0x50021000 0x400>;
 			clocks = <&rcc LPTIM2_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 48 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1162,6 +1171,11 @@
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
@@ -1171,6 +1185,8 @@
 			reg = <0x50022000 0x400>;
 			clocks = <&rcc LPTIM3_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 50 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1184,6 +1200,11 @@
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
@@ -1191,6 +1212,8 @@
 			reg = <0x50023000 0x400>;
 			clocks = <&rcc LPTIM4_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 52 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1198,6 +1221,11 @@
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
@@ -1205,6 +1233,8 @@
 			reg = <0x50024000 0x400>;
 			clocks = <&rcc LPTIM5_K>;
 			clock-names = "mux";
+			interrupts-extended = <&exti 53 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1212,6 +1242,11 @@
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

