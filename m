Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40670C54FD8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE5820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCYIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:55:44 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43573 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbgCYIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.196746-0.000294681-0.802959;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:30 +0800
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
Subject: [PATCH v3 05/11] pstore/blk: blkoops: support console recorder
Date:   Wed, 25 Mar 2020 16:55:00 +0800
Message-Id: <1585126506-18635-6-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support recorder for console. To enable console recorder, just make
console_size be greater than 0 and a multiple of 4096.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig           | 12 ++++++++
 fs/pstore/pstore_blk.c      | 12 +++++++-
 fs/pstore/pstore_zone.c     | 70 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/pstore_zone.h |  4 ++-
 4 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8cead860dcfc..bf90de48ad3c 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -225,6 +225,18 @@ config PSTORE_BLK_PMSG_SIZE
 	  NOTE that, both Kconfig and module parameters can configure
 	  pstore/blk, but module parameters have priority over Kconfig.
 
+config PSTORE_BLK_CONSOLE_SIZE
+	int "Size in Kbytes of console to store"
+	depends on PSTORE_BLK
+	depends on PSTORE_CONSOLE
+	default 64
+	help
+	  This just sets size of console (console_size) for pstore/blk. The
+	  size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
 config PSTORE_BLK_DUMP_OOPS
 	bool "dump oops"
 	depends on PSTORE_BLK
diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index 85cd9f2335be..2b513acaa18f 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -26,6 +26,14 @@
 module_param(pmsg_size, long, 0400);
 MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
 
+#if IS_ENABLED(CONFIG_PSTORE_CONSOLE)
+static long console_size = CONFIG_PSTORE_BLK_CONSOLE_SIZE;
+#else
+static long console_size = -1;
+#endif
+module_param(console_size, long, 0400);
+MODULE_PARM_DESC(console_size, "console size in kbytes");
+
 static int dump_oops = CONFIG_PSTORE_BLK_DUMP_OOPS;
 module_param(dump_oops, int, 0400);
 MODULE_PARM_DESC(total_size, "whether dump oops");
@@ -81,7 +89,8 @@
  *		whole disk).
  *		On success, the number of bytes should be returned, others
  *		means error.
- * @write:	The same as @read.
+ * @write:	The same as @read, but the following error number:
+ *		-EBUSY means try to write again later.
  * @panic_write:The write operation only used for panic case. It's optional
  *		if you do not care panic log. The parameters and return value
  *		are the same as @read.
@@ -131,6 +140,7 @@ static int psblk_register_do(struct psblk_device *dev)
 
 	verify_size(oops_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
+	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
 #undef verify_size
 	dump_oops = dump_oops <= 0 ? 0 : 1;
 
diff --git a/fs/pstore/pstore_zone.c b/fs/pstore/pstore_zone.c
index 444bce7f9ac3..e1e84505b046 100644
--- a/fs/pstore/pstore_zone.c
+++ b/fs/pstore/pstore_zone.c
@@ -87,10 +87,12 @@ struct psz_zone {
  *
  * @opszs: oops/panic storage zones
  * @ppsz: pmsg storage zone
+ * @cpsz: console storage zone
  * @oops_max_cnt: max count of @opszs
  * @oops_read_cnt: counter to read oops zone
  * @oops_write_cnt: counter to write
  * @pmsg_read_cnt: counter to read pmsg zone
+ * @console_read_cnt: counter to read console zone
  * @oops_counter: counter to oops
  * @panic_counter: counter to panic
  * @recovered: whether finish recovering data from storage
@@ -102,10 +104,12 @@ struct psz_zone {
 struct psz_context {
 	struct psz_zone **opszs;
 	struct psz_zone *ppsz;
+	struct psz_zone *cpsz;
 	unsigned int oops_max_cnt;
 	unsigned int oops_read_cnt;
 	unsigned int oops_write_cnt;
 	unsigned int pmsg_read_cnt;
+	unsigned int console_read_cnt;
 	/*
 	 * the counter should be recovered when recover.
 	 * It records the oops/panic times after burning rather than booting.
@@ -125,6 +129,9 @@ struct psz_context {
 };
 static struct psz_context psz_cxt;
 
+static void psz_flush_all_dirty_zones(struct work_struct *);
+static DECLARE_WORK(psz_cleaner, psz_flush_all_dirty_zones);
+
 /**
  * enum psz_flush_mode - flush mode for psz_zone_write()
  *
@@ -235,6 +242,9 @@ static int psz_zone_write(struct psz_zone *zone,
 	return 0;
 dirty:
 	atomic_set(&zone->dirty, true);
+	/* flush dirty zones nicely */
+	if (wcnt == -EBUSY && !is_on_panic())
+		schedule_work(&psz_cleaner);
 	return -EBUSY;
 }
 
@@ -291,6 +301,15 @@ static int psz_move_zone(struct psz_zone *old, struct psz_zone *new)
 	return 0;
 }
 
+static void psz_flush_all_dirty_zones(struct work_struct *work)
+{
+	struct psz_context *cxt = &psz_cxt;
+
+	psz_flush_dirty_zone(cxt->ppsz);
+	psz_flush_dirty_zone(cxt->cpsz);
+	psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);
+}
+
 static int psz_recover_oops_data(struct psz_context *cxt)
 {
 	struct psz_info *info = cxt->psz_info;
@@ -546,6 +565,10 @@ static inline int psz_recovery(struct psz_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = psz_recover_zone(cxt, cxt->cpsz);
+	if (ret)
+		goto recover_fail;
+
 	pr_debug("recover end!\n");
 	atomic_set(&cxt->recovered, 1);
 	return 0;
@@ -561,6 +584,7 @@ static int psz_pstore_open(struct pstore_info *psi)
 
 	cxt->oops_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
+	cxt->console_read_cnt = 0;
 	return 0;
 }
 
@@ -625,8 +649,9 @@ static int psz_pstore_erase(struct pstore_record *record)
 		return psz_oops_erase(cxt, cxt->opszs[record->id], record);
 	case PSTORE_TYPE_PMSG:
 		return psz_record_erase(cxt, cxt->ppsz);
-	default:
-		return -EINVAL;
+	case PSTORE_TYPE_CONSOLE:
+		return psz_record_erase(cxt, cxt->cpsz);
+	default: return -EINVAL;
 	}
 }
 
