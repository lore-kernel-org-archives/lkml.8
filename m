Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC722067B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591888826;
	bh=N2LKNcKUVVE/haOa+2wCE1Z3fse3ofnIkFjP4z6nno8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E9qpWzlyMHiaGNztloYW4hUNc3jyaU28TPVh7uNdBphSA9yGcJW+cq1L0tqsBXplo
	 cdKHoK6rySx+9nxJJGBO+XcP3NxKat91j4xWF6WpACxY1pW12LbaGFaj0CGzKt8zJ2
	 nLaAsfS6Wbpj4XCBBtXe6kityJpB3AKne2K2w1D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgFKPUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:20:23 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34145 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgFKPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:20:21 -0400
Received: by mail-il1-f195.google.com with SMTP id x18so5790790ilp.1;
        Thu, 11 Jun 2020 08:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAVKAHRDXgGLPMfJZBfRvbA2xmqOp2z00RQy/4aV8rQ=;
        b=XjT4NuAKPAIDurTarVN8TN9Avq/cG9X4zFs1MKQs3GCMrBFLOLHcak9y4F6MgnD9yp
         a61QKA1//OR+eY69sWscZJ1ig1udmyf3dkrMvY4x3c/eZ1u3DDbE0qJxyfrkjGiDfycM
         tYCt/0LteZvVsjk0dpYMS9dKehXWak6Psiktpjc9iAxAsBKRUGyLADEfHx5MoLBlujBg
         HBkTvDxD/ceYpWnWN9N8E9MlYgixMbKV6Obx7TqEGShHj+fhREzjjufkKYkk85auxG6R
         Bn5N2lG/eT/qOZbHIC8XOe9pDkrQFCFBpZqiolZrFwcj414yqeJykrEF+UtnC2oC5OaC
         3/fQ==
X-Gm-Message-State: AOAM532PlXGpY+v3iyoayT9Axm94yaPF1QCNYggoCWvcOlLxc/JB/Ym6
        +NOyf2T0LIJ3a72tc2hmNGLO0/A=
X-Google-Smtp-Source: ABdhPJy5eE+JZAglybAdWOhkKMl1YCnQaFPPqpDbWOAi5PV0Lo27xc57icFwskSljCgYgZZNDUVy6Q==
X-Received: by 2002:a05:6e02:13c5:: with SMTP id v5mr7925375ilj.126.1591888817291;
        Thu, 11 Jun 2020 08:20:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id 4sm1677530ilc.34.2020.06.11.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:20:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove more cases of 'allOf' containing a '$ref'
Date:   Thu, 11 Jun 2020 09:20:15 -0600
Message-Id: <20200611152015.1103969-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another round of 'allOf' removals that came in this cycle.

json-schema versions draft7 and earlier have a weird behavior in that
any keywords combined with a '$ref' are ignored (silently). The correct
form was to put a '$ref' under an 'allOf'. This behavior is now changed
in the 2019-09 json-schema spec and '$ref' can be mixed with other
keywords. The json-schema library doesn't yet support this, but the
tooling now does a fixup for this and either way works.

