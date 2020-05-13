Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B65C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C58205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LmACx2po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbgEMJ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:57:37 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:40674 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387681AbgEMJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:57:29 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9u0Le020735;
        Wed, 13 May 2020 04:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=/pI9QKuy8R4Zc2q/kbN5tWB0nqqUgfWbe2w0CiKGrdc=;
 b=LmACx2poD3Yi3Z6eRZ20ly8hh0WBbkZ0ASHwONscs5M7dyLy9GZPTB8nTW3P2dMeUIBU
 RbQ35khdakixEuRP1AbWOLlXpW7z/+EQuKNoYiLIskHXflw+sFi+z1R5bxl1T7CLMhMB
 /z5fbhU6tFM7oYnewL3nrOviQWvYJnORL/27RWfPI47Nqkb8bgmGOxjPo0A3zQw3rDEy
 C4H8uIZllHhhA8CY4YqpJiCuS1bbRzm0QylYuXBpyzHbTKFbpZqRqmy462Kk/Q18Icbz
 ROp0uIMwvl9CndWyU67Aag4W71e0T24uqcQLF0xoNkkj7LfGt1jg701gvK47B7miMRlS Sw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3100xes5n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 04:57:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 10:57:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 10:57:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1226A2C6;
        Wed, 13 May 2020 09:57:21 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 1/7] regulator: arizona-regulator: Move binding over to dtschema
Date:   Wed, 13 May 2020 10:57:14 +0100
Message-ID: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

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

