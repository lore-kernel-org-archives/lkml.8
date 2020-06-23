Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E4D2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Yq43X0n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgFWBFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:05:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:49147 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731820AbgFWBFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:05:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592874321; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=uz0dphFHv5gXxX27iBEVAusWSb4Wag9GpadQ1BZnNP4=; b=Yq43X0n5dV8ki66w0DXezUmHuZ1reQx9zTjiRD4uh+MZsrXtAT5fnkWq6yw3um++iXrqQ+gZ
 vT5skmmLaRJl+OI+lf4qg8xIhaQwLilDIGOKDcChOX8qCW6dwRonRUfG5t2QP3g2yrZKYEz4
 SdsqCkVv4xrsUx/EBAl2emYI7PY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ef1553d5866879c7602e90c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 01:05:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8F71C4339C; Tue, 23 Jun 2020 01:05:01 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 678ADC433C8;
        Tue, 23 Jun 2020 01:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 678ADC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org, elder@ieee.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v5 1/2] remoteproc: qcom: Add per subsystem SSR notification
Date:   Mon, 22 Jun 2020 18:04:30 -0700
Message-Id: <1592874271-26697-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
References: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a single notification chain which is called whenever any
remoteproc shuts down. This leads to all the listeners being notified, and
is not an optimal design as kernel drivers might only be interested in
listening to notifications from a particular remoteproc. Create a global
list of remoteproc notification info data structures. This will hold the
name and notifier_list information for a particular remoteproc. The API
to register for notifications will use name argument to retrieve the
notification info data structure and the notifier block will be added to
that data structure's notification chain. Also move from blocking notifier
to srcu notifer based implementation to support dynamic notifier head
creation.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/qcom_common.c      | 86 +++++++++++++++++++++++++++++------
 drivers/remoteproc/qcom_common.h      |  5 +-
 include/linux/remoteproc/qcom_rproc.h | 20 ++++++--
 3 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 9028cea..658f2ca 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/remoteproc.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include <linux/rpmsg/qcom_glink.h>
 #include <linux/rpmsg/qcom_smd.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -23,7 +24,14 @@
 #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 
-static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
+struct qcom_ssr_subsystem {
+	const char *name;
+	struct srcu_notifier_head notifier_list;
+	struct list_head list;
+};
+
+static LIST_HEAD(qcom_ssr_subsystem_list);
+static DEFINE_MUTEX(qcom_ssr_subsys_lock);
 
 static int glink_subdev_start(struct rproc_subdev *subdev)
 {
@@ -189,37 +197,80 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
 }
 EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
 
+static struct qcom_ssr_subsystem *qcom_ssr_get_subsys(const char *name)
+{
+	struct qcom_ssr_subsystem *info;
+
+	mutex_lock(&qcom_ssr_subsys_lock);
+	/* Match in the global qcom_ssr_subsystem_list with name */
+	list_for_each_entry(info, &qcom_ssr_subsystem_list, list)
+		if (!strcmp(info->name, name))
+			return info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+	info->name = kstrdup_const(name, GFP_KERNEL);
+	srcu_init_notifier_head(&info->notifier_list);
+
+	/* Add to global notification list */
+	list_add_tail(&info->list, &qcom_ssr_subsystem_list);
+	mutex_unlock(&qcom_ssr_subsys_lock);
+
+	return info;
+}
+
 /**
  * qcom_register_ssr_notifier() - register SSR notification handler
- * @nb:		notifier_block to notify for restart notifications
+ * @name:	Subsystem's SSR name
+ * @nb:		notifier_block to be invoked upon subsystem's state change
  *
- * Returns 0 on success, negative errno on failure.
+ * This registers the @nb notifier block as part the notifier chain for a
+ * remoteproc associated with @name. The notifier block's callback
+ * will be invoked when the remote processor's SSR events occur
+ * (pre/post startup and pre/post shutdown).
  *
- * This register the @notify function as handler for restart notifications. As
- * remote processors are stopped this function will be called, with the SSR
- * name passed as a parameter.
+ * Return: a subsystem cookie on success, ERR_PTR on failure.
  */
