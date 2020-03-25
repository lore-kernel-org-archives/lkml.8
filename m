Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC92C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576592073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCYI4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:56:01 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:36369 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgCYIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.149378-0.00041665-0.850205;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:35 +0800
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
Subject: [PATCH v3 10/11] pstore/zone: pstore/blk: support non-block devices
Date:   Wed, 25 Mar 2020 16:55:05 +0800
Message-Id: <1585126506-18635-11-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support non-block device like MTD device. A non-block driver calls
psblk_register_device() to register to pstore/blk.

In addition, pstore/zone should also fix to non-block devices like
MTD device. MTD device is not block device and an erase must be done
before write. To adapt to non block device like MTD device,
pstore/zone must call the special erase job rather than set the
@datalen of zone to 0, which works on block device but not MTD device.
If no this patch, pstore on MTD disables to remove log file.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 Documentation/admin-guide/pstore-block.rst | 17 +++++++---
 fs/pstore/pstore_blk.c                     | 52 ++++++++++++------------------
 fs/pstore/pstore_zone.c                    |  8 ++++-
 include/linux/pstore_blk.h                 | 37 +++++++++++++++++++++
 include/linux/pstore_zone.h                |  6 ++++
 5 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
index a96415eaaf24..a31155b36e62 100644
--- a/Documentation/admin-guide/pstore-block.rst
+++ b/Documentation/admin-guide/pstore-block.rst
@@ -7,8 +7,8 @@ Introduction
 ------------
 
 Pstore block (pstore/blk) is an oops/panic logger that writes its logs to a
-block device before the system crashes. You can get these log files by
-mounting pstore filesystem like::
+block device and non-block device before the system crashes. You can get
+these log files by mounting pstore filesystem like::
 
     mount -t pstore pstore /sys/fs/pstore
 
@@ -24,8 +24,8 @@ Configurations for user determine how pstore/blk works, such as pmsg_size,
 oops_size and so on. All of them support both Kconfig and module parameters,
 but module parameters have priority over Kconfig.
 
-Configurations for driver are all about block device, such as total_size
-of block device and read/write operations.
+Configurations for driver are all about block device and non-block device,
+such as total_size of block device and read/write operations.
 
 Configurations for user
 -----------------------
@@ -146,6 +146,15 @@ driver uses ``psblk_register_blkdev`` to register to pstore/blk.
 .. kernel-doc:: fs/pstore/pstore_blk.c
    :identifiers: psblk_register_blkdev
 
+A non-block device driver uses ``psblk_register_device`` with
+``struct psblk_device`` to register to pstore/blk.
+
+.. kernel-doc:: fs/pstore/pstore_blk.c
+   :identifiers: psblk_register_device
+
+.. kernel-doc:: include/linux/pstore_blk.h
+   :identifiers: psblk_device
+
 Compression and header
 ----------------------
 
diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index 061609b66d8a..5c8006376677 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -96,36 +96,15 @@
 })
 
 /**
- * struct psblk_device - back-end pstore/blk driver structure.
+ * psblk_register_device() - register non-block device to pstore/blk
  *
- * @total_size: The total size in bytes pstore/blk can use. It must be greater
- *		than 4096 and be multiple of 4096.
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all recorders for compatible.
- * @read:	The general read operation. Both of the function parameters
- *		@size and @offset are relative value to bock device (not the
- *		whole disk).
- *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but the following error number:
- *		-EBUSY means try to write again later.
- *		-ENOMSG means to try next zone.
- * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters are relative
- *		value to storage.
- *		On success, the number of bytes should be returned, others
- *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
+ * @dev: non-block device information
+ *
+ * Return:
+ * * 0		- OK
+ * * Others	- something error.
  */
