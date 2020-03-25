Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BDEC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03F520772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeg4XdTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYMNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:13:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:13:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so2815341wrd.0;
        Wed, 25 Mar 2020 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hOl/owfaYb87sP9mVjhujvo/kAvWxhYs1nSOGilmW4A=;
        b=jeg4XdTKu/XvPZ1Xt3cF8yIQaKYs5aWC2NHt59RttrPbt0SqxL2nONJvUXDtWR3VsM
         he/pJZaKOoztPwWFclpqXDea5mIxyMAXnmrmQBRA3Lo1X2D0c9AtixK0wOl5PJVOKxsP
         dtrIBzMNlVI0yIXWPyGzcLXIg6VTsUTkqvOFD5AaYZZLdfWhWub+Ai197xzoUIYQdOiB
         U+EuUQvyxX0Cwf6/0k68URomy6Raj2+HVNMsmLdVBBVrJhxocwaam1YWoKzvZ3XSTdIn
         g4z0cAGsqFFqmCd0myDe/h4G3ntMr5OezQaQCanFHA92fGQDPU+iQbhOOfQ9I6iodafQ
         Zs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hOl/owfaYb87sP9mVjhujvo/kAvWxhYs1nSOGilmW4A=;
        b=XpYh76mfoMyrsm6us0FLyZVdZK7ZR3jhDh5i6ONH8ln5Io3tPpOBtGrHTa4mPz9BUk
         FEI0//fCvZRorNNe2h9HSkdqs904o49f5BYVMhXc8bGZ6VMR47ZJVn5l+a3newSujdDz
         hIq/o1QM9dzpYv8YW4TR1NE6Cu6PcAbWUiz79evhEmOAG4K0ZZXY3HUKgYQVqvkLYvWL
         eyZ7ZG5HhczO/qij/lvXbL8K5UmRZ7hwxwWQMN+qJO0pzJOVuBspWzi1sjSeFlogrcgH
         ZDDUJU5wf7EvK6bxLLs3US0fwVPy3rYSqD3h/v2v46pUBatl4nO0AC5k7NnUu7B/0xHM
         zQ9Q==
X-Gm-Message-State: ANhLgQ1SBDVtTPJdUpG5U+8he/QNjBwVrryEu0pc+XlZpVyWFpKO+qPG
        BiWlvninZiu+cWOcSk666+M=
X-Google-Smtp-Source: ADFU+vsAfNfD810hUfVVo81ck+67IHCKX2XgtJjX/9gCIeuNFKMXkmYoMLeOykpyMlq1qsRO68Tlig==
X-Received: by 2002:a5d:4e05:: with SMTP id p5mr3120806wrt.59.1585138421936;
        Wed, 25 Mar 2020 05:13:41 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k9sm35010397wrd.74.2020.03.25.05.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 05:13:41 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     kishon@ti.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: phy: convert phy-rockchip-inno-usb2 bindings to yaml
Date:   Wed, 25 Mar 2020 13:13:35 +0100
Message-Id: <20200325121335.12249-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files for Rockchip with 'usb2-phy' subnodes
are manually verified. In order to automate this process
phy-rockchip-inno-usb2.txt has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v3:
  Replace oneOf by enum
  Remove allOf phy-provider.yaml
  Add "#phy-cells"
  Add additionalProperties: false

Changes v2:
  Keep "rockchip,rk3366-usb2phy" support.
  Add "#phy-cells" to example.
  Add allOf phy-provider.yaml
---
 .../bindings/phy/phy-rockchip-inno-usb2.txt        |  81 -----------
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 155 +++++++++++++++++++++
 2 files changed, 155 insertions(+), 81 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
