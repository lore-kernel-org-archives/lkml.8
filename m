Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5898B22CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q8GOR9mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgGaML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4514 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732886AbgGaMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:06 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC7cQn011783;
        Fri, 31 Jul 2020 14:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=cVheV20ZNKPxcFr0xDJ7TW1uuXFbr75eOpa/Iq2uNJ8=;
 b=q8GOR9mpzUsC3ATCIQiAiPYdCDBfrnecGzKrKzS6TKjRfqHwORQXWt/T6+hSfUfTLgOa
 WPCc/YCPR123dRFwOf654hQcj8oarmxRrQyWbY6OZf9wSV4BHIUUJXFeLNOI1BSTFS7s
 O86a4bBV1Lg376VG73M7ozfO7A3KSehy2Y2L9XQb26Y/uc5usNPamwsUmUPKGp+W1lId
 wDg3nBQe1m14hesq0T/Rsm03jsx7WSVWFpmMRsPYcerBFit+78bjAY5kQkChYdgjj3+x
 w6L5YaTzXFaVPQMvfNjbYPpJtxH+AfgRKnFMp3DfJeIRWaTaqFXwYghHQZLDa4C9TvDu FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32g9v9xku7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5E7110002A;
        Fri, 31 Jul 2020 14:11:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96BEA2AE6DD;
        Fri, 31 Jul 2020 14:11:01 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:00
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 01/13] rpmsg: introduce rpmsg raw driver
Date:   Fri, 31 Jul 2020 14:10:31 +0200
Message-ID: <20200731121043.24199-2-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is a copy past of the rpmsg_char driver with following
update:
- The control part has been removed.
- The rpmsg class has been removed because the information already
  available in /sys/bus.
- The device is now an RPMsg device probed by a RPMsg bus driver.
- The associated endpoint is now created by the bus not on the fs open.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/Kconfig     |   9 +
 drivers/rpmsg/Makefile    |   1 +
 drivers/rpmsg/rpmsg_raw.c | 347 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_raw.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 0143c9864c45..900ec8f54081 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -23,6 +23,15 @@ config RPMSG_NS
 	  channel that probes the associate RPMsg device on remote endpoint
 	  service announcement.
 
+config RPMSG_RAW
+	tristate "RPMSG raw service driver"
+	depends on RPMSG
+	depends on NET
+	help
+	  Say Y here to export rpmsg endpoints as char device files, found
+	  in /dev. They make it possible for user-space programs to send and
+	  receive rpmsg packets through a basic char device.
+
 config RPMSG_MTK_SCP
 	tristate "MediaTek SCP"
 	depends on MTK_SCP
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 8d452656f0ee..d75f0a65e71d 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
 obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
 obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
