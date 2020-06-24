Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE66C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032CF20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BKYvQqVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgFXCZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:25:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35027 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbgFXCZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:25:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592965524; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yKqRxzK5CgSW8RmcYWIU6RCr/r6LK8FTWdS99NGEJHw=; b=BKYvQqVY/2i7VuwvrWhc/CWvFdPO9n4lnNhqZ6KYPpquf8/p7FkvlfLlIp3edgoDrumMQUs9
 Pnji+ZGsj9eSbsQzy+O91VSxJgCePy8Jxp3Ixwad3i+kTPMJoLtWHbGBNhP2CrlXiADItrvp
 +fW2svB3D7SJrsagFGhMibOHaA8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5ef2b980117610c7ff5431fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 02:25:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B63D8C433C6; Wed, 24 Jun 2020 02:25:04 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77B97C43395;
        Wed, 24 Jun 2020 02:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77B97C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org, elder@ieee.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v6 2/2] remoteproc: qcom: Add notification types to SSR
Date:   Tue, 23 Jun 2020 19:23:28 -0700
Message-Id: <1592965408-16908-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592965408-16908-1-git-send-email-rishabhb@codeaurora.org>
References: <1592965408-16908-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSR subdevice only adds callback for the unprepare event. Add callbacks
for prepare, start and prepare events. The client driver for a particular
remoteproc might be interested in knowing the status of the remoteproc
while undergoing SSR, not just when the remoteproc has finished shutting
down.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/qcom_common.c      | 44 ++++++++++++++++++++++++++++++++++-
 include/linux/remoteproc/qcom_rproc.h | 16 +++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 7a7384c..7ec4597 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -265,6 +265,44 @@ int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
+static int ssr_notify_prepare(struct rproc_subdev *subdev)
+{
+	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct qcom_ssr_notify_data data = {
+		.name = ssr->info->name,
+		.crashed = false,
+	};
+
+	srcu_notifier_call_chain(&ssr->info->notifier_list,
+				 QCOM_SSR_BEFORE_POWERUP, &data);
+	return 0;
+}
+
+static int ssr_notify_start(struct rproc_subdev *subdev)
+{
+	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct qcom_ssr_notify_data data = {
+		.name = ssr->info->name,
+		.crashed = false,
+	};
+
+	srcu_notifier_call_chain(&ssr->info->notifier_list,
+				 QCOM_SSR_AFTER_POWERUP, &data);
+	return 0;
+}
+
+static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct qcom_ssr_notify_data data = {
+		.name = ssr->info->name,
+		.crashed = crashed,
+	};
+
+	srcu_notifier_call_chain(&ssr->info->notifier_list,
+				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
+}
+
 static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
@@ -273,7 +311,8 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
-	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
+	srcu_notifier_call_chain(&ssr->info->notifier_list,
+				 QCOM_SSR_AFTER_SHUTDOWN, &data);
 }
 
 /**
@@ -298,6 +337,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 	}
 
 	ssr->info = info;
+	ssr->subdev.prepare = ssr_notify_prepare;
+	ssr->subdev.start = ssr_notify_start;
+	ssr->subdev.stop = ssr_notify_stop;
 	ssr->subdev.unprepare = ssr_notify_unprepare;
 
 	rproc_add_subdev(rproc, &ssr->subdev);
diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
index 2a1d6d0..6470516 100644
--- a/include/linux/remoteproc/qcom_rproc.h
+++ b/include/linux/remoteproc/qcom_rproc.h
@@ -5,6 +5,22 @@ struct notifier_block;
 
 #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
 
+/**
+ * enum qcom_ssr_notify_type - Startup/Shutdown events related to a remoteproc
+ * processor.
+ *
+ * @QCOM_SSR_BEFORE_POWERUP:	Remoteproc about to start (prepare stage)
+ * @QCOM_SSR_AFTER_POWERUP:	Remoteproc is running (start stage)
+ * @QCOM_SSR_BEFORE_SHUTDOWN:	Remoteproc crashed or shutting down (stop stage)
+ * @QCOM_SSR_AFTER_SHUTDOWN:	Remoteproc is down (unprepare stage)
+ */
+enum qcom_ssr_notify_type {
+	QCOM_SSR_BEFORE_POWERUP,
+	QCOM_SSR_AFTER_POWERUP,
+	QCOM_SSR_BEFORE_SHUTDOWN,
+	QCOM_SSR_AFTER_SHUTDOWN,
+};
+
 struct qcom_ssr_notify_data {
 	const char *name;
 	bool crashed;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

