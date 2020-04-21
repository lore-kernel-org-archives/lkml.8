Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24251C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DE7206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="j67Welv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgDUOcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:32:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47376 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728819AbgDUOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:32:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587479565; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=1Oeoo/cM1X75NsGv7SmWr0CfrczaffnNNsKkmbOOmj8=; b=j67Welv461ZewE4I3QHZTVFbARHfEgzrxQGOzmN3jmePKFufVcn+g/0Aav+ke6hasUsSral8
 C8CZNOO33G35UyEUt2GmbZHKJCJdeBZ0fiDThrF3LrckTsWEAZyOaVjNPNtrcg+tOKegCMyX
 TMXiY33gagMaucr+vZhAyw44tQU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f040c.7f147a95cc00-smtp-out-n04;
 Tue, 21 Apr 2020 14:32:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF4CCC433CB; Tue, 21 Apr 2020 14:32:42 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFBFDC433D2;
        Tue, 21 Apr 2020 14:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFBFDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, ohad@wizery.com, mka@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/7] Add PAS and MSA based Modem support
Date:   Tue, 21 Apr 2020 20:02:21 +0530
Message-Id: <20200421143228.8981-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PAS based modem support on SC7180 SoCs and update the device node to
support MSA based modem boot.

V2:
 * use memory-region to reference mba/mpss regions [Bjorn]
 * move peripheral memory regions to the board dts [Bjorn]
 * overload the base remoteproc_mpss node wherever possible [Bjorn]
 * Pick up Bjorn's R-b

Patch [1,2] - Add PAS based modem support
Patch [3,4] - use memory-region to reference mba/mpss regions
Patch [5] - Update reserved memory map
Patch [6,7] - Add PAS/MSA modem nodes

Sibi Sankar (7):
  dt-bindings: remoteproc: qcom: Add SC7180 MPSS support
  remoteproc: qcom: pas: Add SC7180 Modem support
  dt-bindings: remoteproc: qcom: Use memory-region to reference memory
  remoteproc: qcom_q6v5_mss: Extract mba/mpss from memory-region
  arm64: dts: qcom: sc7180: Update reserved memory map
  arm64: dts: qcom: sc7180: Add Q6V5 MSS node
  arm64: dts: qcom: sc7180: Update Q6V5 MSS node

 .../bindings/remoteproc/qcom,adsp.txt         |  3 +
 .../bindings/remoteproc/qcom,q6v5.txt         |  8 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 60 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 89 ++++++++++++++++++-
 drivers/remoteproc/qcom_q6v5_mss.c            | 21 ++++-
 drivers/remoteproc/qcom_q6v5_pas.c            |  1 +
 6 files changed, 177 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
