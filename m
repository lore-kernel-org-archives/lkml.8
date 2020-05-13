Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12694CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE42205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XQoLgexN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbgEMJ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:58:00 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61520 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388469AbgEMJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:57:30 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9u0Lk020735;
        Wed, 13 May 2020 04:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=S7xojcQy7IkRwmV8KWrhmJWwJ9D5XE7+CtTCv4bZOxs=;
 b=XQoLgexNCsdkNoT5Fx6/PCXcjfTZOGPe5Cf78KKms873xBL30ckUlheMDmX89A7PL4pd
 6ZlXK9/mab6rQ+mGaBmHnIH5UMGC54eIlwXKf1M25lMgcxkAnOzHHsYDnMCKusT3ETMC
 rOZwqHCG1ceNUpd58ag+nfzpexdJwvOBnAW/fjF0223361bckPdJfPfLB+uh4GxVqQW7
 pdoEEboam6bi2SI5VhYsOajnTg8b6R7uo6aQut3ujv2hw9zInuFl/oKON+OYL19avS9B
 dhDaEdc+qC5BJh68Ht7WF8oRhv4uJiCf7DhM3lCDtk/5A2XiDWAJc335VvB6naxQNDq6 MQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3100xes5n1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 04:57:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 10:57:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 10:57:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7FFBD448;
        Wed, 13 May 2020 09:57:21 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 7/7] mfd: madera: Move binding over to dtschema
Date:   Wed, 13 May 2020 10:57:20 +0100
Message-ID: <20200513095720.8867-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Removed some more redundant descriptions
 - Updated pinctrl node naming in the example

