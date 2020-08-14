Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C6EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF20A20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHNWgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:36:10 -0400
Received: from mail.manjaro.org ([176.9.38.148]:39094 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgHNWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:36:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 86B65E1124;
        Sat, 15 Aug 2020 00:36:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tO3t8igeQngG; Sat, 15 Aug 2020 00:36:04 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] ARM: dts: stm32: add resets property to spi device nodes on stm32h743
Date:   Sat, 15 Aug 2020 00:35:43 +0200
Message-Id: <20200814223543.3420540-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32 spi driver tries to determine the fifo size of spi devices
dynamically. However, if the spi was already configured by the bootloader
the fifo size check can become an endless loop, because the driver
expects the spi to be in its initial "after device reset" state. The
driver does already support resetting the spi device at probe, thus this
patch adds only the required device tree properties

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/stm32h743.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 9dd58974bf8d..7c612db9efcf 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -110,6 +110,7 @@ spi2: spi@40003800 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x40003800 0x400>;
 			interrupts = <36>;
+			resets = <&rcc STM32H7_APB1L_RESET(SPI2)>;
 			clocks = <&rcc SPI2_CK>;
 			status = "disabled";
 
@@ -121,6 +122,7 @@ spi3: spi@40003c00 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x40003c00 0x400>;
 			interrupts = <51>;
+			resets = <&rcc STM32H7_APB1L_RESET(SPI3)>;
 			clocks = <&rcc SPI3_CK>;
 			status = "disabled";
 		};
@@ -207,6 +209,7 @@ spi1: spi@40013000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x40013000 0x400>;
 			interrupts = <35>;
+			resets = <&rcc STM32H7_APB2_RESET(SPI1)>;
 			clocks = <&rcc SPI1_CK>;
 			status = "disabled";
 		};
@@ -217,6 +220,7 @@ spi4: spi@40013400 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x40013400 0x400>;
 			interrupts = <84>;
+			resets = <&rcc STM32H7_APB2_RESET(SPI4)>;
 			clocks = <&rcc SPI4_CK>;
 			status = "disabled";
 		};
@@ -227,6 +231,7 @@ spi5: spi@40015000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x40015000 0x400>;
 			interrupts = <85>;
+			resets = <&rcc STM32H7_APB2_RESET(SPI5)>;
 			clocks = <&rcc SPI5_CK>;
 			status = "disabled";
 		};
@@ -372,6 +377,7 @@ spi6: spi@58001400 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x58001400 0x400>;
 			interrupts = <86>;
+			resets = <&rcc STM32H7_APB4_RESET(SPI6)>;
 			clocks = <&rcc SPI6_CK>;
 			status = "disabled";
 		};
-- 
2.28.0

