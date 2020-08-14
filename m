Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E40920774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597422109;
	bh=LRsp/btt9UOyYtJvFlQ9n7bPsWOsc4kVvQpIJUQ/QV4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f9lUgY2kENo2ih2DIIlHw3/rkRQ1w91st4SZSBEMHn+HdIIgW0wdqhAxom0XMTVJE
	 p9pE59xDRwdTPmm+bzieZhqrGEtT8lJjPlMTs34KLshtVK3OIQzq2xkCbmlprnc3+F
	 om9JYGID0yyp4LXTFNc+mJ6Y1SLLqG1k1rxjUeY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHNQVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:21:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36394 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgHNQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:21:40 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so11366655iob.3;
        Fri, 14 Aug 2020 09:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Uqq7tktnOIzY70fK71Kwoupw6rg0Xh+PHkqkEn55dI=;
        b=hPyRrQUa8nKvJLs0DU3Zs/BOLEFj6eR32WCOz/dYT7TiYoOvlwIiaLqTnBEOumEsNN
         hflZEE56d4LEb0nHg+LgpFqTgVN816fAx0xfuFGdSdbB6DR1Ity0A9cy1jGAhVZoCgcv
         2NPi6564MvZ1XOqMddEeMYkH/HN6UG4yNZkgVC8NprUxSGFDJDL6bjcN2hzdZobkO3gz
         +N//Tsh3CoUZFt6a7aMbFPVAu7S3IiM2bZXpo0F83f9AroxJHwJdYryIchfiplE4uu6G
         rivig5HFi0Jfg8KBKSZZBeY4su1WDbWt1gLy2hnev7LWO6HzDJnPT+aYkCcVP5s6G6CP
         Lqkg==
X-Gm-Message-State: AOAM530LIh4cAKddyiY/HZlBCA0YDOtX//nvosAVgiG05mbsPYuyJjfB
        m+pibAVxt4lP6yBs4dFyvl8L2Q1xJg==
X-Google-Smtp-Source: ABdhPJzl6JdfMZmFkvnYgZbdJ7IxH3P6rtqXgWXEvuArMjkhKb9KFnlCEzkZqQj7Fx7d3gPWlXrvaQ==
X-Received: by 2002:a5e:dd44:: with SMTP id u4mr2737958iop.192.1597422097247;
        Fri, 14 Aug 2020 09:21:37 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id a16sm2968913ilp.23.2020.08.14.09.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:21:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove more cases of 'allOf' containing a '$ref'
Date:   Fri, 14 Aug 2020 10:21:34 -0600
Message-Id: <20200814162134.2284874-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another wack-a-mole pass of killing off unnecessary 'allOf + $ref'
usage.

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
 .../bindings/display/brcm,bcm2835-hdmi.yaml   |  3 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  3 +-
 .../interrupt-controller/mti,gic.yaml         | 28 ++++++------
 .../bindings/media/i2c/dongwoon,dw9768.yaml   | 43 +++++++++----------
 .../bindings/pci/ti,j721e-pci-ep.yaml         |  3 +-
 .../bindings/pci/ti,j721e-pci-host.yaml       |  3 +-
 .../bindings/sound/maxim,max98390.yaml        |  6 +--
 .../bindings/sound/nvidia,tegra186-dspk.yaml  |  3 +-
 .../bindings/sound/nvidia,tegra210-dmic.yaml  |  3 +-
 .../bindings/sound/nvidia,tegra210-i2s.yaml   |  3 +-
 .../bindings/sound/ti,j721e-cpb-audio.yaml    |  6 +--
 .../sound/ti,j721e-cpb-ivi-audio.yaml         | 15 +++----
 12 files changed, 49 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
index 52b3cdac0bdf..f54b4e4808f0 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
@@ -32,8 +32,7 @@ properties:
       - const: hdmi
 
   ddc:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: >
       Phandle of the I2C controller used for DDC EDID probing
 
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index a6ac289d98da..0ca992465a21 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -97,8 +97,7 @@ patternProperties:
             input signal is multiplied. For example, <1 3> indicates the signal is scaled
             down to 1/3 of its value before ADC measurement.
             If property is not found default value depending on chip will be used.
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        $ref: /schemas/types.yaml#/definitions/uint32-array
         oneOf:
           - items:
               - const: 1
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
index 9f0eb3addac4..ce6aaff15214 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
@@ -42,14 +42,13 @@ properties:
       Specifies the list of CPU interrupt vectors to which the GIC may not
       route interrupts. This property is ignored if the CPU is started in EIC
       mode.
-    allOf:
-      - $ref: /schemas/types.yaml#definitions/uint32-array
-      - minItems: 1
-        maxItems: 6
-        uniqueItems: true
-        items:
-          minimum: 2
-          maximum: 7
+    $ref: /schemas/types.yaml#definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    uniqueItems: true
+    items:
+      minimum: 2
+      maximum: 7
 
   mti,reserved-ipi-vectors:
     description: |
