Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF692075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7y2Uh5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHZQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgHZQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:03:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81550C061786
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:03:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so1070911pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOJ2wsgRzvVRKckZeydkoWsG77ZYsewrKloG8nTk710=;
        b=u7y2Uh5YZGN9nMLWxRDS6HRYwt2+2SPr2lWkM/5QvASQ4iAGJGcyoH52Lk9ebk3I+y
         bdVfivs0fxD5OXqsIM6hrs3bJI7GwUZYkIhIjYiMyEuoeY4U05vxbNTksNII0z5OTYuY
         tf2e9jPijn6R05nDnaYRtFNpfbiR/AWVfHhuzWC3uIwrmAh9IbCQd8Uob3kzQXPPrwlS
         gRKbt1MxjyUapwHaVxWAFjs1jgyPR6fNXwKcZXOk2UmRu3giyuL0pYlRJX/ZAmlOoaQp
         LgfjX8V83K66sgRxj8e/y24yYopZI7D874u7TmcD34ygtW34au7bsh3NEbTWUMWMFg1g
         csUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOJ2wsgRzvVRKckZeydkoWsG77ZYsewrKloG8nTk710=;
        b=EY6KYxynRjvIIqLu1ltU/vEdO0I0+Xz5n2xUj4wBjZn7HzUbiiMVLbqPq/XvM6Acsg
         2ip2LoJO3UgqFLer4cJ2EiWw4cg1oXautKS3HWX1vLBIoWe+axUMk0mm0N4Q+BUYv7Jr
         vSW4zcP/YfLEOpoBBuFalRSF9/XiABnXXz4JzewvPC91KK+JnMwf4YRIYYAgqim3LqON
         QIlogbeh8B4qiSF8CmOyjBnXbXISf+7oboX6oMV0tLI0BYcilTQm+y+nUq62mqFB2HyM
         8J1vEr8Lno+cyJH9h83N4QyPb5uZ99DjKb0CRXQTO0hti2hRSy7R1xHx2EJMAP6MJoA3
         jwzw==
X-Gm-Message-State: AOAM531KTxNWbb+PO+uaLMi8bIpFHP+pFaiLzvhSQvBM5H/d2btcuvld
        0cJ8ImnQVOAMhNDAWeO4CfJLpA==
X-Google-Smtp-Source: ABdhPJx3zgfkCLWuhwB9Ncl+xylskuKGkxZ5BPvawfalxKyVUr95qHmDSMim1JB1vRjdaVphcFzgBw==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr12271225plr.224.1598457804850;
        Wed, 26 Aug 2020 09:03:24 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id u3sm2487555pjn.29.2020.08.26.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:03:23 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add bindings for Novatek nt36672a
Date:   Wed, 26 Aug 2020 21:33:07 +0530
Message-Id: <20200826160308.18911-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826160308.18911-1-sumit.semwal@linaro.org>
References: <20200826160308.18911-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek nt36672a is a display driver IC that can drive DSI panel. It
is also present in the Tianma video mode panel, which is a FHD+ panel
with a resolution of 1080x2246 and 6.18 inches size. It is found in
some of the Poco F1 phones.

This patch adds the display driver for the IC, with support added for
this tianma fhd video mode panel.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---
v2: remove ports node, making port@0 directly under panel@0 node.
v3: updated to replace port@0 to just 'port'.
v5: renamed to novatek,nt36672a, since the binding is for the IC and not
      the panel.
---
 .../display/panel/novatek,nt36672a.yaml       | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
new file mode 100644
index 000000000000..7f8d1097bee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36672a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36672A based DSI display Panels
+
+maintainers:
+  - Sumit Semwal <sumit.semwal@linaro.org>
+
+description: |
+  The nt36672a IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels.
+  Right now, support is added only for a Tianma FHD+ LCD display panel with a
+  resolution of 1080x2246. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: tianma,fhd-video
+      - const: novatek,nt36672a
+    description: This indicates the panel manufacturer of the panel that is
+      in turn using the NT36672A panel driver. This compatible string
+      determines how the NT36672A panel driver is configured for the indicated
+      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
+
+  reg: true
+  reset-gpios:
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active high)
+  vddio-supply:
+    description: phandle of the regulator that provides the supply voltage
+      Power IC supply
+  vddpos-supply:
+    description: phandle of the positive boost supply regulator
+  vddneg-supply:
+    description: phandle of the negative boost supply regulator
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vddi0-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - port
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
+        compatible = "tianma,fhd-video", "novatek,nt36672a";
+        reg = <0>;
+        vddi0-supply = <&vreg_l14a_1p88>;
+        vddpos-supply = <&lab>;
+        vddneg-supply = <&ibb>;
+
+        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        port {
+          tianma_nt36672a_in_0: endpoint {
+            remote-endpoint = <&dsi0_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.28.0

