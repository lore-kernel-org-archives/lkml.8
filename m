Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4052078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mi1NLbsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIAOgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:36:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28018 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbgIAOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:20:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598970058; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hVBikNs7XDrVNGsdyCS7qGWenwga/b9zJ4BT0UQd/Tk=; b=mi1NLbsUwo81mnwwer1yVncvddvXd5hZqscsAoFrjV0v6LE0loihCPJZ5HIwlbiMStiDvNTC
 BDRdMyuDkm8XQVZtT4HJLdGD9WMyqaQotPUIlFXJFSgCQXLAxq8aYfcNjYaWwbtjz6dm7S7z
 yRptYV2GqDuf4TT3hn5nwxcRKGE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f4e58bc54e87432be4770b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 14:20:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5427DC433C9; Tue,  1 Sep 2020 14:20:43 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3F44C433C9;
        Tue,  1 Sep 2020 14:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3F44C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     stanimir.varbanov@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 0/5] DVFS support for Venus
Date:   Tue,  1 Sep 2020 19:50:21 +0530
Message-Id: <1598970026-7199-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, can you pick PATCH 1 since its already reviewed by you.
Stan, Patch 2 and 3 will need to be picked by you and they both have your ACKs
Patch 4 and 5 will need to be merged via the qcom tree once we have them reviewed.

v6: No changes, rebased on 5.9-rc3

v5: Fixed the opp-tables (patch 4/5) to avoid -ERANGE from
dev_pm_opp_set_rate

v4: Moved code from probe/remove/runtime_suspend into
different pm_ops callbacks

v3: Renamed the optional power domain as cx

v2: Fixed up the labels of OPP nodes in patch 4
    Included the bindings update patch as part of this series,
    a resend of https://lore.kernel.org/patchwork/patch/1241077/

These patches add DVFS support for Venus

Rajendra Nayak (5):
  dt-bindings: media: venus: Add an optional power domain for perf
    voting
  media: venus: core: Fix error handling in probe
  media: venus: core: Add support for opp tables/perf voting
  arm64: dts: sdm845: Add OPP tables and power-domains for venus
  arm64: dts: sc7180: Add OPP tables and power-domains for venus

 .../bindings/media/qcom,sc7180-venus.yaml          |  6 +-
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |  6 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 35 +++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 +++++++++-
 drivers/media/platform/qcom/venus/core.c           | 17 ++--
 drivers/media/platform/qcom/venus/core.h           |  5 ++
 drivers/media/platform/qcom/venus/pm_helpers.c     | 92 ++++++++++++++++++++--
 7 files changed, 183 insertions(+), 18 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

