Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20EBC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA7E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXF9HzEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgCKNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:05:33 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41873 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgCKNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:05:33 -0400
Received: by mail-wr1-f47.google.com with SMTP id s14so2500523wrt.8;
        Wed, 11 Mar 2020 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AhLkhUvdXLfO1SrTt7a8DDpSIYACsGN+xMVAxW5xB8M=;
        b=mXF9HzEtB49zv112z2A8Vvho3B+cvcgVwObY0OKhMIIH0zMdzxIODt0Vg8N8IXQW+a
         BYud6KydFWAaPuTpjxPwQn3MpdLCSItW9dq76Xu5t0IXhqV3lZXq9DQZBYhLFmkH9lut
         mFotv9s4g3TkexMUQ2HGK9DsSDG1Kr77JWRepmuJZ5T+fa/cQqCfk2Za2nRkVJV2uJiv
         NwFi5xgjYLx1yasq9tLUKKLTh8J0ZFmVEPU7lfbwJwBG9FP0uTiHy58OcXopIYsYHmU9
         R2rCP964fW3UgdzIoht5/tTBOALSrdLQSTyh5dEXCIcTjw1L3oCmggFgVPRDx92R6Ska
         OVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AhLkhUvdXLfO1SrTt7a8DDpSIYACsGN+xMVAxW5xB8M=;
        b=EZiaLxKn1NcW+CDKF6B20tGLK/p3QyrDPWKsavINADq/QSgPwB6PSPREtsJkMjAT7k
         rQVPF21ElCiSqZMBiE51gjx6ehcGLZEQhs7NRMmKs4NCkT+eIMzBwphCuM6wwyzzRPpi
         Ea/scSfOY3Po/L1yzIlQw//n5L1lCQjKw8dJOH2M6TF6ARwbHs3aAkn7wR6/KHQkiAgk
         GP7hs2LIJKdo5D5utnz1KKThpYAZGOr3phLaa09NljI/ds+tDNMqMisFvndXiUSdk70Z
         7vsCVRHgDkfejsJ5yyYqU4r/O3gTNCeTLjTjbtdWh2S2Pkh9/hUDsSWhDrIZTYFht6nD
         ETfw==
X-Gm-Message-State: ANhLgQ2KN4qyZDGRzYZdDJUT/tblb7nrvxvY+S0hw6vDgxqf9SYO9ugl
        86PhwNrQ5vuNTBjXNDS34ps=
X-Google-Smtp-Source: ADFU+vtmZ8OBwTwqf9IfppxfqWVwowjIoq/aKh+H9Xn5exxfAlSTYe0p2TQSbD+CzHz9OEbbKlBwtQ==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr4223866wrw.99.1583931929923;
        Wed, 11 Mar 2020 06:05:29 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p10sm69291517wrx.81.2020.03.11.06.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 06:05:29 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: convert rockchip vop bindings to yaml
Date:   Wed, 11 Mar 2020 14:05:15 +0100
Message-Id: <20200311130515.10663-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'vop' nodes are manually verified.
In order to automate this process rockchip-vop.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  No new properties
---
 .../bindings/display/rockchip/rockchip-vop.txt     |  74 ------------
 .../bindings/display/rockchip/rockchip-vop.yaml    | 126 +++++++++++++++++++++
 2 files changed, 126 insertions(+), 74 deletions(-)
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
index 000000000..cb88849f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
@@ -0,0 +1,126 @@
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
+  iommus:
+    maxItems: 1
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

