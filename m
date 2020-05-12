Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E9C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5E1206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hdviXVlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgELPY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:24:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:21244 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730490AbgELPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:24:24 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CFIae6000767;
        Tue, 12 May 2020 10:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=bkgjsNmkiBbiZiJR0ssbt/x+we0l9n828C2NvUEpA48=;
 b=hdviXVlcm3vxwSK0+gbi/yTRW3YmHyw0LFoU3qRDa/hV9AvKdGrGpazhqQhwMHJc/Plg
 yBU7FaadO9bzUFUAPgjPjWMpMyIHrTiPVd75Q6zlUo+h7jJ8oIyHkhm4SR1eb/nj1svu
 fqXNYOg/jN0kSGA4MEVIGiCuHox5N737JrWg88we8dbwJmPUxPBexvFtoBsAY9rsNSvE
 puOCgCPX807/oTip14DCIrnHj9BPVfTZsjtdQCqgYvjok+dNVBbHHXf0Eo08C1il2L84
 5Gjr/VeXdbggU7AzkyepCSPL8n3EX8bu8BVMLUjBsZyX0I3EIaEOpag2OyTURMdOOY9a Xw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30wsx3msj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 10:24:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 16:23:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 12 May 2020 16:23:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F0B62C5;
        Tue, 12 May 2020 15:23:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v3 1/5] hwmon: lochnagar: Move binding over to dtschema
Date:   Tue, 12 May 2020 16:23:54 +0100
Message-ID: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
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

