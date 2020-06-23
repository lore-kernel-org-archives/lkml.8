Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E932078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sVizWFAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgFWLl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:41:26 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:33479 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbgFWLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:41:25 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 05NBe8ci003070;
        Tue, 23 Jun 2020 20:40:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 05NBe8ci003070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592912410;
        bh=PygYU/2RRMrfiio7nz6fPQ9Z7mq5YCkWc1Sf7EhnCkI=;
        h=From:To:Cc:Subject:Date:From;
        b=sVizWFATWNcpy5d9L3all7xagM7c44OaE+nOQol8xIWPF1MVnRFYRK+KAyHkpv+Di
         K0ohhgAFzmEXqysWpfY+oy9zqY8dlFfcvS7uTwCnWxFtcA9BtjqO2tiz2Opou6yamU
         OQDbKdbG89dg+9GLB1EHru5JKHnKyuXLcpjRJm1jzx3444+h8jKKOvJtWjR1NcF06p
         ebdnrAdGVhto+zkF6R/d7tKHpxWO4gjBmdj4cWAkWl5Utk5NAF3uAOwWx66gkL8fcy
         trtsxYJwBvJj/kYN2jxwGKo7YronIzoFNQBUX5USckS9u6fIQKRCmGW7XmbVQefPgM
         971JdwhmVLzhA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
Date:   Tue, 23 Jun 2020 20:40:05 +0900
Message-Id: <20200623114005.791643-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier EVEA sound codec binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add schema for subnode 'port'

 .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
 .../bindings/sound/uniphier,evea.txt          | 26 -------
 2 files changed, 70 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
new file mode 100644
index 000000000000..228168f685cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/socionext,uniphier-evea.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier EVEA SoC-internal sound codec
+
+maintainers:
+  - <alsa-devel@alsa-project.org>
+
+properties:
+  compatible:
+    const: socionext,uniphier-evea
+
+  reg:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: evea
+      - const: exiv
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: evea
+      - const: exiv
+      - const: adamv
+
+  resets:
+    minItems: 3
+    maxItems: 3
+
+  "#sound-dai-cells":
+    const: 1
+
+patternProperties:
+  "^port@[0-9]$":
+    type: object
+    properties:
+      endpoint: true
+    required:
+      - endpoint
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    codec@57900000 {
+        compatible = "socionext,uniphier-evea";
+        reg = <0x57900000 0x1000>;
+        clock-names = "evea", "exiv";
+        clocks = <&sys_clk 41>, <&sys_clk 42>;
+        reset-names = "evea", "exiv", "adamv";
+        resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
+        #sound-dai-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/uniphier,evea.txt b/Documentation/devicetree/bindings/sound/uniphier,evea.txt
deleted file mode 100644
index 3f31b235f18b..000000000000
--- a/Documentation/devicetree/bindings/sound/uniphier,evea.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Socionext EVEA - UniPhier SoC internal codec driver
-
-Required properties:
-- compatible      : should be "socionext,uniphier-evea".
-- reg             : offset and length of the register set for the device.
-- clock-names     : should include following entries:
-                    "evea", "exiv"
-- clocks          : a list of phandle, should contain an entry for each
-                    entries in clock-names.
-- reset-names     : should include following entries:
-                    "evea", "exiv", "adamv"
-- resets          : a list of phandle, should contain reset entries of
-                    reset-names.
-- #sound-dai-cells: should be 1.
-
-Example:
-
-	codec {
-		compatible = "socionext,uniphier-evea";
-		reg = <0x57900000 0x1000>;
-		clock-names = "evea", "exiv";
-		clocks = <&sys_clk 41>, <&sys_clk 42>;
-		reset-names = "evea", "exiv", "adamv";
-		resets = <&sys_rst 41>, <&sys_rst 42>, <&adamv_rst 0>;
-		#sound-dai-cells = <1>;
-	};
-- 
2.25.1

