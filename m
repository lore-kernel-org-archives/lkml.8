Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FEC54FD9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636F220714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCYI4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:56:07 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54913 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbgCYI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:56:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0775484-0.000381191-0.92207;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:31 +0800
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
Subject: [PATCH v3 06/11] pstore/blk: blkoops: support ftrace recorder
Date:   Wed, 25 Mar 2020 16:55:01 +0800
Message-Id: <1585126506-18635-7-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support recorder for ftrace. To enable ftrace recorder, just make
ftrace_size be greater than 0 and a multiple of 4096.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig           |  12 ++++
 fs/pstore/pstore_blk.c      |   9 +++
 fs/pstore/pstore_zone.c     | 172 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pstore_zone.h |   2 +
 4 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index bf90de48ad3c..55ce726be795 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -237,6 +237,18 @@ config PSTORE_BLK_CONSOLE_SIZE
 	  NOTE that, both Kconfig and module parameters can configure
 	  pstore/blk, but module parameters have priority over Kconfig.
 
+config PSTORE_BLK_FTRACE_SIZE
+	int "Size in Kbytes of ftarce to store"
+	depends on PSTORE_BLK
+	depends on PSTORE_FTRACE
+	default 64
+	help
+	  This just sets size of ftrace (ftrace_size) for pstore/blk. The
+	  size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
 config PSTORE_BLK_DUMP_OOPS
 	bool "dump oops"
 	depends on PSTORE_BLK
diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index 2b513acaa18f..560e7b3f0945 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -34,6 +34,14 @@
 module_param(console_size, long, 0400);
 MODULE_PARM_DESC(console_size, "console size in kbytes");
 
+#if IS_ENABLED(CONFIG_PSTORE_FTRACE)
+static long ftrace_size = CONFIG_PSTORE_BLK_FTRACE_SIZE;
+#else
+static long ftrace_size = -1;
+#endif
+module_param(ftrace_size, long, 0400);
+MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
+
 static int dump_oops = CONFIG_PSTORE_BLK_DUMP_OOPS;
 module_param(dump_oops, int, 0400);
 MODULE_PARM_DESC(total_size, "whether dump oops");
