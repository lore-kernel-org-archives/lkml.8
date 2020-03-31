Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8968C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8033520787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="agKWTWd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgCaIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:32:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33952 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgCaIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:32:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V8SjZ3011728;
        Tue, 31 Mar 2020 10:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1v1U4r1IuuaW9QqrxsAf4ezFvjw5plmmtNHpo6Hw1F0=;
 b=agKWTWd45e2PIS39MINNzpssx3of5D9H9mL0wDT0/AKXSpqp7+WjK5Kes5Naf3j4uwmt
 vrIPKnRq1BJdPu2LW8k+DKFyAdS932xcnkdlH1X+o6jZEf+CNEmLz9HkGvxTVTke94Jh
 lNCYyoveQ4/W2asqY4uJUwE3BRzpRyz4+g8ELjiSUVIRkZSQFWz9bXCwQZQDL5Gl9jye
 gLBRq4JzHMKw+/rCQVO2IT0FdIjhc3pPSkQ0q2tOZLvgiO/nb57LO9DogoDtJoT6DUrN
 LWBF9gmiPfyL6SJsnUD2+Nr3clMO513v+g/1JQqxAEcIBT3Rpp0RfKbHFzn0qcP+Kavn GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 301xbmdsum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 10:32:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AC0110003A;
        Tue, 31 Mar 2020 10:32:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEF7B21E675;
        Tue, 31 Mar 2020 10:32:02 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 10:32:02
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
Subject: [PATCH v5 2/6] ARM: dts: stm32: Add timer subnodes on stm32mp15 SoCs
Date:   Tue, 31 Mar 2020 10:31:42 +0200
Message-ID: <20200331083146.10462-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200331083146.10462-1-benjamin.gaignard@st.com>
References: <20200331083146.10462-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer subnode and interrupts to low power timer nodes for
all stm32mp15x SoCs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index fb41d0778b00..424925068baf 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -358,6 +358,10 @@
 			reg = <0x40009000 0x400>;
 			clocks = <&rcc LPTIM1_K>;
 			clock-names = "mux";
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -376,6 +380,11 @@
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
@@ -1135,6 +1144,10 @@
 			reg = <0x50021000 0x400>;
 			clocks = <&rcc LPTIM2_K>;
 			clock-names = "mux";
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 48 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1153,6 +1166,11 @@
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
@@ -1162,6 +1180,10 @@
 			reg = <0x50022000 0x400>;
 			clocks = <&rcc LPTIM3_K>;
 			clock-names = "mux";
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 50 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1175,6 +1197,11 @@
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
@@ -1182,6 +1209,10 @@
 			reg = <0x50023000 0x400>;
 			clocks = <&rcc LPTIM4_K>;
 			clock-names = "mux";
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 52 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1189,6 +1220,11 @@
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
@@ -1196,6 +1232,10 @@
 			reg = <0x50024000 0x400>;
 			clocks = <&rcc LPTIM5_K>;
 			clock-names = "mux";
+			interrupt-names = "event", "wakeup";
+			interrupts-extended = <&intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					      <&exti 53 IRQ_TYPE_LEVEL_HIGH>;
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1203,6 +1243,11 @@
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

