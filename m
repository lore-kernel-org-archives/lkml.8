Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7672A20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFAGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:23:34 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48762 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgFAGX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:23:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB2BB20047B;
        Mon,  1 Jun 2020 08:23:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03B38200480;
        Mon,  1 Jun 2020 08:23:20 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C01440323;
        Mon,  1 Jun 2020 14:23:12 +0800 (SGT)
From:   sandor.yu@nxp.com
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, heiko@sntech.de, hjc@rock-chips.com,
        Sandor.yu@nxp.com, dkos@cadence.com,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 7/7] dt-bindings: display: Document Cadence MHDP HDMI/DP bindings
Date:   Mon,  1 Jun 2020 14:17:37 +0800
Message-Id: <9fa979f1099f7c02fd746f25002d8a652253d70f.1590982881.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590982881.git.Sandor.yu@nxp.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1590982881.git.Sandor.yu@nxp.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

Document the bindings used for the Cadence MHDP HDMI/DP bridge.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 .../bindings/display/bridge/cdns,mhdp.yaml    | 46 +++++++++++++++
 .../devicetree/bindings/display/imx/mhdp.yaml | 59 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
 create mode 100644 Documentation/devicetree/bindings/display/imx/mhdp.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
new file mode 100644
index 000000000000..aa23feba744a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause))
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence MHDP TX Encoder
+
+maintainers:
+  - Sandor Yu <Sandoryu@nxp.com>
+
+description: |
+  Cadence MHDP Controller supports one or more of the protocols,
+  such as HDMI and DisplayPort.
+  Each protocol requires a different FW binaries.
+
+  This document defines device tree properties for the Cadence MHDP Encoder
+  (CDNS MHDP TX). It doesn't constitue a device tree binding
+  specification by itself but is meant to be referenced by platform-specific
+  device tree bindings.
+
+  When referenced from platform device tree bindings the properties defined in
+  this document are defined as follows. The platform device tree bindings are
+  responsible for defining whether each property is required or optional.
+
+properties:
+  reg:
+    maxItems: 1
+    description: Memory mapped base address and length of the MHDP TX registers.
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    - const: plug_in
+      description: Hotplug detect interrupter for cable plugin event.
+    - const: plug_out
+      description: Hotplug detect interrupter for cable plugout event.
+
+  port:
+    type: object
+    description: |
+      The connectivity of the MHDP TX with the rest of the system is
+      expressed in using ports as specified in the device graph bindings defined
+      in Documentation/devicetree/bindings/graph.txt. The numbering of the ports
+      is platform-specific.
diff --git a/Documentation/devicetree/bindings/display/imx/mhdp.yaml b/Documentation/devicetree/bindings/display/imx/mhdp.yaml
new file mode 100644
index 000000000000..17850cfd1cb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/mhdp.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/mhdp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence MHDP Encoder
+
+maintainers:
+  - Sandor Yu <Sandoryu@nxp.com>
+
+description: |
+  The MHDP transmitter is a Cadence HD Display TX controller IP
+  with a companion PHY IP.
+  The MHDP supports one or more of the protocols,
+  such as HDMI(1.4 & 2.0), DisplayPort(1.2).
+  switching between the two modes (HDMI and DisplayPort)
+  requires reloading the appropriate FW
+
+  These DT bindings follow the Cadence MHDP TX bindings defined in
+  Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml with the
+  following device-specific properties.
+
+Properties:
+  compatible:
+    enum:
+      - nxp,imx8mq-cdns-hdmi
+      - nxp,imx8mq-cdns-dp
+
+  reg: See cdns,mhdp.yaml.
+
+  interrupts: See cdns,mhdp.yaml.
+
+  interrupt-names: See cdns,mhdp.yaml.
+
+  ports: See cdns,mhdp.yaml.
+
+Required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - ports
+
+Example:
+  - |
+    mhdp: mhdp@32c00000 {
+      compatible = "nxp,imx8mq-cdns-hdmi";
+      reg = <0x32c00000 0x100000>;
+      interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "plug_in", "plug_out";
+
+      ports {
+        mhdp_in: endpoint {
+          remote-endpoint = <&dcss_out>;
+        };
+      };
+    };
-- 
2.17.1

