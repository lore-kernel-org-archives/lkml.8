Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F90C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB11A20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="mRrR9ilY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgICW1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgICW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:27:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE13C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:27:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so3229175qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg1t9In0g5b7CTs/tQIaFcuTzs3vfJs/vuWLC07Pzgc=;
        b=mRrR9ilYMg1OOegUka41qYoRCU25laiyVARX4xxF6J+7i+DZLSjHl+zoXxDIXk55Pn
         Ul8wFONEb6KtDQ30kaWNmGgZaCd0N0ZTEDKKV1X8aTMzyh2HWxPAoZcLtuLEOQiyt36P
         34g2IRyVVcKKr4irRKmfiI8en3pPyt8uVu9IXzE3fBH/7VjoX4cGq9JE/DaK2z+gTBZa
         w5ErxbUjsIqY5YPVmcUcp7CUtwt7PqtBf/atz4Ito2/N5GEfK20gj1vCawafwOzomCtb
         OnqX5UdP2lntdOUAUYL59uwl9Y3EsvJMnc/2JChHAWPMmPgVwaBaMBLQuIMHTEekRGqT
         3Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg1t9In0g5b7CTs/tQIaFcuTzs3vfJs/vuWLC07Pzgc=;
        b=iB2iZsvGC4HPxX2e2Oid59VRArG8NQdeO3DMwjjmKbrH4RvYPQCG9RcPxmqQDXkuVX
         InalBH9aKc0Sn0eahmEN9+y9GqNWQPdD+6hgXuA16Bv/QfRwJAESgff4jPQfMcl5Kl1r
         bwi4/D66wL53uKW0DavmcOOs9fA/XPHemzlpL31OoDwja5TX2zp75MNaESUXsFXtyMFk
         bTH4ZK/E2DnLacuZH/v+IC+CyfQGE8FexjXzFE7b0uN/SwVfDxYQRXDlkzijUd/jeF8Y
         xUqrx1E5te9yHe3mAvN+tCCls1j3iMaQFe/1KGDW30TO9nNBnrVHhPb47Z25skmQ6fAo
         htYA==
X-Gm-Message-State: AOAM5315yVrHMFOpdqLYIFp5LrIAU1terZCgsJCmppfUx2iNjfsHWrUC
        jdvBaBT/okGCGQGYseg9mBpURNKbbppD9+hFIEU=
X-Google-Smtp-Source: ABdhPJyLV2eb86Nsfbw+iM3w6ebemM6ZYJF5/tgw4W/oNcN66sgd2w6vSHOiDqWGb4G67oUcPY0A8w==
X-Received: by 2002:ac8:748c:: with SMTP id v12mr5697566qtq.200.1599172033997;
        Thu, 03 Sep 2020 15:27:13 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y30sm3217157qth.7.2020.09.03.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:27:13 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/7] arm64: dts: qcom: sdm845-dispcc: same name for dp_phy clocks as sc7180
Date:   Thu,  3 Sep 2020 18:26:10 -0400
Message-Id: <20200903222620.27448-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200903222620.27448-1-jonathan@marek.ca>
References: <20200903222620.27448-1-jonathan@marek.ca>
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

