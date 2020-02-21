Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4054C11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9253206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vIaGzjaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgBUCLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:11:44 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:46308 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:11:44 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01L2A7H5001755;
        Fri, 21 Feb 2020 11:10:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01L2A7H5001755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582251010;
        bh=J5YlQLARzzU9Enfb9QitiBwyznmuB4gzWmaSBIM5u7c=;
        h=From:To:Cc:Subject:Date:From;
        b=vIaGzjaLDunfjhmFTMiuPJDeE0a0PQm5JxnACdIpVBMWksHGTnOrmLSM43k9R25CW
         wRRypljz7oOexuPsphlTKWKAT/+NRK5BbL4IybvZk4ZC7/5fcJBR2EWXd3U+J4M4v7
         OXUt8HOL4TFEE4PVvcmD30zWGRe7/rYJV6UbFZbGSG3856UMmpVe/rdWS91mpD8b7j
         bNgmZNiVmNOCbXLMC2pQifOgZ1C0IPdJ9RI8oha3uoifC6nbfxqd8Reg7ezhcJjSgq
         843JN/o9GqLqJw9G9y1p1RkfN3Omqs3hbYOPWz+Gv1t8u12C0to3+TbnH1DRPEGtFQ
         UeCfSS7UHbFRg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: Convert UniPhier board/SoC bindings to json-schema
Date:   Fri, 21 Feb 2020 11:10:00 +0900
Message-Id: <20200221021002.18795-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Socionext UniPhier board/SoC binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/arm/socionext/uniphier.txt       | 47 -------------
 .../bindings/arm/socionext/uniphier.yaml      | 70 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 71 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml

diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
deleted file mode 100644
index b3ed1033740e..000000000000
--- a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Socionext UniPhier SoC family
------------------------------
-
-Required properties in the root node:
-  - compatible: should contain board and SoC compatible strings
-
-SoC and board compatible strings:
-  (sorted chronologically)
-
-  - LD4 SoC:  "socionext,uniphier-ld4"
-      - Reference Board: "socionext,uniphier-ld4-ref"
-
-  - Pro4 SoC: "socionext,uniphier-pro4"
-      - Reference Board: "socionext,uniphier-pro4-ref"
-      - Ace Board:       "socionext,uniphier-pro4-ace"
-      - Sanji Board:     "socionext,uniphier-pro4-sanji"
-
-  - sLD8 SoC: "socionext,uniphier-sld8"
-      - Reference Board: "socionext,uniphier-sld8-ref"
-
-  - PXs2 SoC: "socionext,uniphier-pxs2"
-      - Gentil Board:    "socionext,uniphier-pxs2-gentil"
-      - Vodka Board:     "socionext,uniphier-pxs2-vodka"
-
-  - LD6b SoC: "socionext,uniphier-ld6b"
-      - Reference Board: "socionext,uniphier-ld6b-ref"
-
-  - LD11 SoC: "socionext,uniphier-ld11"
-      - Reference Board: "socionext,uniphier-ld11-ref"
-      - Global Board:    "socionext,uniphier-ld11-global"
-
-  - LD20 SoC: "socionext,uniphier-ld20"
-      - Reference Board: "socionext,uniphier-ld20-ref"
-      - Global Board:    "socionext,uniphier-ld20-global"
-
-  - PXs3 SoC: "socionext,uniphier-pxs3"
-      - Reference Board: "socionext,uniphier-pxs3-ref"
-
-Example:
-
-/dts-v1/;
-
-/ {
-	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
-
-	...
-};
diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.yaml b/Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
new file mode 100644
index 000000000000..1cd0adcf9ddb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/socionext/uniphier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier platform device tree bindings
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: LD4 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-ld4-ref
+          - const: socionext,uniphier-ld4
+      - description: Pro4 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-pro4-ace
+            - socionext,uniphier-pro4-ref
+            - socionext,uniphier-pro4-sanji
+          - const: socionext,uniphier-pro4
+      - description: sLD8 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-sld8-ref
+          - const: socionext,uniphier-sld8
+      - description: PXs2 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-pxs2-gentil
+            - socionext,uniphier-pxs2-vodka
+          - const: socionext,uniphier-pxs2
+      - description: LD6b SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-ld6b-ref
+          - const: socionext,uniphier-ld6b
+      - description: LD11 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-ld11-global
+            - socionext,uniphier-ld11-ref
+          - const: socionext,uniphier-ld11
+      - description: LD20 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-ld20-global
+            - socionext,uniphier-ld20-ref
+          - const: socionext,uniphier-ld20
+      - description: PXs3 SoC boards
+        items:
+          - enum:
+            - socionext,uniphier-pxs3-ref
+          - const: socionext,uniphier-pxs3
+
+examples:
+  - |
+
+    / {
+        compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
+
+        ...
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4beb8dc4c7eb..93ccb6708ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2546,7 +2546,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/arm/socionext/uniphier.txt
+F:	Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
 F:	arch/arm/boot/dts/uniphier*
-- 
2.17.1

