Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93BDC47259
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C55F20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IvmoLKhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEDPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:48:37 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:27488 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729168AbgEDPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:48:28 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FfANt013282;
        Mon, 4 May 2020 10:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=PTUqGsExCqy1iGgVnDfJon+Dgv6eXvoMayShFYFUPX8=;
 b=IvmoLKhwGr3wMxkLf+Ws51vSwyLpLO/wZuTvSbv+lTHunCzm+yEsJV4wJV2KEO/VNXrj
 LVugbFrIMmSmnE9c36YdnoiNHxZD3Uk3MMlOD5Ajtp32Nsbboqgt6T95qd+YlIoFkOXY
 PaE1dv2/6WVk3DJFKqD7npCqDORKddXHmikaeoSh1JY7zzv5ZDDwbglVb+jEYUTBjPLh
 GHZhCJF5OpRyg3yWD3wQEvWZaF07CLl+r3wQ3uD33uc4oLDI+msjf50fz3wOGV/FXHrI
 2uFAxnWkJ5d2TQxzLUFCET0AX3Liq29Eusb92r+YnhldBGqratuhrRtoG84lzDBRsa9h pQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pkefj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 10:48:00 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 16:47:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 May 2020 16:47:57 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 644722C5;
        Mon,  4 May 2020 15:47:57 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 5/5] mfd: lochnagar: Move binding over to dtschema
Date:   Mon, 4 May 2020 16:47:57 +0100
Message-ID: <20200504154757.17519-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
References: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Removed contains on the compatible
 - Moved all sub-nodes into here directly only using $ref for properties
 - As the regulator binding only contained subnodes that file is now deleted
 - Removed some pointless descriptions

A little nervous about the amount of clock and regulator stuff this
pulls into the MFD file, any comments on that welcome? Would it be worth
looking into something along the lines of the definitions stuff to keep
some of that out in the clock and regulator bindings?

Thanks,
Charles

 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  85 -----
 .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 352 +++++++++++++++++++++
 .../bindings/regulator/cirrus,lochnagar.txt        |  82 -----
 MAINTAINERS                                        |  11 +-
 4 files changed, 357 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
