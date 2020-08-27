Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25F42078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YKLX3guM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgH0OFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:05:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59054 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH0Npm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:45:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07RDjBhL022110;
        Thu, 27 Aug 2020 08:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598535911;
        bh=5TD3DZKUhVTIBg9ToF8SbOEDPDgYWNIhElOSZbLFSco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YKLX3guMfPWKGjwen7PQbw6CO1XOeDdXEb0uzupeJCSSMkTmm9spe0FtWoc7WnE9R
         mma5G9cozT7mG+7+gftd09oJIKOunQT3J9ON56K5XsyFjYc5DOUZ8avMBiWdz5F47t
         tnZFu8G51JbPAsD3pZIiKHlaK16Shuj+B+oiV8yY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07RDjB9C073637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 08:45:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 27
 Aug 2020 08:45:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 27 Aug 2020 08:45:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07RDjADx024420;
        Thu, 27 Aug 2020 08:45:10 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dp83822: Add TI dp83822 phy
Date:   Thu, 27 Aug 2020 08:45:08 -0500
Message-ID: <20200827134509.23854-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200827134509.23854-1-dmurphy@ti.com>
References: <20200827134509.23854-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt binding for the TI dp83822 ethernet phy device.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/net/ti,dp83822.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83822.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
new file mode 100644
index 000000000000..55913534cbc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/net/ti,dp83822.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI DP83822 ethernet PHY
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The DP83822 is a low-power, single-port, 10/100 Mbps Ethernet PHY. It
+  provides all of the physical layer functions needed to transmit and receive
+  data over standard, twisted-pair cables or to connect to an external,
+  fiber-optic transceiver. Additionally, the DP83822 provides flexibility to
+  connect to a MAC through a standard MII, RMII, or RGMII interface
+
+  Specifications about the Ethernet PHY can be found at:
+    http://www.ti.com/lit/ds/symlink/dp83822i.pdf
+
+allOf:
+  - $ref: "ethernet-phy.yaml#"
+
+properties:
+  reg:
+    maxItems: 1
+
+  ti,link-loss-low:
+    type: boolean
+    description: |
+       DP83822 PHY in Fiber mode only.
+       Sets the DP83822 to detect a link drop condition when the signal goes
+       high.  If not set then link drop will occur when the signal goes low.
+       This property is only applicable if the fiber mode support is strapped
+       to on.
+
+  ti,fiber-mode:
+    type: boolean
+    description: |
+       DP83822 PHY only.
+       If present the DP83822 PHY is configured to operate in fiber mode
+       Fiber mode support can also be strapped. If the strap pin is not set
+       correctly or not set at all then this boolean can be used to enable it.
+       If the fiber mode is not strapped then signal detection for the PHY
+       is disabled.
+       In fiber mode, auto-negotiation is disabled and the PHY can only work in
+       100base-fx (full and half duplex) modes.
+
+  rx-internal-delay-ps:
+    description: |
+       DP83822 PHY only.
+       Setting this property to a non-zero number sets the RX internal delay
+       for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
+       to receive data.
+
+  tx-internal-delay-ps:
+    description: |
+       DP83822 PHY only.
+       Setting this property to a non-zero number sets the TX internal delay
+       for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
+       to transmit data.
+
+required:
+  - reg
+
+examples:
+  - |
+    mdio0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+        rx-internal-delay-ps = <1>;
+        tx-internal-delay-ps = <1>;
+      };
+    };
+
+...
-- 
2.28.0