+obj-$(CONFIG_RPMSG_RAW)	+= rpmsg_raw.o
diff --git a/drivers/rpmsg/rpmsg_raw.c b/drivers/rpmsg/rpmsg_raw.c
new file mode 100644
index 000000000000..8684a78ab4d1
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_raw.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ *
+ * Based on rpmsg_char driver.
+ */
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/rpmsg.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/rpmsg.h>
+
+#include "rpmsg_internal.h"
+
+#define RPMSG_DEV_MAX	(MINORMASK + 1)
+
+#define dev_to_eptdev(dev) container_of(dev, struct rpmsg_raw, dev)
+#define cdev_to_eptdev(i_cdev) container_of(i_cdev, struct rpmsg_raw, cdev)
+
+static dev_t rpmsg_raw_major;
+
+static DEFINE_IDA(rpmsg_minor_ida);
+static DEFINE_IDA(rpmsg_ept_ida);
+
+/**
+ * struct rpmsg_raw - endpoint device context
+ * @dev:	endpoint device
+ * @cdev:	cdev for the endpoint device
+ * @rpdev:	underlaying rpmsg device
+ * @ept_lock:	synchronization of @ept modifications
+ * @queue_lock:	synchronization of @queue operations
+ * @queue:	incoming message queue
+ * @readq:	wait object for incoming queue
+ */
+struct rpmsg_raw {
+	struct device dev;
+	struct cdev cdev;
+	struct rpmsg_device *rpdev;
+	struct mutex ept_lock;
+	spinlock_t queue_lock;
+	struct sk_buff_head queue;
+	wait_queue_head_t readq;
+};
+
+static int rpmsg_raw_cb(struct rpmsg_device *rpdev, void *buf, int len,
+			void *priv, u32 addr)
+{
+	struct rpmsg_raw *eptdev = dev_get_drvdata(&rpdev->dev);
+	struct sk_buff *skb;
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, buf, len);
+
+	spin_lock(&eptdev->queue_lock);
+	skb_queue_tail(&eptdev->queue, skb);
+	spin_unlock(&eptdev->queue_lock);
+
+	/* wake up any blocking processes, waiting for new data */
+	wake_up_interruptible(&eptdev->readq);
+
+	return 0;
+}
+
+static int rpmsg_raw_open(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_raw *eptdev = cdev_to_eptdev(inode->i_cdev);
+	struct device *dev = &eptdev->dev;
+
+	get_device(dev);
+
+	filp->private_data = eptdev;
+
+	return 0;
+}
+
+static int rpmsg_raw_release(struct inode *inode, struct file *filp)
+{
+	struct rpmsg_raw *eptdev = cdev_to_eptdev(inode->i_cdev);
+
+	/* Discard all SKBs */
+	skb_queue_purge(&eptdev->queue);
+
+	put_device(&eptdev->dev);
+
+	return 0;
+}
+
+static ssize_t rpmsg_raw_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct rpmsg_raw *eptdev = filp->private_data;
+	unsigned long flags;
+	struct sk_buff *skb;
+	int use;
+
+	if (!eptdev->rpdev->ept)
+		return -EPIPE;
+
+	spin_lock_irqsave(&eptdev->queue_lock, flags);
+
+	/* Wait for data in the queue */
+	if (skb_queue_empty(&eptdev->queue)) {
+		spin_unlock_irqrestore(&eptdev->queue_lock, flags);
+
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		/* Wait until we get data or the endpoint goes away */
+		if (wait_event_interruptible(eptdev->readq,
+					     !skb_queue_empty(&eptdev->queue) ||
+					     !eptdev->rpdev->ept))
+			return -ERESTARTSYS;
+
+		/* We lost the endpoint while waiting */
+		if (!eptdev->rpdev->ept)
+			return -EPIPE;
+
+		spin_lock_irqsave(&eptdev->queue_lock, flags);
+	}
+
+	skb = skb_dequeue(&eptdev->queue);
+	spin_unlock_irqrestore(&eptdev->queue_lock, flags);
+	if (!skb)
+		return -EFAULT;
+
+	use = min_t(size_t, iov_iter_count(to), skb->len);
+	if (copy_to_iter(skb->data, use, to) != use)
+		use = -EFAULT;
+
+	kfree_skb(skb);
+
+	return use;
+}
+
+static ssize_t rpmsg_raw_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *filp = iocb->ki_filp;
+	struct rpmsg_raw *eptdev = filp->private_data;
+	size_t len = iov_iter_count(from);
+	void *kbuf;
+	int ret;
+
+	kbuf = kzalloc(len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(kbuf, len, from)) {
+		ret = -EFAULT;
+		goto free_kbuf;
+	}
+
+	if (mutex_lock_interruptible(&eptdev->ept_lock)) {
+		ret = -ERESTARTSYS;
+		goto free_kbuf;
+	}
+
+	if (!eptdev->rpdev->ept) {
+		ret = -EPIPE;
+		goto unlock_eptdev;
+	}
+
+	if (filp->f_flags & O_NONBLOCK)
+		ret = rpmsg_trysend(eptdev->rpdev->ept, kbuf, len);
+	else
+		ret = rpmsg_send(eptdev->rpdev->ept, kbuf, len);
+
+unlock_eptdev:
+	mutex_unlock(&eptdev->ept_lock);
+
+free_kbuf:
+	kfree(kbuf);
+	return ret < 0 ? ret : len;
+}
+
+static __poll_t rpmsg_raw_poll(struct file *filp, poll_table *wait)
+{
+	struct rpmsg_raw *eptdev = filp->private_data;
+	__poll_t mask = 0;
+
+	if (!eptdev->rpdev->ept)
+		return EPOLLERR;
+
+	poll_wait(filp, &eptdev->readq, wait);
+
+	if (!skb_queue_empty(&eptdev->queue))
+		mask |= EPOLLIN | EPOLLRDNORM;
+
+	mask |= rpmsg_poll(eptdev->rpdev->ept, filp, wait);
+
+	return mask;
+}
+
+static void rpmsg_raw_release_device(struct device *dev)
+{
+	struct rpmsg_raw *eptdev = dev_to_eptdev(dev);
+
+	ida_simple_remove(&rpmsg_ept_ida, dev->id);
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
+	cdev_del(&eptdev->cdev);
+	kfree(eptdev);
+}
+
+static const struct file_operations rpmsg_raw_fops = {
+	.owner = THIS_MODULE,
+	.open = rpmsg_raw_open,
+	.release = rpmsg_raw_release,
+	.read_iter = rpmsg_raw_read_iter,
+	.write_iter = rpmsg_raw_write_iter,
+	.poll = rpmsg_raw_poll,
+};
+
+static int rpmsg_raw_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_raw *eptdev;
+	struct device *dev;
+	int ret;
+
+	eptdev = kzalloc(sizeof(*eptdev), GFP_KERNEL);
+	if (!eptdev)
+		return -ENOMEM;
+
+	dev = &eptdev->dev;
+	eptdev->rpdev = rpdev;
+
+	mutex_init(&eptdev->ept_lock);
+	spin_lock_init(&eptdev->queue_lock);
+	skb_queue_head_init(&eptdev->queue);
+	init_waitqueue_head(&eptdev->readq);
+
+	device_initialize(dev);
+	dev->parent = &rpdev->dev;
+	dev_set_drvdata(dev, eptdev);
+
+	cdev_init(&eptdev->cdev, &rpmsg_raw_fops);
+	eptdev->cdev.owner = THIS_MODULE;
+
+	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(dev, "failed to get IDA (%d)\n", ret);
+		goto free_eptdev;
+	}
+
+	dev->devt = MKDEV(MAJOR(rpmsg_raw_major), ret);
+
+	ret = ida_simple_get(&rpmsg_ept_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto free_minor_ida;
+	dev->id = ret;
+	dev_set_name(dev, "rpmsg%d", dev->id);
+
+	ret = cdev_add(&eptdev->cdev, dev->devt, 1);
+	if (ret) {
+		ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+		dev_err(&rpdev->dev, "failed to add char device(%d)\n", ret);
+		goto free_ept_ida;
+	}
+
+	/* We can now rely on the release function for cleanup */
+	dev->release = rpmsg_raw_release_device;
+
+	ret = device_add(dev);
+	if (ret) {
+		dev_err(dev, "device_add failed: %d\n", ret);
+		put_device(dev);
+	}
+
+	dev_set_drvdata(&rpdev->dev, eptdev);
+
+	return ret;
+
+free_ept_ida:
+	ida_simple_remove(&rpmsg_ept_ida, dev->id);
+free_minor_ida:
+	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+free_eptdev:
+	put_device(dev);
+	kfree(eptdev);
+
+	return ret;
+}
+
+static void rpmsg_raw_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_raw *eptdev = dev_get_drvdata(&rpdev->dev);
+
+	/* wake up any blocked readers */
+	wake_up_interruptible(&eptdev->readq);
+
+	device_del(&eptdev->dev);
+
+	put_device(&eptdev->dev);
+}
+
+static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
+	{ .name	= "rpmsg-raw" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_sample_id_table);
+
+static struct rpmsg_driver rpmsg_raw_client = {
+	.drv.name	= KBUILD_MODNAME,
+	.id_table	= rpmsg_driver_sample_id_table,
+	.probe		= rpmsg_raw_probe,
+	.callback	= rpmsg_raw_cb,
+	.remove		= rpmsg_raw_remove,
+};
+
+static int rpmsg_raw_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&rpmsg_raw_major, 0, RPMSG_DEV_MAX,
+				  "rpmsg");
+	if (ret < 0) {
+		pr_err("rpmsg: failed to allocate char dev region\n");
+		return ret;
+	}
+
+	ret = register_rpmsg_driver(&rpmsg_raw_client);
+	if (ret < 0)
+		unregister_chrdev_region(rpmsg_raw_major, RPMSG_DEV_MAX);
+
+	return ret;
+}
+module_init(rpmsg_raw_init);
+
+static void rpmsg_raw_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_raw_client);
+	unregister_chrdev_region(rpmsg_raw_major, RPMSG_DEV_MAX);
+}
+module_exit(rpmsg_raw_exit);
+
+MODULE_DESCRIPTION("RPMSG raw service driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_ALIAS("rpmsg_raw");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

