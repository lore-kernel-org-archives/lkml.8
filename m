Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F118C11D34
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2620836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="trsTmj6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBXO6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39546 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgBXO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so9741997wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9cRXoC/GfDAtjxWi5KsDJ09IaYSATCVgnb2jSrSXVk=;
        b=trsTmj6zVlXNSoLi6KjZbFbzFLBRs7Gbl4tvKmeC/QMtjfjtG0KRvB94LBGe9rrf8K
         g6qLpJrRcJ6aWkO6aD8gXTvRwMIFkVDdi2MLdTqRkweFtGFgWXH4VXINLQEdUQeRJ9ia
         4r1EUUDep2XGR/LQJwkjBkjN/FeQluq/xDZg7MkODgYep/Ydi26Y7mU1tCBTCA2iIpsj
         5Kz6BBcFsRB2CuTdZLY9Cj4wApZI6C2QhRvYk/zNlVeL2PHr/67K6Bnk9V9uXPyQTkap
         cb+6bldDPVjqxRaZrTpIqmhq06Ym01u5RKbM+alXY9gCq3qdky5bC0r4ySg/su2xGZL5
         bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9cRXoC/GfDAtjxWi5KsDJ09IaYSATCVgnb2jSrSXVk=;
        b=iMJdvAAMNxVUp4A/TMr3wv9clGiystp/WcV2lPNnJqPSrJ1tHuL5SKnjwcWhM20B99
         kh92zqr5EdaHR2w8+GhY77l6gNdWWcIiwlI4irJC1Jxh5XFEu2WJI0Qoic4E5QWmbTgC
         ApMG9Wka21rJCoD4n7jzgPRvnQsi30UbwjBrxJ0rb/LwppwJN7RarNQf7a0Ql7t9/nWV
         6eqD4lfG19f6hnyIwflKPRPHxnT6FZUlr4/irb5cTv139ckg13qKS8+snhgpYUwcv8eK
         qw446x9PlHhHsRPebw27J87NHIezMemuYMnSk/AnnOGooSDknHrJCfZLj5qmF92rYBmB
         o+xg==
X-Gm-Message-State: APjAAAW2mCQEuF9Xk79Yw7H3Mo1qZHHm//kpLtdsk/BIC4re2B66wrM6
        W7Xszlr+57+SjGQcTN1jaz200g==
X-Google-Smtp-Source: APXvYqxuk/ZsOhi/Z9PZFDby6XImdLYc1HKOphlMtlNyGM6T4IvnoK5UeTKpmgEVirInMyPYyv25UQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr22339218wmb.0.1582556310822;
        Mon, 24 Feb 2020 06:58:30 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:30 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5/9] ASoC: meson: convert axg fifo to schema
Date:   Mon, 24 Feb 2020 15:58:17 +0100
Message-Id: <20200224145821.262873-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224145821.262873-1-jbrunet@baylibre.com>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding documentation for the Amlogic axg audio FIFOs to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-fifo.txt       |  34 ------
 .../bindings/sound/amlogic,axg-fifo.yaml      | 111 ++++++++++++++++++
 2 files changed, 111 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
deleted file mode 100644
index fa4545ed81ca..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Amlogic Audio FIFO controllers
-
-Required properties:
-- compatible: 'amlogic,axg-toddr' or
-	      'amlogic,axg-toddr' or
-	      'amlogic,g12a-frddr' or
-	      'amlogic,g12a-toddr' or
-	      'amlogic,sm1-frddr' or
-	      'amlogic,sm1-toddr'
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- interrupts: interrupt specifier for the fifo.
-- clocks: phandle to the fifo peripheral clock provided by the audio
-	  clock controller.
-- resets: list of reset phandle, one for each entry reset-names.
-- reset-names: should contain the following:
-  * "arb" : memory ARB line (required)
-  * "rst" : dedicated device reset line (optional)
-- #sound-dai-cells: must be 0.
-- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
-  		      is useful for determining certain configuration such
-		      as the flush threshold of the fifo
-
-Example of FRDDR A on the A113 SoC:
-
-frddr_a: audio-controller@1c0 {
-	compatible = "amlogic,axg-frddr";
-	reg = <0x0 0x1c0 0x0 0x1c>;
-	#sound-dai-cells = <0>;
-	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
-	resets = <&arb AXG_ARB_FRDDR_A>;
-	fifo-depth = <512>;
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
new file mode 100644
index 000000000000..d9fe4f624784
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-fifo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic AXG Audio FIFO controllers
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    oneOf:
+      - items:
+        - const:
+            amlogic,axg-toddr
+      - items:
+        - const:
+            amlogic,axg-frddr
+      - items:
+        - enum:
+          - amlogic,g12a-toddr
+          - amlogic,sm1-toddr
+        - const:
+            amlogic,axg-toddr
+      - items:
+        - enum:
+          - amlogic,g12a-frddr
+          - amlogic,sm1-frddr
+        - const:
+            amlogic,axg-frddr
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    items:
+      - description: Memory ARB line
+      - description: Dedicated device reset line
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: arb
+      - const: rst
+
+  amlogic,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Size of the controller's fifo in bytes
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - interrupts
+  - reg
+  - clocks
+  - resets
+  - amlogic,fifo-depth
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-toddr
+          - amlogic,sm1-toddr
+          - amlogic,g12a-frddr
+          - amlogic,sm1-frddr
+then:
+  properties:
+    resets:
+      minItems: 2
+    reset-names:
+      minItems: 2
+  required:
+    - reset-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    frddr_a: audio-controller@1c0 {
+        compatible = "amlogic,g12a-frddr", "amlogic,axg-frddr";
+        reg = <0x0 0x1c0 0x0 0x1c>;
+        #sound-dai-cells = <0>;
+        interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+        resets = <&arb AXG_ARB_FRDDR_A>, <&clkc_audio AUD_RESET_FRDDR_A>;
+        reset-names = "arb", "rst";
+        amlogic,fifo-depth = <512>;
+    };
+
-- 
2.24.1