@@ -767,9 +792,18 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 			record->reason == KMSG_DUMP_PANIC)
 		atomic_set(&cxt->on_panic, 1);
 
+	/*
+	 * if on panic, do not write except panic records
+	 * Fix case that panic_write prints log which wakes up console recorder.
+	 */
+	if (is_on_panic() && record->type != PSTORE_TYPE_DMESG)
+		return -EBUSY;
+
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
 		return psz_oops_write(cxt, record);
+	case PSTORE_TYPE_CONSOLE:
+		return psz_record_write(cxt->cpsz, record);
 	case PSTORE_TYPE_PMSG:
 		return psz_record_write(cxt->ppsz, record);
 	default:
@@ -794,6 +828,13 @@ static struct psz_zone *psz_read_next_zone(struct psz_context *cxt)
 			return zone;
 	}
 
+	if (cxt->console_read_cnt == 0) {
+		cxt->console_read_cnt++;
+		zone = cxt->cpsz;
+		if (psz_old_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -903,6 +944,8 @@ static ssize_t psz_pstore_read(struct pstore_record *record)
 		readop = psz_oops_read;
 		record->id = cxt->oops_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_CONSOLE:
+		fallthrough;
 	case PSTORE_TYPE_PMSG:
 		readop = psz_record_read;
 		break;
@@ -1050,6 +1093,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
 		psz_free_zones(&cxt->opszs, &cxt->oops_max_cnt);
 	if (cxt->ppsz)
 		psz_free_zone(&cxt->ppsz);
+	if (cxt->cpsz)
+		psz_free_zone(&cxt->cpsz);
 }
 
 static int psz_alloc_zones(struct psz_context *cxt)
@@ -1066,6 +1111,14 @@ static int psz_alloc_zones(struct psz_context *cxt)
 		goto free_out;
 	}
 
+	off_size += info->console_size;
+	cxt->cpsz = psz_init_zone(PSTORE_TYPE_CONSOLE, &off,
+			info->console_size);
+	if (IS_ERR(cxt->cpsz)) {
+		err = PTR_ERR(cxt->cpsz);
+		goto free_out;
+	}
+
 	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
 			info->total_size - off_size,
 			info->oops_size, &cxt->oops_max_cnt);
@@ -1100,7 +1153,7 @@ int psz_register(struct psz_info *info)
 		return -EINVAL;
 	}
 
-	if (!info->oops_size && !info->pmsg_size) {
+	if (!info->oops_size && !info->pmsg_size && !info->console_size) {
 		pr_warn("at least one of the records be non-zero\n");
 		return -EINVAL;
 	}
@@ -1128,6 +1181,7 @@ int psz_register(struct psz_info *info)
 	check_size(total_size, 4096);
 	check_size(oops_size, SECTOR_SIZE);
 	check_size(pmsg_size, SECTOR_SIZE);
+	check_size(console_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -1160,6 +1214,7 @@ int psz_register(struct psz_info *info)
 	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
 	pr_debug("\toops size : %ld Bytes\n", info->oops_size);
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
+	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
 
 	err = psz_alloc_zones(cxt);
 	if (err) {
@@ -1181,11 +1236,14 @@ int psz_register(struct psz_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
 	if (info->pmsg_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+	if (info->console_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
 
-	pr_info("Registered %s as pszone backend for%s%s%s\n", info->name,
+	pr_info("Registered %s as pszone backend for%s%s%s%s\n", info->name,
 			cxt->opszs && cxt->psz_info->dump_oops ? " Oops" : "",
 			cxt->opszs && cxt->psz_info->panic_write ? " Panic" : "",
-			cxt->ppsz ? " Pmsg" : "");
+			cxt->ppsz ? " Pmsg" : "",
+			cxt->cpsz ? " Console" : "");
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -1219,6 +1277,8 @@ void psz_unregister(struct psz_info *info)
 {
 	struct psz_context *cxt = &psz_cxt;
 
+	flush_work(&psz_cleaner);
+
 	pstore_unregister(&cxt->pstore);
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 85e159d8f935..8a1838633010 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -17,12 +17,13 @@
  * @oops_size:	The size of oops/panic zone. Zero means disabled, otherwise,
  *		it must be multiple of SECTOR_SIZE(512 Bytes).
  * @pmsg_size:	The size of pmsg zone which is the same as @oops_size.
+ * @console_size:The size of console zone which is the same as @oops_size.
  * @dump_oops:	Whether to dump oops log.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
  *		On success, the number of bytes should be returned, others
  *		means error.
- * @write:	The same as @read.
+ * @write:	The same as @read, but -EBUSY means try to write again later.
  * @panic_write:The write operation only used for panic case. It's optional
  *		if you do not care panic log. The parameters and return value
  *		are the same as @read.
@@ -34,6 +35,7 @@ struct psz_info {
 	unsigned long total_size;
 	unsigned long oops_size;
 	unsigned long pmsg_size;
+	unsigned long console_size;
 	int dump_oops;
 	psz_read_op read;
 	psz_write_op write;
-- 
1.9.1

