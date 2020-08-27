Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407BD207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mR9jECCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgH0TuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:50:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51487 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgH0TuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:50:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598557810; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=jQ/gIuY2mY0oFoFD/iITvJMPLZuXd04x2UZpRd55VRM=; b=mR9jECCzG855ALuixZlfh0YFx4B8njzGmJRt+YTclFJLBTEHzF2Ho3WQek+sl0vj3+G2wrdm
 pK3E1ubSuo/e6tEm+/KeosPp7rFCFg3KhQTZcHDFY2QKPukWiFQXY2rKiK0CUzny0ZeE4YJm
 X9AEk8A0PQmhPB7VlLdTuYUItow=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f480e45630b177c472cd16f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 19:49:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 126EBC433CA; Thu, 27 Aug 2020 19:49:25 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8C24C43387;
        Thu, 27 Aug 2020 19:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8C24C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 2/3] remoteproc: Add coredump configuration to sysfs
Date:   Thu, 27 Aug 2020 12:48:50 -0700
Message-Id: <1598557731-1566-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose coredump configuration in sysfs under a feature
flag. This is useful for systems where access to
debugfs might be limited.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 24 +++++++++
 drivers/remoteproc/remoteproc_debugfs.c          |  4 ++
 drivers/remoteproc/remoteproc_sysfs.c            | 68 ++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
index 36094fb..f6c44fa 100644
--- a/Documentation/ABI/testing/sysfs-class-remoteproc
+++ b/Documentation/ABI/testing/sysfs-class-remoteproc
@@ -58,3 +58,27 @@ Description:	Remote processor name
 		Reports the name of the remote processor. This can be used by
 		userspace in exactly identifying a remote processor and ease
 		up the usage in modifying the 'firmware' or 'state' files.
+
+What:		/sys/class/remoteproc/.../coredump
+Date:		July 2020
+Contact:	Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>
+Description:	Remote processor coredump configuration
+
+		Reports the coredump configuration of the remote processor,
+		which will be one of:
+
+		"default"
+		"inline"
+		"disabled"
+
+		"default" means when the remote processor's coredump is
+		collected it will be copied to a separate buffer and that
+		buffer is exposed to userspace.
+
+		"inline" means when the remote processor's coredump is
+		collected userspace will directly read from the remote
+		processor's device memory. Extra buffer will not be used to
+		copy the dump. Also recovery process will not proceed until
+		all data is read by usersapce.
+
+		"disabled" means no dump will be collected.
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 2e3b3e2..48dfd0a 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -27,6 +27,7 @@
 /* remoteproc debugfs parent dir */
 static struct dentry *rproc_dbg;
 
+#if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
 /*
  * A coredump-configuration-to-string lookup table, for exposing a
  * human readable configuration via debugfs. Always keep in sync with
@@ -114,6 +115,7 @@ static const struct file_operations rproc_coredump_fops = {
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
+#endif
 
 /*
  * Some remote processors may support dumping trace logs into a shared
@@ -425,8 +427,10 @@ void rproc_create_debug_dir(struct rproc *rproc)
 			    rproc, &rproc_rsc_table_fops);
 	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
 			    rproc, &rproc_carveouts_fops);
+#if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
 	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
 			    rproc, &rproc_coredump_fops);
+#endif
 }
 
 void __init rproc_init_debugfs(void)
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index eea514c..89b301a 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -10,6 +10,71 @@
 
 #define to_rproc(d) container_of(d, struct rproc, dev)
 
+#if IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT)
+/*
+ * A coredump-configuration-to-string lookup table, for exposing a
+ * human readable configuration via sysfs. Always keep in sync with
+ * enum rproc_coredump_mechanism
+ */
+static const char * const rproc_coredump_str[] = {
+	[RPROC_COREDUMP_DEFAULT]	= "default",
+	[RPROC_COREDUMP_INLINE]		= "inline",
+	[RPROC_COREDUMP_DISABLED]	= "disabled",
+};
+
+/* Expose the current coredump configuration via debugfs */
+static ssize_t coredump_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
+}
+
+/*
+ * By writing to the 'coredump' sysfs entry, we control the behavior of the
+ * coredump mechanism dynamically. The default value of this entry is "default".
+ *
+ * The 'coredump' sysfs entry supports these commands:
+ *
+ * default:	This is the default coredump mechanism. When the remoteproc
+ *		crashes the entire coredump will be copied to a separate buffer
+ *		and exposed to userspace.
+ *
+ * inline:	The coredump will not be copied to a separate buffer and the
+ *		recovery process will have to wait until data is read by
+ *		userspace. But this avoid usage of extra memory.
+ *
+ * disabled:	This will disable coredump. Recovery will proceed without
+ *		collecting any dump.
+ */
+static ssize_t coredump_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	if (rproc->state == RPROC_CRASHED) {
+		dev_err(&rproc->dev, "can't change coredump configuration\n");
+		return -EBUSY;
+	}
+
+	if (sysfs_streq(buf, "disable")) {
+		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
+	} else if (sysfs_streq(buf, "inline")) {
+		rproc->dump_conf = RPROC_COREDUMP_INLINE;
+	} else if (sysfs_streq(buf, "default")) {
+		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
+	} else {
+		dev_err(&rproc->dev, "Invalid coredump configuration\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(coredump);
+#endif
+
 /* Expose the loaded / running firmware name via sysfs */
 static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -138,6 +203,9 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(name);
 
 static struct attribute *rproc_attrs[] = {
+#if IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT)
+	&dev_attr_coredump.attr,
+#endif
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
 	&dev_attr_name.attr,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

