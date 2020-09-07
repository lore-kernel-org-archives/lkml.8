Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE84C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5322145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J66KLzlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgIGISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgIGISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F5C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:18:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l9so13287270wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0HsauPurP4GLwNBopn5TZUsUZJKLkyzLDWrJr/4s5U=;
        b=J66KLzlOYfq63rz/EDI2/aR4JNB6BbshNVdCF0X7BoOXx8o3cPwwoD4FA2dtwXw66D
         jIQX9rFkKLZQ9wB/HmiYiMdhuY4afx3UkS2sDyJnZu0cMaNbusqbjiQIaKGtQQuXz/aa
         USbX4T2elF97eM1fMje7fNj8+x9bGo1er6L1qzB42H+G5T3xhG7wbmSuRMy4NbGjnGP8
         d8HEDEEl/qOiT2DY8wQmCwFr4N1VqNLmqeCNyDoHy6g+yjWDcH5WQuUuOsQRrzFxUOaZ
         DnkA/kuikMDBtrB6ybir6wiFs8/gED3EDAbZlYM+oj1M8wV5mSGFFw49l7vloRbfEFTX
         L+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0HsauPurP4GLwNBopn5TZUsUZJKLkyzLDWrJr/4s5U=;
        b=tPwgd3nr9zmovBfDyzUy//F9gYJiMBk+DOWNFKozTxZ5jV3rxNiCl7uaz8KVEhFdyy
         RXCiMOhlWDSzwGUDXVtpNkIe4AxzxFIrEb0dPNQrqJWN4WGTsQ+EP6gy7mF+gSEyKXPb
         TfA3PDi6GBOYninMSppuFfD+2cMwW5emVaBqEzFf6E+mu6CfrjZpDEB9X4XCFkJLLpzD
         N3XEYcragON1FSguOPm1NV/X/NBVuYtE98gSFrMAbaTMPmdD/I/2/HxN86CAAvJB8BgL
         H/IPfEpFtFbVsMHSDOasI8GfmxEt4deBYlcvQm84XQir1eomFfElWzS8NgtK6iMn0bnJ
         cesA==
X-Gm-Message-State: AOAM532U/CzWZun8blR2j0I2rVNWFKbuG3Kd63Q+CFvozNKdHrnOLkoC
        bCgDlQxCeXHT4XmaX2TfPnRGVA==
X-Google-Smtp-Source: ABdhPJwT5w0cdNog5hvbeofOd9g2nUaa5JeJ2ZchwmHJ7pv5qSRDx2+v0cWfcXr2DTx0d7DcEDFbEA==
X-Received: by 2002:a7b:cd05:: with SMTP id f5mr19294990wmj.116.1599466713146;
        Mon, 07 Sep 2020 01:18:33 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id q186sm28032205wma.45.2020.09.07.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:18:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/6] dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
Date:   Mon,  7 Sep 2020 10:18:21 +0200
Message-Id: <20200907081825.1654-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907081825.1654-1-narmstrong@baylibre.com>
References: <20200907081825.1654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a), with a custom
glue managing the IP resets, clock and data input similar to the DW-HDMI Glue on other
Amlogic SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../display/amlogic,meson-dw-mipi-dsi.yaml    | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
new file mode 100644
index 000000000000..6177f45ea1a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-mipi-dsi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic specific extensions to the Synopsys Designware MIPI DSI Host Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The Amlogic Meson Synopsys Designware Integration is composed of
+  - A Synopsys DesignWare MIPI DSI Host Controller IP
+  - A TOP control block controlling the Clocks & Resets of the IP
+
+allOf:
+  - $ref: dsi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-axg-dw-mipi-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: pclk
+      - const: px_clk
+      - const: meas_clk
+
+  resets:
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: top
+
+  phys:
+    minItems: 1
+
+  phy-names:
+    items:
+      - const: dphy
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: Input node to receive pixel data.
+      port@1:
+        type: object
+        description: DSI output node to panel.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi@7000 {
+          compatible = "amlogic,meson-axg-dw-mipi-dsi";
+          reg = <0x6000 0x400>;
+          resets = <&reset_top>;
+          reset-names = "top";
+          clocks = <&clk_pclk>, <&clk_px>;
+          clock-names = "pclk", "px_clk";
+          phys = <&mipi_dphy>;
+          phy-names = "dphy";
+
+          ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              /* VPU VENC Input */
+              mipi_dsi_venc_port: port@0 {
+                  reg = <0>;
+
+                  mipi_dsi_in: endpoint {
+                       remote-endpoint = <&dpi_out>;
+                  };
+              };
+
+              /* DSI Output */
+              mipi_dsi_panel_port: port@1 {
+                  reg = <1>;
+
+                  mipi_out_panel: endpoint {
+                      remote-endpoint = <&mipi_in_panel>;
+                  };
+              };
+          };
+    };
-- 
2.22.0