Thanks,
Charles

 .../devicetree/bindings/mfd/cirrus,madera.yaml     | 311 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/madera.txt   | 114 --------
 MAINTAINERS                                        |   6 +-
 3 files changed, 314 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/madera.txt

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml b/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
new file mode 100644
index 0000000000000..a013c14cbee17
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
@@ -0,0 +1,311 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/cirrus,madera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic Madera class audio CODECs Multi-Functional Device
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a range
+  of analogue I/O.
+
+  See also the child driver bindings in:
+
+    bindings/pinctrl/cirrus,madera.yaml
+    bindings/regulator/wlf,arizona.yaml
+    bindings/sound/cirrus,madera.yaml
+
+allOf:
+  - $ref: /schemas/pinctrl/cirrus,madera.yaml#
+  - $ref: /schemas/regulator/wlf,arizona.yaml#
+  - $ref: /schemas/sound/cirrus,madera.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cirrus,cs47l85
+              - wlf,wm1840
+    then:
+      properties:
+        SPKVDDL-supply:
+          description:
+            Left speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+        SPKVDDR-supply:
+          description:
+            Right speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+      required:
+        - SPKVDDL-supply
+        - SPKVDDR-supply
+    else:
+      required:
+        - DCVDD-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cirrus,cs47l15
+              - cirrus,cs47l35
+    then:
+      properties:
+        SPKVDD-supply:
+          description:
+            Mono speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+      required:
+        - SPKVDD-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cirrus,cs47l35
+              - cirrus,cs47l85
+              - cirrus,cs47l90
+              - cirrus,cs47l91
+              - wlf,wm1840
+    then:
+      properties:
+        DBVDD2-supply:
+          description:
+            Databus power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+      required:
+        - DBVDD2-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cirrus,cs47l85
+              - cirrus,cs47l90
+              - cirrus,cs47l91
+              - wlf,wm1840
+    then:
+      properties:
+        DBVDD3-supply:
+          description:
+            Databus power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+        DBVDD4-supply:
+          description:
+            Databus power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+  - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - cirrus,cs47l15
+    then:
+      required:
+        - MICVDD-supply
+    else:
+      properties:
+        CPVDD2-supply:
+          description:
+            Secondary charge pump power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+
+      required:
+        - CPVDD2-supply
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - cirrus,cs47l15
+        - cirrus,cs47l35
+        - cirrus,cs47l85
+        - cirrus,cs47l90
+        - cirrus,cs47l91
+        - cirrus,cs42l92
+        - cirrus,cs47l92
+        - cirrus,cs47l93
+        - cirrus,wm1840
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description:
+      The first cell is the pin number. The second cell is reserved for
+      future use and must be zero
+    const: 2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description:
+      The first cell is the IRQ number.
+      The second cell is the flags, encoded as the trigger masks from
+      bindings/interrupt-controller/interrupts.txt
+    const: 2
+
+  interrupts: true
+
+  reset-gpios:
+    description:
+      One entry specifying the GPIO controlling /RESET.  As defined in
+      bindings/gpio.txt.  Although optional, it is strongly recommended
+      to use a hardware reset.
+    maxItems: 1
+
+  clocks:
+    description:
+      Should reference the clocks supplied on MCLK1, MCLK2 and MCLK3.
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description: |
+      May contain up to three strings:
+        "mclk1" For the clock supplied on MCLK1, recommended to be a
+                high quality audio reference clock.
+        "mclk2" For the clock supplied on MCLK2, required to be an
+                always on 32k clock.
+        "mclk3" For the clock supplied on MCLK3.
+    oneOf:
+      - items:
+        - const: mclk1
+      - items:
+        - const: mclk2
+      - items:
+        - const: mclk3
+      - items:
+        - const: mclk1
+        - const: mclk2
+      - items:
+        - const: mclk1
+        - const: mclk3
+      - items:
+        - const: mclk2
+        - const: mclk3
+      - items:
+        - const: mclk1
+        - const: mclk2
+        - const: mclk3
+
+  AVDD-supply:
+    description:
+      Analogue power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  DBVDD1-supply:
+    description:
+      Databus power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  CPVDD1-supply:
+    description:
+      Charge pump power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  DCVDD-supply:
+    description:
+      Digital power supply, optional on CS47L85, WM1840 where it can
+      be supplied internally.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  MICVDD-supply:
+    description:
+      Microphone power supply, normally supplied internally except on
+      cs47l24, wm1831 where it is mandatory.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupt-parent
+  - interrupts
+  - AVDD-supply
+  - DBVDD1-supply
+  - CPVDD1-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/madera.h>
+    i2c@e0004000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xe0004000 0x1000>;
+
+        cs47l85: codec@1a {
+            compatible = "cirrus,cs47l85";
+            reg = <0x1a>;
+
+            reset-gpios = <&gpio 0>;
+            wlf,ldoena = <&gpio 1>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <&host_irq1>;
+            interrupt-parent = <&gic>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            AVDD-supply = <&vdd1v8>;
+            DBVDD1-supply = <&vdd1v8>;
+            DBVDD2-supply = <&vdd1v8>;
+            DBVDD3-supply = <&vdd1v8>;
+            DBVDD4-supply = <&vdd1v8>;
+            CPVDD1-supply = <&vdd1v8>;
+            CPVDD2-supply = <&vdd1v2>;
+            SPKVDDL-supply = <&vdd5v>;
+            SPKVDDR-supply = <&vdd5v>;
+
+            clocks = <&clks 0>, <&clks 1>, <&clks 2>;
+            clock-names = "mclk1", "mclk2", "mclk3";
+
+            cirrus,dmic-ref = <0 0 MADERA_DMIC_REF_MICBIAS1>;
+            cirrus,inmode = <
+                MADERA_INMODE_SE   MADERA_INMODE_SE
+                MADERA_INMODE_SE   MADERA_INMODE_SE
+                MADERA_INMODE_DIFF MADERA_INMODE_DIFF
+            >;
+            cirrus,max-channels-clocked = <2 0 0>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinsettings>;
+
+            pinsettings: pin-settings {
+                aif1-pins {
+                    groups = "aif1";
+                    function = "aif1";
+                    bias-bus-hold;
+                };
+
+                aif2-pins {
+                    groups = "aif2";
+                    function = "aif2";
+                    bias-bus-hold;
+                };
+
+                aif3-pins {
+                    groups = "aif3";
+                    function = "aif3";
+                    bias-bus-hold;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
deleted file mode 100644
index 47e2b8bc60519..0000000000000
--- a/Documentation/devicetree/bindings/mfd/madera.txt
+++ /dev/null
@@ -1,114 +0,0 @@
-Cirrus Logic Madera class audio codecs Multi-Functional Device
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-See also the child driver bindings in:
-bindings/pinctrl/cirrus,madera-pinctrl.txt
-bindings/regulator/arizona-regulator.txt
-bindings/sound/madera.txt
-
-Required properties:
-
-  - compatible : One of the following chip-specific strings:
-        "cirrus,cs47l15"
-        "cirrus,cs47l35"
-        "cirrus,cs47l85"
-        "cirrus,cs47l90"
-        "cirrus,cs47l91"
-        "cirrus,cs42l92"
-        "cirrus,cs47l92"
-        "cirrus,cs47l93"
-        "cirrus,wm1840"
-
-  - reg : I2C slave address when connected using I2C, chip select number when
-    using SPI.
-
-  - DCVDD-supply : Power supply for the device as defined in
-    bindings/regulator/regulator.txt
-    Mandatory on CS47L15, CS47L35, CS47L90, CS47L91, CS42L92, CS47L92, CS47L93
-    Optional on CS47L85, WM1840
-
-  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
-    Power supplies for the device
-
-  - DBVDD3-supply, DBVDD4-supply : Power supplies for the device
-    (CS47L85, CS47L90, CS47L91, WM1840)
-
-  - SPKVDDL-supply, SPKVDDR-supply : Power supplies for the device
-    (CS47L85, WM1840)
-
-  - SPKVDD-supply : Power supply for the device
-    (CS47L15, CS47L35)
-
-  - interrupt-controller : Indicates that this device is an interrupt controller
-
-  - #interrupt-cells: the number of cells to describe an IRQ, must be 2.
-    The first cell is the IRQ number.
-    The second cell is the flags, encoded as the trigger masks from
-    bindings/interrupt-controller/interrupts.txt
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-
-  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
-    is reserved for future use and must be zero
-
-  - interrupt-parent : The parent interrupt controller.
-
-  - interrupts : The interrupt line the /IRQ signal for the device is
-    connected to.
-
-Optional properties:
-
-  - MICVDD-supply : Power supply, only need to be specified if
-    powered externally
-
-  - reset-gpios : One entry specifying the GPIO controlling /RESET.
-    As defined in bindings/gpio.txt.
-    Although optional, it is strongly recommended to use a hardware reset
-
-  - clocks: Should reference the clocks supplied on MCLK1, MCLK2 and MCLK3
-  - clock-names: May contain up to three strings:
-      "mclk1" for the clock supplied on MCLK1, recommended to be a high
-      quality audio reference clock
-      "mclk2" for the clock supplied on MCLK2, required to be an always on
-      32k clock
-      "mclk3" for the clock supplied on MCLK3
-
-  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
-    Documentation/devicetree/bindings/regulator/regulator.txt.
-    One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
-    (all codecs)
-
-    One for each output pin (MICBIAS1A, MIBCIAS1B, MICBIAS2A, ...)
-    (all except CS47L85, WM1840)
-
-    The following following additional property is supported for the generator
-    nodes:
-      - cirrus,ext-cap : Set to 1 if the MICBIAS has external decoupling
-        capacitors attached.
-
-Optional child nodes:
-    micvdd : Node containing initialization data for the micvdd regulator
-    See bindings/regulator/arizona-regulator.txt
-
-    ldo1 : Node containing initialization data for the LDO1 regulator
-    See bindings/regulator/arizona-regulator.txt
-    (cs47l85, wm1840)
-
-Example:
-
-cs47l85@0 {
-	compatible = "cirrus,cs47l85";
-	reg = <0>;
-
-	reset-gpios = <&gpio 0>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	interrupts = <&host_irq1>;
-	interrupt-parent = <&gic>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 92a96cc0ea734..82fb3a4cd81bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4086,9 +4086,9 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
-F:	Documentation/devicetree/bindings/mfd/madera.txt
-F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
-F:	Documentation/devicetree/bindings/sound/madera.txt
+F:	Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
+F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/cs47l*
-- 
2.11.0

