Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C65BC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB46206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oaGyC+qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgD0K2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:28:55 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:31930 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgD0K2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:28:47 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAQxFn029197;
        Mon, 27 Apr 2020 05:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=JmrcVen7kYcAJZ9waAthPqfdugvgxyfvuE98X/vHYE8=;
 b=oaGyC+qqgDfxdvxOTtXwtTcD5Q0irqjN48R3FFSYr+HzbtN0CpoxertEfE+LxX8Rrs7W
 FSL/acrw1Bf39NWpzMK9yHKz37ctJ0sF0HVn5DCYXYlLUHlgJzFZlgYcQ1Num0Nz27W9
 WVFqS5Tm8ZgazM3sFF7ycIgCxy1h4KT/324PeHcOT5zuvBi6GHdkrcaMu+5TfcHpwI5q
 IaMik73QWC/UybCZjhNy/weBjEFDk4kPzts5sTdLBRI64obYnF3AxU2ZPn9QCPIpssRm
 7c8rJvuTRco/ZSplbnwNry6T5r8NT8z1mA7Ztt31pFUN+Jpy5hRWRSuUYhw/KvXEPp3G Wg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30mhmqu0ng-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 05:28:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 11:28:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 27 Apr 2020 11:28:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 784DA2C6;
        Mon, 27 Apr 2020 10:28:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 5/6] clk: lochnagar: Move binding over to dtschema
Date:   Mon, 27 Apr 2020 11:28:11 +0100
Message-ID: <20200427102812.23251-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../devicetree/bindings/clock/cirrus,lochnagar.txt |  94 ---------
 .../bindings/clock/cirrus,lochnagar.yaml           | 220 +++++++++++++++++++++
 2 files changed, 220 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml

diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
deleted file mode 100644
index 52a064c789eec..0000000000000
--- a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,94 +0,0 @@
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
-This binding document describes the binding for the clock portion of
-the driver.
-
-Also see these documents for generic binding information:
-  [1] Clock : ../clock/clock-bindings.txt
-
-And these for relevant defines:
-  [2] include/dt-bindings/clock/lochnagar.h
-
-This binding must be part of the Lochnagar MFD binding:
-  [3] ../mfd/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar1-clk"
-                 "cirrus,lochnagar2-clk"
-
-  - #clock-cells : Must be 1. The first cell indicates the clock
-    number, see [2] for available clocks and [1].
-
-Optional properties:
-
-  - clocks : Must contain an entry for each clock in clock-names.
-  - clock-names : May contain entries for each of the following
-    clocks:
-     - ln-cdc-clkout : Output clock from CODEC card.
-     - ln-dsp-clkout : Output clock from DSP card.
-     - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
-       input audio clocks from host system.
-     - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
-       external connector.
-     - ln-spdif-mclk : Optional input audio clock from SPDIF.
-     - ln-spdif-clkout : Optional input audio clock from SPDIF.
-     - ln-adat-mclk : Optional input audio clock from ADAT.
-     - ln-pmic-32k : On board fixed clock.
-     - ln-clk-12m : On board fixed clock.
-     - ln-clk-11m : On board fixed clock.
-     - ln-clk-24m : On board fixed clock.
-     - ln-clk-22m : On board fixed clock.
-     - ln-clk-8m : On board fixed clock.
-     - ln-usb-clk-24m : On board fixed clock.
-     - ln-usb-clk-12m : On board fixed clock.
-
-  - assigned-clocks : A list of Lochnagar clocks to be reparented, see
-    [2] for available clocks.
-  - assigned-clock-parents : Parents to be assigned to the clocks
-    listed in "assigned-clocks".
-
-Optional nodes:
-
-  - fixed-clock nodes may be registered for the following on board clocks:
-     - ln-pmic-32k : 32768 Hz
-     - ln-clk-12m : 12288000 Hz
-     - ln-clk-11m : 11298600 Hz
-     - ln-clk-24m : 24576000 Hz
-     - ln-clk-22m : 22579200 Hz
-     - ln-clk-8m : 8192000 Hz
-     - ln-usb-clk-24m : 24576000 Hz
-     - ln-usb-clk-12m : 12288000 Hz
-
-Example:
-
-lochnagar {
-	lochnagar-clk {
-		compatible = "cirrus,lochnagar2-clk";
-
-		#clock-cells = <1>;
-
-		clocks = <&clk-audio>, <&clk_pmic>;
-		clock-names = "ln-gf-mclk2", "ln-pmic-32k";
-
-		assigned-clocks = <&lochnagar-clk LOCHNAGAR_CDC_MCLK1>,
-				  <&lochnagar-clk LOCHNAGAR_CDC_MCLK2>;
-		assigned-clock-parents = <&clk-audio>,
-					 <&clk-pmic>;
-	};
-
-	clk-pmic: clk-pmic {
-		compatible = "fixed-clock";
-		clock-cells = <0>;
-		clock-frequency = <32768>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..55d27e4475333
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
@@ -0,0 +1,220 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/cirrus,lochnagar.yaml#
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
+  This binding document describes the binding for the clock portion of the
+  driver.
+
+  Also see these documents for generic binding information:
+    [1] Clock : ../clock/clock-bindings.txt
+
+  And these for relevant defines:
+    [2] include/dt-bindings/clock/lochnagar.h
+
+  This binding must be part of the Lochnagar MFD binding:
+    [3] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  lochnagar-clk:
+    type: object
+
+    properties:
+      compatible:
+        contains:
+          enum:
+            - cirrus,lochnagar1-clk
+            - cirrus,lochnagar2-clk
+
+      '#clock-cells':
+        description:
+          Must be 1. The first cell indicates the clock number, see [2] for
+          available clocks and [1].
+        const: 1
+      clock-names:
+        description: |
+          May contain entries for each of the following clocks:
+           - ln-cdc-clkout : Output clock from CODEC card.
+           - ln-dsp-clkout : Output clock from DSP card.
+           - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
+             input audio clocks from host system.
+           - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
+             external connector.
+           - ln-spdif-mclk : Optional input audio clock from SPDIF.
+           - ln-spdif-clkout : Optional input audio clock from SPDIF.
+           - ln-adat-mclk : Optional input audio clock from ADAT.
+           - ln-pmic-32k : On board fixed clock.
+           - ln-clk-12m : On board fixed clock.
+           - ln-clk-11m : On board fixed clock.
+           - ln-clk-24m : On board fixed clock.
+           - ln-clk-22m : On board fixed clock.
+           - ln-clk-8m : On board fixed clock.
+           - ln-usb-clk-24m : On board fixed clock.
+           - ln-usb-clk-12m : On board fixed clock.
+        items:
+          enum:
+            - ln-cdc-clkout
+            - ln-dsp-clkout
+            - ln-gf-mclk1
+            - ln-gf-mclk2
+            - ln-gf-mclk3
+            - ln-gf-mclk4
+            - ln-psia1-mclk
+            - ln-psia2-mclk
+            - ln-spdif-mclk
+            - ln-spdif-clkout
+            - ln-adat-mclk
+            - ln-pmic-32k
+            - ln-clk-12m
+            - ln-clk-11m
+            - ln-clk-24m
+            - ln-clk-22m
+            - ln-clk-8m
+            - ln-usb-clk-24m
+            - ln-usb-clk-12m
+        minItems: 1
+        maxItems: 19
+      clocks: true
+      assigned-clocks: true
+      assigned-clock-parents: true
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - '#clock-cells'
+
+  lochnagar-pmic32k:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 32768
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-clk12m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 12288000
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-clk11m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 11298600
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-clk24m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 24576000
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-clk22m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 22579200
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-clk8m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 8192000
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-usb24m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 24576000
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
+
+  lochnagar-usb12m:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - fixed-clock
+      '#clock-cells':
+        const: 0
+      clock-frequency:
+        const: 12288000
+    required:
+      - compatible
+      - '#clock-cells'
+      - clock-frequency
-- 
2.11.0

