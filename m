Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABBC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2826206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgATBEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 20:04:13 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59689 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729117AbgATBEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:04:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.295461-0.0239955-0.680544;DS=CONTINUE|ham_system_inform|0.132419-0.000329682-0.867252;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gf.OYKf_1579482234;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gf.OYKf_1579482234)
          by smtp.aliyun-inc.com(10.147.42.16);
          Mon, 20 Jan 2020 09:04:04 +0800
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
Subject: [PATCH v1 05/11] pstore/blk: blkoops: support ftrace recorder
Date:   Mon, 20 Jan 2020 09:03:47 +0800
Message-Id: <1579482233-2672-6-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support recorder for ftrace. To enable ftrace recorder, just make
ftrace_size be greater than 0 and a multiple of 4096.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig          | 12 ++++++++
 fs/pstore/blkoops.c        | 11 +++++++
 fs/pstore/blkzone.c        | 75 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pstore_blk.h |  4 +++
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index af83ae59f31a..5649218d2821 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -210,6 +210,18 @@ config PSTORE_BLKOOPS_CONSOLE_SIZE
 	  NOTE that, both kconfig and module parameters can configure blkoops,
 	  but module parameters have priority over kconfig.
 
+config PSTORE_BLKOOPS_FTRACE_SIZE
+	int "ftrace size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	depends on PSTORE_FTRACE
+	default 64
+	help
+	  This just sets size of ftrace (ftrace_size) for pstore/blk. The
+	  value must be a multiple of 4096.
+
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
+
 config PSTORE_BLKOOPS_BLKDEV
 	string "block device for blkoops"
 	depends on PSTORE_BLKOOPS
diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
index 91754795d612..3f28e61c8ecf 100644
--- a/fs/pstore/blkoops.c
+++ b/fs/pstore/blkoops.c
@@ -39,6 +39,10 @@
 module_param(console_size, long, 0400);
 MODULE_PARM_DESC(console_size, "console size in kbytes");
 
+static long ftrace_size = -1;
+module_param(ftrace_size, long, 0400);
+MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
+
 static int dump_oops = -1;
 module_param(dump_oops, int, 0400);
 MODULE_PARM_DESC(total_size, "whether dump oops");
@@ -95,6 +99,12 @@
 #define DEFAULT_CONSOLE_SIZE 0
 #endif
 
+#ifdef CONFIG_PSTORE_BLKOOPS_FTRACE_SIZE
+#define DEFAULT_FTRACE_SIZE CONFIG_PSTORE_BLKOOPS_FTRACE_SIZE
+#else
+#define DEFAULT_FTRACE_SIZE 0
+#endif
+
 #ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
 #define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
 #else
@@ -150,6 +160,7 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
 	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
 	verify_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096);
 	verify_size(console_size, DEFAULT_CONSOLE_SIZE, 4096);
+	verify_size(ftrace_size, DEFAULT_FTRACE_SIZE, 4096);
 #undef verify_size
 	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
 
diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
index 1bb914a2622a..66ae8e2a924b 100644
--- a/fs/pstore/blkzone.c
+++ b/fs/pstore/blkzone.c
@@ -105,10 +105,13 @@ struct blkz_context {
 	struct blkz_zone **dbzs;	/* dmesg block zones */
 	struct blkz_zone *pbz;		/* Pmsg block zone */
 	struct blkz_zone *cbz;		/* console block zone */
+	struct blkz_zone **fbzs;	/* Ftrace zones */
 	unsigned int dmesg_max_cnt;
 	unsigned int dmesg_read_cnt;
 	unsigned int pmsg_read_cnt;
 	unsigned int console_read_cnt;
+	unsigned int ftrace_max_cnt;
+	unsigned int ftrace_read_cnt;
 	unsigned int dmesg_write_cnt;
 	/*
 	 * the counter should be recovered when recover.
@@ -297,6 +300,7 @@ static void blkz_flush_all_dirty_zones(struct work_struct *work)
 	blkz_flush_dirty_zone(cxt->pbz);
 	blkz_flush_dirty_zone(cxt->cbz);
 	blkz_flush_dirty_zones(cxt->dbzs, cxt->dmesg_max_cnt);
+	blkz_flush_dirty_zones(cxt->fbzs, cxt->ftrace_max_cnt);
 }
 
 static int blkz_recover_dmesg_data(struct blkz_context *cxt)
@@ -513,6 +517,31 @@ static int blkz_recover_zone(struct blkz_context *cxt, struct blkz_zone *zone)
 	return ret;
 }
 
+static int blkz_recover_zones(struct blkz_context *cxt,
+		struct blkz_zone **zones, unsigned int cnt)
+{
+	int ret;
+	unsigned int i;
+	struct blkz_zone *zone;
+
+	if (!zones)
+		return 0;
+
+	for (i = 0; i < cnt; i++) {
+		zone = zones[i];
+		if (unlikely(!zone))
+			continue;
+		ret = blkz_recover_zone(cxt, zone);
+		if (ret)
+			goto recover_fail;
+	}
+
+	return 0;
+recover_fail:
+	pr_debug("recover %s[%u] failed\n", zone->name, i);
+	return ret;
+}
+
 static inline int blkz_recovery(struct blkz_context *cxt)
 {
 	int ret = -EBUSY;
@@ -532,6 +561,10 @@ static inline int blkz_recovery(struct blkz_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = blkz_recover_zones(cxt, cxt->fbzs, cxt->ftrace_max_cnt);
+	if (ret)
+		goto recover_fail;
+
 	pr_debug("recover end!\n");
 	atomic_set(&cxt->recovered, 1);
 	return 0;
@@ -548,6 +581,7 @@ static int blkz_pstore_open(struct pstore_info *psi)
 	cxt->dmesg_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
 	cxt->console_read_cnt = 0;
+	cxt->ftrace_read_cnt = 0;
 	return 0;
 }
 
@@ -605,6 +639,8 @@ static int blkz_pstore_erase(struct pstore_record *record)
 		return blkz_record_erase(cxt, cxt->pbz);
 	case PSTORE_TYPE_CONSOLE:
 		return blkz_record_erase(cxt, cxt->cbz);
+	case PSTORE_TYPE_FTRACE:
+		return blkz_record_erase(cxt, cxt->fbzs[record->id]);
 	default: return -EINVAL;
 	}
 }
@@ -759,6 +795,13 @@ static int notrace blkz_pstore_write(struct pstore_record *record)
 		return blkz_record_write(cxt, cxt->cbz, record);
 	case PSTORE_TYPE_PMSG:
 		return blkz_record_write(cxt, cxt->pbz, record);
+	case PSTORE_TYPE_FTRACE: {
+		int zonenum = smp_processor_id();
+
+		if (!cxt->fbzs)
+			return -ENOSPC;
+		return blkz_record_write(cxt, cxt->fbzs[zonenum], record);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -775,6 +818,12 @@ static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
 			return zone;
 	}
 
+	while (cxt->ftrace_read_cnt < cxt->ftrace_max_cnt) {
+		zone = cxt->fbzs[cxt->ftrace_read_cnt++];
+		if (blkz_old_ok(zone))
+			return zone;
+	}
+
 	if (cxt->pmsg_read_cnt == 0) {
 		cxt->pmsg_read_cnt++;
 		zone = cxt->pbz;
@@ -897,6 +946,9 @@ static ssize_t blkz_pstore_read(struct pstore_record *record)
 		readop = blkz_dmesg_read;
 		record->id = cxt->dmesg_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_FTRACE:
+		record->id = cxt->ftrace_read_cnt - 1;
+		/* fallthrough */
 	case PSTORE_TYPE_CONSOLE:
 		/* fallthrough */
 	case PSTORE_TYPE_PMSG:
@@ -1062,15 +1114,27 @@ static int blkz_cut_zones(struct blkz_context *cxt)
 		goto free_pmsg;
 	}
 
+	off_size += info->ftrace_size;
+	cxt->fbzs = blkz_init_zones(PSTORE_TYPE_FTRACE, &off,
+			info->ftrace_size,
+			info->ftrace_size / nr_cpu_ids,
+			&cxt->ftrace_max_cnt);
+	if (IS_ERR(cxt->fbzs)) {
+		err = PTR_ERR(cxt->fbzs);
+		goto free_console;
+	}
+
 	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off,
 			info->total_size - off_size,
 			info->dmesg_size, &cxt->dmesg_max_cnt);
 	if (IS_ERR(cxt->dbzs)) {
 		err = PTR_ERR(cxt->dbzs);
-		goto free_console;
+		goto free_ftrace;
 	}
 
 	return 0;
+free_ftrace:
+	blkz_free_zones(&cxt->fbzs, &cxt->ftrace_max_cnt);
 free_console:
 	blkz_free_zone(&cxt->cbz);
 free_pmsg:
@@ -1119,6 +1183,7 @@ int blkz_register(struct blkz_info *info)
 	check_size(dmesg_size, SECTOR_SIZE);
 	check_size(pmsg_size, SECTOR_SIZE);
 	check_size(console_size, SECTOR_SIZE);
+	check_size(ftrace_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -1152,6 +1217,7 @@ int blkz_register(struct blkz_info *info)
 	pr_debug("\tdmesg size : %ld Bytes\n", info->dmesg_size);
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
 	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
+	pr_debug("\tftrace size : %ld Bytes\n", info->ftrace_size);
 
 	err = blkz_cut_zones(cxt);
 	if (err) {
@@ -1175,13 +1241,16 @@ int blkz_register(struct blkz_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 	if (info->console_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
+	if (info->ftrace_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 
-	pr_info("Registered %s as blkzone backend for %s%s%s%s\n",
+	pr_info("Registered %s as blkzone backend for %s%s%s%s%s\n",
 			info->name,
 			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
 			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "",
 			cxt->pbz ? "Pmsg " : "",
-			cxt->cbz ? "Console" : "");
+			cxt->cbz ? "Console " : "",
+			cxt->fbzs ? "Ftrace" : "");
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 546375e04419..77704c1b404a 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -25,6 +25,9 @@
  * @console_size:
  *	The size of zone for console. Zero means disabled, othewise, it must
  *	be multiple of SECTOR_SIZE(512).
+ * @ftrace_size:
+ *	The size of zone for ftrace. Zero means disabled, othewise, it must
+ *	be multiple of SECTOR_SIZE(512).
  * @dump_oops:
  *	Dump oops and panic log or only panic.
  * @read, @write:
@@ -60,6 +63,7 @@ struct blkz_info {
 	unsigned long dmesg_size;
 	unsigned long pmsg_size;
 	unsigned long console_size;
+	unsigned long ftrace_size;
 	int dump_oops;
 	blkz_read_op read;
 	blkz_write_op write;
-- 
1.9.1

