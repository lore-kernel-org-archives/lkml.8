Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0167F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SKbzkvZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgFPPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:33:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45313 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728448AbgFPPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:33:56 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GFD1Et005397;
        Tue, 16 Jun 2020 17:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ywECLfS8RJnUvCXHRDqenH4W2P5mGI7YRrQh1zdXSqs=;
 b=SKbzkvZ8Sh8AH5bW88BqONOypCrZFZCdlCxIv5kAzNuKFlU+HOUcNMI/OqCgpZraSC6Y
 6/jibWFEnMfpx+LCOJD2IEtbKiNRFSDWq13MmFX0TdF1aPS/lPX2/gAzvc6JXjTXkYjF
 cLbYGA/zbJI7uw3SrKaYGTMycWh9OObAYos44B+jqFs1RZW9pJJoqRPyrfV+M+5jGujZ
 sxeKePJ8Mi/VK5O2MY+oHQ//6Ey9NhhBC2sKNYUQhQjJ0GdrAe78wvcYNUbVkIZyXbjm
 Vg8fQbwcA/ypu5Hl9oW+qtwrMlOHRpcZZ+EyuA2kkFQJdJZwxXbH5sZBZTeG+RrryVo2 pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjw05cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 17:33:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 075B010002A;
        Tue, 16 Jun 2020 17:33:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E90032C890A;
        Tue, 16 Jun 2020 17:33:40 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Jun 2020 17:33:40
 +0200
From:   Patrick Delaunay <patrick.delaunay@st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Patrick Delaunay <patrick.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32: cosmetic update in stm32mp15-pinctrl.dtsi
Date:   Tue, 16 Jun 2020 17:33:29 +0200
Message-ID: <20200616153329.15148-1-patrick.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs where possible and remove multiple blanks lines.

Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
---

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 7eb858732d6d..7d351757f2f8 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -210,8 +210,8 @@
 				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
 				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
 				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_MDC */
-			         <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
-			         <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
 				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
 				 <STM32_PINMUX('H', 6, ANALOG)>, /* ETH_RGMII_RXD2 */
 				 <STM32_PINMUX('H', 7, ANALOG)>, /* ETH_RGMII_RXD3 */
@@ -453,7 +453,7 @@
 	i2c5_pins_b: i2c5-1 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 0, AF4)>, /* I2C5_SCL */
-			         <STM32_PINMUX('D', 1, AF4)>; /* I2C5_SDA */
+				 <STM32_PINMUX('D', 1, AF4)>; /* I2C5_SDA */
 			bias-disable;
 			drive-open-drain;
 			slew-rate = <0>;
@@ -463,7 +463,7 @@
 	i2c5_sleep_pins_b: i2c5-sleep-1 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 0, ANALOG)>, /* I2C5_SCL */
-			         <STM32_PINMUX('D', 1, ANALOG)>; /* I2C5_SDA */
+				 <STM32_PINMUX('D', 1, ANALOG)>; /* I2C5_SDA */
 		};
 	};
 
@@ -1072,7 +1072,6 @@
 		};
 	};
 
-
 	sai2a_pins_b: sai2a-1 {
 		pins1 {
 			pinmux = <STM32_PINMUX('I', 6, AF10)>,	/* SAI2_SD_A */
-- 
2.17.1

