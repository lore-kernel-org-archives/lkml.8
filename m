Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E61C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6572207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgFILKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:10:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:44274 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFILKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:10:44 -0400
IronPort-SDR: UaNy+SqA4nnoshHFJFo7B0ss21eUA5gZKfrS6DQ8UFnh1ImlNrKC1QNmDHC1n2KZHH/Xemm3T+
 7NYQtUWEEcbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 04:10:32 -0700
IronPort-SDR: BvdolLA2BS53bFjvL6VJ7sqBdI5/1dyPApx0bp0MY3+aEkARfJBVcKRccxnrOrHpx/YuM6zy+T
 7n+Wccjl4gfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="270856935"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2020 04:10:28 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 1/2] dt-bindings: usb: Add USB PHY support for Intel LGM SoC
Date:   Tue,  9 Jun 2020 19:08:49 +0800
Message-Id: <20200609110850.43469-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200609110850.43469-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200609110850.43469-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

