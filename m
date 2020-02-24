Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DDC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930E62072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BxwsppZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgBXO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39869 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgBXO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1933277wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+m5Zk6ATehdxswy6Hjbn0kVD8RHIMq9I1KqtdFphR4Y=;
        b=BxwsppZ2TqEjT+8Z3y25ke1pudvOilFOi8pPUubmpCnhiDngRYPXdE94G7U9Ava7zQ
         RomwNhFUanS4atJGqdbEqofH6EZH/03ujPLOashF22t7WT2B1Fhp7Z9KFA+8uPmxzRMt
         0h2oPjI7KDMWdHsVDhW1N6Eu9/UVeLCDLPonER6wXezzegFK9KFX61o0pT2TOElUJex3
         gQv8ec3/kuemWFl7o+5ymRoCd6NmXdQ66o7/uaxH+5SIUtHSfr05mntPv7wZsULLI7Ij
         bWBoqaYzCjFr3npplC/8TRkuHWl35sd6nxfFn9P3WZ9X8q8LCuQOiF8stMRuF4ocpmby
         fbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+m5Zk6ATehdxswy6Hjbn0kVD8RHIMq9I1KqtdFphR4Y=;
        b=aYHfXIje18g67yrtz658R338J2JIDJjlNLfwCq7S+P3E98R95hUx2dUQN20Js69oSD
         rnBJFQtik80mPby/iMphKteydbwUHVNKzwEVw3yD2QsaO4nvII6JC7IXfiAVnt245J13
         uy5Lxpz1oEPt/DTOoSOyZjMkY/HJm5S4Hr9R9B+QmtMRltbdPTFvy98sDzcpCSMTWTeT
         Z7M4CFY3b/oVQfL6W2chLDdORMqU54X8LFnzbCxdJmuTGEAszZHhYoUrifTkL/9GCnfQ
         idRCTtond6rToroMmBuIe2TMj+VPgReigBWwZ8CJe6OuxPsMdfrL+giMxvEbBkQklEgq
         fsQA==
X-Gm-Message-State: APjAAAUA3JbozDDxs+XX/VKs6DiZbr6Aht5Rmo+Hzh/eKdwugYJIzaVl
        m8WXcI95AxS/KCxtQPmn+myZ5w==
X-Google-Smtp-Source: APXvYqwKJQRnmPqcIIix9h+Okty9D6LqCQRrxgqAPcpQ8cagQSHDEFG5tHJ6MlgBAUv48MiCgtTlPw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr70933271wru.57.1582556312782;
        Mon, 24 Feb 2020 06:58:32 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:32 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 7/9] ASoC: meson: convert axg spdif output to schema
Date:   Mon, 24 Feb 2020 15:58:19 +0100
Message-Id: <20200224145821.262873-8-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg spdif output to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifout.txt   | 25 ------
 .../bindings/sound/amlogic,axg-spdifout.yaml  | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
deleted file mode 100644
index 28381dd1f633..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Amlogic Audio SPDIF Output
-
-Required properties:
-- compatible: 'amlogic,axg-spdifout' or
-	      'amlogic,g12a-spdifout' or
-	      'amlogic,sm1-spdifout'
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk" : peripheral clock.
-  * "mclk" : master clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the spdif output.
-
-Example on the A113 SoC:
-
-spdifout: audio-controller@480 {
-	compatible = "amlogic,axg-spdifout";
-	reg = <0x0 0x480 0x0 0x50>;
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
-		 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
-	clock-names = "pclk", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
new file mode 100644
index 000000000000..9ac52916f88b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG SPDIF Output
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
+            amlogic,axg-spdifout
+      - items:
+        - enum:
+          - amlogic,g12a-spdifout
+          - amlogic,sm1-spdifout
+        - const:
+            amlogic,axg-spdifout
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: SPDIF output master clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: mclk
+
+  reg:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: dedicated device reset line
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-spdifout
+          - amlogic,sm1-spdifout
+then:
+  required:
+    - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    spdifout: audio-controller@480 {
+    	compatible = "amlogic,axg-spdifout";
+        reg = <0x0 0x480 0x0 0x50>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+                 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+        clock-names = "pclk", "mclk";
+    };
-- 
2.24.1

