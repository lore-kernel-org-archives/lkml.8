Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A161C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B5120714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Zug2G4Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCTXge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:36:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58298 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727631AbgCTXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:36:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584747392; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=tF47bbQuVfMnOHBOoce98F6vj6dpZ0a7qcd99W3Mc90=; b=Zug2G4Plxtph5T3DJIkiF65OMbHbfAys2zGSIZCx7Qwu/rhm/6ma3SgdSuWTaTR/EP6yQYJv
 M3iCxcdpBJ1rDy4r2xUy+55LxnW/mRA1HrJPFT/4Fipz/OwxlHIrZoxy3nzXKJwcE8zXQVe1
 NUy4cOJcEcPFeSMpLdjhN0CLvgU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e75537e.7f09f33deb58-smtp-out-n02;
 Fri, 20 Mar 2020 23:36:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB3E5C43637; Fri, 20 Mar 2020 23:36:28 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 967CAC433BA;
        Fri, 20 Mar 2020 23:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 967CAC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 1/2] remoteproc: Add userspace char device driver
Date:   Fri, 20 Mar 2020 16:36:16 -0700
Message-Id: <1584747377-14824-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
References: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver for creating the character device interface for
userspace applications. The character device interface can be used
in order to boot up and shutdown the remote processor.
This might be helpful for remote processors that are booted by
userspace applications and need to shutdown when the application
crahes/shutsdown.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/Makefile               |   1 +
 drivers/remoteproc/remoteproc_internal.h  |   3 +
 drivers/remoteproc/remoteproc_userspace.c | 126 ++++++++++++++++++++++++++++++
 include/linux/remoteproc.h                |   2 +
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_userspace.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e30a1b1..facb3fa 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
 remoteproc-y				:= remoteproc_core.o
 remoteproc-y				+= remoteproc_debugfs.o
 remoteproc-y				+= remoteproc_sysfs.o
+remoteproc-y				+= remoteproc_userspace.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 493ef92..bafaa12 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -63,6 +63,9 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 
+/* from remoteproc_userspace.c */
+extern int rproc_char_device_add(struct rproc *rproc);
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/drivers/remoteproc/remoteproc_userspace.c b/drivers/remoteproc/remoteproc_userspace.c
new file mode 100644
index 0000000..e3017e7
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_userspace.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Character device interface driver for Remoteproc framework.
+ *
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+static LIST_HEAD(rproc_chrdev_list);
+
+struct rproc_char_dev {
+	struct list_head node;
+	dev_t dev_no;
+	struct rproc *rproc;
+};
+
+static DEFINE_MUTEX(rproc_chrdev_lock);
+
+static struct rproc *rproc_get_by_dev_no(int minor)
+{
+	struct rproc_char_dev *r;
+
+	mutex_lock(&rproc_chrdev_lock);
+	list_for_each_entry(r, &rproc_chrdev_list, node) {
+		if (MINOR(r->dev_no) == minor)
+			break;
+	}
+	mutex_unlock(&rproc_chrdev_lock);
+
+	return r->rproc;
+}
+
+static int rproc_open(struct inode *inode, struct file *file)
+{
+	struct rproc *rproc;
+	int retval;
+
+	rproc = rproc_get_by_dev_no(iminor(inode));
+	if (!rproc)
+		return -EINVAL;
+
+	if (!try_module_get(rproc->dev.parent->driver->owner)) {
+		dev_err(&rproc->dev, "can't get owner\n");
+		return -EINVAL;
+	}
+
+	get_device(&rproc->dev);
+	retval = rproc_boot(rproc);
+
+	return retval;
+}
+
+static int rproc_close(struct inode *inode, struct file *file)
+{
+	struct rproc *rproc;
+
+	rproc = rproc_get_by_dev_no(iminor(inode));
+	if (!rproc)
+		return -EINVAL;
+
+	rproc_shutdown(rproc);
+	rproc_put(rproc);
+
+	return 0;
+}
+
+static const struct file_operations rproc_fops = {
+	.open = rproc_open,
+	.release = rproc_close,
+};
+
+int rproc_char_device_add(struct rproc *rproc)
+{
+	int ret = 0;
+	static int major, minor;
+	dev_t dev_no;
+	struct rproc_char_dev *chrdev;
+
+	mutex_lock(&rproc_chrdev_lock);
+	if (!major) {
+		ret = alloc_chrdev_region(&dev_no, 0, 4, "subsys");
+		if (ret < 0) {
+			pr_err("Failed to alloc subsys_dev region, err %d\n",
+									ret);
+			goto fail;
+		}
+		major = MAJOR(dev_no);
+		minor = MINOR(dev_no);
+	} else
+		dev_no = MKDEV(major, minor);
+
+	cdev_init(&rproc->char_dev, &rproc_fops);
+	rproc->char_dev.owner = THIS_MODULE;
+	ret = cdev_add(&rproc->char_dev, dev_no, 1);
+	if (ret < 0)
+		goto fail_unregister_cdev_region;
+
+	rproc->dev.devt = dev_no;
+
+	chrdev = kzalloc(sizeof(struct rproc_char_dev), GFP_KERNEL);
+	if (!chrdev) {
+		ret = -ENOMEM;
+		goto fail_unregister_cdev_region;
+	}
+
+	chrdev->rproc = rproc;
+	chrdev->dev_no = dev_no;
+	list_add(&chrdev->node, &rproc_chrdev_list);
+	++minor;
+	mutex_unlock(&rproc_chrdev_lock);
+
+	return 0;
+
+fail_unregister_cdev_region:
+	unregister_chrdev_region(dev_no, 1);
+fail:
+	mutex_unlock(&rproc_chrdev_lock);
+	return ret;
+}
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