@@ -141,6 +149,7 @@ static int psblk_register_do(struct psblk_device *dev)
 	verify_size(oops_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
+	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
 #undef verify_size
 	dump_oops = dump_oops <= 0 ? 0 : 1;
 
diff --git a/fs/pstore/pstore_zone.c b/fs/pstore/pstore_zone.c
index e1e84505b046..1da4fc760d31 100644
--- a/fs/pstore/pstore_zone.c
+++ b/fs/pstore/pstore_zone.c
@@ -88,11 +88,14 @@ struct psz_zone {
  * @opszs: oops/panic storage zones
  * @ppsz: pmsg storage zone
  * @cpsz: console storage zone
+ * @fpszs: ftrace storage zones
  * @oops_max_cnt: max count of @opszs
  * @oops_read_cnt: counter to read oops zone
  * @oops_write_cnt: counter to write
  * @pmsg_read_cnt: counter to read pmsg zone
  * @console_read_cnt: counter to read console zone
+ * @ftrace_max_cnt: max count of @fpszs
+ * @ftrace_read_cnt: counter to read ftrace zone
  * @oops_counter: counter to oops
  * @panic_counter: counter to panic
  * @recovered: whether finish recovering data from storage
@@ -105,11 +108,14 @@ struct psz_context {
 	struct psz_zone **opszs;
 	struct psz_zone *ppsz;
 	struct psz_zone *cpsz;
+	struct psz_zone **fpszs;
 	unsigned int oops_max_cnt;
 	unsigned int oops_read_cnt;
 	unsigned int oops_write_cnt;
 	unsigned int pmsg_read_cnt;
 	unsigned int console_read_cnt;
+	unsigned int ftrace_max_cnt;
+	unsigned int ftrace_read_cnt;
 	/*
 	 * the counter should be recovered when recover.
 	 * It records the oops/panic times after burning rather than booting.
@@ -308,6 +314,7 @@ static void psz_flush_all_dirty_zones(struct work_struct *work)
 	psz_flush_dirty_zone(cxt->ppsz);
 	psz_flush_dirty_zone(cxt->cpsz);
 	psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);
+	psz_flush_dirty_zones(cxt->fpszs, cxt->ftrace_max_cnt);
 }
 
 static int psz_recover_oops_data(struct psz_context *cxt)
@@ -542,6 +549,31 @@ static int psz_recover_zone(struct psz_context *cxt, struct psz_zone *zone)
 	return ret;
 }
 
+static int psz_recover_zones(struct psz_context *cxt,
+		struct psz_zone **zones, unsigned int cnt)
+{
+	int ret;
+	unsigned int i;
+	struct psz_zone *zone;
+
+	if (!zones)
+		return 0;
+
+	for (i = 0; i < cnt; i++) {
+		zone = zones[i];
+		if (unlikely(!zone))
+			continue;
+		ret = psz_recover_zone(cxt, zone);
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
 /**
  * psz_recovery() - recover data from storage
  * @cxt: the context of pstore/zone
@@ -569,6 +601,10 @@ static inline int psz_recovery(struct psz_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = psz_recover_zones(cxt, cxt->fpszs, cxt->ftrace_max_cnt);
+	if (ret)
+		goto recover_fail;
+
 	pr_debug("recover end!\n");
 	atomic_set(&cxt->recovered, 1);
 	return 0;
@@ -585,6 +621,7 @@ static int psz_pstore_open(struct pstore_info *psi)
 	cxt->oops_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
 	cxt->console_read_cnt = 0;
+	cxt->ftrace_read_cnt = 0;
 	return 0;
 }
 
@@ -651,6 +688,10 @@ static int psz_pstore_erase(struct pstore_record *record)
 		return psz_record_erase(cxt, cxt->ppsz);
 	case PSTORE_TYPE_CONSOLE:
 		return psz_record_erase(cxt, cxt->cpsz);
+	case PSTORE_TYPE_FTRACE:
+		if (record->id >= cxt->ftrace_max_cnt)
+			return -EINVAL;
+		return psz_record_erase(cxt, cxt->fpszs[record->id]);
 	default: return -EINVAL;
 	}
 }
@@ -806,6 +847,13 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 		return psz_record_write(cxt->cpsz, record);
 	case PSTORE_TYPE_PMSG:
 		return psz_record_write(cxt->ppsz, record);
+	case PSTORE_TYPE_FTRACE: {
+		int zonenum = smp_processor_id();
+
+		if (!cxt->fpszs)
+			return -ENOSPC;
+		return psz_record_write(cxt->fpszs[zonenum], record);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -821,6 +869,14 @@ static struct psz_zone *psz_read_next_zone(struct psz_context *cxt)
 			return zone;
 	}
 
+	if (cxt->ftrace_read_cnt < cxt->ftrace_max_cnt)
+		/*
+		 * No need psz_old_ok(). Let psz_ftrace_read() do so for
+		 * combination. psz_ftrace_read() should traverse over
+		 * all zones in case of some zone without data.
+		 */
+		return cxt->fpszs[cxt->ftrace_read_cnt++];
+
 	if (cxt->pmsg_read_cnt == 0) {
 		cxt->pmsg_read_cnt++;
 		zone = cxt->ppsz;
@@ -894,6 +950,98 @@ static ssize_t psz_oops_read(struct psz_zone *zone,
 	return size + hlen;
 }
 
+static int psz_ftrace_combine(char *src1_buf, size_t src1_size,
+		char *src2_buf, size_t src2_size,
+		char **dest_buf, size_t *dest_size)
+{
+	size_t src1_off, src2_off, total;
+	size_t src1_idx = 0, src2_idx = 0, merged_idx = 0;
+	void *merged_buf;
+	struct pstore_ftrace_record *mrec, *s1rec, *s2rec;
+	size_t record_size = sizeof(struct pstore_ftrace_record);
+
+	src1_off = src1_size % record_size;
+	src1_size -= src1_off;
+
+	src2_off = src2_size % record_size;
+	src2_size -= src2_off;
+
+	total = src1_size + src2_size;
+	merged_buf = kmalloc(total, GFP_KERNEL);
+	if (!merged_buf)
+		return -ENOMEM;
+
+	s1rec = (struct pstore_ftrace_record *)(src1_buf + src1_off);
+	s2rec = (struct pstore_ftrace_record *)(src2_buf + src2_off);
+	mrec = (struct pstore_ftrace_record *)(merged_buf);
+
+	while (src1_size > 0 && src2_size > 0) {
+		u64 s1_ts, s2_ts;
+
+		s1_ts = pstore_ftrace_read_timestamp(&s1rec[src1_idx]);
+		s2_ts = pstore_ftrace_read_timestamp(&s2rec[src2_idx]);
+		if (s1_ts < s2_ts) {
+			mrec[merged_idx++] = s1rec[src1_idx++];
+			src1_size -= record_size;
+		} else {
+			mrec[merged_idx++] = s2rec[src2_idx++];
+			src2_size -= record_size;
+		}
+	}
+
+	while (src1_size > 0) {
+		mrec[merged_idx++] = s1rec[src1_idx++];
+		src1_size -= record_size;
+	}
+
+	while (src2_size > 0) {
+		mrec[merged_idx++] = s2rec[src2_idx++];
+		src2_size -= record_size;
+	}
+
+	*dest_buf = merged_buf;
+	*dest_size = total;
+	return 0;
+}
+
+/* try to combine all ftrace zones */
+static ssize_t psz_ftrace_read(struct psz_zone *zone,
+		struct pstore_record *record)
+{
+	struct psz_context *cxt = record->psi->data;
+	struct psz_buffer *buf;
+	char *dest;
+	size_t dest_size;
+	int ret;
+
+	if (!zone || !record)
+		return -ENOSPC;
+
+	if (!psz_old_ok(zone))
+		goto out;
+
+	buf = (struct psz_buffer *)zone->oldbuf;
+	if (!buf)
+		return -ENOMSG;
+
+	ret = psz_ftrace_combine(record->buf, record->size,
+			(char *)buf->data, atomic_read(&buf->datalen),
+			&dest, &dest_size);
+	if (unlikely(ret))
+		return ret;
+
+	kfree(record->buf);
+	record->buf = dest;
+	record->size = dest_size;
+
+out:
+	if (cxt->ftrace_read_cnt < cxt->ftrace_max_cnt)
+		/* then, read next ftrace zone */
+		return -ENOMSG;
+	record->id = 0;
+	return record->size ? record->size : -ENOMSG;
+}
+
 static ssize_t psz_record_read(struct psz_zone *zone,
 		struct pstore_record *record)
 {
@@ -944,6 +1092,9 @@ static ssize_t psz_pstore_read(struct pstore_record *record)
 		readop = psz_oops_read;
 		record->id = cxt->oops_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_FTRACE:
+		readop = psz_ftrace_read;
+		break;
 	case PSTORE_TYPE_CONSOLE:
 		fallthrough;
 	case PSTORE_TYPE_PMSG:
@@ -1095,6 +1246,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
 		psz_free_zone(&cxt->ppsz);
 	if (cxt->cpsz)
 		psz_free_zone(&cxt->cpsz);
+	if (cxt->fpszs)
+		psz_free_zones(&cxt->fpszs, &cxt->ftrace_max_cnt);
 }
 
 static int psz_alloc_zones(struct psz_context *cxt)
@@ -1119,6 +1272,16 @@ static int psz_alloc_zones(struct psz_context *cxt)
 		goto free_out;
 	}
 
+	off_size += info->ftrace_size;
+	cxt->fpszs = psz_init_zones(PSTORE_TYPE_FTRACE, &off,
+			info->ftrace_size,
+			info->ftrace_size / nr_cpu_ids,
+			&cxt->ftrace_max_cnt);
+	if (IS_ERR(cxt->fpszs)) {
+		err = PTR_ERR(cxt->fpszs);
+		goto free_out;
+	}
+
 	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
 			info->total_size - off_size,
 			info->oops_size, &cxt->oops_max_cnt);
@@ -1182,6 +1345,7 @@ int psz_register(struct psz_info *info)
 	check_size(oops_size, SECTOR_SIZE);
 	check_size(pmsg_size, SECTOR_SIZE);
 	check_size(console_size, SECTOR_SIZE);
+	check_size(ftrace_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -1215,6 +1379,7 @@ int psz_register(struct psz_info *info)
 	pr_debug("\toops size : %ld Bytes\n", info->oops_size);
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
 	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
+	pr_debug("\tftrace size : %ld Bytes\n", info->ftrace_size);
 
 	err = psz_alloc_zones(cxt);
 	if (err) {
@@ -1238,12 +1403,15 @@ int psz_register(struct psz_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 	if (info->console_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
+	if (info->ftrace_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 
-	pr_info("Registered %s as pszone backend for%s%s%s%s\n", info->name,
+	pr_info("Registered %s as pszone backend for%s%s%s%s%s\n", info->name,
 			cxt->opszs && cxt->psz_info->dump_oops ? " Oops" : "",
 			cxt->opszs && cxt->psz_info->panic_write ? " Panic" : "",
 			cxt->ppsz ? " Pmsg" : "",
-			cxt->cpsz ? " Console" : "");
+			cxt->cpsz ? " Console" : "",
+			cxt->fpszs ? " Ftrace" : "");
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 8a1838633010..a138e8b7dc20 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -18,6 +18,7 @@
  *		it must be multiple of SECTOR_SIZE(512 Bytes).
  * @pmsg_size:	The size of pmsg zone which is the same as @oops_size.
  * @console_size:The size of console zone which is the same as @oops_size.
+ * @ftrace_size:The size of ftrace zone which is the same as @oops_size.
  * @dump_oops:	Whether to dump oops log.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
@@ -36,6 +37,7 @@ struct psz_info {
 	unsigned long oops_size;
 	unsigned long pmsg_size;
 	unsigned long console_size;
+	unsigned long ftrace_size;
 	int dump_oops;
 	psz_read_op read;
 	psz_write_op write;
-- 
1.9.1

