Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCB92065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="toCA5kU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgENUI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:08:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57804 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgENUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:08:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589486905; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4sodTfYBSa80PcaqFm4+5cs7pkyxemTKYG6L44YBdc0=; b=toCA5kU4dSM5SSHcKzXt+O1esL9VMELyu1KxO2Cf46pd/63ldtv5260uv9gly+nebHlw07qz
 YODzNTM4bje7rIfX4Uio/lyE+IF4BVY9odQRUs/oCLadQXHHwll5Re6vWbU1yBcw2mevdwp7
 LIZhnO3xxa8WDKwrL1nbQlk5JEM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebda539.7fdb73bc6ab0-smtp-out-n02;
 Thu, 14 May 2020 20:08:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44F29C38561; Thu, 14 May 2020 20:08:25 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCC6BC49493;
        Thu, 14 May 2020 20:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCC6BC49493
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 3/3] remoteproc: Add coredump debugfs entry
Date:   Thu, 14 May 2020 13:07:36 -0700
Message-Id: <1589486856-23440-4-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
References: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coredump debugfs entry to configure the type of dump that will
be collected during recovery. User can select between default or
inline coredump functionality. Also coredump collection can be
disabled through this interface.
This functionality can be configured differently for different
remote processors.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 732770e..2f611de 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -28,6 +28,90 @@
 static struct dentry *rproc_dbg;
 
 /*
+ * A coredump-configuration-to-string lookup table, for exposing a
+ * human readable configuration via debugfs. Always keep in sync with
+ * enum rproc_coredump_mechanism
+ */
+static const char * const rproc_coredump_str[] = {
+	[COREDUMP_DEFAULT]	= "default",
+	[COREDUMP_INLINE]	= "inline",
+	[COREDUMP_DISABLED]	= "disabled",
+};
+
+/* Expose the current coredump configuration via debugfs */
+static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct rproc *rproc = filp->private_data;
+	const char *buf = rproc_coredump_str[rproc->dump_conf];
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+}
+
+/*
+ * By writing to the 'coredump' debugfs entry, we control the behavior of the
+ * coredump mechanism dynamically. The default value of this entry is "default".
+ *
+ * The 'coredump' debugfs entry supports these commands:
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
+static ssize_t rproc_coredump_write(struct file *filp,
+				     const char __user *user_buf, size_t count,
+				     loff_t *ppos)
+{
+	struct rproc *rproc = filp->private_data;
+	int ret, err = 0;
+	char buf[20];
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	ret = copy_from_user(buf, user_buf, count);
+	if (ret)
+		return -EFAULT;
+
+	/* remove end of line */
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	if (rproc->state == RPROC_CRASHED) {
+		dev_err(&rproc->dev, "can't change coredump configuration\n");
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (!strncmp(buf, "disable", count))
+		rproc->dump_conf = COREDUMP_DISABLED;
+	else if (!strncmp(buf, "inline", count))
+		rproc->dump_conf = COREDUMP_INLINE;
+	else if (!strncmp(buf, "default", count))
+		rproc->dump_conf = COREDUMP_DEFAULT;
+	else {
+		dev_err(&rproc->dev, "Invalid coredump configuration\n");
+		err = -EINVAL;
+	}
+out:
+	return err ? err : count;
+}
+
+static const struct file_operations rproc_coredump_fops = {
+	.read = rproc_coredump_read,
+	.write = rproc_coredump_write,
+	.open = simple_open,
+	.llseek = generic_file_llseek,
+};
+
+/*
  * Some remote processors may support dumping trace logs into a shared
  * memory buffer. We expose this trace buffer using debugfs, so users
  * can easily tell what's going on remotely.
@@ -337,6 +421,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
 			    rproc, &rproc_rsc_table_fops);
 	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
 			    rproc, &rproc_carveouts_fops);
+	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
+			    rproc, &rproc_coredump_fops);
 }
 
 void __init rproc_init_debugfs(void)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
