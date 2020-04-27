Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D75C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2414206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RS2jj00z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgD0K2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:28:47 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:20764 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727015AbgD0K2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:28:45 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAQxFl029197;
        Mon, 27 Apr 2020 05:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=9QwdPHrjB8s6Odgewvc3jqvQAhfcLlard78LWLHs09s=;
 b=RS2jj00zCwgpqCjhUTG1H+pwUfP4TQZm/WyiYYONXlyMk7voQALICRMaHlRrwc87WOXb
 UQsnLH/LQaFHJ9SgxqwhZs46eKdbqF/gQJ9rMWXYFyu56cVIXzn3vqH0KZEP88TGUgpv
 +w15QwXdsex726c7ijHutNXExsvXCQgAkDGZYJ4YlMOh5AHvnraqXq4PrI94UhSq5VI7
 OEQtso+17aidDq2Hju/AA4JxdOIHfB8sHh62E/x2ImEjxuig/fdDY6uaWeXy+CdG0c2G
 uuJC06SAUd77m87thV75n7Zr3r6WH5OUWC87WgvIg7uKke1RnCjsKAHITdo7Fb2FCYkW dw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30mhmqu0ng-2
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3383B2C6;
        Mon, 27 Apr 2020 10:28:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/6] hwmon: lochnagar: Move binding over to dtschema
Date:   Mon, 27 Apr 2020 11:28:07 +0100
Message-ID: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
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
 .../devicetree/bindings/hwmon/cirrus,lochnagar.txt | 26 --------------
 .../bindings/hwmon/cirrus,lochnagar.yaml           | 40 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
deleted file mode 100644
index ffb79ccf51ee3..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
+++ /dev/null
@@ -1,26 +0,0 @@
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
-This binding document describes the binding for the hardware monitor
-portion of the driver.
-
-This binding must be part of the Lochnagar MFD binding:
-  [4] ../mfd/cirrus,lochnagar.txt
-
-Required properties:
-
-  - compatible : One of the following strings:
-                 "cirrus,lochnagar2-hwmon"
-
-Example:
-
-lochnagar-hwmon {
-	compatible = "cirrus,lochnagar2-hwmon";
-};
diff --git a/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
new file mode 100644
index 0000000000000..db3e20319714c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/cirrus,lochnagar.yaml#
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
+  This binding document describes the binding for the hardware monitor
+  portion of the driver.
+
+  This binding must be part of the Lochnagar MFD binding:
+    [1] ../mfd/cirrus,lochnagar.yaml
+
+properties:
+  lochnagar-hwmon:
+    type: object
+
+    properties:
+      compatible:
+        contains:
+          enum:
+            - cirrus,lochnagar2-hwmon
+
+    required:
+      - compatible
+
+    additionalProperties: false
-- 
2.11.0

