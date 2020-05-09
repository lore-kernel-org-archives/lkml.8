Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03054C54E4B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAB024956
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEILPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:15:37 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37410 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728243AbgEILOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:14:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436581|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00723887-0.00020148-0.99256;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.HVopGr-_1589022874;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVopGr-_1589022874)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sat, 09 May 2020 19:14:44 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Subject: [PATCH v5 04/12] pstore/blk: Provide way to choose pstore frontend support
Date:   Sat,  9 May 2020 19:14:06 +0800
Message-Id: <1589022854-19821-5-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most pstore backends lack support for all the pstore frontends, only
handling kmsg dump and not things like pmsg, console, and ftrace.
Provide a way for drivers using pstore/blk to list which frontends they
expect to support.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
Link: https://lore.kernel.org/r/1585126506-18635-4-git-send-email-liaoweixiong@allwinnertech.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c            | 18 ++++++++++++++----
 include/linux/pstore_blk.h |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index e249b22ff55f..57d9d180511e 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -67,6 +67,9 @@
  *
  * @total_size: The total size in bytes pstore/blk can use. It must be greater
  *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to bock device (not the
  *		whole disk).
@@ -79,6 +82,7 @@
  */
 struct psblk_device {
 	unsigned long total_size;
+	unsigned int flags;
 	psz_read_op read;
 	psz_write_op write;
 	psz_write_op panic_write;
@@ -104,8 +108,11 @@ static int psblk_register_do(struct psblk_device *dev)
 		return -ENOMEM;
 	}
 
-#define verify_size(name, alignsize) {					\
-		long _##name_ = (name);					\
+	/* zero means all backends for compatible */
+	if (!dev->flags)
+		dev->flags = UINT_MAX;
+#define verify_size(name, alignsize, enable) {				\
+		long _##name_ = (enable) ? (name) : 0;			\
 		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
 		if (_##name_ & ((alignsize) - 1)) {			\
 			pr_info(#name " must align to %d\n",		\
@@ -116,7 +123,7 @@ static int psblk_register_do(struct psblk_device *dev)
 		pstore_zone_info->name = _##name_;			\
 	}
 
-	verify_size(kmsg_size, 4096);
+	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 #undef verify_size
 
 	pstore_zone_info->total_size = dev->total_size;
@@ -312,6 +319,7 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * psblk_register_blkdev() - register block device to pstore/blk
  *
  * @major: the major device number of registering device
+ * @flags: refer to macro starting with PSTORE_FLAGS defined in linux/pstore.h
  * @panic_write: the interface for panic case.
  *
  * Only the matching major to @blkdev can register.
@@ -322,7 +330,8 @@ static struct bdev_info *psblk_get_bdev_info(void)
  * * 0		- OK
  * * Others	- something error.
  */
-int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
+int psblk_register_blkdev(unsigned int major, unsigned int flags,
+		psblk_panic_write_op panic_write)
 {
 	struct block_device *bdev;
 	struct psblk_device dev = {0};
@@ -353,6 +362,7 @@ int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
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

