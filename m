Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEDCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4700D2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO6PPX2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgAXQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgAXQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so72433wmb.0;
        Fri, 24 Jan 2020 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uJoeltGGhmQKQoFJipSF7NJGrgp+ESh1SyyRe6anT6U=;
        b=XO6PPX2pWqnpKnGovVWZfIR79tFHTFU2R3vop4kZP4gw9HGbYbZY0S7Qh5vf+Mu2DG
         a27PRLxbXCESnbT1uxnPCwpd26mpy2DvPV2pExJyERgMsM77q5aCZYQ6Lwb05J2jCqVa
         bNtr5cmcKFZOHyqZjFY9qPQCj9AJqCcI9oUcx1+oIOOtFtEG2eOWzm7QKVAvxvIX/MQM
         QaI2RvIo1p+EXBB7TlyuBu+c9A0mumMXWy1l5X2zq0QifLdu9p1cu5iIorMOYQnIk3bl
         3ctPkflh/W0nmz412KOz1oDYI+Me5Jg+dgkLwb3aHkLIsPrLGLT37EZRrn5XTlv+kfjH
         hLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uJoeltGGhmQKQoFJipSF7NJGrgp+ESh1SyyRe6anT6U=;
        b=YIrlW1z4eYOpeT3kV3qgTOwH/lyIesy0w26VUrWLRtUHK6V/lrJrJFOK/FmXM2ccXR
         ZdfKImQFripZ0E7DD43k0k96QfL9tuGS4Y0OuPEreF0F/294pZqZBYmwnmyhBUamEfRX
         si/HF+l88hHex6nox719Nc7g/K6FmLWR/lhPu5kRKrLZLndome73GtBzHCEOduyvISE+
         kNrjd4B4QkFlodMxDKlraR5g61UmYtW0KJf7yrxN8K1b2hl6twOjaZT6VJq2Xa61x6Ld
         b+W66IVrMxdPhUExFcflpgvnOY6Lu8z4BBkKUP+JqrbdO22tRAQsz5FEF7EE6OxNRX4M
         cEag==
X-Gm-Message-State: APjAAAWq6FoYbUjizDyQ0H/bAGQPQESosePRY8WXYzYSiuujFzTYq3f+
        Z9sGBvZXnFDer3K0OykK5wg=
X-Google-Smtp-Source: APXvYqy3mk7rwTNk9qGgqbzMeEjnTVID618sKjWfbjGW+VxAoMrQQ9N9uv2TnvdBzWt4d8bgabEuHw==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr44736wmp.19.1579883411139;
        Fri, 24 Jan 2020 08:30:11 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:10 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 01/10] dt-bindings: mtd: add rockchip nand controller bindings
Date:   Fri, 24 Jan 2020 17:29:52 +0100
Message-Id: <20200124163001.28910-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Rockchip NAND controller bindings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/mtd/rockchip,nand-controller.yaml     | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml

diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
new file mode 100644
index 000000000..5c725f972
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/rockchip,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip NAND Controller Device Tree Bindings
+
+allOf:
+  - $ref: "nand-controller.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-nand-controller
+      - rockchip,rk3066-nand-controller
+      - rockchip,rk3228-nand-controller
+      - rockchip,rk3288-nand-controller
+      - rockchip,rk3308-nand-controller
+      - rockchip,rk3368-nand-controller
+      - rockchip,rv1108-nand-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: hclk_nandc
+      - const: clk_nandc
+
+patternProperties:
+  "^nand@[a-f0-9]+$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      nand-is-boot-medium: true
+
+      rockchip,idb-res-blk-num:
+        minimum: 2
+        default: 16
+        allOf:
+        - $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          For legacy devices where the bootrom can only handle 24 bit BCH/ECC.
+          If specified it indicates the number of erase blocks in use by
+          the bootloader that need a lower BCH/ECC setting.
+          Only used in combination with 'nand-is-boot-medium'.
+
+    additionalProperties: false
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
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    nandc: nand-controller@10500000 {
+      compatible = "rockchip,rk3066-nand-controller";
+      reg = <0x10500000 0x4000>;
+      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_NANDC0>;
+      clock-names = "hclk_nandc";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+        nand-is-boot-medium;
+      };
+    };
+
+...
-- 
2.11.0

