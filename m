Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0267C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DCC20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AJSuHTZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgEFP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:58:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:26338 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729698AbgEFP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:58:08 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046Fri6X028143;
        Wed, 6 May 2020 10:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=AYBRmqrnY/0hIkelt5w9rQXDpdGMDLG6zT7tw23pw20=;
 b=AJSuHTZi1pdlJhBl2LksEmuzU9fdS5hY4DRy2mxRWhPL62LYdhS2B+NAfdxyzCbC8R4J
 kTcL74c3LNpW5FSY+FJ2euYAV6mVCbwWcuVwnc3GZCkAREWaXk5jXQuavfkeRfl9ytSa
 FVvsQjGPgJHL1aaB6VErKAkkZzgTybXwT8mw4JtC2SiyPBOyQzZ1M7DBSG0xjPiDyhGq
 AxUH37ecz0HnWfvv+tfiplP/gKR4I8ORETrZVh4t9SOg+iY47tiJ+LhqxF/bjOg2Y7Ch
 ED1nTltdnGnPRsf1Q6JKbbCXpp/mfZmtS4KwraQAscIHKUnuJF0F+Of6C3xZqUu18gKW Ew== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30s6937h76-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 May 2020 10:58:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 16:57:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 6 May 2020 16:57:59 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5046545A;
        Wed,  6 May 2020 15:57:59 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 6/7] pinctrl: madera: Move binding over to dtschema
Date:   Wed, 6 May 2020 16:57:57 +0100
Message-ID: <20200506155758.14643-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
References: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
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

New since v1, putting in the same series as Arizona since they share the
same regulator binding.

Thanks,
Charles

 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  99 --------------
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml | 147 +++++++++++++++++++++
 2 files changed, 147 insertions(+), 99 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
