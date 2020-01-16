Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D77C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C662072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAPLKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:10:52 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49835 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPLKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:10:52 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 41FD2E0017;
        Thu, 16 Jan 2020 11:10:46 +0000 (UTC)
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
Subject: [PATCH v5 3/7] dt-bindings: PCI: meson: Update PCIE bindings documentation
Date:   Thu, 16 Jan 2020 12:18:46 +0100
Message-Id: <20200116111850.23690-4-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116111850.23690-1-repk@triplefau.lt>
References: <20200116111850.23690-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a new PHYs has been introduced for AXG SoC family, update
dt bindings documentation.

Please note that this breaks backward compatibility but as not a single
devicetree uses that yet that seems ok.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 .../bindings/pci/amlogic,meson-pcie.txt       | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
index 84fdc422792e..b6acbe694ffb 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -18,7 +18,6 @@ Required properties:
 - reg-names: Must be
 	- "elbi"	External local bus interface registers
 	- "cfg"		Meson specific registers
-	- "phy"		Meson PCIE PHY registers for AXG SoC Family
 	- "config"	PCIe configuration space
 - reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
 - clocks: Must contain an entry for each entry in clock-names.
@@ -26,13 +25,13 @@ Required properties:
 	- "pclk"       PCIe GEN 100M PLL clock
 	- "port"       PCIe_x(A or B) RC clock gate
 	- "general"    PCIe Phy clock
-	- "mipi"       PCIe_x(A or B) 100M ref clock gate for AXG SoC Family
 - resets: phandle to the reset lines.
-- reset-names: must contain "phy" "port" and "apb"
-       - "phy"         Share PHY reset for AXG SoC Family
+- reset-names: must contain "port" and "apb"
        - "port"        Port A or B reset
        - "apb"         Share APB reset
-- phys: should contain a phandle to the shared phy for G12A SoC Family
+- phys: should contain a phandle to the PCIE phy
+- phy-names: must contain "pcie"
+
 - device_type:
 	should be "pci". As specified in designware-pcie.txt
 
@@ -43,9 +42,8 @@ Example configuration:
 			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
 			reg = <0x0 0xf9800000 0x0 0x400000
 					0x0 0xff646000 0x0 0x2000
-					0x0 0xff644000 0x0 0x2000
 					0x0 0xf9f00000 0x0 0x100000>;
-			reg-names = "elbi", "cfg", "phy", "config";
+			reg-names = "elbi", "cfg", "config";
 			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
 			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
@@ -58,17 +56,15 @@ Example configuration:
 			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
 
 			clocks = <&clkc CLKID_USB
-					&clkc CLKID_MIPI_ENABLE
 					&clkc CLKID_PCIE_A
 					&clkc CLKID_PCIE_CML_EN0>;
 			clock-names = "general",
-					"mipi",
 					"pclk",
 					"port";
-			resets = <&reset RESET_PCIE_PHY>,
-				<&reset RESET_PCIE_A>,
+			resets = <&reset RESET_PCIE_A>,
 				<&reset RESET_PCIE_APB>;
-			reset-names = "phy",
-					"port",
+			reset-names = "port",
 					"apb";
+			phys = <&pcie_phy>;
+			phy-names = "pcie";
 	};
-- 
2.24.1

