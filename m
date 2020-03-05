Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7789EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45420848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oT8MfrRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCERHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:07:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:48270 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgCERHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:07:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583428034; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4BQCqiSyVLAnY7G9z7oQROVsitnkw15NXXmoIHztfNA=; b=oT8MfrRMXr4rhjpFcJJBx/89FwfDns/hWe7pz1s7xXVbs5tPwI26kutHv2+7ofI5zLiI2/0j
 4cy4aMKAIzRpxzMX6um7ZbQOdHpgXQtcyHQz65ll+tdKQ8UQ4vwaq34XvUL2t17vpeWYtBbK
 tf/XpV9mDk5stV+nCAhC3VjLing=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6131c1.7fb0826e8ca8-smtp-out-n01;
 Thu, 05 Mar 2020 17:07:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39390C4479C; Thu,  5 Mar 2020 17:07:13 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01BE7C433A2;
        Thu,  5 Mar 2020 17:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01BE7C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v12 0/4] Invoke rpmh_flush for non OSI targets
Date:   Thu,  5 Mar 2020 22:36:59 +0530
Message-Id: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v12:
- Kconfig change to remove COMPILE_TEST was dropped in v11, reinclude it.

Changes in v11:
- Address Doug's comments on change 2 and 3
- Include change to invalidate TCSes before flush from [4]

Changes in v10:
- Address Evan's comments to update commit message on change 2
- Add Evan's Reviewed by on change 2
- Remove comment from rpmh_flush() related to last CPU invoking it
- Rebase all changes on top of next-20200302

Changes in v9:
- Keep rpmh_flush() to invoke from within cache_lock
- Remove comments related to only last cpu invoking rpmh_flush()

Changes in v8:
- Address Stephen's comments on changes 2 and 3
- Add Reviewed by from Stephen on change 1

Changes in v7:
- Address Srinivas's comments to update commit text
- Add Reviewed by from Srinivas

Changes in v6:
- Drop 1 & 2 changes from v5 as they already landed in maintainer tree
- Drop 3 & 4 changes from v5 as no user at present for power domain in rsc
- Rename subject to appropriate since power domain changes are dropped
- Rebase other changes on top of next-20200221

Changes in v5:
- Add Rob's Acked by on dt-bindings change
- Drop firmware psci change
- Update cpuidle stats in dtsi to follow PC mode
- Include change to update dirty flag when data is updated from [4]
- Add change to invoke rpmh_flush when caches are dirty

Changes in v4:
- Add change to allow hierarchical topology in PC mode
- Drop hierarchical domain idle states converter from v3
- Address Merge sc7180 dtsi change to add low power modes

Changes in v3:
- Address Rob's comment on dt property value
- Address Stephen's comments on rpmh-rsc driver change
- Include sc7180 cpuidle low power mode changes from [1]
- Include hierarchical domain idle states converter change from [2]

Changes in v2:
- Add Stephen's Reviewed-By to the first three patches
- Addressed Stephen's comments on fourth patch
- Include changes to connect rpmh domain to cpuidle and genpds

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based
on Ulf Hansoon's patch series[3], when the cluster of CPUs enter deepest
idle states. As a part of domain poweroff, RSC can lower resource state
requirements by flushing the cached sleep and wake state votes for various
resources.

[1] https://patchwork.kernel.org/patch/11218965
[2] https://patchwork.kernel.org/patch/10941671
[3] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=222355
[4] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=236503

Maulik Shah (3):
  arm64: dts: qcom: sc7180: Add cpuidle low power states
  soc: qcom: rpmh: Update dirty flag only when data changes
  soc: qcom: rpmh: Invoke rpmh_flush for dirty caches

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c              | 27 ++++++++++---
 2 files changed, 100 insertions(+), 5 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
