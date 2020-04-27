Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40806C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119552064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QcFqyD9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgD0K2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:28:41 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59494 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgD0K2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:28:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAQxFm029197;
        Mon, 27 Apr 2020 05:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=PnK6ji+fY5JtW/xhK/84MD4wpuIccwFxrCzAtfnRQls=;
 b=QcFqyD9UAbvyoW6V6Guz6ThozfhwwqnBZx36tXpO6TISB68i+Hm6WXVFJPKR2DUFmdsS
 ZUKAZ9hn+JYlX25yo45BC92dyvA6x/5P7ihII60eDCOBCyA9fKg5Icb1Y44F3TFLXva7
 w0PF+jwzHXieild+9An/wCmP+F9areu+y4+9wkxjPGiUtmP6LMjzCI8vSIBh2ihzy1pl
 cjp+eYVTONfTINQ8yi+VfOIlvhqTOV6FSyKMsu4Kp5gdiXAPYbGGBchkvY3gbSfGhq5/
 xz+vQP4UVbwq5VhfBo0XJUhssR8bH/dAYuiobVIxIOZziK3808ZHfk4Mn7dx3SaqwpXb tg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30mhmqu0ng-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 05:28:14 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 11:28:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 27 Apr 2020 11:28:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 67C1D44A;
        Mon, 27 Apr 2020 10:28:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/6] regulator: lochnagar: Move binding over to dtschema
Date:   Mon, 27 Apr 2020 11:28:10 +0100
Message-ID: <20200427102812.23251-4-ckeepax@opensource.cirrus.com>
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
 .../bindings/regulator/cirrus,lochnagar.txt        |  82 -------------
 .../bindings/regulator/cirrus,lochnagar.yaml       | 132 +++++++++++++++++++++
 2 files changed, 132 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.yaml

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
diff --git a/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..49ffa1534050b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/cirrus,lochnagar.yaml#
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
+  This binding document describes the binding for the regulator portion of
+  the driver.
+
+  Also see these documents for generic binding information:
+    [1] Regulator: ../regulator/regulator.yaml
+
+  This binding must be part of the Lochnagar MFD binding:
+    [2] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  VDDCORE:
+    description:
+      Initialisation data for the VDDCORE regulator, which supplies the
+      CODECs digital core if not being provided by an internal regulator.
+    $ref: "regulator.yaml#"
+    type: object
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-vddcore
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
+    $ref: "regulator.yaml#"
+    type: object
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-micvdd
+      SYSVDD-supply:
+        description:
+          Primary power supply for the Lochnagar.
+    required:
+      - compatible
+
+  MIC1VDD:
+    description:
+      Initialisation data for the MIC1VDD supplies.
+    $ref: "regulator.yaml#"
+    type: object
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-mic1vdd
+      cirrus,micbias-input:
+        description:
+          A property selecting which of the CODEC minicard micbias outputs
+          should be used.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 1
+        maximum: 4
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
+    $ref: "regulator.yaml#"
+    type: object
+    properties:
+      compatible:
+        enum:
+          - cirrus,lochnagar2-mic2vdd
+      cirrus,micbias-input:
+        description:
+          A property selecting which of the CODEC minicard micbias outputs
+          should be used.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 1
+        maximum: 4
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
+    $ref: "regulator.yaml#"
+    type: object
+    properties:
+      compatible:
+        enum:
+          - regulator-fixed
+      regulator-min-microvolt:
+        const: 1800000
+      regulator-max-microvolt:
+        const: 1800000
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
-- 
2.11.0

