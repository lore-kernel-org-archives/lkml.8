Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B0C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E3C20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nPZwfgeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgDAAEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:04:14 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52733 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729514AbgDAAEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 20:04:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585699453; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZBJAAaa3TvwvVz/4rY37gGSVlw1f3QzL6lY3lGWRPEg=; b=nPZwfgeTtNO/xInx2PfAvI1/tnr4hi/m0TqUm8V3BH2ubWxbF0iNNHqaJKJQzzN+kudMZkoG
 PLC1XNd88HlX8I4lIlFOYC3QDttKk8Qxsl2BH46AfxNtq5IKxMwZ8N3evNbfSHhmj4LJ5LJ7
 +Mf+MOeEymzgUpfe1IvOtP7u1P0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e83da75.7f8c32be4180-smtp-out-n02;
 Wed, 01 Apr 2020 00:04:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CD62C44788; Wed,  1 Apr 2020 00:04:05 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99CA7C433D2;
        Wed,  1 Apr 2020 00:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99CA7C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 1/2] remoteproc: Add character device interface
Date:   Tue, 31 Mar 2020 17:03:57 -0700
Message-Id: <1585699438-14394-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the character device interface for userspace applications.
This interface can be used in order to boot up and shutdown
remote subsystems. Currently there is only a sysfs interface
which the userspace clients can use. If a usersapce application
crashes after booting the remote processor does not get any
indication about the crash. It might still assume that the
application is running. For example modem uses remotefs service
to fetch data from disk/flash memory. If the remotefs service
crashes, modem keeps on requesting data which might lead to a
crash. Adding a character device interface makes the remote
processor tightly coupled with the user space application.
A crash of the application leads to a close on the file descriptors
therefore shutting down the remoteproc.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/Kconfig               |   9 +++
 drivers/remoteproc/Makefile              |   1 +
 drivers/remoteproc/remoteproc_cdev.c     | 100 +++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h |  22 +++++++
 include/linux/remoteproc.h               |   2 +
 5 files changed, 134 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_cdev.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index de3862c..6374b79 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -14,6 +14,15 @@ config REMOTEPROC
 
 if REMOTEPROC
 
+config REMOTEPROC_CDEV
+	bool "Remoteproc character device interface"
+	help
+	  Say y here to have a character device interface for Remoteproc
+	  framework. Userspace can boot/shutdown remote processors through
+	  this interface.
+
+	  It's safe to say N if you don't want to use this interface.
+
 config IMX_REMOTEPROC
 	tristate "IMX6/7 remoteproc support"
 	depends on ARCH_MXC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e30a1b1..b7d4f77 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
 remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
+obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
new file mode 100644
index 0000000..8182bd1
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Character device interface driver for Remoteproc framework.
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+#define NUM_RPROC_DEVICES	64
+static dev_t rproc_cdev;
+static DEFINE_IDA(cdev_minor_ida);
+
+static int rproc_cdev_open(struct inode *inode, struct file *file)
+{
+	struct rproc *rproc;
+
+	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
+
+	if (!rproc)
+		return -EINVAL;
+
+	if (rproc->state == RPROC_RUNNING)
+		return -EBUSY;
+
+	return rproc_boot(rproc);
+}
+
+static int rproc_cdev_release(struct inode *inode, struct file *file)
+{
+	struct rproc *rproc;
+
+	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
+
+	if (!rproc || rproc->state != RPROC_RUNNING)
+		return -EINVAL;
+
+	rproc_shutdown(rproc);
+
+	return 0;
+}
+
+static const struct file_operations rproc_fops = {
+	.open = rproc_cdev_open,
+	.release = rproc_cdev_release,
+};
+
+int rproc_char_device_add(struct rproc *rproc)
+{
+	int ret, minor;
+	dev_t cdevt;
+
+	minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
+			       GFP_KERNEL);
+	if (minor < 0) {
+		dev_err(&rproc->dev, "%s: No more minor numbers left! rc:%d\n",
+			__func__, minor);
+		return -ENODEV;
+	}
+
+	cdev_init(&rproc->char_dev, &rproc_fops);
+	rproc->char_dev.owner = THIS_MODULE;
+
+	cdevt = MKDEV(MAJOR(rproc_cdev), minor);
+	ret = cdev_add(&rproc->char_dev, cdevt, 1);
+	if (ret < 0)
+		ida_simple_remove(&cdev_minor_ida, minor);
+
+	rproc->dev.devt = cdevt;
+	return ret;
+}
+
+void rproc_char_device_remove(struct rproc *rproc)
+{
+	__unregister_chrdev(MAJOR(rproc->dev.devt), MINOR(rproc->dev.devt), 1,
+			    "rproc");
+	ida_simple_remove(&cdev_minor_ida, MINOR(rproc->dev.devt));
+}
+
+void __init rproc_init_cdev(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&rproc_cdev, 0, NUM_RPROC_DEVICES, "rproc");
+	if (ret < 0) {
+		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
+		return;
+	}
+}
+
+void __exit rproc_exit_cdev(void)
+{
+	__unregister_chrdev(MAJOR(rproc_cdev), 0, NUM_RPROC_DEVICES, "rproc");
+}
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 493ef92..28d61a1 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
 int rproc_init_sysfs(void);
 void rproc_exit_sysfs(void);
 
+#ifdef CONFIG_REMOTEPROC_CDEV
+void rproc_init_cdev(void);
+void rproc_exit_cdev(void);
+int rproc_char_device_add(struct rproc *rproc);
+void rproc_char_device_remove(struct rproc *rproc);
+#else
+static inline void rproc_init_cdev(void)
+{
+}
+static inline void rproc_exit_cdev(void)
+{
+}
+static inline int rproc_char_device_add(struct rproc *rproc)
+{
+	return 0;
+}
+static inline void  rproc_char_device_remove(struct rproc *rproc)
+{
+}
+#endif
+
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
@@ -63,6 +84,7 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad666..c4ca796 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -37,6 +37,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/cdev.h>
 #include <linux/virtio.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
@@ -514,6 +515,7 @@ struct rproc {
 	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	struct cdev char_dev;
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
