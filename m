Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E631C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB120C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIJRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgIJR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC6C061795;
        Thu, 10 Sep 2020 10:28:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CD68729BB09
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 12/12] arm64: dts: mediatek: Add mt8183 power domains controller
Date:   Thu, 10 Sep 2020 19:28:26 +0200
Message-Id: <20200910172826.3074357-13-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Add power domains controller node for SoC mt8183

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 160 +++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 102105871db2..7012cdb22bf0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/mt8183-power.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include "mt8183-pinfunc.h"
@@ -316,6 +317,160 @@ pio: pinctrl@10005000 {
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8183-power-controller", "syscon";
+			reg = <0 0x10006000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			audio@MT8183_POWER_DOMAIN_AUDIO {
+				reg = <MT8183_POWER_DOMAIN_AUDIO>;
+				clocks = <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
+					 <&infracfg CLK_INFRA_AUDIO>,
+					 <&infracfg CLK_INFRA_AUDIO_26M_BCLK>;
+				clock-names = "audio", "audio1", "audio2";
+				#power-domain-cells = <0>;
+			};
+
+			conn@MT8183_POWER_DOMAIN_CONN {
+				reg = <MT8183_POWER_DOMAIN_CONN>;
+				mediatek,infracfg = <&infracfg>;
+				#power-domain-cells = <0>;
+			};
+
+			mfg_async@MT8183_POWER_DOMAIN_MFG_ASYNC {
+				reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks =  <&topckgen CLK_TOP_MUX_MFG>;
+				clock-names = "mfg";
+				#power-domain-cells = <1>;
+
+				mfg@MT8183_POWER_DOMAIN_MFG {
+					reg = <MT8183_POWER_DOMAIN_MFG>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					mfg_core0@MT8183_POWER_DOMAIN_MFG_CORE0 {
+						reg = <MT8183_POWER_DOMAIN_MFG_CORE0>;
+						#power-domain-cells = <0>;
+					};
+
+					mfg_core1@MT8183_POWER_DOMAIN_MFG_CORE1 {
+						reg = <MT8183_POWER_DOMAIN_MFG_CORE1>;
+						#power-domain-cells = <0>;
+					};
+
+					mfg_2d@MT8183_POWER_DOMAIN_MFG_2D {
+						reg = <MT8183_POWER_DOMAIN_MFG_2D>;
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+
+			disp@MT8183_POWER_DOMAIN_DISP {
+				reg = <MT8183_POWER_DOMAIN_DISP>;
+				clocks = <&topckgen CLK_TOP_MUX_MM>,
+					 <&mmsys CLK_MM_SMI_COMMON>,
+					 <&mmsys CLK_MM_SMI_LARB0>,
+					 <&mmsys CLK_MM_SMI_LARB1>,
+					 <&mmsys CLK_MM_GALS_COMM0>,
+					 <&mmsys CLK_MM_GALS_COMM1>,
+					 <&mmsys CLK_MM_GALS_CCU2MM>,
+					 <&mmsys CLK_MM_GALS_IPU12MM>,
+					 <&mmsys CLK_MM_GALS_IMG2MM>,
+					 <&mmsys CLK_MM_GALS_CAM2MM>,
+					 <&mmsys CLK_MM_GALS_IPU2MM>;
+				clock-names = "mm", "mm-0", "mm-1", "mm-2", "mm-3",
+					      "mm-4", "mm-5", "mm-6", "mm-7",
+					      "mm-8", "mm-9";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				mediatek,infracfg = <&infracfg>;
+				mediatek,smi = <&smi_common>;
+				#power-domain-cells = <1>;
+
+				cam@MT8183_POWER_DOMAIN_CAM {
+					reg = <MT8183_POWER_DOMAIN_CAM>;
+					clocks = <&topckgen CLK_TOP_MUX_CAM>,
+						 <&camsys CLK_CAM_LARB6>,
+						 <&camsys CLK_CAM_LARB3>,
+						 <&camsys CLK_CAM_SENINF>,
+						 <&camsys CLK_CAM_CAMSV0>,
+						 <&camsys CLK_CAM_CAMSV1>,
+						 <&camsys CLK_CAM_CAMSV2>,
+						 <&camsys CLK_CAM_CCU>;
+					clock-names = "cam", "cam-0", "cam-1",
+						      "cam-2", "cam-3", "cam-4",
+						      "cam-5", "cam-6";
+					mediatek,infracfg = <&infracfg>;
+					mediatek,smi = <&smi_common>;
+					#power-domain-cells = <0>;
+				};
+
+				isp@MT8183_POWER_DOMAIN_ISP {
+					reg = <MT8183_POWER_DOMAIN_ISP>;
+					clocks = <&topckgen CLK_TOP_MUX_IMG>,
+						 <&imgsys CLK_IMG_LARB5>,
+						 <&imgsys CLK_IMG_LARB2>;
+					clock-names = "isp", "isp-0", "isp-1";
+					mediatek,infracfg = <&infracfg>;
+					mediatek,smi = <&smi_common>;
+					#power-domain-cells = <0>;
+				};
+
+				vdec@MT8183_POWER_DOMAIN_VDEC {
+					reg = <MT8183_POWER_DOMAIN_VDEC>;
+					mediatek,smi = <&smi_common>;
+					#power-domain-cells = <0>;
+				};
+
+				venc@MT8183_POWER_DOMAIN_VENC {
+					reg = <MT8183_POWER_DOMAIN_VENC>;
+					mediatek,smi = <&smi_common>;
+					#power-domain-cells = <0>;
+				};
+
+				vpu_top@MT8183_POWER_DOMAIN_VPU_TOP {
+					reg = <MT8183_POWER_DOMAIN_VPU_TOP>;
+					clocks = <&topckgen CLK_TOP_MUX_IPU_IF>,
+						 <&topckgen CLK_TOP_MUX_DSP>,
+						 <&ipu_conn CLK_IPU_CONN_IPU>,
+						 <&ipu_conn CLK_IPU_CONN_AHB>,
+						 <&ipu_conn CLK_IPU_CONN_AXI>,
+						 <&ipu_conn CLK_IPU_CONN_ISP>,
+						 <&ipu_conn CLK_IPU_CONN_CAM_ADL>,
+						 <&ipu_conn CLK_IPU_CONN_IMG_ADL>;
+					clock-names = "vpu", "vpu1", "vpu-0", "vpu-1",
+						      "vpu-2", "vpu-3", "vpu-4", "vpu-5";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+					mediatek,smi = <&smi_common>;
+					#power-domain-cells = <1>;
+
+					vpu_core0@MT8183_POWER_DOMAIN_VPU_CORE0 {
+						reg = <MT8183_POWER_DOMAIN_VPU_CORE0>;
+						clocks = <&topckgen CLK_TOP_MUX_DSP1>;
+						clock-names = "vpu2";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					vpu_core1@MT8183_POWER_DOMAIN_VPU_CORE1 {
+						reg = <MT8183_POWER_DOMAIN_VPU_CORE1>;
+						clocks = <&topckgen CLK_TOP_MUX_DSP2>;
+						clock-names = "vpu3";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8183-wdt",
 				     "mediatek,mt6589-wdt";
@@ -754,6 +909,11 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14019000 {
+			compatible = "mediatek,mt8183-smi-common", "syscon";
+			reg = <0 0x14019000 0 0x1000>;
+		};
+
 		imgsys: syscon@15020000 {
 			compatible = "mediatek,mt8183-imgsys", "syscon";
 			reg = <0 0x15020000 0 0x1000>;
-- 
2.28.0

