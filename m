Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B20C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207A2214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvlLQg25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgA3VMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:12:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42016 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgA3VMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:12:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1814853plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLRLFIcc4LIDPB9YigEhydFs/8ZzkV4XRdQLFB2ep6Q=;
        b=mvlLQg25kRWGKBllUT9LNWpMct+Ba9NKWhZdoJX9+F9VAred9+dS/mDDCVnUjMykB6
         JGnUnzTVq3MReXN52FJHvEOjso6Eo4DYGGCKemrWLVfzm13MY7EJwthSidsm5ZTA2WNN
         CbsWG08fig8R1vdNkLtPz/Qr8aV/mkk5CBygY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLRLFIcc4LIDPB9YigEhydFs/8ZzkV4XRdQLFB2ep6Q=;
        b=rYX/Kq6p682rb7HccPWEfXza2GQND6U2qyGK5vcHeP6TaOTE+dsYKhH0B7/uENNdlB
         5RvN/3h+zpG8GvFjCN5S+JqkK5iAdbGbS1P8DwMxAgHtk18uBxeAVYo8qjRN2/eeyFcN
         DCN28gCq/iizCGzfSG2SB1cF4zNDJQjH5JGIKgwR6klD8LtksNQotAXIj0KsPAQpt6AK
         OaXEucShgq1uq04686i+4q6X3vr0iyo6aBRV3esWJnmJhFoRRlfFt3RmxYFqHCGlyNqT
         FY+5moLRi+VLqbZktTLLIJNd0Dsz4Cx2JX4yD26k5ORdaMEapXHNvKj6G6W++FI3tJtV
         IwXQ==
X-Gm-Message-State: APjAAAWE92NiHV2+ZMn49AbjT/aWEr6DOzQJk8PFT8OyEf31kfT2WzSR
        B5FVNew6+Iu7xrbcSXqA+oebVA==
X-Google-Smtp-Source: APXvYqynqQ+EaQq3PdE2MU+3FgfT6u0H42mDI9WEvEDzLZl9MDS9Vjmi62wBJhNJvvoukgiX+YZr8A==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr7870236pjv.140.1580418770963;
        Thu, 30 Jan 2020 13:12:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id ci5sm4343871pjb.5.2020.01.30.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:12:50 -0800 (PST)
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
Subject: [PATCH v3 02/15] dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
Date:   Thu, 30 Jan 2020 13:12:18 -0800
Message-Id: <20200130131220.v3.2.I0c4bbb0f75a0880cd4bd90d8b267271e2375e0d0@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130211231.224656-1-dianders@chromium.org>
References: <20200130211231.224656-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,dispcc bindings had a few problems with them:

1. They didn't specify all the clocks that dispcc is a client of.
   Specifically on sc7180 there are two clocks from the DSI PHY and
   two from the DP PHY.  On sdm845 there are actually two DSI PHYs
   (each of which has two clocks) and an extra clock from the gcc.
   These all need to be specified.

2. The sdm845.dtsi has existed for quite some time without specifying
   the clocks.  The Linux driver was relying on global names to match
   things up.  While we should transition things, it should be noted
   in the bindings.

3. The names used the bindings for "xo" and "gpll0" didn't match the
   names that QC used for these clocks internally and this was causing
   confusion / difficulty with their code generation tools.  Switched
   to the internal names to simplify everyone's lives.  It's not quite
   as clean in a purist sense but it should avoid headaches.  This
   officially changes the binding, but that seems OK in this case.

Also note that I updated the example.

Fixes: 5d28e44ba630 ("dt-bindings: clock: Add YAML schemas for the QCOM DISPCC clock bindings")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Added include file to description.
- Discovered / added new gcc input clock on sdm845.
- Split sc7180 and sdm845 into two files.
- Switched names to internal QC names rather than logical ones.
- Updated commit description.

Changes in v2:
- Patch ("dt-bindings: clock: Fix qcom,dispcc...") new for v2.

 .../bindings/clock/qcom,dispcc.yaml           | 67 -------------
 .../bindings/clock/qcom,sc7180-dispcc.yaml    | 84 ++++++++++++++++
 .../bindings/clock/qcom,sdm845-dispcc.yaml    | 99 +++++++++++++++++++
 3 files changed, 183 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
