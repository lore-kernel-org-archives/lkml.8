Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C36C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1822072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HFA4ICVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXO6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34188 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBXO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so2403769wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbPDnJvMb3x4DYL4TCdJnWqdiB62oTXrzN6fiKtZb+M=;
        b=HFA4ICVw6V3LfO9qsOscd8/53GDOJ3feJ6Ji0HTsOjTTuAfuXMA0hsAdQkCSU+bL1q
         qhfqsEkCP2czU4Xjmkmw+EEm6CZaDVFNLQIiAg+kUooHrcLk+Opg29JGVI7CWnl4biTJ
         Juwq/Os17E9C9puNGBVtGWkN4iKkMLauBzjpW6A0K6hfC2sAB+hy9SgW9Sexlmlgs/7B
         W+JJ1c3ikKSjCl0izRj2FzutJE98f+IzxhtqGCxOzFm7enLHKcK2BweferHjmXshlRAR
         qay7/kngc50egqFvqA6+AOFo/Qe+IPVz8uXpFDz5wYPax0ITcqQ0eQQzank8PArcR/Fk
         2+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbPDnJvMb3x4DYL4TCdJnWqdiB62oTXrzN6fiKtZb+M=;
        b=ZmNzE21NjrAl5/4RShIu8qLUQ1ZO5wZ+A1sC3EajUAx9MvixGKlheeNbEn613t7Rcj
         yv/U19OQqtsGcl6NoDAnOyW3X0012X0uRR+f7j79TbK6aflqvWvD86hiSirCpgB64V+E
         tvARJtAqAlNDC15PihNyGASRH1jX24RtkJrLCOoVmicVXF5MDETXC2uPQdoDQCGmlW2m
         FWzumW8d9x4IMy8JkUOslnN8qs90WcsoMKmfeA4QCajiMDhGVc+t9Z1TgpPZhc5nhDkm
         v09yTMhQbsc6bWcXW9UhSg4j1uoLCnl+b6ay4nn1JIx4KtgCMQet7oDw/sZRNnIKBF9v
         a+aQ==
X-Gm-Message-State: APjAAAWNUluEZGOXPNvPNTln2qt+vV3xXL6ThMC7xTvrzxELpiLuhffR
        hZ9kou1eBdUPpCu+4t35lwvUjw==
X-Google-Smtp-Source: APXvYqwPxiP3e2VegzNZkK0egE5/QUcECBQ7ji696G0f6DJy+KFTKe13E3vEe4wS2WyJefgjBE6iMQ==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr64415099wrx.141.1582556307308;
        Mon, 24 Feb 2020 06:58:27 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/9] ASoC: meson: convert axg tdm interface to schema
Date:   Mon, 24 Feb 2020 15:58:14 +0100
Message-Id: <20200224145821.262873-3-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic tdm interface to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
 .../bindings/sound/amlogic,axg-tdm-iface.yaml | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
deleted file mode 100644
index cabfb26a5f22..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic Audio TDM Interfaces
-
-Required properties:
-- compatible: 'amlogic,axg-tdm-iface'
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "sclk" : bit clock.
-  * "lrclk": sample clock
-  * "mclk" : master clock
-	     -> optional if the interface is in clock slave mode.
-- #sound-dai-cells: must be 0.
-
-Example of TDM_A on the A113 SoC:
-
-tdmif_a: audio-controller@0 {
-	compatible = "amlogic,axg-tdm-iface";
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
-		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
-	clock-names = "mclk", "sclk", "lrclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
new file mode 100644
index 000000000000..5f04f9cf30a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio TDM Interfaces
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller-.*"
+
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    items:
+      - const: 'amlogic,axg-tdm-iface'
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: Bit clock
+      - description: Sample clock
+      - description: Master clock #optional
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      - const: sclk
+      - const: lrclk
+      - const: mclk
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    tdmif_a: audio-controller-0 {
+        compatible = "amlogic,axg-tdm-iface";
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+                 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+        clock-names = "sclk", "lrclk", "mclk";
+    };
+
-- 
2.24.1

