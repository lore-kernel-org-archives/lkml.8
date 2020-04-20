Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19274C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3BA20775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="n/OQ8pJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgDTPpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:07 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50250 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgDTPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:44:52 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFcDWr020255;
        Mon, 20 Apr 2020 10:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=qNDX1e9cmLY8++RjUuUsNUnq+t/NLjmrrD3VfGW3Akc=;
 b=n/OQ8pJdNl09gVaLnIEJm0bZb29ac7pzHN3BHlI8a+ckuMZvqSgVO28zs7b1gAqx3dqK
 ZMTktB4XLiAhpgE+J0ExxUnUuUkmf0XvMf+nRhWeTDUqPygM72q1HRAL8B337zzgL3s4
 aLkWS1slbg6uW5+uytGqDucbs92oyuD+2xQf5JV5m7Uyd2GcKHEwbc/Yan2R7PassmhG
 z5RGG9ZAi3xG+6mN1ZhQI3i65pOyj1rmpwgVcZYZzDVwbQQosbXc3iEqok0kr7UOK1Rh
 +FRO81xIwrLpoi5rGgU1VwuWmnfrJd1qsV9jrKaeTzBbsaPawrjSW2/Z95MvwIC7dHsx Ow== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4b9hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 10:44:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 Apr
 2020 16:44:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 Apr 2020 16:44:44 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 914632C6;
        Mon, 20 Apr 2020 15:44:44 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/4] regulator: arizona-regulator: Move binding over to dtschema
Date:   Mon, 20 Apr 2020 16:44:41 +0100
Message-ID: <20200420154444.12332-2-ckeepax@opensource.cirrus.com>
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
 .../bindings/regulator/arizona-regulator.txt       | 18 -----------
 .../devicetree/bindings/regulator/wlf,arizona.yaml | 37 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/arizona-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
deleted file mode 100644
index 69bf41949b01f..0000000000000
--- a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Cirrus Logic Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-This document lists regulator specific bindings, see the primary binding
-document:
-  For Wolfson Microelectronic Arizona codecs: ../mfd/arizona.txt
-  For Cirrus Logic Madera codecs: ../mfd/madera.txt
-
-Optional properties:
-  - wlf,ldoena : GPIO specifier for the GPIO controlling LDOENA
-
-Optional subnodes:
-  - ldo1 : Initial data for the LDO1 regulator, as covered in
-    Documentation/devicetree/bindings/regulator/regulator.txt
-  - micvdd : Initial data for the MICVDD regulator, as covered in
-    Documentation/devicetree/bindings/regulator/regulator.txt
diff --git a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
new file mode 100644
index 0000000000000..a0aea73bf4122
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona/Madera class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a
+  range of analogue I/O.
+
+  This document lists regulator specific bindings, see the primary binding
+  document. For Wolfson Microelectronic Arizona codecs ../mfd/wlf,arizona.yaml
+  and for Cirrus Logic Madera codecs ../mfd/madera.txt
+
+properties:
+  wlf,ldoena:
+    description:
+      GPIO specifier for the GPIO controlling LDOENA.
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    maxItems: 1
+
+  ldo1:
+    description:
+      Initial data for the LDO1 regulator.
+    $ref: "regulator.yaml#"
+    type: object
+
+  micvdd:
+    description:
+      Initial data for the MICVDD regulator.
+    $ref: "regulator.yaml#"
+    type: object
-- 
2.11.0

