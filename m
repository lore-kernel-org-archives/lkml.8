Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8161720724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHULmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:42:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:14303 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgHULju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:39:50 -0400
IronPort-SDR: fgUnRgWQzunzS5OIwHzKX9K2ggJI2gXIkuwK4CZyTCWr+z+ys+ajGa0+6KV9eD8WRcN2/ZPmj9
 1FJLWiihfpRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143305584"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143305584"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 04:39:44 -0700
IronPort-SDR: JVTI3XBCtwgCkEz1A7Ppe+paPAV42meD9gCCamrSIwPKnJb2dmRDzWXT8fObjR9LHZpL44ahCu
 qnIgU8SRVX/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327740415"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 04:39:42 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
Date:   Fri, 21 Aug 2020 19:37:46 +0800
Message-Id: <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay eMMC PHY.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/intel,keembay-emmc-phy.yaml  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
new file mode 100644
index 000000000000..4cbbd3887c13
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay eMMC PHY bindings
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+    const: intel,keembay-emmc-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: emmcclk
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@20290000 {
+          compatible = "intel,keembay-emmc-phy";
+          reg = <0x20290000 0x54>;
+          clocks = <&emmc>;
+          clock-names = "emmcclk";
+          #phy-cells = <0>;
+    };
-- 
2.17.1