-struct psblk_device {
-	unsigned long total_size;
-	unsigned int flags;
-	psz_read_op read;
-	psz_write_op write;
-	psz_write_op panic_write;
-};
-
-static int psblk_register_do(struct psblk_device *dev)
+int psblk_register_device(struct psblk_device *dev)
 {
 	int ret;
 
@@ -169,6 +148,7 @@ static int psblk_register_do(struct psblk_device *dev)
 	psz_info->dump_oops = dump_oops;
 	psz_info->read = dev->read;
 	psz_info->write = dev->write;
+	psz_info->erase = dev->erase;
 	psz_info->panic_write = dev->panic_write;
 	psz_info->name = MODNAME;
 	psz_info->owner = THIS_MODULE;
@@ -181,8 +161,14 @@ static int psblk_register_do(struct psblk_device *dev)
 	mutex_unlock(&psz_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(psblk_register_device);
 
-static void psblk_unregister_do(struct psblk_device *dev)
+/**
+ * psblk_unregister_blkdev() - unregister block device from pstore/blk
+ *
+ * @dev: non-block device information
+ */
+void psblk_unregister_device(struct psblk_device *dev)
 {
 	mutex_lock(&psz_lock);
 	if (psz_info && psz_info->read == dev->read) {
@@ -192,6 +178,7 @@ static void psblk_unregister_do(struct psblk_device *dev)
 	}
 	mutex_unlock(&psz_lock);
 }
+EXPORT_SYMBOL_GPL(psblk_unregister_device);
 
 /**
  * psblk_get_bdev() - open block device
@@ -405,11 +392,12 @@ int psblk_register_blkdev(unsigned int major, unsigned int flags,
 
 	dev.total_size = psblk_bdev_size(bdev);
 	dev.flags = flags;
-	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
+	dev.erase = NULL;
+	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 
-	ret = psblk_register_do(&dev);
+	ret = psblk_register_device(&dev);
 	if (ret)
 		goto err_put_bdev;
 
@@ -435,7 +423,7 @@ void psblk_unregister_blkdev(unsigned int major)
 	void *holder = blkdev;
 
 	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		psblk_unregister_do(&dev);
+		psblk_unregister_device(&dev);
 		psblk_put_bdev(psblk_bdev, holder);
 		blkdev_panic_write = NULL;
 		psblk_bdev = NULL;
diff --git a/fs/pstore/pstore_zone.c b/fs/pstore/pstore_zone.c
index 84ff53c1aaae..e51bc794f908 100644
--- a/fs/pstore/pstore_zone.c
+++ b/fs/pstore/pstore_zone.c
@@ -652,15 +652,21 @@ static inline int psz_oops_erase(struct psz_context *cxt,
 	struct psz_buffer *buffer = zone->buffer;
 	struct psz_oops_header *hdr =
 		(struct psz_oops_header *)buffer->data;
+	size_t size;
 
 	if (unlikely(!psz_ok(zone)))
 		return 0;
+
 	/* this zone is already updated, no need to erase */
 	if (record->count != hdr->counter)
 		return 0;
 
+	size = buffer_datalen(zone) + sizeof(*zone->buffer);
 	atomic_set(&zone->buffer->datalen, 0);
-	return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	if (cxt->psz_info->erase)
+		return cxt->psz_info->erase(size, zone->off);
+	else
+		return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
 
 static inline int psz_record_erase(struct psz_context *cxt,
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index d2ea1733b51a..e733f28aef2c 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -8,6 +8,41 @@
 #include <linux/pstore_zone.h>
 
 /**
+ * struct psblk_device - back-end pstore/blk driver structure.
+ *
+ * @total_size: The total size in bytes pstore/blk can use. It must be greater
+ *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all recorders for compatible.
+ * @read:	The general read operation. Both of the function parameters
+ *		@size and @offset are relative value to bock device (not the
+ *		whole disk).
+ *		On success, the number of bytes should be returned, others
+ *		means error.
+ * @write:	The same as @read, but the following error number:
+ *		-EBUSY means try to write again later.
+ *		-ENOMSG means to try next zone.
+ * @erase:	The general erase operation for device with special removing
+ *		job. Both of the function parameters @size and @offset are
+ *		relative value to storage.
+ *		Return 0 on success and others on failure.
+ * @panic_write:The write operation only used for panic case. It's optional
+ *		if you do not care panic log. The parameters are relative
+ *		value to storage.
+ *		On success, the number of bytes should be returned, others
+ *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
+ */
+struct psblk_device {
+	unsigned long total_size;
+	unsigned int flags;
+	psz_read_op read;
+	psz_write_op write;
+	psz_erase_op erase;
+	psz_write_op panic_write;
+};
+
+/**
  * typedef psblk_panic_write_op - panic write operation to block device
  *
  * @buf: the data to write
@@ -22,6 +57,8 @@
 typedef int (*psblk_panic_write_op)(const char *buf, sector_t start_sect,
 		sector_t sects);
 
+int psblk_register_device(struct psblk_device *dev);
+void psblk_unregister_device(struct psblk_device *dev);
 int  psblk_register_blkdev(unsigned int major, unsigned int flags,
 		psblk_panic_write_op panic_write);
 void psblk_unregister_blkdev(unsigned int major);
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 2bfa79bff97b..c2db8e5c6542 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -7,6 +7,7 @@
 
 typedef ssize_t (*psz_read_op)(char *, size_t, loff_t);
 typedef ssize_t (*psz_write_op)(const char *, size_t, loff_t);
+typedef ssize_t (*psz_erase_op)(size_t, loff_t);
 /**
  * struct psz_info - pstore/zone back-end driver structure
  *
@@ -27,6 +28,10 @@
  * @write:	The same as @read, but the following error number:
  *		-EBUSY means try to write again later.
  *		-ENOMSG means to try next zone.
+ * @erase:	The general erase operation for device with special removing
+ *		job. Both of the function parameters @size and @offset are
+ *		relative value to storage.
+ *		Return 0 on success and others on failure.
  * @panic_write:The write operation only used for panic case. It's optional
  *		if you do not care panic log. The parameters are relative
  *		value to storage.
@@ -45,6 +50,7 @@ struct psz_info {
 	int dump_oops;
 	psz_read_op read;
 	psz_write_op write;
+	psz_erase_op erase;
 	psz_write_op panic_write;
 };
 
-- 
1.9.1

