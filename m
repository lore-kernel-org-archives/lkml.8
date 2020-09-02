Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3ADC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDF32083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="NJMEZWQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgIBSkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:40:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E33C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:40:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f2so696307qkh.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3FtOjfWRuXBO4qF0opoE+PxiWYcIk55Pn3cV1ZJjqs=;
        b=NJMEZWQE8qbfuoSybzpoijdnqQ3tCiACVj28O0B08Hbw3devVYB77DHtQQzQ4SqKx8
         ybVqLxxYN9jgESG2P0v1y2SeWlR8AJFj55ZYa42Ez8sXpvJ4omnGLE0zIihUV2zxl3dB
         4kFy+TAiHwkduB7bxzcx43Okg0qgMdQzrLFRhMDe7QByb8SyF222h1C93MLpZY0fuYWC
         PlJi+QhPHEnBNs/X6LIhhvqgKY/05V1IcNyaWt39zqZ8X3wt+FuJTgjQHN84EnN9iZxL
         7RLkPmMBA7B59OcyjFKIoKX79i0TzCLGw/J0JhM79m7oCtNENIAleM0h60oRJ88/TpQZ
         B6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3FtOjfWRuXBO4qF0opoE+PxiWYcIk55Pn3cV1ZJjqs=;
        b=VEa+zHy3JoQBq6b6Ya52cFRWxY3aHCQGtD0jleNSRl5zSnQSF67R59DaW/4pZVJ+U2
         ANGohDfUWZkjXmWiou2yRSIJsCueQbKjL9ANT3hnKeBdrfBtjNySbg4IEpULy4ve5p5S
         XH7Q2gwMG2yxvVAGFoN3isJGy6ZEQwV1IVc5JA2z3G6tOJ/B+Cw9io1bHRj6bACf1wfV
         Auvbl/mT82STtaDvpkhv+sOXvf+LLQC70Q8MagL/21V/ATvejmudKONRCmscIWyBKbSA
         z/FjmvsG1tGKNk32i4F8amozreMRk/n49WHt3TAoO9Zb4eTLdjPpK8NqSXwYEC7dhnoq
         56Hg==
X-Gm-Message-State: AOAM533z1/MpgiOtzaYJ+goV7XRPqc7u+oQkwf/j6e13CA7OP22qsEYt
        P03zVfIRMCnpBvzvTdGG1N/4oQ==
X-Google-Smtp-Source: ABdhPJzJ8y+nWNziNtBaaq5oM00QrWcc1NecbpfuiXNFN+FHGq2n4bKYAAQzAh/PXgacFidUXsoe1g==
X-Received: by 2002:a05:620a:795:: with SMTP id 21mr7779190qka.131.1599072004166;
        Wed, 02 Sep 2020 11:40:04 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id s47sm208004qtb.13.2020.09.02.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:40:03 -0700 (PDT)
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
Subject: [PATCH 3/7] dt-bindings: clock: combine qcom,sdm845-dispcc and qcom,sc7180-dispcc
Date:   Wed,  2 Sep 2020 14:38:43 -0400
Message-Id: <20200902183852.14510-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200902183852.14510-1-jonathan@marek.ca>
References: <20200902183852.14510-1-jonathan@marek.ca>
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
 2 files changed, 11 insertions(+), 93 deletions(-)
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-dispcc.yaml => qcom,dispcc.yaml} (85%)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
similarity index 85%
rename from Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
rename to Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
index 3825dd6e67e3..7c1c81cdc681 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
@@ -1,23 +1,27 @@
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
@@ -25,8 +29,8 @@ properties:
   clocks:
     items:
       - description: Board XO source
-      - description: GPLL0 source from GCC
-      - description: GPLL0 div source from GCC
+      - description: GPLL0 source from GCC (sdm845 only)
+      - description: GPLL0 div source from GCC (sdm845 only)
       - description: Byte clock from DSI PHY0
       - description: Pixel clock from DSI PHY0
       - description: Byte clock from DSI PHY1
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