deleted file mode 100644
index 3bf92ad37fa1b..0000000000000
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-Cirrus Logic Lochnagar Audio Development Board
-
-Lochnagar is an evaluation and development board for Cirrus Logic
-Smart CODEC and Amp devices. It allows the connection of most Cirrus
-Logic devices on mini-cards, as well as allowing connection of
-various application processor systems to provide a full evaluation
-platform.  Audio system topology, clocking and power can all be
-controlled through the Lochnagar, allowing the device under test
-to be used in a variety of possible use cases.
-
-Also see these documents for generic binding information:
-  [1] GPIO : ../gpio/gpio.txt
-
-And these for relevant defines:
-  [2] include/dt-bindings/pinctrl/lochnagar.h
-  [3] include/dt-bindings/clock/lochnagar.h
-
-And these documents for the required sub-node binding details:
-  [4] Clock: ../clock/cirrus,lochnagar.txt
-  [5] Pinctrl: ../pinctrl/cirrus,lochnagar.txt
-  [6] Regulator: ../regulator/cirrus,lochnagar.txt
-  [7] Sound: ../sound/cirrus,lochnagar.txt
-  [8] Hardware Monitor: ../hwmon/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar1"
-                 "cirrus,lochnagar2"
-
-  - reg : I2C slave address
-
-  - reset-gpios : Reset line to the Lochnagar, see [1].
-
-Required sub-nodes:
-
-  - lochnagar-clk : Binding for the clocking components, see [4].
-
-  - lochnagar-pinctrl : Binding for the pin control components, see [5].
-
-Optional sub-nodes:
-
-  - Bindings for the regulator components, see [6]. Only available on
-    Lochnagar 2.
-
-  - lochnagar-sc : Binding for the sound card components, see [7].
-                   Only available on Lochnagar 2.
-  - lochnagar-hwmon : Binding for the hardware monitor components, see [8].
-                      Only available on Lochnagar 2.
-
-Optional properties:
-
-  - present-gpios : Host present line, indicating the presence of a
-    host system, see [1]. This can be omitted if the present line is
-    tied in hardware.
-
-Example:
-
-lochnagar: lochnagar@22 {
-	compatible = "cirrus,lochnagar2";
-	reg = <0x22>;
-
-	reset-gpios = <&gpio0 55 0>;
-	present-gpios = <&gpio0 60 0>;
-
-	lochnagar-clk {
-		compatible = "cirrus,lochnagar2-clk";
-		...
-	};
-
-	lochnagar-pinctrl {
-		compatible = "cirrus,lochnagar-pinctrl";
-		...
-	};
-
-	lochnagar-sc {
-		compatible = "cirrus,lochnagar2-soundcard";
-		...
-	};
-
-	lochnagar-hwmon {
-		compatible = "cirrus,lochnagar2-hwmon";
-		...
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..7a616577ac634
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -0,0 +1,352 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/cirrus,lochnagar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic Lochnagar Audio Development Board
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  Lochnagar is an evaluation and development board for Cirrus Logic
+  Smart CODEC and Amp devices. It allows the connection of most Cirrus
+  Logic devices on mini-cards, as well as allowing connection of
+  various application processor systems to provide a full evaluation
+  platform.  Audio system topology, clocking and power can all be
+  controlled through the Lochnagar, allowing the device under test
+  to be used in a variety of possible use cases.
+
+  Also see these documents for generic binding information:
+    [1] GPIO : ../gpio/gpio.txt
+
+  And these for relevant defines:
+    [2] include/dt-bindings/pinctrl/lochnagar.h
+    [3] include/dt-bindings/clock/lochnagar.h
+
+  And these documents for the required sub-node binding details:
+    [4] Clock: ../clock/cirrus,lochnagar.yaml
+    [5] Pinctrl: ../pinctrl/cirrus,lochnagar.yaml
+    [6] Sound: ../sound/cirrus,lochnagar.yaml
+    [7] Hardware Monitor: ../hwmon/cirrus,lochnagar.yaml
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - cirrus,lochnagar2
+    then:
+      properties:
+        lochnagar-hwmon:
+          type: object
+          $ref: /schemas/hwmon/cirrus,lochnagar.yaml#
+
+        lochnagar-sc:
+          type: object
+          $ref: /schemas/sound/cirrus,lochnagar.yaml#
+
+properties:
+  compatible:
+    enum:
+      - cirrus,lochnagar1
+      - cirrus,lochnagar2
+
+  reg:
+    const: 0x22
+
+  reset-gpios:
+    maxItems: 1
+
+  present-gpios:
+    description: |
+      Host present line, indicating the presence of a
+      host system, see [1]. This can be omitted if the present line is
+      tied in hardware.
+    maxItems: 1
+
+  lochnagar-clk:
+    type: object
+    $ref: /schemas/clock/cirrus,lochnagar.yaml#
+
+  lochnagar-pmic32k:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 32768
+
+  lochnagar-clk12m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 12288000
+
+  lochnagar-clk11m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 11298600
+
+  lochnagar-clk24m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 24576000
+
+  lochnagar-clk22m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 22579200
+
+  lochnagar-clk8m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 8192000
+
+  lochnagar-usb24m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 24576000
+
+  lochnagar-usb12m:
+    type: object
+    $ref: /schemas/clock/fixed-clock.yaml#
+    properties:
+      clock-frequency:
+        const: 12288000
+
+  lochnagar-pinctrl:
+    type: object
+    $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
+
+  VDDCORE:
+    description:
+      Initialisation data for the VDDCORE regulator, which supplies the
+      CODECs digital core if not being provided by an internal regulator.
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-vddcore
+
+      SYSVDD-supply:
+        description:
+          Primary power supply for the Lochnagar.
+    required:
+      - compatible
+
+  MICVDD:
+    description:
+      Initialisation data for the MICVDD regulator, which supplies the
+      CODECs MICVDD.
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-micvdd
+
+      SYSVDD-supply:
+        description:
+          Primary power supply for the Lochnagar.
+    required:
+      - compatible
+
+  MIC1VDD:
+    description:
+      Initialisation data for the MIC1VDD supplies.
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-mic1vdd
+
+      cirrus,micbias-input:
+        description:
+          A property selecting which of the CODEC minicard micbias outputs
+          should be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 4
+
+      MICBIAS1-supply:
+        description:
+          Regulator supplies for the MIC1VDD outputs, supplying the digital
+          microphones, normally supplied from the attached CODEC.
+    required:
+      - compatible
+
+  MIC2VDD:
+    description:
+      Initialisation data for the MIC2VDD supplies.
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-mic2vdd
+
+      cirrus,micbias-input:
+        description:
+          A property selecting which of the CODEC minicard micbias outputs
+          should be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 4
+
+      MICBIAS2-supply:
+        description:
+          Regulator supplies for the MIC2VDD outputs, supplying the digital
+          microphones, normally supplied from the attached CODEC.
+    required:
+      - compatible
+
+  VDD1V8:
+    description:
+      Recommended fixed regulator for the VDD1V8 regulator, which supplies
+      the CODECs analog and 1.8V digital supplies.
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    properties:
+      compatible:
+        enum:
+          - regulator-fixed
+
+      regulator-min-microvolt:
+        const: 1800000
+
+      regulator-max-microvolt:
+        const: 1800000
+
+      vin-supply:
+        description:
+          Should be set to same supply as SYSVDD
+    required:
+      - compatible
+      - regulator-min-microvolt
+      - regulator-max-microvolt
+      - regulator-boot-on
+      - regulator-always-on
+      - vin-supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - lochnagar-clk
+  - lochnagar-pinctrl
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clk/lochnagar.h>
+    #include <dt-bindings/pinctrl/lochnagar.h>
+    i2c@e0004000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xe0004000 0x1000>;
+
+        lochnagar: lochnagar@22 {
+            compatible = "cirrus,lochnagar2";
+            reg = <0x22>;
+
+            reset-gpios = <&gpio0 55 0>;
+            present-gpios = <&gpio0 60 0>;
+
+            lochnagarclk: lochnagar-clk {
+                compatible = "cirrus,lochnagar2-clk";
+
+                #clock-cells = <1>;
+                clocks = <&clkaudio>, <&clkpmic>;
+                clock-names = "ln-gf-mclk2", "ln-pmic-32k";
+
+                assigned-clocks = <&lochnagarclk LOCHNAGAR_CDC_MCLK1>,
+                                  <&lochnagarclk LOCHNAGAR_CDC_MCLK2>;
+                assigned-clock-parents = <&clkaudio>, <&clkpmic>;
+            };
+
+            clkpmic: lochnagar-pmic32k {
+                compatible = "fixed-clock";
+                #clock-cells = <0>;
+                clock-frequency = <32768>;
+            };
+
+            lochnagar-pinctrl {
+                compatible = "cirrus,lochnagar-pinctrl";
+
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinsettings>;
+
+                pinsettings: pin-settings {
+                    ap2aif-pins {
+                        input-enable;
+                        groups = "gf-aif1";
+                        function = "codec-aif3";
+                    };
+                    codec2aif-pins {
+                        output-enable;
+                        groups = "codec-aif3";
+                        function = "gf-aif1";
+                    };
+                };
+            };
+
+            lochnagar-sc {
+                compatible = "cirrus,lochnagar2-soundcard";
+
+                #sound-dai-cells = <1>;
+
+                clocks = <&lochnagarclk LOCHNAGAR_SOUNDCARD_MCLK>;
+                clock-names = "mclk";
+            };
+
+            lochnagar-hwmon {
+                compatible = "cirrus,lochnagar2-hwmon";
+            };
+
+            MIC1VDD {
+                compatible = "cirrus,lochnagar2-mic1vdd";
+
+                cirrus,micbias-input = <3>;
+            };
+
+            MICVDD {
+                compatible = "cirrus,lochnagar2-micvdd";
+
+                SYSVDD-supply = <&wallvdd>;
+
+                regulator-min-microvolt = <3300000>;
+                regulator-max-microvolt = <3300000>;
+            };
+
+            VDD1V8 {
+                compatible = "regulator-fixed";
+
+                regulator-name = "VDD1V8";
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+                regulator-boot-on;
+                regulator-always-on;
+
+                vin-supply = <&wallvdd>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
deleted file mode 100644
index 91974e6ee251b..0000000000000
--- a/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Cirrus Logic Lochnagar Audio Development Board
-
-Lochnagar is an evaluation and development board for Cirrus Logic
-Smart CODEC and Amp devices. It allows the connection of most Cirrus
-Logic devices on mini-cards, as well as allowing connection of
-various application processor systems to provide a full evaluation
-platform.  Audio system topology, clocking and power can all be
-controlled through the Lochnagar, allowing the device under test
-to be used in a variety of possible use cases.
-
-This binding document describes the binding for the regulator portion
-of the driver.
-
-Also see these documents for generic binding information:
-  [1] Regulator: ../regulator/regulator.txt
-
-This binding must be part of the Lochnagar MFD binding:
-  [2] ../mfd/cirrus,lochnagar.txt
-
-Optional sub-nodes:
-
-  - VDDCORE : Initialisation data for the VDDCORE regulator, which
-    supplies the CODECs digital core if it has no build regulator for that
-    purpose.
-      Required Properties:
-      - compatible : One of the following strings:
-                     "cirrus,lochnagar2-vddcore"
-      - SYSVDD-supply: Primary power supply for the Lochnagar.
-
-  - MICVDD : Initialisation data for the MICVDD regulator, which
-    supplies the CODECs MICVDD.
-      Required Properties:
-      - compatible : One of the following strings:
-                     "cirrus,lochnagar2-micvdd"
-      - SYSVDD-supply: Primary power supply for the Lochnagar.
-
-  - MIC1VDD, MIC2VDD : Initialisation data for the MICxVDD supplies.
-      Required Properties:
-      - compatible : One of the following strings:
-                     "cirrus,lochnagar2-mic1vdd", "cirrus,lochnagar2-mic2vdd"
-      Optional Properties:
-      - cirrus,micbias-input : A property selecting which of the CODEC
-        minicard micbias outputs should be used, valid values are 1 - 4.
-      - MICBIAS1-supply, MICBIAS2-supply: Regulator supplies for the
-        MICxVDD outputs, supplying the digital microphones, normally
-        supplied from the attached CODEC.
-
-  - VDD1V8 : Recommended fixed regulator for the VDD1V8 regulator, which supplies the
-    CODECs analog and 1.8V digital supplies.
-      Required Properties:
-      - compatible : Should be set to "regulator-fixed"
-      - regulator-min-microvolt : Should be set to 1.8V
-      - regulator-max-microvolt : Should be set to 1.8V
-      - regulator-boot-on
-      - regulator-always-on
-      - vin-supply : Should be set to same supply as SYSVDD
-
-Example:
-
-lochnagar {
-	lochnagar-micvdd: MICVDD {
-		compatible = "cirrus,lochnagar2-micvdd";
-
-		SYSVDD-supply = <&wallvdd>;
-
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	lochnagar-vdd1v8: VDD1V8 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "VDD1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-
-		vin-supply = <&wallvdd>;
-	};
-};
-
diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db314976..91bf1fbe98c8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4062,12 +4062,11 @@ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	patches@opensource.cirrus.com
 S:	Supported
-F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
-F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
-F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
-F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
-F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
-F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
+F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
+F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
+F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
 F:	Documentation/hwmon/lochnagar.rst
 F:	drivers/clk/clk-lochnagar.c
 F:	drivers/hwmon/lochnagar-hwmon.c
-- 
2.11.0

