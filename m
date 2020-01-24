Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C0AC35244
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9502071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DH4yPU/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgAXWnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:43:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40736 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgAXWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:43:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so458663pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUY8OKSzBPGKXsy9C12HX4Zd6On+8bszenkjFTAhVcw=;
        b=DH4yPU/+4ENvZ1SHdmkXG/qDzhONJtANeKgsBWF2MKama9XzUmkblLRrT/cItCZKj8
         8Y2BMYOHgoRy5Bf8ONQUvRQ9k0wgYTzO7ax770GkY60FXeHJNdvANDEoCA0UBkaZmXuq
         QICm4GNs/WQDglT6iZ7Ib965Jp/q1Yqp5t0JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUY8OKSzBPGKXsy9C12HX4Zd6On+8bszenkjFTAhVcw=;
        b=L9bOmgaUN34GKw/5bhfL8e0TqdssLXfIVPPlo7ZYNg2R/eudlMPXAf43ew7zvPss6V
         eS2T78tCPS7oGSzxxq1J9OT+H7LIdUNdbGkiVU/CmqicQpfU15Q3UIVWyye9L8tqxwxR
         r8rAJ/adA1R/FlLRTq58oYIN/4ZC+pgn+D4TTi42qK5qqBg/ksTM83ZlkJfb8envFQkD
         gVkOasJNoWorP8UZNTPOQscBPCXhOAy5u5Y/Q3cvpHxO9RuhygmCkoIDULk2xtI6z95W
         b7y6EtfMn/9hwtbrNeV1AKxCFzfnY0rlh1JekRfkiBAP+6S9Q+/CRL6YsCSpMZLaGmAy
         OipQ==
X-Gm-Message-State: APjAAAWrsajoezN7NnM2G6ejsw8+PXjoTSLogIDZpNJwVsFNYMc8yaZn
        p/uTNcRBDWSWUQXqMHDRKBzorw==
X-Google-Smtp-Source: APXvYqx5KfK3OEW+qx8AJSVzFCWaLqn2Fo+x2QCA7ODGdtOJTbEJkWdllo7poK33dXuSQDkC1pMurw==
X-Received: by 2002:a17:90b:342:: with SMTP id fh2mr1666659pjb.23.1579905797991;
        Fri, 24 Jan 2020 14:43:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm7690948pjo.26.2020.01.24.14.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:43:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        mka@chromium.org, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        hoegsberg@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
Date:   Fri, 24 Jan 2020 14:42:17 -0800
Message-Id: <20200124144154.v2.2.I0c4bbb0f75a0880cd4bd90d8b267271e2375e0d0@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124224225.22547-1-dianders@chromium.org>
References: <20200124224225.22547-1-dianders@chromium.org>
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
   (each of which has two clocks).  These all need to be specified.

2. The sdm845.dtsi has existed for quite some time without specifying
   the clocks.  The Linux driver was relying on global names to match
   things up.  While we should transition things, it should be noted
   in the bindings.

NOTE: It may be slightly controversial that I didn't re-order the
clocks and name the "DSI" clocks on sc7180 to "dsi0".  That would have
allowed me to have a single table and just use minItems/maxItems to
specify that sc7180 only had one DSI PHY.  I almost did that, but it
felt a little weird.  Why did the DSI clock have a 0 but not the DP
clock?  If we add a SoC that has a 2nd DP port then we can't
retroactively name old ones.  What if we have a SoC that has HDMI but
only one DSI lane?  It felt cleaner to me to just duplicate.

Also note that I updated the example.

Fixes: 5d28e44ba630 ("dt-bindings: clock: Add YAML schemas for the QCOM DISPCC clock bindings")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Patch ("dt-bindings: clock: Fix qcom,dispcc...") new for v2.

 .../bindings/clock/qcom,dispcc.yaml           | 87 +++++++++++++++----
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
index 9c58e02a1de1..560c52ce3da5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
@@ -19,18 +19,6 @@ properties:
       - qcom,sc7180-dispcc
       - qcom,sdm845-dispcc
 
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
   '#clock-cells':
     const: 1
 
@@ -52,16 +40,83 @@ required:
   - '#reset-cells'
   - '#power-domain-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,sc7180-dispcc
+then:
+  properties:
+    clocks:
+      items:
+        - description: Board XO source
+        - description: GPLL0 source from GCC
+        - description: Byte clock from DSI PHY
+        - description: Pixel clock from DSI PHY
+        - description: Link clock from DP PHY
+        - description: VCO DIV clock from DP PHY
+
+    clock-names:
+      items:
+        - const: xo
+        - const: gpll0
+        - const: dsi_phy_pll_byte
+        - const: dsi_phy_pll_pixel
+        - const: dp_phy_pll_link
+        - const: dp_phy_pll_vco_div
+
+else:
+  if:
+    # NOTE: sdm845.dtsi existed for quite some time and specified no clocks.
+    # The code had to use hardcoded mechanisms to find the input clocks.
+    # Any sdm845 device trees should be transitioned, but actual code may
+    # need to handle old dts files.
+    properties:
+      compatible:
+        contains:
+          const: qcom,sdm845-dispcc
+  then:
+    properties:
+      clocks:
+        items:
+          - description: Board XO source
+          - description: GPLL0 source from GCC
+          - description: Byte clock from DSI PHY0
+          - description: Pixel clock from DSI PHY0
+          - description: Byte clock from DSI PHY1
+          - description: Pixel clock from DSI PHY1
+          - description: Link clock from DP PHY
+          - description: VCO DIV clock from DP PHY
+
+      clock-names:
+        items:
+          - const: xo
+          - const: gpll0
+          - const: dsi0_phy_pll_byte
+          - const: dsi0_phy_pll_pixel
+          - const: dsi1_phy_pll_byte
+          - const: dsi1_phy_pll_pixel
+          - const: dp_phy_pll_link
+          - const: dp_phy_pll_vco_div
+
 examples:
   # Example of DISPCC with clock node properties for SDM845:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@af00000 {
       compatible = "qcom,sdm845-dispcc";
-      reg = <0xaf00000 0x10000>;
-      clocks = <&rpmhcc 0>, <&gcc 24>;
-      clock-names = "xo", "gpll0";
+      reg = <0 0x0af00000 0 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_DISP_GPLL0_CLK_SRC>,
+               <&dsi0_phy 0>, <&dsi0_phy 1>,
+               <&dsi1_phy 0>, <&dsi1_phy 1>,
+               <&dp_phy 0>, <&dp_phy 1>;
+      clock-names = "xo", "gpll0",
+                    "dsi0_phy_pll_byte", "dsi0_phy_pll_pixel",
+                    "dsi1_phy_pll_byte", "dsi1_phy_pll_pixel",
+                    "dp_phy_pll_link", "dp_phy_pll_vco_div";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-     };
+    };
 ...
-- 
2.25.0.341.g760bfbb309-goog

