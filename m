Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E36C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1FB22B51
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w5rlct7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgGTSNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:13:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:13:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KIC9AX046558;
        Mon, 20 Jul 2020 13:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595268729;
        bh=4KiZbT+DgSaObYOpScRgrA6GAU+kccEbndY0uV9caOs=;
        h=From:To:CC:Subject:Date;
        b=w5rlct7zKGxmme+hGSBvRAztq7+B/mpHXTY6TmK5lhME8Ipr+bCa+pKXwQFMnu1tI
         8eKUhbTZKJBUctn0GRgrUw9g0X9FdhfnnfjWKQqsqQ/GJb5S43y6c2SgnkvBGsmGgr
         iONtnqPoZ99nKO5XZ1Csh2IB7ITX5H+KEQ8Cr6t0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KIC9Xh090919;
        Mon, 20 Jul 2020 13:12:09 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 13:12:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 13:12:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KIC8tD050355;
        Mon, 20 Jul 2020 13:12:08 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Date:   Mon, 20 Jul 2020 13:12:01 -0500
Message-ID: <20200720181202.31000-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the tas2770 binding to yaml format.
Add in the reset-gpio to the binding as it is in the code but not
documented in the binding.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2770.txt     | 37 ---------
 .../devicetree/bindings/sound/tas2770.yaml    | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas2770.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
deleted file mode 100644
index ede6bb3d9637..000000000000
--- a/Documentation/devicetree/bindings/sound/tas2770.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Texas Instruments TAS2770 Smart PA
-
-The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
-efficiently driving high peak power into small loudspeakers.
-Integrated speaker voltage and current sense provides for
-real time monitoring of loudspeaker behavior.
-
-Required properties:
-
- - compatible:	   - Should contain "ti,tas2770".
- - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
- - #address-cells  - Should be <1>.
- - #size-cells     - Should be <0>.
- - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
- - ti,imon-slot-no:- TDM TX current sense time slot.
- - ti,vmon-slot-no:- TDM TX voltage sense time slot.
-
-Optional properties:
-
-- interrupt-parent: the phandle to the interrupt controller which provides
-                     the interrupt.
-- interrupts: interrupt specification for data-ready.
-
-Examples:
-
-    tas2770@4c {
-                compatible = "ti,tas2770";
-                reg = <0x4c>;
-                #address-cells = <1>;
-                #size-cells = <0>;
-                interrupt-parent = <&msm_gpio>;
-                interrupts = <97 0>;
-                ti,asi-format = <0>;
-                ti,imon-slot-no = <0>;
-                ti,vmon-slot-no = <2>;
-        };
-
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
new file mode 100644
index 000000000000..8192450d72dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019-20 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2770.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments TAS2770 Smart PA
+
+maintainers:
+  - Shi Fu <shifu0704@thundersoft.com>
+
+description: |
+  The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
+  efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2770
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+
+  reset-gpio:
+    description: GPIO used to reset the device.
+
+  interrupts:
+    maxItems: 1
+
+  ti,imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX current sense time slot.
+
+  ti,vmon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX voltage sense time slot.
+
+  ti,asi-format:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets TDM RX capture edge.
+    enum:
+          - 0 # Rising edge
+          - 1 # Falling edge
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c0 {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@4c {
+       compatible = "ti,tas2770";
+       reg = <0x4c>;
+       #sound-dai-cells = <1>;
+       interrupt-parent = <&gpio1>;
+       interrupts = <14>;
+       reset-gpio = <&gpio1 15 0>;
+       ti,imon-slot-no = <0>;
+       ti,vmon-slot-no = <2>;
+     };
+   };
+
-- 
2.27.0

