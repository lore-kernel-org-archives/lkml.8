Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB8C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4262166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+wHUgAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgCDS5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:57:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:57:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so1431612pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idtFy8s7OaNPWyKbg7P+1dRKvA+ZRf5zuxknR7OyW1o=;
        b=P+wHUgAfTLxMQ2NcHR/tTiyoigV9cEhyD/cKtzqf91Cc47F9lSfj2Sbn3vBkR8MKA4
         HKATzrSgYdIqrlRSJ+u52MpPHsjvVLLagl6mT+sTceC5IVRaJI/IVta88WVHPHpDjCi/
         MdtGjOBHDRAVq41VdjCz1mMvtjAHJogDft0A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idtFy8s7OaNPWyKbg7P+1dRKvA+ZRf5zuxknR7OyW1o=;
        b=MnWIUSyaArGerFN/tVdt1IBWgYkOtG8dQXtCaiWglIC9m/bLdLVaHVHn3cJdcmL7/Q
         P1QhUsHlVU2wBZgQpPa1kyS0Oc87wrpN5KgKcorn/g9cR1vcAsOwVwoWTObiIP3UpWna
         pQMPcn4H0Z+oXixFORd6XzD3fZK6+BZWhD5Gm0gU37ALZS+z8Ja9XeB3uj/kJRuzpQBm
         97kJCbbU/Jul9b+SRjMLCZ94ohlvgPxU8DuzMt1eWcnGVqPqDCY5yR7txM02CzUyLKOt
         lmgelPWNGanedD+07BhQ9ubmB1KnIfXe2m4w494Dzy3RHRNTyAkgt/er0wvkNYtEZy9d
         c1hg==
X-Gm-Message-State: ANhLgQ13Rugx6fdjkbF1t7XTYAS3oBNLOM5Sc+DN/FYcnqDnFBtU1sy9
        7rGFfPobDtwQgjBbFs63vM9x7A==
X-Google-Smtp-Source: ADFU+vsFNLAgknRkVaIM88rGnq3JGV02sq8SLXTLvL9+Yxwez8qby8TqAzle/IPrOWuYWkvutiT15w==
X-Received: by 2002:a63:5859:: with SMTP id i25mr3699184pgm.74.1583348243434;
        Wed, 04 Mar 2020 10:57:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id cm2sm3576394pjb.23.2020.03.04.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:57:22 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sc7180: Add unit name to soc node
Date:   Wed,  4 Mar 2020 10:56:56 -0800
Message-Id: <20200304105638.1.I9ea0d337fcb927f52a28b20613b2377b6249c222@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just like commit a1875bf98290 ("arm64: dts: qcom: sdm845: Add
unit name to soc node") but for sc7180.

For reference, the warning being fixed was:
  Warning (unit_address_vs_reg): /soc:
  node has a reg or ranges property, but no unit name

Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 253274d5f04c..8e71f543819e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -359,7 +359,7 @@ psci {
 		method = "smc";
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x10 0>;
-- 
2.25.0.265.gbab2e86ba0-goog

