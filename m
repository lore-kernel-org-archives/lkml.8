Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE2C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1722076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCYIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:55:41 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60731 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbgCYIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439015|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0260262-0.000154574-0.973819;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:34 +0800
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
Subject: [PATCH v3 09/11] pstore/blk: a way to get user configure about pstore front-ends.
Date:   Wed, 25 Mar 2020 16:55:04 +0800
Message-Id: <1585126506-18635-10-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's one of a series of patches to adapt to MTD device.

It's different to block driver, MTD driver should check zone size
and get identifier to MTD device. To make it, psblk_usr_info() is
created.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/pstore_blk.c     | 37 ++++++++++++++++++++++++++++++-------
 include/linux/pstore_blk.h | 10 ++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index d6949146135b..061609b66d8a 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -84,6 +84,17 @@
 	sector_t start_sect;
 } g_bdev_info;
 
+#define check_size(name, alignsize) ({				\
+	long _##name_ = (name);					\
+	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+	if (_##name_ & ((alignsize) - 1)) {			\
+		pr_info(#name " must align to %d\n",		\
+				(alignsize));			\
+		_##name_ = ALIGN(name, (alignsize));		\
+	}							\
+	_##name_;						\
+})
+
 /**
  * struct psblk_device - back-end pstore/blk driver structure.
  *
@@ -138,13 +149,11 @@ static int psblk_register_do(struct psblk_device *dev)
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 #define verify_size(name, alignsize, enable) {				\
-		long _##name_ = (enable) ? (name) : 0;			\
-		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
-		if (_##name_ & ((alignsize) - 1)) {			\
-			pr_info(#name " must align to %d\n",		\
-					(alignsize));			\
-			_##name_ = ALIGN(name, (alignsize));		\
-		}							\
+		long _##name_;						\
+		if (enable)						\
+			_##name_ = check_size(name, alignsize);		\
+		else							\
+			_##name_ = 0;					\
 		name = _##name_ / 1024;					\
 		psz_info->name = _##name_;				\
 	}
@@ -464,6 +473,20 @@ int psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
 }
 EXPORT_SYMBOL_GPL(psblk_blkdev_info);
 
+/* get information of pstore/blk */
+int psblk_usr_info(struct psblk_info *info)
+{
+	strncpy(info->device, blkdev, 80);
+	info->dump_oops = dump_oops <= 0 ? 0 : 1;
+	info->oops_size = check_size(oops_size, 4096);
+	info->pmsg_size = check_size(pmsg_size, 4096);
+	info->ftrace_size = check_size(ftrace_size, 4096);
+	info->console_size = check_size(console_size, 4096);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(psblk_usr_info);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
 MODULE_DESCRIPTION("Block device Oops/Panic logger");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 828b0763d477..d2ea1733b51a 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -27,4 +27,14 @@ int  psblk_register_blkdev(unsigned int major, unsigned int flags,
 void psblk_unregister_blkdev(unsigned int major);
 int  psblk_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
 
+struct psblk_info {
+	int dump_oops;
+	char device[80];
+	unsigned long oops_size;
+	unsigned long pmsg_size;
+	unsigned long console_size;
+	unsigned long ftrace_size;
+};
+int psblk_usr_info(struct psblk_info *info);
+
 #endif
-- 
1.9.1

