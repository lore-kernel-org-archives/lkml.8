Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E956206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFKCOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:14:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:34853 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgFKCOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:14:30 -0400
IronPort-SDR: jzFqMHkn2R7rstCXA9RliGyxXeSJoea2bxh7+GGMy4QGU7V/SD8t0yVUJd9lywtgWYUnp1HAgt
 rsgl/gdkR9eQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 19:14:29 -0700
IronPort-SDR: jOhxUCI3nq8MORS0dfmzTWNXHTnAN8YKQmBuaAzgU3YCQrNU6NiM+Kzn6Oqj56jxDEPVISc3Zx
 iBkGXv9/MWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="418953095"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2020 19:14:27 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: Add USB PHY support for Intel LGM SoC
Date:   Thu, 11 Jun 2020 10:12:45 +0800
Message-Id: <20200611021246.3250-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add the dt-schema to support USB PHY on Intel LGM SoC

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/usb/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml
new file mode 100644
index 000000000000..0fc76cd23774
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/intel,lgm-usb-phy.yaml#
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
+required:
+  - compatible
+  - clocks
+  - reg
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    usb_phy: usb_phy@e7e00000 {
+        compatible = "intel,lgm-usb-phy";
+        reg = <0xe7e00000 0x10000>;
+        clocks = <&cgu0 153>;
+        resets = <&rcu 0x70 0x24>,
+                 <&rcu 0x70 0x26>,
+                 <&rcu 0x70 0x28>;
+        reset-names = "phy", "apb", "phy31";
+    };
-- 
2.11.0

