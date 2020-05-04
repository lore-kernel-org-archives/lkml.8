Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E005C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B97920721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gxy2corp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgEDPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:48:33 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:5126 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgEDPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:48:28 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044Ff8hb013274;
        Mon, 4 May 2020 10:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=ruwAi4Ms1nGm6/1I9eyZuVf0rt1TFOg18937TCXIFik=;
 b=Gxy2corpWlcVGIE/8DYJTOrBK9l3fE5jJyODBa6EMOc09DDsPt5H3N+2GhVew4U5Mfxn
 TwmMSA9BFsWCCIDSgYRJc1grEdcnlCxpBbDHO7uS4urf3PeADBtu9SSQUINE9+J3cCUL
 MFmL5/i7GoGQu4B/HkAZdetLj+TusUf3s/ErLhvSaW1hmizV2zon68EkfrbyiRdDxAeY
 ZIutsGe7/eCnAKzz/ZeTgFVFtzDzdqsSN7txvqE59Qba9qgi2h/q5xVzM+KQG/F8bQEm
 QljjLtT+f0tt7hIk/fBXlHk9/44TCHg7uPP4xGrMWDcJGJB7aUJ5ZtMpZazyVg8hI1va Uw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pkefk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 10:47:58 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 16:47:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 May 2020 16:47:57 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 426372C6;
        Mon,  4 May 2020 15:47:57 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/5] pinctrl: lochnagar: Move binding over to dtschema
Date:   Mon, 4 May 2020 16:47:55 +0100
Message-ID: <20200504154757.17519-3-ckeepax@opensource.cirrus.com>
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
 - Moved sub-node into MFD file leaving just the properties in here
 - Removed contains on the compatible
 - Added a required -pins suffix for pinmux/ctrl nodes
 - Added some extra blank lines for readability

Thanks,
Charles

 .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 ---------------
 .../bindings/pinctrl/cirrus,lochnagar.yaml         | 191 +++++++++++++++++++++
 2 files changed, 191 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
