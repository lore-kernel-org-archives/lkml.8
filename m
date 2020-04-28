Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A957FC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F14F2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="md7CWbVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD1WSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:18:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48017 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbgD1WSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:18:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588112315; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=af+dDB6m+8MufGAb4/mIx5aBUAtu88g4EjzmaZpijQs=; b=md7CWbVEW6gkUQwgIEnkeC6uEXOQgHO+Z1daq7W4hzaDPZld66PCyfnpi4tI2YoPZQPzAXzf
 oBldPEdugQ4h3z3Jot5dAYvm9hMlJa7Qe9cMFvStSaOZmz98QWyEEoOo2xcnrCMjjauSY8Pt
 IfQdipXDOC/ZFQqGuTkgj6GUJDo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8abb8.7f5ff92048f0-smtp-out-n02;
 Tue, 28 Apr 2020 22:18:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 244E1C43636; Tue, 28 Apr 2020 22:18:32 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30F9DC433BA;
        Tue, 28 Apr 2020 22:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30F9DC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     ohad@wizery.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 1/2] remoteproc: qcom: Add per subsystem SSR notification
Date:   Tue, 28 Apr 2020 15:16:08 -0700
Message-Id: <1588112169-29447-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588112169-29447-1-git-send-email-rishabhb@codeaurora.org>
References: <1588112169-29447-1-git-send-email-rishabhb@codeaurora.org>
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
that data structure's notification chain.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/qcom_common.c      | 89 ++++++++++++++++++++++++++++++-----
 drivers/remoteproc/qcom_common.h      | 10 +++-
 include/linux/remoteproc/qcom_rproc.h | 20 ++++++--
 3 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 60650bc..7cd17be 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -15,16 +15,18 @@
 #include <linux/rpmsg/qcom_glink.h>
 #include <linux/rpmsg/qcom_smd.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/remoteproc/qcom_rproc.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
 
+#define MAX_NAME_LEN	20
+DEFINE_MUTEX(rproc_notif_lock);
+
 #define to_glink_subdev(d) container_of(d, struct qcom_rproc_glink, subdev)
 #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 
-static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
-
 static int glink_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
@@ -174,39 +176,81 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
 }
 EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
 
+struct rproc_notif_info *find_notif_info(const char *name)
+{
+	struct rproc_notif_info *info;
+
+	/* Match in the global rproc_notif_list with name */
+	list_for_each_entry(info, &rproc_notif_list, list) {
+		if (!strncmp(info->name, name, strlen(name)))
+			return info;
+	}
+	return NULL;
+}
+
 /**
  * qcom_register_ssr_notifier() - register SSR notification handler
+ * @name:	pointer to name which will be searched in the global notif_list
  * @nb:		notifier_block to notify for restart notifications
  *
- * Returns 0 on success, negative errno on failure.
+ * Returns pointer to srcu notifier head on success, ERR_PTR on failure.
  *
- * This register the @notify function as handler for restart notifications. As
- * remote processors are stopped this function will be called, with the SSR
- * name passed as a parameter.
+ * This registers the @nb notifier block as part the notifier chain for a
+ * remoteproc associated with @name. The notifier block's callback
+ * will be invoked when the particular remote processor is stopped.
  */
-int qcom_register_ssr_notifier(struct notifier_block *nb)
+void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&ssr_notifiers, nb);
+	struct rproc_notif_info *info;
+
+	mutex_lock(&rproc_notif_lock);
+	info = find_notif_info(name);
+	if (!info) {
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			mutex_unlock(&rproc_notif_lock);
+			return ERR_PTR(-ENOMEM);
+		}
+		info->name = kstrndup(name, MAX_NAME_LEN, GFP_KERNEL);
+		srcu_init_notifier_head(&info->notifier_list);
+
+		/* Add to global notif list */
+		INIT_LIST_HEAD(&info->list);
+		list_add_tail(&info->list, &rproc_notif_list);
+	}
+
+	srcu_notifier_chain_register(&info->notifier_list, nb);
+	mutex_unlock(&rproc_notif_lock);
+	return &info->notifier_list;
 }
 EXPORT_SYMBOL_GPL(qcom_register_ssr_notifier);
 
 /**
  * qcom_unregister_ssr_notifier() - unregister SSR notification handler
+ * @notify:	pointer to srcu notifier head
  * @nb:		notifier_block to unregister
  */
