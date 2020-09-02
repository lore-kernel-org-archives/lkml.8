Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC32CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3ED20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="hhC3vT59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgIBSlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgIBSkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:40:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE34C061251
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:40:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w186so706985qkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg1t9In0g5b7CTs/tQIaFcuTzs3vfJs/vuWLC07Pzgc=;
        b=hhC3vT59TxPLb3rFe0HnRM66J/M9V9UidUla1thtjU123Yl/POs3Zqp/Qm7U9R3D2y
         W2JpYl/HxalGjIMxHgjU+/fM2eKI9HdWFOE7s/ri2XQpk5l0JyKB8IzyHuZEyocV8NB9
         x+8zqjjqDY3nwcsighUhDTZQx2RK9C/xu2J73qrVp4jHW5pgpg/aiv3+4tdPs7gwDL3y
         TLaJEvKHyS8x5ZFarJ7CRh4y2zaq+sUOk8ocqs5hLiPOTd0pdCCCKKUS629fyWvSc1Hy
         xc6v9zyiiOs5qrb9quNu2D5+mSZnPt0e5i7gUIAoD4BGoQ88PJE1ECs3UzQmcNuBW65Q
         4BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg1t9In0g5b7CTs/tQIaFcuTzs3vfJs/vuWLC07Pzgc=;
        b=KKKLn3S62CMayua3+v/i9rtEq2W6uue6AwLtwS0ebfWFW6KlQRjtWB3lBi1YJg8L8t
         mFsB86HvJat9YUuLIWs/O2sz0BcsFuRJCK8YeCQBgbYU6mID8YR1CuatZx/uc3bFd2CD
         1FOEPMs+Up32HZ6Gt4yS7q0DpMMyLZjP615Q0Dh+tliYCTdTYHPqclNU04GGhYbscDpZ
         1CjeoZiuvSvUPeTwiQ6lx4Abf7dJFKSYDVRB+Biv8fXJ9LvK4fVPove/amrKqag+mZZG
         47g/p/58GuLJO8H40yPusgqjxtk6Qkn+GWijQ3bw86zw/EdMPQqpV75mad4ZbdAdDnhG
         hOXg==
X-Gm-Message-State: AOAM531ALzzRCuD6R2qTCa39xak1MZJsA+3d0HkxuLlYl2N//Ff9sXaW
        qhETtecWYs0E+Nvql68TwCBV9g==
X-Google-Smtp-Source: ABdhPJxPRGDyQv3ibszWeA3WlU9WRxYEUMu3g+2vz1499sb+s4ys67PEdYMn5f9sHQWJjOZP6neZsA==
X-Received: by 2002:a37:b245:: with SMTP id b66mr7861577qkf.179.1599072002249;
        Wed, 02 Sep 2020 11:40:02 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id s47sm208004qtb.13.2020.09.02.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:40:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] arm64: dts: qcom: sdm845-dispcc: same name for dp_phy clocks as sc7180
Date:   Wed,  2 Sep 2020 14:38:42 -0400
Message-Id: <20200902183852.14510-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200902183852.14510-1-jonathan@marek.ca>
References: <20200902183852.14510-1-jonathan@marek.ca>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2884577dcb77..8184d6204b33 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4139,8 +4139,8 @@ dispcc: clock-controller@af00000 {
 				      "dsi0_phy_pll_out_dsiclk",
 				      "dsi1_phy_pll_out_byteclk",
 				      "dsi1_phy_pll_out_dsiclk",
-				      "dp_link_clk_divsel_ten",
-				      "dp_vco_divided_clk_src_mux";
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.26.1

