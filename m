Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C1C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09116206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="lZETRBcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgDQW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:29:16 -0400
Received: from plaes.org ([188.166.43.21]:57506 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgDQW3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:29:16 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:9d4d:940e:6b9e:3deb:4])
        by plaes.org (Postfix) with ESMTPSA id C54B6412C2;
        Fri, 17 Apr 2020 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587161878; bh=CuWTSWogL5JToClyKPKUHBYOUHXu6/mkEKPAV4YLbVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZETRBcXeQXm8yzTNezI5LpsawhmT8InxOuYc/djy0Tr2ewY2eL3Q+CgV/M37HiTY
         Ok5hFWQ1wLhPv9cQyKOStSWzVJECt3nCDoVnfLaJymnL7tNDHDfYUgofkRBISORYZX
         YTGqG+6yh+QsHUxyvv2R9w5PGq758CdpEN2AxZ4WGZHJMSI4OZB8M4CEsCq7GoCUQZ
         AO1JX/rsW7h7DA5GdvIV9JNnZHAVv3TMtr3uHtDi+M2WTvv99yvTs/NpqwaN3gMoHQ
         wBSjctLImhQRE6JQ6TsAsjOKKEDxr9+Bm+T6QjHN8iIl30QWBRj6bovCWEtQLLTbqI
         4gY/XgaRPPfmA==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 4/4] ARM: dts: sun7i: Use syscon-based implementation for gmac
Date:   Sat, 18 Apr 2020 01:17:30 +0300
Message-Id: <20200417221730.555954-5-plaes@plaes.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417221730.555954-1-plaes@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use syscon-based approach to access gmac clock configuration
register, instead of relying on a custom clock driver.

As a bonus, we can now drop the custom clock implementation
and dummy clocks making sun7i fully CCU-compatible.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 36 +++-----------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index ffe1d10a1a84..750962a94fad 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -219,37 +219,6 @@ osc32k: clk-32k {
 			clock-frequency = <32768>;
 			clock-output-names = "osc32k";
 		};
-
-		/*
-		 * The following two are dummy clocks, placeholders
-		 * used in the gmac_tx clock. The gmac driver will
-		 * choose one parent depending on the PHY interface
-		 * mode, using clk_set_rate auto-reparenting.
-		 *
-		 * The actual TX clock rate is not controlled by the
-		 * gmac_tx clock.
-		 */
-		mii_phy_tx_clk: clk-mii-phy-tx {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <25000000>;
-			clock-output-names = "mii_phy_tx";
-		};
-
-		gmac_int_tx_clk: clk-gmac-int-tx {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <125000000>;
-			clock-output-names = "gmac_int_tx";
-		};
-
-		gmac_tx_clk: clk@1c20164 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun7i-a20-gmac-clk";
-			reg = <0x01c20164 0x4>;
-			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
-			clock-output-names = "gmac_tx";
-		};
 	};
 
 
@@ -1511,11 +1480,12 @@ mali: gpu@1c40000 {
 
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
+			syscon = <&ccu>;
 			reg = <0x01c50000 0x10000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&ccu CLK_AHB_GMAC>, <&gmac_tx_clk>;
-			clock-names = "stmmaceth", "allwinner_gmac_tx";
+			clocks = <&ccu CLK_AHB_GMAC>;
+			clock-names = "stmmaceth";
 			snps,pbl = <2>;
 			snps,fixed-burst;
 			snps,force_sf_dma_mode;
-- 
2.25.2

