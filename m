Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CADC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD97206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6u5Qtqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:04:07 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40843 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:04:06 -0500
Received: by mail-wr1-f50.google.com with SMTP id p2so2403420wrw.7;
        Fri, 06 Mar 2020 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YR0lCL3cHcMh4aBsrWN++mBdZnxvJMryxsPb/NXbbQ8=;
        b=o6u5QtqcDnHFlW4AlXezVmU/uA9dq87KpZSfKp2nyfH/+HQXOGKfNRHKravuP4gGkC
         JTDXc24U2zJwQLyMII6uw9F9Z8RevD52ddTzt41+vgdY+a7P3HMWBLl2WrlcS+y/EY+C
         tbklyIHpY3edWhCcStfOfndNlenJ6HADWfPPGFIKY7eRs6mndnMhYICQQY6E/s8dEAz5
         qVz8jnb7oZ045PUnV78EWmmiyOdJ7iqO8o+/0vMNmUsY/38pQYmxIm5thEQaYqxbXX4G
         ABKo6hfDjSG1dTIGSxPqUqqF3WY47u5jPiXfArig02OPvYP2G03bDxmDUDDvkHAJQ7Xc
         8tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YR0lCL3cHcMh4aBsrWN++mBdZnxvJMryxsPb/NXbbQ8=;
        b=IHNfVNYHQfyUEvomdv/PsXaXwo42E/6FI2oC3a8iVPeheVS79b0sOEf5R8pbenq1Gg
         gSm8DtJF02zK6LlREhSG8bKqU6usJYm6edO7DLP6ZmE6tN6RdnWMmpvp80hSnNKr9rj+
         3AhyzELJmD/hmw7Pd9WnLIDimjpGucrXWcJy85aB6f1ApDA1uaK/XqycB2/GOgcidJ11
         0yUbb4eOMGpeqzfv4yRn1Vlr8XN4p8ijF4EzwP2h+y0kCME2rOoofFQwHyvokDPS7OgH
         RdCKHgPpiuRZomhespJcv/3moQQeWAWmz3AAqllS91jGBY9UTfJZlkMV3BvZy8nZSBjM
         thaQ==
X-Gm-Message-State: ANhLgQ39xhYICt5SBN74my5KYPLtqb40dzope1pL9wyOiboDpnkmSADB
        er4qoL6kF0+kuCL+aVYl7lHONGtH
X-Google-Smtp-Source: ADFU+vs5y9JIqlSp5TU/9gFn3fOnI7lpknUYRYdnf9E1tYzf5UVe7kVdGvJZs6SLhcGoPWMH/D/Hpw==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr4761249wrq.424.1583514244345;
        Fri, 06 Mar 2020 09:04:04 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m3sm30646392wrx.9.2020.03.06.09.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 09:04:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: display: rockchip: convert rockchip vop bindings to yaml
Date:   Fri,  6 Mar 2020 18:03:53 +0100
Message-Id: <20200306170353.11393-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'vop' nodes are manually verified.
In order to automate this process rockchip-vop.txt
has to be converted to yaml. Also included are new
properties needed for the latest Rockchip Socs.

Added properties:
  assigned-clocks
  assigned-clock-rates
  power-domains
  rockchip,grf

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |  74 -----------
 .../bindings/display/rockchip/rockchip-vop.yaml    | 141 +++++++++++++++++++++
 2 files changed, 141 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
