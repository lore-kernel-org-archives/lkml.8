Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69150C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F06420836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbgEKVCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:02:00 -0400
Received: from v6.sk ([167.172.42.174]:52586 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732376AbgEKVBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:01:54 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9506C610D4;
        Mon, 11 May 2020 21:01:52 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/11] dt-bindings: sound: Add Marvell MMP SSPA binding
Date:   Mon, 11 May 2020 23:01:33 +0200
Message-Id: <20200511210134.1224532-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511210134.1224532-1-lkundrak@v3.sk>
References: <20200511210134.1224532-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the audio serial port interface (I2S) on
Marvell MMP SoCs.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/sound/marvell,mmp-sspa.yaml      | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml

diff --git a/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml b/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml
new file mode 100644
index 000000000000..6d20a24a2ae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/marvell,mmp-sspa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvel SSPA Digital Audio Interface Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller(@.*)?$"
+
+  compatible:
+    const: marvell,mmp-sspa
+
+  reg:
+    items:
+      - description: RX block
+      - description: TX block
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Clock for the Audio block
+      - description: I2S bit clock
+
+  clock-names:
+    items:
+      - const: audio
+      - const: bitclk
+
+  power-domains:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  port:
+    type: object
+
+    properties:
+      endpoint:
+        type: object
+
+        properties:
+          remote-endpoint: true
+
+          frame-master:
+            type: boolean
+            description: SoC generates the frame clock
+
+          bitclock-master:
+            type: boolean
+            description: SoC generates the bit clock
+
+          dai-format:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: The digital audio format
+            const: i2s
+
+        required:
+          - remote-endpoint
+
+    required:
+      - endpoint
+
+    additionalProperties: false
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
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+
+    audio-controller@d42a0c00 {
+      compatible = "marvell,mmp-sspa";
+      reg = <0xd42a0c00 0x30>,
+            <0xd42a0c80 0x30>;
+      interrupts = <2>;
+      clock-names = "audio", "bitclk";
+      clocks = <&soc_clocks 127>,
+               <&audio_clk 1>;
+      #sound-dai-cells = <0>;
+      dmas = <&adma0 0>, <&adma0 1>;
+      dma-names = "tx", "rx";
+      port {
+        endpoint {
+          remote-endpoint = <&rt5631_0>;
+          frame-master;
+          bitclock-master;
+          dai-format = "i2s";
+        };
+      };
+    };
+
+...
-- 
2.26.2

