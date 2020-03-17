Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814E420738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a47jTiix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:36:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCQQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:36:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so22753497wme.2;
        Tue, 17 Mar 2020 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WiB0u/leEGdcW1B+cHUhgFUc+5o/BZhuLHHQx8vVK4Y=;
        b=a47jTiixaLJG9rKjBDKQjHrYCYALh0axG7IEvuZmG5kxyTi7LzW49WxdAtDI3N1B08
         fNZ9DSCMu+gE61Ca4ftdVmbNPN0bDsaPdrrtdhYEv50m827YOKLS/6Gd6O1NLO+0l5gG
         vUrhlc3K4hhmbVBv7ceC0vxDHPBGEoACsmXtx9T3Xr/zY5gZyyuJ0tycgNE6D7Gnu7tv
         bNyRVzJDxkwtExRU1s39sfiYY+LuPgFnZzZ3qyWB+emuzKu5yUnPOvqpIgSNHZzkLnkh
         KrweK3LyHhw3j9ITk66Fqm7fVi8MzYGKDkLeVbXd+Pf/yQe8aJIv53p17+b3NigbrGjg
         /zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WiB0u/leEGdcW1B+cHUhgFUc+5o/BZhuLHHQx8vVK4Y=;
        b=Ofxs8ASBQFVJd0FWmnVEJ3fD1gs6AKJryRyMIXKokSP2wjJGKFRLBMGHGAhlYJ3lBb
         cYvX6C6CSxceonkp1bp7BsBlKINc+94iAX2AlCz4UZqkCRj3rKsP9zdNPY/siRp0Cu1o
         B0aSLzRfPQ4pb8LS+Eeh4FaLFFk3N8oRo27C/HZfrNHQvuCs1WAW6bqK637Kl1D6BFTA
         /XeGjVDnlkQJ7JfGc9f7mm1Y2LDbVJ/RsnCahPDfpHfvGkZtxD79mYFkZ5yvgL5gSgQo
         OCc8KsiKUrcigNlcxw3VyafziuPCr5UmlaL2fOzVe479y0d3fdojgTWcmNhr8NTXBEut
         siUQ==
X-Gm-Message-State: ANhLgQ1MnVNwZ9/69AGFYztVyhzLrX3S3+l6BfMTolm9vsXuUaX5e5Mp
        xIGphBwVqC6y3/QVur+WmPT65aU8
X-Google-Smtp-Source: ADFU+vvTbdxbQ8NuM1t3+foh2whJCugiJIlAkWJHzkdA1yliE1Ar3iJ2fVnrlc/J0tx6/r10MnuCGw==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr145719wmd.1.1584462962316;
        Tue, 17 Mar 2020 09:36:02 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm5389702wrm.30.2020.03.17.09.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:36:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: sram: convert rockchip-pmu-sram bindings to yaml
Date:   Tue, 17 Mar 2020 17:35:54 +0100
Message-Id: <20200317163555.18107-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'rockchip-pmu-sram' compatible nodes
are manually verified. In order to automate this process
rockchip-pmu-sram.txt has to be converted to yaml.

A check with the command below gives for example this error:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
compatible:0:
'rockchip,rk3288-pmu-sram' was expected
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
compatible:
['mmio-sram'] is too short

Fix this error by adding an extra 'mmio-sram' compatible and
'if then' structure to filter yaml warnings.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/
rockchip-pmu-sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/sram/rockchip-pmu-sram.txt | 16 --------
 .../bindings/sram/rockchip-pmu-sram.yaml           | 46 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
 create mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml

diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
deleted file mode 100644
index 6b42fda30..000000000
--- a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Rockchip SRAM for pmu:
-------------------------------
-
-The sram of pmu is used to store the function of resume from maskrom(the 1st
-level loader). This is a common use of the "pmu-sram" because it keeps power
-even in low power states in the system.
-
-Required node properties:
-- compatible : should be "rockchip,rk3288-pmu-sram"
-- reg : physical base address and the size of the registers window
-
-Example:
-	sram@ff720000 {
-		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
-		reg = <0xff720000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
new file mode 100644
index 000000000..bb72e4f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sram/rockchip-pmu-sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SRAM for pmu
+
+description:
+  The sram of pmu is used to store the function of resume from maskrom(the 1st
+  level loader). This is a common use of the "pmu-sram" because it keeps power
+  even in low power states in the system.
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+# The extra 'mmio-sram' compatible and 'if then' structure is needed
+# to filter yaml warnings.
+properties:
+  compatible:
+    oneOf:
+      - const: mmio-sram
+      - items:
+        - const: rockchip,rk3288-pmu-sram
+        - const: mmio-sram
+
+  reg:
+    maxItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3288-pmu-sram
+
+then:
+  required:
+    - compatible
+    - reg
+
+examples:
+  - |
+    pmu_sram: sram@ff720000 {
+      compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
+      reg = <0xff720000 0x1000>;
+    };
-- 
2.11.0

