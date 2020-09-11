Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117ECC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A513720770
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="fZQzry+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIKPjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgIKPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:36:26 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009CC0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so5380573qvk.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsPjwepdx0CsX0W2iH+opkwycH1cAd/VmPHfgsssETA=;
        b=fZQzry+hCtrnoa+52FXNS3blkRMCk5HvwNVjsX3f/YDaXBo3WJRUgWkihBcCkda3wH
         OXPShaOb4WnuCWIQ8qFvXjvVFhQQz9/vvY8qpbi0RXe4GkSD4B73jvdAzqD0hnIBdMWL
         lywVkKHzT4FOk0xj10Apx9Dyz0Hr5CZZnj333WeQ9vZ0T+aKPfBertLrH8DZFBUtgaA+
         vtItGqRIdlQekcoRrQCwSAF/SxNKAG/HqjdSOWj9QzL3+O5OcG8chcnZCTuh91xDQF0J
         ipXqS97rYcHf3Iy648uyNueio62Oi3wthzFM7lQGFdxsrSWiZaA3OTDoIwDlWeHTIsBD
         DBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsPjwepdx0CsX0W2iH+opkwycH1cAd/VmPHfgsssETA=;
        b=Zfu4TZCSwgVGazeZj0Vgjtv0Bmg0swkkmTN/G+TPo48X5M9YffUe40YtLgtEG2g7if
         kiTHYs59o8sqjiwQVhWeYRXCg4T7qElOTuJzGUI9RXmFd6NN9lABxemEVaJUdoJoSImm
         qN8Bge2snQAAswfFThHp7wH8met+ChLe6aii7NoSdwDByp6yc//D9fw3rVXTL7nFAfwi
         rsbjOp6j8sG+iWI5qe9UIkmJ1xHVkxFR0LNZV/FXWhoz7QojIu6uGAy/gjrpq+iMitYl
         ZiHcv+xRHzRrum/CRUConk36qcO9YhQ+xv21ziq4CHk25C7eF6hxE86d7CSMTTa4Ohw+
         L1qA==
X-Gm-Message-State: AOAM533SSt45/HKObppxFylX/dXDea3D+EfvaESJ0/O1IUbcXyS9tkOw
        dGnXtjmhkpCHYU4Nk3dGvFvWeA==
X-Google-Smtp-Source: ABdhPJxVT7wmShH+qDM7q22ttEuV1aHWCNGhiqx81r3AmbzL0gVcrtkCOUv9oTQDmYAvbHTs/shsIA==
X-Received: by 2002:a0c:e354:: with SMTP id a20mr2464989qvm.43.1599838536879;
        Fri, 11 Sep 2020 08:35:36 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id v16sm3001744qkg.37.2020.09.11.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:35:36 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/7] dt-bindings: clock: combine qcom,sdm845-dispcc and qcom,sc7180-dispcc
Date:   Fri, 11 Sep 2020 11:34:03 -0400
Message-Id: <20200911153412.21672-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200911153412.21672-1-jonathan@marek.ca>
References: <20200911153412.21672-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two bindings are almost identical, so combine them into one. This
will make it easier to add the sm8150 and sm8250 dispcc bindings.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 ...om,sdm845-dispcc.yaml => qcom,dispcc.yaml} | 18 ++--
 .../bindings/clock/qcom,sc7180-dispcc.yaml    | 86 -------------------
 2 files changed, 12 insertions(+), 92 deletions(-)
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-dispcc.yaml => qcom,dispcc.yaml} (86%)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
similarity index 86%
rename from Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
rename to Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
index ead44705333b..7d5b25dfe0b1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
@@ -1,32 +1,37 @@
 # SPDX-License-Identifier: GPL-2.0-only
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/clock/qcom,sdm845-dispcc.yaml#
+$id: http://devicetree.org/schemas/clock/qcom,dispcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Display Clock & Reset Controller Binding for SDM845
+title: Qualcomm Display Clock & Reset Controller Binding
 
 maintainers:
   - Taniya Das <tdas@codeaurora.org>
 
 description: |
   Qualcomm display clock control module which supports the clocks, resets and
-  power domains on SDM845.
+  power domains on SDM845/SC7180.
 
-  See also dt-bindings/clock/qcom,dispcc-sdm845.h.
+  See also:
+    dt-bindings/clock/qcom,dispcc-sdm845.h
+    dt-bindings/clock/qcom,dispcc-sc7180.h
 
 properties:
   compatible:
-    const: qcom,sdm845-dispcc
+    enum:
+      - qcom,sdm845-dispcc
+      - qcom,sc7180-dispcc
 
   # NOTE: sdm845.dtsi existed for quite some time and specified no clocks.
   # The code had to use hardcoded mechanisms to find the input clocks.
   # New dts files should have these clocks.
   clocks:
+    minItems: 8
     items:
       - description: Board XO source
       - description: GPLL0 source from GCC
-      - description: GPLL0 div source from GCC
+      - description: GPLL0 div source from GCC (sdm845 only)
       - description: Byte clock from DSI PHY0
       - description: Pixel clock from DSI PHY0
       - description: Byte clock from DSI PHY1
@@ -35,6 +40,7 @@ properties:
       - description: VCO DIV clock from DP PHY
 
   clock-names:
+    minItems: 8
     items:
       - const: bi_tcxo
       - const: gcc_disp_gpll0_clk_src
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
deleted file mode 100644
index e94847f92770..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
+++ /dev/null
@@ -1,86 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/qcom,sc7180-dispcc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm Display Clock & Reset Controller Binding for SC7180
-
-maintainers:
-  - Taniya Das <tdas@codeaurora.org>
-
-description: |
-  Qualcomm display clock control module which supports the clocks, resets and
-  power domains on SC7180.
-
-  See also dt-bindings/clock/qcom,dispcc-sc7180.h.
-
-properties:
-  compatible:
-    const: qcom,sc7180-dispcc
-
-  clocks:
-    items:
-      - description: Board XO source
-      - description: GPLL0 source from GCC
-      - description: Byte clock from DSI PHY
-      - description: Pixel clock from DSI PHY
-      - description: Link clock from DP PHY
-      - description: VCO DIV clock from DP PHY
-
-  clock-names:
-    items:
-      - const: bi_tcxo
-      - const: gcc_disp_gpll0_clk_src
-      - const: dsi0_phy_pll_out_byteclk
-      - const: dsi0_phy_pll_out_dsiclk
-      - const: dp_phy_pll_link_clk
-      - const: dp_phy_pll_vco_div_clk
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
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
-    #include <dt-bindings/clock/qcom,rpmh.h>
-    clock-controller@af00000 {
-      compatible = "qcom,sc7180-dispcc";
-      reg = <0x0af00000 0x200000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
-               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
-               <&dsi_phy 0>,
-               <&dsi_phy 1>,
-               <&dp_phy 0>,
-               <&dp_phy 1>;
-      clock-names = "bi_tcxo",
-                    "gcc_disp_gpll0_clk_src",
-                    "dsi0_phy_pll_out_byteclk",
-                    "dsi0_phy_pll_out_dsiclk",
-                    "dp_phy_pll_link_clk",
-                    "dp_phy_pll_vco_div_clk";
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
-...
-- 
2.26.1

