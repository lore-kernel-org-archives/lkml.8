Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D18C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8CC20575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P+K2XDRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgEMJ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:57:34 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38470 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388468AbgEMJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:57:29 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9u0Lf020735;
        Wed, 13 May 2020 04:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=CmbsIiYf5Qkf3NovBpTi5+qziK13VA5wNYGFm8LfSqw=;
 b=P+K2XDRrXE1kgkICSKWj/z7peHqd6jL/VXl/2u3I+N0XYYFKkLi615YDvgsXxp2HEiej
 zLOXOZcTbYpgmvaYOhZ/An0m6Po2vxz4BOaZVoU+pEKic6QpSjvyW7CkuUAMDGklQWil
 ae3RUa4VnMwOg60onKUXY4XukuCB5rtSJgAAvsDXtKHyRfYGZnT5AZUwRXYsYjAlPTMF
 Ag0ezCcxQhJarvUGdIN5+9w1OWb9iUZxZkXtMxL3oBQllzwovtJBhwRKUhy3xg3TFisN
 5PP57htdZbdh17M8ivTZeZPBWvjGss5MMy8SSxUyzjSX2bAjS3BvBjn7/ywKXDN3s/Yc gw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3100xes5n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 04:57:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 10:57:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 10:57:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 26FBB448;
        Wed, 13 May 2020 09:57:21 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 2/7] extcon: arizona: Move binding over to dtschema
Date:   Wed, 13 May 2020 10:57:15 +0100
Message-ID: <20200513095720.8867-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
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

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 -------------
 .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 +++++++++++++++++++++
 2 files changed, 125 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