deleted file mode 100644
index 8b3a5f514..000000000
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-device-tree bindings for rockchip soc display controller (vop)
-
-VOP (Visual Output Processor) is the Display Controller for the Rockchip
-series of SoCs which transfers the image data from a video memory
-buffer to an external LCD interface.
-
-Required properties:
-- compatible: value should be one of the following
-		"rockchip,rk3036-vop";
-		"rockchip,rk3126-vop";
-		"rockchip,px30-vop-lit";
-		"rockchip,px30-vop-big";
-		"rockchip,rk3066-vop";
-		"rockchip,rk3188-vop";
-		"rockchip,rk3288-vop";
-		"rockchip,rk3368-vop";
-		"rockchip,rk3366-vop";
-		"rockchip,rk3399-vop-big";
-		"rockchip,rk3399-vop-lit";
-		"rockchip,rk3228-vop";
-		"rockchip,rk3328-vop";
-
-- reg: Must contain one entry corresponding to the base address and length
-	of the register space. Can optionally contain a second entry
-	corresponding to the CRTC gamma LUT address.
-
-- interrupts: should contain a list of all VOP IP block interrupts in the
-		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-		 format depends on the interrupt controller used.
-
-- clocks: must include clock specifiers corresponding to entries in the
-		clock-names property.
-
-- clock-names: Must contain
-		aclk_vop: for ddr buffer transfer.
-		hclk_vop: for ahb bus to R/W the phy regs.
-		dclk_vop: pixel clock.
-
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - axi
-  - ahb
-  - dclk
-
-- iommus: required a iommu node
-
-- port: A port node with endpoint definitions as defined in
-  Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Example:
-SoC specific DT entry:
-	vopb: vopb@ff930000 {
-		compatible = "rockchip,rk3288-vop";
-		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
-		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
-		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
-		reset-names = "axi", "ahb", "dclk";
-		iommus = <&vopb_mmu>;
-		vopb_out: port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			vopb_out_edp: endpoint@0 {
-				reg = <0>;
-				remote-endpoint=<&edp_in_vopb>;
-			};
-			vopb_out_hdmi: endpoint@1 {
-				reg = <1>;
-				remote-endpoint=<&hdmi_in_vopb>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
new file mode 100644
index 000000000..93ccd32aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip-vop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip soc display controller (VOP)
+
+description:
+  VOP (Visual Output Processor) is the Display Controller for the Rockchip
+  series of SoCs which transfers the image data from a video memory
+  buffer to an external LCD interface.
+
+maintainers:
+  - Sandy Huang <hjc@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,px30-vop-big
+      - const: rockchip,px30-vop-lit
+      - const: rockchip,rk3036-vop
+      - const: rockchip,rk3066-vop
+      - const: rockchip,rk3126-vop
+      - const: rockchip,rk3188-vop
+      - const: rockchip,rk3228-vop
+      - const: rockchip,rk3288-vop
+      - const: rockchip,rk3328-vop
+      - const: rockchip,rk3366-vop
+      - const: rockchip,rk3368-vop
+      - const: rockchip,rk3399-vop-big
+      - const: rockchip,rk3399-vop-lit
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          Must contain one entry corresponding to the base address and length
+          of the register space.
+      - description:
+          Can optionally contain a second entry corresponding to
+          the CRTC gamma LUT address.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Should contain a list of all VOP IP block interrupts in the
+      order VSYNC, LCD_SYSTEM. The interrupt specifier
+      format depends on the interrupt controller used.
+
+  clocks:
+    items:
+      - description: Clock for ddr buffer transfer.
+      - description: Pixel clock.
+      - description: Clock for the ahb bus to R/W the phy regs.
+
+  clock-names:
+    items:
+      - const: aclk_vop
+      - const: dclk_vop
+      - const: hclk_vop
+
+  resets:
+    minItems: 3
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: dclk
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+  assigned-clocks:
+    maxItems: 2
+
+  assigned-clock-rates:
+    maxItems: 2
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for
+      the general register file (GRF).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    vopb: vopb@ff930000 {
+      compatible = "rockchip,rk3288-vop";
+      reg = <0x0 0xff930000 0x0 0x19c>,
+            <0x0 0xff931000 0x0 0x1000>;
+      interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_VOP0>,
+               <&cru DCLK_VOP0>,
+               <&cru HCLK_VOP0>;
+      clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+      resets = <&cru SRST_LCDC1_AXI>,
+               <&cru SRST_LCDC1_AHB>,
+               <&cru SRST_LCDC1_DCLK>;
+      reset-names = "axi", "ahb", "dclk";
+      iommus = <&vopb_mmu>;
+      vopb_out: port {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        vopb_out_edp: endpoint@0 {
+          reg = <0>;
+          remote-endpoint=<&edp_in_vopb>;
+        };
+        vopb_out_hdmi: endpoint@1 {
+          reg = <1>;
+          remote-endpoint=<&hdmi_in_vopb>;
+        };
+      };
+    };
-- 
2.11.0

