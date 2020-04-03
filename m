Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55225C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224072077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi7RSUUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbgDCNGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:06:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403800AbgDCNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:06:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so6308229wrt.7;
        Fri, 03 Apr 2020 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YWX9cu/QSo8yRIN7AcBy13ogB4+/rJ1kxLeU3StGuPk=;
        b=Qi7RSUUREUB7NjQKdlKSApbx4ENGqn4aokUL81r8T9zR3j2ArRBvIMNQ6H0MBZxW7C
         RSkOkxN1mazkVMuF9ZInCYn+Lc/b3aIGlISZgDoKippise92hno9knc2+W9QFwFRtya3
         niaQ2NvYMGjI9Q517Xa2hzQdFKU28DDdb1T6fEpYjAdSz6hPUJmYxjVhprnul/rvxK0i
         TvVqe97bD++d7SdEJgolK7xZF7WdY7tqNQSfWzT5XhowIdQ9FJpFydwxJG9fOC7qdNSc
         +LAoVS0SSz8/V+jj4Gn0wVY/TM8cYFs19fc2b/LWEf4QwdMAgr8OTMTdheCIUcpBzLej
         vSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YWX9cu/QSo8yRIN7AcBy13ogB4+/rJ1kxLeU3StGuPk=;
        b=KkFN0vc80vdx41WjAgnsnIJS8AE971jnsWRufJ1NNdImlryytvjLhDVRk9lw8efpUy
         d8h4JaXdIXtd7bKmtGbhaZnZSjyOjdl8coh5XFeQ0aex7ZKV7dATwpgQ5CZ33LNoa3dU
         PkxeTLrZA4dkQsshbLDAGKQ0rSgvRZEpsAr+o0Z+9VBtWQA5oo/2LiPFeIjC1T7ZHeKy
         CT8VxO4MRzsAogMVcxJDfhrGX5Q3Tv2QFHlFe2KZF49t4vrJNRNSccwari98/VH1buk1
         VWMg1DsoiwP3GS8d4YZwRO+Vk0oXf6kYv6B4Vga9nx7ehiggBUxRtqi+YgjmgqU9ysXc
         e5hQ==
X-Gm-Message-State: AGi0PuYuWVez7cmw6Jffpmc4+Gfs7SL6hB8Kg8HQkRKW/Y9E0O/KR2MR
        86Qum+teCM67ZdhZR6wWWrE=
X-Google-Smtp-Source: APiQypIahrHiJOQlFe44D75IWRJ+qbieepz8CijZqcdOPl7y3Au0IjGYFn4Nnml+G/if8kVNM4+PZw==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr6387844wrp.356.1585919174979;
        Fri, 03 Apr 2020 06:06:14 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o9sm7036093wru.29.2020.04.03.06.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:06:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jacob-chen@iotwrt.com
Cc:     ezequiel@collabora.com, mchehab@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: media: convert rockchip rga bindings to yaml
Date:   Fri,  3 Apr 2020 15:06:06 +0200
Message-Id: <20200403130607.6138-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files for Rockchip with 'rga' nodes
are manually verified. In order to automate this process
rockchip-rga.txt has to be converted to yaml.

Changed:
  Add missing reg property

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  Change MAINTAINERS
---
 .../devicetree/bindings/media/rockchip-rga.txt     | 34 ----------
 .../devicetree/bindings/media/rockchip-rga.yaml    | 78 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 3 files changed, 79 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.txt
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip-rga.txt b/Documentation/devicetree/bindings/media/rockchip-rga.txt
deleted file mode 100644
index c53a8e513..000000000
--- a/Documentation/devicetree/bindings/media/rockchip-rga.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-device-tree bindings for rockchip 2D raster graphic acceleration controller (RGA)
-
-RGA is a standalone 2D raster graphic acceleration unit. It accelerates 2D
-graphics operations, such as point/line drawing, image scaling, rotation,
-BitBLT, alpha blending and image blur/sharpness.
-
-Required properties:
-- compatible: value should be one of the following
-  "rockchip,rk3228-rga", "rockchip,rk3288-rga": for Rockchip RK3228
-  "rockchip,rk3288-rga": for Rockchip RK3288
-  "rockchip,rk3399-rga": for Rockchip RK3399
-
-- interrupts: RGA interrupt specifier.
-
-- clocks: phandle to RGA sclk/hclk/aclk clocks
-
-- clock-names: should be "aclk", "hclk" and "sclk"
-
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: should be "core", "axi" and "ahb"
-
-Example:
-SoC-specific DT entry:
-	rga: rga@ff680000 {
-		compatible = "rockchip,rk3399-rga";
-		reg = <0xff680000 0x10000>;
-		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
-		clock-names = "aclk", "hclk", "sclk";
-
-		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
-		reset-names = "core, "axi", "ahb";
-	};
diff --git a/Documentation/devicetree/bindings/media/rockchip-rga.yaml b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
new file mode 100644
index 000000000..3b110b574
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip-rga.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip-rga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip 2D raster graphic acceleration controller (RGA)
+
+description:
+  RGA is a standalone 2D raster graphic acceleration unit. It accelerates 2D
+  graphics operations, such as point/line drawing, image scaling, rotation,
+  BitBLT, alpha blending and image blur/sharpness.
+
+maintainers:
+  - Jacob Chen <jacob-chen@iotwrt.com>
+  - Ezequiel Garcia <ezequiel@collabora.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3288-rga
+      - const: rockchip,rk3399-rga
+      - items:
+          - const: rockchip,rk3228-rga
+          - const: rockchip,rk3288-rga
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: sclk
+
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: core
+      - const: axi
+      - const: ahb
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    rga: rga@ff680000 {
+      compatible = "rockchip,rk3399-rga";
+      reg = <0xff680000 0x10000>;
+      interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_RGA>,
+               <&cru HCLK_RGA>,
+               <&cru SCLK_RGA_CORE>;
+      clock-names = "aclk", "hclk", "sclk";
+      resets = <&cru SRST_RGA_CORE>,
+               <&cru SRST_A_RGA>,
+               <&cru SRST_H_RGA>;
+      reset-names = "core", "axi", "ahb";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ce80b22cf..ca7cdd2c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14367,7 +14367,7 @@ M:	Ezequiel Garcia <ezequiel@collabora.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/rockchip/rga/
-F:	Documentation/devicetree/bindings/media/rockchip-rga.txt
+F:	Documentation/devicetree/bindings/media/rockchip-rga.yaml
 
 HANTRO VPU CODEC DRIVER
 M:	Ezequiel Garcia <ezequiel@collabora.com>
-- 
2.11.0

