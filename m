Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E550C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67569207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dP3qzIaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgG3Itv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:49:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29066 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbgG3Its (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:49:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596098988; h=Message-Id: Date: Subject: To: From: Sender;
 bh=Xk8V0azahZORFwnETI/qGSyFHpcvit5iXH/UpbB+ZLk=; b=dP3qzIaBNxNLNMP7uz1BIiWVVFwmvApKk1cH6/tMuPAy/Chvi5PiRZjP9PgZ0J9GhOAEqEZV
 uCda8+zLlh+K+VfNLCd1YnPv6F8+gGdLt/rJEgJ0eJNljJjclukFSfY7fB7pKoRdGeIRGcql
 YsYMR/lhdO7+8puty4B/4sRxxHU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f2289a198acebb4e989ec19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 08:49:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87E77C43391; Thu, 30 Jul 2020 08:49:37 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BE51C433C9;
        Thu, 30 Jul 2020 08:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BE51C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, sivaprak@codeaurora.org,
        kathirav@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Enable DVFS support for IPQ6018
Date:   Thu, 30 Jul 2020 14:19:21 +0530
Message-Id: <1596098964-19878-1-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add A53 PLL, APCS clock, RPM Glink, RPM message RAM, cpu-opp-table,
SMPA2 regulator to enable the cpu frequency on IPQ6018.

Kathiravan T (3):
  dt-bindings: mailbox: add compatible for the IPQ6018 SoC
  dt-bindings: regulator: add the sub node names for the MP5496 PMIC
  arm64: dts: ipq6018: enable DVFS support

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  1 +
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |  2 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 96 +++++++++++++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

