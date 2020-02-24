Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E67C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F31B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iYSdXnfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBXO6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44658 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBXO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so10706714wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GUC3r+7+XLZ1MnTHNeVxioo8UtC8ynUGXhqoFIr38o=;
        b=iYSdXnfZfenDrSM3NrHSdFp0SkkGQ0EccB/BQ6ZL6qmgu1dkYPK+tOaU2sT339KqsG
         AklFU6MyF1IJfG3DYEn9+EsQePg0FixjiwvyXbJVsxGvadzoaewawwkcNOdKV9Htmq01
         TnyNvXNFEyH4WnFmR7tKa/ERovodprH84TOZ/iyUhSFb7drHqh6xxDjxZPQ+SQhW33sQ
         b5il+GsUvtIgc5pnDtpvac6aKM+VTUdylOgaxtY5fRdymhmEZAheP/2PVKJgCJeyEHj2
         64IQUvwcer7G9rwk0n3uKlFdDT22B2wXpTl37fVmOMT+/5Y+itZDiUkdNVDbEocEIE9e
         MWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GUC3r+7+XLZ1MnTHNeVxioo8UtC8ynUGXhqoFIr38o=;
        b=C1MInKLgO0LKQ8rrY9U/nTYjrO/CzWJx+0NNOAb23kaJP1l/qTFS6Y1p5lkcz5RW0I
         B6V8Ic8zzUtm3rw92PeIxwcUTB3BhLMH9DalUbV/ALg5IeehxJN4ouszGkvvgCqPky18
         HYiIcxR27Kl7BYU7gyYl73JTzo1ZgKHwmQIHdrSYXFUZGmk/a0kWCXqzkBnPLvavMYkY
         pU2/ng7X+o3Bsp0z4lphImzEwy0Pplso5gu0aLhdctqJdYoeTISYpLt1AObKBRLhRnMV
         4E3LQAwpos4J80NsCgMG5p1x+BZrRLCbjgTLLfs3isWFwq2vRsF2LhGFjPO7bAfn2ma+
         QdPA==
X-Gm-Message-State: APjAAAX1DM6HwxAzJkAUtgYZ6wZaXDzQX93c+4NYRLukVXq3NYdoj9/B
        KQGRmRV7kcju5hJdu1L+j9gu3A==
X-Google-Smtp-Source: APXvYqzvG6wN9QHqbYKHMBdBwFlan6RiQm6wsilDz1UiJ8oMW9F8w7g4WBpGnn3CxfgONsTL+fNtLQ==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr41194382wrx.410.1582556311811;
        Mon, 24 Feb 2020 06:58:31 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:31 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6/9] ASoC: meson: convert axg spdif input to schema
Date:   Mon, 24 Feb 2020 15:58:18 +0100
Message-Id: <20200224145821.262873-7-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg spdif input to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 27 ------
 .../bindings/sound/amlogic,axg-spdifin.yaml   | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
deleted file mode 100644
index df92a4ecf288..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Amlogic Audio SPDIF Input
-
-Required properties:
-- compatible: 'amlogic,axg-spdifin' or
-	      'amlogic,g12a-spdifin' or
-	      'amlogic,sm1-spdifin'
-- interrupts: interrupt specifier for the spdif input.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk" : peripheral clock.
-  * "refclk" : spdif input reference clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the spdif input.
-
-Example on the A113 SoC:
-
-spdifin: audio-controller@400 {
-	compatible = "amlogic,axg-spdifin";
-	reg = <0x0 0x400 0x0 0x30>;
-	#sound-dai-cells = <0>;
-	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
-		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
-	clock-names = "pclk", "refclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
new file mode 100644
index 000000000000..b9b0863c5723
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG SPDIF Input
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
+            amlogic,axg-spdifin
+      - items:
+        - enum:
+          - amlogic,g12a-spdifin
+          - amlogic,sm1-spdifin
+        - const:
+            amlogic,axg-spdifin
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: SPDIF input reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-spdifin
+          - amlogic,sm1-spdifin
+then:
+  required:
+    - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdifin: audio-controller@400 {
+    	compatible = "amlogic,axg-spdifin";
+        reg = <0x0 0x400 0x0 0x30>;
+        #sound-dai-cells = <0>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+                 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+        clock-names = "pclk", "refclk";
+    };
+
-- 
2.24.1

