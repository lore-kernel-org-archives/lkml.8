Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D131C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21492206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gLyzr8do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgDTPo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:44:59 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46970 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728555AbgDTPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:44:52 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFc4KX020208;
        Mon, 20 Apr 2020 10:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=lTeej+5k8Ht4ISNxOOdL8NVY+oUng88XYZqwwEhbFCs=;
 b=gLyzr8do7jXUIX2F185VnJz3O8gcxm9uVl2RUktq5qGGJknSYU34Qyz7FIIROmleF5e4
 aw+Vh0bxeBkq3d427RixgSYSMgu7iEZE70gJa76Tq/G/83ltLqbIxieJVSE92w/gWsMM
 YsMNO5w40CwYay2MlIY3ikddAsRQkYuWbQOJKxKvqNzXQA8c9pCoDr2iQmdQ3l+mJXeN
 ONlI5uoBHasYNwGv3XuFnPvAgHhbnPZsGFTjw+X4E1q2a9OE+EoC8EF8VBNzlXYjLD6X
 w3L8HyTYEKhawU9ivylX4Bw1UwHS1WVxhXp5zcRWYeM1IDvYu8nbsxK5AEBkdJ78r45e fQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4b9hp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 10:44:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 Apr
 2020 16:44:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 Apr 2020 16:44:44 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2EF42AB;
        Mon, 20 Apr 2020 15:44:44 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] mfd: arizona: Move binding over to dtschema
Date:   Mon, 20 Apr 2020 16:44:44 +0100
Message-ID: <20200420154444.12332-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200420154444.12332-1-ckeepax@opensource.cirrus.com>
References: <20200420154444.12332-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt  | 101 --------
 .../devicetree/bindings/mfd/wlf,arizona.yaml       | 288 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +-
 3 files changed, 292 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
