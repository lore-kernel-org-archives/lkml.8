Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60148C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4074420708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GyijhFtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEFP6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:58:06 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:9878 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEFP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:58:06 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046Fri6V028143;
        Wed, 6 May 2020 10:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=j9THUvlUW3zsmYeCMbeUYGW24rlP4wtLiwSg7tYQauw=;
 b=GyijhFtmroyCx7cYHPb5q7j84DkHQifprLJGW2RwWE9dpmqZlLuHxNhYO9fHc5zyp88B
 BYIkjseCUXWzhOEAO7zQ7iGCG54KXFTOa35OMjlGBCvrdaag3d3IyfxE3IRBKrrE2jHY
 cSZ/65GatxRsgbZgWW1XN61lOkDNFzKS8eYVZaTv+kznaPDvz0bjlyKLoXdex8NeG0EH
 UzQcj91xz9x2e+pbvz/HHoNKbZz/5vPEjfA3Lni9lHdDnx6UxQqnYXDQQjzMAmC0pO+C
 MVy3jw4jVnKIY52adSRrfeGZvXs82ggYIXeeV7aJGjfon38NBDZM/4ZDUqvtLHz/oeUX uw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30s6937h76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 May 2020 10:58:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 16:57:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 6 May 2020 16:57:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0835E2C8;
        Wed,  6 May 2020 15:57:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/7] regulator: arizona-regulator: Move binding over to dtschema
Date:   Wed, 6 May 2020 16:57:52 +0100
Message-ID: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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