This has been a constant source of review comments, so let's change this
treewide so everyone copies the simpler syntax.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/tegra/nvidia,tegra20-pmc.yaml         |   5 +-
 .../bindings/ata/sata_highbank.yaml           |  21 +-
 .../bindings/gpio/snps,dw-apb-gpio.yaml       |   7 +-
 .../bindings/iio/imu/adi,adis16475.yaml       |   3 +-
 .../bindings/iio/light/amstaos,tsl2563.yaml   |   5 +-
 .../devicetree/bindings/input/iqs269a.yaml    | 222 ++++++++----------
 .../loongson,pch-msi.yaml                     |  14 +-
 .../loongson,pch-pic.yaml                     |   7 +-
 .../devicetree/bindings/ipmi/ipmi-smic.yaml   |  10 +-
 .../bindings/leds/backlight/qcom-wled.yaml    |  43 ++--
 .../devicetree/bindings/leds/leds-aw2013.yaml |   3 +-
 .../bindings/leds/leds-sgm3140.yaml           |   3 +-
 .../devicetree/bindings/media/i2c/ov8856.yaml |   3 +-
 .../memory-controllers/ingenic,nemc.yaml      |   5 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |   3 +-
 .../bindings/net/ti,k3-am654-cpts.yaml        |   6 +-
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml |   3 +-
 .../bindings/pci/cdns-pcie-host.yaml          |   3 +-
 .../bindings/phy/calxeda-combophy.yaml        |   5 +-
 .../bindings/phy/renesas,usb3-phy.yaml        |   5 +-
 .../bindings/power/supply/cw2015_battery.yaml |  15 +-
 .../power/supply/sbs,sbs-battery.yaml         |   6 +-
 .../bindings/regulator/maxim,max77826.yaml    |   9 +-
 .../regulator/rohm,bd71847-regulator.yaml     |  27 +--
 .../devicetree/bindings/rng/arm-cctrng.yaml   |   6 +-
 .../bindings/serial/samsung_uart.yaml         |   5 +-
 .../bindings/soc/qcom/qcom,geni-se.yaml       |   9 +-
 .../devicetree/bindings/sound/fsl,easrc.yaml  |  19 +-
 .../bindings/sound/simple-card.yaml           |  10 +-
 .../bindings/sound/tlv320adcx140.yaml         |  26 +-
 .../thermal/socionext,uniphier-thermal.yaml   |   5 +-
 .../bindings/usb/aspeed,usb-vhub.yaml         |  24 +-
 .../bindings/watchdog/arm-smc-wdt.yaml        |   3 +-
 33 files changed, 224 insertions(+), 316 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 81534d04094b..b71a20af5f70 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -85,9 +85,8 @@ properties:
       CPU power good signal from external PMIC to PMC is enabled.
 
   nvidia,suspend-mode:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
     description:
       The suspend mode that the platform should use.
       Mode 0 is for LP0, CPU + Core voltage off and DRAM in self-refresh
diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
index b195457006cc..5e2a2394e600 100644
--- a/Documentation/devicetree/bindings/ata/sata_highbank.yaml
+++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
@@ -40,28 +40,25 @@ properties:
 
   calxeda,led-order:
     description: Maps port numbers to offsets within the SGPIO bitstream.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - minItems: 1
-        maxItems: 8
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
 
   calxeda,port-phys:
     description: |
       phandle-combophy and lane assignment, which maps each SATA port to a
       combophy and a lane within that combophy
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle-array
-      - minItems: 1
-        maxItems: 8
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 8
 
   calxeda,tx-atten:
     description: |
       Contains TX attenuation override codes, one per port.
       The upper 24 bits of each entry are always 0 and thus ignored.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - minItems: 1
-        maxItems: 8
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
 
   calxeda,sgpio-gpio:
     description: |
diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
index 04a3c51e1dc1..1240f6289249 100644
--- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
@@ -63,11 +63,10 @@ patternProperties:
 
       snps,nr-gpios:
         description: The number of GPIO pins exported by the port.
+        $ref: /schemas/types.yaml#/definitions/uint32
         default: 32
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - minimum: 1
-            maximum: 32
+        minimum: 1
+        maximum: 32
 
       interrupts:
         description: |
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 98baecb4b98a..208faaffa58d 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -67,8 +67,7 @@ properties:
       1 - direct_sync
       2 - scaled_sync
       3 - pulse_sync
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
 
diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
index efd2eba5f23c..e201a06d8fdc 100644
--- a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
@@ -25,9 +25,8 @@ properties:
 
   amstaos,cover-comp-gain:
     description: Multiplier for gain compensation
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 16]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 16]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
index f0242bb4be81..9c154e5e1a91 100644
--- a/Documentation/devicetree/bindings/input/iqs269a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
@@ -40,10 +40,9 @@ properties:
       posed on channels 6 and 7 by Hall-effect sensing.
 
   azoteq,suspend-mode:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description: |
       Specifies the power mode during suspend as follows:
       0: Automatic (same as normal runtime, i.e. suspend/resume disabled)
@@ -56,11 +55,10 @@ properties:
     description: Divides the device's core clock by a factor of 4.
 
   azoteq,ulp-update:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 7
