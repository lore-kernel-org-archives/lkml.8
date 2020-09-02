Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7209520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VHrtybD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIBXCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgIBXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:02:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D948AC061247
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:02:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so514775pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gbp5El4soX0C+z5m/RfNuwNwoyYLjPi9BYBBMtXuagI=;
        b=VHrtybD/4A+hThtZJJM/UIQBWBqgk3/Kq2K/593d1Pt86pNw5OYN+Ttakg1m0TmRld
         ZN76GvHAIUBIGEiKhgRnnxuUO2g9lhiRiOaB2wLXGxEO1WAIsqTv8CasswoYn4RuQhHN
         Tu5YFQZ7CjusKZDXn7DaYh4MrjDKPFtP1j3zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gbp5El4soX0C+z5m/RfNuwNwoyYLjPi9BYBBMtXuagI=;
        b=Jnh0f9vQLuUg8dzLRXp93qfROaOxkEl3Vn9gJ9k8jVTX5XurHtQofQKkh+vXFQBhGS
         AZOQ8M1rd6pyXj0fhZKDxnS93cXpIWT7e1baN99fToy8sAejgjlBq1QJbe5Q9rGtpPLt
         Ozh6Z6y9bWtDQAtyZrcibp0L/fRBDLVlnPgxRE2UBK1Bp9hIfBzkblxujCCi3aP/e9qS
         LrtFh/R/t9K4l5e+0aEEk9DeHTrKKJeE2bGgr12rIvqXTVVx45gJ6j9Py6Yz74MF1L0V
         6JQIzFK1y0tftQ6WYZfAPLdH72xnNH0uEAW7qcHjCzeYXZL/QsObyLnPC6z79MtEOD2m
         yo9w==
X-Gm-Message-State: AOAM530nJWuD9ZXFnduokEWCIdPsnmmD0LIqdNJAxdIBMY1dWT5nhrPx
        fLwus2XIpWeX9IbixJqsa6KWiQ==
X-Google-Smtp-Source: ABdhPJzIGBjJr716uSgGwRW5r6DiwwvYEBE9tldApiGh+jcAT9uGnxkArdr3pX4uCQ8bWMRwFHzKNA==
X-Received: by 2002:a17:90b:408b:: with SMTP id jb11mr57676pjb.164.1599087739364;
        Wed, 02 Sep 2020 16:02:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x12sm410277pjq.43.2020.09.02.16.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:02:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v2 01/10] dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information
Date:   Wed,  2 Sep 2020 16:02:06 -0700
Message-Id: <20200902230215.3452712-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200902230215.3452712-1-swboyd@chromium.org>
References: <20200902230215.3452712-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding only describes the USB phy inside the USB3 + DP "combo"
phy. Add information for the DP phy and describe the sub-nodes that
represent the DP and USB3 phys that exist inside the combo wrapper.
Remove reg-names from required properties because it isn't required nor
used by the kernel driver.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    | 91 +++++++++++++++++--
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index ef8ae9f73092..4154f5748d39 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -17,13 +17,15 @@ properties:
       - qcom,sdm845-qmp-usb3-phy
   reg:
     items:
-      - description: Address and length of PHY's common serdes block.
+      - description: Address and length of PHY's USB serdes block.
       - description: Address and length of the DP_COM control block.
+      - description: Address and length of PHY's DP serdes block.
 
   reg-names:
     items:
-      - const: reg-base
+      - const: usb
       - const: dp_com
+      - const: dp
 
   "#clock-cells":
     enum: [ 1, 2 ]
@@ -74,16 +76,74 @@ properties:
 
 #Required nodes:
 patternProperties:
-  "^phy@[0-9a-f]+$":
+  "^usb3-phy@[0-9a-f]+$":
     type: object
     description:
-      Each device node of QMP phy is required to have as many child nodes as
-      the number of lanes the PHY has.
+      The USB3 PHY.
+
+    properties:
+      reg:
+        items:
+          - description: Address and length of TX.
+          - description: Address and length of RX.
+          - description: Address and length of PCS.
+          - description: Address and length of TX2.
+          - description: Address and length of RX2.
+          - description: Address and length of pcs_misc.
+
+      clocks:
+        items:
+          - description: pipe clock
+
+      clock-names:
+        items:
+          - const: pipe0
+
+      clock-output-names:
+        items:
+          - const: usb3_phy_pipe_clk_src
+
+      '#clock-cells':
+        const: 0
+
+      '#phy-cells':
+        const: 0
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+      - '#clock-cells'
+      - '#phy-cells'
+
+  "^dp-phy@[0-9a-f]+$":
+    type: object
+    description:
+      The DP PHY.
+
+    properties:
+      reg:
+        items:
+          - description: Address and length of TX.
+          - description: Address and length of RX.
+          - description: Address and length of PCS.
+          - description: Address and length of TX2.
+          - description: Address and length of RX2.
+
+      '#clock-cells':
+        const: 1
+
+      '#phy-cells':
+        const: 0
+
+    required:
+      - reg
+      - '#clock-cells'
+      - '#phy-cells'
 
 required:
   - compatible
   - reg
-  - reg-names
   - "#clock-cells"
   - "#address-cells"
   - "#size-cells"
@@ -103,12 +163,13 @@ examples:
     usb_1_qmpphy: phy-wrapper@88e9000 {
         compatible = "qcom,sdm845-qmp-usb3-phy";
         reg = <0x088e9000 0x18c>,
-              <0x088e8000 0x10>;
-        reg-names = "reg-base", "dp_com";
+              <0x088e8000 0x10>,
+              <0x088ea000 0x40>;
+        reg-names = "usb", "dp_com", "dp";
         #clock-cells = <1>;
         #address-cells = <1>;
         #size-cells = <1>;
-        ranges = <0x0 0x088e9000 0x1000>;
+        ranges = <0x0 0x088e9000 0x2000>;
 
         clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
                  <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
@@ -123,7 +184,7 @@ examples:
         vdda-phy-supply = <&vdda_usb2_ss_1p2>;
         vdda-pll-supply = <&vdda_usb2_ss_core>;
 
-        phy@200 {
+        usb3-phy@200 {
             reg = <0x200 0x128>,
                   <0x400 0x200>,
                   <0xc00 0x218>,
@@ -136,4 +197,14 @@ examples:
             clock-names = "pipe0";
             clock-output-names = "usb3_phy_pipe_clk_src";
         };
+
+        dp-phy@88ea200 {
+            reg = <0xa200 0x200>,
+                  <0xa400 0x200>,
+                  <0xaa00 0x200>,
+                  <0xa600 0x200>,
+                  <0xa800 0x200>;
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+        };
     };
-- 
Sent by a computer, using git, on the internet