-void qcom_unregister_ssr_notifier(struct notifier_block *nb)
+int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&ssr_notifiers, nb);
+	if (!notify)
+		return -EINVAL;
+
+	return srcu_notifier_chain_unregister(notify, nb);
 }
 EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
 
 static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
+	struct rproc_notif_data data = {
+		.name = ssr->info->name,
+		.crashed = false,
+	};
 
-	blocking_notifier_call_chain(&ssr_notifiers, 0, (void *)ssr->name);
+	srcu_notifier_call_chain(&ssr->info->notifier_list, 0, &data);
 }
 
+
 /**
  * qcom_add_ssr_subdev() - register subdevice as restart notification source
  * @rproc:	rproc handle
@@ -214,12 +258,30 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
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
+	struct rproc_notif_info *info;
+
+	mutex_lock(&rproc_notif_lock);
+	info = find_notif_info(ssr_name);
+	if (!info) {
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			mutex_unlock(&rproc_notif_lock);
+			return;
+		}
+		info->name = ssr_name;
+		srcu_init_notifier_head(&info->notifier_list);
+
+		/* Add to global notif_list */
+		INIT_LIST_HEAD(&info->list);
+		list_add_tail(&info->list, &rproc_notif_list);
+	}
+	mutex_unlock(&rproc_notif_lock);
+	ssr->info = info;
 	ssr->subdev.unprepare = ssr_notify_unprepare;
 
 	rproc_add_subdev(rproc, &ssr->subdev);
@@ -233,6 +295,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
  */
 void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
 {
+	ssr->info = NULL;
 	rproc_remove_subdev(rproc, &ssr->subdev);
 }
 EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index 58de71e..0c1d288 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -24,10 +24,16 @@ struct qcom_rproc_subdev {
 	struct qcom_smd_edge *edge;
 };
 
+struct rproc_notif_info {
+	const char *name;
+	struct srcu_notifier_head notifier_list;
+	struct list_head list;
+};
+static LIST_HEAD(rproc_notif_list);
+
 struct qcom_rproc_ssr {
 	struct rproc_subdev subdev;
-
-	const char *name;
+	struct rproc_notif_info *info;
 };
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink);
diff --git a/include/linux/remoteproc/qcom_rproc.h b/include/linux/remoteproc/qcom_rproc.h
index fa8e386..3dc65c0 100644
--- a/include/linux/remoteproc/qcom_rproc.h
+++ b/include/linux/remoteproc/qcom_rproc.h
@@ -5,17 +5,27 @@
 
 #if IS_ENABLED(CONFIG_QCOM_RPROC_COMMON)
 
-int qcom_register_ssr_notifier(struct notifier_block *nb);
-void qcom_unregister_ssr_notifier(struct notifier_block *nb);
+struct rproc_notif_data {
+	const char *name;
+	bool crashed;
+};
+
+void *qcom_register_ssr_notifier(const char *name, struct notifier_block *nb);
+int qcom_unregister_ssr_notifier(void *notify, struct notifier_block *nb);
 
 #else
 
-static inline int qcom_register_ssr_notifier(struct notifier_block *nb)
+static inline void *qcom_register_ssr_notifier(const char *name,
+						struct notifier_block *nb)
 {
-	return 0;
+	return NULL;
 }
 
-static inline void qcom_unregister_ssr_notifier(struct notifier_block *nb) {}
+static inline int qcom_unregister_ssr_notifier(void *notify,
+						struct notifier_block *nb)
+{
+	return 0;
+}
 
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