deleted file mode 100644
index 148ef621a5e5d..0000000000000
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ /dev/null
@@ -1,101 +0,0 @@
-Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-Required properties:
-
-  - compatible : One of the following chip-specific strings:
-        "cirrus,cs47l24"
-        "wlf,wm5102"
-        "wlf,wm5110"
-        "wlf,wm8280"
-        "wlf,wm8997"
-        "wlf,wm8998"
-        "wlf,wm1814"
-        "wlf,wm1831"
-
-  - reg : I2C slave address when connected using I2C, chip select number when
-    using SPI.
-
-  - interrupts : The interrupt line the /IRQ signal for the device is
-    connected to.
-  - interrupt-controller : Arizona class devices contain interrupt controllers
-    and may provide interrupt services to other devices.
-  - #interrupt-cells: the number of cells to describe an IRQ, this should be 2.
-    The first cell is the IRQ number.
-    The second cell is the flags, encoded as the trigger masks from
-    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-  - #gpio-cells : Must be 2. The first cell is the pin number and the
-    second cell is used to specify optional parameters, see ../gpio/gpio.txt
-    for details.
-
-  - AVDD-supply, DBVDD1-supply, CPVDD-supply : Power supplies for the device,
-    as covered in Documentation/devicetree/bindings/regulator/regulator.txt
-
-  - DBVDD2-supply, DBVDD3-supply : Additional databus power supplies (wm5102,
-    wm5110, wm8280, wm8998, wm1814)
-
-  - SPKVDDL-supply, SPKVDDR-supply : Speaker driver power supplies (wm5102,
-    wm5110, wm8280, wm8998, wm1814)
-
-  - SPKVDD-supply : Speaker driver power supply (wm8997)
-
-  - DCVDD-supply : Main power supply (cs47l24, wm1831)
-
-  - MICVDD-supply : Microphone power supply (cs47l24, wm1831)
-
-Optional properties:
-
-  - reset-gpios : GPIO specifier for the GPIO controlling /RESET
-
-  - clocks: Should reference the clocks supplied on MCLK1 and MCLK2
-  - clock-names: Should contains two strings:
-      "mclk1" for the clock supplied on MCLK1, recommended to be a high
-      quality audio reference clock
-      "mclk2" for the clock supplied on MCLK2, recommended to be an always on
-      32k clock
-
-  - wlf,gpio-defaults : A list of GPIO configuration register values. Defines
-    for the appropriate values can found in <dt-bindings/mfd/arizona.txt>. If
-    absent, no configuration of these registers is performed. If any entry has
-    a value that is out of range for a 16 bit register then the chip default
-    will be used. If present exactly five values must be specified.
-
-  - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
-    they are being externally supplied. As covered in
-    Documentation/devicetree/bindings/regulator/regulator.txt
-    (wm5102, wm5110, wm8280, wm8997, wm8998, wm1814)
-
-Deprecated properties:
-
-  - wlf,reset : GPIO specifier for the GPIO controlling /RESET
-
-Also see child specific device properties:
-  Regulator - ../regulator/arizona-regulator.txt
-  Extcon    - ../extcon/extcon-arizona.txt
-  Sound     - ../sound/wlf,arizona.txt
-
-Example:
-
-codec: wm5102@1a {
-	compatible = "wlf,wm5102";
-	reg = <0x1a>;
-	interrupts = <347>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-        interrupt-parent = <&gic>;
-
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	wlf,gpio-defaults = <
-		ARIZONA_GP_FN_TXLRCLK
-		ARIZONA_GP_DEFAULT
-		ARIZONA_GP_DEFAULT
-		ARIZONA_GP_DEFAULT
-		ARIZONA_GP_DEFAULT
-	>;
-};
diff --git a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
new file mode 100644
index 0000000000000..d6032c19db616
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
@@ -0,0 +1,288 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a
+  range of analogue I/O.
+
+allOf:
+  - $ref: /schemas/sound/wlf,arizona.yaml#
+  - $ref: /schemas/regulator/wlf,arizona.yaml#
+  - $ref: /schemas/extcon/wlf,arizona.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cirrus,cs47l24
+              - wlf,wm1831
+    then:
+      required:
+        - DCVDD-supply
+        - MICVDD-supply
+    else:
+      properties:
+        LDOVDD-supply:
+          description:
+            Digital power supply, used internally to generate DCVDD when
+            internally supplied.
+          $ref: /schemas/types.yaml#/definitions/phandle
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - wlf,wm1814
+              - wlf,wm5102
+              - wlf,wm5110
+              - wlf,wm8280
+              - wlf,wm8997
+              - wlf,wm8998
+    then:
+      properties:
+        DBVDD2-supply:
+          description:
+            Databus power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+      required:
+        - DBVDD2-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - wlf,wm1814
+              - wlf,wm5102
+              - wlf,wm5110
+              - wlf,wm8280
+              - wlf,wm8998
+    then:
+      properties:
+        DBVDD3-supply:
+          description:
+            Databus power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+      required:
+        - DBVDD3-supply
+  - if:
+     properties:
+       compatible:
+         contains:
+           enum:
+             - cirrus,cs47l24
+             - wlf,wm1831
+             - wlf,wm8997
+    then:
+      properties:
+        SPKVDD-supply:
+          description:
+            Mono speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+      required:
+        - SPKVDD-supply
+    else:
+      properties:
+        SPKVDDL-supply:
+          description:
+            Left speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+        SPKVDDR-supply:
+          description:
+            Right speaker driver power supply.
+          $ref: /schemas/types.yaml#/definitions/phandle
+      required:
+        - SPKVDDL-supply
+        - SPKVDDR-supply
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs47l24
+      - wlf,wm1814
+      - wlf,wm1831
+      - wlf,wm5102
+      - wlf,wm5110
+      - wlf,wm8280
+      - wlf,wm8997
+      - wlf,wm8998
+
+  reg:
+    description:
+      I2C slave address when connected using I2C, chip select number when
+      using SPI.
+    maxItems: 1
+
+  AVDD-supply:
+    description:
+      Analogue power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+  CPVDD-supply:
+    description:
+      Charge pump power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+  DBVDD1-supply:
+    description:
+      Databus power supply.
+    $ref: /schemas/types.yaml#/definitions/phandle
+  DCVDD-supply:
+    description:
+      Digital power supply, normally supplied internally except on cs47l24,
+      wm1831 where it is mandatory.
+    $ref: /schemas/types.yaml#/definitions/phandle
+  MICVDD-supply:
+    description:
+      Microphone power supply, normally supplied internally except on
+      cs47l24, wm1831 where it is mandatory.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  gpio-controller:
+    description:
+      Indicates this device is a GPIO controller.
+  '#gpio-cells':
+    description:
+      Must be 2. The first cell is the pin number and the second cell
+      is used to specify optional parameters.
+    const: 2
+  wlf,gpio-defaults:
+    description:
+      A list of GPIO configuration register values. Defines for the
+      appropriate values can found in dt-bindings/mfd/arizona.h. If
+      absent, no configuration of these registers is performed. If any
+      entry has a value that is out of range for a 16 bit register then the
+      chip default will be used. If present exactly five values must be
+      specified.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    minItems: 1
+    maxItems: 5
+
+  interrupt-controller:
+    description:
+      Arizona class devices contain interrupt controllers and may provide
+      interrupt services to other devices.
+  '#interrupt-cells':
+    description:
+      The number of cells to describe an IRQ, this should
+      be 2.  The first cell is the IRQ number.  The second
+      cell is the flags, encoded as trigger masks.
+    const: 2
+  interrupts:
+    description:
+      The interrupt line the /IRQ signal for the device is connected to.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description:
+      Should reference the clocks supplied on MCLK1 and MCLK2.
+  clock-names:
+    oneOf:
+      - items:
+        - const: mclk1
+      - items:
+        - const: mclk2
+      - items:
+        - const: mclk1
+        - const: mclk2
+    description:
+      Should contains two strings mclk1 for the clock supplied on MCLK1,
+      recommended to be a high quality audio reference clock mclk2 for the
+      clock supplied on MCLK2, recommended to be an always on 32k clock.
+
+  reset-gpios:
+    description:
+      GPIO specifier for the GPIO controlling RESET
+    maxItems: 1
+
+  wlf,reset:
+    description:
+      GPIO specifier for the GPIO controlling RESET
+    deprecated: true
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
+required:
+  - compatible
+  - AVDD-supply
+  - CPVDD-supply
+  - DBVDD1-supply
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/mfd/arizona.h>
+    i2c@e0004000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xe0004000 0x1000>;
+
+        wm5102: codec@1a {
+            compatible = "wlf,wm5102";
+            reg = <0x1a>;
+
+            reset-gpios = <&gpio 0>;
+            wlf,ldoena = <&gpio 1>;
+
+            AVDD-supply = <&vdd1v8>;
+            DBVDD1-supply = <&vdd1v8>;
+            DBVDD2-supply = <&vdd1v8>;
+            DBVDD3-supply = <&vdd1v8>;
+            CPVDD-supply = <&vdd1v8>;
+            LDOVDD-supply = <&vdd1v8>;
+            SPKVDDL-supply = <&vdd5v>;
+            SPKVDDR-supply = <&vdd5v>;
+
+            interrupts = <347>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&gic>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            #sound-dai-cells = <1>;
+
+            wlf,gpio-defaults = <
+                ARIZONA_GP_FN_TXLRCLK
+                ARIZONA_GP_DEFAULT
+                ARIZONA_GP_DEFAULT
+                ARIZONA_GP_DEFAULT
+                ARIZONA_GP_DEFAULT
+            >;
+
+            clocks = <&clks 0>, <&clks 1>;
+            clock-names = "mclk1", "mclk2";
+
+            wlf,inmode = <ARIZONA_INMODE_DIFF ARIZONA_INMODE_DMIC>;
+            wlf,dmic-ref = <ARIZONA_DMIC_MICBIAS1 ARIZONA_DMIC_MICBIAS3>;
+
+            wlf,use-jd2;
+            wlf,use-jd2-nopull;
+            wlf,jd-invert;
+
+            wlf,micd-software-compare;
+            wlf,micd-detect-debounce = <0>;
+            wlf,micd-pol-gpio = <&codec 2 0>;
+            wlf,micd-rate = <ARIZONA_MICD_TIME_8MS>;
+            wlf,micd-dbtime = <4>;
+            wlf,micd-timeout-ms = <100>;
+            wlf,micd-force-micbias;
+            wlf,micd-configs = <0 ARIZONA_DMIC_MICBIAS1 0>,
+                               <0x2000 ARIZONA_DMIC_MICBIAS2 1>;
+
+            wlf,gpsw = <ARIZONA_GPSW_OPEN>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db314976..007faa486c985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18258,11 +18258,11 @@ L:	patches@opensource.cirrus.com
 S:	Supported
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 T:	git https://github.com/CirrusLogic/linux-drivers.git
-F:	Documentation/devicetree/bindings/extcon/extcon-arizona.txt
-F:	Documentation/devicetree/bindings/mfd/arizona.txt
+F:	Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
+F:	Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
 F:	Documentation/devicetree/bindings/mfd/wm831x.txt
-F:	Documentation/devicetree/bindings/regulator/arizona-regulator.txt
-F:	Documentation/devicetree/bindings/sound/wlf,arizona.txt
+F:	Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
+F:	Documentation/devicetree/bindings/sound/wlf,arizona.yaml
 F:	Documentation/hwmon/wm83??.rst
 F:	arch/arm/mach-s3c64xx/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
-- 
2.11.0

