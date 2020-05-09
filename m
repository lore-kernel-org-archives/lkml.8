Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8833C54E8A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4680217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2OU3Z2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgEIXmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728590AbgEIXlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4735C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:41:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so2300443plt.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWarUU0uMexvpp1DVX6fUGOv60QOMvVOlxWI3GVFNY0=;
        b=W2OU3Z2n7xpB+zI+2cFGzxUUNS0rZFNLs05tLPxdTKSfnDpvrPXOmB5ygXQ3Aja/ny
         9F5LB6ARmrckf8yTzrXUstHVyNk1KfW3KvAihNm2u/tzLsz9sA25fQaKj3XWuxgOd4lT
         mBhKJaH8AcuYKtwqLq14tDXu49T7eRvOVnO8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWarUU0uMexvpp1DVX6fUGOv60QOMvVOlxWI3GVFNY0=;
        b=hw8eNax/jPkWI1dx3Vl/CjQKknoX3whTcpikU/hFXwuDATfpt4jEf45a5WlLmWZslD
         0Uuo0OjsuTIjb4MjiRDaZJz4ubdKzXADBdapO36oJBwoHqGYKU5mFNpV7b5cOnl0WgSP
         tsaloLAAOBAcxSxDndfWrhVqrl6O0y2NbPvoiqynbz6iBeWpM+evIkMK/wOAM+fD0nKG
         A0w4XPYF7+MvnDOnbH+zYKp+EbeNml9GlFkZvYZ3dvUbcmQ4kRNKZTnj6RVitJEVDpcQ
         nprUFWvA44xtLmlurghFyZpmLP0oh+0VC4OhA+agC5hNxT9t14O3Ouh9PDVaZ9RVOrQf
         dNlQ==
X-Gm-Message-State: AGi0PuZnaq+1QVD7wRokaX1RCPLi0t3kzrWcYZamHMmu6FKZOncGKmaW
        lgKhuKSr20NMtJP+noNLIO87pQ==
X-Google-Smtp-Source: APiQypLS2QtTb6nPtDQDdPFEJB534C9tDG5U7v+D1faf6jNzFm0oJqkVNkag7rGHzorCWAyXTdTGlA==
X-Received: by 2002:a17:902:b217:: with SMTP id t23mr5945215plr.132.1589067676121;
        Sat, 09 May 2020 16:41:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d35sm4390627pgd.29.2020.05.09.16.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:41:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v6 09/18] pstore/blk: Introduce backend for block devices
Date:   Sat,  9 May 2020 16:40:54 -0700
Message-Id: <20200509234103.46544-10-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509234103.46544-1-keescook@chromium.org>
References: <20200509234103.46544-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WeiXiong Liao <liaoweixiong@allwinnertech.com>

pstore/blk is similar to pstore/ram, but uses a block device as the
storage rather than persistent ram.

The pstore/blk backend solves two common use-cases that used to preclude
using pstore/ram:
- not all devices have a battery that could be used to persist
  regular RAM across power failures.
- most embedded intelligent equipment have no persistent ram, which
  increases costs, instead preferring cheaper solutions, like block
  devices.

pstore/blk provides separate configurations for the end user and for the
block drivers. User configuration determines how pstore/blk operates, such
as record sizes, max kmsg dump reasons, etc. These can be set by Kconfig
and/or module parameters, but module parameter have priority over Kconfig.
Driver configuration covers all the details about the target block device,
such as total size of the device and how to perform read/write operations.
These are provided by block drivers, calling pstore_register_blkdev(),
including an optional panic_write callback used to bypass regular IO
APIs in an effort to avoid potentially destabilized kernel code during
a panic.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-3-git-send-email-liaoweixiong@allwinnertech.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/Kconfig          |  64 +++++
 fs/pstore/Makefile         |   3 +
 fs/pstore/blk.c            | 489 +++++++++++++++++++++++++++++++++++++
 include/linux/pstore_blk.h |  29 +++
 4 files changed, 585 insertions(+)
 create mode 100644 fs/pstore/blk.c
 create mode 100644 include/linux/pstore_blk.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 98d2457bdd9f..92ba73bd0b62 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -160,3 +160,67 @@ config PSTORE_ZONE
 	help
 	  The common layer for pstore/blk (and pstore/ram in the future)
 	  to manage storage in zones.
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
+config PSTORE_BLK_KMSG_SIZE
+	int "Size in Kbytes of kmsg dump log to store"
+	depends on PSTORE_BLK
+	default 64
+	help
+	  This just sets size of kmsg dump (oops, panic, etc) log for
+	  pstore/blk. The size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
+config PSTORE_BLK_MAX_REASON
+	int "Maximum kmsg dump reason to store"
+	depends on PSTORE_BLK
+	default 2
+	help
+	  The maximum reason for kmsg dumps to store. The default is
+	  2 (KMSG_DUMP_OOPS), see include/linux/kmsg_dump.h's
+	  enum kmsg_dump_reason for more details.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 58a967cbe4af..c270467aeece 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -15,3 +15,6 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 pstore_zone-objs += zone.o
 obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