-        default: 3
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 3
     description: Specifies the ultra-low-power mode update rate.
 
   azoteq,reseed-offset:
@@ -70,34 +68,30 @@ properties:
       reseed events.
 
   azoteq,filt-str-lp-lta:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description:
       Specifies the long-term average filter strength during low-power mode.
 
   azoteq,filt-str-lp-cnt:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description:
       Specifies the raw count filter strength during low-power mode.
 
   azoteq,filt-str-np-lta:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description:
       Specifies the long-term average filter strength during normal-power mode.
 
   azoteq,filt-str-np-cnt:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description:
       Specifies the raw count filter strength during normal-power mode.
 
@@ -156,11 +150,10 @@ properties:
     description: Disables all raw count filtering.
 
   azoteq,gpio3-select:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 7
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 0
     description:
       Selects the channel for which the GPIO3 pin represents touch state.
 
@@ -172,10 +165,9 @@ properties:
       in either direction.
 
   azoteq,tx-freq:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description: |
       Specifies the inductive sensing excitation frequency as follows (paren-
       thesized numbers represent the frequency if 'azoteq,clk-div' is present):
@@ -189,10 +181,9 @@ properties:
     description: Increases the global capacitance adder from 0.5 pF to 1.5 pF.
 
   azoteq,reseed-select:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
     description: |
       Specifies the event(s) that prompt the device to reseed (i.e. reset the
       long-term average) of an associated channel as follows:
@@ -208,10 +199,9 @@ properties:
       channels.
 
   azoteq,filt-str-slider:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-        default: 1
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 1
     description: Specifies the slider coordinate filter strength.
 
 patternProperties:
@@ -246,27 +236,25 @@ patternProperties:
         description: Specifies that the channel participates in slider 1.
 
       azoteq,rx-enable:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32-array
-          - minItems: 1
-            maxItems: 8
-            items:
-              minimum: 0
-              maximum: 7
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8
+        items:
+          minimum: 0
+          maximum: 7
         description:
           Specifies the CRX pin(s) associated with the channel. By default, only
           the CRX pin corresponding to the channel's index is enabled (e.g. CRX0
           for channel 0).
 
       azoteq,tx-enable:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32-array
-          - minItems: 1
-            maxItems: 8
-            items:
-              minimum: 0
-              maximum: 7
-            default: [0, 1, 2, 3, 4, 5, 6, 7]
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8
+        items:
+          minimum: 0
+          maximum: 7
+        default: [0, 1, 2, 3, 4, 5, 6, 7]
         description: Specifies the TX pin(s) associated with the channel.
 
       azoteq,meas-cap-decrease:
@@ -279,10 +267,9 @@ patternProperties:
         description: Floats any inactive CRX pins instead of grounding them.
 
       azoteq,local-cap-size:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 2]
-            default: 0
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 0
         description: |
           Specifies the capacitance to be added to the channel as follows:
           0: None
@@ -296,10 +283,9 @@ patternProperties:
           deep-touch events relative to their respective thresholds.
 
       azoteq,proj-bias:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 2, 3]
-            default: 2
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 2
         description: |
           Specifies the bias current applied during projected-capacitance
           sensing as follows:
@@ -309,10 +295,9 @@ patternProperties:
           3: 20 uA
 
       azoteq,sense-mode:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 9, 14, 15]
-            default: 0
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 9, 14, 15]
+        default: 0
         description: |
           Specifies the channel's sensing mode as follows:
           0:  Self capacitance
@@ -322,10 +307,9 @@ patternProperties:
           15: Temperature
 
       azoteq,sense-freq:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 2, 3]
-            default: 1
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 1
         description: |
           Specifies the channel's sensing frequency as follows (parenthesized
           numbers represent the frequency if 'azoteq,clk-div' is present):
@@ -339,10 +323,9 @@ patternProperties:
         description: Enables the static front-end for the channel.
 
       azoteq,ati-mode:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 2, 3]
-            default: 3
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 3
         description: |
           Specifies the channel's ATI mode as follows:
           0: Disabled
@@ -351,39 +334,35 @@ patternProperties:
           3: Full
 
       azoteq,ati-base:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [75, 100, 150, 200]
