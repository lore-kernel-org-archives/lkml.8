Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CFC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AC82067D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="LHmet0PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGQNa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:30:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30134 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgGQNat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:30:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594992648; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YQ4zTOzVY7tD8+0LunMnnTS0zV8fWFiSWwGe3hpL4w0=; b=LHmet0PTh4d0fM8Tt5CNQK4Th70DJV2plFrJasbXLgp0hrYsrDsPv8qXC/W5Z5YoO69c2QhX
 sugZIqMAAHAOP0FDU+VjFvwJZRxXi/Zosw0VTEVjtt4vhl/BGovjW9KeRTVpvMszUQqp7ANf
 9h4AZmN2HkuVRIJnqw4M+cxRO+M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f11a7ea75eeb235f684d45b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 13:30:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62904C43395; Fri, 17 Jul 2020 13:30:18 +0000 (UTC)
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8527C433AF;
        Fri, 17 Jul 2020 13:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8527C433AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        smasetty@codeaurora.org, devicetree@vger.kernel.org,
        mka@chromium.org, saravanak@google.com, sibis@codeaurora.org,
        viresh.kumar@linaro.org, jonathan@marek.ca, robdclark@gmail.com,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 6/6] arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU opp
Date:   Fri, 17 Jul 2020 18:59:39 +0530
Message-Id: <1594992579-20662-7-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594992579-20662-1-git-send-email-akhilpo@codeaurora.org>
References: <1594992579-20662-1-git-send-email-akhilpo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sharat Masetty <smasetty@codeaurora.org>

Add opp-peak-kBps bindings to the GPU opp table, listing the peak
GPU -> DDR bandwidth requirement for each opp level. This will be
used to scale the DDR bandwidth along with the GPU frequency dynamically.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 80fe54b..ff4ddf1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1479,36 +1479,43 @@
 				opp-800000000 {
 					opp-hz = /bits/ 64 <800000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <8532000>;
 				};
 
 				opp-650000000 {
 					opp-hz = /bits/ 64 <650000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <7216000>;
 				};
 
 				opp-565000000 {
 					opp-hz = /bits/ 64 <565000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <5412000>;
 				};
 
 				opp-430000000 {
 					opp-hz = /bits/ 64 <430000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <5412000>;
 				};
 
 				opp-355000000 {
 					opp-hz = /bits/ 64 <355000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <3072000>;
 				};
 
 				opp-267000000 {
 					opp-hz = /bits/ 64 <267000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <3072000>;
 				};
 
 				opp-180000000 {
 					opp-hz = /bits/ 64 <180000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					opp-peak-kBps = <1804000>;
 				};
 			};
 		};
-- 
2.7.4

