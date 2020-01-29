Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2EC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B69B214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iGn+kHEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgA2MRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:44 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:40422 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbgA2MRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:42 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5A68540828;
        Wed, 29 Jan 2020 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580300261; bh=boMhbcOAYznxmwPqAtybtUTe7IenhzlnxVHicHUsTjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iGn+kHEKBOy6dmSMBtBerde/GCxjE+ihlJ6Cap9xUvvH7QmlE4an0l1f57TSFuSsa
         y1EuWIPA7BwgUgq/T5r7krV1fC88VChu5TPZZ6Ixsv5SFKmPrQqGyI1Hqcw5xdWyae
         oCIyY+epuT9RtlsPV+EVebT3LKa6mLVxOlgC9ZdHgBDOmOU9wVZ8dv6rYWi0QVA5TE
         PFoz5MQFucyjR3pgk92Yr6b3cJu0QHOpENwHmRvyRmFbgkp83NnteybZNuN1J8QTdf
         pq3R1Mot+BRe+UUirVM/aaIjAIHkdHgSUQZ7KWF/yP2DVO0MnSiHJ7o6hFT1JWacmT
         aGbNQ97L2+Saw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8BD19A0078;
        Wed, 29 Jan 2020 12:17:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 70FCC3F041;
        Wed, 29 Jan 2020 13:17:38 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC v2 4/4] i3c: add i3cdev module to expose i3c dev in /dev
Date:   Wed, 29 Jan 2020 13:17:35 +0100
Message-Id: <442a0c2c52223f9ff1a1d1018ff863fb23105389.1580299067.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds user mode support to I3C SDR transfers.

The module is based on i2c-dev.c with the follow features:
  - expose on /dev the i3c devices dynamically based on if they have
    a device driver bound.
  - Dynamically allocate the char device Major number.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 429 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/i3c/i3cdev.h |  38 ++++
 4 files changed, 483 insertions(+)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a4415..0164276 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -20,5 +20,20 @@ menuconfig I3C
 	  will be called i3c.
 
 if I3C
+
+config I3CDEV
+	tristate "I3C device interface"
+	depends on I3C
+	help
+	  Say Y here to use i3c-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the I3C devices.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i3cdev.
+
+	  Note that this application programming interface is EXPERIMENTAL
+	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
+
 source "drivers/i3c/master/Kconfig"
 endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982ef..606d422 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3CDEV)		+= i3cdev.o
 obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/i3cdev.c b/drivers/i3c/i3cdev.c
