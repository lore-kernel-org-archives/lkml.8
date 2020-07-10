Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E2C4345C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4EE20786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lq+MGkGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGJXDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGJXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:02:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1ACC08E8A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so3162613pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Qsyzl86u0xp/Q3AsfuSrATvhmR+NH14naSidgeU2PQ=;
        b=lq+MGkGphLSf5MfibDTvyQhzb4kbnr6BuiTTOfoYVXvs6hnNVAZTeS4GzeWIxArgee
         Y/DxQGYcoFo+gk/NY0IejlYOm3y/3+wSh+PT17XFNxMNb8K+oQfFlM+FQezfd3als/7y
         0D+mf6sp9cX0TEI2MsZR5iuiPVqiJ/+S4Grxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Qsyzl86u0xp/Q3AsfuSrATvhmR+NH14naSidgeU2PQ=;
        b=D3BvMpjEfN5qxI7fiTJO217gggz5RNMfLffF01Tj1tvA6CEfL69B8aLX7RjXcUcJ25
         6qWlgyCT/Sp7qZw+jdp9aRL6S4nWD7U6YYzyVttardND3ClSXRSBt0xKZWVFi9V164ye
         XsLGwNeg55RgtbHd/52dOxxPOKsCV1E8mEGi+z1xuEBsa1dip5PQzGxXIHwzrH1nKwQA
         MPcY/54CZpBlIbpz9MU4WpugOgVTreYGCFrbi62D44nhOW7BYCjYNJMpLpBLN18vMNaD
         146ui935/BrfKSwe7BtCaRy/5UfWG/s5aaC2eS5Ca/nKCpEeTY7BW8TVeUSwp6ABxyxm
         p3/w==
X-Gm-Message-State: AOAM532b87uF6LkOwujHdSHSYPHCJ7ZoO1yvs89LCSI8/ZXLBJb+QXy/
        +zufYUrtAO1NR4FBObcvNY5lXA==
X-Google-Smtp-Source: ABdhPJysOX+rXIvX5/wYSLxirccnx0NQRBQKy0k+Iygaxavdr8HbCK/P41qasElxbHYh6Os2dg4vCg==
X-Received: by 2002:a62:5a45:: with SMTP id o66mr5243667pfb.43.1594422173149;
        Fri, 10 Jul 2020 16:02:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id my9sm7266836pjb.44.2020.07.10.16.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:02:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] arm64: dts: qcom: msm8916: Add "simple-bus" to our mdss node
Date:   Fri, 10 Jul 2020 16:02:22 -0700
Message-Id: <20200710160131.7.I1605593efa85e3c9260e64fe51aedd0524544d81@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200710230224.2265647-1-dianders@chromium.org>
References: <20200710230224.2265647-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the bindings patch, this means that our child nodes
are devices in their own right.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
If this patch lands before the patch ("drm/msm: Avoid manually
populating our children if "simple-bus" is there") it doesn't seem to
be the end of the world.  The first time through
add_display_components() it'll notice that the children are already
populated and it will be a no-op.  When it gets a defer it will then
depouplate them (even though it didn't populate them) and future calls
will just populate them again.

NOTE: I have no way to test this patch, but I'm assuming it works OK?

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 67cae5f9e47e..491362fe02ac 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1023,7 +1023,7 @@ opp-19200000 {
 		};
 
 		mdss: mdss@1a00000 {
-			compatible = "qcom,mdss";
+			compatible = "qcom,mdss", "simple-bus";
 			reg = <0x1a00000 0x1000>,
 			      <0x1ac8000 0x3000>;
 			reg-names = "mdss_phys", "vbif_phys";
-- 
2.27.0.383.g050319c2ae-goog

