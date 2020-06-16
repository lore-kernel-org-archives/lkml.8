Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67068C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A5320882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgFPOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:40:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:9594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFPOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:40:06 -0400
IronPort-SDR: XXvYR06UNTmMiXyV2ySD/HQ9lu7iD4kjJSh6MMQYlH+lojK8ZOjy8+3mORA7fHTcKFeTHJHBfY
 RjVoQF7SGbLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 07:40:06 -0700
IronPort-SDR: DjYWutAvVakNFaTReYrsiqGYvDUEM6FYeKz2886CBhuUNbN7Ul5WLycLkVTTIYwNDAxm7MRFSk
 eJs9WpSFzB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="317238521"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2020 07:40:04 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, adrian.hunter@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 1/2] dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
Date:   Tue, 16 Jun 2020 22:38:17 +0800
Message-Id: <20200616143818.13579-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616143818.13579-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200616143818.13579-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay eMMC PHY.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/phy/intel,keembay-emmc-phy.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
new file mode 100644
index 000000000000..639f2b2d8950
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Intel Corporation
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

