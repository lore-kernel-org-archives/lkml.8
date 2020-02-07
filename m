Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42AAC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F51921775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBGM0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:26:44 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56578 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgBGM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:26:14 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.47067-0.0361931-0.493137;DS=CONTINUE|ham_system_inform|0.198263-0.00022832-0.801509;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.GlaQplc_1581078351;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GlaQplc_1581078351)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 07 Feb 2020 20:25:58 +0800
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
Subject: [PATCH v2 01/11] pstore/blk: new support logger for block devices
Date:   Fri,  7 Feb 2020 20:25:45 +0800
Message-Id: <1581078355-19647-2-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore/blk is similar to pstore/ram, but dump log to block devices
rather than persistent ram.

Why do we need pstore/blk?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

pstore/blk is one of series patches, and provides the zones management
of partition of block device or non-block device likes mtd devices. It
only supports dmesg recorder right now.

To make pstore/blk work, the block/non-block driver should calls
blkz_register() and call blkz_unregister() when exits. On other patches
of series, a better wrapper for pstore/blk, named blkoops, will be
there.

It's different with pstore/ram, pstore/blk relies on read/write APIs
from device driver, especially, write operation for panic record.

Recommend that, the block/non-block driver should register to pstore/blk
only after devices have registered to Linux and ready to work.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig          |  10 +
 fs/pstore/Makefile         |   3 +
 fs/pstore/blkzone.c        | 948 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_blk.h |  62 +++
 4 files changed, 1023 insertions(+)
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/pstore_blk.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8f0369aad22a..536fde9e13e8 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -153,3 +153,13 @@ config PSTORE_RAM
 	  "ramoops.ko".
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
+
+config PSTORE_BLK
+	tristate "Log panic/oops to a block device"
+	depends on PSTORE
+	depends on BLOCK
+	help
+	  This enables panic and oops message to be logged to a block dev
+	  where it can be read back at some later point.
+
+	  If unsure, say N.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 967b5891f325..0ee2fc8d1bfb 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -12,3 +12,6 @@ pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
 
 ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
