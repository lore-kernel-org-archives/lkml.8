Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C5CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28320801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UpwCqyvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:35:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:35:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so1567766wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
        b=UpwCqyvK/iJRqEAqXffCvhMHZsJiCId/XWRp1qUJ67tur32wk24vAMUqgQKqw8Kiz0
         3xYH1WP+uOZdF0NVZ5KB7/TZPxj1hxuBsB2sLzw/AcGMYzlBLgEwYhcNiJCcWMvNUrvu
         NzLDpqQT6uYSTgjCnhpxva9aJBEHH8ZrY6E0jPo/SFJ9nz4g4HtZM/otufHJj6b01cKd
         RnmEASpseEdFS6EkbuSlW0EMO6h9SwLERZqKBpmtQoNcUECq3Ll1ejX9W2GnJ6ZZjdy7
         9JDhz/sFaTexrLB86Nij5a/oMdAZfTqeM7WeK5T50q3T+iuWbrpVyj5sY60xmrENKeSY
         3sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
        b=HQV452wBinmYdxzun5vg9OrIWT9uVUGbrIhIzs0MINd9DjtT64gR1wW3pEbfghP7oP
         4J8vSOvNwF1wwswn3x2PBrGzM9rrGICCWYeMRimWhbmdWVZDgonU2acfyztqpdWRes1Y
         3i9aGgXNPjbZIkXjF4xiEzQFo4VECrOADAUaRyTtPPibib+TVflACLT7iCyIU9WPqrjg
         1nQGGy57WGbwnLR2qlshDJkpG/vTDY8405bdUKDhGiCVCBMFdq5Hp8w08UtDYBBX3JTp
         VZ8wTW8uHSptlusepK4jVoIqltAnRM0dRlsNVaYjN6ISSwDeSApXfAknw9wr7aeeIWiE
         VqeA==
X-Gm-Message-State: APjAAAUM/XVEcLjMswyxW/pQaLMOfMXwP9x+meRzBA0EmkRjXtKLAYFM
        kbXXMPLsaDdSOKWH0JiR+K1/Kw==
X-Google-Smtp-Source: APXvYqzxucKgV4r8Bu6KtPj/ZgEuOzvUI3SexShfY8duouA2EFO2KyxxS3/Xo5gyoAzLBSrovztuWA==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr10756741wmi.37.1582133710071;
        Wed, 19 Feb 2020 09:35:10 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v15sm648120wrf.7.2020.02.19.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:35:09 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 1/2] ASoC: meson: add t9015 internal codec binding documentation
Date:   Wed, 19 Feb 2020 18:35:02 +0100
Message-Id: <20200219173503.1112561-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219173503.1112561-1-jbrunet@baylibre.com>
References: <20200219173503.1112561-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documention of the internal DAC found in the Amlogic
gxl, g12a and sm1 SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,t9015.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
new file mode 100644
index 000000000000..b7c38c2b5b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,t9015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic T9015 Internal Audio DAC
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
+    items:
+      - const: amlogic,t9015
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: pclk
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
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/g12a-clkc.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+
+    acodec: audio-controller@32000 {
+        compatible = "amlogic,t9015";
+        reg = <0x0 0x32000 0x0 0x14>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc CLKID_AUDIO_CODEC>;
+        clock-names = "pclk";
+        resets = <&reset RESET_AUDIO_CODEC>;
+    };
+
-- 
2.24.1