deleted file mode 100644
index 208daaff0be4f..0000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-Cirrus Logic Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-This document lists Extcon specific bindings, see the primary binding document:
-  ../mfd/arizona.txt
-
-Optional properties:
-
-  - wlf,hpdet-channel : Headphone detection channel.
-    ARIZONA_ACCDET_MODE_HPL or 1 - Headphone detect mode is set to HPDETL
-    ARIZONA_ACCDET_MODE_HPR or 2 - Headphone detect mode is set to HPDETR
-    If this node is not mentioned or if the value is unknown, then
-    headphone detection mode is set to HPDETL.
-
-  - wlf,use-jd2 : Use the additional JD input along with JD1 for dual pin jack
-    detection.
-  - wlf,use-jd2-nopull : Internal pull on JD2 is disabled when used for
-    jack detection.
-  - wlf,jd-invert : Invert the polarity of the jack detection switch
-
-  - wlf,micd-software-compare : Use a software comparison to determine mic
-    presence
-  - wlf,micd-detect-debounce : Additional software microphone detection
-    debounce specified in milliseconds.
-  - wlf,micd-pol-gpio : GPIO specifier for the GPIO controlling the headset
-    polarity if one exists.
-  - wlf,micd-bias-start-time : Time allowed for MICBIAS to startup prior to
-    performing microphone detection, specified as per the ARIZONA_MICD_TIME_XXX
-    defines.
-  - wlf,micd-rate : Delay between successive microphone detection measurements,
-    specified as per the ARIZONA_MICD_TIME_XXX defines.
-  - wlf,micd-dbtime : Microphone detection hardware debounces specified as the
-    number of measurements to take, valid values being 2 and 4.
-  - wlf,micd-timeout-ms : Timeout for microphone detection, specified in
-    milliseconds.
-  - wlf,micd-force-micbias : Force MICBIAS continuously on during microphone
-    detection.
-  - wlf,micd-configs : Headset polarity configurations (generally used for
-    detection of CTIA / OMTP headsets), the field can be of variable length
-    but should always be a multiple of 3 cells long, each three cell group
-    represents one polarity configuration.
-    The first cell defines the accessory detection pin, zero will use MICDET1
-    and all other values will use MICDET2.
-    The second cell represents the MICBIAS to be used.
-    The third cell represents the value of the micd-pol-gpio pin.
-
-  - wlf,gpsw : Settings for the general purpose switch, set as one of the
-    ARIZONA_GPSW_XXX defines.
-
-Example:
-
-codec: wm8280@0 {
-	compatible = "wlf,wm8280";
-	reg = <0>;
-	...
-
-	wlf,use-jd2;
-	wlf,use-jd2-nopull;
-	wlf,jd-invert;
-
-	wlf,micd-software-compare;
-	wlf,micd-detect-debounce = <0>;
-	wlf,micd-pol-gpio = <&codec 2 0>;
-	wlf,micd-rate = <ARIZONA_MICD_TIME_8MS>;
-	wlf,micd-dbtime = <4>;
-	wlf,micd-timeout-ms = <100>;
-	wlf,micd-force-micbias;
-	wlf,micd-configs = <
-		0 1 0 /* MICDET1 MICBIAS1 GPIO=low */
-		1 2 1 /* MICDET2 MICBIAS2 GPIO=high */
-	>;
-
-	wlf,gpsw = <ARIZONA_GPSW_OPEN>;
-};
diff --git a/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
new file mode 100644
index 0000000000000..f9845dc2f5ae5
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a
+  range of analogue I/O.
+
+  This document lists Extcon specific bindings, see the primary binding
+  document ../mfd/arizona.yaml
+
+properties:
+  wlf,hpdet-channel:
+    description:
+      Headphone detection channel.  ARIZONA_ACCDET_MODE_HPL/1 sets the
+      headphone detect mode to HPDETL, ARIZONA_ACCDET_MODE_HPR/2 sets it
+      to HPDETR.  If this node is not included or if the value is unknown,
+      then headphone detection mode is set to HPDETL.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 2
+
+  wlf,use-jd2:
+    description:
+      Use the additional JD input along with JD1 for dual pin jack detection.
+    type: boolean
+
+  wlf,use-jd2-nopull:
+    description:
+      Internal pull on JD2 is disabled when used for jack detection.
+    type: boolean
+
+  wlf,jd-invert:
+    description:
+      Invert the polarity of the jack detection switch.
+    type: boolean
+
+  wlf,micd-software-compare:
+    description:
+      Use a software comparison to determine mic presence.
+    type: boolean
+
+  wlf,micd-detect-debounce:
+    description:
+      Additional software microphone detection debounce specified in
+      milliseconds.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  wlf,micd-pol-gpio:
+    description:
+      GPIO specifier for the GPIO controlling the headset polarity if one
+      exists.
+    maxItems: 1
+
+  wlf,micd-bias-start-time:
+    description:
+      Time allowed for MICBIAS to startup prior to performing microphone
+      detection, specified as per the ARIZONA_MICD_TIME_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 12
+
+  wlf,micd-rate:
+    description:
+      Delay between successive microphone detection measurements, specified
+      as per the ARIZONA_MICD_TIME_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 12
+
+  wlf,micd-dbtime:
+    description:
+      Microphone detection hardware debounces specified as the number of
+      measurements to take.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [2, 4]
+
+  wlf,micd-timeout-ms:
+    description:
+      Timeout for microphone detection, specified in milliseconds.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  wlf,micd-force-micbias:
+    description:
+      Force MICBIAS continuously on during microphone detection.
+    type: boolean
+
+  wlf,micd-configs:
+    description:
+      Headset polarity configurations (generally used for detection of
+      CTIA / OMTP headsets), the field can be of variable length but
+      should always be a multiple of 3 cells long, each three cell group
+      represents one polarity configuration.
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+    items:
+      items:
+        - description:
+            The first cell defines the accessory detection pin, zero
+            will use MICDET1 and 0x2000 will use MICDET2.
+          enum: [ 0, 0x2000 ]
+        - description:
+            The second cell represents the MICBIAS to be used. Zero
+            will use MICVDD, 1-3 will use MICBIASx.
+          minimum: 0
+          maximum: 3
+        - description:
+            The third cell represents the value of the micd-pol-gpio
+            pin.
+          minimum: 0
+          maximum: 1
+
+  wlf,gpsw:
+    description:
+      Settings for the general purpose switch, set as one of the
+      ARIZONA_GPSW_XXX defines.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 3
-- 
2.11.0

