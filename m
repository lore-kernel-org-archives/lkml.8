Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38607C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F5420714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCYI5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:57:37 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56571 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727504AbgCYI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:57:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0347911-0.000129059-0.96508;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:27 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Subject: [PATCH v3 02/11] pstore/blk: new support logger for block devices
Date:   Wed, 25 Mar 2020 16:54:57 +0800
Message-Id: <1585126506-18635-3-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore/blk is similar to pstore/ram, but dump log to block device
rather than persistent ram.

Why do we need pstore/blk?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

Pstore/blk provides efficient configuration method. It divides all
configurations into 2 parts, configurations for user and
configurations for driver.

Configurations for user detemine how pstore/blk work, such as
dump_oops and oops_size. They can be set by Kconfig and module
parameter, but module parameter has priority over Kconfig.

Configurations for driver are all about block device, such as
total_size of device and read/write operations. They should be provided
by device drivers, calling psblk_register_blkdev().

If block device do not support panic write, @panic_write can be NULL.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig          |  62 +++++++
 fs/pstore/Makefile         |   2 +
 fs/pstore/pstore_blk.c     | 425 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_blk.h |  27 +++
 4 files changed, 516 insertions(+)
 create mode 100644 fs/pstore/pstore_blk.c
 create mode 100644 include/linux/pstore_blk.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 5ad4ab68ac4f..590af61019c2 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -160,3 +160,65 @@ config PSTORE_ZONE
 	help
 	  The common layer for pstore/blk (and pstore/ram in the future)
 	  to manager storage as zones.
