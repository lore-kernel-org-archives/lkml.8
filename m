Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E2C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8111820714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCYI4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:56:00 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47539 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgCYIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.147272-0.000573396-0.852155;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.H50xpyL_1585126516;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H50xpyL_1585126516)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 25 Mar 2020 16:55:29 +0800
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
Subject: [PATCH v3 04/11] pstore/blk: pstore/zone: support pmsg recorder
Date:   Wed, 25 Mar 2020 16:54:59 +0800
Message-Id: <1585126506-18635-5-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmsg support recorder for userspace. To enable pmsg, just make pmsg_size
be greater than 0 and a multiple of 4096.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig           |  12 ++
 fs/pstore/pstore_blk.c      |   9 ++
 fs/pstore/pstore_zone.c     | 273 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/pstore_zone.h |   2 +
 4 files changed, 283 insertions(+), 13 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 590af61019c2..8cead860dcfc 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -213,6 +213,18 @@ config PSTORE_BLK_OOPS_SIZE
 	  NOTE that, both Kconfig and module parameters can configure
 	  pstore/blk, but module parameters have priority over Kconfig.
 
+config PSTORE_BLK_PMSG_SIZE
+	int "Size in Kbytes of pmsg to store"
+	depends on PSTORE_BLK
+	depends on PSTORE_PMSG
+	default 64
+	help
+	  This just sets size of pmsg (pmsg_size) for pstore/blk. The size is
+	  in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
+
 config PSTORE_BLK_DUMP_OOPS
 	bool "dump oops"
 	depends on PSTORE_BLK
diff --git a/fs/pstore/pstore_blk.c b/fs/pstore/pstore_blk.c
index f3ce7bbd9077..85cd9f2335be 100644
--- a/fs/pstore/pstore_blk.c
+++ b/fs/pstore/pstore_blk.c
@@ -18,6 +18,14 @@
 module_param(oops_size, long, 0400);
 MODULE_PARM_DESC(oops_size, "oops size in kbytes");
 
+#if IS_ENABLED(CONFIG_PSTORE_PMSG)
+static long pmsg_size = CONFIG_PSTORE_BLK_PMSG_SIZE;
+#else
+static long pmsg_size = -1;
+#endif
+module_param(pmsg_size, long, 0400);
+MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
+
 static int dump_oops = CONFIG_PSTORE_BLK_DUMP_OOPS;
 module_param(dump_oops, int, 0400);
 MODULE_PARM_DESC(total_size, "whether dump oops");
