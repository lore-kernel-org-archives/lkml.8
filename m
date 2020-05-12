Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6CC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4380206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="L+T/oTmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgELPYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:24:24 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37482 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbgELPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:24:23 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CFIae5000767;
        Tue, 12 May 2020 10:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=R876TaLuvENQfw7hHUL+esaIQkLeVGHIvM+NnGt1qYA=;
 b=L+T/oTmtcFmxnBm55LBFKRJ3rNQ4DslhVm+bzcWnJljMTbwFq/DKFaBGeM/4Xkfx51LD
 AneDe0WSmjpiKeHMw9nRs5FVOtXjQZAACgjW65k+INEXhmbl/lJlSAlahwgu21OSkKez
 YNaGUtAPk+yH+Vv6L/aisigr5oO/i4nbrehGqeo9C7kRKy8BcJa68fwgnqRute3LxX5q
 BQV1trPXCcsv64JJ0TJHYbLn65b8d69lpp3C3odb64uQA9hfWhY2yc8mxG9SdntLJfWc
 23GX+av74qxkVD5q1lSs3/cEgoGwEpGMUu/3+n6iFvkwzHyv8bUV7DqnjLeMrDcaNoVv ww== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30wsx3msj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 10:24:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 16:23:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 12 May 2020 16:23:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 296982C8;
        Tue, 12 May 2020 15:23:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: lochnagar: Move binding over to dtschema
Date:   Tue, 12 May 2020 16:23:55 +0100
Message-ID: <20200512152359.11839-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 .../devicetree/bindings/sound/cirrus,lochnagar.txt | 39 ----------------
 .../bindings/sound/cirrus,lochnagar.yaml           | 52 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 39 deletions(-)
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
index 0000000000000..cea612d3d4a7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
@@ -0,0 +1,52 @@
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
+  compatible:
+    enum:
+      - cirrus,lochnagar2-soundcard
+
+  '#sound-dai-cells':
+    description:
+      The first cell indicating the audio interface.
+    const: 1
+
+  clocks:
+    description:
+      Master clock source for the sound card, should normally be set to
+      LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar clock driver.
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
-- 
2.11.0

