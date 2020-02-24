Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C5C11D37
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7612082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NJSESJwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgBXO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35368 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBXO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so9742903wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OJoB//spfjO/IU33dyjF9Pxncay2n5Huh8I5gGbVYY=;
        b=NJSESJwpD7rdlg2Py2/a9hEzVwszz8QXKtIpMrm9dixL6SF4DCivsT2sVJpLDGZcMJ
         hVDUYsqrC+/Tn38Wu/C5lgprd3ZcAw0OPXV6TLBfUvHdlOgH8G9Iz8OfyLioRgLluizs
         afm+PP/Zp3zIMLbAHEJI8ojfoSUiqx3URqqJvuH1hQKP2eULmOtq3//0APBmL2FLv29q
         hB/OFR8KC7hbGAuEPPalWlcEkTCJdoc5EtA9/Zi8eG3k1RiE8c/su7csxJ9KfsBy34hu
         dp64tWM0zojAWxhE4SLXj+OxoElDsa7ndcak1iUVeqf0JPMY90rDnRR9BkiyjCDAPKqm
         vrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OJoB//spfjO/IU33dyjF9Pxncay2n5Huh8I5gGbVYY=;
        b=AaKmXUS/gHnwc19wHz2DoOOl1zIWhgrC/ApuL1yTspe9IBTM3ZyQN+xikyUa6IZ80K
         iZL0UVFdF5CycRU6dPHrMndB4DESEzyC7nfL4012huuUMlz8/1yCBum0vMuk7VyAnLrl
         smCuJrCnCkmabiyDOAVhqIblPZ298f1HG7ugt+ihUxZWKzAHWrAIxf9p16C29sreYk21
         iJ4Wco4XaaxoEJIRDGLqM2cCCNyufr4PJTJrmWTycAT+Xmeqvjioe1kKK0SrK2dFb6fS
         0YIkrTNaX+sMjw+5TEkKr95/vQGFP6H8A2VgiZrMe1HkliBvt5QOEAcMThWEEkPUxq+h
         EkDQ==
X-Gm-Message-State: APjAAAUgMHM6S9ICubchJYMI4QSBG7ZWLBB4wEjbJzgKdyZ9xZhDnxVM
        Tfrj0OQe8fPTTDk5kvCgdPJx+437jvU=
X-Google-Smtp-Source: APXvYqzPABP3vha2W+KZHGMeyNLHDDONVJ2avGCuEoixvZb3qGftRCKvja4t1WsUu6PnKu65VXekIw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr23429419wme.53.1582556309756;
        Mon, 24 Feb 2020 06:58:29 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:28 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4/9] ASoC: meson: convert axg pdm to schema
Date:   Mon, 24 Feb 2020 15:58:16 +0100
Message-Id: <20200224145821.262873-5-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg PDM device to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-pdm.txt        | 29 -------
 .../bindings/sound/amlogic,axg-pdm.yaml       | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
deleted file mode 100644
index 716878107a24..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Amlogic Audio PDM input
-
-Required properties:
-- compatible: 'amlogic,axg-pdm' or
-	      'amlogic,g12a-pdm' or
-	      'amlogic,sm1-pdm'
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk"   : peripheral clock.
-  * "dclk"   : pdm digital clock
-  * "sysclk" : dsp system clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the pdm input.
-
-Example of PDM on the A113 SoC:
-
-pdm: audio-controller@ff632000 {
-	compatible = "amlogic,axg-pdm";
-	reg = <0x0 0xff632000 0x0 0x34>;
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_PDM>,
-		 <&clkc_audio AUD_CLKID_PDM_DCLK>,
-		 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
-	clock-names = "pclk", "dclk", "sysclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
new file mode 100644
index 000000000000..aa90b77e593d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-pdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG PDM input
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
+        - enum:
+          - amlogic,g12a-pdm
+          - amlogic,sm1-pdm
+        - const:
+            amlogic,axg-pdm
+      - items:
+        - const:
+            amlogic,axg-pdm
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: PDM digital clock
+      - description: DSP system clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: dclk
+      - const: sysclk
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
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-pdm
+          - amlogic,sm1-pdm
+then:
+  required:
+    - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    pdm: audio-controller@ff632000 {
+        compatible = "amlogic,axg-pdm";
+        reg = <0x0 0xff632000 0x0 0x34>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_PDM>,
+                 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+                 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+        clock-names = "pclk", "dclk", "sysclk";
+    };
-- 
2.24.1

