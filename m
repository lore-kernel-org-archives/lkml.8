Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D0EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0E02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJUnCZVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbgAXWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:43:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34850 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbgAXWn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:43:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so1860986pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bui28Vv12xUmXWYpC+BbDFYgTGPFUNN9TS7e8X83ptU=;
        b=nJUnCZVZFNjMZvgzvmEPCuW8bMgT93sV0s2dZgIYVCytFK0KhhjowkK2AosMIsSyay
         KmsdEYHy/oKz+S9r2Kkijver4P7gSJN8tLFftGYIKJ/WG2/GJaPtQiiz5n4FA8uhSKE1
         yjW6QAW2ZhSfO7AVaFhdvXiXxzrTqDyFmvByI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bui28Vv12xUmXWYpC+BbDFYgTGPFUNN9TS7e8X83ptU=;
        b=nfBpQO7/LLVIxxYJDex+KeWcFllPPooX6xB4Wp1Ae51soKb0bV3GWbO5yNObbqxNos
         W8DaXSZmh44bSsbWCO6L7WqVvrVBRWS4IEnu7B4RXS0Xq+vpDpr5a+1SIYUzhFbvAT7n
         sNGg2kj2b+v4O7bIc7kAle0ZnxOoR438j4xNWX0vDYrAhLePJI2AGo+1SV8VT31BRmhw
         kkBSw5g3TgxrkCnRFGeo7cD06GiybFaTpc9nOlSZZSgdQvYnISjpl4wl6tKJT5Sokvod
         dl3VS8mVDHC4kDnuCSYwPxazpbjFvL3rPDlU/P9d8W62lBwpWn8K3TSM+JqcdcChibLa
         3Vrw==
X-Gm-Message-State: APjAAAVxNgM0q3qtec1G7Kbja4DnfwPgu03CTmcewtRdMCht63TLPKcY
        hU+Uma3ZlCLJDo6CCM8BdYsAUw==
X-Google-Smtp-Source: APXvYqzS9tPcZFwCykAq9Smp2Jxt5RR3eG4xljjcnI1eH/vNH2TY407AdxHLUd4cuuKsTLeq6urYLw==
X-Received: by 2002:a62:ddd0:: with SMTP id w199mr5272391pff.1.1579905805722;
        Fri, 24 Jan 2020 14:43:25 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm7690948pjo.26.2020.01.24.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:43:25 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 09/10] arm64: dts: qcom: sdm845: Add the missing clock on the videocc
Date:   Fri, 24 Jan 2020 14:42:24 -0800
Message-Id: <20200124144154.v2.9.Id0599319487f075808baba7cba02c4c3c486dc80@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124224225.22547-1-dianders@chromium.org>
References: <20200124224225.22547-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're transitioning over to requiring the Qualcomm Video Clock
Controller to specify all the input clocks.  Let's add the one input
clock for the videocc for sdm845.

NOTE: Until the Linux driver for sdm845's video is updated, this clock
will not actually be used in Linux.  It will continue to use global
clock names to match things up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Patch ("arm64: dts: qcom: sdm845: Add...videocc") new for v2.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e624c91dbd6d..8c41e25bd4a8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2605,6 +2605,8 @@ video-core1 {
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sdm845-videocc";
 			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-- 
2.25.0.341.g760bfbb309-goog

