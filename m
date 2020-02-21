Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07425C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC39206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582324037;
	bh=kLUKGBTqzIFY2Ua56X+c3ZIhtYD+JddpSUZE5BrT4UM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IsSLpBXn2t73KrfawztWXkSfZuKeH/OCEqpxaUvdFsQmER+NeoKQF9cJ8dwIcsItG
	 R1FUQLiXVWnpWTHUNQ3fIYptnVOxlVTo8jLP+u1EBCGXlToVcR8j3z+XFRz8JrJZht
	 8ORAV+elzWcATKzAXicRL2qkkPP0ON6AODAaPjzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBUW1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:27:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34154 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:27:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so3195928oig.1;
        Fri, 21 Feb 2020 14:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTirmbPmqIwCM11sEYEnsQBZT3YNX8pu9sKvCZihSoI=;
        b=aqiXh/7ziTfPtCnkgGchDEVqju8rqEKOF6XiCTlgvvASGGPHGrH7+pnNr6fUtNbAqH
         9k3ZZUk9eLISWGt3XzG8VBVYkn3xhQQVgS1Xur8bk40DAcHhk901je+bB1ZpqGdxyQ+D
         tA9tnWfNrhC5XDR2DFSdRtICKxNCaY3AOZvl8ESCikzDRRm0z0qyFVb3Fs1u9SzQbVte
         rcyJsfccsOK2GQ0KzyfL6pypCG+BktBBpj4pQx8KIazTdBXmGaHpfPqH4ZGopugXhRyY
         3P8vgBV9Cab3tTZVxw/K57T2zBH0NYGFOck+gQB68I85UARE5F9+34IVg8HKUuIyBmWW
         05Ag==
X-Gm-Message-State: APjAAAVT2Wdc+AeYr+pHmvM667vxJjljTTO8WAYUOnWDXcgKmohVX3/w
        AFwimqiuXm5Adlkg12sEhs5ucjE=
X-Google-Smtp-Source: APXvYqyWRVBpG0hk244IXemUWJlTmd+SUgtr5hLf8xut8NHaBwuwk4Kpz0I3Ywpl9V7XkC/1aLP39w==
X-Received: by 2002:a05:6808:7c7:: with SMTP id f7mr3956131oij.58.1582324032885;
        Fri, 21 Feb 2020 14:27:12 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t21sm1494758otr.42.2020.02.21.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 14:27:12 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] dt-bindings: Fix dtc warnings in examples
Date:   Fri, 21 Feb 2020 16:27:10 -0600
Message-Id: <20200221222711.15973-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all the warnings in the DT binding schema examples when built with
'W=1'. This is in preparation to make that the default for examples.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |  2 +-
 .../clock/allwinner,sun4i-a10-osc-clk.yaml         |  2 +-
 .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |  2 +-
 .../display/allwinner,sun4i-a10-tv-encoder.yaml    |  6 +-----
 .../bindings/display/bridge/anx6345.yaml           | 10 ++--------
 .../display/panel/leadtek,ltk500hd1829.yaml        |  2 ++
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |  2 ++
 .../bindings/display/simple-framebuffer.yaml       |  6 +-----
 .../devicetree/bindings/dma/ti/k3-udma.yaml        | 14 +-------------
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  | 14 +++++++-------
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 14 +++++++-------
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  2 +-
 .../bindings/input/touchscreen/goodix.yaml         |  2 +-
 .../devicetree/bindings/media/ti,cal.yaml          |  2 +-
 .../devicetree/bindings/mfd/max77650.yaml          |  4 ++--
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  1 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 ++
 .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |  2 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |  2 +-
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  2 +-
 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  2 +-
 22 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
index 68917bb7c7e8..55f7938c4826 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
@@ -52,7 +52,7 @@ required:
 
 examples:
   - |
