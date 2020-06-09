Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67623C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46564207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFIHsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 03:48:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:55638 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgFIHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:48:04 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0E980C3810;
        Tue,  9 Jun 2020 15:40:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from ubuntu18.lan (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31250T139912844142336S1591688422511107_;
        Tue, 09 Jun 2020 15:40:29 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <eff317781d3eb59a5582b697a7d81b16>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v6 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
Date:   Tue,  9 Jun 2020 15:40:18 +0800
Message-Id: <20200609074020.23860-2-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation support for Rockchip RK3xxx NAND flash controllers

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v6:
- Fix some wrong define
- Modified the definition of compatible

Changes in v5:
- Fix some wrong define
- Add boot-medium define
- Remove some compatible define

Changes in v4:
- The compatible define with rkxx_nfc
- Add assigned-clocks
- Fix some wrong define

Changes in v3:
- Change the title for the dt-bindings

Changes in v2: None

 .../mtd/rockchip,nand-controller.yaml         | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml

diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
new file mode 100644
index 000000000000..f753fe8248aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/rockchip,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoCs NAND FLASH Controller (NFC)
+
+allOf:
+  - $ref: "nand-controller.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,px30-nfc
+      - const: rockchip,rk2928-nfc
+      - const: rockchip,rv1108-nfc
+      - items:
+          - const: rockchip,rk3326-nfc
+          - const: rockchip,px30-nfc
+      - items:
+          - const: rockchip,rk3036-nfc
+          - const: rockchip,rk2928-nfc
+      - items:
+          - const: rockchip,rk3308-nfc
+          - const: rockchip,rv1108-nfc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ahb
+      - const: nfc
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  pinctrl-0:
+    maxItems: 1
+
+  pinctrl-names:
+    const: default
+
+  power-domains:
+     maxItems: 1
+
+patternProperties:
+  "^nand@[a-f0-9]$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+      nand-ecc-mode:
+        const: hw
+
+      nand-ecc-step-size:
+        const: 1024
+
+      nand-ecc-strength:
+        enum: [16, 24, 40, 60, 70]
+        description:
+          The ECC configurations that can be supported are as follows.
+          - NFCv900(PX30 and RK3326) support ecc strength 16, 40, 60 and 70.
+          - NFCv600(RK3066 and RK2928) support ecc strength 16, 24, 40 and 60.
+          - NFCv622(RK3036 and RK3128) support ecc strength 16, 24, 40 and 60.
+          - NFCv800(RK3308 and RV1108) support ecc strength 16.
+
+      nand-bus-width:
+        const: 8
+
+      rockchip,boot-blks:
+        minimum: 2
+        default: 16
+        allOf:
+        - $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The NFC driver need this information to select ECC
+          algorithms supported by the BOOTROM.
+          Only used in combination with 'nand-is-boot-medium'.
+
+      rockchip,boot-ecc-strength:
+        enum: [16, 24, 40, 60, 70]
+        allOf:
+        - $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          If specified it indicates that a different BCH/ECC setting is
+          supported by the BOOTROM.
+          - NFCv900(PX30 and RK3326) support ecc strength 16 and 70.
+          - NFCv600(RK3066 and RK2928) support ecc strength 16, 24, 40 and 60.
+          - NFCv622(RK3036 and RK3128) support ecc strength 16, 24, 40 and 60.
+          - NFCv800(RK3308 and RV1108) support ecc strength 16.
+          Only used in combination with 'nand-is-boot-medium'.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3308-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nfc: nand-controller@ff4b0000 {
+      compatible = "rockchip,rk3308-nfc",
+                   "rockchip,rv1108-nfc";
+      reg = <0x0 0xff4b0000 0x0 0x4000>;
+      interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+      clock-names = "ahb", "nfc";
+      assigned-clocks = <&clks SCLK_NANDC>;
+      assigned-clock-rates = <150000000>;
+
+      pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
+                   &flash_rdn &flash_rdy &flash_wrn>;
+      pinctrl-names = "default";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+        label = "rk-nand";
+        nand-bus-width = <8>;
+        nand-ecc-mode = "hw";
+        nand-ecc-step-size = <1024>;
+        nand-ecc-strength = <16>;
+        nand-is-boot-medium;
+        rockchip,boot-blks = <8>;
+        rockchip,boot-ecc-strength = <16>;
+      };
+    };
+
+...
-- 
2.17.1



