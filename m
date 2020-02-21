Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A983C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256E924650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBUQof convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:44:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:44:34 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2AEA7294A83;
        Fri, 21 Feb 2020 16:44:32 +0000 (GMT)
Date:   Fri, 21 Feb 2020 17:44:28 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Message-ID: <20200221174428.77696ab6@collabora.com>
In-Reply-To: <20200221135911.1300170b@collabora.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
        <20200219073548.GA2728338@kroah.com>
        <CH2PR12MB4216D5141E562974634430B8AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
        <20200221115229.GA116368@kroah.com>
        <20200221135911.1300170b@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 13:59:11 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 21 Feb 2020 12:52:29 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Feb 21, 2020 at 11:47:22AM +0000, Vitor Soares wrote:  
> > > Hi Greg,
> > > 
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Date: Wed, Feb 19, 2020 at 07:35:48
> > >     
> > > > On Wed, Feb 19, 2020 at 01:20:41AM +0100, Vitor Soares wrote:    
> > > > > Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.
> > > > > 
> > > > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > > > ---
> > > > >  drivers/i3c/internals.h |  1 +
> > > > >  drivers/i3c/master.c    | 12 ++++++++++++
> > > > >  2 files changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> > > > > index bc062e8..a6deedf 100644
> > > > > --- a/drivers/i3c/internals.h
> > > > > +++ b/drivers/i3c/internals.h
> > > > > @@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
> > > > >  int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
> > > > >  			       const struct i3c_ibi_setup *req);
> > > > >  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> > > > > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
> > > > >  #endif /* I3C_INTERNAL_H */
> > > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > > > index 21c4372..8e22da2 100644
> > > > > --- a/drivers/i3c/master.c
> > > > > +++ b/drivers/i3c/master.c
> > > > > @@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
> > > > >  	dev->ibi = NULL;
> > > > >  }
> > > > >  
> > > > > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
> > > > > +{
> > > > > +	int res;
> > > > > +
> > > > > +	mutex_lock(&i3c_core_lock);
> > > > > +	res = bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
> > > > > +	mutex_unlock(&i3c_core_lock);    
> > > > 
> > > > Ick, why the lock?  Are you _sure_ you need that?  The core should
> > > > handle any list locking issues here, right?    
> > > 
> > > I want to make sure that no new devices (eg: Hot-Join capable device) are 
> > > added during this iteration and after this call, each new device will 
> > > release a bus notification.
> > >     
> > > > 
> > > > I don't see bus-specific-locks around other subsystem functions that do
> > > > this (like usb_for_each_dev).    
> > > 
> > > I based in I2C use case.    
> > 
> > Check to see if this is really needed, for some reason I doubt it...  
> 
> Can we please try the spidev approach before fixing those problems. None
> of that would be needed if we declare the i3cdev driver as a regular
> i3c_device_driver and let user space bind devices it wants to expose
> through the sysfs interface. As I said earlier, we even have all the
> pieces we need to automate that using a udev rule, and the resulting
> patchset would be 'less invasive'/simpler for pretty much the same
> result.

So, I went ahead and implemented it the way I suggest. The diffstat is
not representative here (though it's still in favor of this new version)
since I also changed the way we expose/handle SDR transfers. What's
most important IMO is the fact that

* we no longer need to access the internal I3C API
* we no longer need to care about transitions between i3cdev and
  other drivers (the core guarantees that a device is always bound to at
  most one driver)
* the registration/unregistration procedure is simplified

Not all problems have been addressed (we still need to put a limit on
the number of xfers and the max size per transfer we allow, and
probably plenty of other things pointed by Greg, Arnd and others), but
I'd really like to start from there for the next version.

--->8---
From a344e3c51db4e414e4ec6007c001c32afa954a82 Mon Sep 17 00:00:00 2001
From: Vitor Soares <Vitor.Soares@synopsys.com>
Date: Wed, 19 Feb 2020 01:20:42 +0100
Subject: [PATCH] i3c: add i3cdev module to expose i3c dev in /dev

This patch adds user mode support to I3C SDR transfers.

The module is based on spidev with the follow features:
  - Dynamically allocate the char device Major number.
  - Expose SDR (Single Data Rate) transfers

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 324 ++++++++++++++++++++++++++++++++
 include/uapi/linux/i3c/i3cdev.h |  38 ++++
 4 files changed, 378 insertions(+)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a441506f61..01642768ab5f 100644
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
index 11982efbc6d9..606d422841b2 100644
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
index 000000000000..2b408a446ab6
--- /dev/null
+++ b/drivers/i3c/i3cdev.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <soares@synopsys.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i3c/device.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/i3c/i3cdev.h>
+
+#define MAX_I3CDEV_DEVS (MINORMASK + 1)
+
+struct i3cdev_data {
+	struct i3c_device *i3c;
+	struct device *dev;
+	struct cdev cdev;
+	dev_t devt;
+};
+
+static DEFINE_IDA(i3cdev_ida);
+static dev_t i3cdev_first_chrdev;
+
+static ssize_t
+i3cdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
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
+	dev_dbg(i3cdev->dev, "Reading %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	if (!ret)
+		ret = copy_to_user(buf, tmp, xfers.len) ? -EFAULT : xfers.len;
+
+	kfree(tmp);
+	return ret;
+}
+
+static ssize_t
+i3cdev_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
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
+	dev_dbg(i3cdev->dev, "Writing %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	kfree(tmp);
+
+	return !ret ? count : ret;
+}
+
+static int
+i3cdev_ioctl_priv_xfers(struct i3c_device *i3c,
+			struct i3cdev_priv_xfers __user *uxfers)
+{
+	struct i3cdev_priv_xfers xfers;
+	struct i3cdev_priv_xfer *uxfer_array;
+	struct i3c_priv_xfer *xfer_array;
+	unsigned int i;
+	int ret;
+
+	if (copy_from_user(&xfers, uxfers, sizeof(xfers)))
+		return -EFAULT;
+
+	/* TODO: Add a limit for xfers.nxfers. */
+	uxfer_array = memdup_user(u64_to_user_ptr(xfers.xfers),
+				  xfers.nxfers * sizeof(*uxfer_array));
+	if (!uxfer_array)
+		return -ENOMEM;
+
+	xfer_array = kmalloc_array(xfers.nxfers, sizeof(*xfer_array),
+				   GFP_KERNEL);
+	if (!xfer_array) {
+		ret = -ENOMEM;
+		goto out_free_uxfer_array;
+	}
+
+	/* TODO Add a limit for max in/out size. */
+	for (i = 0; i < xfers.nxfers; i++) {
+		void __user *udata = u64_to_user_ptr(uxfer_array[i].data);
+		void *data;
+
+		xfer_array[i].rnw = uxfer_array[i].rnw;
+		xfer_array[i].len = uxfer_array[i].len;
+
+		if (!xfer_array[i].rnw) {
+			data = memdup_user(udata, xfer_array[i].len);
+		} else {
+			data = kzalloc(xfer_array[i].len, GFP_KERNEL);
+			if (data)
+				data = ERR_PTR(-ENOMEM);
+		}
+
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(xfer_array[i].data.in);
+			goto out_free_xfer_array;
+		}
+
+		xfer_array[i].data.in = data;
+	}
+
+	ret = i3c_device_do_priv_xfers(i3c, xfer_array, xfers.nxfers);
+
+	if (!ret) {
+		for (i = 0; i < xfers.nxfers; i++) {
+			void __user *udata = u64_to_user_ptr(uxfer_array[i].data);
+			void *data = xfer_array[i].data.in;
+
+			if (!xfer_array[i].rnw)
+				continue;
+
+			if (copy_to_user(udata, data, xfer_array[i].len)) {
+				ret = -EFAULT;
+				goto out_free_xfer_array;
+			}
+		}
+	}
+
+out_free_xfer_array:
+	for (i = 0; i < xfers.nxfers; i++)
+		kfree(xfer_array[i].data.in);
+
+	kfree(xfer_array);
+
+out_free_uxfer_array:
+	kfree(uxfer_array);
+	return ret;
+}
+
+static long
+i3cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret = -EACCES;
+
+	dev_dbg(i3cdev->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n", cmd, arg);
+
+	switch (cmd) {
+	case I3CDEV_PRIV_XFER:
+		ret = i3cdev_ioctl_priv_xfers(i3cdev->i3c, udata);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return ret;
+}
+
+static int i3cdev_open(struct inode *inode, struct file *file)
+{
+	struct i3cdev_data *i3cdev = container_of(inode->i_cdev,
+						  struct i3cdev_data,
+						  cdev);
+	file->private_data = i3cdev;
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
+	.owner = THIS_MODULE,
+	.read = i3cdev_read,
+	.write = i3cdev_write,
+	.unlocked_ioctl	= i3cdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.open = i3cdev_open,
+	.release = i3cdev_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+static struct class *i3cdev_class;
+
+static int i3cdev_probe(struct i3c_device *i3c)
+{
+	struct device *dev = i3cdev_to_dev(i3c);
+	struct i3cdev_data *i3cdev;
+	int ret;
+	int id;
+
+	i3cdev = devm_kzalloc(dev, sizeof(*i3cdev), GFP_KERNEL);
+	if (!i3cdev)
+		return -ENOMEM;
+
+	ret = ida_simple_get(&i3cdev_ida, 0, MAX_I3CDEV_DEVS, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(dev, "no minor number available!\n");
+		return ret;
+	}
+
+	i3cdev->i3c = i3c;
+	i3cdev->devt = MKDEV(MAJOR(i3cdev_first_chrdev),
+			     MINOR(i3cdev_first_chrdev) + ret);
+	i3cdev_set_drvdata(i3c, i3cdev);
+	cdev_init(&i3cdev->cdev, &i3cdev_fops);
+	i3cdev->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&i3cdev->cdev, i3cdev->devt, 1);
+	if (ret)
+		goto error_free_id;
+
+	i3cdev->dev = device_create(i3cdev_class, dev, i3cdev->devt,
+				    NULL, "i3cdev%d", id);
+	if (IS_ERR(i3cdev->dev)) {
+		ret = PTR_ERR(i3cdev->dev);
+		goto error_free_cdev;
+	}
+
+	return 0;
+
+error_free_cdev:
+	cdev_del(&i3cdev->cdev);
+error_free_id:
+	ida_free(&i3cdev_ida,
+		 MINOR(i3cdev->devt) - MINOR(i3cdev_first_chrdev));
+	return ret;
+}
+
+static int i3cdev_remove(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+
+	i3cdev = i3cdev_get_drvdata(i3c);
+
+	device_destroy(i3cdev_class, i3cdev->devt);
+	cdev_del(&i3cdev->cdev);
+	ida_simple_remove(&i3cdev_ida,
+			  MINOR(i3cdev->devt) - MINOR(i3cdev_first_chrdev));
+
+	return 0;
+}
+
+static const struct i3c_device_id i3cdev_ids[] = {
+	{ /* Sentinel */ },
+};
+
+static struct i3c_driver i3cdev_driver = {
+	.probe = i3cdev_probe,
+	.remove = i3cdev_remove,
+	.id_table = i3cdev_ids,
+};
+
+static int __init i3cdev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&i3cdev_first_chrdev, 0, MAX_I3CDEV_DEVS,
+				  "i3cdev");
+	if (ret)
+		return ret;
+
+	i3cdev_class = class_create(THIS_MODULE, "i3cdev");
+	if (IS_ERR(i3cdev_class))
+		goto err_unreg_chrdev_region;
+
+	ret = i3c_driver_register(&i3cdev_driver);
+	if (ret)
+		goto err_destroy_class;
+
+	return 0;
+
+err_destroy_class:
+	class_destroy(i3cdev_class);
+err_unreg_chrdev_region:
+	unregister_chrdev_region(i3cdev_first_chrdev, MAX_I3CDEV_DEVS);
+	return ret;
+}
+module_init(i3cdev_init);
+
+static void __exit i3cdev_exit(void)
+{
+	i3c_driver_unregister(&i3cdev_driver);
+	class_destroy(i3cdev_class);
+	unregister_chrdev_region(i3cdev_first_chrdev, MAX_I3CDEV_DEVS);
+}
+module_exit(i3cdev_exit);
+
+MODULE_AUTHOR("Vitor Soares <soares@synopsys.com>");
+MODULE_DESCRIPTION("I3C /dev entries driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/i3c/i3cdev.h b/include/uapi/linux/i3c/i3cdev.h
new file mode 100644
index 000000000000..305dc029ca2d
--- /dev/null
+++ b/include/uapi/linux/i3c/i3cdev.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
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
+struct i3cdev_priv_xfer {
+	__u64 data;
+	__u16 len;
+	__u8 rnw;
+	__u8 pad[5];
+};
+
+struct i3cdev_priv_xfers {
+	__u64 nxfers;
+	__u64 xfers;
+};
+
+#define I3CDEV_PRIV_XFER \
+	_IOWR(I3C_DEV_IOC_MAGIC, 0, struct i3cdev_priv_xfers)
+
+#endif
-- 
2.24.1