@@ -57,13 +56,12 @@ properties:
       It accepts two values: the 1st is the starting interrupt and the 2nd is
       the size of the reserved range. If not specified, the driver will
       allocate the last (2 * number of VPEs in the system).
-    allOf:
-      - $ref: /schemas/types.yaml#definitions/uint32-array
-      - items:
-          - minimum: 0
-            maximum: 254
-          - minimum: 2
-            maximum: 254
+    $ref: /schemas/types.yaml#definitions/uint32-array
+    items:
+      - minimum: 0
+        maximum: 254
+      - minimum: 2
+        maximum: 254
 
   timer:
     type: object
diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
index cb96e95d7e81..21864ab86ec4 100644
--- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
@@ -38,39 +38,36 @@ properties:
   dongwoon,aac-mode:
     description:
       Indication of AAC mode select.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - enum:
-          - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
-          - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
-          - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
-          - 5    #  AAC8 mode(operation time# 1.13 x Tvib)
-        default: 2
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum:
+      - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
+      - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
+      - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
+      - 5    #  AAC8 mode(operation time# 1.13 x Tvib)
+    default: 2
 
   dongwoon,aac-timing:
     description:
       Number of AAC Timing count that controlled by one 6-bit period of
       vibration register AACT[5:0], the unit of which is 100 us.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - default: 0x20
-        minimum: 0x00
-        maximum: 0x3f
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    default: 0x20
+    minimum: 0x00
+    maximum: 0x3f
 
   dongwoon,clock-presc:
     description:
       Indication of VCM internal clock dividing rate select, as one multiple
       factor to calculate VCM ring periodic time Tvib.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - enum:
-          - 0    #  Dividing Rate -  2
-          - 1    #  Dividing Rate -  1
-          - 2    #  Dividing Rate -  1/2
-          - 3    #  Dividing Rate -  1/4
-          - 4    #  Dividing Rate -  8
-          - 5    #  Dividing Rate -  4
-        default: 1
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum:
+      - 0    #  Dividing Rate -  2
+      - 1    #  Dividing Rate -  1
+      - 2    #  Dividing Rate -  1/2
+      - 3    #  Dividing Rate -  1/4
+      - 4    #  Dividing Rate -  8
+      - 5    #  Dividing Rate -  4
+    default: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index cfe25cface21..b3c3d0c3c390 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -31,8 +31,7 @@ properties:
   ti,syscon-pcie-ctrl:
     description: Phandle to the SYSCON entry required for configuring PCIe mode
                  and link speed.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index d7b60487c6c3..8200ba00bc09 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -31,8 +31,7 @@ properties:
   ti,syscon-pcie-ctrl:
     description: Phandle to the SYSCON entry required for configuring PCIe mode
       and link speed.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
index 9c2e3effa0c0..fea9a1b6619a 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -18,16 +18,14 @@ properties:
     description: I2C address of the device.
 
   maxim,temperature_calib:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
     description: The calculated temperature data was measured while doing the calibration.
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 65535
 
   maxim,r0_calib:
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
     description: This is r0 calibration data which was measured in factory mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 8388607
 
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
index e620c77d0728..2f2fcffa65cb 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
@@ -48,8 +48,7 @@ properties:
 
   sound-name-prefix:
     pattern: "^DSPK[1-9]$"
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/string
+    $ref: /schemas/types.yaml#/definitions/string
     description:
       Used as prefix for sink/source names of the component. Must be a
       unique string among multiple instances of the same component.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
index 1c14e83f67c7..8689d9f18c11 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
@@ -49,8 +49,7 @@ properties:
 
   sound-name-prefix:
     pattern: "^DMIC[1-9]$"
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/string
+    $ref: /schemas/types.yaml#/definitions/string
     description:
       used as prefix for sink/source names of the component. Must be a
       unique string among multiple instances of the same component.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
index 795797001843..9bbf18153d63 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
@@ -67,8 +67,7 @@ properties:
 
   sound-name-prefix:
     pattern: "^I2S[1-9]$"
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/string
+    $ref: /schemas/types.yaml#/definitions/string
     description:
       Used as prefix for sink/source names of the component. Must be a
       unique string among multiple instances of the same component.
diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
index 6f2be6503401..d52cfbeb2d07 100644
--- a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
@@ -37,13 +37,11 @@ properties:
 
   ti,cpb-mcasp:
     description: phandle to McASP used on CPB
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,cpb-codec:
     description: phandle to the pcm3168a codec used on the CPB
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
index e0b88470a502..bb780f621628 100644
--- a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
@@ -50,28 +50,23 @@ properties:
 
   ti,cpb-mcasp:
     description: phandle to McASP used on CPB
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,cpb-codec:
     description: phandle to the pcm3168a codec used on the CPB
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,ivi-mcasp:
     description: phandle to McASP used on IVI
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,ivi-codec-a:
     description: phandle to the pcm3168a-A codec on the expansion board
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,ivi-codec-b:
     description: phandle to the pcm3168a-B codec on the expansion board
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
     items:
-- 
2.25.1

