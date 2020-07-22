Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E28C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDED20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guVuNrx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGVF6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgGVF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:58:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6BCC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:58:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l6so414653plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTm4mWhvKAmIc2Rf3uwqpSL+kAsziisrGlZO4B+85K8=;
        b=guVuNrx2ZWLOp4fNmvGs/LfJYvYVXWStXsqNLTMHKJIZAV/XgbdQm12D7Ftqp67bIP
         Ojv6OaXH4wfdhdGo2uaSJEY2mNxzfWgXvQEAcVvr4IhBJPOmDeaimWxQySSEcfXnbIj+
         j5KgliOrjkHxKKf/CoiroWN75Usd09WLyc58/m7bi9CLgk2JLfz+ApA5VMV4FJued4Yu
         lV+FwRXcQlbdhzifR2pyGCPE4QLkdQPCHdqEJasdDsuKzV4DpaY34VeVUTACzED7VCIb
         oFXY+Ssx1ko+J3e/kasBhiR17y+QxrXn3ClI3vY8Wt2TJtpa2NjenDct7nnD+B9AWC3T
         so1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTm4mWhvKAmIc2Rf3uwqpSL+kAsziisrGlZO4B+85K8=;
        b=d2mDlYEUWh/lkOpM1VpV/hVx04upCm9NW8m3JQ7Z8g0TRAK6Rk1avjZxdZngKs8d7P
         irBEBvPPne9yGPjE+HY4xx+vfI6bH0gI6TPzPYfRurCz9AK/wKZhlxyg6FJe6mwedyHi
         80kXvAlhmcNPkY+D7mAGE6eFhSWeq2lSbZxE7IW0S3e53f+sJQ891G+bCDwd4kovxsPi
         aBEn/UkO26BOlkBSeyeWBaEsShkEP7RPl3yMuVqpzJOG4bp3a+i8KWdasxLkuaZqXr7g
         BqyW5DdcIZBNTWgGvXFUnecy57vX09SiZ1//zHLoMADUR4h89Gd22mvqSD1erks5AY+x
         buHg==
X-Gm-Message-State: AOAM532gOg/51gh97eKA2xZtB2cocDmpRq6LnCgF9sivKwbNB5gEUPhv
        JvdbP8Buvv0NBjU6xBUbKfiJPQ==
X-Google-Smtp-Source: ABdhPJxNgX46VHUtwjAEqfNC1oD0Z6BdM604ZtHA8C7mdc+55PewhMuFojFaYwfykV1A/TwKENDtHw==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr8547210pjb.148.1595397510192;
        Tue, 21 Jul 2020 22:58:30 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id e191sm22144010pfh.42.2020.07.21.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 22:58:29 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
Date:   Wed, 22 Jul 2020 11:28:15 +0530
Message-Id: <20200722055816.20768-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722055816.20768-1-sumit.semwal@linaro.org>
References: <20200722055816.20768-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nt36672a panel from Tianma is a FHD+ panel with a resolution of 1080x2246
and 6.18 inches size. It is found in some of the Poco F1 phones.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Change-Id: I401dfbfe23ff2d806c956002f45e349cb9688c16

---
v2: remove ports node, making port@0 directly under panel@0 node.
---
 .../display/panel/tianma,nt36672a.yaml        | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
new file mode 100644
index 000000000000..cb1799fbbd32
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
@@ -0,0 +1,104 @@
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
+  port@0:
+    type: object
+    description: DSI input port driven by master DSI
+    properties:
+      reg:
+        const: 0
+
+    required:
+      - reg
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
+  - port@0
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+        port@0 {
+          reg = <0>;
+          tianma_nt36672a_in_0: endpoint {
+            remote-endpoint = <&dsi0_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.27.0

