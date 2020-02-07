Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9A217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n3ej5cmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGTut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:50:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37816 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:50:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 017Jo4UJ100329;
        Fri, 7 Feb 2020 13:50:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581105004;
        bh=MsMfXIk8QfS6+D9zPfzNzS76menjn5D568VCWB65xFs=;
        h=From:To:CC:Subject:Date;
        b=n3ej5cmDnV4gXAXVnJbF1wDDQ79MRGmttgezAigJKQFf2SIiPeTmtMqe6Z9ltx9GF
         7GYeZb/OyFdDHH+aTMMpgtVMRIq1TH1Epp0j6EQoWI+yhExfVNcUmb8RZJi8PsTZWR
         zC/8aOvA5sIXBfWhqNW/y9rf9QIH7giKf6Bqa8dY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 017Jo4iL031897;
        Fri, 7 Feb 2020 13:50:04 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 7 Feb
 2020 13:50:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 7 Feb 2020 13:50:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 017Jo4io116946;
        Fri, 7 Feb 2020 13:50:04 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: sound: Add TLV320ADCx140 dt bindings
Date:   Fri, 7 Feb 2020 13:45:32 -0600
Message-ID: <20200207194533.29967-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for the TLV320ADCx140 Burr-Brown ADC.
The initial support is for the following:

TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/sound/tlv320adcx140.yaml         | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
new file mode 100644
index 000000000000..84c407fae21e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/tlv320adcx140.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TLV320ADCX140 Quad Channel Analog-to-Digital Converter
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The TLV320ADCX140 are multichannel (4-ch analog recording or 8-ch digital
+  PDM microphones recording), high-performance audio, analog-to-digital
+  converter (ADC) with analog inputs supporting up to 2V RMS. The TLV320ADCX140
+  family supports line and  microphone Inputs, and offers a programmable
+  microphone bias or supply voltage generation.
+
+  Specifications can be found at:
+    http://www.ti.com/lit/ds/symlink/tlv320adc3140.pdf
+    http://www.ti.com/lit/ds/symlink/tlv320adc5140.pdf
+    http://www.ti.com/lit/ds/symlink/tlv320adc6140.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,tlv320adc3140
+      - const: ti,tlv320adc5140
+      - const: ti,tlv320adc6140
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C addresss of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+
+  reset-gpios:
+    description: |
+       GPIO used for hardware reset.
+
+  ti,use-internal-areg:
+    type: boolean
+    description: |
+       Internal Regulator with AVDD at 3.3V.
+
+  ti,mic-bias-source:
+    description: |
+       Indicates the source for MIC Bias.
+       0 - Mic bias is set to VREF
+       1 - Mic bias is set to VREF × 1.096
+       6 - Mic bias is set to AVDD
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 6]
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      codec: codec@4c {
+        compatible = "ti,tlv320adc5140";
+        reg = <0x4c>;
+        ti,use-internal-areg;
+        ti,mic-bias-source = <6>;
+        reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+      };
+    };
-- 
2.25.0

