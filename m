Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369D9212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ID1EvhNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgFQSU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:20:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51610 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:20:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05HIKlau058353;
        Wed, 17 Jun 2020 13:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592418047;
        bh=9YzsGgvzf8JqwO3Rel1UX3fG2CArvUoADEzxwh+jRns=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ID1EvhNoBZ5WzZrXWjfC27EQB1VHfWa4hlNkAhytWMjKuebDV7u9bU4oyJKJEyK7O
         i/tirq5iqf2HBv9k3rg6tPueLW2EBk2kqBsybzCdtm8HgJvhjEOovWqDhnMudR4AYl
         y9qrRhkblZ8sinZ67k6TgAqMnAwU6RT2wXaET6Bs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05HIKlDR116158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jun 2020 13:20:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 17
 Jun 2020 13:20:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 17 Jun 2020 13:20:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05HIKlL8129580;
        Wed, 17 Jun 2020 13:20:47 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v7 5/6] dt-bindings: net: dp83822: Add TI dp83822 phy
Date:   Wed, 17 Jun 2020 13:20:18 -0500
Message-ID: <20200617182019.6790-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617182019.6790-1-dmurphy@ti.com>
References: <20200617182019.6790-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt binding for the TI dp83822 ethernet phy device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/net/ti,dp83822.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83822.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
new file mode 100644
index 000000000000..09e0e5fd88e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/net/ti,dp83822.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI DP83822 ethernet PHY
+
+allOf:
+  - $ref: "ethernet-phy.yaml#"
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
+  Specifications about the charger can be found at:
+    http://www.ti.com/lit/ds/symlink/dp83822i.pdf
+
+properties:
+  reg:
+    maxItems: 1
+
+  rx-internal-delay-ps:
+    description: Enables the RX fixed internal delay of 3.5ns.
+    default: 3500
+
+  tx-internal-delay-ps:
+    description: Enables the TX fixed internal delay of 3.5ns.
+    default: 3500
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
+        rx-internal-delay-ps = <3500>;
+        tx-internal-delay-ps = <3500>;
+      };
+    };
-- 
2.26.2

