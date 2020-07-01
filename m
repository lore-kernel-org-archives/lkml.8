Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E652C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3757F2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dK7H4B3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgGALlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:41:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20755 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730406AbgGALlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:41:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593603680; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yCOmt+7TNApXMP9W7foIqk8TA3VYJjNfF1s36e7JilI=; b=dK7H4B3yYraDVM5V5JL/YCWvQYouv9mUuYhtkj7hlkSHWoqz4IAQTrMLU3SBO0ZOgb3Mh7Ti
 peA8fCsOmwTWwEzcZy00nsnphFr8uxIyAO8MElluVXESYFm8CSm62hysG6uRYcpv+Z1FxymD
 lgN1xPMtLfb+JZOGDUOwCeriTTg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5efc76508fe116ddd9f0845d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Jul 2020 11:41:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC484C433A0; Wed,  1 Jul 2020 11:41:03 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9EB9C43395;
        Wed,  1 Jul 2020 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9EB9C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: sc7180: Add OPP tables and power-domains for venus
Date:   Wed,  1 Jul 2020 17:10:38 +0530
Message-Id: <1593603638-19296-4-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593603638-19296-1-git-send-email-rnayak@codeaurora.org>
References: <1593603638-19296-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP tables in order to be able to vote on the performance state
of a power-domain

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ad57df2..738a741 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2392,8 +2392,10 @@
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc VENUS_GDSC>,
-					<&videocc VCODEC0_GDSC>;
-			power-domain-names = "venus", "vcodec0";
+					<&videocc VCODEC0_GDSC>,
+					<&rpmhpd SC7180_CX>;
+			power-domain-names = "venus", "vcodec0", "opp-pd";
+			operating-points-v2 = <&venus_opp_table>;
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
 				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
 				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
@@ -2414,6 +2416,35 @@
 			video-encoder {
 				compatible = "venus-encoder";
 			};
+
+			venus_opp_table: venus-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <150000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-320000000 {
+					opp-hz = /bits/ 64 <270000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-380000000 {
+					opp-hz = /bits/ 64 <340000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <434000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+
+				opp-533000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					required-opps = <&rpmhpd_opp_turbo>;
+				};
+			};
 		};
 
 		videocc: clock-controller@ab00000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