-int qcom_register_ssr_notifier(struct notifier_block *nb)
+void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&ssr_notifiers, nb);
+	struct qcom_ssr_subsystem *info;
+
+	info = qcom_ssr_get_subsys(name);
+	if (IS_ERR(info))
+		return info;
+
+	srcu_notifier_chain_register(&info->notifier_list, nb);
+
+	return &info->notifier_list;
 }
 EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
 
 /**
  * qcom_unregister_ssr_notifier() - unregister SSR notification handler
+ * @notify:	subsystem coookie returned from qcom_register_ssr_notifier
  * @nb:		notifier_block to unregister
+ *
+ * This function will unregister the notifier from the particular notifier
+ * chain.
+ *
+ * Return: 0 on success, %ENOENT otherwise.
  */
-void qcom_unregister_ssr_notifier(struct notifier_block *nb)
+int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&ssr_notifiers, nb);
+	return srcu_notifier_chain_unregister(notify, nb);
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
 static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct qcom_ssr_notif_data data = {
+		.name = ssr->info->name,
+		.crashed = false,
+	};
 
-	blocking_notifier_call_chain(&ssr_notifiers, 0, (void *)ssr->name);
+	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
 }
 
 /**
@@ -229,12 +280,20 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
  * @ssr_name:	identifier to use for notifications originating from @rproc
  *
  * As the @ssr is registered with the @rproc SSR events will be sent to all
- * registered listeners in the system as the remoteproc is shut down.
+ * registered listeners for the particular remoteproc when it is shutdown.
  */
 void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 			 const char *ssr_name)
 {
-	ssr->name = ssr_name;
+	struct qcom_ssr_subsystem *info;
+
+	info = qcom_ssr_get_subsys(ssr_name);
+	if (IS_ERR(info)) {
+		dev_err(&rproc->dev, "Failed to add ssr subdevice\n");
+		return;
+	}
+
+	ssr->info = info;
 	ssr->subdev.unprepare = ssr_notify_unprepare;
 
 	rproc_add_subdev(rproc, &ssr->subdev);
@@ -249,6 +308,7 @@ EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
 void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
 {
 	rproc_remove_subdev(rproc, &ssr->subdev);
+	ssr->info = NULL;
 }
 EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
 
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index 34e5188..dfc641c 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -26,10 +26,11 @@ struct qcom_rproc_subdev {
 	struct qcom_smd_edge *edge;
 };
 
+struct qcom_ssr_subsystem;
+
 struct qcom_rproc_ssr {
 	struct rproc_subdev subdev;
-
-	const char *name;
+	struct qcom_ssr_subsystem *info;
 };
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
index fa8e386..58422b1 100644
--- a/include/linux/remoteproc/qcom_rproc.h
+++ b/include/linux/remoteproc/qcom_rproc.h
@@ -5,17 +5,27 @@ struct notifier_block;
 
 #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
 
-int qcom_register_ssr_notifier(struct notifier_block *nb);
-void qcom_unregister_ssr_notifier(struct notifier_block *nb);
+struct qcom_ssr_notif_data {
+	const char *name;
+	bool crashed;
+};
+
+void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb);
+int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb);
 
 #else
 
-static inline int qcom_register_ssr_notifier(struct notifier_block *nb)
+static inline void *qcom_register_ssr_notifier(const char *name,
+					       struct notifier_block *nb)
 {
-	return 0;
+	return NULL;
 }
 
-static inline void qcom_unregister_ssr_notifier(struct notifier_block *nb) {}
+static inline int qcom_unregister_ssr_notifier(void *notify,
+					       struct notifier_block *nb)
+{
+	return 0;
+}
 
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

