Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469BFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B1F20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pCl9L/5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgGHLnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:43:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1651 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbgGHLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:43:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068BDggv010076;
        Wed, 8 Jul 2020 13:43:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=6ckmkQk8+QiiCG6bsKaHAQ9FdAGOnyaXYUue5dZsFvg=;
 b=pCl9L/5cv2JgF3Gq94BXZJB8HPpS5mz+Vp199r6vkbneJHPGG7wpKe6efh76+v6sHYbx
 7tAvwRJBjOysfghCcCgTV5tSKKqk6vk2bVgDlLWkdcmu5Desf/+N5rP1QkXRJ0ywKPiQ
 a9bUAtiQGnwLMvTEmwZFoiBz1yNqNmUuneCCByi30J96o69hkWeeGTNVsjzpG2OzF5Tw
 BioGq1RZ0ahuq6+CjJ3FhybG2GDLPARVtzNwtkrEPlf+0BW02q136NLlvI9hD1nGNZ+h
 SDE4IzYGNr07AjY9So5Tc5YksPFFhCT+Y4Gz7zzHijfDrFl9SGstks8Nt3eC6q8QT1Kj Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322fhv781s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 13:43:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96AED100034;
        Wed,  8 Jul 2020 13:43:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8804D2B4D31;
        Wed,  8 Jul 2020 13:43:34 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul 2020 13:43:33
 +0200
From:   Patrick Delaunay <patrick.delaunay@st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Patrick Delaunay <patrick.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32: Correct spi4 pins in stm32mp15-pinctrl.dtsi
Date:   Wed, 8 Jul 2020 13:43:24 +0200
Message-ID: <20200708114324.7309-1-patrick.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_08:2020-07-08,2020-07-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move spi4_pins_a nodes from pinctrl_z to pinctrl
as the associated pins are not in BANK Z.

Fixes: 498a7014989dfdd9a47864b55704dc829ed0dc90
Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
---

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 7eb858732d6d..6aedbd7077ff 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1574,6 +1574,20 @@
 		};
 	};
 
+	spi4_pins_a: spi4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
+				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
+			bias-disable;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
@@ -1776,18 +1790,4 @@
 			bias-disable;
 		};
 	};
-
-	spi4_pins_a: spi4-0 {
-		pins {
-			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
-				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
-			bias-disable;
-			drive-push-pull;
-			slew-rate = <1>;
-		};
-		pins2 {
-			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
-			bias-disable;
-		};
-	};
 };
-- 
2.17.1

