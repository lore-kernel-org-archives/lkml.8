Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D63C7C840
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80E3206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EAJmrWtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgD0OBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:01:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46516 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgD0OAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:00:48 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 22138C0340;
        Mon, 27 Apr 2020 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587996047; bh=gkz/MH4Z3ksYqoxMhUAoa+N/R81O+lRzybg5tG4r+Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EAJmrWtZWC1Rpt/5XO7y7dQi8qPIw6reeltCBl06D8trq30jmSKDRwBuT4pWIMs9W
         6Xgy8WwlpRSHV2Hpbm4i+zdxTuS0n1LXXy4Njxl01ShCfLw7HyWVO3B0VSMpDtPYGe
         enoOfvju0XBLo4+zGut3bPcbxfdlpLEqwuLDChC860cAEZ9/GJboW2H4ILknv0E/EJ
         +Ki+98EHW+FvxmhVZlmvhb7Fu365m30XGyEMWQFCKL0/kqTpklEQW9nO1+mB83qxqH
         OHOQ+EAqS92uUjsQGIf8TuLEbFF5z0l8DQiGc2oG7Bhh6Zfqi+QtxNnpRImxo7cWaO
         hJDUy71FCLfCQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51743A005E;
        Mon, 27 Apr 2020 14:00:44 +0000 (UTC)
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v3 1/4] dt-bindings: display: Add IPK DSI subsystem bindings
Date:   Mon, 27 Apr 2020 16:00:33 +0200
Message-Id: <04a657ce78633d82565d3a7ce34a8ab52310ff63.1587992776.git.angelo.ribeiro@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
References: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
In-Reply-To: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
References: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for Synopsys DesignWare MIPI DSI Host and VPG (Video
Pattern Generator) support in the IPK display subsystem.

The Synopsys DesignWare IPK display video pipeline is composed by a DSI
controller (snps,dw-ipk-dsi) and a VPG (snps,dw-ipk-vpg) as DPI
stimulus. Typically is used the Raspberry Pi
(raspberrypi,7inch-touchscreen-panel) as DSI panel that requires a
I2C controller (snps,designware-i2c).

Reported-by: Rob Herring <robh+dt@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
---
Changes since v3:
  - Fixed dt-binding breaking on `make dt_binding_check`.

Changes since v2:
  - Fixed dt-bindings issues, see
    https://patchwork.ozlabs.org/patch/1260819/.
---
 .../bindings/display/snps,dw-ipk-dsi.yaml          | 159 +++++++++++++++++++++
 .../bindings/display/snps,dw-ipk-vpg.yaml          |  73 ++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml

diff --git a/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml b/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
new file mode 100644
index 0000000..af4b775
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/snps,dw-ipk-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare IPK specific extensions for the Synopsys DSI host
+       controller.
+
+maintainers:
+  - Angelo Ribeiro <angelo.ribeiro@synopsys.com>
+
+description: |
+  The Synopsys DesignWare IPK DSI controller uses the Synopsys DesignWare MIPI
+  DSI host controller.
+  For more info refer to
+  Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt.
+
+properties:
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  compatible:
+    items:
+      - const: snps,dw-ipk-dsi
+      - const: snps,dw-mipi-dsi
+
+  reg:
+    items:
+      - description: DW MIPI DSI Host registers
+      - description: DW MIPI DSI Phy test-chip registers
+    minItems: 2
+
+  reg-names:
+    items:
+     - const: dsi
+     - const: phy
+    minItems: 2
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: PLL clock
+      - description: Pixel clock
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ref
+      - const: px_clk
+    minItems: 2
+
+  resets:
+    items:
+      - description: APB reset line
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: apb
+    minItems: 1
+
+  ports:
+    type: object
+    description: |
+      A port node containging a DSI input and outuput port nodes as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt and
+      Documentation/devicetree/bindings/graph.txt.
+    properties:
+      port@0:
+        type: object
+        description: Input endpoint of the controller, connects to a DPI source.
+
+      port@1:
+        type: object
+        description: Output endpoint of the controller, connects to a panel or
+          a bridge input port.
+
+    required:
+      - port@0
+      - port@1
+
+additionalProperties: false
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - ports
+
+examples:
+  - |
+    dsi1: dw-ipk-dsi@2000 {
+        compatible = "snps,dw-ipk-dsi";
+        reg = <0x02000 0xfff>, <0x05000 0xfff>;
+        reg-names = "dsi", "phy";
+        clocks = <&apb_clk>, <&pll_clk>;
+        clock-names = "pclk", "ref";
+        resets = <&ipk_rst 1>;
+        reset-names = "apb";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dsi1_in: endpoint {
+                    remote-endpoint = <&vbridge_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                dsi_out_port: endpoint {
+                    remote-endpoint = <&panel_dsi_port>;
+                };
+            };
+        };
+    };
+
+    i2c: i2c@1000 {
+        compatible = "snps,designware-i2c";
+        reg = <0x01000 0x100>;
+        clock-frequency = <400000>;
+        clocks = <&i2cclk>;
+        interrupts = <0>;
+        resets = <&ipk_rst 0>;
+        reset-names = "i2c";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lcd@45 {
+            compatible = "raspberrypi,7inch-touchscreen-panel";
+            reg = <0x45>;
+
+            port {
+                panel_dsi_port: endpoint {
+                    remote-endpoint = <&dsi_out_port>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml b/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
new file mode 100644
index 0000000..07e8380
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/snps,dw-ipk-vpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Video Pattern Generator (VPG) for MIPI DSI HOST
+
+maintainers:
+  - Angelo Ribeiro <angelo.ribeiro@synopsys.com>
+
+properties:
+  compatible:
+    const: snps,dw-ipk-vpg
+
+  reg:
+    items:
+      - description: Video Pattern Generator (VPG) registers
+      - description: Clock generator (MMCM) registers
+    minItems: 2
+
+  reg-names:
+   items:
+     - const: vpg
+     - const: mmcm
+   minItems: 2
+
+  resets:
+    items:
+      - description: VPG reset line
+      - description: MMCM reset line
+    minItems: 2
+
+  reset-names:
+    items:
+      - const: vpg
+      - const: mmcm
+    minItems: 2
+
+  port:
+    type: object
+    description: Video port for DPI output.
+      The VPG has one video port for internal DPI stimulus over the MIPI
+      DSI host controller.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi_vpg: dw-dsi-vpg@3000 {
+        compatible = "snps,dw-ipk-vpg";
+        reg = <0x03000 0xfff>, <0x07000 0xfff>;
+        reg-names = "vpg", "mmcm";
+        resets = <&ipk_rst 2>, <&ipk_rst 3>;
+        reset-names = "vpg", "mmcm";
+        status = "okay";
+
+        port {
+            vpg_out: endpoint {
+                remote-endpoint = <&dsi1_in>;
+            };
+        };
+    };
+
+...
-- 
2.7.4

