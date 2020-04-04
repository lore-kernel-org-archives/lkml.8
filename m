Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6493DC2BA17
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313A420659
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4E8Wx4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDDLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 07:52:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50312 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgDDLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 07:52:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id t128so9876211wma.0;
        Sat, 04 Apr 2020 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WdnAbDTj6jtP4VOMCJVjHgxV4qgpznX9InRBomX1p1U=;
        b=J4E8Wx4pFqTYQ7rSPhEuNAo18XhTGgqc93isY+r8lRW8JlqL4VLWPVkNXDV3cHGQ9d
         z1XXfTpQM9AF4+JDVVIUq5vfxYmmqJhuaDVy59FS0UEiJre7Tn+D4dvtzcpQQvzsAE+r
         hvZECd7kZGJu0pSPWrIR/7Ry69C1ipi/47hKON1ZifHQ80qKgQSX7pPhYD6xxYWkknfX
         Kq/ekhgWQIQgYy1tQgW5pGFkLWEW9VoBtIwrJPG/aLRQjcKQHRf74QabqtQtE8gQjXLN
         hqT/KeB5AEcZLVBIDUyL9kjcg68Sz6O4XvmdfN40hR0/hH93yxlSA99yWBu0UEEQ2e4q
         bG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WdnAbDTj6jtP4VOMCJVjHgxV4qgpznX9InRBomX1p1U=;
        b=QntM3aNZpJ3DGo+YwJo2mSz5b1bto67AFFf3HvhINUDVFmu8zyHqEY1NxzOerAZ+24
         0QLYuUhrPEf42oQnAuSIxDllZ2mCiRtDxDGlwSmUqt7Kpzt+gqugHCNzoqpXP6IzKgr/
         UWEaof2EFtY57UQTVFrl5xYsGg60tS4ca/P5r8cVkLenxVP5N9cQCMq44t0UkyKPcJdQ
         o8thMPy62OnmNSd45POTQDdnCiC/XEZ90G+K9P4EdiwwM0o3/a+oMDK/8vdhihBUGZmP
         5r9urtfibcV9GmW367RJlU+Zy0vWFsmkeo4VFq2nFTB9DKejqq1Hu4XdlWpoFsrF6Pwo
         mJPg==
X-Gm-Message-State: AGi0PuZfeWvJ62fq+ujHXYOhUKCgQGLv90UBacDckrud2qrEvJSgwiWU
        qiAjRAaBbn4Aza9uOWsW2y0=
X-Google-Smtp-Source: APiQypLgvsrDXCY+fxQ+1NshaZ3Bzn9yeGXWoAfPDWIG/qG982FurHXkaoXmgyUD9FAl58gmD4wFrQ==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr13636483wmc.187.1586001152742;
        Sat, 04 Apr 2020 04:52:32 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g186sm16183276wmg.36.2020.04.04.04.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 04:52:32 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: sound: convert rockchip spdif bindings to yaml
Date:   Sat,  4 Apr 2020 13:52:23 +0200
Message-Id: <20200404115225.4314-1-jbx6244@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v3:
  Add reviewed by
  Fix irq.h already included in arm-gic.h
  Change rk3188-cru-common.h to rk3188-cru.h

Changed v2:
  dmas and dma-names layout
---
 .../devicetree/bindings/sound/rockchip-spdif.txt   | 45 -----------
 .../devicetree/bindings/sound/rockchip-spdif.yaml  | 93 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 45 deletions(-)
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
index 000000000..bfd44fd8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -0,0 +1,93 @@
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
+    maxItems: 1
+
+  dma-names:
+    const: tx
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
+    #include <dt-bindings/clock/rk3188-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
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

