Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D343BC81CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1BC2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/EIr+RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD0Vvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgD0Vvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:51:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2ACC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:51:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j7so9282047pgj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2US+UFErdQz+/2WUCZdQSrynGNoBUJIwL6mFZZjO4Zk=;
        b=R/EIr+RRamTRbKEAIuBhHKtxaZewTjKE+LoWnkc6pD9eXhURKoBWUI4TmJyQusVmxP
         jOByzuGCKpFdP9gc4/+Qkuces3cOPbZGbpK8Xb0bGwpey/X184pwhchY4wkJaj1Ja18d
         ezEjZlzbb/RPusZpc4a8A7uzoMB90e2nYlB6QmhrB/GCOW5qjRYmeC4clKzYjjTQJz62
         A5LU5tKEnL0jix2gPrIJMSTx2tQpcWR8K5FQRSml2SIT/K/F0hI2tj/EiZYa27s6232T
         0q3JFgy7tEtWSEeVAMXJtCJAgPIoeElTBbGf6s68t3zak1GwAXvtYfIeSsJPxgZGokhg
         vmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2US+UFErdQz+/2WUCZdQSrynGNoBUJIwL6mFZZjO4Zk=;
        b=qlQk1BkCUW30EykMXcJTCZDdkLAHlqqIlRTnWO4ZM0MbHbMs2vk4JBXVagHBji/xhk
         29S/FJqGx5nmAkzK8aIhYR+efcjW792WJfIgzuMyT9Oo+TaVKeBWxwmfNrKwYXG6jvXS
         arxX7HMCccnccjHbCKrwgw+HHU00Z+ap3LlmAHwQpgeb7fFrn4Hb6R6IBNQaXUQo2XB+
         1kYhgKWHSGB9Pd1n4T1Y7D8ecmBLL2K+PEkORFERewmlTjDVsFQWEogDnYVRqFW3Tlaj
         oDD2UEVFC0DHejLQJuwGdO30h6i0gmxhc4lcLJndM+iV/GYynm54EVjAAoFZpymKCvkp
         d+Dw==
X-Gm-Message-State: AGi0PuY4fIJsTL1WeEhM+Cu+6BdYZEX9tcGNh+Y88stGMLV0g5iERESI
        LyyB2hXp5Ii+hrFMLPpefx/Z1A==
X-Google-Smtp-Source: APiQypI9w3mN/5nhDZ6PT2DjOc9Txq+MTciQT5JDWxwj7p1+7MIALxUJUUbrsUd/RNQXKiPBr/2zFg==
X-Received: by 2002:a63:241:: with SMTP id 62mr5334082pgc.38.1588024311660;
        Mon, 27 Apr 2020 14:51:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j5sm4153876pfh.58.2020.04.27.14.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:51:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250-mtp: Drop PM8150 ldo11
Date:   Mon, 27 Apr 2020 14:51:17 -0700
Message-Id: <20200427215117.2900139-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8150 ldo11 on the MTP is wired to VDD_SSC_CX and controlled in levels,
rather than as a regulator. As such it's available from the rpmhpd as
the SM8250_LCX power domain.

Fixes: ec13d5c23a33 ("arm64: dts: qcom: sm8250-mtp: Add pm8150, pm8150l and pm8009")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index e9acda9f5b83..0c6b936be471 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -136,13 +136,6 @@ vreg_l10a_1p8: ldo10 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		vreg_l11a_0p75: ldo11 {
-			regulator-name = "vreg_l11a_0p75";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
 		vreg_l12a_1p8: ldo12 {
 			regulator-name = "vreg_l12a_1p8";
 			regulator-min-microvolt = <1800000>;
-- 
2.24.0

