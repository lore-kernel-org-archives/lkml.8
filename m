Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CCEC3F2DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ILsNtQdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCFEOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:14:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38873 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:14:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id g21so448043pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2KaJ1yUggeguCo+et3Wjki7yX2Lm8UWii6gWzTJsgk=;
        b=ILsNtQdtWcAJHuazrj06SPHLr4LhBTFidAP+VUUw9H+1NFhPmCvzffVClSscsCR70i
         WYxCxfH5zPGPl7/xi/DQ5vwP1qBRPeGUaXB+jPuSrR5WBNDE9+r9l80cAeC9vKZf4Snl
         F8HbgcCZ/SzGUdSljbpwAxXzbO39LwC1bNDWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2KaJ1yUggeguCo+et3Wjki7yX2Lm8UWii6gWzTJsgk=;
        b=t7/lR4Rt1wuwNYWfiY6PZs1fw/YvHBzx8y5sz9zljsElxyPDbnPiNHXHPzi2XcRkB8
         vL79Dn/I3CD3Jr5FYl4OdbGOXkwLWPUjS/Qs/CPW2vsMipiZfuUIBPa53wM2LQ7tdzIH
         nbhccFhwiwB77uawghPHK6rh9HFfiuXZG34i7MF6dhJmifJpqrkUBWQA4eDbHFMdCIYU
         Fb44N6VDFnJBEUahZkgHS4q6hHUslGGP52yQVKyji0DN8imF8iiJLUNTWCP/GHgwkJA6
         b7/KA6mp95yNimYxq/X9q1q7TXa8lmelZBgVT6eHDph7Z59mc6of4fxDw5lKjWYlX39u
         5a9A==
X-Gm-Message-State: ANhLgQ0T0ZGQH5mk9EWp7k2rZVjtjyGjEYDHTGlyrxiyHIkVKJVu3gPY
        OCwIha2i/EYv74FXwbuj9LR31A==
X-Google-Smtp-Source: ADFU+vsxuflO0a9AmIY2Lhei3VB+nOOiqCjrwhRCFJZrlWJRsR6eerIH8NNep1ffq0qlPBkzNCnmDg==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr1377119pge.341.1583468041988;
        Thu, 05 Mar 2020 20:14:01 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id q97sm6295025pja.9.2020.03.05.20.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 20:14:01 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nick Fan <nick.fan@mediatek.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v5 2/4] arm64: dts: mt8183: Add node for the Mali GPU
Date:   Fri,  6 Mar 2020 12:13:43 +0800
Message-Id: <20200306041345.259332-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306041345.259332-1-drinkcat@chromium.org>
References: <20200306041345.259332-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic GPU node for mt8183.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---
Upstreaming what matches existing bindings from our Chromium OS tree:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/arch/arm64/boot/dts/mediatek/mt8183.dtsi#1411

The evb part of this change depends on this patch to add PMIC dtsi:
https://patchwork.kernel.org/patch/10928161/

The binding we use with out-of-tree Mali drivers includes more
clocks, this is used for devfreq: the out-of-tree driver switches
clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
switches clk_mux back to clk_main_parent:
(see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
clocks =
        <&topckgen CLK_TOP_MFGPLL_CK>,
        <&topckgen CLK_TOP_MUX_MFG>,
        <&clk26m>,
        <&mfgcfg CLK_MFG_BG3D>;
clock-names =
        "clk_main_parent",
        "clk_mux",
        "clk_sub_parent",
        "subsys_mfg_cg";
(based on discussions, this probably belongs in the clock core)

v5:
 - Rename "2d" power domain to "core2" (keep R-B again).

v4:
 - Add power-domain-names to describe the 3 domains.
   (kept Alyssa's reviewed-by as the change is minor)

v3:
 - No changes

v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |   7 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 105 ++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 1fb195c683c3d01..7d609e0cd9b4975 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "mt8183.dtsi"
+#include "mt6358.dtsi"
 
 / {
 	model = "MediaTek MT8183 evaluation board";
@@ -30,6 +31,12 @@ &auxadc {
 	status = "okay";
 };
 
+&gpu {
+	supply-names = "mali", "sram";
+	mali-supply = <&mt6358_vgpu_reg>;
+	sram-supply = <&mt6358_vsram_gpu_reg>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c_pins_0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 97863adb7bc02b4..fc690c54988c8cc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -652,6 +652,111 @@ mfgcfg: syscon@13000000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@13040000 {
+			compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
+			reg = <0 0x13040000 0 0x4000>;
+			interrupts =
+				<GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 279 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
+
+			power-domains =
+				<&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>,
+				<&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>,
+				<&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
+			power-domain-names = "core0", "core1", "core2";
+
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+
+		gpu_opp_table: opp_table0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <625000>, <850000>;
+			};
+
+			opp-320000000 {
+				opp-hz = /bits/ 64 <320000000>;
+				opp-microvolt = <631250>, <850000>;
+			};
+
+			opp-340000000 {
+				opp-hz = /bits/ 64 <340000000>;
+				opp-microvolt = <637500>, <850000>;
+			};
+
+			opp-360000000 {
+				opp-hz = /bits/ 64 <360000000>;
+				opp-microvolt = <643750>, <850000>;
+			};
+
+			opp-380000000 {
+				opp-hz = /bits/ 64 <380000000>;
+				opp-microvolt = <650000>, <850000>;
+			};
+
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <656250>, <850000>;
+			};
+
+			opp-420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <662500>, <850000>;
+			};
+
+			opp-460000000 {
+				opp-hz = /bits/ 64 <460000000>;
+				opp-microvolt = <675000>, <850000>;
+			};
+
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <687500>, <850000>;
+			};
+
+			opp-540000000 {
+				opp-hz = /bits/ 64 <540000000>;
+				opp-microvolt = <700000>, <850000>;
+			};
+
+			opp-580000000 {
+				opp-hz = /bits/ 64 <580000000>;
+				opp-microvolt = <712500>, <850000>;
+			};
+
+			opp-620000000 {
+				opp-hz = /bits/ 64 <620000000>;
+				opp-microvolt = <725000>, <850000>;
+			};
+
+			opp-653000000 {
+				opp-hz = /bits/ 64 <653000000>;
+				opp-microvolt = <743750>, <850000>;
+			};
+
+			opp-698000000 {
+				opp-hz = /bits/ 64 <698000000>;
+				opp-microvolt = <768750>, <868750>;
+			};
+
+			opp-743000000 {
+				opp-hz = /bits/ 64 <743000000>;
+				opp-microvolt = <793750>, <893750>;
+			};
+
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <825000>, <925000>;
+			};
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8183-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.25.1.481.gfbce0eb801-goog

