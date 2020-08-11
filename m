Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED73C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCE820578
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brmRzebW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgHKLk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgHKLkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:40:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B6C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:40:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so7459329pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02zVwfMx3c82dMESmN/3uMBsnfv+t0nf9lm5grlg/ao=;
        b=brmRzebWF+qxRm2xbkZxf1t508yAsFnpHm48CjrF+vPSTGi2fU4tEaqzodQ8YvHZwF
         kvj3w15iqwZqsIAiXsalZQYYruC1JappHCUXk/e9WJrI0noqBb6nEhi1hGNsthPZf/ZW
         ZcttNh9PCGRKkY8i6bhtxdAJQt3J2/Y4kot3s3V7yRliiOcXU8oaGMzHNUqKfjh/rB0P
         0ScHvjum8xzTQoTIywdCN/eIiRFCUHaCD8Jn+kgx87HXj+LxsVZ8MNg3+ZWhdeX4pK4I
         8SIWEbBSkfhXpGwkHVqlS8XzFGV46ql5t7ZZQA5OitY3xEQpLZZVUZlDorWq3xcj24hd
         HUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02zVwfMx3c82dMESmN/3uMBsnfv+t0nf9lm5grlg/ao=;
        b=riDQQqS7s6yVrCc9qqhRGvjZz43EkQrCttn3N8GShbBWT0jUJvL/Kb1rY5kI/0F1N+
         fzqr7bggA3gve4fpwd8b+6WLH38VR8tn2V6ey3sNz8XEw7iZw8LIR640pMRrjwn2MGzn
         71nsdBhZKb+nQw8h0nI1cLX88MArhE3MoijqINxbUY9fx9YKk7Fwyy8BC9zUB/S4GT5l
         7OvHkKKl0T6H6j1p5xmghq87Uw9bSCm9UYrjTtBOEyredZIxMW2G6FEnEt6T8iz9hmid
         Gp3hpNbS/65ATOPeXrjI4ZcMwJGcrldzfu875aE/zBj68E1Z2w052IbDuLtLVbtmoZqh
         HT1Q==
X-Gm-Message-State: AOAM531gbugZ7YPXRvkhhO8rgmAtfCqdWVcnOij0BHt9OlmQXr2IqYsS
        GFQfpyF43iah6bDTL6WeVMkfbg==
X-Google-Smtp-Source: ABdhPJxqJqQh0R5VflvErlmkXKGAOAf1Jse5lrPIX3ZXjS1vdMCSvE+VSC8IUZrotOU2sgTStg7GlQ==
X-Received: by 2002:a63:7704:: with SMTP id s4mr472831pgc.78.1597146025062;
        Tue, 11 Aug 2020 04:40:25 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id gj2sm2600448pjb.21.2020.08.11.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:40:24 -0700 (PDT)
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
Subject: [RESEND PATCH v3 1/2] dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
Date:   Tue, 11 Aug 2020 17:10:09 +0530
Message-Id: <20200811114010.17807-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811114010.17807-1-sumit.semwal@linaro.org>
References: <20200811114010.17807-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nt36672a panel from Tianma is a FHD+ panel with a resolution of
1080x2246 and 6.18 inches size. It is found in some of the Poco F1
phones.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: remove ports node, making port@0 directly under panel@0 node.
v3: updated to replace port@0 to just 'port'.
---
 .../display/panel/tianma,nt36672a.yaml        | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
new file mode 100644
index 000000000000..03dc323332a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
@@ -0,0 +1,95 @@
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
+  port: true
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
2.27.0

