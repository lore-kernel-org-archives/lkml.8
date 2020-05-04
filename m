Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD02C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F002063A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bBwFeNbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgEDPs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:48:26 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:23708 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729119AbgEDPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:48:25 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044FfANq013282;
        Mon, 4 May 2020 10:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=2653QIWdmqGpjyB9LNnnjexzZnZ/KmCOM+XRdySJZsM=;
 b=bBwFeNbzfa/69DBJ2Vey2x1cEBnCRAqK8vWMLlmGVN5WnhP1BnJf4a0jnmjF1ZTMiisu
 lGDBb8A9zTT6NVWTEjvirsozzz6gUCCX129MxhnQCH99KmgxfZm94E54OQZsOy5fShLg
 qMFVbJwMDWioNA3Pv1UC0h3DZBGUdrm53AyYxddEi98GtjtmouFydj5TvMyLysGD2Rmz
 Dzk7XaXRd+uCxgPjWREui9Z2/uHpFZFRITZm1N72vaxywIPN/NLiYS/PJwvxb4iu6gUo
 8eRxDnd9YZ2Rq1vofxEiAeomJ3frbLwK9wyRnABNiWTkGnwX4mBQAjWWCzUfixhw6RAd cA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30s59pkefj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 10:47:58 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 16:47:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 May 2020 16:47:57 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 290062C5;
        Mon,  4 May 2020 15:47:57 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/5] hwmon: lochnagar: Move binding over to dtschema
Date:   Mon, 4 May 2020 16:47:53 +0100
Message-ID: <20200504154757.17519-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
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

Thanks,
Charles

 .../devicetree/bindings/hwmon/cirrus,lochnagar.txt | 26 ----------------
 .../bindings/hwmon/cirrus,lochnagar.yaml           | 35 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 26 deletions(-)
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
index 0000000000000..cc00b97a7dace
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
@@ -0,0 +1,35 @@
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
+  compatible:
+    enum:
+      - cirrus,lochnagar2-hwmon
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.11.0

