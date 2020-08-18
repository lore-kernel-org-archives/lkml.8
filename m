Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A606BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70475207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762770;
	bh=4dvAMDQMjyFHGCuaNuR4HTZo8aTwdVUdSVxYl9LxYHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQjqTVuQOh37rjT/yaas6cHYU9Ysl8nuUbSTD4xJ2Wsc9uK5ktEBIVwUe91Jmxy5f
	 usDoBqGxojkHf7f282UTWKp08F9Opo7OfP962ZiLzhNuh9UwdrLoVRrOtZO5m76U/q
	 frT6Nq3v36EvR7UGpnoTiXtdEILmOo9ajhuB04+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHRO73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgHRO7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:11 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F8F20866;
        Tue, 18 Aug 2020 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=4dvAMDQMjyFHGCuaNuR4HTZo8aTwdVUdSVxYl9LxYHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+zQdGSPE5FbcrKxlvemvWlNb34s55Y0/az1+lcil3xxhuG9Hye8fMq4RlOO7bRWd
         qTD4gqEETQu+CdKV7yoLqnOJisHz0IfhDvaxUqNF26inRw/2AsduTqBSgAFndnJWI6
         MItXowALVFbQENjEd819DjMG5GTrut4YMqRRZ0oc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAk-6w; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 5/6] dt: document HiSilicon SPMI controller and mfd/regulator properties
Date:   Tue, 18 Aug 2020 16:58:57 +0200
Message-Id: <56c40a260bf31edf7049f50586c63ee0d06e02cb.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597762400.git.mchehab+huawei@kernel.org>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the properties needed by the HiSilicon
6421v600 driver, and by the SPMI controller used to access
the chipset.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 159 ++++++++++++++++++
 .../hisilicon,hisi-spmi-controller.yaml       |  62 +++++++
 2 files changed, 221 insertions(+)
 create mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
new file mode 100644
index 000000000000..c76093f320f1
--- /dev/null
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon 6421v600 SPMI PMIC
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |
+  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
+  (SPMI) bus. It provides interrupts and power supply.
+
+  The GPIO and interrupt settings are represented as part of the top-level PMIC
+  node.
+
+  The SPMI controller part is provided by
+  Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml.
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]"
+
+  compatible:
+    const: hisilicon,hi6421v600-spmi
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller:
+    description:
+      Identify that the PMIC is capable of behaving as an interrupt controller.
+
+  gpios:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^ldo[0-9]+@[0-9a-f]$':
+        type: object
+
+        $ref: "/schemas/regulator/regulator.yaml#"
+
+        properties:
+          reg:
+            description: Enable register.
+
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+            const: 0
+
+          vsel-reg:
+            description: Voltage selector register.
+
+          enable-mask:
+            description: Bitmask used to enable the regulator.
+
+          voltage-table:
+            description: Table with the selector items for the voltage regulator.
+            minItems: 2
+            maxItems: 16
+
+          off-on-delay-us:
+            description: Time required for changing state to enabled in microseconds.
+
+          startup-delay-us:
+            description: Startup time in microseconds.
+
+          idle-mode-mask:
+            description: Bitmask used to put the regulator on idle mode.
+
+          eco-microamp:
+            description: Maximum current while on idle mode.
+
+        required:
+          - reg
+          - vsel-reg
+          - enable-mask
+          - voltage-table
+          - off-on-delay-us
+          - startup-delay-us
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+examples:
+  - |
+    /* pmic properties */
+
+    pmic: pmic@0 {
+      compatible = "hisilicon,hi6421-spmi";
+      reg = <0 0>;
+
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      gpios = <&gpio28 0 0>;
+
+      regulators {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ldo3: ldo3@16 {
+          reg = <0x16>;
+          vsel-reg = <0x51>;
+
+          regulator-name = "ldo3";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <2000000>;
+          regulator-boot-on;
+
+          enable-mask = <0x01>;
+
+          voltage-table = <1500000>, <1550000>, <1600000>, <1650000>,
+                          <1700000>, <1725000>, <1750000>, <1775000>,
+                          <1800000>, <1825000>, <1850000>, <1875000>,
+                          <1900000>, <1925000>, <1950000>, <2000000>;
+          off-on-delay-us = <20000>;
+          startup-delay-us = <120>;
+        };
+
+        ldo4: ldo4@17 { /* 40 PIN */
+          reg = <0x17>;
+          vsel-reg = <0x52>;
+
+          regulator-name = "ldo4";
+          regulator-min-microvolt = <1725000>;
+          regulator-max-microvolt = <1900000>;
+          regulator-boot-on;
+
+          enable-mask = <0x01>;
+          idle-mode-mask = <0x10>;
+          eco-microamp = <10000>;
+
+          hi6421-vsel = <0x52 0x07>;
+          voltage-table = <1725000>, <1750000>, <1775000>, <1800000>,
+                          <1825000>, <1850000>, <1875000>, <1900000>;
+          off-on-delay-us = <20000>;
+          startup-delay-us = <120>;
+        };
+      };
+    };
diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
new file mode 100644
index 000000000000..b1cfa9c3aca6
--- /dev/null
+++ b/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/hisilicon,hisi-spmi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon SPMI controller
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |
+  The HiSilicon SPMI BUS controller is found on some Kirin-based designs.
+  It is a MIPI System Power Management (SPMI) controller.
+
+  The PMIC part is provided by
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
+
+properties:
+  $nodename:
+    pattern: "spmi@[0-9a-f]"
+
+  compatible:
+    const: hisilicon,kirin970-spmi-controller
+
+  reg:
+    maxItems: 1
+
+  spmi-channel:
+    description: |
+      number of the Kirin 970 SPMI channel where the SPMI devices are connected.
+
+required:
+ - compatible
+ - reg
+ - spmi-channel
+
+patternProperties:
+  "^pmic@[0-9a-f]$":
+    description: |
+      PMIC properties, which are specific to the used SPMI PMIC device(s).
+      When used in combination with HiSilicon 6421v600, the properties
+      are documented at
+      Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spmi: spmi@fff24000 {
+        compatible = "hisilicon,kirin970-spmi-controller";
+        status = "ok";
+        reg = <0x0 0xfff24000 0x0 0x1000>;
+        spmi-channel = <2>;
+
+        pmic@0 {
+          /* pmic properties */
+        };
+      };
+    };
-- 
2.26.2

