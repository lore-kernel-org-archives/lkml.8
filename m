Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE1C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCAF2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CYlqEbU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgD0K2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:28:39 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55756 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgD0K2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:28:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAQxFk029197;
        Mon, 27 Apr 2020 05:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=bswkb0vBqjnfnIPerQr5lFQiQesi0Mra1AUJgOVIgP0=;
 b=CYlqEbU094rYFSg/ib6uulL/7qTU7dAt/m9jFiyhfFvKgBRKrtp2ZNdn7ZwP2YPU6ssA
 RwpQaD53LaSMnpYmXRrRPp3sJOhaHu/0dYOMkB4BABBZ/KzsC0dEEzM9Td+Yers5JrN6
 lIWRQG3YsGMk550si9lzqkeQszXaOCQNLqFTHdSvH8YRYVQ2nGttfRJMhXNv8z40T0wO
 tWu74ydIPXiCcFnjjZaaMGns9HlCTKFCbI27u2CQoaNgkRtaObdID8oetuQOxwQIJpLr
 ng1PF4xEV8XZGoPa0ZvDmctcLMFschV4lpil9vz3iJGvAUBOCm3Klot0qqeE2n8e4WO0 7Q== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30mhmqu0ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 05:28:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 11:28:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 27 Apr 2020 11:28:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 44777448;
        Mon, 27 Apr 2020 10:28:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/6] ASoC: lochnagar: Move binding over to dtschema
Date:   Mon, 27 Apr 2020 11:28:08 +0100
Message-ID: <20200427102812.23251-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 bulkscore=0
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
 .../devicetree/bindings/sound/cirrus,lochnagar.txt | 39 ---------------
 .../bindings/sound/cirrus,lochnagar.yaml           | 58 ++++++++++++++++++++++
 2 files changed, 58 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml

diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
deleted file mode 100644
index 41ae2699f07a9..0000000000000
--- a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,39 +0,0 @@
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
-This binding document describes the binding for the audio portion
-of the driver.
-
-This binding must be part of the Lochnagar MFD binding:
-  [4] ../mfd/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar2-soundcard"
-
-  - #sound-dai-cells : Must be set to 1.
-
-  - clocks : Contains an entry for each entry in clock-names.
-  - clock-names : Must include the following clocks:
-      "mclk" Master clock source for the sound card, should normally
-      be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar
-      clock driver.
-
-Example:
-
-lochnagar-sc {
-	compatible = "cirrus,lochnagar2-soundcard";
-
-	#sound-dai-cells = <1>;
-
-	clocks = <&lochnagar_clk LOCHNAGAR_SOUNDCARD_MCLK>;
-	clock-names = "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..6a266793ebd16
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,lochnagar.yaml#
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
+  This binding document describes the binding for the audio portion of the
+  driver.
+
+  This binding must be part of the Lochnagar MFD binding:
+    [1] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  lochnagar-sc:
+    type: object
+
+    properties:
+      compatible:
+        contains:
+          enum:
+            - cirrus,lochnagar2-soundcard
+
+      '#sound-dai-cells':
+        description:
+          Must be 1. The first cell indicating the audio interface.
+        const: 1
+
+      clocks:
+        maxItems: 1
+        description:
+          Master clock source for the sound card, should normally be set to
+          LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar clock driver.
+      clock-names:
+        const: mclk
+        description:
+          Must contain the string mclk.
+
+    required:
+      - compatible
+      - '#sound-dai-cells'
+      - clocks
+      - clock-names
+
+    additionalProperties: false
-- 
2.11.0

