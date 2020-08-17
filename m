Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376CFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9062063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vCsTbgaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgHQW7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:59:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54180 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbgHQW7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:59:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597705182; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=1iMRAOibRi50JnJL7Gy/48bD9j2LMVyK5mB4/xTVJwk=; b=vCsTbgaj4TRknvrjonPoAKQn/U6j/IYF7Av3DOto/6SExXpMjSLpMiyS/D0YOdLPMwmwYeaL
 DkI4T0VBLmCtuzdkTAQdTr6OKk1ei9/yEiuk1G2LrxVLKLRLb6eFdzzQMxUVZ4Rhf8ATZVRQ
 9KRRHCYzaSVG9tF13xkh8hVF7Xk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3b0bcf440a07969a205e61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 22:59:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71EDFC43395; Mon, 17 Aug 2020 22:59:26 +0000 (UTC)
Received: from linuxdisplay-lab-04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F84AC433CA;
        Mon, 17 Aug 2020 22:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F84AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tanmay@codeaurora.org
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     swboyd@chromium.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        robdclark@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node
Date:   Mon, 17 Aug 2020 15:59:12 -0700
Message-Id: <20200817225912.3149-1-tanmay@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node defines alternate DP HPD functionality of GPIO.

Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index bf2f2bb1aa79..0eedf057acc1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1457,6 +1457,19 @@ pinconf-sd-cd {
 					drive-strength = <2>;
 				};
 			};
+
+			dp_hot_plug_det: dp-hot-plug-det {
+				pinmux {
+					pins = "gpio117";
+					function = "dp_hot";
+				};
+
+				pinconf {
+					pins = "gpio117";
+					bias-disable;
+					input-enable;
+				};
+			};
 		};
 
 		gpu: gpu@5000000 {

base-commit: 62975d27d647a40c58d3b96c29b911fc4f33c310
prerequisite-patch-id: a4d3e51b6e1200ff7d4550f206db98a92c0a098f
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

