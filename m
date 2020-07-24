Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE34C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CB420714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGXD6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:58:55 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:26142 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgGXD6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:58:48 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Jul 2020 20:58:47 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 23 Jul 2020 20:58:46 -0700
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Jul 2020 09:28:23 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 1686E4272; Fri, 24 Jul 2020 09:28:22 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 2/3] arm64: dts: qcom: sc7180: Add sleep pin ctrl for BT uart
Date:   Fri, 24 Jul 2020 09:28:01 +0530
Message-Id: <1595563082-2353-3-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
References: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sleep pin ctrl for BT uart, and also change the bias
configuration to match Bluetooth module.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
Changes in V2:
 - This patch adds sleep state for BT UART. Newly added in V2.

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 42 ++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 26cc491..bc919f2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -469,20 +469,50 @@
 
 &qup_uart3_default {
 	pinconf-cts {
-		/*
-		 * Configure a pull-down on 38 (CTS) to match the pull of
-		 * the Bluetooth module.
-		 */
+		/* Configure no pull on 38 (CTS) to match Bluetooth module */
 		pins = "gpio38";
+		bias-disable;
+	};
+
+	pinconf-rts {
+		/* We'll drive 39 (RTS), so configure pull-down */
+		pins = "gpio39";
+		drive-strength = <2>;
 		bias-pull-down;
+	};
+
+	pinconf-tx {
+		/* We'll drive 40 (TX), so no pull */
+		pins = "gpio40";
+		drive-strength = <2>;
+		bias-disable;
 		output-high;
 	};
 
+	pinconf-rx {
+		/*
+		 * Configure a pull-up on 41 (RX). This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module is
+		 * in tri-state (module powered off or not driving the
+		 * signal yet).
+		 */
+		pins = "gpio41";
+		bias-pull-up;
+	};
+};
+
+&qup_uart3_sleep {
+	pinconf-cts {
+		/* Configure no-pull on 38 (CTS) to match Bluetooth module */
+		pins = "gpio38";
+		bias-disable;
+	};
+
 	pinconf-rts {
-		/* We'll drive 39 (RTS), so no pull */
+		/* We'll drive 39 (RTS), so configure pull-down */
 		pins = "gpio39";
 		drive-strength = <2>;
-		bias-disable;
+		bias-pull-down;
 	};
 
 	pinconf-tx {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

