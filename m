Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E291D2137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgIGMVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:34368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgIGMSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2361424;
        Mon,  7 Sep 2020 05:18:43 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20CB3F66E;
        Mon,  7 Sep 2020 05:18:42 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] arm64: dts: hisilicon: Fix SP805 clocks
Date:   Mon,  7 Sep 2020 13:18:29 +0100
Message-Id: <20200907121831.242281-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907121831.242281-1-andre.przywara@arm.com>
References: <20200907121831.242281-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SP805 DT binding requires two clocks to be specified, but
Hisilicon platform DTs currently only specify one clock.

In practice, Linux would pick a clock named "apb_pclk" for the bus
clock, and the Linux and U-Boot SP805 driver would use the first clock
to derive the actual watchdog counter frequency.

Since currently both are the very same clock, we can just double the
clock reference, and add the correct clock-names, to match the binding.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++----
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index d25aac5e0bf8..994140fbc916 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1089,16 +1089,18 @@
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xe8a06000 0x0 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_OSC32K>;
-			clock-names = "apb_pclk";
+			clocks = <&crg_ctrl HI3660_OSC32K>,
+				 <&crg_ctrl HI3660_OSC32K>;
+			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		watchdog1: watchdog@e8a07000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xe8a07000 0x0 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg_ctrl HI3660_OSC32K>;
-			clock-names = "apb_pclk";
+			clocks = <&crg_ctrl HI3660_OSC32K>,
+				 <&crg_ctrl HI3660_OSC32K>;
+			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		tsensor: tsensor@fff30000 {
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3d189d9f0d24..6578f8191d71 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -843,8 +843,9 @@
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xf8005000 0x0 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ao_ctrl HI6220_WDT0_PCLK>;
-			clock-names = "apb_pclk";
+			clocks = <&ao_ctrl HI6220_WDT0_PCLK>,
+				 <&ao_ctrl HI6220_WDT0_PCLK>;
+			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		tsensor: tsensor@0,f7030700 {
-- 
2.17.1

