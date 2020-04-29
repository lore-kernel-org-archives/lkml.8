Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38CDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDB0214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="iXIpe3Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgD2UrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:47:05 -0400
Received: from plaes.org ([188.166.43.21]:35034 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgD2UrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:47:02 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id 27C2F406D2;
        Wed, 29 Apr 2020 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588193189; bh=hD8MO8nZG7cWOQMyvrg2gESOCiX1BXG9t5neHczu/iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXIpe3Y+PbIFsrKy3pI5oWGv70swaGWQqS0jNKqF7Fa+apASm3B0MrhusmrrJct93
         apTgFtSE9y10wyorWdpzYyKvpYnoAoLHS9WsVhI85vFWnpdNgOY6X3m1BMjVnXWNvi
         o9575D9Z3tGZHvKXj4E9BCpabTbKzYDx3kxJieWWTIz+bw1eYx7+SFBxvcnxfwyRke
         OXvYI21clbu6d52frM234CHwkvxIq8JelPajlOQmVK8uCWFAbvK1X2ftMF/7VhUjmn
         qPy3JuXulTak3ZaFlnenKIVtgdGLHxoTW8F2s/59pxl+bzI1SOLS1ErlzZsOONWpzY
         ywl/yvEglystw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 6/6] ARM: dts: sun6i: Use syscon-based implementation for gmac
Date:   Wed, 29 Apr 2020 23:46:12 +0300
Message-Id: <20200429204612.31883-7-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429204612.31883-1-plaes@plaes.org>
References: <20200429204612.31883-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use syscon-based approach to access gmac clock configuration
register instead of relying on a custom clock driver.

As a bonus, we can now drop the custom clock implementation
and the dummy clocks.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 35 +++-----------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f3425a66fc0a..fcf8a242741f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -228,36 +228,6 @@ osc32k: clk-32k {
 			clock-output-names = "ext_osc32k";
 		};
 
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
-		gmac_tx_clk: clk@1c200d0 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun7i-a20-gmac-clk";
-			reg = <0x01c200d0 0x4>;
-			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
-			clock-output-names = "gmac_tx";
-		};
 	};
 
 	de: display-engine {
@@ -943,11 +913,12 @@ i2c3: i2c@1c2b800 {
 
 		gmac: ethernet@1c30000 {
 			compatible = "allwinner,sun7i-a20-gmac";
+			syscon = <&ccu>;
 			reg = <0x01c30000 0x1054>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&ccu CLK_AHB1_EMAC>, <&gmac_tx_clk>;
-			clock-names = "stmmaceth", "allwinner_gmac_tx";
+			clocks = <&ccu CLK_AHB1_EMAC>;
+			clock-names = "stmmaceth";
 			resets = <&ccu RST_AHB1_EMAC>;
 			reset-names = "stmmaceth";
 			snps,pbl = <2>;
-- 
2.26.2

