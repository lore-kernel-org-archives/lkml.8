Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A2C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13C620838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LpM7mpj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBXO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:58:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37460 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgBXO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:58:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so6484170wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdwXQ7pH6rI6ueZApn+K43TDTHvz3mfvfA2n6YIMVTA=;
        b=LpM7mpj7LiZYFY1F/LHsfKrbgKu9KMEEPBIR7iDONOQtj5dzo4PULT5jUyW8VBENL7
         ErVZShkH6j+APMl0j47EspIm4CwGk9WYyH+f6FoSIYTjN4yTAoJh+CJiUTrJ5Gdtwqwq
         b6w2PcF2xLt7hUCknO6OepJMPbtuZhua9fSEKjbXvhGoX/pERSl3Y9o7tppCYNjp8ESs
         O1c993L2XPYgrMdjGFiGfQJAn6Tn75s3iH6AqFliUtHIChwfNQvJrCBf0tIFCjXOqOgl
         S8Ons34q9AFhe8dmhrVCQ6kXq9TCLFxm1YFMA2n0G3vawr70esVlFNS5i9GgW4pgD8X2
         3vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdwXQ7pH6rI6ueZApn+K43TDTHvz3mfvfA2n6YIMVTA=;
        b=hSeGn5FPYl3f+huvNI4TjI4RUJHzO/KMEdoymVOFJTXzbMi/4BbeFilDdilZSqBHnm
         2Y0l30kLI0GYQoXCle4Pqp0XFVDXEXP+pxLhYsMvAidtU1GxZtRaThTQXAEHycIIavdm
         RasWRTJbuYFEif21YO/hS0ihbxYbzT9LgXk4g6/pSKgRIQrJOvQkLliTwD0QL8xkhCRj
         uk1oWn9eVE/g+oEG0bQBw4nx+ZJxdDGCD+g6rM7YBVhzHH0/Q8fKQ+f3qUCyrTD1u6R7
         bnxkgP/lxmZHQoznCW9Y0kGX9KXS8jj17IhSd+NQjgKlNKrMkQBN0ZGUy9CfcvW1riI9
         HnzA==
X-Gm-Message-State: APjAAAUQu9GuCkOMpB3W7TIbbQoWljFYvUO+T8XgTGF7jszhIBH5UlFL
        1Q8kDNyojGPWLKveVDZVv5Bupg==
X-Google-Smtp-Source: APXvYqx6BBo21R5PTgXLbRReQuUMfO7alOUBEJcwx+E701SSNNZySFjVl7yKssosp1Wkvm7UURQw2Q==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr69304362wrx.288.1582556313782;
        Mon, 24 Feb 2020 06:58:33 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm8035127wrt.35.2020.02.24.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 06:58:33 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 8/9] ASoC: meson: convert g12a tohdmitx control to schema
Date:   Mon, 24 Feb 2020 15:58:20 +0100
Message-Id: <20200224145821.262873-9-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic g12a tohdmitx codec
glue to schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  | 58 -------------------
 .../bindings/sound/amlogic,g12a-tohdmitx.yaml | 53 +++++++++++++++++
 2 files changed, 53 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
deleted file mode 100644
index 4e8cd7eb7cec..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Amlogic HDMI Tx control glue
-
-Required properties:
-- compatible: "amlogic,g12a-tohdmitx" or
-	      "amlogic,sm1-tohdmitx"
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- #sound-dai-cells: should be 1.
-- resets: phandle to the dedicated reset line of the hdmitx glue.
-
-Example on the S905X2 SoC:
-
-tohdmitx: audio-controller@744 {
-	compatible = "amlogic,g12a-tohdmitx";
-	reg = <0x0 0x744 0x0 0x4>;
-	#sound-dai-cells = <1>;
-	resets = <&clkc_audio AUD_RESET_TOHDMITX>;
-};
-
-Example of an 'amlogic,axg-sound-card':
-
-sound {
-	compatible = "amlogic,axg-sound-card";
-
-[...]
-
-	dai-link-x {
-		sound-dai = <&tdmif_a>;
-		dai-format = "i2s";
-		dai-tdm-slot-tx-mask-0 = <1 1>;
-
-		codec-0 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
-		};
-
-		codec-1 {
-			sound-dai = <&external_dac>;
-		};
-	};
-
-	dai-link-y {
-		sound-dai = <&tdmif_c>;
-		dai-format = "i2s";
-		dai-tdm-slot-tx-mask-0 = <1 1>;
-
-		codec {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
-		};
-	};
-
-	dai-link-z {
-		sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-		codec {
-			sound-dai = <&hdmi_tx>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml
new file mode 100644
index 000000000000..fdd64d103f33
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,g12a-tohdmitx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic G12a HDMI Tx Control Glue
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 1
+
+  compatible:
+    oneOf:
+      - items:
+        - const:
+            amlogic,g12a-tohdmitx
+      - items:
+        - enum:
+          - amlogic,sm1-tohdmitx
+        - const:
+            amlogic,g12a-tohdmitx
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
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    tohdmitx: audio-controller@744 {
+    	compatible = "amlogic,g12a-tohdmitx";
+        reg = <0x0 0x744 0x0 0x4>;
+        #sound-dai-cells = <1>;
+        resets = <&clkc_audio AUD_RESET_TOHDMITX>;
+    };
+
+
-- 
2.24.1

