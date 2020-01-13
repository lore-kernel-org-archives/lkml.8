Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9097AC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B092080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="t76HvVnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgAMQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:20:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21752 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728792AbgAMQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:20:46 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DGIYXl021897;
        Mon, 13 Jan 2020 17:20:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YXhJQvwHgKOjRoApdSqrtMOVX0SqxojByXlRGb3oW1E=;
 b=t76HvVnHAT76rLL3tIfg3pqAhn5js6eenVTCt8xiKZZpuhbwpua52tjQPL9UibgIEh4i
 hlG5lJfo/LhKsOCRHD8fh7SNyrue++dUZS9cOWeytGIeQ6+b73E0DvMBFI+xulZwF7gt
 nd5l5ezmz7iwBEr9BaWvXPBlTExKI+KxTJYHPOiysphG96tmB6P8w4r0oYmzAdYxqD6D
 2R3nlCfxMPGqE7BwgLrDd+Wup9jmJSA8XhtJRHtRWqoI50GgLauxUgF6+2ZwPRL73efh
 /TQH4c0O5D7UNjHN2Q7qyZNwpQsu7uRuNsge5J0TYOaIws03zqtVND5O/eOGyILRlGYk sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s116g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 17:20:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 883A410002A;
        Mon, 13 Jan 2020 17:20:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58F622D3791;
        Mon, 13 Jan 2020 17:20:13 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 Jan 2020 17:20:12
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH] ASoC: dt-bindings: stm32: convert spdfirx to json-schema
Date:   Mon, 13 Jan 2020 17:19:54 +0100
Message-ID: <20200113161954.29779-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_05:2020-01-13,2020-01-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 SPDIFRX bindings to DT schema format using json-schema.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 .../bindings/sound/st,stm32-spdifrx.txt       | 56 -------------
 .../bindings/sound/st,stm32-spdifrx.yaml      | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
deleted file mode 100644
index 33826f2459fa..000000000000
--- a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
-
-The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
-IEC-60958 and IEC-61937.
-
-Required properties:
-  - compatible: should be "st,stm32h7-spdifrx"
-  - reg: cpu DAI IP base address and size
-  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
-  - clock-names: must contain "kclk"
-  - interrupts: cpu DAI interrupt line
-  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
-    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
-  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
-
-Optional properties:
-  - resets: Reference to a reset controller asserting the SPDIFRX
-
-The device node should contain one 'port' child node with one child 'endpoint'
-node, according to the bindings defined in Documentation/devicetree/bindings/
-graph.txt.
-
-Example:
-spdifrx: spdifrx@40004000 {
-	compatible = "st,stm32h7-spdifrx";
-	reg = <0x40004000 0x400>;
-	clocks = <&rcc SPDIFRX_CK>;
-	clock-names = "kclk";
-	interrupts = <97>;
-	dmas = <&dmamux1 2 93 0x400 0x0>,
-	       <&dmamux1 3 94 0x400 0x0>;
-	dma-names = "rx", "rx-ctrl";
-	pinctrl-0 = <&spdifrx_pins>;
-	pinctrl-names = "default";
-
-	spdifrx_port: port {
-		cpu_endpoint: endpoint {
-			remote-endpoint = <&codec_endpoint>;
-		};
-	};
-};
-
-spdif_in: spdif-in {
-	compatible = "linux,spdif-dir";
-
-	codec_port: port {
-		codec_endpoint: endpoint {
-			remote-endpoint = <&cpu_endpoint>;
-		};
-	};
-};
-
-soundcard {
-	compatible = "audio-graph-card";
-	dais = <&spdifrx_port>;
-};
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
new file mode 100644
index 000000000000..ab8e9d74ac3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/st,stm32-spdifrx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 S/PDIF receiver (SPDIFRX)
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@st.com>
+
+description: |
+  The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
+  IEC-60958 and IEC-61937.
+
+properties:
+  compatible:
+    enum:
+      - st,stm32h7-spdifrx
+
+  "#sound-dai-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: kclk
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: audio data capture DMA
+      - description: IEC status bits capture DMA
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: rx-ctrl
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    spdifrx: spdifrx@40004000 {
+        compatible = "st,stm32h7-spdifrx";
+        #sound-dai-cells = <0>;
+        reg = <0x40004000 0x400>;
+        clocks = <&rcc SPDIF_K>;
+        clock-names = "kclk";
+        interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dmamux1 2 93 0x400 0x0>,
+               <&dmamux1 3 94 0x400 0x0>;
+        dma-names = "rx", "rx-ctrl";
+        pinctrl-0 = <&spdifrx_pins>;
+        pinctrl-names = "default";
+    };
+
+...
-- 
2.17.1

