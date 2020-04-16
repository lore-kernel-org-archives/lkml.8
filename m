Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B9CC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBBB21973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636296AbgDPMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:51:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39826 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894435AbgDPMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:51:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 5340D2A00AE
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] dt-bindings: display: dw_mipi_dsi.txt: convert to yaml
Date:   Thu, 16 Apr 2020 15:52:07 +0300
Message-Id: <20200416125207.425271-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Synopsis MIPI DSI binding documentation to yaml and
should be quite straightforward. I've added a missing ref clk and also
added Mark and Rob as maintainers based on 'get_maintainer.pl' results.

Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 .../bindings/display/bridge/dw_mipi_dsi.txt   | 32 ---------
 .../display/bridge/snps,dw-mipi-dsi.yaml      | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
deleted file mode 100644
index b13adf30b8d3..000000000000
--- a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Synopsys DesignWare MIPI DSI host controller
-============================================
-
-This document defines device tree properties for the Synopsys DesignWare MIPI
-DSI host controller. It doesn't constitue a device tree binding specification
-by itself but is meant to be referenced by platform-specific device tree
-bindings.
-
-When referenced from platform device tree bindings the properties defined in
-this document are defined as follows. The platform device tree bindings are
-responsible for defining whether each optional property is used or not.
-
-- reg: Memory mapped base address and length of the DesignWare MIPI DSI
-  host controller registers. (mandatory)
-
-- clocks: References to all the clocks specified in the clock-names property
-  as specified in [1]. (mandatory)
-
-- clock-names:
-  - "pclk" is the peripheral clock for either AHB and APB. (mandatory)
-  - "px_clk" is the pixel clock for the DPI/RGB input. (optional)
-
-- resets: References to all the resets specified in the reset-names property
-  as specified in [2]. (optional)
-
-- reset-names: string reset name, must be "apb" if used. (optional)
-
-- panel or bridge node: see [3]. (mandatory)
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/reset/reset.txt
-[3] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
diff --git a/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
new file mode 100644
index 000000000000..0ab4125eee30
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/snps,dw-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare MIPI DSI host controller
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |
+  This document defines device tree properties for the Synopsys DesignWare MIPI
+  DSI host controller. It doesn't constitue a device tree binding specification
+  by itself but is meant to be referenced by platform-specific device tree
+  bindings.
+
+  When referenced from platform device tree bindings the properties defined in
+  this document are defined as follows. The platform device tree bindings are
+  responsible for defining whether each property is required or optional.
+
+properties:
+  reg:
+    description: |
+      Memory mapped base address and length of the DesignWare MIPI DSI host
+      controller registers.
+
+  clocks:
+    description: |
+      References to all the clocks specified in the clock-names property as
+      specified in Documentation/devicetree/bindings/clock/clock-bindings.txt
+    items:
+      - description: Module clock
+      - description: DSI bus colck for either AHB and APB
+      - description: Pixel clock for the DPI/RGB input
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: ref
+      - const: pclk
+      - const: px_clk
+    minItems: 2
+    maxItems: 3
+
+  resets:
+    description: |
+      References to all the resets specified in the reset-names property as
+      specified in Documentation/devicetree/bindings/reset/reset.txt
+
+  reset-names:
+    const: apb
+
+patternProperties:
+  "^panel@[0-3]$":
+    type: object
+    description: |
+      A node containing the panel or bridge description as documented in
+      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
+
+required:
+  - reg
+  - clocks
+  - clock-names
-- 
2.26.0

