Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF380C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD54220870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DNwz16Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgGCJoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:44:37 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37982 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbgGCJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:44:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593769476; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4zLWTAsDZFRd2CjR56Sq7oA8+zNn95BI2DMylIeR/fo=; b=DNwz16NhaSuh8ERNcZJCi0LGemGdVly/Di1AyX/5O/y6DQQx/a9DH0MokuFUCKcZ6ogVXs1i
 VXXC5AsRQb9t03TZ44cMZUdT/jzX7eyFQlFJu9o6AhDvfH2QvlLMBeEavHyhkcZIJKQjIJhY
 syCWypPLx0wWNqmxrkEkTNmtN40=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5efefe02c4bb4f886d33e79a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 09:44:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3630C433A0; Fri,  3 Jul 2020 09:44:33 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB0A7C433CB;
        Fri,  3 Jul 2020 09:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB0A7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/3] QSPI: Add DVFS support
Date:   Fri,  3 Jul 2020 15:11:30 +0530
Message-Id: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This patchset adds support for QSPI DVFS, and adds device tree
changes for sdm845 and sc7180 SoC's.
Though this patchset has no other dependency, it would result
in a merge conflict with changes already in qcom for-next,
if pulled into another tree for 5.9.
Hence requesting you to take these changes via the qcom tree
for 5.9. The qspi driver changes are already ACK'ed by Mark.

thanks,
Rajendra

Rajendra Nayak (3):
  spi: spi-qcom-qspi: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add qspi opps and power-domains
  arm64: dts: sc7180: Add qspi opps and power-domains

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
 drivers/spi/spi-qcom-qspi.c          | 28 +++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

