Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74236C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DB02078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ohb8ZDxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgICXFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:05:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57346 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgICXEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:04:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599174270; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=J1X0QFUD6hvClJi4SBmPQOCyIfjNTP8uLJvVcx6ddi8=; b=ohb8ZDxk4PyMsAbybZVB4YDXLpF6CU47K51u1dCeC01xZi8Zy6Ob2CE2NdcNdlvp9EsgFh/o
 G/mfXakMJzHdqKLC2OBC7cC9iCQ7PkWO2dYfTSN7bI9tHC+VcNOxErZ1IiN/TIZu/6qllV6K
 QuESPg0W/KU8+lG1aOFlXHy+Lqc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f51767d7f21d51b306d8e9e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 23:04:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE6BAC43395; Thu,  3 Sep 2020 23:04:29 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA6D0C433C9;
        Thu,  3 Sep 2020 23:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA6D0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 3/3] remoteproc: Add recovery configuration to sysfs
Date:   Thu,  3 Sep 2020 16:03:45 -0700
Message-Id: <1599174226-2307-4-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
References: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose recovery configuration in sysfs under a feature
flag. This is useful for systems where access to
debugfs might be limited.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 20 ++++++
 drivers/remoteproc/remoteproc_debugfs.c          | 78 ------------------------
 drivers/remoteproc/remoteproc_sysfs.c            | 58 ++++++++++++++++++
 3 files changed, 78 insertions(+), 78 deletions(-)

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
index 732770e..c505f0e 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -84,82 +84,6 @@ static const struct file_operations rproc_name_ops = {
 	.llseek	= generic_file_llseek,
 };
 
-/* expose recovery flag via debugfs */
-static ssize_t rproc_recovery_read(struct file *filp, char __user *userbuf,
-				   size_t count, loff_t *ppos)
-{
-	struct rproc *rproc = filp->private_data;
-	char *buf = rproc->recovery_disabled ? "disabled\n" : "enabled\n";
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
-}
-
-/*
- * By writing to the 'recovery' debugfs entry, we control the behavior of the
- * recovery mechanism dynamically. The default value of this entry is "enabled".
- *
- * The 'recovery' debugfs entry supports these commands:
- *
- * enabled:	When enabled, the remote processor will be automatically
- *		recovered whenever it crashes. Moreover, if the remote
- *		processor crashes while recovery is disabled, it will
- *		be automatically recovered too as soon as recovery is enabled.
- *
- * disabled:	When disabled, a remote processor will remain in a crashed
- *		state if it crashes. This is useful for debugging purposes;
- *		without it, debugging a crash is substantially harder.
- *
- * recover:	This function will trigger an immediate recovery if the
- *		remote processor is in a crashed state, without changing
- *		or checking the recovery state (enabled/disabled).
- *		This is useful during debugging sessions, when one expects
- *		additional crashes to happen after enabling recovery. In this
- *		case, enabling recovery will make it hard to debug subsequent
- *		crashes, so it's recommended to keep recovery disabled, and
- *		instead use the "recover" command as needed.
- */
-static ssize_t
-rproc_recovery_write(struct file *filp, const char __user *user_buf,
-		     size_t count, loff_t *ppos)
-{
-	struct rproc *rproc = filp->private_data;
-	char buf[10];
-	int ret;
-
-	if (count < 1 || count > sizeof(buf))
-		return -EINVAL;
-
-	ret = copy_from_user(buf, user_buf, count);
-	if (ret)
-		return -EFAULT;
-
-	/* remove end of line */
-	if (buf[count - 1] == '\n')
-		buf[count - 1] = '\0';
-
-	if (!strncmp(buf, "enabled", count)) {
-		/* change the flag and begin the recovery process if needed */
-		rproc->recovery_disabled = false;
-		rproc_trigger_recovery(rproc);
-	} else if (!strncmp(buf, "disabled", count)) {
-		rproc->recovery_disabled = true;
-	} else if (!strncmp(buf, "recover", count)) {
-		/* begin the recovery process without changing the flag */
-		rproc_trigger_recovery(rproc);
-	} else {
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static const struct file_operations rproc_recovery_ops = {
-	.read = rproc_recovery_read,
-	.write = rproc_recovery_write,
-	.open = simple_open,
-	.llseek = generic_file_llseek,
-};
-
 /* expose the crash trigger via debugfs */
 static ssize_t
 rproc_crash_write(struct file *filp, const char __user *user_buf,
@@ -329,8 +253,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
 
 	debugfs_create_file("name", 0400, rproc->dbg_dir,
 			    rproc, &rproc_name_ops);
-	debugfs_create_file("recovery", 0600, rproc->dbg_dir,
-			    rproc, &rproc_recovery_ops);
 	debugfs_create_file("crash", 0200, rproc->dbg_dir,
 			    rproc, &rproc_crash_ops);
 	debugfs_create_file("resource_table", 0400, rproc->dbg_dir,
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

