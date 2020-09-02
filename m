Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5AD20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbxSowKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBGoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgIBGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:44:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AEC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 23:44:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1893403pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKVQa7mFyShxE7bXpbdQpBbN4ieHP/7X9mNZXJlFeWE=;
        b=VbxSowKnbuXn0pQhBT1Y5EFmaJmyFwdlHnKCpLHH+X/6hgc0H7kAoQdQFPm9ULcAY4
         76f4E8AVEzmUxHXqr1D+pRDYDzYtiF6El2nppqCBtlcli6Iv6FQkxV49Zsqn+3E6zeLs
         5HYbeNbH+B3wt1mvNZEsU9RE2qmvvbcLEfUmj81HSiROe7gqrSpnN+dfrXD6tfCVqw2P
         LatCFjshi2BJ06h/atlv+F3vVjljZB0cCCO4OrimAnH0QKgpg88EE393jU/bm7Cv/uP6
         SMzp8ugfPM8mTQXVyj1JJd7LwZaOEEdr4+GYI0Y9uDCQH4nw0abiZM2OO1zJOePm/t5z
         9hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKVQa7mFyShxE7bXpbdQpBbN4ieHP/7X9mNZXJlFeWE=;
        b=ocsHgK7MLyoUbhv1SIvNgwLQZwOIrMY92USecRpNSPakmfuyD1JWei7GUOXZzqaBK3
         TXbtRViIepUlxq7E0H6jyeAzQCUzv2I5LvZ+LVHMFIEE9/yjdtGjlorBfTqgx9xD/lNO
         s8T1P3jQ8tRnugnqlLRulziB8spFzqN4w+lg88QQqEBGgCPssf/7Qc8e0K6LHDdTwBas
         c60yPJlxAKrLgN/3lZ+DEnoW3bSi3IQYkssGmABU60CTZKtqUH5/FoB+krbbtPVPcFEy
         z6k6PmjrhcUjrXxKxEhjwMZauNLH53Ww2Nj2d5yZY4kqpmiC6KGdzhyque8kdZr0VFxl
         CNhw==
X-Gm-Message-State: AOAM531Zi64SvVxY6Y75ZHWS8HRg/uYhC7s8uCn4xamt3dAtAHwwhjkp
        YtE9QdgZMhYXlL+NP/f1TYomwQ==
X-Google-Smtp-Source: ABdhPJyIUwDkLbR90M2f4Qg0VUzGtIQWD0a8g/0r2lBFebTTC9iEvE9yJOTSSB9Yr3y+BjdpqPx5dQ==
X-Received: by 2002:a17:90a:d106:: with SMTP id l6mr948438pju.169.1599029060327;
        Tue, 01 Sep 2020 23:44:20 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id i23sm4317434pfo.207.2020.09.01.23.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:44:19 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: display: panel: Add bindings for Novatek nt36672a
Date:   Wed,  2 Sep 2020 12:14:06 +0530
Message-Id: <20200902064407.30712-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902064407.30712-1-sumit.semwal@linaro.org>
References: <20200902064407.30712-1-sumit.semwal@linaro.org>
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
v6: v5 review comments incorporated.
    - added enum for the compatible part, since it can be extended in
      future.
    - few cosmetic updates.
---
 .../display/panel/novatek,nt36672a.yaml       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
new file mode 100644
index 000000000000..d2170de6b723
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -0,0 +1,87 @@
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
+      - enum:
+         - tianma,fhd-video
+      - const: novatek,nt36672a
+    description: This indicates the panel manufacturer of the panel that is
+      in turn using the NT36672A panel driver. This compatible string
+      determines how the NT36672A panel driver is configured for the indicated
+      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
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
+  reg: true
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
+
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "tianma,fhd-video", "novatek,nt36672a";
+            reg = <0>;
+            vddi0-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lab>;
+            vddneg-supply = <&ibb>;
+
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port {
+                tianma_nt36672a_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.28.0

