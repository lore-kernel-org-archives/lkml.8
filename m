Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA27C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F171020658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgCPKht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:37:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:26973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbgCPKhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:37:48 -0400
IronPort-SDR: rTFpp8D6X+jrEEN2t3LqCf9Iyk6cYEef2JlnBOU7lmQfKtjtncupz9ukemesoakXCLAV/xAZ5A
 FsYqA+3tFEew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 03:37:48 -0700
IronPort-SDR: nJYOC8ABG9/Y71CZLfrtkevdQTgt8U0ZIFO13H6skBTJGV3P3G31pWTXsPBR6EUTm81qrfLgVT
 vKT+RdQ6Pt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="267522697"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 03:37:46 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for Keem Bay eMMC PHY
Date:   Mon, 16 Mar 2020 18:37:25 +0800
Message-Id: <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Intel Keem Bay eMMC PHY DT bindings.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/phy/intel,keembay-emmc-phy.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
new file mode 100644
index 000000000000..af1d62fc8323
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay eMMC PHY
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-emmc-phy
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
+  intel,syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      A phandle to a syscon device used to access core/phy configuration
+      registers.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - intel,syscon
+  - "#phy-cells"
+
+examples:
+  - |
+    mmc_phy_syscon: syscon@20290000 {
+          compatible = "simple-mfd", "syscon";
+          reg = <0x0 0x20290000 0x0 0x54>;
+    };
+
+    emmc_phy: mmc_phy@20290000 {
+          compatible = "intel,keembay-emmc-phy";
+          reg = <0x0 0x20290000 0x0 0x54>;
+          clocks = <&mmc>;
+          clock-names = "emmcclk";
+          intel,syscon = <&mmc_phy_syscon>;
+          #phy-cells = <0>;
+    };
-- 
2.17.1

