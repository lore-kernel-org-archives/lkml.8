Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C337C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3428B207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SgabqXEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgH0Ttj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31365 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgH0Ttg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598557775; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bdHYAMPgcy3cvjCiidfmeFTYKUu3fscjSsmkXsVM6sw=; b=SgabqXErybvus7iJrdbt3aFex8nw6P9EJZ1JYwxhIxkzTUH7KHKzaxvFi+/FK3Rb8aG57nxP
 Jb/vVP/x3AVuKdqjjK8xNNHRjov0qk3dF7EIdqMVNM0nJQ/x2Jfod4MswBrK0WiipphF/Ice
 JpTp92rp7d+fdPjSv+9WoWLQlzM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f480e4491574590bff134bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 19:49:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60EF3C433A0; Thu, 27 Aug 2020 19:49:24 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41D88C43395;
        Thu, 27 Aug 2020 19:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41D88C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 3/3] remoteproc: Add recovery configuration to sysfs
Date:   Thu, 27 Aug 2020 12:48:51 -0700
Message-Id: <1598557731-1566-4-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose recovery configuration in sysfs under a feature
flag. This is useful for systems where access to
debugfs might be limited.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 20 ++++++++
 drivers/remoteproc/remoteproc_debugfs.c          |  6 ++-
 drivers/remoteproc/remoteproc_sysfs.c            | 58 ++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
index f6c44fa..7368b50 100644
--- a/Documentation/ABI/testing/sysfs-class-remoteproc
+++ b/Documentation/ABI/testing/sysfs-class-remoteproc
@@ -82,3 +82,23 @@ Description:	Remote processor coredump configuration
 		all data is read by usersapce.
 
 		"disabled" means no dump will be collected.
+
+What:		/sys/class/remoteproc/.../recovery
+Date:		July 2020
+Contact:	Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>
+Description:	Remote processor recovery mechanism
+
+		Reports the recovery mechanism of the remote processor,
+		which will be one of:
+
+		"enabled"
+		"disabled"
+
+		"enabled" means, the remote processor will be automatically
+		recovered whenever it crashes. Moreover, if the remote
+		processor crashes while recovery is disabled, it will
+		be automatically recovered too as soon as recovery is enabled.
+
+		"disabled" means, a remote processor will remain in a crashed
+		state if it crashes. This is useful for debugging purposes;
+		without it, debugging a crash is substantially harder.
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 48dfd0a..415a9ff 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -174,6 +174,7 @@ static const struct file_operations rproc_name_ops = {
 	.llseek	= generic_file_llseek,
 };
 
+#if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
 /* expose recovery flag via debugfs */
 static ssize_t rproc_recovery_read(struct file *filp, char __user *userbuf,
 				   size_t count, loff_t *ppos)
@@ -249,6 +250,7 @@ static const struct file_operations rproc_recovery_ops = {
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
+#endif
 
 /* expose the crash trigger via debugfs */
 static ssize_t
@@ -419,8 +421,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
 
 	debugfs_create_file("name", 0400, rproc->dbg_dir,
 			    rproc, &rproc_name_ops);
-	debugfs_create_file("recovery", 0600, rproc->dbg_dir,
-			    rproc, &rproc_recovery_ops);
 	debugfs_create_file("crash", 0200, rproc->dbg_dir,
 			    rproc, &rproc_crash_ops);
 	debugfs_create_file("resource_table", 0400, rproc->dbg_dir,
@@ -430,6 +430,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
 #if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
 	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
 			    rproc, &rproc_coredump_fops);
+	debugfs_create_file("recovery", 0600, rproc->dbg_dir,
+			    rproc, &rproc_recovery_ops);
 #endif
 }
 
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 89b301a..45cae4f 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -11,6 +11,63 @@
 #define to_rproc(d) container_of(d, struct rproc, dev)
 
 #if IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT)
+
+/* expose recovery flag via sysfs */
+static ssize_t recovery_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	return sprintf(buf, "%s", rproc->recovery_disabled ? "disabled\n" : "enabled\n");
+}
+
+/*
+ * By writing to the 'recovery' sysfs entry, we control the behavior of the
+ * recovery mechanism dynamically. The default value of this entry is "enabled".
+ *
+ * The 'recovery' sysfs entry supports these commands:
+ *
+ * enabled:	When enabled, the remote processor will be automatically
+ *		recovered whenever it crashes. Moreover, if the remote
+ *		processor crashes while recovery is disabled, it will
+ *		be automatically recovered too as soon as recovery is enabled.
+ *
+ * disabled:	When disabled, a remote processor will remain in a crashed
+ *		state if it crashes. This is useful for debugging purposes;
+ *		without it, debugging a crash is substantially harder.
+ *
+ * recover:	This function will trigger an immediate recovery if the
+ *		remote processor is in a crashed state, without changing
+ *		or checking the recovery state (enabled/disabled).
+ *		This is useful during debugging sessions, when one expects
+ *		additional crashes to happen after enabling recovery. In this
+ *		case, enabling recovery will make it hard to debug subsequent
+ *		crashes, so it's recommended to keep recovery disabled, and
+ *		instead use the "recover" command as needed.
+ */
+static ssize_t recovery_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	if (sysfs_streq(buf, "enabled")) {
+		/* change the flag and begin the recovery process if needed */
+		rproc->recovery_disabled = false;
+		rproc_trigger_recovery(rproc);
+	} else if (sysfs_streq(buf, "disabled")) {
+		rproc->recovery_disabled = true;
+	} else if (sysfs_streq(buf, "recover")) {
+		/* begin the recovery process without changing the flag */
+		rproc_trigger_recovery(rproc);
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(recovery);
+
 /*
  * A coredump-configuration-to-string lookup table, for exposing a
  * human readable configuration via sysfs. Always keep in sync with
@@ -205,6 +262,7 @@ static DEVICE_ATTR_RO(name);
 static struct attribute *rproc_attrs[] = {
 #if IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT)
 	&dev_attr_coredump.attr,
+	&dev_attr_recovery.attr,
 #endif
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