-            default: 100
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [75, 100, 150, 200]
+        default: 100
         description: Specifies the channel's ATI base.
 
       azoteq,ati-target:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - multipleOf: 32
-            minimum: 0
-            maximum: 2016
-            default: 512
+        $ref: /schemas/types.yaml#/definitions/uint32
+        multipleOf: 32
+        minimum: 0
+        maximum: 2016
+        default: 512
         description: Specifies the channel's ATI target.
 
       azoteq,assoc-select:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32-array
-          - minItems: 1
-            maxItems: 8
-            items:
-              minimum: 0
-              maximum: 7
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8
+        items:
+          minimum: 0
+          maximum: 7
         description:
           Specifies the associated channels for which the channel serves as a
           reference channel. By default, no channels are selected.
 
       azoteq,assoc-weight:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - minimum: 0
-            maximum: 255
-            default: 0
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+        default: 0
         description:
           Specifies the channel's impact weight if it acts as an associated
           channel (0 = 0% impact, 255 = 200% impact).
@@ -411,11 +390,10 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint32
-              - minimum: 0
-                maximum: 255
-                default: 10
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 255
+            default: 10
             description: Specifies the threshold for the event.
 
           linux,code:
@@ -430,19 +408,17 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint32
-              - minimum: 0
-                maximum: 255
-                default: 8
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 255
+            default: 8
             description: Specifies the threshold for the event.
 
           azoteq,hyst:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint32
-              - minimum: 0
-                maximum: 15
-                default: 4
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 15
+            default: 4
             description: Specifies the hysteresis for the event.
 
           linux,code:
@@ -457,19 +433,17 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint32
-              - minimum: 0
-                maximum: 255
-                default: 26
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 255
+            default: 26
             description: Specifies the threshold for the event.
 
           azoteq,hyst:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint32
-              - minimum: 0
-                maximum: 15
-                default: 0
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 15
+            default: 0
             description: Specifies the hysteresis for the event.
 
           linux,code:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
index 1a5ebbdd219a..1b256d9dd92a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -25,19 +25,17 @@ properties:
     description:
       u32 value of the base of parent HyperTransport vector allocated
       to PCH MSI.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - minimum: 0
-        maximum: 255
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 255
 
   loongson,msi-num-vecs:
     description:
       u32 value of the number of parent HyperTransport vectors allocated
       to PCH MSI.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - minimum: 1
-        maximum: 256
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 256
 
   msi-controller: true
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
index 274adea13f33..a6dcbb2971a9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
@@ -25,10 +25,9 @@ properties:
     description:
       u32 value of the base of parent HyperTransport vector allocated
       to PCH PIC.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - minimum: 0
-        maximum: 192
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 192
 
   interrupt-controller: true
 
diff --git a/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
index f0bb157e9417..58fa76ee6176 100644
--- a/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
+++ b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
@@ -31,9 +31,8 @@ properties:
 
   reg-size:
     description: The access width of the register in bytes. Defaults to 1.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 2, 4, 8]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
 
   reg-spacing:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -43,9 +42,8 @@ properties:
     description: |
       The amount of bits to shift the register content to the right to get
       the data into bit zero.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - maximum: 56
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 56
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
index 01c7d93dc658..32e0896c6bc1 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
@@ -57,8 +57,7 @@ properties:
     description: |
       mA; per-string current limit.
       This property is supported only for WLED3.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     default: 20
     minimum: 0
     maximum: 25
@@ -74,38 +73,33 @@ properties:
   qcom,current-boost-limit:
     description: |
       mA; boost current limit.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   qcom,switching-freq:
     description: |
       kHz; switching frequency.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200, 4800, 9600 ]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200, 4800, 9600 ]
 
   qcom,ovp:
     description: |
       V; Over-voltage protection limit.
       This property is supported only for WLED3.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 27, 29, 32, 35 ]
-      - default: 29
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 27, 29, 32, 35 ]
+    default: 29
 
   qcom,ovp-millivolt:
     description: |
       Over-voltage protection limit. This property is for WLED4 only.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 18100, 19600, 29600, 31100 ]
