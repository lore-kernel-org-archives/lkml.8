Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8E0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245C4206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L5LV3Tmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgIGL2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgIGLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:23:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0597C0617BC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:10:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e16so15380202wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksfc1mO30cLXViBtYtZb85XN30sTC3Vit9JBymnzNwE=;
        b=L5LV3TmznwxKFMrjSInEz1r5fPbaLK01lzlEqVLfKgITk1M38tBh9QdrNF27X1ewbv
         ZJ5CYAaFOyCM5/1/HyhDBqiQXHF6QC2ItV03Crj1+DuptshphgdT2guRFJ5ogbztJ21e
         nvAhIRwVurv8gJ8aFWF4v9KZRPjSTHWTaSScPxm4r0ze38QLlYUZnuMGJ8UKmW3v0B62
         IIkezs/Q4LnnltkCxjhi1sThjVoXoneJF6QmZN9uvifez/woOa1yqSPTzWhWG6TPWjJN
         MlYdOSX6EKBwHjnkcguFebmW+tXjWHhBQJGqJHVCl9JguyHb7a/U/jDftkyHo8J8a37u
         fV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksfc1mO30cLXViBtYtZb85XN30sTC3Vit9JBymnzNwE=;
        b=cEC9AB0w1N+R6nGAaYpVqqpiIyFDEv6tAtK4EYKgdm+MiqYhsQBVb2Z/RNugYhFaOO
         lVXs34R+U8rQ+nC4Rcnhi8NCWJI4rtXwxeEms815krppbwSkzt6JewF2fXO5zc7oHlP6
         4pyF8ib/BgaI10CIV3bx2R12evZ3IX15wNN5fIRK/C5KtkoWaaQRivbyasZw1yuPhHER
         qf/38HH8cnXm/SdQ6+Ew8mof6LQhkYIytRMnohPXiTPs/mqhDGEulPIgv367e7IiVI5m
         bnEMN+MArZDg/6X2nh7nDclh7z4rGFPmo8CarlDMR/qDbNzwVUZLmZ+BkA+KsHVqaJ5C
         bgvQ==
X-Gm-Message-State: AOAM533XxTOq+rcRgGBBdld/Abj2Rk6THOVGUmlGibySiac2+dbSePzN
        DI87grd4vp5N8APggN6VNdEXVw==
X-Google-Smtp-Source: ABdhPJxEekX2hSCryqMffGe1N5PtVtj5Lqq1CMosFkbr9M9VKGuytxsv/T6GZvG6eFxNQ24VGYt2Lw==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr21235068wrf.206.1599477033135;
        Mon, 07 Sep 2020 04:10:33 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u13sm19922111wrm.77.2020.09.07.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:10:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: add TDO tl070wsh30 DSI panel bindings
Date:   Mon,  7 Sep 2020 13:10:26 +0200
Message-Id: <20200907111027.21933-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907111027.21933-1-narmstrong@baylibre.com>
References: <20200907111027.21933-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the 1024*600 tl070wsh30 DSI panel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../display/panel/tdo,tl070wsh30.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
new file mode 100644
index 000000000000..20f4fdedfcb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tdo,tl070wsh30.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tdo,tl070wsh30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TDO TL070WSH30 DSI panel
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+
+  compatible:
+    enum:
+      - tdo,tl070wsh30
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  backlight: true
+  reset-gpios: true
+  port: true
+  power-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+  - port
+  - reg
+
+examples:
+  - |
+    dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel@0 {
+        compatible = "tdo,tl070wsh30";
+        reg = <0>;
+        power-supply = <&vcc_lcd_reg>;
+        backlight = <&panel_backlight>;
+        reset-gpios = <&gpio_reset>;
+
+        port {
+          panel: endpoint {
+            remote-endpoint = <&mipi_dsi_out>;
+          };
+        };
+      };
+    };
-- 
2.22.0