deleted file mode 100644
index 9c58e02a1de1..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
+++ /dev/null
@@ -1,67 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/bindings/clock/qcom,dispcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Display Clock & Reset Controller Binding
-
-maintainers:
-  - Taniya Das <tdas@codeaurora.org>
-
-description: |
-  Qualcomm display clock control module which supports the clocks, resets and
-  power domains.
-
-properties:
-  compatible:
-    enum:
-      - qcom,sc7180-dispcc
-      - qcom,sdm845-dispcc
-
-  clocks:
-    minItems: 1
-    maxItems: 2
-    items:
-      - description: Board XO source
-      - description: GPLL0 source from GCC
-
-  clock-names:
-    items:
-      - const: xo
-      - const: gpll0
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
-
-examples:
-  # Example of DISPCC with clock node properties for SDM845:
-  - |
-    clock-controller@af00000 {
-      compatible = "qcom,sdm845-dispcc";
-      reg = <0xaf00000 0x10000>;
-      clocks = <&rpmhcc 0>, <&gcc 24>;
-      clock-names = "xo", "gpll0";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-     };
-...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
new file mode 100644
index 000000000000..35315011fc37
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,sc7180-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding for SC7180
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains on SC7180.
+
+  See also dt-bindings/clock/qcom,dispcc-sc7180.h.
+
+properties:
+  compatible:
+    const: qcom,sc7180-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+      - description: Byte clock from DSI PHY
+      - description: Pixel clock from DSI PHY
+      - description: Link clock from DP PHY
+      - description: VCO DIV clock from DP PHY
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: gcc_disp_gpll0_clk_src
+      - const: dsi0_phy_pll_out_byteclk
+      - const: dsi0_phy_pll_out_dsiclk
+      - const: dp_phy_pll_link_clk
+      - const: dp_phy_pll_vco_div_clk
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
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sc7180-dispcc";
+      reg = <0 0x0af00000 0 0x200000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&dsi_phy 0>,
+               <&dsi_phy 1>,
+               <&dp_phy 0>,
+               <&dp_phy 1>;
+      clock-names = "bi_tcxo",
+                    "gcc_disp_gpll0_clk_src",
+                    "dsi0_phy_pll_out_byteclk",
+                    "dsi0_phy_pll_out_dsiclk",
+                    "dp_phy_pll_link_clk",
+                    "dp_phy_pll_vco_div_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
new file mode 100644
index 000000000000..aed2387dc4a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,sdm845-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding for SDM845
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains on SDM845.
+
+  See also dt-bindings/clock/qcom,dispcc-sdm845.h.
+
+properties:
+  compatible:
+    const: qcom,sdm845-dispcc
+
+  # NOTE: sdm845.dtsi existed for quite some time and specified no clocks.
+  # The code had to use hardcoded mechanisms to find the input clocks.
+  # New dts files should have these clocks.
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+      - description: GPLL0 div source from GCC
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: Byte clock from DSI PHY1
+      - description: Pixel clock from DSI PHY1
+      - description: Link clock from DP PHY
+      - description: VCO DIV clock from DP PHY
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: gcc_disp_gpll0_clk_src
+      - const: gcc_disp_gpll0_div_clk_src
+      - const: dsi0_phy_pll_out_byteclk
+      - const: dsi0_phy_pll_out_dsiclk
+      - const: dsi1_phy_pll_out_byteclk
+      - const: dsi1_phy_pll_out_dsiclk
+      - const: dp_link_clk_divsel_ten
+      - const: dp_vco_divided_clk_src_mux
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
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sdm845-dispcc";
+      reg = <0 0x0af00000 0 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&dsi1_phy 0>,
+               <&dsi1_phy 1>,
+               <&dp_phy 0>,
+               <&dp_phy 1>;
+      clock-names = "bi_tcxo",
+                    "gcc_disp_gpll0_clk_src",
+                    "gcc_disp_gpll0_div_clk_src",
+                    "dsi0_phy_pll_out_byteclk",
+                    "dsi0_phy_pll_out_dsiclk",
+                    "dsi1_phy_pll_out_byteclk",
+                    "dsi1_phy_pll_out_dsiclk",
+                    "dp_link_clk_divsel_ten",
+                    "dp_vco_divided_clk_src_mux";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
-- 
2.25.0.341.g760bfbb309-goog

