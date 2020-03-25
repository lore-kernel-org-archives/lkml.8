Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6AC54FD6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A5A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgCYIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:55:51 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55163 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727299AbgCYIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437167|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00953176-0.000256599-0.990212;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:28 +0800
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
Subject: [PATCH v3 03/11] pstore/blk: respect for driver to pick pstore front-ends
Date:   Wed, 25 Mar 2020 16:54:58 +0800
Message-Id: <1585126506-18635-4-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most devices, not all psotre front-ends are supported. Pstore/blk
should provide a way for drivers to list the supported front-ends.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/pstore_blk.c     | 18 ++++++++++++++----
 include/linux/pstore_blk.h |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index 2fbdd4563e5c..f3ce7bbd9077 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -65,6 +65,9 @@
  *
  * @total_size: The total size in bytes pstore/blk can use. It must be greater
  *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all recorders for compatible.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to bock device (not the
  *		whole disk).
@@ -77,6 +80,7 @@
  */
 struct psblk_device {
 	unsigned long total_size;
+	unsigned int flags;
 	psz_read_op read;
 	psz_write_op write;
 	psz_write_op panic_write;
@@ -102,8 +106,11 @@ static int psblk_register_do(struct psblk_device *dev)
 		return -ENOMEM;
 	}
 
-#define verify_size(name, alignsize) {					\
-		long _##name_ = (name);					\
+	/* zero means all recorders for compatible */
+	if (!dev->flags)
+		dev->flags = UINT_MAX;
+#define verify_size(name, alignsize, enable) {				\
+		long _##name_ = (enable) ? (name) : 0;			\
 		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
 		if (_##name_ & ((alignsize) - 1)) {			\
 			pr_info(#name " must align to %d\n",		\
@@ -114,7 +121,7 @@ static int psblk_register_do(struct psblk_device *dev)
 		psz_info->name = _##name_;				\
 	}
 
-	verify_size(oops_size, 4096);
+	verify_size(oops_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 #undef verify_size
 	dump_oops = dump_oops <= 0 ? 0 : 1;
 
@@ -311,6 +318,7 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * psblk_register_blkdev() - register block device to pstore/blk
  *
  * @major: the major device number of registering device
+ * @flags: refer to macro starting with PSTORE_FLAGS defined in linux/pstore.h
  * @panic_write: the interface for panic case.
  *
  * Only the matching major to @blkdev can register.
@@ -321,7 +329,8 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * * 0		- OK
  * * Others	- something error.
  */
-int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
+int psblk_register_blkdev(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write)
 {
 	struct block_device *bdev;
 	struct psblk_device dev = {0};
@@ -352,6 +361,7 @@ int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
 	blkdev_panic_write = panic_write;
 
 	dev.total_size = psblk_bdev_size(bdev);
+	dev.flags = flags;
 	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 5ff465e3953e..d8f609e60288 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -4,6 +4,7 @@
 #define __PSTORE_BLK_H_
 
 #include <linux/types.h>
+#include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
 /**
@@ -20,7 +21,8 @@
 typedef int (*psblk_panic_write_op)(const char *buf, sector_t start_sect,
 		sector_t sects);
 
-int  psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write);
+int  psblk_register_blkdev(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write);
 void psblk_unregister_blkdev(unsigned int major);
 int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
 
-- 
1.9.1