deleted file mode 100644
index a87447180e838..0000000000000
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,141 +0,0 @@
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
-This binding document describes the binding for the pinctrl portion
-of the driver.
-
-Also see these documents for generic binding information:
-  [1] GPIO : ../gpio/gpio.txt
-  [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
-
-And these for relevant defines:
-  [3] include/dt-bindings/pinctrl/lochnagar.h
-
-This binding must be part of the Lochnagar MFD binding:
-  [4] ../mfd/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar-pinctrl"
-
-  - gpio-controller : Indicates this device is a GPIO controller.
-  - #gpio-cells : Must be 2. The first cell is the pin number, see
-    [3] for available pins and the second cell is used to specify
-    optional parameters, see [1].
-  - gpio-ranges : Range of pins managed by the GPIO controller, see
-    [1]. Both the GPIO and Pinctrl base should be set to zero and the
-    count to the appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define,
-    see [3].
-
-  - pinctrl-names : A pinctrl state named "default" must be defined.
-  - pinctrl-0 : A phandle to the default pinctrl state.
-
-Required sub-nodes:
-
-The pin configurations are defined as a child of the pinctrl states
-node, see [2]. Each sub-node can have the following properties:
-  - groups : A list of groups to select (either this or "pins" must be
-    specified), available groups:
-      codec-aif1, codec-aif2, codec-aif3, dsp-aif1, dsp-aif2, psia1,
-      psia2, gf-aif1, gf-aif2, gf-aif3, gf-aif4, spdif-aif, usb-aif1,
-      usb-aif2, adat-aif, soundcard-aif
-  - pins : A list of pin names to select (either this or "groups" must
-    be specified), available pins:
-      fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4, fpga-gpio5,
-      fpga-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
-      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
-      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
-      gf-gpio3, gf-gpio7, codec-aif1-bclk, codec-aif1-rxdat,
-      codec-aif1-lrclk, codec-aif1-txdat, codec-aif2-bclk,
-      codec-aif2-rxdat, codec-aif2-lrclk, codec-aif2-txdat,
-      codec-aif3-bclk, codec-aif3-rxdat, codec-aif3-lrclk,
-      codec-aif3-txdat, dsp-aif1-bclk, dsp-aif1-rxdat, dsp-aif1-lrclk,
-      dsp-aif1-txdat, dsp-aif2-bclk, dsp-aif2-rxdat,
-      dsp-aif2-lrclk, dsp-aif2-txdat, psia1-bclk, psia1-rxdat,
-      psia1-lrclk, psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
-      psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat, gf-aif3-lrclk,
-      gf-aif3-txdat, gf-aif4-bclk, gf-aif4-rxdat, gf-aif4-lrclk,
-      gf-aif4-txdat, gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
-      gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat, gf-aif2-lrclk,
-      gf-aif2-txdat, dsp-uart1-rx, dsp-uart1-tx, dsp-uart2-rx,
-      dsp-uart2-tx, gf-uart2-rx, gf-uart2-tx, usb-uart-rx,
-      codec-pdmclk1, codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
-      codec-dmicclk1, codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
-      codec-dmicclk3, codec-dmicdat3, codec-dmicclk4, codec-dmicdat4,
-      dsp-dmicclk1, dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
-      i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, dsp-standby,
-      codec-mclk1, codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
-      gf-gpio1, gf-gpio5, dsp-gpio20, led1, led2
-  - function : The mux function to select, available functions:
-      aif, fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4, fpga-gpio5,
-      fpga-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
-      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
-      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
-      gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5, dsp-gpio20, codec-clkout,
-      dsp-clkout, pmic-32k, spdif-clkout, clk-12m288, clk-11m2986,
-      clk-24m576, clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
-      gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1, codec-mclk2,
-      dsp-clkin, psia1-mclk, psia2-mclk, spdif-mclk, codec-irq,
-      codec-reset, dsp-reset, dsp-irq, dsp-standby, codec-pdmclk1,
-      codec-pdmdat1, codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
-      codec-dmicdat1, codec-dmicclk2, codec-dmicdat2, codec-dmicclk3,
-      codec-dmicdat3, codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
-      dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
-      dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx, gf-uart2-rx,
-      gf-uart2-tx, usb-uart-rx, usb-uart-tx, i2c2-scl, i2c2-sda,
-      i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, spdif-aif, psia1,
-      psia1-bclk, psia1-lrclk, psia1-rxdat, psia1-txdat, psia2,
-      psia2-bclk, psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
-      codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
-      codec-aif1-txdat, codec-aif2, codec-aif2-bclk, codec-aif2-lrclk,
-      codec-aif2-rxdat, codec-aif2-txdat, codec-aif3, codec-aif3-bclk,
-      codec-aif3-lrclk, codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
-      dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat, dsp-aif1-txdat,
-      dsp-aif2, dsp-aif2-bclk, dsp-aif2-lrclk, dsp-aif2-rxdat,
-      dsp-aif2-txdat, gf-aif3, gf-aif3-bclk, gf-aif3-lrclk,
-      gf-aif3-rxdat, gf-aif3-txdat, gf-aif4, gf-aif4-bclk,
-      gf-aif4-lrclk, gf-aif4-rxdat, gf-aif4-txdat, gf-aif1,
-      gf-aif1-bclk, gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat,
-      gf-aif2, gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
-      gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif, soundcard-aif,
-
-  - output-enable : Specifies that an AIF group will be used as a master
-    interface (either this or input-enable is required if a group is
-    being muxed to an AIF)
-  - input-enable : Specifies that an AIF group will be used as a slave
-    interface (either this or output-enable is required if a group is
-    being muxed to an AIF)
-
-Example:
-
-lochnagar-pinctrl {
-	compatible = "cirrus,lochnagar-pinctrl";
-
-	gpio-controller;
-	#gpio-cells = <2>;
-	gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pin-settings>;
-
-	pin-settings: pin-settings {
-		ap-aif {
-			input-enable;
-			groups = "gf-aif1";
-			function = "codec-aif3";
-		};
-		codec-aif {
-			output-enable;
-			groups = "codec-aif3";
-			function = "gf-aif1";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..2d6f832f1e4c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,lochnagar.yaml#
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
+  Logic devices on mini-cards, as well as allowing connection of various
+  application processor systems to provide a full evaluation platform.
+  Audio system topology, clocking and power can all be controlled through
+  the Lochnagar, allowing the device under test to be used in a variety of
+  possible use cases.
+
+  This binding document describes the binding for the pinctrl portion of
+  the driver.
+
+  Also see these documents for generic binding information:
+    [1] GPIO : ../gpio/gpio.txt
+    [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
+
+  And these for relevant defines:
+    [3] include/dt-bindings/pinctrl/lochnagar.h
+
+  This binding must be part of the Lochnagar MFD binding:
+    [4] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  compatible:
+    enum:
+      - cirrus,lochnagar-pinctrl
+
+  gpio-controller:
+    description:
+      Indicates this device is a GPIO controller.
+
+  '#gpio-cells':
+    description:
+      The first cell is the pin number and the second cell is used
+      to specify optional parameters.
+    const: 2
+
+  gpio-ranges:
+    description:
+      Range of pins managed by the GPIO controller, see [1]. Both the
+      GPIO and Pinctrl base should be set to zero and the count to the
+      appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define, see [3].
+    maxItems: 1
+
+  pinctrl-0:
+    description:
+      A phandle to the default pinctrl state.
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+patternProperties:
+  '^.*$':
+    patternProperties:
+      '^.*-pins$':
+        description:
+          The pin configurations are defined as a child of the pinctrl
+          states node, see [2]. Each sub-node can have the following
+          properties.
+        type: object
+        allOf:
+          - $ref: pincfg-node.yaml#
+          - $ref: pinmux-node.yaml#
+
+        properties:
+          groups:
+            description:
+              A list of groups to select (either this or "pins" must be
+              specified), available groups.
+            enum: [ codec-aif1, codec-aif2, codec-aif3, dsp-aif1,
+                    dsp-aif2, psia1, psia2, gf-aif1, gf-aif2, gf-aif3,
+                    gf-aif4, spdif-aif, usb-aif1, usb-aif2, adat-aif,
+                    soundcard-aif ]
+
+          pins:
+            description:
+              A list of pin names to select (either this or "groups" must
+              be specified), available pins.
+            enum: [ fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
+                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
+                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
+                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
+                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
+                    gf-gpio2, gf-gpio3, gf-gpio7, codec-aif1-bclk,
+                    codec-aif1-rxdat, codec-aif1-lrclk, codec-aif1-txdat,
+                    codec-aif2-bclk, codec-aif2-rxdat, codec-aif2-lrclk,
+                    codec-aif2-txdat, codec-aif3-bclk, codec-aif3-rxdat,
+                    codec-aif3-lrclk, codec-aif3-txdat, dsp-aif1-bclk,
+                    dsp-aif1-rxdat, dsp-aif1-lrclk, dsp-aif1-txdat,
+                    dsp-aif2-bclk, dsp-aif2-rxdat, dsp-aif2-lrclk,
+                    dsp-aif2-txdat, psia1-bclk, psia1-rxdat, psia1-lrclk,
+                    psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
+                    psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat,
+                    gf-aif3-lrclk, gf-aif3-txdat, gf-aif4-bclk,
+                    gf-aif4-rxdat, gf-aif4-lrclk, gf-aif4-txdat,
+                    gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
+                    gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat,
+                    gf-aif2-lrclk, gf-aif2-txdat, dsp-uart1-rx,
+                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
+                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, codec-pdmclk1,
+                    codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
+                    codec-dmicclk1, codec-dmicdat1, codec-dmicclk2,
+                    codec-dmicdat2, codec-dmicclk3, codec-dmicdat3,
+                    codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
+                    dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
+                    i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda,
+                    dsp-standby, codec-mclk1, codec-mclk2, dsp-clkin,
+                    psia1-mclk, psia2-mclk, gf-gpio1, gf-gpio5,
+                    dsp-gpio20, led1, led2 ]
+
+          function:
+            description:
+              The mux function to select, available functions.
+            enum: [ aif, fpga-gpio1, fpga-gpio2, fpga-gpio3, fpga-gpio4,
+                    fpga-gpio5, fpga-gpio6, codec-gpio1, codec-gpio2,
+                    codec-gpio3, codec-gpio4, codec-gpio5, codec-gpio6,
+                    codec-gpio7, codec-gpio8, dsp-gpio1, dsp-gpio2,
+                    dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6,
+                    gf-gpio2, gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5,
+                    dsp-gpio20, codec-clkout, dsp-clkout, pmic-32k,
+                    spdif-clkout, clk-12m288, clk-11m2986, clk-24m576,
+                    clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
+                    gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1,
+                    codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
+                    spdif-mclk, codec-irq, codec-reset, dsp-reset,
+                    dsp-irq, dsp-standby, codec-pdmclk1, codec-pdmdat1,
+                    codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
+                    codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
+                    codec-dmicclk3, codec-dmicdat3, codec-dmicclk4,
+                    codec-dmicdat4, dsp-dmicclk1, dsp-dmicdat1,
+                    dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
+                    dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx,
+                    gf-uart2-rx, gf-uart2-tx, usb-uart-rx, usb-uart-tx,
+                    i2c2-scl, i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl,
+                    i2c4-sda, spdif-aif, psia1, psia1-bclk, psia1-lrclk,
+                    psia1-rxdat, psia1-txdat, psia2, psia2-bclk,
+                    psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
+                    codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
+                    codec-aif1-txdat, codec-aif2, codec-aif2-bclk,
+                    codec-aif2-lrclk, codec-aif2-rxdat, codec-aif2-txdat,
+                    codec-aif3, codec-aif3-bclk, codec-aif3-lrclk,
+                    codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
+                    dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat,
+                    dsp-aif1-txdat, dsp-aif2, dsp-aif2-bclk,
+                    dsp-aif2-lrclk, dsp-aif2-rxdat, dsp-aif2-txdat,
+                    gf-aif3, gf-aif3-bclk, gf-aif3-lrclk, gf-aif3-rxdat,
+                    gf-aif3-txdat, gf-aif4, gf-aif4-bclk, gf-aif4-lrclk,
+                    gf-aif4-rxdat, gf-aif4-txdat, gf-aif1, gf-aif1-bclk,
+                    gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat, gf-aif2,
+                    gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
+                    gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif,
+                    soundcard-aif ]
+
+          output-enable:
+            description:
+              Specifies that an AIF group will be used as a master
+              interface (either this or input-enable is required if a
+              group is being muxed to an AIF)
+
+          input-enable:
+            description:
+              Specifies that an AIF group will be used as a slave
+              interface (either this or output-enable is required if a
+              group is being muxed to an AIF)
+
+        additionalProperties: false
+        required:
+          - function
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+  - pinctrl-0
+  - pinctrl-names
-- 
2.11.0

