Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F858C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C02C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvUC35sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFQOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:51:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFAC0613EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:51:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so1115572pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHDXTrxrPr/ji5r+gzel+9fUGlLw6TAHPNwGJ7xfdkA=;
        b=VvUC35sOnZr1p54G45m3VOKy8uZ8e5bmbhcZN9jZnFVgnTDiwJJjn9q1w9joR+fq6+
         LvIBHOBoTFfEjjTgB2XyZgDwbQMwmAF2q/yvQvrXOVOTPcqSP5y46rr1TpxGi0W40RPU
         9jf31u38Q01rzuP+kO6uGvxmaReLYGtsWSpAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHDXTrxrPr/ji5r+gzel+9fUGlLw6TAHPNwGJ7xfdkA=;
        b=iQGBND5RWmoqyVNAyErWDwQSfXv9qBcL6zQegghNus1hGEo4qdG6XvljUldsAnI4sy
         2t07WIzShyo59qtJRI1jYiTEnFr5yaVRteSZn3ezpwkQSFeJW7sIs1JiksAVJeg7rzUE
         SqitSs4noaTHcnMPErIE6SBTF8D+FwZi4SQs2ej66V5+4/rrOQk8rqD8DiHriEIAUk1I
         tFH434EB15tEJK7BiyiB7SsxVpjzKOW6+5I81hkeQYBDFc7nHvhQ/9i1QNb/rbPnVbqU
         xM7Nxx8XR+AcDpOMWwJvsZOsQCzJdGa2xd4Py8PJe65syeUbufdYHWsMPpwKJirTSCnZ
         /HXg==
X-Gm-Message-State: AOAM530Dl5BinvAsE6sNt9U88nVV4CB5oqZm649KxQSODmf9ykcipsCi
        oorzKmW07onS/QbvZq9XXPw77Q==
X-Google-Smtp-Source: ABdhPJyABziZjJ2pLl5VgSZD68qgYBT6lnAEYD6+D8xTs6fWFVqzHs1ul+Kl1aQoJPBpUFqDygFnzg==
X-Received: by 2002:a17:90b:4911:: with SMTP id kr17mr8174779pjb.40.1592405515652;
        Wed, 17 Jun 2020 07:51:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k18sm147040pfp.208.2020.06.17.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:51:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     dhavalp@codeaurora.org, mturney@codeaurora.org,
        rnayak@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc7180: Add properties to qfprom for fuse blowing
Date:   Wed, 17 Jun 2020 07:51:16 -0700
Message-Id: <20200617074930.v3.4.I70c17309f8b433e900656d7c53a2e6b61888bb68@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200617145116.247432-1-dianders@chromium.org>
References: <20200617145116.247432-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Kumar Bokka <rbokka@codeaurora.org>

This patch adds properties to the qfprom node to enable fuse blowing.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Name is now 'efuse' to match what schema checker wants.
- Reorganized ranges to match driver/bindings changes.
- Added 4th range as per driver/binding changes.
- No more reg-names as per driver/binding changes.
- Clock name is now just "sec" as per driver/binding changes.

 arch/arm64/boot/dts/qcom/sc7180-idp.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 4e9149d82d09..2a9224e2083f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -287,6 +287,10 @@ vreg_bob: bob {
 	};
 };
 
+&qfprom {
+	vcc-supply = <&vreg_l11a_1p8>;
+};
+
 &qspi {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 31b9217bb5bf..d7f5e3d64b17 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -498,9 +498,15 @@ gcc: clock-controller@100000 {
 			#power-domain-cells = <1>;
 		};
 
-		qfprom@784000 {
+		qfprom: efuse@784000 {
 			compatible = "qcom,qfprom";
-			reg = <0 0x00784000 0 0x8ff>;
+			reg = <0 0x00784000 0 0x8ff>,
+			      <0 0x00780000 0 0x7a0>,
+			      <0 0x00782000 0 0x100>,
+			      <0 0x00786000 0 0x1fff>;
+
+			clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
+			clock-names = "sec";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.27.0.290.gba653c62da-goog