-      - default: 29600
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 18100, 19600, 29600, 31100 ]
+    default: 29600
 
   qcom,num-strings:
     description: |
       number of led strings attached.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   qcom,enabled-strings:
     description: |
@@ -113,8 +107,7 @@ properties:
       string of leds are operated individually. Specify the
       list of strings used by the device. Any combination of
       led strings can be used.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 4
 
@@ -150,10 +143,9 @@ properties:
            0 - Modulator A
            1 - Modulator B
       This property is applicable only to WLED5 peripheral.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 0, 1 ]
-      - default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    default: 0
 
   qcom,cabc-sel:
     description: |
@@ -164,9 +156,8 @@ properties:
            2 - CABC 2
            3 - External signal (e.g. LPG) is used for dimming
       This property is applicable only to WLED5 peripheral.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 0, 1, 2, 3 ]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
 
 allOf:
   - if:
diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
index f118721df1e8..e24b0d15ef01 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -32,8 +32,7 @@ properties:
 patternProperties:
   "^led@[0-2]$":
     type: object
-    allOf:
-      - $ref: common.yaml#
+    $ref: common.yaml#
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
index ecf7ac9ab067..f68259619488 100644
--- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
@@ -33,8 +33,7 @@ properties:
 
   led:
     type: object
-    allOf:
-      - $ref: common.yaml#
+    $ref: common.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
index d6af685ad3ca..1956b2a32bf4 100644
--- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
@@ -79,8 +79,7 @@ properties:
               - const: 4
 
           link-frequencies:
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/uint64-array
+            $ref: /schemas/types.yaml#/definitions/uint64-array
             description:
               Allowed data bus frequencies. 360000000, 180000000 Hz or both
               are supported by the driver.
diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index 9b478da0c479..17ba45a6c260 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -45,9 +45,8 @@ patternProperties:
         maxItems: 255
 
       ingenic,nemc-bus-width:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [8, 16]
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [8, 16]
         description: Specifies the bus width in bits.
 
       ingenic,nemc-tAS:
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index 71d9e6c1c72e..174579370a22 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -145,8 +145,7 @@ patternProperties:
 
   "^cpts@[0-9a-f]+":
     type: object
-    allOf:
-      - $ref: "ti,k3-am654-cpts.yaml#"
+    $ref: "ti,k3-am654-cpts.yaml#"
     description:
       CPSW Common Platform Time Sync (CPTS) module.
 
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index 50e027911dd4..af608f2ecfdf 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -74,15 +74,13 @@ properties:
       - const: cpts
 
   ti,cpts-ext-ts-inputs:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 8
     description:
       Number of hardware timestamp push inputs (HWx_TS_PUSH)
 
   ti,cpts-periodic-outputs:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 8
     description:
       Number of timestamp Generator function outputs (TS_GENFx)
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index 6150a7a7bdbf..016a5f61592d 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -15,8 +15,7 @@ allOf:
 properties:
   cdns,max-outbound-regions:
     description: maximum number of outbound regions
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 32
     default: 32
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index c87a3a36ccd2..303078a7b7a8 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -16,8 +16,7 @@ allOf:
 properties:
   cdns,max-outbound-regions:
     description: maximum number of outbound regions
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 32
     default: 32
diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
index 16a8bd7644bf..41ee16e21f8d 100644
--- a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
+++ b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
@@ -29,9 +29,8 @@ properties:
 
   phydev:
     description: device ID for programming the ComboPHY.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - maximum: 31
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 31
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml
index f459eaf55278..68cf9dd0390d 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml
@@ -52,9 +52,8 @@ properties:
     description: |
       Enable/disable spread spectrum clock (ssc). 0 or the property doesn't
       exist means disabling the ssc. The actual value will be -<value> ppm.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 0, 4003, 4492, 4980 ]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 4003, 4492, 4980 ]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index 4a265d4234b9..2036977ecc2f 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -27,11 +27,9 @@ properties:
       of this binary blob is kept secret by CellWise. The only way to obtain
       it is to mail two batteries to a test facility of CellWise and receive
       back a test report with the binary blob.
