Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9551E20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NbNW2kLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgA3VNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:13:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35207 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgA3VNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:13:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1829516plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fol0JJk4IblLpT4hiUDWb+r71DYlQYGNjU+sPWvrVtI=;
        b=NbNW2kLhoU4SqcB8NO5LF/J1dTq+k84S1Xp8/bVNLPdrYCRbW/z2dE1bCXWiDJCT+n
         e4ZDPQH601UTR7Z8wKk0aukfftdiMMVtl5MnOaEvYHxL0LUlBI2oHGBD78X0hf6FgEJ2
         +dWdI+cN6qTj7z3WF5T8+bF9+BN8T+hIlaNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fol0JJk4IblLpT4hiUDWb+r71DYlQYGNjU+sPWvrVtI=;
        b=bcPXoCgMoiVT6WHri9l4tuIsaQxoar8fDzxurkd86RHJG60Azr9NQrxg2997Gv+jbW
         0zL9G0k4cMFuef9nnWa7XrgSYVUDXaWt7iMPtIKyCUXpNufy2iKpE2uYW2QPoGpst12a
         SLk8PejWMQiZ21z0RNmLh48tGh771qlPyGGh7uSe1shmRPHO5AEXeU9tWuMg2VATIF0V
         iCXpPA8mNKFGS9goQRtuuZcQg/tMiIQPmt3RsV70a+W5aEl9FfjYh+ZwFhpRkoBfyj5r
         Z3GkR8WFvf/ccjiqRELUqe45ATqrH4B/zMwuA+7RfdhTk50KkjexQ9iwAVUP5Xy36H5M
         s7YA==
X-Gm-Message-State: APjAAAW6NRJk9vsBaw5A+Fvds6JLjQ1EArpYhxUF27o9pFPDdZPDJYM/
        3DCfh54PsmY/47w+/92Ux+Gy8Q==
X-Google-Smtp-Source: APXvYqy2P3oKHw/5gmuRoNPGnGaALGU6i55k3M8QnYtzLdPZgM3doZOHhvvWoincZ28UWeE0iBIc7w==
X-Received: by 2002:a17:90a:a60c:: with SMTP id c12mr8400886pjq.28.1580418781917;
        Thu, 30 Jan 2020 13:13:01 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id ci5sm4343871pjb.5.2020.01.30.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:13:01 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 11/15] dt-bindings: clock: Cleanup qcom,videocc bindings for sdm845/sc7180
Date:   Thu, 30 Jan 2020 13:12:27 -0800
Message-Id: <20200130131220.v3.11.I27bbd90045f38cd3218c259526409d52a48efb35@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130211231.224656-1-dianders@chromium.org>
References: <20200130211231.224656-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the qcom,videocc bindings match the recent changes to the
dispcc and gpucc.

1. Switched to using "bi_tcxo" instead of "xo".

2. Adds a description for the XO clock.  Not terribly important but
   nice if it cleanly matches its cousins.

3. Updates the example to use the symbolic name for the RPMH clock and
   also show that the real devices are currently using 2 address cells
   / size cells and fixes the spacing on the closing brace.

4. Split into 2 files.  In this case they could probably share one
   file, but let's be consistent.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Added include file to description.
- Split videocc bindings into 2 files.
- Unlike in v2, use internal name instead of purist name.

Changes in v2:
- Patch ("dt-bindings: clock: Cleanup qcom,videocc") new for v2.

 .../bindings/clock/qcom,sc7180-videocc.yaml   | 63 +++++++++++++++++++
 ...,videocc.yaml => qcom,sdm845-videocc.yaml} | 27 ++++----
 2 files changed, 77 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,videocc.yaml => qcom,sdm845-videocc.yaml} (60%)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
new file mode 100644
index 000000000000..f12ec56737e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,sc7180-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller Binding for SC7180
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm video clock control module which supports the clocks, resets and
+  power domains on SC7180.
+
+  See also dt-bindings/clock/qcom,videocc-sc7180.h.
+
+properties:
+  compatible:
+    const: qcom,sc7180-videocc
+
+  clocks:
+    items:
+      - description: Board XO source
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@ab00000 {
+      compatible = "qcom,sc7180-videocc";
+      reg = <0 0x0ab00000 0 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      clock-names = "bi_tcxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
similarity index 60%
rename from Documentation/devicetree/bindings/clock/qcom,videocc.yaml
rename to Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
index 43cfc893a8d1..60300f5ab307 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-videocc.yaml
@@ -1,30 +1,31 @@
 # SPDX-License-Identifier: GPL-2.0-only
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/clock/qcom,videocc.yaml#
+$id: http://devicetree.org/schemas/bindings/clock/qcom,sdm845-videocc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Video Clock & Reset Controller Binding
+title: Qualcomm Video Clock & Reset Controller Binding for SDM845
 
 maintainers:
   - Taniya Das <tdas@codeaurora.org>
 
 description: |
   Qualcomm video clock control module which supports the clocks, resets and
-  power domains.
+  power domains on SDM845.
+
+  See also dt-bindings/clock/qcom,videocc-sdm845.h.
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7180-videocc
-      - qcom,sdm845-videocc
+    const: qcom,sdm845-videocc
 
   clocks:
-    maxItems: 1
+    items:
+      - description: Board XO source
 
   clock-names:
     items:
-      - const: xo
+      - const: bi_tcxo
 
   '#clock-cells':
     const: 1
@@ -48,15 +49,15 @@ required:
   - '#power-domain-cells'
 
 examples:
-  # Example of VIDEOCC with clock node properties for SDM845:
   - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@ab00000 {
       compatible = "qcom,sdm845-videocc";
-      reg = <0xab00000 0x10000>;
-      clocks = <&rpmhcc 0>;
-      clock-names = "xo";
+      reg = <0 0x0ab00000 0 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      clock-names = "bi_tcxo";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-     };
+    };
 ...
-- 
2.25.0.341.g760bfbb309-goog

