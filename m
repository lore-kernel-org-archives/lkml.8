Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52307C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3849520786
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgH1CXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:23:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:43689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgH1CXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:23:22 -0400
IronPort-SDR: KG1qOdteCZHn0h5okk4vtVd1uFQ3CWplVUNiStxziksvEJYUNbm5x5NjkufYnNdOlLYkgVDMbL
 ZEmeCG62AOxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136141623"
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="136141623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 19:23:22 -0700
IronPort-SDR: XVLI9TFoFx70WQs8U7Un4I1LeyyksgUWi8hAB59hfJq6JSq4UVItoMWYwGmuH73U+9PZn+K9AD
 cOGLxEHcJu4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="475479860"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 19:23:19 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        balbi@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 1/2] dt-bindings: phy: Add USB PHY support for Intel LGM SoC
Date:   Fri, 28 Aug 2020 10:23:11 +0800
Message-Id: <20200828022312.52724-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add the dt-schema to support USB PHY on Intel LGM SoC

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
new file mode 100644
index 000000000000..ce62c0b94daf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,lgm-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel LGM USB PHY Device Tree Bindings
+
+maintainers:
+  - Vadivel Murugan Ramuthevar <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-usb-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: USB PHY and Host controller reset
+      - description: APB BUS reset
+      - description: General Hardware reset
+
+  reset-names:
+    items:
+      - const: phy
+      - const: apb
+      - const: phy31
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@e7e00000 {
+        compatible = "intel,lgm-usb-phy";
+        reg = <0xe7e00000 0x10000>;
+        clocks = <&cgu0 153>;
+        resets = <&rcu 0x70 0x24>,
+                 <&rcu 0x70 0x26>,
+                 <&rcu 0x70 0x28>;
+        reset-names = "phy", "apb", "phy31";
+        #phy-cells = <0>;
+    };
-- 
2.11.0

