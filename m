Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D2C4345A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B20F2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnTEaAYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGPPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgGPPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:39:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:39:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l6so4027462plt.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZAKSAh34vTXMTUWEjv2hN2YsXCAZIAQFEsdbfwVoDU=;
        b=FnTEaAYt0y6BvQOFPCsBRFnTthf3sONoeLwowi4ONN/7NOSqNe/7Guc9c5CyDpPbl5
         UWt9WLPB6kjrzLv2tFFfUbhmNO7xyu7G32cNI2I7WGJ1FBqo1IMpocIoejL3/DyWMLcr
         juFpoZdNbRRZ1prAfjrmKmXrc+lFm2w7bQTqxP9k+uUjTZSd1RizMYBdM6yw3oEGnShN
         GuhUQCcQ7ydXBCXGZ7hJ2JfOig0aOuZC0H7lF+r3+Gw+EV2Zj1TU1Z2wqNVZrlU1/tpp
         LQ10NfyB3EziTrY0Wci0FvwaPeYi7/Kwart4MXJXgXVKUZHknlGtDh7ml9kb3o4oHneE
         CWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZAKSAh34vTXMTUWEjv2hN2YsXCAZIAQFEsdbfwVoDU=;
        b=p82mxUhiWAq8S/knqmTSZk5SvWfu5mBtbPG2uW9lratM2OqcAsQTL/CNQG7g+NWa5S
         UqBvuY4+C5v0MtU1vO9lYIN2h+9ASWlZareOdgI1VGiqMq1kmB3ZqeH/1J4ocTxLSrxs
         a0sLfs5xXkRfCgtieoFQb++W2XJe25Kivivi9FbXYoR7WvE71ohIxETE2thB+wr+wouG
         2jGs3Ks8SuLNayGXu0RnsU8G5rBM9UeOCnEKkU/SM34D7dS9mVDKIWriI3YF5rZgTAD5
         HN5gRuWln14vgpq2D6JXvhM20AvBduD1QzxWrY6bv3ChBPdsTqqgaW429P2ncPv6SASd
         iGxA==
X-Gm-Message-State: AOAM532Z4jjakaV7lUfsRb+zbjfUFmg+PUX+lvOm+xsQG8LUemzelT2P
        9r6D3R8hMEWy+RTAScZ87JsC7Q==
X-Google-Smtp-Source: ABdhPJzqE6oeEFFqme3rNP4ESry/Nvs1h8rm0US3SV0eP4I21Fv1cOF9PvgFvbXn5mcqhBlJZUVx9w==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr5772276pjz.176.1594913959344;
        Thu, 16 Jul 2020 08:39:19 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id f14sm417056pjq.36.2020.07.16.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:39:18 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
Date:   Thu, 16 Jul 2020 21:08:57 +0530
Message-Id: <20200716153858.526-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716153858.526-1-sumit.semwal@linaro.org>
References: <20200716153858.526-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nt36672a panel from Tianma is a FHD+ panel with a resolution of 1080x2246
and 6.18 inches size. It is found in some of the Poco F1 phones.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 .../display/panel/tianma,nt36672a.yaml        | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
new file mode 100644
index 000000000000..3c583ca926ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tianma,nt36672a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tianma model NT36672A DSI Panel display driver
+
+maintainers:
+  - Sumit Semwal <sumit.semwal@linaro.org>
+
+description: |
+  The nt36672a panel from Tianma is a FHD+ LCD display panel with a resolution
+  of 1080x2246. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: tianma,nt36672a
+
+  reg:
+    description: DSI virtual channel of the peripheral
+
+  reset-gpios:
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active high)
+
+  vddio-supply:
+    description: phandle of the regulator that provides the supply voltage
+      Power IC supply
+
+  vddpos-supply:
+    description: phandle of the positive boost supply regulator
+
+  vddneg-supply:
+    description: phandle of the negative boost supply regulator
+
+  pinctrl-names:
+    description: Pinctrl for panel active and suspend
+
+  pinctrl-0:
+    description: Active pinctrls
+
+  pinctrl-1:
+    description: Suspend pinctrls
+
+  ports:
+    type: object
+    properties:
+      port@0:
+        type: object
+        description: DSI input port driven by master DSI
+        properties:
+          reg:
+            const: 0
+
+        required:
+          - reg
+
+required:
+  - compatible
+  - reg
+  - vddi0-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - pinctrl-names
+  - pinctrl-0
+  - pinctrl-1
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/gpio/gpio.h>
+    dsi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      panel@0 {
+        compatible = "tianma,nt36672a";
+        reg = <0>;
+        vddi0-supply = <&vreg_l14a_1p88>;
+        vddpos-supply = <&lab>;
+        vddneg-supply = <&ibb>;
+
+        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+        pinctrl-names = "panel_active", "panel_suspend";
+        pinctrl-0 = <&sde_dsi_active>;
+        pinctrl-1 = <&sde_dsi_suspend>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            tianma_nt36672a_in_0: endpoint {
+              remote-endpoint = <&dsi0_out>;
+            };
+          };
+        };
+      };
+    };
+
+...
-- 
2.27.0

