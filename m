Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FDF20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rfHNya/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbgFWBFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:05:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:49855 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732496AbgFWBFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:05:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592874319; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=l7HyIkJnxBsinObpa2Z9vSuHV/rwoV3wrn30vlRTkoE=; b=rfHNya/jx3SeiQEABqZsikrXYO8pDyYLwvHEMiC8eJAR2ji63cE4m7wRtGdpDBgVD1IdD2LH
 hjIbPSOhqSyUzazh6B2Opi3FcdEtzSBSE1H3vyuCfbMGSILwEENSSTIJR7442bQ2J+6+wZXx
 L7g3hSWpORXVfhL61eT/0DF1kY4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ef1553ee144dd5115acc32f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 01:05:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E50BAC433CB; Tue, 23 Jun 2020 01:05:01 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E32AFC43391;
        Tue, 23 Jun 2020 01:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E32AFC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org, elder@ieee.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v5 2/2] remoteproc: qcom: Add notification types to SSR
Date:   Mon, 22 Jun 2020 18:04:31 -0700
Message-Id: <1592874271-26697-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
References: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
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
index 658f2ca..0848bf1 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -262,6 +262,44 @@ int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
+static int ssr_notify_prepare(struct rproc_subdev *subdev)
+{
+	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct qcom_ssr_notif_data data = {
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
+	struct qcom_ssr_notif_data data = {
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
+	struct qcom_ssr_notif_data data = {
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
@@ -270,7 +308,8 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
-	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
+	srcu_notifier_call_chain(&ssr->info->notifier_list,
+				 QCOM_SSR_AFTER_SHUTDOWN, &data);
 }
 
 /**
@@ -294,6 +333,9 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 	}
 
 	ssr->info = info;
+	ssr->subdev.prepare = ssr_notify_prepare;
+	ssr->subdev.start = ssr_notify_start;
+	ssr->subdev.stop = ssr_notify_stop;
 	ssr->subdev.unprepare = ssr_notify_unprepare;
 
 	rproc_add_subdev(rproc, &ssr->subdev);
diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
index 58422b1..83ac8e8 100644
--- a/include/linux/remoteproc/qcom_rproc.h
+++ b/include/linux/remoteproc/qcom_rproc.h
@@ -5,6 +5,22 @@ struct notifier_block;
 
 #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
 
+/**
+ * enum qcom_ssr_notif_type - Startup/Shutdown events related to a remoteproc
+ * processor.
+ *
+ * @QCOM_SSR_BEFORE_POWERUP:	Remoteproc about to start (prepare stage)
+ * @QCOM_SSR_AFTER_POWERUP:	Remoteproc is running (start stage)
+ * @QCOM_SSR_BEFORE_SHUTDOWN:	Remoteproc crashed or shutting down (stop stage)
+ * @QCOM_SSR_AFTER_SHUTDOWN:	Remoteproc is down (unprepare stage)
+ */
+enum qcom_ssr_notif_type {
+	QCOM_SSR_BEFORE_POWERUP,
+	QCOM_SSR_AFTER_POWERUP,
+	QCOM_SSR_BEFORE_SHUTDOWN,
+	QCOM_SSR_AFTER_SHUTDOWN,
+};
+
 struct qcom_ssr_notif_data {
 	const char *name;
 	bool crashed;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