-    allOf:
-      - $ref: /schemas/types.yaml#definitions/uint8-array
-    items:
-      - minItems: 64
-        maxItems: 64
+    $ref: /schemas/types.yaml#definitions/uint8-array
+    minItems: 64
+    maxItems: 64
 
   cellwise,monitor-interval-ms:
     description:
@@ -41,10 +39,9 @@ properties:
   power-supplies:
     description:
       Specifies supplies used for charging the battery connected to this gauge
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle-array
-      - minItems: 1
-        maxItems: 8 # Should be enough
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 8 # Should be enough
 
   monitored-battery:
     description:
diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
index 205bc826bd20..a90b3601e695 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
@@ -32,16 +32,14 @@ properties:
     description:
       The number of times to retry I2C transactions on I2C IO failure.
     default: 0
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   sbs,poll-retry-count:
     description:
       The number of times to try looking for new status after an external
       change notification.
     default: 0
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   sbs,battery-detect-gpios:
     description:
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77826.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77826.yaml
index 19cbd5eb2897..78c0b63243f7 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max77826.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77826.yaml
@@ -21,8 +21,7 @@ properties:
 
   regulators:
     type: object
-    allOf:
-      - $ref: regulator.yaml#
+    $ref: regulator.yaml#
     description: |
       list of regulators provided by this controller, must be named
       after their hardware counterparts LDO[1-15], BUCK and BUCKBOOST
@@ -30,13 +29,11 @@ properties:
     patternProperties:
       "^LDO([1-9]|1[0-5])$":
         type: object
-        allOf:
-          - $ref: regulator.yaml#
+        $ref: regulator.yaml#
 
       "^BUCK|BUCKBOOST$":
         type: object
-        allOf:
-          - $ref: regulator.yaml#
+        $ref: regulator.yaml#
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index d797cc23406f..07256a4b50b9 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -29,8 +29,7 @@ description: |
 patternProperties:
   "^LDO[1-6]$":
     type: object
-    allOf:
-      - $ref: regulator.yaml#
+    $ref: regulator.yaml#
     description:
       Properties for single LDO regulator.
 
@@ -44,8 +43,7 @@ patternProperties:
 
   "^BUCK[1-6]$":
     type: object
-    allOf:
-      - $ref: regulator.yaml#
+    $ref: regulator.yaml#
     description:
       Properties for single BUCK regulator.
 
@@ -56,28 +54,25 @@ patternProperties:
           should be "buck1", ..., "buck6"
 
       rohm,dvs-run-voltage:
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/uint32"
-          - minimum: 0
-            maximum: 1300000
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1300000
         description:
           PMIC default "RUN" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
 
       rohm,dvs-idle-voltage:
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/uint32"
-          - minimum: 0
-            maximum: 1300000
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1300000
         description:
           PMIC default "IDLE" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
 
       rohm,dvs-suspend-voltage:
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/uint32"
-          - minimum: 0
-            maximum: 1300000
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 1300000
         description:
           PMIC default "SUSPEND" state voltage in uV. See below table for
           bucks which support this. 0 means disabled.
diff --git a/Documentation/devicetree/bindings/rng/arm-cctrng.yaml b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
index ca6aad19b6ba..c471e4c10558 100644
--- a/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
+++ b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
@@ -28,10 +28,8 @@ properties:
     description:
       Arm TrustZone CryptoCell TRNG engine has 4 ring oscillators.
       Sampling ratio values for these 4 ring oscillators. (from calibration)
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - items:
-          maxItems: 4
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 4
 
   clocks:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 32a5e1e30833..96414ac65d06 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -33,9 +33,8 @@ properties:
     description: |
       The size (in bytes) of the IO accesses that should be performed
       on the device.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [ 1, 4 ]
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 4 ]
 
   clocks:
     minItems: 2
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index dee8bb2b69fe..a2b29cc3e93b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -100,8 +100,7 @@ patternProperties:
                  supports up to 50MHz, up to four chip selects, programmable
                  data path from 4 bits to 32 bits and numerous protocol
                  variants.
-    allOf:
-      - $ref: /spi/spi-controller.yaml#
+    $ref: /spi/spi-controller.yaml#
 
     properties:
       compatible:
