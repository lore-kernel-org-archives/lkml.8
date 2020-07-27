Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB1C4345C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B14A2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WAB5C08X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgG0Im5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:42:57 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:44405 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgG0Imy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595839373; x=1627375373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pq7+Cad0Upf0gR5pSZeWVklhIYbcWc/Z2/yeAnUUmgY=;
  b=WAB5C08XOwBzfw4NZ2p1w927OqlKpt8jB+9D37KZk7Huw/zao5H6EU7J
   +QFcuxXAD3MZaRGlQGLMhQELXKlpx7imsC8lTiDqVktCh1czKj0yt/X9g
   P9d9EFCHv6E3F6YPC37R1pfgy1TRDvLiZdIFhbRObkY2mtAdn5w508mtm
   L3ua4bEnLLaUj5SMnbOUmNPfuBCoJHaC7pCbdo/q5Ljky9Bh3wIq2IpWt
   FqFtSxpnEhMWTHt/rdg03ggYdtk8AB0SAHZNPQf9xeE23CFQYIlbVYeQD
   MWTtPh+5y7skBJ4iBZKXWnNz2AjJuhXZbwKDZTdQbp7C5bVJFXA0d1BLj
   w==;
IronPort-SDR: D0maofAB+YXZYS/a0ioNkixBzeeRq2daEAI/c7uPbIIrWXqb6W3yNASXzNqAKFwrpXL8TdD0vD
 xSQaOBj4U7TD0RRo9LkQfEww1qZ5ZByaiTSPbpRXDCwYH8bmnUstVdnVrrWaLUUTqJSJTMgW2j
 hLV2tRcjx232LhJ0vj6wvDmM3o8PrGH9wrT13DKl+FiYgHdt/JIc/0ga9l5vRzpziqG8YIWPro
 SCdZg7HvdTadoS+IhPFDWYnVUwbwjpcorOzVKYvLuDe1ut4r7XyHdHu9nndriIAmR6dOE93Osz
 YhU=
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="81360579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2020 01:42:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 01:42:09 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 27 Jul 2020 01:42:48 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        "Michael Turquette" <mturquette@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 09/10] arm64: dts: sparx5: Add Sparx5 SoC DPLL clock
Date:   Mon, 27 Jul 2020 10:42:10 +0200
Message-ID: <20200727084211.6632-10-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727084211.6632-1-lars.povlsen@microchip.com>
References: <20200727084211.6632-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DPLL clock to the Sparx5 SoC. It is used to generate clock
to misc peripherals, specifically the SDHCI/eMMC controller.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 39 +++++++++++++----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index baf4176ce1dfe..161846caf9c94 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -72,20 +72,29 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	clocks: clocks {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges;
-		ahb_clk: ahb-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <250000000>;
-		};
-		sys_clk: sys-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <625000000>;
-		};
+	lcpll_clk: lcpll-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2500000000>;
+	};
+
+	clks: clock-controller@61110000c {
+		compatible = "microchip,sparx5-dpll";
+		#clock-cells = <1>;
+		clocks = <&lcpll_clk>;
+		reg = <0x6 0x1110000c 0x24>;
+	};
+
+	ahb_clk: ahb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+	};
+
+	sys_clk: sys-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <625000000>;
 	};
 
 	axi: axi@600000000 {
@@ -161,8 +170,6 @@ uart2_pins: uart2-pins {
 				pins = "GPIO_26", "GPIO_27";
 				function = "uart2";
 			};
-
 		};
-
 	};
 };
-- 
2.27.0

