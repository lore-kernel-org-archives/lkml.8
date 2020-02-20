Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B9C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA5724670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="r/Yxe+YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBTCMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:12:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:16745 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgBTCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:12:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582164733; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=t15n6yBKLX2ibvF8ZHGW5Z7Dt9gbYeMrwtq2d0/Wg3w=; b=r/Yxe+YR4GyO4nxX3jhh/GcPMI0V+CCJ7nGDvDih4rCY/oIQaxaYfxxM3S8fPr6NRCRuFW9Y
 3RBgByAYpiHKb3hQLGxNee8K+wHSIfkNGdCM65Lulk407OeZ8m3t2I8rrIiBPUn11+0A5wnG
 hu+NUTytJEUOZ+dRmQPeMIhx6g0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4deaf3.7fc9a66a80a0-smtp-out-n02;
 Thu, 20 Feb 2020 02:12:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BC86C447A3; Thu, 20 Feb 2020 02:12:02 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5DE5C447A2;
        Thu, 20 Feb 2020 02:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5DE5C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH 2/2] remoteproc: core: Prevent sleep when rproc crashes
Date:   Wed, 19 Feb 2020 18:11:53 -0800
Message-Id: <1582164713-6413-3-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
References: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remoteproc recovery should be fast and any delay will have an impact on the
user-experience. Use power management APIs (pm_stay_awake and pm_relax) to
ensure that the system does not go to sleep.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5ab65a4..52e318c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1712,6 +1712,8 @@ static void rproc_crash_handler_work(struct work_struct *work)
 
 	if (!rproc->recovery_disabled)
 		rproc_trigger_recovery(rproc);
+
+	pm_relax(&rproc->dev);
 }
 
 /**
@@ -2242,6 +2244,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 		return;
 	}
 
+	pm_stay_awake(&rproc->dev);
+
 	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
 		rproc->name, rproc_crash_to_string(type));
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
