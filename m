Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F53C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF83208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GKSmPWTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgGaMLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732873AbgGaMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:06 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC7eJT011790;
        Fri, 31 Jul 2020 14:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=GC42Txzu7YDXAQKZYf6iSbzEby/I1QhEBTt8f1fNlOE=;
 b=GKSmPWTmxu07Q6Up4AwoOM8j4Wbp4dyQmLhrFb2Zl0/fnz0i7/GFkRuILplbMqe01WSp
 EIf1ULLqIWwdQqarNy/4pNZh6xb8yJAmulIYxBShp4Ojr1kHqR6/5gtg1tZGuUtW1huA
 K2N4P5n8xEBcuLWEFofikPQELMed78xEd14vRFY4qz2jK6uNz4aJ+738lEsdCYCFFlrm
 Jh91+asLbdNZPuQNGwM26aZEyDyrrk2pWrvLm8qvIHKp7MKunSE4q0XNhNCuK+1D21u3
 MlqnMaN3tqbXgDU5yzT8OL8w0M0AEJzYJpJmXQOSuatHDQ+XMljZ3We+LB0I0TyZFV3u LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32g9v9xku9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D69E910002A;
        Fri, 31 Jul 2020 14:11:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CACE02AE6DE;
        Fri, 31 Jul 2020 14:11:02 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:02
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 02/13] rpmsg: introduce rpmsg_control driver for channel creation
Date:   Fri, 31 Jul 2020 14:10:32 +0200
Message-ID: <20200731121043.24199-3-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a RPMsg driver that will offer to the userspace applications an
ioctl to manage channels.
As a first step, this driver just creates the /dev/rpmsg_ctl<x>
( <x> is the instance value). The ioctl is not implemented.

Notice that this driver is associated to a RPMsg device with no endpoint.
Instantiating this device as an RPMsg device allows to retrieve the
associated RPMsg backend.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/Kconfig      |   8 ++
 drivers/rpmsg/Makefile     |   1 +
 drivers/rpmsg/rpmsg_ctrl.c | 209 +++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_ctrl.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 900ec8f54081..c5afbf24e793 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -23,6 +23,14 @@ config RPMSG_NS
 	  channel that probes the associate RPMsg device on remote endpoint
 	  service announcement.
 
+config RPMSG_CTRL
+	tristate "RPMSG control interface"
+	depends on RPMSG
+	help
+	  Say Y here to enable the support of the name service announcement
+	  channel that probe the associate RPMsg device on remote endpoint
+	  service announcement.
+
 config RPMSG_RAW
 	tristate "RPMSG raw service driver"
 	depends on RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index d75f0a65e71d..dc5228022dac 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
 obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
+obj-$(CONFIG_RPMSG_CTRL)	+= rpmsg_ctrl.o
 obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
