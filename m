Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C12076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nY/URHMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2KVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:21:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45114 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG2KVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596018074; x=1627554074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZDY0T6Oj5kZPX2bvi28/V5jMbm1TjGpBdiPQdVnlgs=;
  b=nY/URHMGsEL9TmsBtA/OrC2XkVVvObrDb97PrGMQP1Kyqp7Jw4RuPeMF
   FH8JvJ9JJoOdnpG3YEJ4vSBpdeo/j49kcUSdcHL3j3PzBMvwD00ZLea9X
   +RcvKEgrA4WaZG5ZArSsRDznTDEcwsUTuu9JWWJN2/r0NuKgSRqIXOadG
   23HmR1lWjNJSekLHpga+Pu2llhcS/3zE5NBLJGNZpIFrpgmkbsGcXXbIS
   ykyfd8cmfGPhW++8GyGyQ+pC1G8b79+P1MRtoaZhO2zywlBgRsnGOh1K5
   DZUv6JeL68ZwdatGAknSl0EBLiRitcUqsiMdojYXVnfTNQKU1WxzuW+yk
   w==;
IronPort-SDR: /1NWZyD0fKGEaB+J+GQxSEnytQBCoc/xzTua5KVjSATKO1f1DjS/352C5rNuHUzCfse5D2crBu
 5cyA42IWp4xMBcZlqSsSGRG8siKzYVYKLUKas1t1eUE7qEI2ruyk+opwyQjAU7w3r6xO9zgNWb
 aLafBTKuV7z01lVsIYkwfyDEkc3lTyMhcLZTpvsz09wcVHfo6TGrVbh2F0vfIG0JltHSc+U1p8
 PsU6axUSpLYOaMEr9z9VNzlhkllZVJOEmCldbH4CqzRxtW9oul3yw5LGgwSqVvn3bA+t+5hXl1
 bq0=
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="81629155"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jul 2020 03:21:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 29 Jul 2020 03:21:11 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 29 Jul 2020 03:19:07 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF TX Controller
Date:   Wed, 29 Jul 2020 13:19:21 +0300
Message-ID: <20200729101922.3033616-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings for the new Microchip S/PDIF TX Controller
embedded inside sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - replaced https with http
 - reworked example, included bindings;

 .../bindings/sound/mchp,spdiftx.yaml          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
new file mode 100644
index 000000000000..2b7c27391f0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip S/PDIF Tx Controller Device Tree Bindings
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+        The Microchip Sony/Philips Digital Interface Transmitter is a
+        serial port compliant with the IEC-60958 standard.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    oneOf:
+      - const: microchip,sama7g5-spdiftx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdiftx@e1618000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdiftx";
+        reg = <0xe1618000 0x4000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(50)>;
+        dma-names = "tx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 85>, <&pmc PMC_TYPE_GCK 85>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdiftx_default>;
+    };
-- 
2.25.1

