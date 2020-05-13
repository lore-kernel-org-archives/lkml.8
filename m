Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B9CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5365720575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PUAcPBcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgEMJ5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:57:40 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43858 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388470AbgEMJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:57:30 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D9u0Lj020735;
        Wed, 13 May 2020 04:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=SGOndz/ErrrygWh8rfUv3xwuUpdwePDe7HkD71FD/VA=;
 b=PUAcPBcCdesSj3EsmkzWE3ZYTrYsrfcYRvfvGKR3UP/BAM97xrUIK+r/XoOC3dF+Fy6v
 vmtuIKF/qJtHJF+r3JtX8AhfEdSwHHkpTbLRjvKb6kGTMTjlBE/eIOK5ZmVLmG4f4Beb
 xzqFE3BEL7IRE+Mc5paYWTkfunShRwpkU7VqxAN1C9SUnQ8tYSIc3ju7B/+N90Mk9+9p
 225HH6iUYnO3ABFdeC6E4kM05hYVyWDD1JvxVqEyFfEGBwZv39ynoEyQgEPaUs3Nn1uL
 HJjo+WWY7ycz+mWOS4XzT7MB2n/pgZgJghZqHJJGtL4JCwVOIkzF0eblSIph5qdBf7Ta jg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3100xes5n2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 04:57:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 10:57:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 10:57:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3B46F2C5;
        Wed, 13 May 2020 09:57:21 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 3/7] ASoC: arizona: Move binding over to dtschema
Date:   Wed, 13 May 2020 10:57:16 +0100
Message-ID: <20200513095720.8867-3-ckeepax@opensource.cirrus.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ----------
 .../devicetree/bindings/sound/wlf,arizona.yaml     | 114 +++++++++++++++++++++
 2 files changed, 114 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.yaml

diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.txt b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
deleted file mode 100644
index e172c62dc2dff..0000000000000
--- a/Documentation/devicetree/bindings/sound/wlf,arizona.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Cirrus Logic Arizona class audio SoCs
-
-These devices are audio SoCs with extensive digital capabilities and a range
-of analogue I/O.
-
-This document lists sound specific bindings, see the primary binding
-document:
-  ../mfd/arizona.txt
-
-Optional properties:
-
-  - wlf,inmode : A list of INn_MODE register values, where n is the number
-    of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
-    2 (Digital Microphone). If absent, INn_MODE registers set to 0 by default.
-    If present, values must be specified less than or equal to the number of
-    input signals. If values less than the number of input signals, elements
-    that have not been specified are set to 0 by default. Entries are:
-    <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280, wm8997)
-    <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
-  - wlf,out-mono : A list of boolean values indicating whether each output is
-    mono or stereo. Position within the list indicates the output affected
-    (eg. First entry in the list corresponds to output 1). A non-zero value
-    indicates a mono output. If present, the number of values should be less
-    than or equal to the number of outputs, if less values are supplied the
-    additional outputs will be treated as stereo.
-
-  - wlf,dmic-ref : DMIC reference voltage source for each input, can be
-    selected from either MICVDD or one of the MICBIAS's, defines
-    (ARIZONA_DMIC_xxxx) are provided in <dt-bindings/mfd/arizona.txt>. If
-    present, the number of values should be less than or equal to the
-    number of inputs, unspecified inputs will use the chip default.
-
-  - wlf,max-channels-clocked : The maximum number of channels to be clocked on
-    each AIF, useful for I2S systems with multiple data lines being mastered.
-    Specify one cell for each AIF to be configured, specify zero for AIFs that
-    should be handled normally.
-    If present, number of cells must be less than or equal to the number of
-    AIFs. If less than the number of AIFs, for cells that have not been
-    specified the corresponding AIFs will be treated as default setting.
-
-  - wlf,spk-fmt : PDM speaker data format, must contain 2 cells (OUT5 and OUT6).
-    See the datasheet for values.
-    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
-      wm8998, wm1814)
-
-  - wlf,spk-mute : PDM speaker mute setting, must contain 2 cells (OUT5 and OUT6).
-    See the datasheet for values.
-    The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
-    wm8998, wm1814)
-
-  - wlf,out-volume-limit : The volume limit value that should be applied to each
-    output channel. See the datasheet for exact values. Channels are specified
-    in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.yaml b/Documentation/devicetree/bindings/sound/wlf,arizona.yaml
new file mode 100644
index 0000000000000..22d54be7900a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,arizona.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,arizona.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  These devices are audio SoCs with extensive digital capabilities and a range
+  of analogue I/O.
+
+  This document lists sound specific bindings, see the primary binding
+  document ../mfd/arizona.yaml
+
+properties:
+  '#sound-dai-cells':
+    description:
+      The first cell indicating the audio interface.
+    const: 1
+
+  wlf,inmode:
+    description:
+      A list of INn_MODE register values, where n is the number of input
+      signals. Valid values are 0 (Differential), 1 (Single-ended) and
+      2 (Digital Microphone). If absent, INn_MODE registers set to 0 by
+      default.  If present, values must be specified less than or equal
+      to the number of input signals. If values less than the number of
+      input signals, elements that have not been specified are set to 0 by
+      default. Entries are <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280,
+      wm8997) and <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 2
+      default: 0
+
+  wlf,out-mono:
+    description:
+      A list of boolean values indicating whether each output is mono
+      or stereo. Position within the list indicates the output affected
+      (eg. First entry in the list corresponds to output 1). A non-zero
+      value indicates a mono output. If present, the number of values
+      should be less than or equal to the number of outputs, if less values
+      are supplied the additional outputs will be treated as stereo.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      minimum: 0
+      maximum: 1
+      default: 0
+
+  wlf,dmic-ref:
+    description:
+      DMIC reference voltage source for each input, can be selected from
+      either MICVDD or one of the MICBIAS's, defines (ARIZONA_DMIC_xxxx)
+      are provided in dt-bindings/mfd/arizona.h. If present, the number
+      of values should be less than or equal to the number of inputs,
+      unspecified inputs will use the chip default.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 3
+      default: 0
+
+  wlf,max-channels-clocked:
+    description:
+      The maximum number of channels to be clocked on each AIF, useful for
+      I2S systems with multiple data lines being mastered.  Specify one
+      cell for each AIF to be configured, specify zero for AIFs that should
+      be handled normally.  If present, number of cells must be less than
+      or equal to the number of AIFs. If less than the number of AIFs, for
+      cells that have not been specified the corresponding AIFs will be
+      treated as default setting.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 3
+    items:
+      default: 0
+
+  wlf,spk-fmt:
+    description:
+      PDM speaker data format, must contain 2 cells (OUT5 and OUT6).  See
+      the datasheet for values.  The second cell is ignored for codecs that
+      do not have OUT6 (wm5102, wm8997, wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  wlf,spk-mute:
+    description:
+      PDM speaker mute setting, must contain 2 cells (OUT5 and OUT6).  See
+      the datasheet for values.  The second cell is ignored for codecs that
+      do not have OUT6 (wm5102, wm8997, wm8998, wm1814)
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  wlf,out-volume-limit:
+    description:
+      The volume limit value that should be applied to each output
+      channel. See the datasheet for exact values. Channels are specified
+      in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 12
-- 
2.11.0

