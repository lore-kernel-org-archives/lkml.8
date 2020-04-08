Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45ACC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC31020757
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RmZS3urD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDHXhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:37:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61124 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbgDHXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:37:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586389026; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=sd4ovfJpZhdxAUPqCMdrQUjnd3KMRkpIg+xta7RYHBA=; b=RmZS3urDL1VVyRelzBzc8IPbXsnBxT2qPWm1/geulfEje3LQrcbRmWAlzH4CPfoIIYEmf6zP
 Vmena2mrsj05BQY4e7WSJ6NBYtz27rQbnWPlV9s2Rix55sYUXEcG5g/+lvxkfiSD1jrO3Ytq
 uj40c41RqekAxX8x4IsOMv+JaeY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8e601e.7f618e0b6ca8-smtp-out-n05;
 Wed, 08 Apr 2020 23:37:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8A63C43636; Wed,  8 Apr 2020 23:37:02 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B99AC43637;
        Wed,  8 Apr 2020 23:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B99AC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH v2 2/6] remoteproc: sysmon: Add notifications for events
Date:   Wed,  8 Apr 2020 16:36:39 -0700
Message-Id: <1586389003-26675-3-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
References: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add notification for other stages of remoteproc boot and shutdown. This
includes adding callback functions for the prepare and unprepare events,
and fleshing out the callback function for start.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/qcom_sysmon.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 1366050..851664e 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -439,8 +439,31 @@ static const struct qmi_ops ssctl_ops = {
 	.del_server = ssctl_del_server,
 };
 
+static int sysmon_prepare(struct rproc_subdev *subdev)
+{
+	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
+						  subdev);
+	struct sysmon_event event = {
+		.subsys_name = sysmon->name,
+		.ssr_event = SSCTL_SSR_EVENT_BEFORE_POWERUP
+	};
+
+	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+
+	return 0;
+}
+
 static int sysmon_start(struct rproc_subdev *subdev)
 {
+	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
+						  subdev);
+	struct sysmon_event event = {
+		.subsys_name = sysmon->name,
+		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
+	};
+
+	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+
 	return 0;
 }
 
@@ -464,6 +487,18 @@ static void sysmon_stop(struct rproc_subdev *subdev, bool crashed)
 		sysmon_request_shutdown(sysmon);
 }
 
+static void sysmon_unprepare(struct rproc_subdev *subdev)
+{
+	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
+						  subdev);
+	struct sysmon_event event = {
+		.subsys_name = sysmon->name,
+		.ssr_event = SSCTL_SSR_EVENT_AFTER_SHUTDOWN
+	};
+
+	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
+}
+
 /**
  * sysmon_notify() - notify sysmon target of another's SSR
  * @nb:		notifier_block associated with sysmon instance
@@ -563,8 +598,10 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 
 	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
 
+	sysmon->subdev.prepare = sysmon_prepare;
 	sysmon->subdev.start = sysmon_start;
 	sysmon->subdev.stop = sysmon_stop;
+	sysmon->subdev.unprepare = sysmon_unprepare;
 
 	rproc_add_subdev(rproc, &sysmon->subdev);
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