new file mode 100644
index 000000000000..d31b1ba51fa7
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020
+ */
+#include <linux/cdev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "rpmsg_internal.h"
+#include <uapi/linux/rpmsg.h>
+
+#define RPMSG_DEV_MAX	(MINORMASK + 1)
+
+#define dev_to_ctrldev(dev) container_of(dev, struct rpmsg_ctrl_dev, dev)
+#define cdev_to_ctrldev(i_cdev) container_of(i_cdev, struct rpmsg_ctrl_dev, cdev)
+
+/**
+ * struct rpmsg_ctrl_dev - control device for instantiating endpoint devices
+ * @rpdev:	underlaying rpmsg device
+ * @cdev:	cdev for the ctrl device
+ * @dev:	device for the ctrl device
+ */
+struct rpmsg_ctrl_dev {
+	struct rpmsg_device *rpdev;
+	struct cdev cdev;
+	struct device dev;
+};
+
+static DEFINE_IDA(rpmsg_ctrl_ida);
+static DEFINE_IDA(rpmsg_minor_ida);
+
+static dev_t rpmsg_major;
+
+static int rpmsg_ctrl_dev_open(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_ctrl_dev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
+
+	get_device(&ctrldev->dev);
+	filp->private_data = ctrldev;
+
+	return 0;
+}
+
+static long rpmsg_ctrl_dev_ioctl(struct file *fp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct rpmsg_ctrl_dev *ctrldev = fp->private_data;
+
+	dev_info(&ctrldev->dev, "Control not yet implemented\n");
+
+	return 0;
+};
+
+static int rpmsg_ctrl_dev_release(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_ctrl_dev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
+
+	put_device(&ctrldev->dev);
+
+	return 0;
+}
+
+static void rpmsg_ctrl_dev_release_device(struct device *dev)
+{
+	struct rpmsg_ctrl_dev *ctrldev = dev_to_ctrldev(dev);
+
+	dev_err(dev, "%s\n", __func__);
+
+	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+	cdev_del(&ctrldev->cdev);
+	kfree(ctrldev);
+}
+
+static const struct file_operations rpmsg_ctrl_fops = {
+	.owner = THIS_MODULE,
+	.open = rpmsg_ctrl_dev_open,
+	.release = rpmsg_ctrl_dev_release,
+	.unlocked_ioctl = rpmsg_ctrl_dev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static int rpmsg_ctrl_add_control(struct rpmsg_ctrl_dev *ctrldev)
+{
+	struct device *dev = &ctrldev->dev;
+	int ret;
+
+	cdev_init(&ctrldev->cdev, &rpmsg_ctrl_fops);
+	ctrldev->cdev.owner = THIS_MODULE;
+
+	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
+
+	dev_set_name(dev, "rpmsg_ctrl%d", dev->id);
+
+	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
+	if (ret)
+		goto free_minor_ida;
+
+	dev_info(dev, "add %s control for %s driver\n",
+		 dev_name(dev),  dev_name(dev->parent));
+
+	return 0;
+
+free_minor_ida:
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+
+	return ret;
+}
+
+static int rpmsg_ctrl_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_ctrl_dev *ctrldev;
+	struct device *dev;
+	int ret;
+
+	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
+	if (!ctrldev)
+		return -ENOMEM;
+
+	ctrldev->rpdev = rpdev;
+
+	dev = &ctrldev->dev;
+	device_initialize(dev);
+	dev->parent = &rpdev->dev;
+
+	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto free_ctrldev;
+
+	dev->id = ret;
+
+	ret = rpmsg_ctrl_add_control(ctrldev);
+	if (ret < 0)
+		goto free_ctrl_ida;
+
+	/* We can now rely on the release function for cleanup */
+	dev->release = rpmsg_ctrl_dev_release_device;
+
+	ret = device_add(dev);
+	if (ret) {
+		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
+		put_device(dev);
+		goto free_ctrl_ida;
+	}
+
+	dev_set_drvdata(dev, ctrldev);
+	dev_set_drvdata(&rpdev->dev, ctrldev);
+
+	return 0;
+
+free_ctrl_ida:
+	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
+free_ctrldev:
+	put_device(dev);
+	kfree(ctrldev);
+
+	return ret;
+}
+
+static void rpmsg_ctrl_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_ctrl_dev *ctrldev = dev_get_drvdata(&rpdev->dev);
+
+	device_del(&ctrldev->dev);
+	put_device(&ctrldev->dev);
+}
+
+static struct rpmsg_driver rpmsg_ctrl_driver = {
+	.probe = rpmsg_ctrl_probe,
+	.remove = rpmsg_ctrl_remove,
+	.drv = {
+		.name = "rpmsg_ctrl",
+	},
+};
+
+static int rpmsg_ctrl_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg");
+	if (ret < 0) {
+		pr_err("rpmsg: failed to allocate char dev region\n");
+		return ret;
+	}
+
+	ret = register_rpmsg_driver(&rpmsg_ctrl_driver);
+	if (ret < 0) {
+		pr_err("rpmsgchr: failed to register rpmsg driver\n");
+		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+	}
+
+	return ret;
+}
+postcore_initcall(rpmsg_ctrl_init);
+
+static void rpmsg_ctrl_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_ctrl_driver);
+	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+}
+module_exit(rpmsg_ctrl_exit);
+
+MODULE_DESCRIPTION("Ioctl rpmsg driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_ALIAS("rpmsg_ctl");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

