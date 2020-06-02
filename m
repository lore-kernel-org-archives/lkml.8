Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A051206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OlSX02OP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBTfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:35:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49040 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:35:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052JZaw2110528;
        Tue, 2 Jun 2020 14:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591126536;
        bh=/GqgLpU1uPJ1Wy+HenNmK2cNmc59eJZQiS6sZEF0GYw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OlSX02OP6CNAVor5r6F8fugshagcZ2Sv+MkYt0Vgd9rdYWr9VELYiNwoKT+vmhj5z
         NSXN/grf5ygZuwP5d/vY3wTP7Uk7+X8YFYPW6q98N3aSSrT68UozruYNGquOjEOX62
         OJC8vTkpm7ieXB0KHalnv9yX1DMpP03q5vhIeLZU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 052JZZAB091823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Jun 2020 14:35:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 14:35:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 14:35:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052JZZeS006873;
        Tue, 2 Jun 2020 14:35:35 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] dt-bindings: tas2562: Convert the tas2562 binding to yaml
Date:   Tue, 2 Jun 2020 14:35:24 -0500
Message-ID: <20200602193524.30309-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602193524.30309-1-dmurphy@ti.com>
References: <20200602193524.30309-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TAS2562 text file to yaml format.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.txt     | 34 ----------
 .../devicetree/bindings/sound/tas2562.yaml    | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
deleted file mode 100644
index 94796b547184..000000000000
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Texas Instruments TAS2562 Smart PA
-
-The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
-efficiently driving high peak power into small loudspeakers.
-Integrated speaker voltage and current sense provides for
-real time monitoring of loudspeaker behavior.
-
-Required properties:
- - #address-cells  - Should be <1>.
- - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
- - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
- - ti,imon-slot-no:- TDM TX current sense time slot.
-
-Optional properties:
-- interrupt-parent: phandle to the interrupt controller which provides
-                    the interrupt.
-- interrupts: (GPIO) interrupt to which the chip is connected.
-- shut-down: GPIO used to control the state of the device.
-
-Examples:
-tas2562@4c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        compatible = "ti,tas2562";
-        reg = <0x4c>;
-
-        interrupt-parent = <&gpio1>;
-        interrupts = <14>;
-
-	shut-down = <&gpio1 15 0>;
-        ti,imon-slot-no = <0>;
-};
-
diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
new file mode 100644
index 000000000000..11e0269d03b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments TAS2562 Smart PA
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
+  efficiently driving high peak power into small loudspeakers.
+  Integrated speaker voltage and current sense provides for
+  real time monitoring of loudspeaker behavior.
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2562
+      - ti,tas2563
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C addresss of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+
+  shut-down:
+    description: GPIO used to control the state of the device.
+
+  interrupts:
+    maxItems: 1
+
+  ti,imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TDM TX current sense time slot.
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c0 {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@4c {
+       compatible = "ti,tas2562";
+       reg = <0x4c>;
+       #sound-dai-cells = <1>;
+       interrupt-parent = <&gpio1>;
+       interrupts = <14>;
+
+       shut-down = <&gpio1 15 0>;
+       ti,imon-slot-no = <0>;
+     };
+   };
+
-- 
2.26.2

