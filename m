Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9FFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD44521582
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jgO6nuaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIGITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgIGISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:18:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so13484358wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miWW6H6jXaFE/FyCEk5bY4nk7z7nkaDQEzvoX6DPlkA=;
        b=jgO6nuaRnlo0R2OYFX2vcDkqIExJA3JJthDEk7bvwcmzptmlrdmL9LVBaBYN+tgFno
         3Xy+PA6367n1pTE12o5y1KJC0pJan5XYQdAxgLIvpfe0/eYP3DeMjz+ck5qtw8SYM9qo
         J0AaFTHJ0hi2U58MsHU8vsIOh8yMo6JhUTSVtPjedZCyBClJAtST6EI2aUNnERV67TZa
         YxodpFCjL3Zli9Wgpg53hQ9fkU0GKZpETAQypmWG5MaFv9H51Mv0klk23hVicKOVW4iG
         3DaIltmO1vFQnyrBIMtX5/Sg2ECwSDcurrC2TGyBfPUxu9o94hsBvBuknTsJsT/RjFZT
         ZI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miWW6H6jXaFE/FyCEk5bY4nk7z7nkaDQEzvoX6DPlkA=;
        b=PichfAzB2ZPFyrSLkVtL6QKIs/ZWvtqS3Z26R76vDT7Pmc2vyDdbYs3XAk5G8l1OBe
         pGmPKdTkDUoqgNmF1PmCZ0oGHItfDeuEMIICU7zqVXNxBScJdN+N7skx62dojqmJ8Q0O
         wtDytvH4ejR88P9lUy5jOu3lXVTGoJZaUCCh1Ot5war68SAVt6J8CW5Mv8oWMtBipHSf
         272bg5mCJL/xCaZzJ8sjtIKDPO1MtuVN+MagMr5X8Mzmscnw7ey3cN88WN35VMix1spb
         A0IdCOJHBOVcVRz39r7Ox/DieERNYBiFObw2R6zwEPi9p62Nb/HqPZ6gnf/wTmjep8vb
         9PxA==
X-Gm-Message-State: AOAM532mYrkUssz4pO3+OElzg1bVeyaqNlzhx+uckHuI/NZxzAZtWFa7
        lddyEwO/7cD3QXNLBFgtT9lClg==
X-Google-Smtp-Source: ABdhPJzt7+ODbEr1nL9IMe4B5idhevglKUu034LrO7TAnTPbUIolpz1hDb42Mq+Viw7CjTrnT2KwwQ==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr14600574wmb.142.1599466711691;
        Mon, 07 Sep 2020 01:18:31 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id q186sm28032205wma.45.2020.09.07.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:18:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/6] dt-bindings: display: amlogic,meson-vpu: add bindings for VPU found in AXG SoCs
Date:   Mon,  7 Sep 2020 10:18:20 +0200
Message-Id: <20200907081825.1654-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907081825.1654-1-narmstrong@baylibre.com>
References: <20200907081825.1654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG SoC family has a downgraded VPU supporting only MIPI-DSI output
after it's ENCL DPI encoder output.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/display/amlogic,meson-vpu.yaml   | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
index a8d202c9d004..e2e7d99d8ace 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
@@ -31,8 +31,10 @@ description: |
 
   The Video Input Unit is in charge of the pixel scanout from the DDR memory.
   It fetches the frames addresses, stride and parameters from the "Canvas" memory.
+  On the AXG family, the Video Input Unit direclty reads from DDR memory.
   This part is also in charge of the CSC (Colorspace Conversion).
   It can handle 2 OSD Planes and 2 Video Planes.
+  On the AXG family, only a single OSD plane without scalins is supported.
 
   VPP: Video Post Processing
   --------------------------
@@ -49,11 +51,13 @@ description: |
   The VENC is composed of the multiple pixel encoders
    - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
    - ENCP : Progressive Video Encoder for HDMI
-   - ENCL : LCD LVDS Encoder
+   - ENCL : LCD DPI Encoder
   The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and clock
   tree and provides the scanout clock to the VPP and VIU.
   The ENCI is connected to a single VDAC for Composite Output.
   The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
+  On the AXG and G12A family, the ENCL is connected to a DPI-to-DSI
+  transceiver.
 
 properties:
   compatible:
@@ -65,6 +69,7 @@ properties:
               - amlogic,meson-gxm-vpu # GXM (S912)
           - const: amlogic,meson-gx-vpu
       - enum:
+          - amlogic,meson-axg-vpu # AXG (A113D, A113X)
           - amlogic,meson-g12a-vpu # G12A (S905X2, S905Y2, S905D2)
 
   reg:
@@ -92,6 +97,11 @@ properties:
     description:
       A port node pointing to the HDMI-TX port node.
 
+  port@2:
+    type: object
+    description:
+      A port node pointing to the DPI port node.
+
   "#address-cells":
     const: 1
 
@@ -102,11 +112,31 @@ required:
   - compatible
   - reg
   - interrupts
-  - port@0
-  - port@1
   - "#address-cells"
   - "#size-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gx-vpu
+            - amlogic,meson-g12a-vpu
+
+    then:
+      required:
+        - port@0
+        - port@1
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-vpu
+
+    then:
+      required:
+        - port@2
+
 additionalProperties: false
 
 examples:
-- 
2.22.0

