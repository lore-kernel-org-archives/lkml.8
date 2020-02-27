Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE719C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4B124692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cjd7ijl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgB0Mhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:37:46 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:39512 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgB0Mhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:37:46 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01RCap9O018520;
        Thu, 27 Feb 2020 21:36:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01RCap9O018520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582807011;
        bh=ZOAQrMnQEXEPvN8bCNp3UgX+oQzExQ8Hfi1fHbs68aA=;
        h=From:To:Cc:Subject:Date:From;
        b=cjd7ijl8paDPTuhFKEtAp96O+UViOd4ayI08E3mSM6skmLRqDvmQ+3Tvx5wfts25U
         TwPNkiSoHRe+zIzGGzts9iZ3ToZOPPmySjNm6as/eGWOVTd4SCbk4F0hTPANXQkkd+
         D95+eH5ZXS3iuYTIoQKBiab2Uq3BWEgDcL/7Aztmc88t6IGdTqEOMFasmW6IwwKEd7
         GfLkRihcTFAgzqilDS5P3bZ9O5m8rAMSiLLrfIyuS/C/HPRKncOIigAz3YF8ocUsYW
         CaIiUEfR0LbgPhz0tFd+5WKwap6NARH0rWQCNsgNCfCUBYvajFS0ybW0oJQJ7ZDRtw
         xgQYkZvN/0cBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Convert UniPhier System Cache to json-schema
Date:   Thu, 27 Feb 2020 21:36:48 +0900
Message-Id: <20200227123648.12785-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier System Cache binding to DT schema format.
This is a full-custom outer cache (L2 and L3) used on UniPhier
ARM 32-bit SoCs.

While I was here, I added the interrupts property. This is not
used in Linux, but the hardware has interrupt lines at least.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/arm/socionext/cache-uniphier.txt |  60 -----------
 .../socionext,uniphier-system-cache.yaml      | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml

diff --git a/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
deleted file mode 100644
index d27a646f48a9..000000000000
--- a/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-UniPhier outer cache controller
-
-UniPhier SoCs are integrated with a full-custom outer cache controller system.
-All of them have a level 2 cache controller, and some have a level 3 cache
-controller as well.
-
-Required properties:
-- compatible: should be "socionext,uniphier-system-cache"
-- reg: offsets and lengths of the register sets for the device.  It should
-  contain 3 regions: control register, revision register, operation register,
-  in this order.
-- cache-unified: specifies the cache is a unified cache.
-- cache-size: specifies the size in bytes of the cache
-- cache-sets: specifies the number of associativity sets of the cache
-- cache-line-size: specifies the line size in bytes
-- cache-level: specifies the level in the cache hierarchy.  The value should
-  be 2 for L2 cache, 3 for L3 cache, etc.
-
-Optional properties:
-- next-level-cache: phandle to the next level cache if present.  The next level
-  cache should be also compatible with "socionext,uniphier-system-cache".
-
-The L2 cache must exist to use the L3 cache; the cache hierarchy must be
-indicated correctly with "next-level-cache" properties.
-
-Example 1 (system with L2):
-	l2: l2-cache@500c0000 {
-		compatible = "socionext,uniphier-system-cache";
-		reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
-		      <0x506c0000 0x400>;
-		cache-unified;
-		cache-size = <0x80000>;
-		cache-sets = <256>;
-		cache-line-size = <128>;
-		cache-level = <2>;
-	};
-
-Example 2 (system with L2 and L3):
-	l2: l2-cache@500c0000 {
-		compatible = "socionext,uniphier-system-cache";
-		reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
-		      <0x506c0000 0x400>;
-		cache-unified;
-		cache-size = <0x200000>;
-		cache-sets = <512>;
-		cache-line-size = <128>;
-		cache-level = <2>;
-		next-level-cache = <&l3>;
-	};
-
-	l3: l3-cache@500c8000 {
-		compatible = "socionext,uniphier-system-cache";
-		reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
-		      <0x506c8000 0x400>;
-		cache-unified;
-		cache-size = <0x400000>;
-		cache-sets = <512>;
-		cache-line-size = <256>;
-		cache-level = <3>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
new file mode 100644
index 000000000000..2e765bb3e6f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/socionext/socionext,uniphier-system-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier outer cache controller
+
+description: |
+  UniPhier ARM 32-bit SoCs are integrated with a full-custom outer cache
+  controller system. All of them have a level 2 cache controller, and some
+  have a level 3 cache controller as well.
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  compatible:
+    const: socionext,uniphier-system-cache
+
+  reg:
+    description: |
+      should contain 3 regions: control register, revision register,
+      operation register, in this order.
+    minItems: 3
+    maxItems: 3
+
+  interrupts:
+    description: |
+      Interrupts can be used to notify the completion of cache operations.
+      The number of interrupts should match to the number of CPU cores.
+      The specified interrupts correspond to CPU0, CPU1, ... in this order.
+      minItems: 1
+      maxItems: 4
+
+  cache-unified: true
+
+  cache-size: true
+
+  cache-sets: true
+
+  cache-line-size: true
+
+  cache-level:
+    minimum: 2
+    maximum: 3
+
+  next-level-cache: true
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - cache-unified
+  - cache-size
+  - cache-sets
+  - cache-line-size
+  - cache-level
+
+examples:
+  - |
+    // System with L2.
+    cache-controller@500c0000 {
+        compatible = "socionext,uniphier-system-cache";
+        reg = <0x500c0000 0x2000>, <0x503c0100 0x4>, <0x506c0000 0x400>;
+        interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
+        cache-unified;
+        cache-size = <0x140000>;
+        cache-sets = <512>;
+        cache-line-size = <128>;
+        cache-level = <2>;
+    };
+  - |
+    // System with L2 and L3.
+    //   L2 should specify the next level cache by 'next-level-cache'.
+    l2: cache-controller@500c0000 {
+        compatible = "socionext,uniphier-system-cache";
+        reg = <0x500c0000 0x2000>, <0x503c0100 0x8>, <0x506c0000 0x400>;
+        interrupts = <0 190 4>, <0 191 4>;
+        cache-unified;
+        cache-size = <0x200000>;
+        cache-sets = <512>;
+        cache-line-size = <128>;
+        cache-level = <2>;
+        next-level-cache = <&l3>;
+    };
+
+    l3: cache-controller@500c8000 {
+        compatible = "socionext,uniphier-system-cache";
+        reg = <0x500c8000 0x2000>, <0x503c8100 0x8>, <0x506c8000 0x400>;
+        interrupts = <0 174 4>, <0 175 4>;
+        cache-unified;
+        cache-size = <0x200000>;
+        cache-sets = <512>;
+        cache-line-size = <256>;
+        cache-level = <3>;
+    };
-- 
2.17.1