@@ -126,8 +125,7 @@ patternProperties:
   "i2c@[0-9a-f]+$":
     type: object
     description: GENI serial engine based I2C controller.
-    allOf:
-      - $ref: /schemas/i2c/i2c-controller.yaml#
+    $ref: /schemas/i2c/i2c-controller.yaml#
 
     properties:
       compatible:
@@ -156,8 +154,7 @@ patternProperties:
   "serial@[0-9a-f]+$":
     type: object
     description: GENI Serial Engine based UART Controller.
-    allOf:
-      - $ref: /schemas/serial.yaml#
+    $ref: /schemas/serial.yaml#
 
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index 73cdcf053a9c..9dd57a974b28 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -45,23 +45,20 @@ properties:
       - const: ctx3_tx
 
   firmware-name:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/string
-      - const: imx/easrc/easrc-imx8mn.bin
+    $ref: /schemas/types.yaml#/definitions/string
+    const: imx/easrc/easrc-imx8mn.bin
     description: The coefficient table for the filters
 
   fsl,asrc-rate:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 8000
-      - maximum: 192000
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8000
+    maximum: 192000
     description: Defines a mutual sample rate used by DPCM Back Ends
 
   fsl,asrc-format:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [2, 6, 10, 32, 36]
-        default: 2
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2, 6, 10, 32, 36]
+    default: 2
     description:
       Defines a mutual sample format used by DPCM Back Ends
 
diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index cb2bb5fac0e1..8132d0c0f00a 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -13,15 +13,13 @@ definitions:
 
   frame-master:
     description: Indicates dai-link frame master.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle-array
-      - maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
 
   bitclock-master:
     description: Indicates dai-link bit clock master
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle-array
-      - maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
 
   frame-inversion:
     description: dai-link uses frame clock inversion
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index c5b5b4260496..2e6ac5d2ee96 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -76,13 +76,12 @@ properties:
        PDMIN3 - PDMCLK latching edge used for channel 5 and 6 data
        PDMIN4 - PDMCLK latching edge used for channel 7 and 8 data
 
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - minItems: 1
-        maxItems: 4
-        items:
-          maximum: 1
-        default: [0, 0, 0, 0]
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      maximum: 1
+    default: [0, 0, 0, 0]
 
   ti,gpi-config:
     description: |
@@ -102,13 +101,12 @@ properties:
        7 - GPIX is configured as a PDM data input for channel 7 and channel
             (PDMDIN4)
 
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - minItems: 1
-        maxItems: 4
-        items:
-          maximum: 7
-        default: [0, 0, 0, 0]
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      maximum: 7
+    default: [0, 0, 0, 0]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index bb9594bb2cf1..553c9dcdaeeb 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -28,9 +28,8 @@ properties:
     const: 0
 
   socionext,tmod-calibration:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - maxItems: 2
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
     description:
       A pair of calibrated values referred from PVT, in case that the values
       aren't set on SoC, like a reference board.
diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
index ccc67d03d4bb..e4e83d3971ac 100644
--- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
@@ -52,21 +52,18 @@ properties:
 
   vhub-vendor-id:
     description: vhub Vendor ID
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - maximum: 65535
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
 
   vhub-product-id:
     description: vhub Product ID
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - maximum: 65535
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
 
   vhub-device-revision:
     description: vhub Device Revision in binary-coded decimal
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - maximum: 65535
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 65535
 
   vhub-strings:
     type: object
@@ -90,18 +87,15 @@ properties:
 
           manufacturer:
             description: vhub manufacturer
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/string
+            $ref: /schemas/types.yaml#/definitions/string
 
           product:
             description: vhub product name
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/string
+            $ref: /schemas/types.yaml#/definitions/string
 
           serial-number:
             description: vhub device serial number
-            allOf:
-              - $ref: /schemas/types.yaml#/definitions/string
+            $ref: /schemas/types.yaml#/definitions/string
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
index bec651541e0c..8e4c7c69bc1c 100644
--- a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
@@ -17,8 +17,7 @@ properties:
     enum:
       - arm,smc-wdt
   arm,smc-id:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       The ATF smc function id used by the firmware.
       Defaults to 0x82003D06 if unset.
-- 
2.25.1

