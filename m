Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DAC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5487620857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TyGAs5sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgDQO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:26:40 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45701 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbgDQO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:26:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587133598; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=CMTAciZ1CDkXatEHtEmVAWxJhkhwS/4RbxCzudGRMx8=; b=TyGAs5sU85Hv5qqD+lcUHeg/8PF1xd80mlCPPA6DFoPpxR+KZxz8Je2DlSam35yyEash+WlH
 KeuebM3MkcEvV0GMlIfiVmoxuDFPBpH5ElfyyYYOQC5R3/kXQgK5eivUTJpPC5mk7YiXEjpM
 NPxxQjMpeV062kB7pJ55P4Dcc5s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99bc90.7fe8837f05e0-smtp-out-n01;
 Fri, 17 Apr 2020 14:26:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F78AC43636; Fri, 17 Apr 2020 14:26:23 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8981FC433F2;
        Fri, 17 Apr 2020 14:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8981FC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        ohad@wizery.com, mka@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/5] Add PAS and MSA based Modem support
Date:   Fri, 17 Apr 2020 19:56:00 +0530
Message-Id: <20200417142605.28885-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PAS based modem support on SC7180 SoCs and update the device node to
support MSA based modem boot.

Patch [1,2] - Add PAS based modem support
Patch [3] - Update reserved memory map
Patch [4,5] - Add PAS/MSA modem nodes

Sibi Sankar (5):
  dt-bindings: remoteproc: qcom: Add SC7180 MPSS support
  remoteproc: qcom: pas: Add SC7180 Modem support
  arm64: dts: qcom: sc7180: Update reserved memory map
  arm64: dts: qcom: sc7180: Add Q6V5 MSS node
  arm64: dts: qcom: sc7180: Update Q6V5 MSS node

 .../bindings/remoteproc/qcom,adsp.txt         |   3 +
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 105 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 124 +++++++++++++++++-
 drivers/remoteproc/qcom_q6v5_pas.c            |   1 +
 4 files changed, 231 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
