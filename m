Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7419FC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54016206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHte5rVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgELHD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgELHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:03:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5DC061A0C;
        Tue, 12 May 2020 00:03:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so5943026pfn.3;
        Tue, 12 May 2020 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o//dTfJVTpsa5Zo7nPNQBSOusaLkGD86FZMNihxJfus=;
        b=gHte5rVUD6y77Xe/TFwjDfYe9ap4bclJIR3xqi1I4zZijHaTmhe0Gim+Ke3EaFnJXe
         XJUjPVATgmdLPBcdDcR2qvWe2tRzSWZuFX3VmGuLTvYRJYbWD4+vqJebdZlZ0s+4uF/q
         EOsHEQv66zGagOhM3QAwtb5vCkNRPX9YPjRBJiOCej/P6J6Acyko6XtZNeWvFM1CbH2I
         VSToK4mNIq0e1Y1inpqYK+SmtdgxbaFKQe+EzRBulSqHa2pf3fwoMz5qa+5MZbIeK3uV
         YvPxu4ZQgWH6ZHmBADxC/MtYhY7NVcdmzOg40KLgnYVFrmHg+4htNhrzMAMfu+zc8Uei
         VoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o//dTfJVTpsa5Zo7nPNQBSOusaLkGD86FZMNihxJfus=;
        b=Zfl1H8eKudZulaow1GhTr9zlswR6FDpZ3Ba32xYkLTEPTVCjHhsA5AtRdTEDSBg0B+
         VzVzQktmtQ9Ivw4oP9XakyQj9prP0A245YVKVfBQ/4mCT+gztGFVuaAB1HK4QzkqEwQ7
         VN7Hk2V9MqB6hLoUR+wCf85yzBGKLFKfjmKULWU+d5/es4dOXrP6kbuHXPqnDiJaKXMP
         NMBksNa1lW8F8OCJgKU6jjSthNs8FBQTEAlMQsGrZN5ozcLed5/FrST4r/MzEiS31apK
         +aJr/+A2d2pNZkbc9voWlLcIFGtdIDlDn9e/VqCp07JTwIibE4Aij7HfI0t0hCyXTl4y
         GXoQ==
X-Gm-Message-State: AOAM530Y7CjwFfR471fKd2WTz8V2X61UUt6HGTGjFzWEJ4PuUcOQXId5
        CqZxBaGlLlAlebWzYOxOOcs=
X-Google-Smtp-Source: ABdhPJyvQqwVfnqNh+p34cdkk3VkqZVcQx818ZVzyde7cIL1JuJ8VM2Siydwch4p+f1lnq+Vtm0N7A==
X-Received: by 2002:a63:3c19:: with SMTP id j25mr9279778pga.434.1589267032602;
        Tue, 12 May 2020 00:03:52 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 62sm11016369pfu.181.2020.05.12.00.03.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:03:52 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH v3 2/5] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Tue, 12 May 2020 15:03:34 +0800
Message-Id: <1589267017-17294-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Changes:

V3:
    change compatible to st,sf-tc240t-9370-t, match #vendor,#lcd_module style

V2:
    verifyied with make dt_binding_check

V1:
    none

.../bindings/display/panel/ilitek,ili9341.yaml     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 0000000..9f694d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,68 @@
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
+                 compatible = "st,sf-tc240t-9370-t", "ilitek,ili9341";
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

