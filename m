Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B0C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED24722B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZlJQCOuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGTHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:07:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21664 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgGTHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:07:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595228868; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=r2oI1pl/idUO1QLdPIYXEQVPdb7/t8I9LlHR4yGeeMc=; b=ZlJQCOuQ6L0B3BX/ZpOejKXN2ybSvd5KtU+l6Y+nEcMR19+24+FuzmFuMWkvm9pRmIXu61Ia
 q2jzyOs1tL/kP/EDb1eNrHkWUG9xRfGqKqsZfyBwzjLeKfPCgwPDj6hjjJOrDuia0z2knvqj
 ge1+ZU1SnMChCGjjFxVsPhwU+4c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f1542be1012768490538f59 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 07:07:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB283C433CB; Mon, 20 Jul 2020 07:07:41 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A05A2C433C6;
        Mon, 20 Jul 2020 07:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A05A2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     stanimir.varbanov@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 0/4] DVFS support for Venus
Date:   Mon, 20 Jul 2020 12:37:18 +0530
Message-Id: <1595228842-9826-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Renamed the optional power domain as cx

v2: Fixed up the labels of OPP nodes in patch 4
    Included the bindings update patch as part of this series,
    a resend of https://lore.kernel.org/patchwork/patch/1241077/

These patches add DVFS support for Venus

Patch 1 will need to be picked by Rob.
Patch 2 will need to be picked by Stan,
Patch 3 and 4 should land via the qcom tree.

Rajendra Nayak (4):
  dt-bindings: media: venus: Add an optional power domain for perf
    voting
  media: venus: core: Add support for opp tables/perf voting
  arm64: dts: sdm845: Add OPP tables and power-domains for venus
  arm64: dts: sc7180: Add OPP tables and power-domains for venus

 .../bindings/media/qcom,sc7180-venus.yaml          |  6 ++-
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |  6 ++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 35 +++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 +++++++++++++++-
 drivers/media/platform/qcom/venus/core.c           | 43 ++++++++++++++---
 drivers/media/platform/qcom/venus/core.h           |  5 ++
 drivers/media/platform/qcom/venus/pm_helpers.c     | 54 ++++++++++++++++++++--
 7 files changed, 173 insertions(+), 16 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