deleted file mode 100644
index b0e36cf0d289e..0000000000000
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+++ /dev/null
@@ -1,99 +0,0 @@
-Cirrus Logic Madera class audio codecs pinctrl driver
-
-The Cirrus Logic Madera codecs provide a number of GPIO functions for
-interfacing to external hardware and to provide logic outputs to other devices.
-Certain groups of GPIO pins also have an alternate function, normally as an
-audio interface.
-
-The set of available GPIOs, functions and alternate function groups differs
-between codecs so refer to the datasheet for the codec for further information
-on what is supported on that device.
-
-The properties for this driver exist within the parent MFD driver node.
-
-See also
-  the core bindings for the parent MFD driver:
-    Documentation/devicetree/bindings/mfd/madera.txt
-
-  the generic pinmix bindings:
-    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-Required properties of parent mfd node:
-  - pinctrl-names : must be "default"
-  - pinctrl-0 : a phandle to the node containing the subnodes containing default
-      configurations
-
-Required subnodes:
-  One subnode is required to contain the default settings. It contains an
-  arbitrary number of configuration subnodes, one for each group or pin
-  configuration you want to apply as a default.
-
-Required properties of configuration subnodes:
-  - groups : name of one pin group to configure. One of:
-	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
-	dmic4, dmic5, dmic6,
-	gpio1, gpio2, ..., gpio40
-    The gpioN groups select the single pin of this name for configuration
-
-Optional properties of configuration subnodes:
-  Any configuration option not explicitly listed in the dts will be left at
-  chip default setting.
-
-  - function : name of function to assign to this group. One of:
-	aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1, pdmspk2,
-	dmic3, dmic4, dmic5, dmic6,
-	io, dsp-gpio, irq1, irq2,
-	fll1-clk, fll1-lock, fll2-clk, fll2-lock, fll3-clk, fll3-lock,
-	fllao-clk, fllao-lock,
-	opclk, opclk-async, pwm1, pwm2, spdif,
-	asrc1-in1-lock, asrc1-in2-lock, asrc2-in1-lock, asrc2-in2-lock,
-	spkl-short-circuit, spkr-short-circuit, spk-shutdown,
-	spk-overheat-shutdown, spk-overheat-warn,
-	timer1-sts, timer2-sts, timer3-sts, timer4-sts, timer5-sts, timer6-sts,
-	timer7-sts, timer8-sts,
-	log1-fifo-ne, log2-fifo-ne, log3-fifo-ne, log4-fifo-ne, log5-fifo-ne,
-	log6-fifo-ne, log7-fifo-ne, log8-fifo-ne,
-
-  - bias-disable : disable pull-up and pull-down
-  - bias-bus-hold : enable buskeeper
-  - bias-pull-up : output is pulled-up
-  - bias-pull-down : output is pulled-down
-  - drive-push-pull : CMOS output
-  - drive-open-drain : open-drain output
-  - drive-strength : drive strength in mA. Valid values are 4 or 8
-  - input-schmitt-enable : enable schmitt-trigger mode
-  - input-schmitt-disable : disable schmitt-trigger mode
-  - input-debounce : A value of 0 disables debounce, a value !=0 enables
-	debounce
-  - output-low : set the pin to output mode with low level
-  - output-high : set the pin to output mode with high level
-
-Example:
-
-cs47l85@0 {
-	compatible = "cirrus,cs47l85";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&cs47l85_defaults>;
-
-	cs47l85_defaults: cs47l85-gpio-defaults {
-		aif1 {
-			groups = "aif1";
-			function = "aif1";
-			bias-bus-hold;
-		};
-
-		aif2 {
-			groups = "aif2";
-			function = "aif2";
-			bias-bus-hold;
-		};
-
-		opclk {
-			groups = "gpio1";
-			function = "opclk";
-			bias-pull-up;
-			drive-strength = <8>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
new file mode 100644
index 0000000000000..07a13429ca6c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/cirrus,madera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic Madera class audio CODECs pinctrl driver
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  The Cirrus Logic Madera codecs provide a number of GPIO functions for
+  interfacing to external hardware and to provide logic outputs to other devices.
+  Certain groups of GPIO pins also have an alternate function, normally as an
+  audio interface.
+
+  The set of available GPIOs, functions and alternate function groups differs
+  between CODECs so refer to the datasheet for the CODEC for further information
+  on what is supported on that device.
+
+  The properties for this driver exist within the parent MFD driver node.
+
+  See also the core bindings for the parent MFD driver:
+
+    Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
+
+  And the generic pinmix bindings:
+
+    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+properties:
+  pinctrl-0:
+    description:
+      A phandle to the node containing the subnodes containing default
+      configurations.
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+patternProperties:
+  '^.*-pins$':
+    description:
+      One subnode is required to contain the default settings. It
+      contains an arbitrary number of configuration subnodes, one for
+      each group or pin configuration you want to apply as a default.
+    patternProperties:
+      '^.*-pin$':
+        type: object
+        allOf:
+          - $ref: "pincfg-node.yaml#"
+          - $ref: "pinmux-node.yaml#"
+        properties:
+          groups:
+            description:
+              Name of one pin group to configure.
+            enum: [ aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1,
+                    pdmspk2, dmic4, dmic5, dmic6, gpio1, gpio2, gpio3,
+                    gpio4, gpio5, gpio6, gpio7, gpio7, gpio8, gpio9,
+                    gpio10, gpio11, gpio12, gpio13, gpio14, gpio15,
+                    gpio16, gpio17, gpio17, gpio18, gpio19, gpio20,
+                    gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
+                    gpio27, gpio27, gpio28, gpio29, gpio30, gpio31,
+                    gpio32, gpio33, gpio34, gpio35, gpio36, gpio37,
+                    gpio37, gpio38, gpio39 ]
+
+          function:
+            description:
+              Name of function to assign to this group.
+            enum: [ aif1, aif2, aif3, aif4, mif1, mif2, mif3,
+                    pdmspk1, pdmspk2, dmic3, dmic4, dmic5,
+                    dmic6, io, dsp-gpio, irq1, irq2, fll1-clk,
+                    fll1-lock, fll2-clk, fll2-lock, fll3-clk,
+                    fll3-lock, fllao-clk, fllao-lock, opclk,
+                    opclk-async, pwm1, pwm2, spdif, asrc1-in1-lock,
+                    asrc1-in2-lock, asrc2-in1-lock, asrc2-in2-lock,
+                    spkl-short-circuit, spkr-short-circuit,
+                    spk-shutdown, spk-overheat-shutdown,
+                    spk-overheat-warn, timer1-sts, timer2-sts,
+                    timer3-sts, timer4-sts, timer5-sts, timer6-sts,
+                    timer7-sts, timer8-sts, log1-fifo-ne,
+                    log2-fifo-ne, log3-fifo-ne, log4-fifo-ne,
+                    log5-fifo-ne, log6-fifo-ne, log7-fifo-ne,
+                    log8-fifo-ne ]
+
+          bias-disable:
+            description:
+              Disable pull-up and pull-down.
+
+          bias-bus-hold:
+            description:
+              Enable buskeeper.
+
+          bias-pull-up:
+            description:
+              Output is pulled-up.
+
+          bias-pull-down:
+            description:
+              Output is pulled-down.
+
+          drive-push-pull:
+            description:
+              CMOS output.
+
+          drive-open-drain:
+            description:
+              Open-drain output.
+
+          drive-strength:
+            description:
+              Drive strength in mA.
+            enum: [ 4, 8 ]
+
+          input-schmitt-enable:
+            description:
+              Enable schmitt-trigger mode.
+
+          input-schmitt-disable:
+            description:
+              Disable schmitt-trigger mode.
+
+          input-debounce:
+            description:
+              A zero value disables debounce, non-zero value enables
+              debounce.
+
+          output-low:
+            description:
+              Set the pin to output mode with low level.
+
+          output-high:
+            description:
+              Set the pin to output mode with high level.
+
+        additionalProperties: false
+
+        required:
+          - groups
+
+    additionalProperties: false
+
+required:
+  - pinctrl-0
+  - pinctrl-names
-- 
2.11.0

