Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062B720842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="S3kPeSSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgBKMQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:16:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:40991 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgBKMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:16:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581423392; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=O4Uzm0kXYS5RWZJf/jv6Ip8Srev+mpFkK4pytBqAReM=; b=S3kPeSSsbtHpLhCjvXghNpEk6CFvpQIN1JLL1DAZq0x64vKRnwibvMgFAHKwnLZdTcUsFQ0z
 oG2LA9DStk/vkIaBJMPutyzyQzuKgUdX36JrVCn08o607t9DGW5Lm7kXOT/2XOQEC8eoCqWj
 gx9l0p98pNooM8sGCSD0HHeroFQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e429b17.7f533cb2a420-smtp-out-n03;
 Tue, 11 Feb 2020 12:16:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB549C447A2; Tue, 11 Feb 2020 12:16:23 +0000 (UTC)
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B739FC43383;
        Tue, 11 Feb 2020 12:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B739FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, agross@kernel.org, bjorn.andersson@linaro.org,
        hemantg@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com,
        gubbaven@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] arm64: dts: qcom: sc7180: Add node for bluetooth soc wcn3990
Date:   Tue, 11 Feb 2020 17:46:12 +0530
Message-Id: <20200211121612.29075-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for bluetooth soc wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 388f50ad4fde..19f82ddc1f09 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -19,6 +19,7 @@
 	aliases {
 		hsuart0 = &uart3;
 		serial0 = &uart8;
+		bluetooth0 = &bluetooth;
 	};
 
 	chosen {
@@ -256,6 +257,16 @@
 
 &uart3 {
 	status = "okay";
+	bluetooth: wcn3990-bt {
+		compatible = "qcom,wcn3990-bt";
+		vddio-supply = <&vreg_l10a_1p8>;
+		vddxo-supply = <&vreg_l1c_1p8>;
+		vddrf-supply = <&vreg_l2c_1p3>;
+		vddch0-supply = <&vreg_l10c_3p3>;
+		max-speed = <3200000>;
+		clocks = <&rpmhcc RPMH_RF_CLK2>;
+		status = "okay";
+	};
 };
 
 &uart8 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