new file mode 100644
index 0000000..f1140dc
--- /dev/null
+++ b/drivers/i3c/i3cdev.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <soares@synopsys.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/i3c/i3cdev.h>
+
+#include "internals.h"
+
+struct i3cdev_data {
+	struct list_head list;
+	struct i3c_device *i3c;
+	struct cdev cdev;
+	struct device *dev;
+	int id;
+};
+
+static DEFINE_IDA(i3cdev_ida);
+static dev_t i3cdev_number;
+#define I3C_MINORS 16 /* 16 I3C devices supported for now */
+
+static LIST_HEAD(i3cdev_list);
+static DEFINE_SPINLOCK(i3cdev_list_lock);
+
+static struct i3cdev_data *i3cdev_get_by_i3c(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+
+	spin_lock(&i3cdev_list_lock);
+	list_for_each_entry(i3cdev, &i3cdev_list, list) {
+		if (i3cdev->i3c == i3c)
+			goto found;
+	}
+
+	i3cdev = NULL;
+
+found:
+	spin_unlock(&i3cdev_list_lock);
+	return i3cdev;
+}
+
+static struct i3cdev_data *get_free_i3cdev(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+	int id;
+
+	id = ida_simple_get(&i3cdev_ida, 0, I3C_MINORS, GFP_KERNEL);
+	if (id < 0) {
+		pr_err("i3cdev: no minor number available!\n");
+		return ERR_PTR(id);
+	}
+
+	i3cdev = kzalloc(sizeof(*i3cdev), GFP_KERNEL);
+	if (!i3cdev) {
+		ida_simple_remove(&i3cdev_ida, id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	i3cdev->i3c = i3c;
+	i3cdev->id = id;
+
+	spin_lock(&i3cdev_list_lock);
+	list_add_tail(&i3cdev->list, &i3cdev_list);
+	spin_unlock(&i3cdev_list_lock);
+
+	return i3cdev;
+}
+
+static void put_i3cdev(struct i3cdev_data *i3cdev)
+{
+	spin_lock(&i3cdev_list_lock);
+	list_del(&i3cdev->list);
+	spin_unlock(&i3cdev_list_lock);
+	kfree(i3cdev);
+}
+
+static ssize_t
+i3cdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct i3c_device *i3c = file->private_data;
+	struct i3c_priv_xfer xfers = {
+		.rnw = true,
+		.len = count,
+	};
+	char *tmp;
+	int ret;
+
+	tmp = kzalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	xfers.data.in = tmp;
+
+	dev_dbg(&i3c->dev, "Reading %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	if (!ret)
+		ret = copy_to_user(buf, tmp, count) ? -EFAULT : ret;
+
+	kfree(tmp);
+	return ret;
+}
+
+static ssize_t
+i3cdev_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *f_pos)
+{
+	struct i3c_device *i3c = file->private_data;
+	struct i3c_priv_xfer xfers = {
+		.rnw = false,
+		.len = count,
+	};
+	char *tmp;
+	int ret;
+
+	tmp = memdup_user(buf, count);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	xfers.data.out = tmp;
+
+	dev_dbg(&i3c->dev, "Writing %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	kfree(tmp);
+	return (!ret) ? count : ret;
+}
+
+static int
+i3cdev_do_priv_xfer(struct i3c_device *dev, struct i3c_ioc_priv_xfer *xfers,
+		    unsigned int nxfers)
+{
+	struct i3c_priv_xfer *k_xfers;
+	u8 **data_ptrs;
+	int i, ret = 0;
+
+	k_xfers = kcalloc(nxfers, sizeof(*k_xfers), GFP_KERNEL);
+	if (!k_xfers)
+		return -ENOMEM;
+
+	data_ptrs = kcalloc(nxfers, sizeof(*data_ptrs), GFP_KERNEL);
+	if (!data_ptrs) {
+		ret = -ENOMEM;
+		goto err_free_k_xfer;
+	}
+
+	for (i = 0; i < nxfers; i++) {
+		data_ptrs[i] = memdup_user((const u8 __user *)
+					   (uintptr_t)xfers[i].data,
+					   xfers[i].len);
+		if (IS_ERR(data_ptrs[i])) {
+			ret = PTR_ERR(data_ptrs[i]);
+			break;
+		}
+
+		k_xfers[i].len = xfers[i].len;
+		if (xfers[i].rnw) {
+			k_xfers[i].rnw = true;
+			k_xfers[i].data.in = data_ptrs[i];
+		} else {
+			k_xfers[i].rnw = false;
+			k_xfers[i].data.out = data_ptrs[i];
+		}
+	}
+
+	if (ret < 0) {
+		i--;
+		goto err_free_mem;
+	}
+
+	ret = i3c_device_do_priv_xfers(dev, k_xfers, nxfers);
+	if (ret)
+		goto err_free_mem;
+
+	for (i = 0; i < nxfers; i++) {
+		if (xfers[i].rnw) {
+			if (copy_to_user((void __user *)(uintptr_t)xfers[i].data,
+					 data_ptrs[i], xfers[i].len))
+				ret = -EFAULT;
+		}
+	}
+
+err_free_mem:
+	for (; i >= 0; i--)
+		kfree(data_ptrs[i]);
+	kfree(data_ptrs);
+err_free_k_xfer:
+	kfree(k_xfers);
+	return ret;
+}
+
+static struct i3c_ioc_priv_xfer *
+i3cdev_get_ioc_priv_xfer(unsigned int cmd, struct i3c_ioc_priv_xfer *u_xfers,
+			 unsigned int *nxfers)
+{
+	u32 tmp = _IOC_SIZE(cmd);
+
+	if ((tmp % sizeof(struct i3c_ioc_priv_xfer)) != 0)
+		return ERR_PTR(-EINVAL);
+
+	*nxfers = tmp / sizeof(struct i3c_ioc_priv_xfer);
+	if (*nxfers == 0)
+		return NULL;
+
+	return memdup_user(u_xfers, tmp);
+}
+
+static int
+i3cdev_ioc_priv_xfer(struct i3c_device *i3c, unsigned int cmd,
+		     struct i3c_ioc_priv_xfer *u_xfers)
+{
+	struct i3c_ioc_priv_xfer *k_xfers;
+	unsigned int nxfers;
+	int ret;
+
+	k_xfers = i3cdev_get_ioc_priv_xfer(cmd, u_xfers, &nxfers);
+	if (IS_ERR_OR_NULL(k_xfers))
+		return PTR_ERR(k_xfers);
+
+	ret = i3cdev_do_priv_xfer(i3c, k_xfers, nxfers);
+
+	kfree(k_xfers);
+
+	return ret;
+}
+
+static long
+i3cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i3c_device *i3c = file->private_data;
+
+	dev_dbg(&i3c->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n", cmd, arg);
+
+	if (_IOC_TYPE(cmd) != I3C_DEV_IOC_MAGIC)
+		return -ENOTTY;
+
+	/* Check command number and direction */
+	if (_IOC_NR(cmd) == _IOC_NR(I3C_IOC_PRIV_XFER(0)) &&
+	    _IOC_DIR(cmd) == (_IOC_READ | _IOC_WRITE))
+		return i3cdev_ioc_priv_xfer(i3c, cmd,
+					(struct i3c_ioc_priv_xfer __user *)arg);
+
+	return 0;
+}
+
+static int i3cdev_open(struct inode *inode, struct file *file)
+{
+	struct i3cdev_data *i3cdev = container_of(inode->i_cdev,
+						  struct i3cdev_data,
+						  cdev);
+
+	file->private_data = i3cdev->i3c;
+
+	return 0;
+}
+
+static int i3cdev_release(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations i3cdev_fops = {
+	.owner		= THIS_MODULE,
+	.read		= i3cdev_read,
+	.write		= i3cdev_write,
+	.unlocked_ioctl	= i3cdev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.open		= i3cdev_open,
+	.release	= i3cdev_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+static struct class *i3cdev_class;
+
+static int i3cdev_attach(struct device *dev, void *dummy)
+{
+	struct i3cdev_data *i3cdev;
+	struct i3c_device *i3c;
+	int res;
+
+	if (dev->type == &i3c_masterdev_type || dev->driver)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	/* Get a device */
+	i3cdev = get_free_i3cdev(i3c);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	cdev_init(&i3cdev->cdev, &i3cdev_fops);
+	i3cdev->cdev.owner = THIS_MODULE;
+	res = cdev_add(&i3cdev->cdev,
+		       MKDEV(MAJOR(i3cdev_number), i3cdev->id), 1);
+	if (res)
+		goto error_cdev;
+
+	/* register this i3c device with the driver core */
+	i3cdev->dev = device_create(i3cdev_class, &i3c->dev,
+				    MKDEV(MAJOR(i3cdev_number), i3cdev->id),
+				    NULL, "i3c-%s", dev_name(&i3c->dev));
+	if (IS_ERR(i3cdev->dev)) {
+		res = PTR_ERR(i3cdev->dev);
+		goto error;
+	}
+	pr_debug("i3cdev: I3C device [%s] registered as minor %d\n",
+		 dev_name(&i3c->dev), i3cdev->id);
+	return 0;
+
+error:
+	cdev_del(&i3cdev->cdev);
+error_cdev:
+	put_i3cdev(i3cdev);
+	return res;
+}
+
+static int i3cdev_detach(struct device *dev, void *dummy)
+{
+	struct i3cdev_data *i3cdev;
+	struct i3c_device *i3c;
+
+	if (dev->type == &i3c_masterdev_type)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	i3cdev = i3cdev_get_by_i3c(i3c);
+	if (!i3cdev)
+		return 0;
+
+	cdev_del(&i3cdev->cdev);
+	device_destroy(i3cdev_class, MKDEV(MAJOR(i3cdev_number), i3cdev->id));
+	ida_simple_remove(&i3cdev_ida, i3cdev->id);
+	put_i3cdev(i3cdev);
+
+	pr_debug("i3cdev: device [%s] unregistered\n", dev_name(&i3c->dev));
+
+	return 0;
+}
+
+static int i3cdev_notifier_call(struct notifier_block *nb,
+				unsigned long action,
+				void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		return i3cdev_attach(dev, NULL);
+	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_BOUND_DRIVER:
+		return i3cdev_detach(dev, NULL);
+	}
+
+	return 0;
+}
+
+static struct notifier_block i3c_notifier = {
+	.notifier_call = i3cdev_notifier_call,
+};
+
+static int __init i3cdev_init(void)
+{
+	int res;
+
+	/* Dynamically request unused major number */
+	res = alloc_chrdev_region(&i3cdev_number, 0, I3C_MINORS, "i3c");
+	if (res)
+		goto out;
+
+	/* Create a classe to populate sysfs entries*/
+	i3cdev_class = class_create(THIS_MODULE, "i3cdev");
+	if (IS_ERR(i3cdev_class)) {
+		res = PTR_ERR(i3cdev_class);
+		goto out_unreg_chrdev;
+	}
+
+	/* Keep track of busses which have devices to add or remove later */
+	res = bus_register_notifier(&i3c_bus_type, &i3c_notifier);
+	if (res)
+		goto out_unreg_class;
+
+	/* Bind to already existing device without driver right away */
+	i3c_for_each_dev(NULL, i3cdev_attach);
+
+	return 0;
+
+out_unreg_class:
+	class_destroy(i3cdev_class);
+out_unreg_chrdev:
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+out:
+	pr_err("%s: Driver Initialisation failed\n", __FILE__);
+	return res;
+}
+
+static void __exit i3cdev_exit(void)
+{
+	bus_unregister_notifier(&i3c_bus_type, &i3c_notifier);
+	i3c_for_each_dev(NULL, i3cdev_detach);
+	class_destroy(i3cdev_class);
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+}
+
+MODULE_AUTHOR("Vitor Soares <soares@synopsys.com>");
+MODULE_DESCRIPTION("I3C /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(i3cdev_init);
+module_exit(i3cdev_exit);
diff --git a/include/uapi/linux/i3c/i3cdev.h b/include/uapi/linux/i3c/i3cdev.h
new file mode 100644
index 0000000..0897313
--- /dev/null
+++ b/include/uapi/linux/i3c/i3cdev.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#ifndef _UAPI_I3C_DEV_H_
+#define _UAPI_I3C_DEV_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* IOCTL commands */
+#define I3C_DEV_IOC_MAGIC	0x07
+
+/**
+ * struct i3c_ioc_priv_xfer - I3C SDR ioctl private transfer
+ * @data: Holds pointer to userspace buffer with transmit data.
+ * @len: Length of data buffer buffers, in bytes.
+ * @rnw: encodes the transfer direction. true for a read, false for a write
+ */
+struct i3c_ioc_priv_xfer {
+	__u64 data;
+	__u16 len;
+	__u8 rnw;
+	__u8 pad[5];
+};
+
+
+#define I3C_PRIV_XFER_SIZE(N)	\
+	((((sizeof(struct i3c_ioc_priv_xfer)) * (N)) < (1 << _IOC_SIZEBITS)) \
+	? ((sizeof(struct i3c_ioc_priv_xfer)) * (N)) : 0)
+
+#define I3C_IOC_PRIV_XFER(N)	\
+	_IOC(_IOC_READ|_IOC_WRITE, I3C_DEV_IOC_MAGIC, 30, I3C_PRIV_XFER_SIZE(N))
+
+#endif
-- 
2.7.4

