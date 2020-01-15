Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B118C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D061B207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgAOMWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:22:20 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47399 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgAOMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:22:19 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5A2A3C000E;
        Wed, 15 Jan 2020 12:22:16 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 2/7] dt-bindings: Add AXG shared MIPI/PCIE PHY bindings
Date:   Wed, 15 Jan 2020 13:29:03 +0100
Message-Id: <20200115122908.16954-3-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115122908.16954-1-repk@triplefau.lt>
References: <20200115122908.16954-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the shared MIPI/PCIE PHYs found in AXG SoCs.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 .../phy/amlogic,meson-axg-mipi-pcie.yaml      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
new file mode 100644
index 000000000000..3184146318cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-mipi-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic AXG shared MIPI/PCIE PHY
+
+maintainers:
+  - Remi Pommarel <repk@triplefau.lt>
+
+properties:
+  compatible:
+    const: amlogic,axg-mipi-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+examples:
+  - |
+    mpphy: phy@0 {
+          compatible = "amlogic,axg-mipi-pcie-phy";
+          reg = <0x0 0x0 0x0 0xc>;
+          #phy-cells = <1>;
+    };
-- 
2.24.1

