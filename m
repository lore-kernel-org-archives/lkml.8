Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F51C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723B3207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hBvriEWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgBUX22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:28:28 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:64982 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729100AbgBUX21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:28:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582327707; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qTXV8CL2DFBuSGQ2DYrUjFlxyMbEdqv6bY+3ktuK+pA=; b=hBvriEWwEILlQdWYMOffMm+xB9uYsslxDgpqtyLdrhoK2IxWModV7wwUnFToExBpotFDaGXv
 bzOjzjmcLJUKCMiFViGV3zrorNP6rY6j51aiHtY3i+Rc+Bagt+12Aeh5UOye8tyWqc75Hi/C
 xx9pBFQiNtkoQ2VoygsB8F0HVbE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e50678f.7fd75cde37d8-smtp-out-n01;
 Fri, 21 Feb 2020 23:28:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AD7AC447A3; Fri, 21 Feb 2020 23:28:14 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 678DAC447A5;
        Fri, 21 Feb 2020 23:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 678DAC447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250: Add vendor-specific PSCI system reset2 type
Date:   Fri, 21 Feb 2020 15:28:05 -0800
Message-Id: <1582327685-6316-4-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582327685-6316-1-git-send-email-eberman@codeaurora.org>
References: <1582327685-6316-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies, Inc. SoCs do not guarantee that an architectural
warm reset boots back into Linux kernel. For instance, if download mode
or reboot reason cookies are set, the SoC would do a warm reset into an
alternate exception level (e.g. a mode to collect RAM dumps) or
application at EL1 (e.g. fastboot mode). Thus, Qualcomm Technologies,
Inc. SoCs support a vendor-specific warm reset type that can be used in
all instances of warm/soft reboots.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f63df12..b85d234 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -162,6 +162,7 @@
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		arm,psci-sys-reset2-type = <0x80000000>;
 	};
 
 	reserved_memory: reserved-memory {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
