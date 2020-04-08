Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570BFC2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C74120757
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WYFZu/7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDHXhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:37:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44145 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgDHXhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:37:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586389032; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CKqAD+S3Af/npJ/Tpw6OWygjoWc1na7g3PguX7Jr2Ng=; b=WYFZu/7DniCSL0WIm2GTt6ZkRji6VisfhmPClJqtgACvKLcn54w4gFX8qLP6+8T5xSVo6Btj
 fptfwXlAlOoFu40Sfw+yWZfC/Pw34ozO2BXhfX51F5x+aSftXQ+9bpFqOx4hNEPkgFICrLar
 OWqlHZs+mP2XlYxcqVwD8zICEXU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8e601e.7f9554ffdb20-smtp-out-n03;
 Wed, 08 Apr 2020 23:37:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAA19C4478F; Wed,  8 Apr 2020 23:37:02 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9D20C44792;
        Wed,  8 Apr 2020 23:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9D20C44792
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH v2 3/6] remoteproc: sysmon: Inform current rproc about all active rprocs
Date:   Wed,  8 Apr 2020 16:36:40 -0700
Message-Id: <1586389003-26675-4-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
References: <1586389003-26675-1-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clients/services running on a remoteproc that booted up might need to be
aware of the state of already running remoteprocs. When a remoteproc boots
up (fresh or after recovery) it is not aware of the remoteprocs that booted
before it, i.e., the system state is incomplete. So to keep track of it we
send sysmon on behalf of all 'ONLINE' remoteprocs.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/qcom_sysmon.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 851664e..8d8996d 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -453,10 +453,20 @@ static int sysmon_prepare(struct rproc_subdev *subdev)
 	return 0;
 }
 
+/**
+ * sysmon_start() - start callback for the sysmon remoteproc subdevice
+ * @subdev:	instance of the sysmon subdevice
+ *
+ * Inform all the listners of sysmon notifications that the rproc associated
+ * to @subdev has booted up. The rproc that booted up also needs to know
+ * which rprocs are already up and running, so send start notifications
+ * on behalf of all the online rprocs.
+ */
 static int sysmon_start(struct rproc_subdev *subdev)
 {
 	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon,
 						  subdev);
+	struct qcom_sysmon *target;
 	struct sysmon_event event = {
 		.subsys_name = sysmon->name,
 		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
@@ -464,6 +474,21 @@ static int sysmon_start(struct rproc_subdev *subdev)
 
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
 
+	mutex_lock(&sysmon_lock);
+	list_for_each_entry(target, &sysmon_list, node) {
+		if (target == sysmon ||
+		    target->rproc->state != RPROC_RUNNING)
+			continue;
+
+		event.subsys_name = target->name;
+
+		if (sysmon->ssctl_version == 2)
+			ssctl_send_event(sysmon, &event);
+		else if (sysmon->ept)
+			sysmon_send_event(sysmon, &event);
+	}
+	mutex_unlock(&sysmon_lock);
+
 	return 0;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
