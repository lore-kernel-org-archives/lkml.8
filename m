Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35CCC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911192080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GCcEMYyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBJIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:12:32 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3645 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41102f0000>; Mon, 10 Feb 2020 00:11:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:30 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:29 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41106a0000>; Mon, 10 Feb 2020 00:12:28 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 02/21] dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
Date:   Mon, 10 Feb 2020 13:41:28 +0530
Message-ID: <1581322307-11140-3-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322287; bh=xL7kQ/KWlZkGepoN2jkiRaQFt/AncKqbOrKpKkGcZoE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GCcEMYyYkq0c4NllYfRhpudRBQcKhSeKDDFexRicZYt+soYbnb/MWyPWMxG8I6VwD
         ntzIZRz2ymTOAXE1YGHfp0AdRGBsH1gAEHYJQuI+y0YDZHL9xzcAc3bJ+Ximj+2U85
         ete62bz/trYDuojDJ+oZmO/o4Arn/JGHhEXY4RwE/TlcAg7/JDDGfIY3TWrydb4Ju4
         tNDWu0P3VRTzT/Lna4tTMrVue3FPDNPFVwiAuHNmdAxU8yqxM6tMmjIsc7zxeeMaII
         7yCWfODTWTCxFKf/gAtWmJkBrvGRsiuqa0UppRj9zcO7x8ZARLjbKE2bLZSvPbjmoe
         9ErBm7s/c4ZiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation for the XUSB device mode controller
present on Tegra210 and Tegra186 SoC. This controller supports the USB 3.0
specification.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4-V5:
 - No changes.
---
V3:
 - Added Reviewed-by and Acked-by updates to commit message.
---
V2:
 - used enum instead of oneOf and const.
 - Moved reg, reg-names, clocks, clock-names to property section from allOf.
 - Limited allOf to min and max items based on soc.
 - Updated description for power-domains.
 - Added V1 reference
---
V1
 - This document is yaml version of [1], with difference of usb-role-switch
   removal.
[1] https://patchwork.kernel.org/patch/11156253/ 
---
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 +++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
new file mode 100644
index 0000000..b84ed8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
+
+description:
+  The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
+  USB 3.0 SuperSpeed protocols.
+
+maintainers:
+  - Nagarjuna Kristam <nkristam@nvidia.com>
+  - JC Kuo <jckuo@nvidia.com>
+  - Thierry Reding <treding@nvidia.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nvidia,tegra210-xudc # For Tegra210
+          - nvidia,tegra186-xudc # For Tegra186
+
+  reg:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: XUSB device controller registers
+      - description: XUSB device PCI Config registers
+      - description: XUSB device registers.
+
+  reg-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      - const: base
+      - const: fpci
+      - const: ipfs
+
+  interrupts:
+    maxItems: 1
+    description: Must contain the XUSB device interrupt.
+
+  clocks:
+    minItems: 4
+    maxItems: 5
+    items:
+      - description: Clock to enable core XUSB dev clock.
+      - description: Clock to enable XUSB super speed clock.
+      - description: Clock to enable XUSB super speed dev clock.
+      - description: Clock to enable XUSB high speed dev clock.
+      - description: Clock to enable XUSB full speed dev clock.
+
+  clock-names:
+    minItems: 4
+    maxItems: 5
+    items:
+     - const: dev
+     - const: ss
+     - const: ss_src
+     - const: fs_src
+     - const: hs_src
+
+  power-domains:
+    maxItems: 2
+    items:
+      - description: XUSBB(device) power-domain
+      - description: XUSBA(superspeed) power-domain
+
+  power-domain-names:
+    maxItems: 2
+    items:
+      - const: dev
+      - const: ss
+
+  nvidia,xusb-padctl:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      phandle to the XUSB pad controller that is used to configure the USB pads
+      used by the XUDC controller.
+
+  phys:
+    minItems: 1
+    description:
+      Must contain an entry for each entry in phy-names.
+      See ../phy/phy-bindings.txt for details.
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: usb2-0
+      - const: usb2-1
+      - const: usb2-2
+      - const: usb2-3
+      - const: usb3-0
+      - const: usb3-1
+      - const: usb3-2
+      - const: usb3-3
+
+  avddio-usb-supply:
+    description: PCIe/USB3 analog logic power supply. Must supply 1.05 V.
+
+  hvdd-usb-supply:
+    description: USB controller power supply. Must supply 3.3 V.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - nvidia,xusb-padctl
+  - phys
+  - phy-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-xudc
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reg-names:
+          minItems: 3
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+      required:
+        - avddio-usb-supply
+        - hvdd-usb-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-xudc
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          maxItems: 2
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@700d0000 {
+        compatible = "nvidia,tegra210-xudc";
+        reg = <0x0 0x700d0000 0x0 0x8000>,
+              <0x0 0x700d8000 0x0 0x1000>,
+              <0x0 0x700d9000 0x0 0x1000>;
+        reg-names = "base", "fpci", "ipfs";
+
+        interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
+                 <&tegra_car TEGRA210_CLK_XUSB_SS>,
+                 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
+                 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>,
+                 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>;
+        clock-names = "dev", "ss", "ss_src", "fs_src", "hs_src";
+
+        power-domains = <&pd_xusbdev>, <&pd_xusbss>;
+        power-domain-names = "dev", "ss";
+
+        nvidia,xusb-padctl = <&padctl>;
+
+        phys = <&micro_b>;
+        phy-names = "usb2-0";
+
+        avddio-usb-supply = <&vdd_pex_1v05>;
+        hvdd-usb-supply = <&vdd_3v3_sys>;
+    };
-- 
2.7.4

