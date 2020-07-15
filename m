Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B712067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D/o5Wr1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGOG4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:56:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56873 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728782AbgGOG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:56:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594796172; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9N1oWEhcrUbKJ3x4cXl1jbwYwOPXzexus4BA/jvOXTw=; b=D/o5Wr1TxrE0lIH6JT6gj43uWWAg9TNUuT7bTg2Kko9lpzOhKXVNrWWSA5hlMyhkNiiMuOzV
 ZXt29CBiHXoa/2YoP+uZwMG44Ev7xJ1/7Wjav/gim32sxzgblRWCPEoQVrVWKQ/ju134S1aw
 4YdH812DhhvAsZJlkbw/nc6Joss=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f0ea881512812c0708b1402 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 06:56:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B09A1C433A1; Wed, 15 Jul 2020 06:56:00 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31F5BC433CB;
        Wed, 15 Jul 2020 06:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31F5BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org, cychiang@google.com,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Add LPASS clock controller nodes
Date:   Wed, 15 Jul 2020 12:25:49 +0530
Message-Id: <1594796149-14778-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the clock controller nodes for Low power audio subsystem
functionality.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 2be81a2..8c30a17 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
 #include <dt-bindings/clock/qcom,gcc-sc7180.h>
 #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
+#include <dt-bindings/clock/qcom,lpasscorecc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7180.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
@@ -2136,6 +2137,27 @@
 			};
 		};

+		lpasscc: clock-controller@62d00000 {
+			compatible = "qcom,sc7180-lpasscorecc";
+			reg = <0 0x62d00000 0 0x50000>,
+			    <0 0x62780000 0 0x30000>;
+			reg-names = "lpass_core_cc", "lpass_audio_cc";
+			clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>;
+			clock-names = "iface";
+			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		lpass_hm: clock-controller@63000000 {
+			compatible = "qcom,sc7180-lpasshm";
+			reg = <0 0x63000000 0 0x28>;
+			clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>;
+			clock-names = "iface";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		etm@7040000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07040000 0 0x1000>;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

