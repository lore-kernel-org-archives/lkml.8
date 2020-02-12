Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B5C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ej8vpRnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgBLK4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:56:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39387 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgBLK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:56:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581504999; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lK9PFYk/scyg7TDWLnox0Xo/iQOLjUX1Z2HtBw6jrpI=; b=Ej8vpRnYtH6fh1fbQeQ07+2QWuCJ2NTCMQXy2GWEj7b7tgoBTMFjMvYqAjkFiaWDRFcsVD9E
 6ngyPvWA+5s2EZpr/K4wLY0dvOzf+fm3Z0E/KTk4ywSeKskncw86dkhYahX6dRYAu3Ww2L6E
 M1a2sYXLqfjL6VuO1iAbh82dwBY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e43d9e6.7efb943c91f0-smtp-out-n02;
 Wed, 12 Feb 2020 10:56:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74597C4479F; Wed, 12 Feb 2020 10:56:37 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 522FDC43383;
        Wed, 12 Feb 2020 10:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 522FDC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 0/2] Output debug information from RSC
Date:   Wed, 12 Feb 2020 16:26:10 +0530
Message-Id: <1581504972-22632-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we get only warning for timeouts. There is no
information available on what is leading to timeouts.

This series add changes to print debug information for TCSes
which are currently in use, commands in the TCSes and its status.
Also include interrupt pending status at GIC and completion status.

Lina Iyer (1):
  soc: qcom: rpmh-rsc: Log interrupt status when TCS is busy

Raju P.L.S.S.S.N (1):
  soc: qcom: rpmh-rsc: Output debug information from RSC

 drivers/soc/qcom/rpmh-internal.h |   3 +
 drivers/soc/qcom/rpmh-rsc.c      | 125 ++++++++++++++++++++++++++++++++++++++-
 drivers/soc/qcom/rpmh.c          |  11 +++-
 3 files changed, 134 insertions(+), 5 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
