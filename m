Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B54221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="P9QknNE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIKQNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgIKPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:35:53 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE69C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cy2so5418368qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cznD9PtbdCnTuIZHnsXFM10RQkLCsdUaXijp1Kw5QfM=;
        b=P9QknNE1aAuC4kFJNTMIPm4V9anpO9ur7O97Qs7oKMmkt40+bLIuzPQjN0Zl5vOGz+
         X+6xr2KY/T8e2o/ozewC6LMosMmgvAuv08GCSijoV73LImGOoAvXeIQTJuBskZYol3Sr
         ujgrWNveABiqQP5jWWXxi3/KJFBN86AGXyIKnDIt3kcZ4aVraHsPZDDxKwQNGVslZMZv
         zBDqqSyQon4hZHF5vDipGydaBniv8+LY7sn/W/kyR6Q5/gWt879m8bbXiTJ5gjw90vp0
         kuHaTx15m4uYUYu/a3VJhuVAapjZTJ9ld3u3TanELyNr7jBamha4IEY88w425OCV/klN
         HG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cznD9PtbdCnTuIZHnsXFM10RQkLCsdUaXijp1Kw5QfM=;
        b=WFikhIiMzR0ZztLhG4+EQUqTzdHrcvY35n8LrmIwyZa8bwXRDYxGXbQ+HD8bc6HBNF
         9AMvgV5MBxFlCNHj45FfpG/1oIlbc2smolz3WTah5rh/6Edg+V1htMC0VzC7EK2XoK1p
         Ykz59iQ9V/+rAuljOd43nAXpgx8W6VStrEE34n2x/SftvzzXKrZxqJ/xWf7rnmuX6NGe
         1YWNUDFfJdwVVrHuh02PJJ0Pc/p8MuCiDaPCt4IHg1b+PeCu2kj0L5AzQEYzzSjg69M1
         W7+8GZcqFOONhuVg9bApQxh+r2Zr+671rTb248Cj4TvvtQ7oLX87KKghk01F8abbCKTj
         Re3Q==
X-Gm-Message-State: AOAM530NoZLTIZOmr3g8sB22mO9Od8PnuPaXQ5pIf2gwo7uL6IHu4Zx1
        pevTXla9jaJLQOswWgjuLIJdVQ==
X-Google-Smtp-Source: ABdhPJxTYCLs2sh7OCgELR9nztjiEkUmHMHQI/9SBfkIRMDRwjvcrCIR6EZfChEKTL46j879jOzCLA==
X-Received: by 2002:a0c:f1c5:: with SMTP id u5mr2488860qvl.10.1599838533324;
        Fri, 11 Sep 2020 08:35:33 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id v16sm3001744qkg.37.2020.09.11.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:35:32 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] dt-bindings: clock: sdm845-dispcc: same name for dp_phy clocks as sc7180
Date:   Fri, 11 Sep 2020 11:34:01 -0400
Message-Id: <20200911153412.21672-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200911153412.21672-1-jonathan@marek.ca>
References: <20200911153412.21672-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to combine dt bindings for sdm845/sc7180 dispcc.

Note: nothing upstream provides these clocks and the sdm845 dispcc driver
hasn't switched to using .fw_name for these clocks (these properties are
ignored), so changing this shouldn't be a problem.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../devicetree/bindings/clock/qcom,sdm845-dispcc.yaml     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
index 4a3be733d042..ead44705333b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -43,8 +43,8 @@ properties:
       - const: dsi0_phy_pll_out_dsiclk
       - const: dsi1_phy_pll_out_byteclk
       - const: dsi1_phy_pll_out_dsiclk
-      - const: dp_link_clk_divsel_ten
-      - const: dp_vco_divided_clk_src_mux
+      - const: dp_phy_pll_link_clk
+      - const: dp_phy_pll_vco_div_clk
 
   '#clock-cells':
     const: 1
@@ -92,8 +92,8 @@ examples:
                     "dsi0_phy_pll_out_dsiclk",
                     "dsi1_phy_pll_out_byteclk",
                     "dsi1_phy_pll_out_dsiclk",
-                    "dp_link_clk_divsel_ten",
-                    "dp_vco_divided_clk_src_mux";
+                    "dp_phy_pll_link_clk",
+                    "dp_phy_pll_vco_div_clk";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.26.1