+
+config PSTORE_BLK
+	tristate "Log panic/oops to a block device"
+	depends on PSTORE
+	depends on BLOCK
+	select PSTORE_ZONE
+	default n
+	help
+	  This enables panic and oops message to be logged to a block dev
+	  where it can be read back at some later point.
+
+	  If unsure, say N.
+
+config PSTORE_BLK_BLKDEV
+	string "block device identifier"
+	depends on PSTORE_BLK
+	default ""
+	help
+	  Which block device should be used for pstore/blk.
+
+	  It accept the following variants:
+	  1) <hex_major><hex_minor> device number in hexadecimal represents
+	     itself no leading 0x, for example b302.
+	  2) /dev/<disk_name> represents the device number of disk
+	  3) /dev/<disk_name><decimal> represents the device number
+	     of partition - device number of disk plus the partition number
+	  4) /dev/<disk_name>p<decimal> - same as the above, this form is
+	     used when disk name of partitioned disk ends with a digit.
+	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+	     unique id of a partition if the partition table provides it.
+	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+	     filled hex representation of the 32-bit "NT disk signature", and PP
+	     is a zero-filled hex representation of the 1-based partition number.
+	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
+	     to a partition with a known unique id.
+	  7) <major>:<minor> major and minor number of the device separated by
+	     a colon.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
+config PSTORE_BLK_OOPS_SIZE
+	int "Size in Kbytes of oops/panic log to store"
+	depends on PSTORE_BLK
+	default 64
+	help
+	  This just sets size of oops/panic log (oops_size) for pstore/blk.
+	  The size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
+config PSTORE_BLK_DUMP_OOPS
+	bool "dump oops"
+	depends on PSTORE_BLK
+	default y
+	help
+	  Whether pstore/blk dumps oops or not.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 94f3631c80ce..0e1c5faf7a0b 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -14,3 +14,5 @@ ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
+
+obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
new file mode 100644
index 000000000000..2fbdd4563e5c
--- /dev/null
+++ b/fs/pstore/pstore_blk.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define MODNAME "pstore-blk"
+#define pr_fmt(fmt) MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pstore_blk.h>
+#include <linux/mount.h>
+#include <linux/uio.h>
+
+static long oops_size = CONFIG_PSTORE_BLK_OOPS_SIZE;
+module_param(oops_size, long, 0400);
+MODULE_PARM_DESC(oops_size, "oops size in kbytes");
+
+static int dump_oops = CONFIG_PSTORE_BLK_DUMP_OOPS;
+module_param(dump_oops, int, 0400);
+MODULE_PARM_DESC(total_size, "whether dump oops");
+
+/*
+ * blkdev - The block device to use.
+ *
+ * Most of the time, it is a partition of block device.
+ *
+ * blkdev accepts the following variants:
+ * 1) <hex_major><hex_minor> device number in hexadecimal represents itself
+ *    no leading 0x, for example b302.
+ * 2) /dev/<disk_name> represents the device number of disk
+ * 3) /dev/<disk_name><decimal> represents the device number
+ *    of partition - device number of disk plus the partition number
+ * 4) /dev/<disk_name>p<decimal> - same as the above, that form is
+ *    used when disk name of partitioned disk ends on a digit.
+ * 5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+ *    unique id of a partition if the partition table provides it.
+ *    The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+ *    partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+ *    filled hex representation of the 32-bit "NT disk signature", and PP
+ *    is a zero-filled hex representation of the 1-based partition number.
+ * 6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
+ *    a partition with a known unique id.
+ * 7) <major>:<minor> major and minor number of the device separated by
+ *    a colon.
+ */
+static char blkdev[80] = CONFIG_PSTORE_BLK_BLKDEV;
+module_param_string(blkdev, blkdev, 80, 0400);
+MODULE_PARM_DESC(blkdev, "the block device for general read/write");
+
+static DEFINE_MUTEX(psz_lock);
+static struct block_device *psblk_bdev;
+static struct psz_info *psz_info;
+static psblk_panic_write_op blkdev_panic_write;
+static struct bdev_info {
+	dev_t devt;
+	sector_t nr_sects;
+	sector_t start_sect;
+} g_bdev_info;
+
+/**
+ * struct psblk_device - back-end pstore/blk driver structure.
+ *
+ * @total_size: The total size in bytes pstore/blk can use. It must be greater
+ *		than 4096 and be multiple of 4096.
+ * @read:	The general read operation. Both of the function parameters
+ *		@size and @offset are relative value to bock device (not the
+ *		whole disk).
+ *		On success, the number of bytes should be returned, others
+ *		means error.
+ * @write:	The same as @read.
+ * @panic_write:The write operation only used for panic case. It's optional
+ *		if you do not care panic log. The parameters and return value
+ *		are the same as @read.
+ */
+struct psblk_device {
+	unsigned long total_size;
+	psz_read_op read;
+	psz_write_op write;
+	psz_write_op panic_write;
+};
+
+static int psblk_register_do(struct psblk_device *dev)
+{
+	int ret;
+
+	if (!dev || !dev->total_size || !dev->read || !dev->write)
+		return -EINVAL;
+
+	mutex_lock(&psz_lock);
+
+	/* someone already registered before */
+	if (psz_info) {
+		mutex_unlock(&psz_lock);
+		return -EBUSY;
+	}
+	psz_info = kzalloc(sizeof(struct psz_info), GFP_KERNEL);
+	if (!psz_info) {
+		mutex_unlock(&psz_lock);
+		return -ENOMEM;
+	}
+
+#define verify_size(name, alignsize) {					\
+		long _##name_ = (name);					\
+		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+		if (_##name_ & ((alignsize) - 1)) {			\
+			pr_info(#name " must align to %d\n",		\
+					(alignsize));			\
+			_##name_ = ALIGN(name, (alignsize));		\
+		}							\
+		name = _##name_ / 1024;					\
+		psz_info->name = _##name_;				\
+	}
+
+	verify_size(oops_size, 4096);
+#undef verify_size
+	dump_oops = dump_oops <= 0 ? 0 : 1;
+
+	psz_info->total_size = dev->total_size;
+	psz_info->dump_oops = dump_oops;
+	psz_info->read = dev->read;
+	psz_info->write = dev->write;
+	psz_info->panic_write = dev->panic_write;
+	psz_info->name = MODNAME;
+	psz_info->owner = THIS_MODULE;
+
+	ret = psz_register(psz_info);
+	if (ret) {
+		kfree(psz_info);
+		psz_info = NULL;
+	}
+	mutex_unlock(&psz_lock);
+	return ret;
+}
+
+static void psblk_unregister_do(struct psblk_device *dev)
+{
+	mutex_lock(&psz_lock);
+	if (psz_info && psz_info->read == dev->read) {
+		psz_unregister(psz_info);
+		kfree(psz_info);
+		psz_info = NULL;
+	}
+	mutex_unlock(&psz_lock);
+}
+
+/**
+ * psblk_get_bdev() - open block device
+ * @holder: exclusive holder identifier
+ *
+ * Return: pointer to block device on success and others on error.
+ *
+ * On success, the returned block_device has reference count of one.
+ */
+static struct block_device *psblk_get_bdev(void *holder)
+{
+	struct block_device *bdev = ERR_PTR(-ENODEV);
+	fmode_t mode = FMODE_READ | FMODE_WRITE;
+
+	if (!blkdev[0])
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&psz_lock);
+	if (psz_info)
+		goto out;
+	if (holder)
+		mode |= FMODE_EXCL;
+	bdev = blkdev_get_by_path(blkdev, mode, holder);
+	if (IS_ERR(bdev)) {
+		dev_t devt;
+
+		devt = name_to_dev_t(blkdev);
+		if (devt == 0) {
+			bdev = ERR_PTR(-ENODEV);
+			goto out;
+		}
+		bdev = blkdev_get_by_dev(devt, mode, holder);
+	}
+out:
+	mutex_unlock(&psz_lock);
+	return bdev;
+}
+
+static void psblk_put_bdev(struct block_device *bdev, void *holder)
+{
+	fmode_t mode = FMODE_READ | FMODE_WRITE;
+
+	if (!bdev)
+		return;
+
+	mutex_lock(&psz_lock);
+	if (holder)
+		mode |= FMODE_EXCL;
+	blkdev_put(bdev, mode);
+	mutex_unlock(&psz_lock);
+}
+
+static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
+{
+	struct block_device *bdev = psblk_bdev;
+	struct file file;
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	struct kvec iov = {.iov_base = buf, .iov_len = bytes};
+
+	if (!bdev)
+		return -ENODEV;
+
+	memset(&file, 0, sizeof(struct file));
+	file.f_mapping = bdev->bd_inode->i_mapping;
+	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
+	file.f_inode = bdev->bd_inode;
+	file_ra_state_init(&file.f_ra, file.f_mapping);
+
+	init_sync_kiocb(&kiocb, &file);
+	kiocb.ki_pos = pos;
+	iov_iter_kvec(&iter, READ, &iov, 1, bytes);
+
+	return generic_file_read_iter(&kiocb, &iter);
+}
+
+static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
+		loff_t pos)
+{
+	struct block_device *bdev = psblk_bdev;
+	struct iov_iter iter;
+	struct kiocb kiocb;
+	struct file file;
+	ssize_t ret;
+	struct kvec iov = {.iov_base = (void *)buf, .iov_len = bytes};
+
+	if (!bdev)
+		return -ENODEV;
+
+	/* Console/Ftrace recorder may handle buffer until flush dirty zones */
+	if (in_interrupt() || irqs_disabled())
+		return -EBUSY;
+
+	memset(&file, 0, sizeof(struct file));
+	file.f_mapping = bdev->bd_inode->i_mapping;
+	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
+	file.f_inode = bdev->bd_inode;
+
+	init_sync_kiocb(&kiocb, &file);
+	kiocb.ki_pos = pos;
+	iov_iter_kvec(&iter, WRITE, &iov, 1, bytes);
+
+	inode_lock(bdev->bd_inode);
+	ret = generic_write_checks(&kiocb, &iter);
+	if (ret > 0)
+		ret = generic_perform_write(&file, &iter, pos);
+	inode_unlock(bdev->bd_inode);
+
+	if (likely(ret > 0)) {
+		const struct file_operations f_op = {.fsync = blkdev_fsync};
+
+		file.f_op = &f_op;
+		kiocb.ki_pos += ret;
+		ret = generic_write_sync(&kiocb, ret);
+	}
+	return ret;
+}
+
+static inline unsigned long psblk_bdev_size(struct block_device *bdev)
+{
+	return (unsigned long)part_nr_sects_read(bdev->bd_part) << SECTOR_SHIFT;
+}
+
+static ssize_t psblk_blk_panic_write(const char *buf, size_t size,
+		loff_t off)
+{
+	int ret;
+
+	if (!blkdev_panic_write)
+		return -EOPNOTSUPP;
+
+	/* size and off must align to SECTOR_SIZE for block device */
+	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
+			size >> SECTOR_SHIFT);
+	return ret ? -EIO : size;
+}
+
+static struct bdev_info *psblk_get_bdev_info(void)
+{
+	struct bdev_info *info = &g_bdev_info;
+	struct block_device *bdev;
+
+	if (info->devt)
+		return info;
+
+	bdev = psblk_get_bdev(NULL);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
+
+	info->devt = bdev->bd_dev;
+	info->nr_sects = part_nr_sects_read(bdev->bd_part);
+	info->start_sect = get_start_sect(bdev);
+
+	if (!psblk_bdev_size(bdev)) {
+		pr_err("no enough space to '%s'\n", blkdev);
+		info = ERR_PTR(-ENOSPC);
+	}
+
+	psblk_put_bdev(bdev, NULL);
+	return info;
+}
+
+/**
+ * psblk_register_blkdev() - register block device to pstore/blk
+ *
+ * @major: the major device number of registering device
+ * @panic_write: the interface for panic case.
+ *
+ * Only the matching major to @blkdev can register.
+ *
+ * If block device do not support panic write, @panic_write can be NULL.
+ *
+ * Return:
+ * * 0		- OK
+ * * Others	- something error.
+ */
+int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
+{
+	struct block_device *bdev;
+	struct psblk_device dev = {0};
+	struct bdev_info *binfo;
+	int ret = -ENODEV;
+	void *holder = blkdev;
+
+	binfo = psblk_get_bdev_info();
+	if (IS_ERR(binfo))
+		return PTR_ERR(binfo);
+
+	/* only allow driver matching the @blkdev */
+	if (!binfo->devt || MAJOR(binfo->devt) != major) {
+		pr_debug("invalid major %u (expect %u)\n",
+				major, MAJOR(binfo->devt));
+		return -ENODEV;
+	}
+
+	/* hold bdev exclusively */
+	bdev = psblk_get_bdev(holder);
+	if (IS_ERR(bdev)) {
+		pr_err("failed to open '%s'!\n", blkdev);
+		return PTR_ERR(bdev);
+	}
+
+	/* psblk_bdev must be assigned before register to pstore/blk */
+	psblk_bdev = bdev;
+	blkdev_panic_write = panic_write;
+
+	dev.total_size = psblk_bdev_size(bdev);
+	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
+	dev.read = psblk_generic_blk_read;
+	dev.write = psblk_generic_blk_write;
+
+	ret = psblk_register_do(&dev);
+	if (ret)
+		goto err_put_bdev;
+
+	pr_info("using '%s'\n", blkdev);
+	return 0;
+
+err_put_bdev:
+	psblk_bdev = NULL;
+	blkdev_panic_write = NULL;
+	psblk_put_bdev(bdev, holder);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psblk_register_blkdev);
+
+/**
+ * psblk_unregister_blkdev() - unregister block device from pstore/blk
+ *
+ * @major: the major device number of device
+ */
+void psblk_unregister_blkdev(unsigned int major)
+{
+	struct psblk_device dev = {.read = psblk_generic_blk_read};
+	void *holder = blkdev;
+
+	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
+		psblk_unregister_do(&dev);
+		psblk_put_bdev(psblk_bdev, holder);
+		blkdev_panic_write = NULL;
+		psblk_bdev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(psblk_unregister_blkdev);
+
+/**
+ * psblk_blkdev_info() - get information of @blkdev
+ *
+ * @devt: the block device num of @blkdev
+ * @nr_sects: the sector count of @blkdev
+ * @start_sect: the start sector of @blkdev
+ *
+ * Block driver needs the follow information for @panic_write.
+ *
+ * Return: 0 on success, others on failure.
+ */
+int psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
+{
+	struct bdev_info *binfo;
+
+	binfo = psblk_get_bdev_info();
+	if (IS_ERR(binfo))
+		return PTR_ERR(binfo);
+
+	if (devt)
+		*devt = binfo->devt;
+	if (nr_sects)
+		*nr_sects = binfo->nr_sects;
+	if (start_sect)
+		*start_sect = binfo->start_sect;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(psblk_blkdev_info);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Block device Oops/Panic logger");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
new file mode 100644
index 000000000000..5ff465e3953e
--- /dev/null
+++ b/include/linux/pstore_blk.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSTORE_BLK_H_
+#define __PSTORE_BLK_H_
+
+#include <linux/types.h>
+#include <linux/pstore_zone.h>
+
+/**
+ * typedef psblk_panic_write_op - panic write operation to block device
+ *
+ * @buf: the data to write
+ * @start_sect: start sector to block device
+ * @sects: sectors count on buf
+ *
+ * Return: On success, zero should be returned. Others mean error.
+ *
+ * Panic write to block device must be aligned to SECTOR_SIZE.
+ */
+typedef int (*psblk_panic_write_op)(const char *buf, sector_t start_sect,
+		sector_t sects);
+
+int  psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write);
+void psblk_unregister_blkdev(unsigned int major);
+int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
+
+#endif
-- 
1.9.1