deleted file mode 100644
index 541f52988..000000000
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-ROCKCHIP USB2.0 PHY WITH INNO IP BLOCK
-
-Required properties (phy (parent) node):
- - compatible : should be one of the listed compatibles:
-	* "rockchip,px30-usb2phy"
-	* "rockchip,rk3228-usb2phy"
-	* "rockchip,rk3328-usb2phy"
-	* "rockchip,rk3366-usb2phy"
-	* "rockchip,rk3399-usb2phy"
-	* "rockchip,rv1108-usb2phy"
- - reg : the address offset of grf for usb-phy configuration.
- - #clock-cells : should be 0.
- - clock-output-names : specify the 480m output clock name.
-
-Optional properties:
- - clocks : phandle + phy specifier pair, for the input clock of phy.
- - clock-names : input clock name of phy, must be "phyclk".
- - assigned-clocks : phandle of usb 480m clock.
- - assigned-clock-parents : parent of usb 480m clock, select between
-		 usb-phy output 480m and xin24m.
-		 Refer to clk/clock-bindings.txt for generic clock
-		 consumer properties.
- - rockchip,usbgrf : phandle to the syscon managing the "usb general
-		 register files". When set driver will request its
-		 phandle as one companion-grf for some special SoCs
-		 (e.g RV1108).
- - extcon : phandle to the extcon device providing the cable state for
-		 the otg phy.
-
-Required nodes : a sub-node is required for each port the phy provides.
-		 The sub-node name is used to identify host or otg port,
-		 and shall be the following entries:
-	* "otg-port" : the name of otg port.
-	* "host-port" : the name of host port.
-
-Required properties (port (child) node):
- - #phy-cells : must be 0. See ./phy-bindings.txt for details.
- - interrupts : specify an interrupt for each entry in interrupt-names.
- - interrupt-names : a list which should be one of the following cases:
-	Regular case:
-	* "otg-id" : for the otg id interrupt.
-	* "otg-bvalid" : for the otg vbus interrupt.
-	* "linestate" : for the host/otg linestate interrupt.
-	Some SoCs use one interrupt with the above muxed together, so for these
-	* "otg-mux" : otg-port interrupt, which mux otg-id/otg-bvalid/linestate
-		to one.
-
-Optional properties:
- - phy-supply : phandle to a regulator that provides power to VBUS.
-		See ./phy-bindings.txt for details.
-
-Example:
-
-grf: syscon@ff770000 {
-	compatible = "rockchip,rk3366-grf", "syscon", "simple-mfd";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-...
-
-	u2phy: usb2-phy@700 {
-		compatible = "rockchip,rk3366-usb2phy";
-		reg = <0x700 0x2c>;
-		#clock-cells = <0>;
-		clock-output-names = "sclk_otgphy0_480m";
-
-		u2phy_otg: otg-port {
-			#phy-cells = <0>;
-			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "otg-id", "otg-bvalid", "linestate";
-		};
-
-		u2phy_host: host-port {
-			#phy-cells = <0>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "linestate";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
new file mode 100644
index 000000000..cb71561a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-inno-usb2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip USB2.0 phy with inno IP block
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-usb2phy
+      - rockchip,rk3228-usb2phy
+      - rockchip,rk3328-usb2phy
+      - rockchip,rk3366-usb2phy
+      - rockchip,rk3399-usb2phy
+      - rockchip,rv1108-usb2phy
+
+  reg:
+    maxItems: 1
+
+  clock-output-names:
+    description:
+      The usb 480m output clock name.
+
+  "#clock-cells":
+    const: 0
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: phyclk
+
+  assigned-clocks:
+    description:
+      Phandle of the usb 480m clock.
+
+  assigned-clock-parents:
+    description:
+      Parent of the usb 480m clock.
+      Select between usb-phy output 480m and xin24m.
+      Refer to clk/clock-bindings.txt for generic clock consumer properties.
+
+  extcon:
+    description:
+      Phandle to the extcon device providing the cable state for the otg phy.
+
+  rockchip,usbgrf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'usb general register files'.
+      When set the driver will request its phandle as one companion-grf
+      for some special SoCs (e.g rv1108).
+
+  host-port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#phy-cells":
+        const: 0
+
+      interrupts:
+        description: host linestate interrupt
+
+      interrupt-names:
+        const: linestate
+
+      phy-supply:
+        description:
+          Phandle to a regulator that provides power to VBUS.
+          See ./phy-bindings.txt for details.
+
+    required:
+      - "#phy-cells"
+      - interrupts
+      - interrupt-names
+
+  otg-port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#phy-cells":
+        const: 0
+
+      interrupts:
+        minItems: 1
+        maxItems: 3
+
+      interrupt-names:
+        oneOf:
+          - const: linestate
+          - const: otg-mux
+          - items:
+            - const: otg-bvalid
+            - const: otg-id
+            - const: linestate
+
+      phy-supply:
+        description:
+          Phandle to a regulator that provides power to VBUS.
+          See ./phy-bindings.txt for details.
+
+    required:
+      - "#phy-cells"
+      - interrupts
+      - interrupt-names
+
+required:
+  - compatible
+  - reg
+  - clock-output-names
+  - "#clock-cells"
+  - "#phy-cells"
+  - host-port
+  - otg-port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    u2phy0: usb2-phy@e450 {
+      compatible = "rockchip,rk3399-usb2phy";
+      reg = <0xe450 0x10>;
+      clocks = <&cru SCLK_USB2PHY0_REF>;
+      clock-names = "phyclk";
+      clock-output-names = "clk_usbphy0_480m";
+      #clock-cells = <0>;
+      #phy-cells = <0>;
+
+      u2phy0_host: host-port {
+        #phy-cells = <0>;
+        interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "linestate";
+      };
+
+      u2phy0_otg: otg-port {
+        #phy-cells = <0>;
+        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "otg-bvalid", "otg-id", "linestate";
+      };
+    };
-- 
2.11.0

