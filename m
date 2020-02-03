Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30212086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bkVpn1QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgBCScT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:32:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46232 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgBCScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so7987679pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0nsR1/n7R57V+1PsrCuglEaiVKyW/xZ3QpC5sxUZYs=;
        b=bkVpn1QNjqmF1XXJ8WslWj9JFEk6QJGoU05C5f9t43nBos/ScgRtQy58GGdyKPkIo1
         5IBJdDMnWmhtwbxEVhBbPYli3A7LKGljXTI2lTtPJR7fEF1v0xuioJ/AbrbQn2MFsoF5
         QrZtR9Ou77L7/8vqClPF45HNodkHGs+6CmM/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0nsR1/n7R57V+1PsrCuglEaiVKyW/xZ3QpC5sxUZYs=;
        b=esjtKnAAEq1fribyhGYMOUaQYOZtveZOAE1EdAIZJH5tWLFQr15A5x5ouB8KkIvD1y
         J/Zdt7B7vcplFEMh24+92Ysb0SrmLiQ/E6rPOncnxEr2bx9M1JdlAJVlHe+lq2azxtGf
         /xtz9s0Wiq79/0Gf0iU3+7bdUl6uxM4/SRAnc9siJMNPs2snMs87e1sKTVrPpa8O0W9t
         cB9KfuaqCOcPrnSvJYFBsm0N9aV4RHf0nbMiASlh+xTURyzto911UrfwSRhgCe3UnWjz
         6M+uJNg1eCLKS5Rl4oY1dMwkkwUXS4sV+V+hcg7fnBowkcHFv002QXAjo7S4CkJU1Z9c
         FA9g==
X-Gm-Message-State: APjAAAXt5mS530hGRkZobCcSRhq5A5EBnHF6VI45Kls4NqKNbjb3eZMs
        hxIJdoXSsFWocvaveYn4kAm0MA==
X-Google-Smtp-Source: APXvYqzMkWPIQYbJufilUz8QnIOu03GyP6Uu2vVrFq4B9/8RRoQGLVf3dxY9AgxeXVW3IVE4+dSLrQ==
X-Received: by 2002:a63:502:: with SMTP id 2mr4061302pgf.364.1580754735571;
        Mon, 03 Feb 2020 10:32:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:15 -0800 (PST)
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
Subject: [PATCH v4 02/15] dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
Date:   Mon,  3 Feb 2020 10:31:35 -0800
Message-Id: <20200203103049.v4.2.I0c4bbb0f75a0880cd4bd90d8b267271e2375e0d0@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
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

Changes in v4:
- Added Rob's review tag.
- Fixed schema id to not have "bindings/" as per Rob.

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
index 000000000000..0429062f1585
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sc7180-dispcc.yaml#
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
index 000000000000..89269ddfbdcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sdm845-dispcc.yaml#
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