@@ -122,6 +130,7 @@ static int psblk_register_do(struct psblk_device *dev)
 	}
 
 	verify_size(oops_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
+	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 #undef verify_size
 	dump_oops = dump_oops <= 0 ? 0 : 1;
 
diff --git a/fs/pstore/pstore_zone.c b/fs/pstore/pstore_zone.c
index 62c834072498..444bce7f9ac3 100644
--- a/fs/pstore/pstore_zone.c
+++ b/fs/pstore/pstore_zone.c
@@ -23,12 +23,14 @@
  *
  * @sig: signature to indicate header (PSZ_SIG xor PSZONE-type value)
  * @datalen: length of data in @data
+ * @start: offset into @data where the beginning of the stored bytes begin
  * @data: zone data.
  */
 struct psz_buffer {
 #define PSZ_SIG (0x43474244) /* DBGC */
 	uint32_t sig;
 	atomic_t datalen;
+	atomic_t start;
 	uint8_t data[];
 };
 
@@ -84,9 +86,11 @@ struct psz_zone {
  * struct psz_context - all about running state of pstore/zone
  *
  * @opszs: oops/panic storage zones
+ * @ppsz: pmsg storage zone
  * @oops_max_cnt: max count of @opszs
  * @oops_read_cnt: counter to read oops zone
  * @oops_write_cnt: counter to write
+ * @pmsg_read_cnt: counter to read pmsg zone
  * @oops_counter: counter to oops
  * @panic_counter: counter to panic
  * @recovered: whether finish recovering data from storage
@@ -97,9 +101,11 @@ struct psz_zone {
  */
 struct psz_context {
 	struct psz_zone **opszs;
+	struct psz_zone *ppsz;
 	unsigned int oops_max_cnt;
 	unsigned int oops_read_cnt;
 	unsigned int oops_write_cnt;
+	unsigned int pmsg_read_cnt;
 	/*
 	 * the counter should be recovered when recover.
 	 * It records the oops/panic times after burning rather than booting.
@@ -139,6 +145,11 @@ static inline int buffer_datalen(struct psz_zone *zone)
 	return atomic_read(&zone->buffer->datalen);
 }
 
+static inline int buffer_start(struct psz_zone *zone)
+{
+	return atomic_read(&zone->buffer->start);
+}
+
 static inline bool is_on_panic(void)
 {
 	struct psz_context *cxt = &psz_cxt;
@@ -146,10 +157,10 @@ static inline bool is_on_panic(void)
 	return atomic_read(&cxt->on_panic);
 }
 
-static ssize_t psz_zone_read(struct psz_zone *zone, char *buf,
+static ssize_t psz_zone_read_buffer(struct psz_zone *zone, char *buf,
 		size_t len, unsigned long off)
 {
-	if (!buf || !zone->buffer)
+	if (!buf || !zone || !zone->buffer)
 		return -EINVAL;
 	if (off > zone->buffer_size)
 		return -EINVAL;
@@ -158,6 +169,18 @@ static ssize_t psz_zone_read(struct psz_zone *zone, char *buf,
 	return len;
 }
 
+static int psz_zone_read_oldbuf(struct psz_zone *zone, char *buf,
+		size_t len, unsigned long off)
+{
+	if (!buf || !zone || !zone->oldbuf)
+		return -EINVAL;
+	if (off > zone->buffer_size)
+		return -EINVAL;
+	len = min_t(size_t, len, zone->buffer_size - off);
+	memcpy(buf, zone->oldbuf->data + off, len);
+	return 0;
+}
+
 static int psz_zone_write(struct psz_zone *zone,
 		enum psz_flush_mode flush_mode, const char *buf,
 		size_t len, unsigned long off)
@@ -413,6 +436,93 @@ static int psz_recover_oops(struct psz_context *cxt)
 	return ret;
 }
 
+static int psz_recover_zone(struct psz_context *cxt, struct psz_zone *zone)
+{
+	struct psz_info *info = cxt->psz_info;
+	struct psz_buffer *oldbuf, tmpbuf;
+	int ret = 0;
+	char *buf;
+	ssize_t rcnt, len, start, off;
+
+	if (!zone || zone->oldbuf)
+		return 0;
+
+	if (is_on_panic()) {
+		/* save data as much as possible */
+		psz_flush_dirty_zone(zone);
+		return 0;
+	}
+
+	if (unlikely(!info->read))
+		return -EINVAL;
+
+	len = sizeof(struct psz_buffer);
+	rcnt = info->read((char *)&tmpbuf, len, zone->off);
+	if (rcnt != len) {
+		pr_debug("read zone %s failed\n", zone->name);
+		return (int)rcnt < 0 ? (int)rcnt : -EIO;
+	}
+
+	if (tmpbuf.sig != zone->buffer->sig) {
+		pr_debug("no valid data in zone %s\n", zone->name);
+		return 0;
+	}
+
+	if (zone->buffer_size < atomic_read(&tmpbuf.datalen) ||
+		zone->buffer_size < atomic_read(&tmpbuf.start)) {
+		pr_info("found overtop zone: %s: off %lld, size %zu\n",
+				zone->name, zone->off, zone->buffer_size);
+		/* just keep going */
+		return 0;
+	}
+
+	if (!atomic_read(&tmpbuf.datalen)) {
+		pr_debug("found erased zone: %s: off %lld, size %zu, datalen %d\n",
+				zone->name, zone->off, zone->buffer_size,
+				atomic_read(&tmpbuf.datalen));
+		return 0;
+	}
+
+	pr_debug("found nice zone: %s: off %lld, size %zu, datalen %d\n",
+			zone->name, zone->off, zone->buffer_size,
+			atomic_read(&tmpbuf.datalen));
+
+	len = atomic_read(&tmpbuf.datalen) + sizeof(*oldbuf);
+	oldbuf = kzalloc(len, GFP_KERNEL);
+	if (!oldbuf)
+		return -ENOMEM;
+
+	memcpy(oldbuf, &tmpbuf, sizeof(*oldbuf));
+	buf = (char *)oldbuf + sizeof(*oldbuf);
+	len = atomic_read(&oldbuf->datalen);
+	start = atomic_read(&oldbuf->start);
+	off = zone->off + sizeof(*oldbuf);
+
+	/* get part of data */
+	rcnt = info->read(buf, len - start, off + start);
+	if (rcnt != len - start) {
+		pr_err("read zone %s failed\n", zone->name);
+		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
+		goto free_oldbuf;
+	}
+
+	/* get the rest of data */
+	rcnt = info->read(buf + len - start, start, off);
+	if (rcnt != start) {
+		pr_err("read zone %s failed\n", zone->name);
+		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
+		goto free_oldbuf;
+	}
+
+	zone->oldbuf = oldbuf;
+	psz_flush_dirty_zone(zone);
+	return 0;
+
+free_oldbuf:
+	kfree(oldbuf);
+	return ret;
+}
+
 /**
  * psz_recovery() - recover data from storage
  * @cxt: the context of pstore/zone
@@ -432,6 +542,10 @@ static inline int psz_recovery(struct psz_context *cxt)
 	if (ret)
 		goto recover_fail;
 
+	ret = psz_recover_zone(cxt, cxt->ppsz);
+	if (ret)
+		goto recover_fail;
+
 	pr_debug("recover end!\n");
 	atomic_set(&cxt->recovered, 1);
 	return 0;
@@ -446,9 +560,17 @@ static int psz_pstore_open(struct pstore_info *psi)
 	struct psz_context *cxt = psi->data;
 
 	cxt->oops_read_cnt = 0;
+	cxt->pmsg_read_cnt = 0;
 	return 0;
 }
 
+static inline bool psz_old_ok(struct psz_zone *zone)
+{
+	if (zone && zone->oldbuf && atomic_read(&zone->oldbuf->datalen))
+		return true;
+	return false;
+}
+
 static inline bool psz_ok(struct psz_zone *zone)
 {
 	if (zone && zone->buffer && buffer_datalen(zone))
@@ -473,6 +595,25 @@ static inline int psz_oops_erase(struct psz_context *cxt,
 	return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
 
+static inline int psz_record_erase(struct psz_context *cxt,
+		struct psz_zone *zone)
+{
+	if (unlikely(!psz_old_ok(zone)))
+		return 0;
+
+	kfree(zone->oldbuf);
+	zone->oldbuf = NULL;
+	/*
+	 * if there are new data in zone buffer, that means the old data
+	 * are already invalid. It is no need to flush 0 (erase) to
+	 * block device.
+	 */
+	if (!buffer_datalen(zone))
+		return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	psz_flush_dirty_zone(zone);
+	return 0;
+}
+
 static int psz_pstore_erase(struct pstore_record *record)
 {
 	struct psz_context *cxt = record->psi->data;
@@ -482,6 +623,8 @@ static int psz_pstore_erase(struct pstore_record *record)
 		if (record->id >= cxt->oops_max_cnt)
 			return -EINVAL;
 		return psz_oops_erase(cxt, cxt->opszs[record->id], record);
+	case PSTORE_TYPE_PMSG:
+		return psz_record_erase(cxt, cxt->ppsz);
 	default:
 		return -EINVAL;
 	}
@@ -502,8 +645,10 @@ static void psz_write_kmsg_hdr(struct psz_zone *zone,
 	hdr->reason = record->reason;
 	if (hdr->reason == KMSG_DUMP_OOPS)
 		hdr->counter = ++cxt->oops_counter;
-	else
+	else if (hdr->reason == KMSG_DUMP_PANIC)
 		hdr->counter = ++cxt->panic_counter;
+	else
+		hdr->counter = 0;
 }
 
 static inline int notrace psz_oops_write_record(struct psz_context *cxt,
@@ -567,6 +712,53 @@ static int notrace psz_oops_write(struct psz_context *cxt,
 	return 0;
 }
 
+static int notrace psz_record_write(struct psz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t start, rem;
+	int cnt = record->size;
+	bool is_full_data = false;
+	char *buf = record->buf;
+
+	if (!zone || !record)
+		return -ENOSPC;
+
+	if (atomic_read(&zone->buffer->datalen) >= zone->buffer_size)
+		is_full_data = true;
+
+	if (unlikely(cnt > zone->buffer_size)) {
+		buf += cnt - zone->buffer_size;
+		cnt = zone->buffer_size;
+	}
+
+	start = buffer_start(zone);
+	rem = zone->buffer_size - start;
+	if (unlikely(rem < cnt)) {
+		psz_zone_write(zone, FLUSH_PART, buf, rem, start);
+		buf += rem;
+		cnt -= rem;
+		start = 0;
+		is_full_data = true;
+	}
+
+	atomic_set(&zone->buffer->start, cnt + start);
+	psz_zone_write(zone, FLUSH_PART, buf, cnt, start);
+
+	/**
+	 * psz_zone_write will set datalen as start + cnt.
+	 * It work if actual data length lesser than buffer size.
+	 * If data length greater than buffer size, pmsg will rewrite to
+	 * beginning of zone, which make buffer->datalen wrongly.
+	 * So we should reset datalen as buffer size once actual data length
+	 * greater than buffer size.
+	 */
+	if (is_full_data) {
+		atomic_set(&zone->buffer->datalen, zone->buffer_size);
+		psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+	}
+	return 0;
+}
+
 static int notrace psz_pstore_write(struct pstore_record *record)
 {
 	struct psz_context *cxt = record->psi->data;
@@ -578,6 +770,8 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
 		return psz_oops_write(cxt, record);
+	case PSTORE_TYPE_PMSG:
+		return psz_record_write(cxt->ppsz, record);
 	default:
 		return -EINVAL;
 	}
@@ -593,6 +787,13 @@ static struct psz_zone *psz_read_next_zone(struct psz_context *cxt)
 			return zone;
 	}
 
+	if (cxt->pmsg_read_cnt == 0) {
+		cxt->pmsg_read_cnt++;
+		zone = cxt->ppsz;
+		if (psz_old_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -642,7 +843,7 @@ static ssize_t psz_oops_read(struct psz_zone *zone,
 			return -ENOMEM;
 	}
 
-	size = psz_zone_read(zone, record->buf + hlen, size,
+	size = psz_zone_read_buffer(zone, record->buf + hlen, size,
 			sizeof(struct psz_oops_header) < 0);
 	if (unlikely(size < 0)) {
 		kfree(record->buf);
@@ -652,6 +853,32 @@ static ssize_t psz_oops_read(struct psz_zone *zone,
 	return size + hlen;
 }
 
+static ssize_t psz_record_read(struct psz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t len;
+	struct psz_buffer *buf;
+
+	if (!zone || !record)
+		return -ENOSPC;
+
+	buf = (struct psz_buffer *)zone->oldbuf;
+	if (!buf)
+		return -ENOMSG;
+
+	len = atomic_read(&buf->datalen);
+	record->buf = kmalloc(len, GFP_KERNEL);
+	if (!record->buf)
+		return -ENOMEM;
+
+	if (unlikely(psz_zone_read_oldbuf(zone, record->buf, len, 0))) {
+		kfree(record->buf);
+		return -ENOMSG;
+	}
+
+	return len;
+}
+
 static ssize_t psz_pstore_read(struct pstore_record *record)
 {
 	struct psz_context *cxt = record->psi->data;
@@ -676,6 +903,9 @@ static ssize_t psz_pstore_read(struct pstore_record *record)
 		readop = psz_oops_read;
 		record->id = cxt->oops_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_PMSG:
+		readop = psz_record_read;
+		break;
 	default:
 		goto next_zone;
 	}
@@ -731,8 +961,10 @@ static struct psz_zone *psz_init_zone(enum pstore_type_id type,
 	zone->type = type;
 	zone->buffer_size = size - sizeof(struct psz_buffer);
 	zone->buffer->sig = type ^ PSZ_SIG;
+	zone->oldbuf = NULL;
 	atomic_set(&zone->dirty, 0);
 	atomic_set(&zone->buffer->datalen, 0);
+	atomic_set(&zone->buffer->start, 0);
 
 	*off += size;
 
@@ -816,6 +1048,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
 {
 	if (cxt->opszs)
 		psz_free_zones(&cxt->opszs, &cxt->oops_max_cnt);
+	if (cxt->ppsz)
+		psz_free_zone(&cxt->ppsz);
 }
 
 static int psz_alloc_zones(struct psz_context *cxt)
@@ -823,18 +1057,26 @@ static int psz_alloc_zones(struct psz_context *cxt)
 	struct psz_info *info = cxt->psz_info;
 	loff_t off = 0;
 	int err;
-	size_t size;
+	size_t off_size = 0;
+
+	off_size += info->pmsg_size;
+	cxt->ppsz = psz_init_zone(PSTORE_TYPE_PMSG, &off, info->pmsg_size);
+	if (IS_ERR(cxt->ppsz)) {
+		err = PTR_ERR(cxt->ppsz);
+		goto free_out;
+	}
 
-	size = info->total_size;
-	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off, size,
+	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
+			info->total_size - off_size,
 			info->oops_size, &cxt->oops_max_cnt);
 	if (IS_ERR(cxt->opszs)) {
 		err = PTR_ERR(cxt->opszs);
-		goto fail_out;
+		goto free_out;
 	}
 
 	return 0;
-fail_out:
+free_out:
+	psz_free_all_zones(cxt);
 	return err;
 }
 
@@ -858,7 +1100,7 @@ int psz_register(struct psz_info *info)
 		return -EINVAL;
 	}
 
-	if (!info->oops_size) {
+	if (!info->oops_size && !info->pmsg_size) {
 		pr_warn("at least one of the records be non-zero\n");
 		return -EINVAL;
 	}
@@ -885,6 +1127,7 @@ int psz_register(struct psz_info *info)
 
 	check_size(total_size, 4096);
 	check_size(oops_size, SECTOR_SIZE);
+	check_size(pmsg_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -916,6 +1159,7 @@ int psz_register(struct psz_info *info)
 	pr_debug("register %s with properties:\n", info->name);
 	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
 	pr_debug("\toops size : %ld Bytes\n", info->oops_size);
+	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
 
 	err = psz_alloc_zones(cxt);
 	if (err) {
@@ -934,11 +1178,14 @@ int psz_register(struct psz_info *info)
 	}
 	cxt->pstore.data = cxt;
 	if (info->oops_size)
-		cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
+	if (info->pmsg_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 
-	pr_info("Registered %s as pszone backend for%s%s\n", info->name,
+	pr_info("Registered %s as pszone backend for%s%s%s\n", info->name,
 			cxt->opszs && cxt->psz_info->dump_oops ? " Oops" : "",
-			cxt->opszs && cxt->psz_info->panic_write ? " Panic" : "");
+			cxt->opszs && cxt->psz_info->panic_write ? " Panic" : "",
+			cxt->ppsz ? " Pmsg" : "");
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index afc10a67a777..85e159d8f935 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -16,6 +16,7 @@
  *		than 4096 and be multiple of 4096.
  * @oops_size:	The size of oops/panic zone. Zero means disabled, otherwise,
  *		it must be multiple of SECTOR_SIZE(512 Bytes).
+ * @pmsg_size:	The size of pmsg zone which is the same as @oops_size.
  * @dump_oops:	Whether to dump oops log.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
@@ -32,6 +33,7 @@ struct psz_info {
 
 	unsigned long total_size;
 	unsigned long oops_size;
+	unsigned long pmsg_size;
 	int dump_oops;
 	psz_read_op read;
 	psz_write_op write;
-- 
1.9.1

