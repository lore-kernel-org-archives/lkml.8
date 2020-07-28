Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA6820714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tk5Nowcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgG1KMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:12:44 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58054 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgG1KMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595931163; x=1627467163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qWRJyT7ofYqitA7J7pY2TzLOv0iLUhqR8zqJooNWb/Y=;
  b=tk5NowcrWeAcifg/ynpsUyLC10AUZI3k8yLIZGvGQUvGTVcvtHXzd6OE
   bSdVf1j/J2zrnYJFHzlmNHiw4VwXrfcIv8JFtLdxFV7sqcG9l5k8ZeYrQ
   l2CiZrgYdGcj0vcB3PdfGNdN+iesE1EstGfU0J1IiiM6nsAGbvi9n4wwF
   1R5qDU6H9TtI3sgagLWymT62SHeGgDxr6PcYaGZN43H+J2fsXtLET82NK
   5H47VuHFGxm3GtaO/FXVaBYF3dBqWyL709uFRd784hdxZlINgWHg/AY1b
   C3Sge9af6tVO/zxvc2BJH7ueckzBss30VDKkPSZHJ+OCOSHwgo9NKFHSx
   w==;
IronPort-SDR: gdPgaWcpufmrKHTg82I5mspqkRip8bEW8aDNhKJEbccH4P1o17eWwqZ3rgBxFEptjbsvhJbRsh
 UXvbrECR/Li40jtK4QxamVLOoFYeHfR4u/TMu3fmYOQ2OpjKU+QFXNZZspfZlXMByfGdfAdzIb
 ImCSyAMUO0Fyoni426xHqToRiKkOvN75wShDuuM9bgAcvPPILsJjaWfXSMVDk90ZynqrKba0oz
 Od6psfDfZiRdhNr1Nknmq/spaeqbLDRR8yrgbnBKmezGbCy+/RbUsJuCI4/ShSEP8bWZH6/BN8
 L/4=
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="85607370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2020 03:12:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 03:12:42 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 28 Jul 2020 03:11:53 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF TX Controller
Date:   Tue, 28 Jul 2020 13:07:43 +0300
Message-ID: <20200728100744.2820112-1-codrin.ciubotariu@microchip.com>
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
 .../bindings/sound/mchp,spdiftx.yaml          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
new file mode 100644
index 000000000000..8e2acfbbe621
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: https://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
+$schema: https://devicetree.org/meta-schemas/core.yaml#
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
+    spdiftx@e1618000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdiftx";
+        reg = <0xe1618000 0x100>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(50)>;
+        dma-names = "tx";
+        clocks = <&spdiftx_clk>, <&spdiftx_gclk>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdiftx_default>;
+    };
-- 
2.25.1

