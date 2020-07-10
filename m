Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644F420720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gDKsiS8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:50:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44258 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:50:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06AEoT9K016419;
        Fri, 10 Jul 2020 09:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594392629;
        bh=jOY1Lpj8nE5e21vNNm8ImYQOmUfYWBaDj239YmWEmtI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gDKsiS8cXTxOv1cdFkKF/ymRbF4vMjQPo4tUzHg6KKYYo8Ic7hCMBi8W75m1Rg2T/
         h+wVnD0sgUbqc+dBQ9lOWmfotymitcxdd9AEnGv9oF2p7V1NZXMx/DMgdfqQLoV5SG
         0LL2BSiFVo5K2blZ3DXpQy21KeaIspAZnV2zTsR4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06AEoSNj007788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 09:50:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 09:50:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 09:50:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06AEoSKG105917;
        Fri, 10 Jul 2020 09:50:28 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH for-next v2 2/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Date:   Fri, 10 Jul 2020 09:50:16 -0500
Message-ID: <20200710145016.384-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710145016.384-1-dmurphy@ti.com>
References: <20200710145016.384-1-dmurphy@ti.com>
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
index 000000000000..8c667fd37a57
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
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

