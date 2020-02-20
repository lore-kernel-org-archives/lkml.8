Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421FC11D02
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B00E24671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VXWavmUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBTC6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:58:05 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:19144 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbgBTC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:58:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582167482; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=maU3Pns7JRQnq6kS3D6USOvQxwO2Ev/vCO5JSfnzuSw=; b=VXWavmUjmGd9P95w33cJX+PB5tbwmzPd046PJTytTdfA5Zj8XR+C70gz13u5mzZh0rWl74/2
 6OSNwkxp9gKoBXjUVVVOfMA9PaOMFGzrsJuumNjydvIi+x5J+GPiRttEB6276nAc7cDF6A4E
 tUZ9gftS+9L3GgcFiMQVfSGlZfI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4df5b1.7fe9c18b85e0-smtp-out-n02;
 Thu, 20 Feb 2020 02:57:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A4FBC447A0; Thu, 20 Feb 2020 02:57:53 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55CF4C43383;
        Thu, 20 Feb 2020 02:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55CF4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH 0/6] remoteproc: qcom: Add callbacks for remoteproc events
Date:   Wed, 19 Feb 2020 18:57:39 -0800
Message-Id: <1582167465-2549-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the usecases for SSR and Sysmon subdevices which are
used by remoteprocs and kernel client drivers relying on those remoteprocs.

Patch 1-3 adds callbacks for prepare, start and unprepare events, and also type
          of sysmon notification.
Patch 4-6 adds a per subsystem notifier chain, callbacks for prepare, start
          and stop events for ssr subdevice.

Rishabh Bhatnagar (1):
  drivers: remoteproc: Add name field for every subdevice

Siddharth Gupta (5):
  remoteproc: sysmon: Add ability to send type of notification
  remoteproc: sysmon: Add notifications for events
  remoteproc: sysmon: Inform current rproc about all active rprocs
  remoteproc: qcom: Add per subsystem SSR notification
  remoteproc: qcom: Add notification types to SSR

 drivers/remoteproc/qcom_common.c      |  86 ++++++++++++++++++++++++----
 drivers/remoteproc/qcom_common.h      |   1 +
 drivers/remoteproc/qcom_sysmon.c      | 103 ++++++++++++++++++++++++++++------
 drivers/soc/qcom/glink_ssr.c          |  20 ++++++-
 include/linux/remoteproc.h            |  17 ++++++
 include/linux/remoteproc/qcom_rproc.h |  17 ++++--
 6 files changed, 209 insertions(+), 35 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
