Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF65C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2809B206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqZ+cS/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLRas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:30:48 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39219 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCLRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:30:47 -0400
Received: by mail-wm1-f50.google.com with SMTP id f7so7285498wml.4;
        Thu, 12 Mar 2020 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xSnW9A8X74vMXdw1AZNYRfnq/dFpU0Q61rYWfM27gUE=;
        b=dqZ+cS/Prcg+PDSUIoMKAOEp40uZVlpGw5ZOWddF1Z+/e20AXbLSPQFzeZ7bd+Z4q+
         4uKT3g1n3TNaUsBmQNyL0iatlr3q3BMU+UCYm1losTAgpsFzjIVGBRlrLH+BCJ0lvz/D
         oW1p+URZaH4dQIOw2PGC3Gmk6LxtBexxtvJAiuqjcQzmxkLbPJp/vSzX+rf0g4fA7rCg
         XOKvY1oZc0waeoUcTIPSLdIwnf+ZvTUJTNkTK/XYTlFrO3wn2oKTzSPMSmQk1pZ3gUe2
         mOwHloguKVYmhmfoshAzANf4zmtWL+5AxDuOC0NE8y/jFyi47KCYNQp0zTLsAnlChnyN
         VWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xSnW9A8X74vMXdw1AZNYRfnq/dFpU0Q61rYWfM27gUE=;
        b=CIsmc6oXvfpsIpQIpdyUrm+iV3CoZ2J3zQ94Z8HLoe6IjoFfUBt/Y3NT5fiMT74oqv
         JtnzEw1F3EGkNVniCDR66ehsOYjGyrezMLO55c6rFY12FI16tOPHvlel1nTUueuPsGCI
         D5/YwwKdLGqRjFZtOCZuh7leQl9MCWU5nfWnWi5TbHXCmOcaWy2s+sDIgUXBhhapUwyw
         qudSWTeHvW5H8f6OxBLXTB8TrF2DVGl4TmehYH4ZpaLbi7ZefyGWnZyh9w1nANgmY9mh
         P2um1FRnvrNwBZw3Dtn9kWSB3NfAJ1UcKYvYxe1tELhEA4jx/p9GCKZQm4I0D/IW170R
         EjZg==
X-Gm-Message-State: ANhLgQ0e8FZV/DC5GWoQa0I4vZxqpz7EX6xWYvGojGLtTVB18A+a6K5P
        3WbxZtux5JgpACY5i3y7B64=
X-Google-Smtp-Source: ADFU+vuVG0oUJL9NNxpSgAnmiNK0aLUEyjsbXdwHcCKQBXDbnFceiU248kw7koVVOEdnC7MW0sy9zQ==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr5786802wmb.178.1584034245527;
        Thu, 12 Mar 2020 10:30:45 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x24sm13170222wmc.36.2020.03.12.10.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:30:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: sound: convert rockchip spdif bindings to yaml
Date:   Thu, 12 Mar 2020 18:30:36 +0100
Message-Id: <20200312173037.21477-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'spdif' nodes are manually verified.
In order to automate this process rockchip-spdif.txt
has to be converted to yaml.

Also rk3188.dtsi, rk3288.dtsi use an extra fallback string,
so change this in the documentation.

Changed:
"rockchip,rk3188-spdif", "rockchip,rk3066-spdif"
"rockchip,rk3288-spdif", "rockchip,rk3066-spdif"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/sound/rockchip-spdif.txt   | 45 ----------
 .../devicetree/bindings/sound/rockchip-spdif.yaml  | 96 ++++++++++++++++++++++
 2 files changed, 96 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
deleted file mode 100644
index ec20c1271..000000000
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* Rockchip SPDIF transceiver
-
-The S/PDIF audio block is a stereo transceiver that allows the
-processor to receive and transmit digital audio via an coaxial cable or
-a fibre cable.
-
-Required properties:
-
-- compatible: should be one of the following:
-   - "rockchip,rk3066-spdif"
-   - "rockchip,rk3188-spdif"
-   - "rockchip,rk3228-spdif"
-   - "rockchip,rk3288-spdif"
-   - "rockchip,rk3328-spdif"
-   - "rockchip,rk3366-spdif"
-   - "rockchip,rk3368-spdif"
-   - "rockchip,rk3399-spdif"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: should contain the SPDIF interrupt.
-- dmas: DMA specifiers for tx dma. See the DMA client binding,
-  Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: should be "tx"
-- clocks: a list of phandle + clock-specifier pairs, one for each entry
-  in clock-names.
-- clock-names: should contain following:
-   - "hclk": clock for SPDIF controller
-   - "mclk" : clock for SPDIF bus
-
-Required properties on RK3288:
-  - rockchip,grf: the phandle of the syscon node for the general register
-                   file (GRF)
-
-Example for the rk3188 SPDIF controller:
-
-spdif: spdif@1011e000 {
-	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
-	reg = <0x1011e000 0x2000>;
-	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&dmac1_s 8>;
-	dma-names = "tx";
-	clock-names = "hclk", "mclk";
-	clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
-	#sound-dai-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
new file mode 100644
index 000000000..45c6eea30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SPDIF transceiver
+
+description:
+  The S/PDIF audio block is a stereo transceiver that allows the
+  processor to receive and transmit digital audio via a coaxial or
+  fibre cable.
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3066-spdif
+      - const: rockchip,rk3228-spdif
+      - const: rockchip,rk3328-spdif
+      - const: rockchip,rk3366-spdif
+      - const: rockchip,rk3368-spdif
+      - const: rockchip,rk3399-spdif
+      - items:
+          - enum:
+            - rockchip,rk3188-spdif
+            - rockchip,rk3288-spdif
+          - const: rockchip,rk3066-spdif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for SPDIF bus
+      - description: clock for SPDIF controller
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: hclk
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+      Required property on RK3288.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3288-spdif
+
+then:
+  required:
+    - rockchip,grf
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spdif: spdif@1011e000 {
+      compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+      reg = <0x1011e000 0x2000>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
+      clock-names = "mclk", "hclk";
+      dmas = <&dmac1_s 8>;
+      dma-names = "tx";
+    };
-- 
2.11.0

