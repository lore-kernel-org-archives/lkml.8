Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00704C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C895B20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IdY3ytxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgEDPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:48:30 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:64426 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729092AbgEDPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:48:26 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FfANs013282;
        Mon, 4 May 2020 10:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=SF/y8HTYDTU1UvYYqfCLFnHOTlonfjOBrp2pNqxE518=;
 b=IdY3ytxtuSdXmlui7igfyqjm7IxfGdJtkmFQjpKkwcktc3ffdwn+HtWzarprZzh3Zkr4
 FcxwfoLitxgV5qlcykYjHWaFPuwcfSNJy94ZW2MRb7LQ64bgRxY8i0mT0gVUOU9thlqa
 AhKgOVRrm/PS6qhamw43HEENyLxKUCpdA6YZXOCLg6Y+/jcOGI+85q25KX8F6cznetw0
 iLnSiZQDjUfjSMjT7sfVwFK2I6jKcpFBBAJcCncv99EZue/hV7jPwgcau1Jj9BuZXrmI
 1NM+XmlhjS0m2KuDeLCdyRUOIaEQ4noVrAMvT1ROWd1zrITo0GPbKp/Aut33zdpmEAtf hw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pkefj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 10:47:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 16:47:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 May 2020 16:47:57 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 53B2444A;
        Mon,  4 May 2020 15:47:57 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 4/5] clk: lochnagar: Move binding over to dtschema
Date:   Mon, 4 May 2020 16:47:56 +0100
Message-ID: <20200504154757.17519-4-ckeepax@opensource.cirrus.com>
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
 - Moved sub-nodes into MFD file leaving just the properties in here
 - Removed contains on the compatible
 - Made clock descriptions comments rather than being in the description

Thanks,
Charles

 .../devicetree/bindings/clock/cirrus,lochnagar.txt | 94 ----------------------
 .../bindings/clock/cirrus,lochnagar.yaml           | 78 ++++++++++++++++++
 2 files changed, 78 insertions(+), 94 deletions(-)
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
index 0000000000000..59de125647ecb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
@@ -0,0 +1,78 @@
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
+  compatible:
+    enum:
+      - cirrus,lochnagar1-clk
+      - cirrus,lochnagar2-clk
+
+  '#clock-cells':
+    description:
+      The first cell indicates the clock number, see [2] for available
+      clocks and [1].
+    const: 1
+
+  clock-names:
+    items:
+      enum:
+        - ln-cdc-clkout # Output clock from CODEC card.
+        - ln-dsp-clkout # Output clock from DSP card.
+        - ln-gf-mclk1 # Optional input clock from host system.
+        - ln-gf-mclk2 # Optional input clock from host system.
+        - ln-gf-mclk3 # Optional input clock from host system.
+        - ln-gf-mclk4 # Optional input clock from host system.
+        - ln-psia1-mclk # Optional input clock from external connector.
+        - ln-psia2-mclk # Optional input clock from external connector.
+        - ln-spdif-mclk # Optional input clock from SPDIF.
+        - ln-spdif-clkout # Optional input clock from SPDIF.
+        - ln-adat-mclk # Optional input clock from ADAT.
+        - ln-pmic-32k # On board fixed clock.
+        - ln-clk-12m # On board fixed clock.
+        - ln-clk-11m # On board fixed clock.
+        - ln-clk-24m # On board fixed clock.
+        - ln-clk-22m # On board fixed clock.
+        - ln-clk-8m # On board fixed clock.
+        - ln-usb-clk-24m # On board fixed clock.
+        - ln-usb-clk-12m # On board fixed clock.
+    minItems: 1
+    maxItems: 19
+
+  clocks: true
+  assigned-clocks: true
+  assigned-clock-parents: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#clock-cells'
-- 
2.11.0

