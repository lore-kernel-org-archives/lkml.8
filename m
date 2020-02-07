Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF2C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452F920720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGM0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:26:13 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34279 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727041AbgBGM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:26:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.443971-0.0296882-0.526341;DS=CONTINUE|ham_system_inform|0.0875362-0.000464935-0.911999;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.GlaQplc_1581078351;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GlaQplc_1581078351)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 07 Feb 2020 20:26:00 +0800
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
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 02/11] blkoops: add blkoops, a warpper for pstore/blk
Date:   Fri,  7 Feb 2020 20:25:46 +0800
Message-Id: <1581078355-19647-3-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blkoops is a better wrapper for pstore/blk, which provides efficient
configuration mothod. It divides all configurations of pstore/blk into
2 parts, configurations for user and configurations for driver.

Configurations for user detemine how pstore/blk work, such as
dump_oops and dmesg_size. They can be set by Kconfig and module
parameters.

Configurations for driver are all about block/non-block device, such as
total_size of device and read/write operations. They should be provided
by device drivers, calling blkoops_register_device() for non-block
device and blkoops_register_blkdev() for block device.

If device driver support for panic records, @panic_write must be valid.
If panic occurs and pstore/blk does not recover yet, the first zone
of dmesg will be used.

Besides, Block device driver has no need to verify which partition is
used and provides generic read/write operations. Because blkoops has
done it. It also means that if users do not care panic records but
records for oops/console/pmsg/ftrace, block device driver should do
nothing.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 MAINTAINERS             |   2 +-
 fs/pstore/Kconfig       |  61 ++++++++
 fs/pstore/Makefile      |   2 +
 fs/pstore/blkoops.c     | 402 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkoops.h |  58 +++++++
 5 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 fs/pstore/blkoops.c
 create mode 100644 include/linux/blkoops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..e4ba97130560 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13381,7 +13381,7 @@ F:	drivers/firmware/efi/efi-pstore.c
 F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
-K:	\b(pstore|ramoops)
+K:	\b(pstore|ramoops|blkoops)
 
 PTP HARDWARE CLOCK SUPPORT
 M:	Richard Cochran <richardcochran@gmail.com>
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 536fde9e13e8..7a57a8edb612 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -163,3 +163,64 @@ config PSTORE_BLK
 	  where it can be read back at some later point.
 
 	  If unsure, say N.
+
+config PSTORE_BLKOOPS
+	tristate "pstore block with oops logger"
+	depends on PSTORE_BLK
+	help
+	  This is a wrapper for pstore/blk.
+
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
+
+	  If unsure, say N.
+
+config PSTORE_BLKOOPS_DMESG_SIZE
+	int "dmesg size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	default 64
+	help
+	  This just sets size of dmesg (dmesg_size) for pstore/blk. The size is
+	  in KB and must be a multiple of 4.
+
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
+
+config PSTORE_BLKOOPS_BLKDEV
+	string "block device for blkoops"
+	depends on PSTORE_BLKOOPS
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
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
+
+config PSTORE_BLKOOPS_DUMP_OOPS
+	bool "dump oops"
+	depends on PSTORE_BLKOOPS
+	default y
+	help
+	  Whether blkoops dumps oops or not.
+
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 0ee2fc8d1bfb..24b3d488d2f0 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
 pstore_blk-y += blkzone.o
