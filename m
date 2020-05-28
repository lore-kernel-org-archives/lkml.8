Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F553C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03F4207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NmJ2qJkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgE1Hje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:39:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgE1Hj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:39:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S7cADv017154;
        Thu, 28 May 2020 09:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FyALCO26XOK/eTghSitDe78wV/WFP/smeKrrxGId2ww=;
 b=NmJ2qJkn17QCml/rYDd4AFiblCGOHQE0qWl+vPK6MjS8E4XGLvOaVNMO99/ya7hNDMg3
 Cc58IHsouAkarRzVO5hc1/4txwJ4t/dMHLJgaryR4tPh4xRyTpwK2iMDB2U/DEPhcDXz
 uKH4WduGbT7zDHyJT2EADtBEoGim43jfEo2NYhnZG8J/yFMLh8uwRGMvA0yrd3tOy/bB
 B+mP1SqCRuD61bAf0WAi/YAu+hu4IOx1PJw2Dem7Gdb0p/uOrV0b0n0lzwlso6TmibrL
 Eui0REwZoAbZrc4ECz5wwjC5TfE6YkuFE+/hlxvCJRjrsfcK6BYnkqlpn4ZTI1ldFK5K VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa29wn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 09:38:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 549A3100034;
        Thu, 28 May 2020 09:38:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42BE32B187F;
        Thu, 28 May 2020 09:38:58 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May 2020 09:38:57
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
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: update uart4 pin configuration for low power on stm32mp157
Date:   Thu, 28 May 2020 09:38:51 +0200
Message-ID: <20200528073853.24759-2-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528073853.24759-1-erwan.leray@st.com>
References: <20200528073853.24759-1-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleep pin configuration is refined for low power modes:
- "sleep" (no wakeup & console suspend enabled): put pins in analog state
  to optimize power
- "idle" (wakeup capability): keep Rx pin in alternate function

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 7eb858732d6d..7cf535dc05f5 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1648,6 +1648,23 @@
 		};
 	};
 
+	uart4_idle_pins_a: uart4-idle-0 {
+		   pins1 {
+			 pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
+		   };
+		   pins2 {
+			 pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+			 bias-disable;
+		   };
+	};
+
+	uart4_sleep_pins_a: uart4-sleep-0 {
+		   pins {
+			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
+				 <STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
+		    };
+	};
+
 	uart4_pins_b: uart4-1 {
 		pins1 {
 			pinmux = <STM32_PINMUX('D', 1, AF8)>; /* UART4_TX */
-- 
2.17.1

