Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865A4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHZSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:38:51 -0400
Received: from foss.arm.com ([217.140.110.172]:50116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgHZSiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:38:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF57106F;
        Wed, 26 Aug 2020 11:38:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AE873F8C6;
        Wed, 26 Aug 2020 11:38:15 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/6] ARM: dts: arm: Fix SP804 users
Date:   Wed, 26 Aug 2020 19:38:00 +0100
Message-Id: <20200826183805.19369-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826183805.19369-1-andre.przywara@arm.com>
References: <20200826183805.19369-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SP804 DT nodes for Realview, MPS2 and VExpress were not complying
with the binding: it requires either one or three clocks, but does not
allow exactly two clocks.

Simply duplicate the first clock to satisfy the binding requirement.
For MPS2, we triple the clock, and add the clock-names property, as this
is required by the Linux primecell driver.
Try to make the clock-names more consistent on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 16 ++++++++--------
 arch/arm/boot/dts/mps2.dtsi               |  6 ++++--
 arch/arm/boot/dts/vexpress-v2p-ca9.dts    |  4 ++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 9748e0fe800f..564e2eee2c24 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -568,8 +568,8 @@
 			clocks = <&sp810_syscon 0>,
 			         <&sp810_syscon 1>,
 				 <&pclk>;
-			clock-names = "timerclk0",
-				    "timerclk1",
+			clock-names = "timer0clk",
+				    "timer1clk",
 				    "apb_pclk";
 		};
 
@@ -582,8 +582,8 @@
 			clocks = <&sp810_syscon 2>,
 			         <&sp810_syscon 3>,
 				 <&pclk>;
-			clock-names = "timerclk2",
-				    "timerclk3",
+			clock-names = "timer0clk",
+				    "timer1clk",
 				    "apb_pclk";
 		};
 
@@ -645,16 +645,16 @@
 		timer45: timer@10018000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x10018000 0x1000>;
-			clocks = <&timclk>, <&pclk>;
-			clock-names = "timer", "apb_pclk";
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
 			status = "disabled";
 		};
 
 		timer67: timer@10019000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x10019000 0x1000>;
-			clocks = <&timclk>, <&pclk>;
-			clock-names = "timer", "apb_pclk";
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/mps2.dtsi b/arch/arm/boot/dts/mps2.dtsi
index 96fb5a5cf4d3..48c34fa282af 100644
--- a/arch/arm/boot/dts/mps2.dtsi
+++ b/arch/arm/boot/dts/mps2.dtsi
@@ -161,9 +161,11 @@
 			};
 
 			timer2: dual-timer@2000 {
-				compatible = "arm,sp804";
+				compatible = "arm,sp804", "arm,primecell";
 				reg = <0x2000 0x1000>;
-				clocks = <&sysclk>;
+				clocks = <&sysclk>, <&sysclk>, <&sysclk>;
+				clock-names = "timer0clk", "timer1clk",
+					       "apb_pclk";
 				interrupts = <10>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 623246f37448..6cddea25a292 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -122,8 +122,8 @@
 		reg = <0x100e4000 0x1000>;
 		interrupts = <0 48 4>,
 			     <0 49 4>;
-		clocks = <&oscclk2>, <&oscclk2>;
-		clock-names = "timclk", "apb_pclk";
+		clocks = <&oscclk2>, <&oscclk2>, <&oscclk2>;
+		clock-names = "timer0clk", "timer1clk", "apb_pclk";
 		status = "disabled";
 	};
 
-- 
2.17.1