-    mlahb: ahb {
+    mlahb: ahb@38000000 {
       compatible = "st,mlahb", "simple-bus";
       #address-cells = <1>;
       #size-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml
index 69cfa4a3d562..c604822cda07 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml
@@ -40,7 +40,7 @@ additionalProperties: false
 
 examples:
   - |
-    osc24M: clk@01c20050 {
+    osc24M: clk@1c20050 {
         #clock-cells = <0>;
         compatible = "allwinner,sun4i-a10-osc-clk";
         reg = <0x01c20050 0x4>;
diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml
index 07f38def7dc3..43963c3062c8 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml
@@ -41,7 +41,7 @@ additionalProperties: false
 
 examples:
   - |
-    clk@0600005c {
+    clk@600005c {
         #clock-cells = <0>;
         compatible = "allwinner,sun9i-a80-gt-clk";
         reg = <0x0600005c 0x4>;
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tv-encoder.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tv-encoder.yaml
index 5d5d39665119..6009324be967 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tv-encoder.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tv-encoder.yaml
@@ -49,11 +49,7 @@ examples:
         resets = <&tcon_ch0_clk 0>;
 
         port {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            tve0_in_tcon0: endpoint@0 {
-                reg = <0>;
+            tve0_in_tcon0: endpoint {
                 remote-endpoint = <&tcon0_out_tve0>;
             };
         };
diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.yaml b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
index 6d72b3d11fbc..c21103869923 100644
--- a/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
@@ -79,21 +79,15 @@ examples:
           #size-cells = <0>;
 
           anx6345_in: port@0 {
-            #address-cells = <1>;
-            #size-cells = <0>;
             reg = <0>;
-            anx6345_in_tcon0: endpoint@0 {
-              reg = <0>;
+            anx6345_in_tcon0: endpoint {
               remote-endpoint = <&tcon0_out_anx6345>;
             };
           };
 
           anx6345_out: port@1 {
-            #address-cells = <1>;
-            #size-cells = <0>;
             reg = <1>;
-            anx6345_out_panel: endpoint@0 {
-              reg = <0>;
+            anx6345_out_panel: endpoint {
               remote-endpoint = <&panel_in_edp>;
             };
           };
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
index 4ebcea7d0c63..a614644c9849 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
@@ -37,6 +37,8 @@ examples:
     dsi@ff450000 {
         #address-cells = <1>;
         #size-cells = <0>;
+        reg = <0xff450000 0x1000>;
+
         panel@0 {
             compatible = "leadtek,ltk500hd1829";
             reg = <0>;
diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
index 186e5e1c8fa3..22c91beb0541 100644
--- a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
+++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
@@ -37,6 +37,8 @@ examples:
     dsi@ff450000 {
         #address-cells = <1>;
         #size-cells = <0>;
+        reg = <0xff450000 0x1000>;
+
         panel@0 {
             compatible = "xinpeng,xpp055c272";
             reg = <0>;
diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 678776b6012a..1db608c9eef5 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -174,10 +174,6 @@ examples:
       };
     };
 
-    soc@1c00000 {
-      lcdc0: lcdc@1c0c000 {
-        compatible = "allwinner,sun4i-a10-lcdc";
-      };
-    };
+    lcdc0: lcdc { };
 
 ...
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 8b5c346f23f6..34780d7535b8 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -143,7 +143,7 @@ examples:
             #size-cells = <2>;
             dma-coherent;
             dma-ranges;
-            ranges;
+            ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0x05000000>;
 
             ti,sci-dev-id = <118>;
 
@@ -169,16 +169,4 @@ examples:
                 ti,sci-rm-range-rflow = <0x6>; /* GP RFLOW */
             };
         };
-
-        mcasp0: mcasp@02B00000 {
-            dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
-            dma-names = "tx", "rx";
-        };
-
-        crypto: crypto@4E00000 {
-            compatible = "ti,sa2ul-crypto";
-
-            dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>, <&main_udmap 0x4001>;
-            dma-names = "tx", "rx1", "rx2";
-        };
     };
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 4ea6a8789699..e8b99adcb1bd 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -84,31 +84,31 @@ examples:
     gpu_opp_table: opp_table0 {
       compatible = "operating-points-v2";
 
-      opp@533000000 {
+      opp-533000000 {
         opp-hz = /bits/ 64 <533000000>;
         opp-microvolt = <1250000>;
       };
-      opp@450000000 {
+      opp-450000000 {
         opp-hz = /bits/ 64 <450000000>;
         opp-microvolt = <1150000>;
       };
-      opp@400000000 {
+      opp-400000000 {
         opp-hz = /bits/ 64 <400000000>;
         opp-microvolt = <1125000>;
       };
-      opp@350000000 {
+      opp-350000000 {
         opp-hz = /bits/ 64 <350000000>;
         opp-microvolt = <1075000>;
       };
-      opp@266000000 {
+      opp-266000000 {
         opp-hz = /bits/ 64 <266000000>;
         opp-microvolt = <1025000>;
       };
-      opp@160000000 {
+      opp-160000000 {
         opp-hz = /bits/ 64 <160000000>;
         opp-microvolt = <925000>;
       };
-      opp@100000000 {
+      opp-100000000 {
         opp-hz = /bits/ 64 <100000000>;
         opp-microvolt = <912500>;
       };
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 36f59b3ade71..8d966f3ff3db 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -138,31 +138,31 @@ examples:
     gpu_opp_table: opp_table0 {
       compatible = "operating-points-v2";
 
-      opp@533000000 {
+      opp-533000000 {
         opp-hz = /bits/ 64 <533000000>;
         opp-microvolt = <1250000>;
       };
-      opp@450000000 {
+      opp-450000000 {
         opp-hz = /bits/ 64 <450000000>;
         opp-microvolt = <1150000>;
       };
-      opp@400000000 {
+      opp-400000000 {
         opp-hz = /bits/ 64 <400000000>;
         opp-microvolt = <1125000>;
       };
-      opp@350000000 {
+      opp-350000000 {
         opp-hz = /bits/ 64 <350000000>;
         opp-microvolt = <1075000>;
       };
-      opp@266000000 {
+      opp-266000000 {
         opp-hz = /bits/ 64 <266000000>;
         opp-microvolt = <1025000>;
       };
-      opp@160000000 {
+      opp-160000000 {
         opp-hz = /bits/ 64 <160000000>;
         opp-microvolt = <925000>;
       };
-      opp@100000000 {
+      opp-100000000 {
         opp-hz = /bits/ 64 <100000000>;
         opp-microvolt = <912500>;
       };
diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index f46de17c0878..cc3c8ea6a894 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -123,7 +123,7 @@ examples:
         samsung,syscon-phandle = <&pmu_system_controller>;
 
         /* NTC thermistor is a hwmon device */
-        ncp15wb473@0 {
+        ncp15wb473 {
             compatible = "murata,ncp15wb473";
             pullup-uv = <1800000>;
             pullup-ohm = <47000>;
diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index d7c3262b2494..c99ed3934d7e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -62,7 +62,7 @@ required:
 
 examples:
 - |
-    i2c@00000000 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
       gt928@5d {
diff --git a/Documentation/devicetree/bindings/media/ti,cal.yaml b/Documentation/devicetree/bindings/media/ti,cal.yaml
index 1ea784179536..5e066629287d 100644
--- a/Documentation/devicetree/bindings/media/ti,cal.yaml
+++ b/Documentation/devicetree/bindings/media/ti,cal.yaml
@@ -177,7 +177,7 @@ examples:
         };
     };
 
-    i2c5: i2c@4807c000 {
+    i2c {
         clock-frequency = <400000>;
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
index 4a70f875a6eb..480385789394 100644
--- a/Documentation/devicetree/bindings/mfd/max77650.yaml
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -97,14 +97,14 @@ examples:
             regulators {
                 compatible = "maxim,max77650-regulator";
 
-                max77650_ldo: regulator@0 {
+                max77650_ldo: regulator-ldo {
                     regulator-compatible = "ldo";
                     regulator-name = "max77650-ldo";
                     regulator-min-microvolt = <1350000>;
                     regulator-max-microvolt = <2937500>;
                 };
 
-                max77650_sbb0: regulator@1 {
+                max77650_sbb0: regulator-sbb0 {
                     regulator-compatible = "sbb0";
                     regulator-name = "max77650-sbb0";
                     regulator-min-microvolt = <800000>;
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 3c0df4016a12..8fded83c519a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -370,6 +370,7 @@ examples:
     mmc3: mmc@1c12000 {
         #address-cells = <1>;
         #size-cells = <0>;
+        reg = <0x1c12000 0x200>;
         pinctrl-names = "default";
         pinctrl-0 = <&mmc3_pins_a>;
         vmmc-supply = <&reg_vmmc3>;
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index b43c6c65294e..65980224d550 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -76,6 +76,8 @@ examples:
       qfprom: eeprom@700000 {
           #address-cells = <1>;
           #size-cells = <1>;
+          reg = <0x00700000 0x100000>;
+
           wp-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 
           /* ... */
diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
index 020ef9e4c411..94ac23687b7e 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
@@ -86,7 +86,7 @@ examples:
     #include <dt-bindings/clock/sun4i-a10-ccu.h>
     #include <dt-bindings/reset/sun4i-a10-ccu.h>
 
-    usbphy: phy@01c13400 {
+    usbphy: phy@1c13400 {
         #phy-cells = <1>;
         compatible = "allwinner,sun4i-a10-usb-phy";
         reg = <0x01c13400 0x10>, <0x01c14800 0x4>, <0x01c1c800 0x4>;
diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 754ea7ab040a..ef4de32cb17c 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -248,7 +248,7 @@ examples:
       };
 
     //Example 3 pin groups
-      pinctrl@60020000 {
+      pinctrl {
         usart1_pins_a: usart1-0 {
                 pins1 {
                         pinmux = <STM32_PINMUX('A', 9, AF7)>;
diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 92ff2e8ad572..91a39a33000b 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -191,7 +191,7 @@ patternProperties:
 
 examples:
   - |
-    xyzreg: regulator@0 {
+    xyzreg: regulator {
       regulator-min-microvolt = <1000000>;
       regulator-max-microvolt = <2500000>;
       regulator-always-on;
diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 80bac7a182d5..4b5509436588 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -125,7 +125,7 @@ examples:
       #size-cells = <1>;
       ranges;
 
-      sram_a: sram@00000000 {
+      sram_a: sram@0 {
         compatible = "mmio-sram";
         reg = <0x00000000 0xc000>;
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 23e989e09766..d918cee100ac 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -87,7 +87,7 @@ additionalProperties: false
 
 examples:
   - |
-    timer {
+    timer@1c20c00 {
         compatible = "allwinner,sun4i-a10-timer";
         reg = <0x01c20c00 0x400>;
         interrupts = <22>,
-- 
2.20.1

