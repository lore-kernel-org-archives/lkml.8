Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B540C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2C320732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgDNAwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:52:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56688 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390593AbgDNAvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:51:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8290A1A0237;
        Tue, 14 Apr 2020 02:51:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A44E61A0223;
        Tue, 14 Apr 2020 02:51:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C59A840305;
        Tue, 14 Apr 2020 08:51:18 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/7] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
Date:   Tue, 14 Apr 2020 08:43:08 +0800
Message-Id: <59596f2ecd406373aec46705c1e30a382e156add.1586747728.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1586747728.git.shengjiu.wang@nxp.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1586747728.git.shengjiu.wang@nxp.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
IP module found on i.MX8MN.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
new file mode 100644
index 000000000000..14ea60084420
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,easrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Asynchronous Sample Rate Converter (ASRC) Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  $nodename:
+    pattern: "^easrc@.*"
+
+  compatible:
+    const: fsl,imx8mn-easrc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: mem
+
+  dmas:
+    maxItems: 8
+
+  dma-names:
+    items:
+      - const: ctx0_rx
+      - const: ctx0_tx
+      - const: ctx1_rx
+      - const: ctx1_tx
+      - const: ctx2_rx
+      - const: ctx2_tx
+      - const: ctx3_rx
+      - const: ctx3_tx
+
+  firmware-name:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string
+      - const: imx/easrc/easrc-imx8mn.bin
+    description: The coefficient table for the filters
+
+  fsl,asrc-rate:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 8000
+      - maximum: 192000
+    description: Defines a mutual sample rate used by DPCM Back Ends
+
+  fsl,asrc-format:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [2, 6, 10, 32, 36]
+        default: 2
+    description:
+      Defines a mutual sample format used by DPCM Back Ends
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - firmware-name
+  - fsl,asrc-rate
+  - fsl,asrc-format
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mn-clock.h>
+
+    easrc: easrc@300C0000 {
+           compatible = "fsl,imx8mn-easrc";
+           reg = <0x0 0x300C0000 0x0 0x10000>;
+           interrupts = <0x0 122 0x4>;
+           clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
+           clock-names = "mem";
+           dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+                  <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+                  <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+                  <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+           dma-names = "ctx0_rx", "ctx0_tx",
+                       "ctx1_rx", "ctx1_tx",
+                       "ctx2_rx", "ctx2_tx",
+                       "ctx3_rx", "ctx3_tx";
+           firmware-name = "imx/easrc/easrc-imx8mn.bin";
+           fsl,asrc-rate  = <8000>;
+           fsl,asrc-format = <2>;
+    };
-- 
2.21.0