+
+obj-$(CONFIG_PSTORE_BLKOOPS) += blkoops.o
diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
new file mode 100644
index 000000000000..8027c3af8c8d
--- /dev/null
+++ b/fs/pstore/blkoops.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "blkoops : " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/blkoops.h>
+#include <linux/mount.h>
+#include <linux/uio.h>
+
+static long dmesg_size = -1;
+module_param(dmesg_size, long, 0400);
+MODULE_PARM_DESC(dmesg_size, "demsg size in kbytes");
+
+static int dump_oops = -1;
+module_param(dump_oops, int, 0400);
+MODULE_PARM_DESC(total_size, "whether dump oops");
+
+/**
+ * The block device to use. Most of the time, it is a partition of block
+ * device. It's fine to ignore it if you are not block device and register
+ * to blkoops by blkoops_register_device(). In this case, @blkdev is
+ * useless and @read, @write and @total_size must be supplied.
+ *
+ * @blkdev accepts the following variants:
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
+static char blkdev[80];
+module_param_string(blkdev, blkdev, 80, 0400);
+MODULE_PARM_DESC(blkdev, "the block device for general read/write");
+
+static DEFINE_MUTEX(blkz_lock);
+static struct block_device *blkoops_bdev;
+static struct blkz_info *bzinfo;
+static blkoops_blk_panic_write_op blkdev_panic_write;
+
+#ifdef CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
+#define DEFAULT_DMESG_SIZE CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
+#else
+#define DEFAULT_DMESG_SIZE 0
+#endif
+
+#ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
+#define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
+#else
+#define DEFAULT_DUMP_OOPS 1
+#endif
+
+#ifdef CONFIG_PSTORE_BLKOOPS_BLKDEV
+#define DEFAULT_BLKDEV CONFIG_PSTORE_BLKOOPS_BLKDEV
+#else
+#define DEFAULT_BLKDEV ""
+#endif
+
+/**
+ * register device to blkoops
+ *
+ * Drivers, not only block drivers but also non-block drivers can call this
+ * function to register to blkoops. It will pack for blkzone and pstore.
+ */
+int blkoops_register_device(struct blkoops_device *bo_dev)
+{
+	int ret;
+
+	if (!bo_dev || !bo_dev->total_size || !bo_dev->read || !bo_dev->write)
+		return -EINVAL;
+
+	mutex_lock(&blkz_lock);
+
+	/* someone already registered before */
+	if (bzinfo) {
+		mutex_unlock(&blkz_lock);
+		return -EBUSY;
+	}
+	bzinfo = kzalloc(sizeof(struct blkz_info), GFP_KERNEL);
+	if (!bzinfo) {
+		mutex_unlock(&blkz_lock);
+		return -ENOMEM;
+	}
+
+#define verify_size(name, defsize, alignsize) {				\
+		long _##name_ = (name);					\
+		if (_##name_ < 0)					\
+			_##name_ = (defsize);				\
+		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+		if (_##name_ & ((alignsize) - 1)) {			\
+			pr_info(#name " must align to %d\n",		\
+					(alignsize));			\
+			_##name_ = ALIGN(name, (alignsize));		\
+		}							\
+		name = _##name_ / 1024;					\
+		bzinfo->name = _##name_;				\
+	}
+
+	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
+#undef verify_size
+	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
+
+	bzinfo->total_size = bo_dev->total_size;
+	bzinfo->dump_oops = dump_oops;
+	bzinfo->read = bo_dev->read;
+	bzinfo->write = bo_dev->write;
+	bzinfo->panic_write = bo_dev->panic_write;
+	bzinfo->name = "blkoops";
+	bzinfo->owner = THIS_MODULE;
+
+	ret = blkz_register(bzinfo);
+	if (ret) {
+		kfree(bzinfo);
+		bzinfo = NULL;
+	}
+	mutex_unlock(&blkz_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkoops_register_device);
+
+void blkoops_unregister_device(struct blkoops_device *bo_dev)
+{
+	mutex_lock(&blkz_lock);
+	if (bzinfo && bzinfo->read == bo_dev->read) {
+		blkz_unregister(bzinfo);
+		kfree(bzinfo);
+		bzinfo = NULL;
+	}
+	mutex_unlock(&blkz_lock);
+}
+EXPORT_SYMBOL_GPL(blkoops_unregister_device);
+
+/**
+ * get block_device of @blkdev
+ * @holder: exclusive holder identifier
+ *
+ * On success, @blkoops_bdev will save the block_device and the returned
+ * block_device has reference count of one.
+ */
+static struct block_device *blkoops_get_bdev(void *holder)
+{
+	struct block_device *bdev = ERR_PTR(-ENODEV);
+	fmode_t mode = FMODE_READ | FMODE_WRITE;
+
+	if (!blkdev[0] && strlen(DEFAULT_BLKDEV))
+		snprintf(blkdev, 80, "%s", DEFAULT_BLKDEV);
+	if (!blkdev[0])
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&blkz_lock);
+	if (bzinfo)
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
+	mutex_unlock(&blkz_lock);
+	return bdev;
+}
+
+static void blkoops_put_bdev(struct block_device *bdev, void *holder)
+{
+	fmode_t mode = FMODE_READ | FMODE_WRITE;
+
+	if (!bdev)
+		return;
+
+	mutex_lock(&blkz_lock);
+	if (holder)
+		mode |= FMODE_EXCL;
+	blkdev_put(bdev, mode);
+	mutex_unlock(&blkz_lock);
+}
+
+static ssize_t blkoops_generic_blk_read(char *buf, size_t bytes, loff_t pos)
+{
+	ssize_t ret;
+	struct block_device *bdev = blkoops_bdev;
+	struct file filp;
+	mm_segment_t ofs;
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	struct iovec iov = {
+		.iov_base = (void __user *)buf,
+		.iov_len = bytes
+	};
+
+	if (!bdev)
+		return -ENODEV;
+
+	memset(&filp, 0, sizeof(struct file));
+	filp.f_mapping = bdev->bd_inode->i_mapping;
+	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
+	filp.f_inode = bdev->bd_inode;
+
+	init_sync_kiocb(&kiocb, &filp);
+	kiocb.ki_pos = pos;
+	iov_iter_init(&iter, READ, &iov, 1, bytes);
+
+	ofs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = generic_file_read_iter(&kiocb, &iter);
+	set_fs(ofs);
+	return ret;
+}
+
+static ssize_t blkoops_generic_blk_write(const char *buf, size_t bytes,
+		loff_t pos)
+{
+	struct block_device *bdev = blkoops_bdev;
+	struct iov_iter iter;
+	struct kiocb kiocb;
+	struct file filp;
+	mm_segment_t ofs;
+	ssize_t ret;
+	struct iovec iov = {
+		.iov_base = (void __user *)buf,
+		.iov_len = bytes
+	};
+
+	if (!bdev)
+		return -ENODEV;
+
+	/* Console/Ftrace recorder may handle buffer until flush dirty zones */
+	if (in_interrupt() || irqs_disabled())
+		return -EBUSY;
+
+	memset(&filp, 0, sizeof(struct file));
+	filp.f_mapping = bdev->bd_inode->i_mapping;
+	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
+	filp.f_inode = bdev->bd_inode;
+
+	init_sync_kiocb(&kiocb, &filp);
+	kiocb.ki_pos = pos;
+	iov_iter_init(&iter, WRITE, &iov, 1, bytes);
+
+	ofs = get_fs();
+	set_fs(KERNEL_DS);
+
+	inode_lock(bdev->bd_inode);
+	ret = generic_write_checks(&kiocb, &iter);
+	if (ret > 0)
+		ret = generic_perform_write(&filp, &iter, pos);
+	inode_unlock(bdev->bd_inode);
+
+	if (likely(ret > 0)) {
+		const struct file_operations f_op = {.fsync = blkdev_fsync};
+
+		filp.f_op = &f_op;
+		kiocb.ki_pos += ret;
+		ret = generic_write_sync(&kiocb, ret);
+	}
+	set_fs(ofs);
+	return ret;
+}
+
+static inline unsigned long blkoops_bdev_size(struct block_device *bdev)
+{
+	return (unsigned long)part_nr_sects_read(bdev->bd_part) << SECTOR_SHIFT;
+}
+
+static ssize_t blkoops_blk_panic_write(const char *buf, size_t size,
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
+/**
+ * register block device to blkoops
+ * @major: the major device number of registering device
+ * @panic_write: the write interface for panic case.
+ *
+ * It is ONLY used for block device to register to blkoops. In this case,
+ * the module parameter @blkdev must be valid. Generic read/write interfaces
+ * will be used.
+ *
+ * Block driver has no need to verify which partition is used. Block driver
+ * should only tell me what major number is, so blkoops can get the matching
+ * driver for @blkdev.
+ *
+ * If block driver support for panic records, @panic_write must be valid. If
+ * panic occurs but pstore/blk does not recover yet, the first zone of dmesg
+ * will be used.
+ */
+int blkoops_register_blkdev(unsigned int major,
+		blkoops_blk_panic_write_op panic_write)
+{
+	struct block_device *bdev;
+	struct blkoops_device bo_dev = {0};
+	int ret = -ENODEV;
+	void *holder = blkdev;
+
+	bdev = blkoops_get_bdev(holder);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	blkoops_bdev = bdev;
+	blkdev_panic_write = panic_write;
+
+	/* only allow driver matching the @blkdev */
+	if (!bdev->bd_dev || MAJOR(bdev->bd_dev) != major)
+		goto err_put_bdev;
+
+	bo_dev.total_size = blkoops_bdev_size(bdev);
+	if (bo_dev.total_size == 0)
+		goto err_put_bdev;
+	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
+	bo_dev.read = blkoops_generic_blk_read;
+	bo_dev.write = blkoops_generic_blk_write;
+
+	ret = blkoops_register_device(&bo_dev);
+	if (ret)
+		goto err_put_bdev;
+	return 0;
+
+err_put_bdev:
+	blkdev_panic_write = NULL;
+	blkoops_bdev = NULL;
+	blkoops_put_bdev(bdev, holder);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkoops_register_blkdev);
+
+void blkoops_unregister_blkdev(unsigned int major)
+{
+	struct blkoops_device bo_dev = {.read = blkoops_generic_blk_read};
+	void *holder = blkdev;
+
+	if (blkoops_bdev && MAJOR(blkoops_bdev->bd_dev) == major) {
+		blkoops_unregister_device(&bo_dev);
+		blkoops_put_bdev(blkoops_bdev, holder);
+		blkdev_panic_write = NULL;
+		blkoops_bdev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(blkoops_unregister_blkdev);
+
+/**
+ * get information of @blkdev
+ * @devt: the block device num of @blkdev
+ * @nr_sectors: the sector count of @blkdev
+ * @start_sect: the start sector of @blkdev
+ *
+ * Block driver needs the follow information for @panic_write.
+ */
+int blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
+{
+	struct block_device *bdev;
+
+	bdev = blkoops_get_bdev(NULL);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	if (devt)
+		*devt = bdev->bd_dev;
+	if (nr_sects)
+		*nr_sects = part_nr_sects_read(bdev->bd_part);
+	if (start_sect)
+		*start_sect = get_start_sect(bdev);
+
+	blkoops_put_bdev(bdev, NULL);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkoops_blkdev_info);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Wrapper for Pstore BLK with Oops logger");
diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
new file mode 100644
index 000000000000..fe63739309aa
--- /dev/null
+++ b/include/linux/blkoops.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __BLKOOPS_H_
+#define __BLKOOPS_H_
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/pstore_blk.h>
+
+/**
+ * struct blkoops_device - backend blkoops driver structure.
+ *
+ * This structure is ONLY used for non-block device by
+ * blkoops_register_device(). If block device, you are strongly recommended
+ * to use blkoops_register_blkdev().
+ *
+ * @total_size:
+ *	The total size in bytes pstore/blk can use. It must be greater than
+ *	4096 and be multiple of 4096.
+ * @read, @write:
+ *	The general (not panic) read/write operation.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, the number of bytes read should be returned.
+ *	On error, negative number should be returned.
+ * @panic_write:
+ *	The write operation only used for panic.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, the number of bytes read should be returned.
+ *	On error, negative number should be returned.
+ */
+struct blkoops_device {
+	unsigned long total_size;
+	blkz_read_op read;
+	blkz_write_op write;
+	blkz_write_op panic_write;
+};
+
+/*
+ * Panic write for block device who should write alignmemt to SECTOR_SIZE.
+ * On success, zero should be returned. Others mean error.
+ */
+typedef int (*blkoops_blk_panic_write_op)(const char *buf, sector_t start_sect,
+		sector_t sects);
+
+int  blkoops_register_device(struct blkoops_device *bo_dev);
+void blkoops_unregister_device(struct blkoops_device *bo_dev);
+int  blkoops_register_blkdev(unsigned int major,
+		blkoops_blk_panic_write_op panic_write);
+void blkoops_unregister_blkdev(unsigned int major);
+int  blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
+
+#endif
-- 
1.9.1

