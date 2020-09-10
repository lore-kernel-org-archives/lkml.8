Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771FBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EFD20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgIJRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:30:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54616 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgIJR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 67B6B29BB10
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 03/12] arm64: dts: mediatek: Add mt8173 power domain controller
Date:   Thu, 10 Sep 2020 19:28:17 +0200
Message-Id: <20200910172826.3074357-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domain controller node for SoC mt8173.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 78 +++++++++++++++++++++---
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 5e046f9d48ce..3b08c5404d81 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -450,16 +450,76 @@ pins1 {
 			};
 		};
 
-		scpsys: power-controller@10006000 {
-			compatible = "mediatek,mt8173-scpsys";
-			#power-domain-cells = <1>;
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8173-power-controller";
 			reg = <0 0x10006000 0 0x1000>;
-			clocks = <&clk26m>,
-				 <&topckgen CLK_TOP_MM_SEL>,
-				 <&topckgen CLK_TOP_VENC_SEL>,
-				 <&topckgen CLK_TOP_VENC_LT_SEL>;
-			clock-names = "mfg", "mm", "venc", "venc_lt";
-			infracfg = <&infracfg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* power domains of the SoC */
+			vdec@MT8173_POWER_DOMAIN_VDEC {
+				reg = <MT8173_POWER_DOMAIN_VDEC>;
+				clocks = <&topckgen CLK_TOP_MM_SEL>;
+				clock-names = "mm";
+				#power-domain-cells = <0>;
+			};
+
+			venc@MT8173_POWER_DOMAIN_VENC {
+				reg = <MT8173_POWER_DOMAIN_VENC>;
+				clocks = <&topckgen CLK_TOP_MM_SEL>,
+					 <&topckgen CLK_TOP_VENC_SEL>;
+				clock-names = "mm", "venc";
+				#power-domain-cells = <0>;
+			};
+			isp@MT8173_POWER_DOMAIN_ISP {
+				reg = <MT8173_POWER_DOMAIN_ISP>;
+				clocks = <&topckgen CLK_TOP_MM_SEL>;
+				clock-names = "mm";
+				#power-domain-cells = <0>;
+			};
+			mm@MT8173_POWER_DOMAIN_MM {
+				reg = <MT8173_POWER_DOMAIN_MM>;
+				clocks = <&topckgen CLK_TOP_MM_SEL>;
+				clock-names = "mm";
+				#power-domain-cells = <0>;
+				mediatek,infracfg = <&infracfg>;
+			};
+			venc_lt@MT8173_POWER_DOMAIN_VENC_LT {
+				reg = <MT8173_POWER_DOMAIN_VENC_LT>;
+				clocks = <&topckgen CLK_TOP_MM_SEL>,
+					 <&topckgen CLK_TOP_VENC_LT_SEL>;
+				clock-names = "mm", "venclt";
+				#power-domain-cells = <0>;
+			};
+			audio@MT8173_POWER_DOMAIN_AUDIO {
+				reg = <MT8173_POWER_DOMAIN_AUDIO>;
+				#power-domain-cells = <0>;
+			};
+			usb@MT8173_POWER_DOMAIN_USB {
+				reg = <MT8173_POWER_DOMAIN_USB>;
+				#power-domain-cells = <0>;
+			};
+			mfg_async@MT8173_POWER_DOMAIN_MFG_ASYNC {
+				reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
+				clocks = <&clk26m>;
+				clock-names = "mfg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				mfg_2d@MT8173_POWER_DOMAIN_MFG_2D {
+					reg = <MT8173_POWER_DOMAIN_MFG_2D>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					mfg@MT8173_POWER_DOMAIN_MFG {
+						reg = <MT8173_POWER_DOMAIN_MFG>;
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+				};
+			};
 		};
 
 		watchdog: watchdog@10007000 {
-- 
2.28.0

