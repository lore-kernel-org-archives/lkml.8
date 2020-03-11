Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B17C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="thIjqzGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgCKKdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:33:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCKKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:33:02 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D7C772C;
        Wed, 11 Mar 2020 11:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583922780;
        bh=7H7+DkNWI6pPxy7zzF3R84Kn/HdsCejLRVjy2C9xDP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thIjqzGJ5UnG0nlkyTTB7WA/tnrltPFnZpvwvQh6IwdG3s1HPoBklKFQxypETGFt4
         WX5ojd9hb6z29sT3zMVD/Yuzedg4ncyNUbFdzi/E13R0YKRvoV8iPKYUc8SU3ncIi4
         wZr0kG3CJsA9Y4uF8tbPL7cM8/pjkfh+95y6vQ0M=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
Date:   Wed, 11 Mar 2020 12:32:50 +0200
Message-Id: <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
Processing System Gigabit Transceiver which provides PHY capabilities to
USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v5:

- Document clocks and clock-names properties
- Document resets and reset-names properties
- Replace subnodes with an additional entry in the PHY cells
- Drop lane frequency PHY cell, replaced by reference clock phandle
- Convert bindings to YAML
- Reword the subject line
- Drop Rob's R-b as the bindings have significantly changed
- Drop resets and reset-names properties
---
 .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 104 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   1 +
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml

diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
new file mode 100644
index 000000000000..9948e4a60e45
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/xlnx,zynqmp-psgtr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP Gigabit Transceiver PHY Device Tree Bindings
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description: |
+  This binding describes the Xilinx ZynqMP Gigabit Transceiver (GTR) PHY. The
+  GTR provides four lanes and is used by USB, SATA, PCIE, Display port and
+  Ethernet SGMII controllers.
+
+properties:
+  "#phy-cells":
+    const: 4
+    description: |
+      The cells contain the following arguments.
+
+      - description: The GTR lane
+        minimum: 0
+        maximum: 3
+      - description: The PHY type
+        enum:
+          - PHY_TYPE_DP
+          - PHY_TYPE_PCIE
+          - PHY_TYPE_SATA
+          - PHY_TYPE_SGMII
+          - PHY_TYPE_USB
+      - description: The PHY instance
+        minimum: 0
+        maximum: 1 # for DP, SATA or USB
+        maximum: 3 # for PCIE or SGMII
+      - description: The reference clock number
+        minimum: 0
+        maximum: 3
+
+  compatible:
+    enum:
+      - xlnx,zynqmp-psgtr-v1.1
+      - xlnx,zynqmp-psgtr
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Clock for each PS_MGTREFCLK[0-3] reference clock input. Unconnected
+      inputs shall not have an entry.
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      pattern: "^ref[0-3]$"
+
+  reg:
+    items:
+      - description: SERDES registers block
+      - description: SIOU registers block
+
+  reg-names:
+    items:
+      - const: serdes
+      - const: siou
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - reg-names
+
+if:
+  properties:
+    compatible:
+      const: xlnx,zynqmp-psgtr
+
+then:
+  properties:
+    xlnx,tx-termination-fix:
+      description: |
+        Include this for fixing functional issue with the TX termination
+        resistance in GT, which can be out of spec for the XCZU9EG silicon
+        version.
+      type: boolean
+
+additionalProperties: false
+
+examples:
+  - |
+    phy: phy@fd400000 {
+      compatible = "xlnx,zynqmp-psgtr-v1.1";
+      reg = <0x0 0xfd400000 0x0 0x40000>,
+            <0x0 0xfd3d0000 0x0 0x1000>;
+      reg-names = "serdes", "siou";
+      clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
+      clock-names = "ref1", "ref2", "ref3";
+      #phy-cells = <4>;
+      status = "okay";
+    };
+
+...
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 1f3f866fae7b..f6bc83b66ae9 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -17,5 +17,6 @@
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
 #define PHY_TYPE_DP		6
+#define PHY_TYPE_SGMII		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
Regards,

Laurent Pinchart