+
+obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
+pstore_blk-y += blkzone.o
diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
new file mode 100644
index 000000000000..f77f612b50ba
--- /dev/null
+++ b/fs/pstore/blkzone.c
@@ -0,0 +1,948 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define MODNAME "pstore-blk"
+#define pr_fmt(fmt) MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/pstore.h>
+#include <linux/mount.h>
+#include <linux/printk.h>
+#include <linux/fs.h>
+#include <linux/pstore_blk.h>
+#include <linux/kdev_t.h>
+#include <linux/device.h>
+#include <linux/namei.h>
+#include <linux/fcntl.h>
+#include <linux/uio.h>
+#include <linux/writeback.h>
+
+/**
+ * struct blkz_head - head of zone to flush to storage
+ *
+ * @sig: signature to indicate header (BLK_SIG xor BLKZONE-type value)
+ * @datalen: length of data in @data
+ * @data: zone data.
+ */
+struct blkz_buffer {
+#define BLK_SIG (0x43474244) /* DBGC */
+	uint32_t sig;
+	atomic_t datalen;
+	uint8_t data[];
+};
+
+/**
+ * struct blkz_dmesg_header: dmesg information
+ *
+ * @magic: magic num for dmesg header
+ * @time: trigger time
+ * @compressed: whether conpressed
+ * @count: oops/panic counter
+ * @reason: identify oops or panic
+ */
+struct blkz_dmesg_header {
+#define DMESG_HEADER_MAGIC 0x4dfc3ae5
+	uint32_t magic;
+	struct timespec64 time;
+	bool compressed;
+	uint32_t counter;
+	enum kmsg_dump_reason reason;
+	uint8_t data[0];
+};
+
+/**
+ * struct blkz_zone - zone information
+ * @off:
+ *	zone offset of block device
+ * @type:
+ *	frontent type for this zone
+ * @name:
+ *	frontent name for this zone
+ * @buffer:
+ *	pointer to data buffer managed by this zone
+ * @oldbuf:
+ *	pointer to old data buffer.
+ * @buffer_size:
+ *	bytes in @buffer->data
+ * @should_recover:
+ *	should recover from storage
+ * @dirty:
+ *	mark whether the data in @buffer are dirty (not flush to storage yet)
+ */
+struct blkz_zone {
+	unsigned long off;
+	const char *name;
+	enum pstore_type_id type;
+
+	struct blkz_buffer *buffer;
+	struct blkz_buffer *oldbuf;
+	size_t buffer_size;
+	bool should_recover;
+	atomic_t dirty;
+};
+
+struct blkz_context {
+	struct blkz_zone **dbzs;	/* dmesg block zones */
+	unsigned int dmesg_max_cnt;
+	unsigned int dmesg_read_cnt;
+	unsigned int dmesg_write_cnt;
+	/*
+	 * the counter should be recovered when recover.
+	 * It records the oops/panic times after burning rather than booting.
+	 */
+	unsigned int oops_counter;
+	unsigned int panic_counter;
+	atomic_t recovered;
+	atomic_t on_panic;
+
+	/*
+	 * bzinfo_lock just protects "bzinfo" during calls to
+	 * blkz_register/blkz_unregister
+	 */
+	spinlock_t bzinfo_lock;
+	struct blkz_info *bzinfo;
+	struct pstore_info pstore;
+};
+static struct blkz_context blkz_cxt;
+
+enum blkz_flush_mode {
+	FLUSH_NONE = 0,
+	FLUSH_PART,
+	FLUSH_META,
+	FLUSH_ALL,
+};
+
+static inline int buffer_datalen(struct blkz_zone *zone)
+{
+	return atomic_read(&zone->buffer->datalen);
+}
+
+static inline bool is_on_panic(void)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+
+	return atomic_read(&cxt->on_panic);
+}
+
+static int blkz_zone_read(struct blkz_zone *zone, char *buf,
+		size_t len, unsigned long off)
+{
+	if (!buf || !zone->buffer)
+		return -EINVAL;
+	if (off > zone->buffer_size)
+		return -EINVAL;
+	len = min_t(size_t, len, zone->buffer_size - off);
+	memcpy(buf, zone->buffer->data + off, len);
+	return 0;
+}
+
+static int blkz_zone_write(struct blkz_zone *zone,
+		enum blkz_flush_mode flush_mode, const char *buf,
+		size_t len, unsigned long off)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	ssize_t wcnt = 0;
+	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
+	size_t wlen;
+
+	if (off > zone->buffer_size)
+		return -EINVAL;
+	wlen = min_t(size_t, len, zone->buffer_size - off);
+	if (buf && wlen) {
+		memcpy(zone->buffer->data + off, buf, wlen);
+		atomic_set(&zone->buffer->datalen, wlen + off);
+	}
+
+	/* avoid to damage old records */
+	if (!is_on_panic() && !atomic_read(&blkz_cxt.recovered))
+		goto set_dirty;
+
+	writeop = is_on_panic() ? info->panic_write : info->write;
+	if (!writeop)
+		goto set_dirty;
+
+	switch (flush_mode) {
+	case FLUSH_NONE:
+		if (unlikely(buf && wlen))
+			goto set_dirty;
+		return 0;
+	case FLUSH_PART:
+		wcnt = writeop((const char *)zone->buffer->data + off, wlen,
+				zone->off + sizeof(*zone->buffer) + off);
+		if (wcnt != wlen)
+			goto set_dirty;
+		/* fallthrough */
+	case FLUSH_META:
+		wlen = sizeof(struct blkz_buffer);
+		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
+		if (wcnt != wlen)
+			goto set_dirty;
+		break;
+	case FLUSH_ALL:
+		wlen = zone->buffer_size + sizeof(*zone->buffer);
+		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
+		if (wcnt != wlen)
+			goto set_dirty;
+		break;
+	}
+
+	return 0;
+set_dirty:
+	atomic_set(&zone->dirty, true);
+	return -EBUSY;
+}
+
+static int blkz_flush_dirty_zone(struct blkz_zone *zone)
+{
+	int ret;
+
+	if (!zone)
+		return -EINVAL;
+
+	if (!atomic_read(&zone->dirty))
+		return 0;
+
+	if (!atomic_read(&blkz_cxt.recovered))
+		return -EBUSY;
+
+	ret = blkz_zone_write(zone, FLUSH_ALL, NULL, 0, 0);
+	if (!ret)
+		atomic_set(&zone->dirty, false);
+	return ret;
+}
+
+static int blkz_flush_dirty_zones(struct blkz_zone **zones, unsigned int cnt)
+{
+	int i, ret;
+	struct blkz_zone *zone;
+
+	if (!zones)
+		return -EINVAL;
+
+	for (i = 0; i < cnt; i++) {
+		zone = zones[i];
+		if (!zone)
+			return -EINVAL;
+		ret = blkz_flush_dirty_zone(zone);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * blkz_move_zone: move data from a old zone to a new zone
+ *
+ * @old: the old zone
+ * @new: the new zone
+ *
+ * NOTE:
+ *	Call blkz_zone_write to copy and flush data. If it failed, we
+ *	should reset new->dirty, because the new zone not really dirty.
+ */
+static int blkz_move_zone(struct blkz_zone *old, struct blkz_zone *new)
+{
+	const char *data = (const char *)old->buffer->data;
+	int ret;
+
+	ret = blkz_zone_write(new, FLUSH_ALL, data, buffer_datalen(old), 0);
+	if (ret) {
+		atomic_set(&new->buffer->datalen, 0);
+		atomic_set(&new->dirty, false);
+		return ret;
+	}
+	atomic_set(&old->buffer->datalen, 0);
+	return 0;
+}
+
+static int blkz_recover_dmesg_data(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_zone *zone = NULL;
+	struct blkz_buffer *buf;
+	unsigned long i;
+	ssize_t rcnt;
+
+	if (!info->read)
+		return -EINVAL;
+
+	for (i = 0; i < cxt->dmesg_max_cnt; i++) {
+		zone = cxt->dbzs[i];
+		if (unlikely(!zone))
+			return -EINVAL;
+		if (atomic_read(&zone->dirty)) {
+			unsigned int wcnt = cxt->dmesg_write_cnt;
+			struct blkz_zone *new = cxt->dbzs[wcnt];
+			int ret;
+
+			ret = blkz_move_zone(zone, new);
+			if (ret) {
+				pr_err("move zone from %lu to %d failed\n",
+						i, wcnt);
+				return ret;
+			}
+			cxt->dmesg_write_cnt = (wcnt + 1) % cxt->dmesg_max_cnt;
+		}
+		if (!zone->should_recover)
+			continue;
+		buf = zone->buffer;
+		rcnt = info->read((char *)buf, zone->buffer_size + sizeof(*buf),
+				zone->off);
+		if (rcnt != zone->buffer_size + sizeof(*buf))
+			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+	}
+	return 0;
+}
+
+/*
+ * blkz_recover_dmesg_meta: recover metadata of dmesg
+ *
+ * Recover metadata as follow:
+ * @cxt->dmesg_write_cnt
+ * @cxt->oops_counter
+ * @cxt->panic_counter
+ */
+static int blkz_recover_dmesg_meta(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	struct blkz_zone *zone;
+	size_t rcnt, len;
+	struct blkz_buffer *buf;
+	struct blkz_dmesg_header *hdr;
+	struct timespec64 time = {0};
+	unsigned long i;
+	/*
+	 * Recover may on panic, we can't allocate any memory by kmalloc.
+	 * So, we use local array instead.
+	 */
+	char buffer_header[sizeof(*buf) + sizeof(*hdr)] = {0};
+
+	if (!info->read)
+		return -EINVAL;
+
+	len = sizeof(*buf) + sizeof(*hdr);
+	buf = (struct blkz_buffer *)buffer_header;
+	for (i = 0; i < cxt->dmesg_max_cnt; i++) {
+		zone = cxt->dbzs[i];
+		if (unlikely(!zone))
+			return -EINVAL;
+
+		rcnt = info->read((char *)buf, len, zone->off);
+		if (rcnt != len) {
+			pr_err("read %s with id %lu failed\n", zone->name, i);
+			return (int)rcnt < 0 ? (int)rcnt : -EIO;
+		}
+
+		if (buf->sig != zone->buffer->sig) {
+			pr_debug("no valid data in dmesg zone %lu\n", i);
+			continue;
+		}
+
+		if (zone->buffer_size < atomic_read(&buf->datalen)) {
+			pr_info("found overtop zone: %s: id %lu, off %lu, size %zu\n",
+					zone->name, i, zone->off,
+					zone->buffer_size);
+			continue;
+		}
+
+		hdr = (struct blkz_dmesg_header *)buf->data;
+		if (hdr->magic != DMESG_HEADER_MAGIC) {
+			pr_info("found invalid zone: %s: id %lu, off %lu, size %zu\n",
+					zone->name, i, zone->off,
+					zone->buffer_size);
+			continue;
+		}
+
+		/*
+		 * we get the newest zone, and the next one must be the oldest
+		 * or unused zone, because we do write one by one like a circle.
+		 */
+		if (hdr->time.tv_sec >= time.tv_sec) {
+			time.tv_sec = hdr->time.tv_sec;
+			cxt->dmesg_write_cnt = (i + 1) % cxt->dmesg_max_cnt;
+		}
+
+		if (hdr->reason == KMSG_DUMP_OOPS)
+			cxt->oops_counter =
+				max(cxt->oops_counter, hdr->counter);
+		else
+			cxt->panic_counter =
+				max(cxt->panic_counter, hdr->counter);
+
+		if (!atomic_read(&buf->datalen)) {
+			pr_debug("found erased zone: %s: id %ld, off %lu, size %zu, datalen %d\n",
+					zone->name, i, zone->off,
+					zone->buffer_size,
+					atomic_read(&buf->datalen));
+			continue;
+		}
+
+		if (!is_on_panic())
+			zone->should_recover = true;
+		pr_debug("found nice zone: %s: id %ld, off %lu, size %zu, datalen %d\n",
+				zone->name, i, zone->off,
+				zone->buffer_size, atomic_read(&buf->datalen));
+	}
+
+	return 0;
+}
+
+static int blkz_recover_dmesg(struct blkz_context *cxt)
+{
+	int ret;
+
+	if (!cxt->dbzs)
+		return 0;
+
+	ret = blkz_recover_dmesg_meta(cxt);
+	if (ret)
+		goto recover_fail;
+
+	ret = blkz_recover_dmesg_data(cxt);
+	if (ret)
+		goto recover_fail;
+
+	return 0;
+recover_fail:
+	pr_debug("recover dmesg failed\n");
+	return ret;
+}
+
+static inline int blkz_recovery(struct blkz_context *cxt)
+{
+	int ret = -EBUSY;
+
+	if (atomic_read(&cxt->recovered))
+		return 0;
+
+	ret = blkz_recover_dmesg(cxt);
+	if (ret)
+		goto recover_fail;
+
+	pr_debug("recover end!\n");
+	atomic_set(&cxt->recovered, 1);
+	return 0;
+
+recover_fail:
+	pr_err("recover failed\n");
+	return ret;
+}
+
+static int blkz_pstore_open(struct pstore_info *psi)
+{
+	struct blkz_context *cxt = psi->data;
+
+	cxt->dmesg_read_cnt = 0;
+	return 0;
+}
+
+static inline bool blkz_ok(struct blkz_zone *zone)
+{
+	if (zone && zone->buffer && buffer_datalen(zone))
+		return true;
+	return false;
+}
+
+static inline int blkz_dmesg_erase(struct blkz_context *cxt,
+		struct blkz_zone *zone)
+{
+	if (unlikely(!blkz_ok(zone)))
+		return 0;
+
+	atomic_set(&zone->buffer->datalen, 0);
+	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+}
+
+static int blkz_pstore_erase(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		return blkz_dmesg_erase(cxt, cxt->dbzs[record->id]);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void blkz_write_kmsg_hdr(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+	struct blkz_buffer *buffer = zone->buffer;
+	struct blkz_dmesg_header *hdr =
+		(struct blkz_dmesg_header *)buffer->data;
+
+	hdr->magic = DMESG_HEADER_MAGIC;
+	hdr->compressed = record->compressed;
+	hdr->time.tv_sec = record->time.tv_sec;
+	hdr->time.tv_nsec = record->time.tv_nsec;
+	hdr->reason = record->reason;
+	if (hdr->reason == KMSG_DUMP_OOPS)
+		hdr->counter = ++cxt->oops_counter;
+	else
+		hdr->counter = ++cxt->panic_counter;
+}
+
+static inline int notrace blkz_dmesg_write_do(struct blkz_context *cxt,
+		struct pstore_record *record)
+{
+	size_t size, hlen;
+	struct blkz_zone *zone;
+	unsigned int zonenum;
+
+	zonenum = cxt->dmesg_write_cnt;
+	zone = cxt->dbzs[zonenum];
+	if (unlikely(!zone))
+		return -ENOSPC;
+	cxt->dmesg_write_cnt = (zonenum + 1) % cxt->dmesg_max_cnt;
+
+	pr_debug("write %s to zone id %d\n", zone->name, zonenum);
+	blkz_write_kmsg_hdr(zone, record);
+	hlen = sizeof(struct blkz_dmesg_header);
+	size = min_t(size_t, record->size, zone->buffer_size - hlen);
+	return blkz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
+}
+
+static int notrace blkz_dmesg_write(struct blkz_context *cxt,
+		struct pstore_record *record)
+{
+	int ret;
+	struct blkz_info *info = cxt->bzinfo;
+
+	/*
+	 * Out of the various dmesg dump types, pstore/blk is currently designed
+	 * to only store crash logs, rather than storing general kernel logs.
+	 */
+	if (record->reason != KMSG_DUMP_OOPS &&
+			record->reason != KMSG_DUMP_PANIC)
+		return -EINVAL;
+
+	/* Skip Oopes when configured to do so. */
+	if (record->reason == KMSG_DUMP_OOPS && !info->dump_oops)
+		return -EINVAL;
+
+	/*
+	 * Explicitly only take the first part of any new crash.
+	 * If our buffer is larger than kmsg_bytes, this can never happen,
+	 * and if our buffer is smaller than kmsg_bytes, we don't want the
+	 * report split across multiple records.
+	 */
+	if (record->part != 1)
+		return -ENOSPC;
+
+	if (!cxt->dbzs)
+		return -ENOSPC;
+
+	ret = blkz_dmesg_write_do(cxt, record);
+	if (!ret) {
+		pr_debug("try to flush other dirty dmesg zones\n");
+		blkz_flush_dirty_zones(cxt->dbzs, cxt->dmesg_max_cnt);
+	}
+
+	/* alway return 0 as we had handled it on buffer */
+	return 0;
+}
+
+static int notrace blkz_pstore_write(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+
+	if (record->type == PSTORE_TYPE_DMESG &&
+			record->reason == KMSG_DUMP_PANIC)
+		atomic_set(&cxt->on_panic, 1);
+
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		return blkz_dmesg_write(cxt, record);
+	default:
+		return -EINVAL;
+	}
+}
+
+#define READ_NEXT_ZONE ((ssize_t)(-1024))
+static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
+{
+	struct blkz_zone *zone = NULL;
+
+	while (cxt->dmesg_read_cnt < cxt->dmesg_max_cnt) {
+		zone = cxt->dbzs[cxt->dmesg_read_cnt++];
+		if (blkz_ok(zone))
+			return zone;
+	}
+
+	return NULL;
+}
+
+static int blkz_read_dmesg_hdr(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	struct blkz_buffer *buffer = zone->buffer;
+	struct blkz_dmesg_header *hdr =
+		(struct blkz_dmesg_header *)buffer->data;
+
+	if (hdr->magic != DMESG_HEADER_MAGIC)
+		return -EINVAL;
+	record->compressed = hdr->compressed;
+	record->time.tv_sec = hdr->time.tv_sec;
+	record->time.tv_nsec = hdr->time.tv_nsec;
+	record->reason = hdr->reason;
+	record->count = hdr->counter;
+	return 0;
+}
+
+static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
+		struct pstore_record *record)
+{
+	size_t size, hlen = 0;
+
+	size = buffer_datalen(zone);
+	/* Clear and skip this DMESG record if it has no valid header */
+	if (blkz_read_dmesg_hdr(zone, record)) {
+		atomic_set(&zone->buffer->datalen, 0);
+		atomic_set(&zone->dirty, 0);
+		return READ_NEXT_ZONE;
+	}
+	size -= sizeof(struct blkz_dmesg_header);
+
+	if (!record->compressed) {
+		char *buf = kasprintf(GFP_KERNEL,
+				"%s: Total %d times\n",
+				record->reason == KMSG_DUMP_OOPS ? "Oops" :
+				"Panic", record->count);
+		hlen = strlen(buf);
+		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
+		if (!record->buf) {
+			kfree(buf);
+			return -ENOMEM;
+		}
+	} else {
+		record->buf = kmalloc(size, GFP_KERNEL);
+		if (!record->buf)
+			return -ENOMEM;
+	}
+
+	if (unlikely(blkz_zone_read(zone, record->buf + hlen, size,
+				sizeof(struct blkz_dmesg_header)) < 0)) {
+		kfree(record->buf);
+		return READ_NEXT_ZONE;
+	}
+
+	return size + hlen;
+}
+
+static ssize_t blkz_pstore_read(struct pstore_record *record)
+{
+	struct blkz_context *cxt = record->psi->data;
+	ssize_t (*blkz_read)(struct blkz_zone *zone,
+			struct pstore_record *record);
+	struct blkz_zone *zone;
+	ssize_t ret;
+
+	/* before read, we must recover from storage */
+	ret = blkz_recovery(cxt);
+	if (ret)
+		return ret;
+
+next_zone:
+	zone = blkz_read_next_zone(cxt);
+	if (!zone)
+		return 0;
+
+	record->type = zone->type;
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		blkz_read = blkz_dmesg_read;
+		record->id = cxt->dmesg_read_cnt - 1;
+		break;
+	default:
+		goto next_zone;
+	}
+
+	ret = blkz_read(zone, record);
+	if (ret == READ_NEXT_ZONE)
+		goto next_zone;
+	return ret;
+}
+
+static struct blkz_context blkz_cxt = {
+	.bzinfo_lock = __SPIN_LOCK_UNLOCKED(blkz_cxt.bzinfo_lock),
+	.recovered = ATOMIC_INIT(0),
+	.on_panic = ATOMIC_INIT(0),
+	.pstore = {
+		.owner = THIS_MODULE,
+		.name = MODNAME,
+		.open = blkz_pstore_open,
+		.read = blkz_pstore_read,
+		.write = blkz_pstore_write,
+		.erase = blkz_pstore_erase,
+	},
+};
+
+static struct blkz_zone *blkz_init_zone(enum pstore_type_id type,
+		unsigned long *off, size_t size)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	struct blkz_zone *zone;
+	const char *name = pstore_type_to_name(type);
+
+	if (!size)
+		return NULL;
+
+	if (*off + size > info->total_size) {
+		pr_err("no room for %s (0x%zx@0x%lx over 0x%lx)\n",
+			name, size, *off, info->total_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	zone = kzalloc(sizeof(struct blkz_zone), GFP_KERNEL);
+	if (!zone)
+		return ERR_PTR(-ENOMEM);
+
+	zone->buffer = kmalloc(size, GFP_KERNEL);
+	if (!zone->buffer) {
+		kfree(zone);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(zone->buffer, 0xFF, size);
+	zone->off = *off;
+	zone->name = name;
+	zone->type = type;
+	zone->buffer_size = size - sizeof(struct blkz_buffer);
+	zone->buffer->sig = type ^ BLK_SIG;
+	atomic_set(&zone->dirty, 0);
+	atomic_set(&zone->buffer->datalen, 0);
+
+	*off += size;
+
+	pr_debug("blkzone %s: off 0x%lx, %zu header, %zu data\n", zone->name,
+			zone->off, sizeof(*zone->buffer), zone->buffer_size);
+	return zone;
+}
+
+static struct blkz_zone **blkz_init_zones(enum pstore_type_id type,
+	unsigned long *off, size_t total_size, ssize_t record_size,
+	unsigned int *cnt)
+{
+	struct blkz_info *info = blkz_cxt.bzinfo;
+	struct blkz_zone **zones, *zone;
+	const char *name = pstore_type_to_name(type);
+	int c, i;
+
+	if (!total_size || !record_size)
+		return NULL;
+
+	if (*off + total_size > info->total_size) {
+		pr_err("no room for zones %s (0x%zx@0x%lx over 0x%lx)\n",
+			name, total_size, *off, info->total_size);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	c = total_size / record_size;
+	zones = kcalloc(c, sizeof(*zones), GFP_KERNEL);
+	if (!zones) {
+		pr_err("allocate for zones %s failed\n", name);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(zones, 0, c * sizeof(*zones));
+
+	for (i = 0; i < c; i++) {
+		zone = blkz_init_zone(type, off, record_size);
+		if (!zone || IS_ERR(zone)) {
+			pr_err("initialize zones %s failed\n", name);
+			while (--i >= 0) {
+				kfree(zones[i]->buffer);
+				kfree(zones[i]);
+			}
+			kfree(zones);
+			return (void *)zone;
+		}
+		zones[i] = zone;
+	}
+
+	*cnt = c;
+	return zones;
+}
+
+static void blkz_free_zone(struct blkz_zone **blkzone)
+{
+	struct blkz_zone *zone = *blkzone;
+
+	if (!zone)
+		return;
+
+	kfree(zone->buffer);
+	kfree(zone);
+	*blkzone = NULL;
+}
+
+static void blkz_free_zones(struct blkz_zone ***blkzones, unsigned int *cnt)
+{
+	struct blkz_zone **zones = *blkzones;
+
+	if (!zones)
+		return;
+
+	while (*cnt > 0) {
+		blkz_free_zone(&zones[*cnt]);
+		(*cnt)--;
+	}
+	kfree(zones);
+	*blkzones = NULL;
+}
+
+static int blkz_cut_zones(struct blkz_context *cxt)
+{
+	struct blkz_info *info = cxt->bzinfo;
+	unsigned long off = 0;
+	int err;
+	size_t size;
+
+	size = info->total_size;
+	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off, size,
+			info->dmesg_size, &cxt->dmesg_max_cnt);
+	if (IS_ERR(cxt->dbzs)) {
+		err = PTR_ERR(cxt->dbzs);
+		goto fail_out;
+	}
+
+	return 0;
+fail_out:
+	return err;
+}
+
+int blkz_register(struct blkz_info *info)
+{
+	int err = -EINVAL;
+	struct blkz_context *cxt = &blkz_cxt;
+	struct module *owner = info->owner;
+
+	if (!info->total_size) {
+		pr_warn("the total size must be non-zero\n");
+		return -EINVAL;
+	}
+
+	if (!info->dmesg_size) {
+		pr_warn("at least one of the records be non-zero\n");
+		return -EINVAL;
+	}
+
+	if (!info->name || !info->name[0])
+		return -EINVAL;
+
+	if (info->total_size < 4096) {
+		pr_err("total size must be greater than 4096 bytes\n");
+		return -EINVAL;
+	}
+
+#define check_size(name, size) {					\
+		if (info->name > 0 && info->name < (size)) {		\
+			pr_err(#name " must be over %d\n", (size));	\
+			return -EINVAL;					\
+		}							\
+		if (info->name & (size - 1)) {				\
+			pr_err(#name " must be a multiple of %d\n",	\
+					(size));			\
+			return -EINVAL;					\
+		}							\
+	}
+
+	check_size(total_size, 4096);
+	check_size(dmesg_size, SECTOR_SIZE);
+
+#undef check_size
+
+	/*
+	 * the @read and @write must be applied.
+	 * if no @read, pstore may mount failed.
+	 * if no @write, pstore do not support to remove record file.
+	 */
+	if (!info->read || !info->write) {
+		pr_err("no valid general read/write interface\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&cxt->bzinfo_lock);
+	if (cxt->bzinfo) {
+		pr_warn("blk '%s' already loaded: ignoring '%s'\n",
+				cxt->bzinfo->name, info->name);
+		spin_unlock(&cxt->bzinfo_lock);
+		return -EBUSY;
+	}
+	cxt->bzinfo = info;
+	spin_unlock(&cxt->bzinfo_lock);
+
+	if (owner && !try_module_get(owner)) {
+		err = -EBUSY;
+		goto fail_out;
+	}
+
+	pr_debug("register %s with properties:\n", info->name);
+	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
+	pr_debug("\tdmesg size : %ld Bytes\n", info->dmesg_size);
+
+	err = blkz_cut_zones(cxt);
+	if (err) {
+		pr_err("cut zones fialed\n");
+		goto put_module;
+	}
+
+	if (info->dmesg_size) {
+		cxt->pstore.bufsize = cxt->dbzs[0]->buffer_size -
+			sizeof(struct blkz_dmesg_header);
+		cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
+		if (!cxt->pstore.buf) {
+			err = -ENOMEM;
+			goto put_module;
+		}
+	}
+	cxt->pstore.data = cxt;
+	if (info->dmesg_size)
+		cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+
+	pr_info("Registered %s as blkzone backend for %s%s\n", info->name,
+			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
+			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "");
+
+	err = pstore_register(&cxt->pstore);
+	if (err) {
+		pr_err("registering with pstore failed\n");
+		goto free_pstore_buf;
+	}
+
+	module_put(owner);
+	return 0;
+
+free_pstore_buf:
+	kfree(cxt->pstore.buf);
+put_module:
+	module_put(owner);
+fail_out:
+	spin_lock(&blkz_cxt.bzinfo_lock);
+	blkz_cxt.bzinfo = NULL;
+	spin_unlock(&blkz_cxt.bzinfo_lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(blkz_register);
+
+void blkz_unregister(struct blkz_info *info)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+
+	pstore_unregister(&cxt->pstore);
+	kfree(cxt->pstore.buf);
+	cxt->pstore.bufsize = 0;
+
+	spin_lock(&cxt->bzinfo_lock);
+	blkz_cxt.bzinfo = NULL;
+	spin_unlock(&cxt->bzinfo_lock);
+
+	blkz_free_zones(&cxt->dbzs, &cxt->dmesg_max_cnt);
+}
+EXPORT_SYMBOL_GPL(blkz_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Block device Oops/Panic logger");
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
new file mode 100644
index 000000000000..589d276fa4e4
--- /dev/null
+++ b/include/linux/pstore_blk.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSTORE_BLK_H_
+#define __PSTORE_BLK_H_
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+
+/**
+ * struct blkz_info - backend blkzone driver structure
+ *
+ * @owner:
+ *	Module which is responsible for this backend driver.
+ * @name:
+ *	Name of the backend driver.
+ * @total_size:
+ *	The total size in bytes pstore/blk can use. It must be greater than
+ *	4096 and be multiple of 4096.
+ * @dmesg_size:
+ *	The size of each zones for dmesg (oops & panic). Zero means disabled,
+ *	otherwise, it must be multiple of SECTOR_SIZE(512 Bytes).
+ * @dump_oops:
+ *	Dump oops and panic log or only panic.
+ * @read, @write:
+ *	The general (not panic) read/write operation. It's required unless you
+ *	are block device and supply valid @bdev. In this case, blkzone will
+ *	replace it as a general read/write interface.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, the number of bytes read/write should be returned.
+ *	On error, negative number should be returned.
+ * @panic_write:
+ *	The write operation only used for panic. It's optional if you do not
+ *	care panic record. If panic occur but blkzone do not recover yet, the
+ *	first zone of dmesg is used.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, the number of bytes write should be returned.
+ *	On error, negative number should be returned.
+ */
+typedef ssize_t (*blkz_read_op)(char *, size_t, loff_t);
+typedef ssize_t (*blkz_write_op)(const char *, size_t, loff_t);
+struct blkz_info {
+	struct module *owner;
+	const char *name;
+
+	unsigned long total_size;
+	unsigned long dmesg_size;
+	int dump_oops;
+	blkz_read_op read;
+	blkz_write_op write;
+	blkz_write_op panic_write;
+};
+
+extern int blkz_register(struct blkz_info *info);
+extern void blkz_unregister(struct blkz_info *info);
+
+#endif
-- 
1.9.1

