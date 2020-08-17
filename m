Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB72C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86E02072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647665;
	bh=CCAMQ1pVhtyjj73AqAvUfMTk4Xwdmos1F+lbGj4gSgU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOUniacfkU1Xyq1Irn4By9K9qpNNXRRJ34gD7kaAvolVld73P5Jb2fO/zcBLPkq41
	 CuQdyGVqvdiXU3dXe5aLVqOBTmX3T2DYuWAxL+4RpV6R+Z5zcR7tKf2eUQJZ8JoHaR
	 jqCpVUxuDTTK/6dOTQG831mBbziMDfXz2IVVVp5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgHQHBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgHQHAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB79207FF;
        Mon, 17 Aug 2020 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647620;
        bh=CCAMQ1pVhtyjj73AqAvUfMTk4Xwdmos1F+lbGj4gSgU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TmML2OJ6HAu3ZeiJc8MGPIzM4binTy7d9xjJRNWnfhoYB8T/6U6UYRsCouLqQLjEA
         s6hIvpr+CFo92Sa4qs+equSLNcjqtxYe9lXy8KFLqhrvZE7qt1djJaUQ7ZLI2uARe1
         FoMHK5s8HNlFgXfjnfN9ibOr6c/tx9qtw/PjOmtY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 01/13] dt-bindings: extcon: ptn5150: Convert binding to DT schema
Date:   Mon, 17 Aug 2020 08:59:57 +0200
Message-Id: <20200817070009.4631-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ptn-5150 extcon driver bindings to DT schema format using
json-schema.  The differences with original bindings document:
 - Use "gpios" suffix for the "int" and "vbus" gpio,
 - Skip generic "pinctrl" property as it is not really required.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/extcon/extcon-ptn5150.txt        | 27 ----------
 .../bindings/extcon/extcon-ptn5150.yaml       | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
deleted file mode 100644
index 936fbdf12815..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* PTN5150 CC (Configuration Channel) Logic device
-
-PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
-connector application with CC control logic detection and indication functions.
-It is interfaced to the host controller using an I2C interface.
-
-Required properties:
-- compatible: should be "nxp,ptn5150"
-- reg: specifies the I2C slave address of the device
-- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
-	connected to the PTN5150's INTB pin.
-- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
-	is used to control VBUS.
-- pinctrl-names : a pinctrl state named "default" must be defined.
-- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus
-	control.
-
-Example:
-	ptn5150@1d {
-		compatible = "nxp,ptn5150";
-		reg = <0x1d>;
-		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
-		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ptn5150_default>;
-		status = "okay";
-	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
new file mode 100644
index 000000000000..f6316f12028b
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PTN5150 CC (Configuration Channel) Logic device
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
+  connector application with CC control logic detection and indication
+  functions.  It is interfaced to the host controller using an I2C interface.
+
+properties:
+  compatible:
+    const: nxp,ptn5150
+
+  int-gpios:
+    description:
+      GPIO pin (input) connected to the PTN5150's INTB pin.
+
+  reg:
+    maxItems: 1
+
+  vbus-gpios:
+    description:
+      GPIO pin (output) used to control VBUS.
+
+required:
+  - compatible
+  - int-gpios
+  - reg
+  - vbus-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ptn5150@1d {
+            compatible = "nxp,ptn5150";
+            reg = <0x1d>;
+            int-gpios = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+            vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.17.1

