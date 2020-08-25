Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CF820715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FRemqu5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgHYLWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:22:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31104 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729985AbgHYLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:22:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598354525; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tSSVfiXd88xOCldtXCPlDzzLEK3G+8ztMfhhhwwpA+c=; b=FRemqu5qiN0t+CgKRwuUWe2s50ZvEU/zKpYu6HX5M9BeMWDCPNwRLzFCvwAF43znO7dupll6
 SNfHLzjXZn3SHSnOEwl6rQ/uRhR69DLYjUdQycA5JhtUIL+stwN0wIESLtvlxTzFfRjxHxCz
 d0eG6DMoP3a3G94+JApKDH2zdR0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f44f445e2d4d29fc8378e18 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 11:21:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F609C433CA; Tue, 25 Aug 2020 11:21:41 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C463BC433C6;
        Tue, 25 Aug 2020 11:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C463BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, swboyd@chromium.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v2 0/2] Modularize RPMH driver
Date:   Tue, 25 Aug 2020 16:51:20 +0530
Message-Id: <1598354482-15491-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Update commit message in patch 1
- send [4] again instead of revert's revert in patch 2.

This series is to modularize RPMH driver

The tracepoint in RPMH driver was changed to _rcuidle variant based on the
test results of unmerged series [1] where .power_off callback from genpd
reported RCU warnings. 

The series which finally got merged [2] uses CPU PM notifications
and genpd .power_off callback is not implemented in RPMH driver to invoke
rpmh_flush(). The CPU PM notifications are done with RCU non idle in kernel
(see cpu_pm_notify() uses rcu_irq_enter_irqson() before notifications)

However using _rcuidle variant prevented RPMH driver to compile as module
since these _rcuidle are not exported symbols for tracepoints.

This seris reverts the change [3] to remove _rcuidle variant for tracepoint
as its no more valid test case (genpd .power_off is not implemented)
and bring backs the change [4] that was reverted due to _rcuidle preventing
to become modular.

[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=243931
[2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=269733
[3] https://lore.kernel.org/r/20200115013751.249588-1-swboyd@chromium.org 
[4] https://lore.kernel.org/r/20200326224459.105170-3-john.stultz@linaro.org 

John Stultz (1):
  soc: qcom: rpmh: Allow RPMH driver to be loaded as a module

Maulik Shah (1):
  Revert "drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh"

 drivers/soc/qcom/Kconfig    | 2 +-
 drivers/soc/qcom/rpmh-rsc.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

