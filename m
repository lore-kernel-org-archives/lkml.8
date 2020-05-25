Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309E42075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu0Me0dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgEYDlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388397AbgEYDl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:41:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD597C061A0E;
        Sun, 24 May 2020 20:41:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so8128698pgg.2;
        Sun, 24 May 2020 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MtXq2QWDOoN0CBKSeH60c2tJASyOu/uu0I8Lzq6RPtM=;
        b=Uu0Me0dGDuqxYix7sKTmgNEVZhxag/XQKpN534oTVw9rKWGtvA9xHjsL1UJK9EHqtM
         nTKC1y2cevDfXsqAT0EYJvl8CF73OhyMOohDURns9BNuV5Rc9adO0KEa3uwcxCsnP/mx
         EyB5Hjqc6Sa+myM+jtbKMHbS9WzPPlgjS8Oe581UgE7bvXzAOGSNdHyPXhR1AGfwYaOc
         rPtop39Crps4TEq4vIoNsfU2i/khaZbcUJIm28SNH/z0XB7uXoNdttEsUFzSmFjnhCKB
         mdAoD+tHQiD5gk3Qoo7RpLrnvHVJ/+WPuPEmDrEWFXf7JwJSPVcW1ggvNyeKJeJY1grf
         FTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MtXq2QWDOoN0CBKSeH60c2tJASyOu/uu0I8Lzq6RPtM=;
        b=f3UC+WAxvTIPPEQhfb1ZTXkdc/QioFY5wmzm4FO44JYRmt9SVAqRoAbI+k3b+0Gq/i
         MyiOoc9meBUh9nzjWCpjmcTPRPIwFODgABY/7AddENg35FBpk9pKwFpO57a6mkXTQUQb
         8LDdXZWTmuqIjYTevk75lU5o9FUEAw7opIQhgRDwF3ELpfSSMjUEjia9AiF+8x3TV1Ax
         mdDOZaTPYdjQQwoTpqadZMNR751vV94DIGFyCQp1ScuA3OdpS0eiaGDiUuYJseDAcBiX
         UrsXdSYD3Z8Iof0gF0sgVsFfEhlpa7q6k5hHTKvag8OECL+RVyjHvh0jF/DIbJ74YSqC
         Q6fA==
X-Gm-Message-State: AOAM533+PXOy8ScYSQWJbH9zUhBEkkO+tiiIT9SOjRGNy+haKk9tAk1Q
        nxK9Xztp6ZvaX66t46MmrBM=
X-Google-Smtp-Source: ABdhPJxXQqJcbq5UIqIaFFaMYgZDDnOf9VW5SW6flIYRe44Lc/7NrxypHleIUL/neqr4Ngl52ftzNQ==
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr23931653pga.312.1590378089383;
        Sun, 24 May 2020 20:41:29 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id 7sm11981695pfc.203.2020.05.24.20.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:41:29 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 4/8] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Mon, 25 May 2020 11:40:58 +0800
Message-Id: <1590378062-7965-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 0000000..2172f88
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams with 16 bits or 18 bits.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ili9341 240*320 Color on stm32f429-disco board
+        - st,sf-tc240t-9370-t
+      - const: ilitek,ili9341
+
+  reg: true
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - port
+
+examples:
+  - |+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel: display@0 {
+                 compatible = "st,sf-tc240t-9370-t",
+                              "ilitek,ili9341";
+                 reg = <0>;
+                 spi-3wire;
+                 spi-max-frequency = <10000000>;
+                 dc-gpios = <&gpiod 13 0>;
+                 port {
+                         panel_in: endpoint {
+                           remote-endpoint = <&display_out>;
+                      };
+                 };
+             };
+        };
+...
+
-- 
2.7.4

