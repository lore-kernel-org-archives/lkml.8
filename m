Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E6C4BA37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9A724679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgB0CsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:48:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:35240 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbgB0CsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:48:08 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D0BC208DC3;
        Thu, 27 Feb 2020 03:48:06 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B3C24208DC0;
        Thu, 27 Feb 2020 03:47:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 32BC3402F7;
        Thu, 27 Feb 2020 10:47:49 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
Date:   Thu, 27 Feb 2020 10:41:57 +0800
Message-Id: <4ce9facad66a67747f32dc0596205c0d1e9b7363.1582770784.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582770784.git.shengjiu.wang@nxp.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1582770784.git.shengjiu.wang@nxp.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
IP module found on i.MX8MN.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
new file mode 100644
index 000000000000..0131da6e6677
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    oneOf:
+      - items:
+        - enum:
+          - fsl,imx8mn-easrc
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
+    oneOf:
+      - items:
+          - const: ctx0_rx
+          - const: ctx0_tx
+          - const: ctx1_rx
+          - const: ctx1_tx
+          - const: ctx2_rx
+          - const: ctx2_tx
+          - const: ctx3_rx
+          - const: ctx3_tx
+
+  fsl,easrc-ram-script-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The coefficient table for the filters
+
+  fsl,asrc-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Defines a mutual sample rate used by DPCM Back Ends
+
+  fsl,asrc-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Defines a mutual sample width used by DPCM Back Ends
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-name
+  - fsl,easrc-ram-script-name
+  - fsl,asrc-rate
+  - fsl,asrc-width
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
+           fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
+           fsl,asrc-rate  = <8000>;
+           fsl,asrc-width = <16>;
+           status = "disabled";
+    };
-- 
2.21.0