+
+pstore_blk-objs += blk.o
+obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
new file mode 100644
index 000000000000..b0e1ae21d1de
--- /dev/null
+++ b/fs/pstore/blk.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implements pstore backend driver that write to block (or non-block) storage
+ * devices, using the pstore/zone API.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "../../block/blk.h"
+#include <linux/blkdev.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pstore_blk.h>
+#include <linux/mount.h>
+#include <linux/uio.h>
+
+static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
+module_param(kmsg_size, long, 0400);
+MODULE_PARM_DESC(kmsg_size, "kmsg dump record size in kbytes");
+
+static int max_reason = CONFIG_PSTORE_BLK_MAX_REASON;
+module_param(max_reason, int, 0400);
+MODULE_PARM_DESC(max_reason,
+		 "maximum reason for kmsg dump (default 2: Oops and Panic)");
+
+/*
+ * blkdev - the block device to use for pstore storage
+ *
+ * Usually, this will be a partition of a block device.
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
+MODULE_PARM_DESC(blkdev, "block device for pstore storage");
+
+/*
+ * All globals must only be accessed under the pstore_blk_lock
+ * during the register/unregister functions.
+ */
+static DEFINE_MUTEX(pstore_blk_lock);
+static struct block_device *psblk_bdev;
+static struct pstore_zone_info *pstore_zone_info;
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
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
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
+	unsigned int flags;
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
+	mutex_lock(&pstore_blk_lock);
+
+	/* someone already registered before */
+	if (pstore_zone_info) {
+		mutex_unlock(&pstore_blk_lock);
+		return -EBUSY;
+	}
+	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
+	if (!pstore_zone_info) {
+		mutex_unlock(&pstore_blk_lock);
+		return -ENOMEM;
+	}
+
+	/* zero means not limit on which backends to attempt to store. */
+	if (!dev->flags)
+		dev->flags = UINT_MAX;
+
+#define verify_size(name, alignsize, enabled) {				\
+		long _##name_ = (enabled) ? (name) : 0;			\
+		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+		if (_##name_ & ((alignsize) - 1)) {			\
+			pr_info(#name " must align to %d\n",		\
+					(alignsize));			\
+			_##name_ = ALIGN(name, (alignsize));		\
+		}							\
+		name = _##name_ / 1024;					\
+		pstore_zone_info->name = _##name_;			\
+	}
+
+	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
+#undef verify_size
+
+	pstore_zone_info->total_size = dev->total_size;
+	pstore_zone_info->max_reason = max_reason;
+	pstore_zone_info->read = dev->read;
+	pstore_zone_info->write = dev->write;
+	pstore_zone_info->panic_write = dev->panic_write;
+	pstore_zone_info->name = KBUILD_MODNAME;
+	pstore_zone_info->owner = THIS_MODULE;
+
+	ret = register_pstore_zone(pstore_zone_info);
+	if (ret) {
+		kfree(pstore_zone_info);
+		pstore_zone_info = NULL;
+	}
+	mutex_unlock(&pstore_blk_lock);
+	return ret;
+}
+
+static void psblk_unregister_do(struct psblk_device *dev)
+{
+	mutex_lock(&pstore_blk_lock);
+	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
+		unregister_pstore_zone(pstore_zone_info);
+		kfree(pstore_zone_info);
+		pstore_zone_info = NULL;
+	}
+	mutex_unlock(&pstore_blk_lock);
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
+	if (WARN_ON(!mutex_is_locked(&pstore_blk_lock)))
+		return ERR_PTR(-EINVAL);
+
+	if (pstore_zone_info)
+		return ERR_PTR(-EBUSY);
+
+	if (!blkdev[0])
+		return ERR_PTR(-ENODEV);
+
+	if (holder)
+		mode |= FMODE_EXCL;
+	bdev = blkdev_get_by_path(blkdev, mode, holder);
+	if (IS_ERR(bdev)) {
+		dev_t devt;
+
+		devt = name_to_dev_t(blkdev);
+		if (devt == 0)
+			return ERR_PTR(-ENODEV);
+		bdev = blkdev_get_by_dev(devt, mode, holder);
+	}
+
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
+	if (WARN_ON(!mutex_is_locked(&pstore_blk_lock)))
+		return;
+
+	if (holder)
+		mode |= FMODE_EXCL;
+	blkdev_put(bdev, mode);
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
+	/* Console/Ftrace backend may handle buffer until flush dirty zones */
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
+	if (WARN_ON(!mutex_is_locked(&pstore_blk_lock)))
+		return ERR_PTR(-EINVAL);
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
+		pr_err("not enough space to '%s'\n", blkdev);
+		info = ERR_PTR(-ENOSPC);
+	}
+
+	psblk_put_bdev(bdev, NULL);
+	return info;
+}
+
+static int __register_pstore_blk(unsigned int major, unsigned int flags,
+				 psblk_panic_write_op panic_write)
+{
+	char bdev_name[BDEVNAME_SIZE];
+	struct block_device *bdev;
+	struct psblk_device dev = { };
+	struct bdev_info *binfo;
+	int ret = -ENODEV;
+	void *holder = blkdev;
+
+	if (WARN_ON(!mutex_is_locked(&pstore_blk_lock)))
+		return -EINVAL;
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
+	dev.flags = flags;
+	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
+	dev.read = psblk_generic_blk_read;
+	dev.write = psblk_generic_blk_write;
+
+	ret = psblk_register_do(&dev);
+	if (ret)
+		goto err_put_bdev;
+
+	bdevname(bdev, bdev_name);
+	pr_info("attached %s%s\n", bdev_name,
+		panic_write ? "" : " (no dedicated panic_write!)");
+	return 0;
+
+err_put_bdev:
+	psblk_bdev = NULL;
+	blkdev_panic_write = NULL;
+	psblk_put_bdev(bdev, holder);
+	return ret;
+}
+
+/**
+ * register_pstore_blk() - register block device to pstore/blk
+ *
+ * @major: the major device number of registering device
+ * @flags: refer to macro starting with PSTORE_FLAGS defined in linux/pstore.h
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
+int register_pstore_blk(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write)
+{
+	int ret;
+
+	mutex_lock(&pstore_blk_lock);
+	ret = __register_pstore_blk(major, flags, panic_write);
+	mutex_unlock(&pstore_blk_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_pstore_blk);
+
+void __unregister_pstore_blk(unsigned int major)
+{
+	struct psblk_device dev = { .read = psblk_generic_blk_read };
+	void *holder = blkdev;
+
+	WARN_ON(!mutex_is_locked(&pstore_blk_lock));
+	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
+		psblk_unregister_do(&dev);
+		psblk_put_bdev(psblk_bdev, holder);
+		blkdev_panic_write = NULL;
+		psblk_bdev = NULL;
+		memset(&g_bdev_info, 0, sizeof(g_bdev_info));
+	}
+}
+
+/**
+ * unregister_pstore_blk() - unregister block device from pstore/blk
+ *
+ * @major: the major device number of device
+ */
+void unregister_pstore_blk(unsigned int major)
+{
+	mutex_lock(&pstore_blk_lock);
+	__unregister_pstore_blk(major);
+	mutex_unlock(&pstore_blk_lock);
+}
+EXPORT_SYMBOL_GPL(unregister_pstore_blk);
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
+	mutex_lock(&pstore_blk_lock);
+	binfo = psblk_get_bdev_info();
+	if (IS_ERR(binfo)) {
+		mutex_unlock(&pstore_blk_lock);
+		return PTR_ERR(binfo);
+	}
+
+	if (devt)
+		*devt = binfo->devt;
+	if (nr_sects)
+		*nr_sects = binfo->nr_sects;
+	if (start_sect)
+		*start_sect = binfo->start_sect;
+
+	mutex_unlock(&pstore_blk_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(psblk_blkdev_info);
+
+static void __exit pstore_blk_exit(void)
+{
+	mutex_lock(&pstore_blk_lock);
+	if (psblk_bdev)
+		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
+	mutex_unlock(&pstore_blk_lock);
+}
+module_exit(pstore_blk_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
+MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_DESCRIPTION("pstore backend for block devices");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
new file mode 100644
index 000000000000..70963e811646
--- /dev/null
+++ b/include/linux/pstore_blk.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSTORE_BLK_H_
+#define __PSTORE_BLK_H_
+
+#include <linux/types.h>
+#include <linux/pstore.h>
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
+int  register_pstore_blk(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write);
+void unregister_pstore_blk(unsigned int major);
+int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
+
+#endif
-- 
2.20.1

