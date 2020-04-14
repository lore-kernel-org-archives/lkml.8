Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB6C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA7A2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbgDNBm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:42:29 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:46240 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728252AbgDNBm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:42:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.642287-0.000725711-0.356987;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07381;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.HGC3QTX_1586828539;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HGC3QTX_1586828539)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 14 Apr 2020 09:42:20 +0800
Subject: Re: [PATCH v3 01/11] pstore/zone: a common layer to manage storage as
 zones
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
        linux-mtd@lists.infradead.org
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1585126506-18635-2-git-send-email-liaoweixiong@allwinnertech.com>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <de10bc53-7e74-eda8-2072-f1abc2c84b59@allwinnertech.com>
Date:   Tue, 14 Apr 2020 09:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1585126506-18635-2-git-send-email-liaoweixiong@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

It's nearly three weeks since these patches submitted. Is there anything
to change?

On 2020/3/25 PM 4:54, WeiXiong Liao wrote:
> This is a pre patch to support pstore/blk.
> 
> Pstore/zone provides the zones management of storage. It's designed
> to work for pstore/blk and pstore/ram in the future.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> ---
>  fs/pstore/Kconfig           |   7 +
>  fs/pstore/Makefile          |   2 +
>  fs/pstore/platform.c        |   3 +-
>  fs/pstore/pstore_zone.c     | 989 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pstore.h      |   1 +
>  include/linux/pstore_zone.h |  44 ++
>  6 files changed, 1045 insertions(+), 1 deletion(-)
>  create mode 100644 fs/pstore/pstore_zone.c
>  create mode 100644 include/linux/pstore_zone.h
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 8f0369aad22a..5ad4ab68ac4f 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -153,3 +153,10 @@ config PSTORE_RAM
>  	  "ramoops.ko".
>  
>  	  For more information, see Documentation/admin-guide/ramoops.rst.
> +
> +config PSTORE_ZONE
> +	tristate
> +	depends on PSTORE
> +	help
> +	  The common layer for pstore/blk (and pstore/ram in the future)
> +	  to manager storage as zones.
> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
> index 967b5891f325..94f3631c80ce 100644
> --- a/fs/pstore/Makefile
> +++ b/fs/pstore/Makefile
> @@ -12,3 +12,5 @@ pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
>  
>  ramoops-objs += ram.o ram_core.o
>  obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
> +
> +obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index d896457e7c11..80b4728c702f 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -129,7 +129,7 @@ enum pstore_type_id pstore_name_to_type(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(pstore_name_to_type);
>  
> -static const char *get_reason_str(enum kmsg_dump_reason reason)
> +const char *get_reason_str(enum kmsg_dump_reason reason)
>  {
>  	switch (reason) {
>  	case KMSG_DUMP_PANIC:
> @@ -148,6 +148,7 @@ static const char *get_reason_str(enum kmsg_dump_reason reason)
>  		return "Unknown";
>  	}
>  }
> +EXPORT_SYMBOL_GPL(get_reason_str);
>  
>  /*
>   * Should pstore_dump() wait for a concurrent pstore_dump()? If
> diff --git a/fs/pstore/pstore_zone.c b/fs/pstore/pstore_zone.c
> new file mode 100644
> index 000000000000..62c834072498
> --- /dev/null
> +++ b/fs/pstore/pstore_zone.c
> @@ -0,0 +1,989 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define MODNAME "pstore-zone"
> +#define pr_fmt(fmt) MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/pstore.h>
> +#include <linux/mount.h>
> +#include <linux/printk.h>
> +#include <linux/fs.h>
> +#include <linux/pstore_zone.h>
> +#include <linux/kdev_t.h>
> +#include <linux/device.h>
> +#include <linux/namei.h>
> +#include <linux/fcntl.h>
> +#include <linux/uio.h>
> +#include <linux/writeback.h>
> +
> +/**
> + * struct psz_head - header of zone to flush to storage
> + *
> + * @sig: signature to indicate header (PSZ_SIG xor PSZONE-type value)
> + * @datalen: length of data in @data
> + * @data: zone data.
> + */
> +struct psz_buffer {
> +#define PSZ_SIG (0x43474244) /* DBGC */
> +	uint32_t sig;
> +	atomic_t datalen;
> +	uint8_t data[];
> +};
> +
> +/**
> + * struct psz_oops_header - sub header of oops zones to flush to storage
> + *
> + * @magic: magic num for oops header
> + * @time: oops/panic trigger time
> + * @compressed: whether conpressed
> + * @counter: oops/panic counter
> + * @reason: identify oops or panic
> + * @data: pointer to log data
> + *
> + * It's a sub-header of oops zone, trailing after &psz_buffer.
> + */
> +struct psz_oops_header {
> +#define OOPS_HEADER_MAGIC 0x4dfc3ae5 /* Just a ramdom number */
> +	uint32_t magic;
> +	struct timespec64 time;
> +	bool compressed;
> +	uint32_t counter;
> +	enum kmsg_dump_reason reason;
> +	uint8_t data[];
> +};
> +
> +/**
> + * struct psz_zone - zone information
> + *
> + * @off: zone offset of storage
> + * @type: front-end type for this zone
> + * @name: front-end name for this zone
> + * @buffer: pointer to data buffer managed by this zone
> + * @oldbuf: pointer to old data buffer.
> + * @buffer_size: bytes in @buffer->data
> + * @should_recover: whether this zone should recover from storage
> + * @dirty: whether the data in @buffer dirty
> + *
> + * zone structure in memory.
> + */
> +struct psz_zone {
> +	loff_t off;
> +	const char *name;
> +	enum pstore_type_id type;
> +
> +	struct psz_buffer *buffer;
> +	struct psz_buffer *oldbuf;
> +	size_t buffer_size;
> +	bool should_recover;
> +	atomic_t dirty;
> +};
> +
> +/**
> + * struct psz_context - all about running state of pstore/zone
> + *
> + * @opszs: oops/panic storage zones
> + * @oops_max_cnt: max count of @opszs
> + * @oops_read_cnt: counter to read oops zone
> + * @oops_write_cnt: counter to write
> + * @oops_counter: counter to oops
> + * @panic_counter: counter to panic
> + * @recovered: whether finish recovering data from storage
> + * @on_panic: whether occur panic
> + * @psz_info_lock: lock to @psz_info
> + * @psz_info: information from back-end
> + * @pstore: structure for pstore
> + */
> +struct psz_context {
> +	struct psz_zone **opszs;
> +	unsigned int oops_max_cnt;
> +	unsigned int oops_read_cnt;
> +	unsigned int oops_write_cnt;
> +	/*
> +	 * the counter should be recovered when recover.
> +	 * It records the oops/panic times after burning rather than booting.
> +	 */
> +	unsigned int oops_counter;
> +	unsigned int panic_counter;
> +	atomic_t recovered;
> +	atomic_t on_panic;
> +
> +	/*
> +	 * psz_info_lock just protects "psz_info" during calls to
> +	 * psz_register/psz_unregister
> +	 */
> +	spinlock_t psz_info_lock;
> +	struct psz_info *psz_info;
> +	struct pstore_info pstore;
> +};
> +static struct psz_context psz_cxt;
> +
> +/**
> + * enum psz_flush_mode - flush mode for psz_zone_write()
> + *
> + * @FLUSH_NONE: do not flush to storage but update data on memory
> + * @FLUSH_PART: just flush part of data including meta data to storage
> + * @FLUSH_META: just flush meta data of zone to storage
> + * @FLUSH_ALL: flush all of zone
> + */
> +enum psz_flush_mode {
> +	FLUSH_NONE = 0,
> +	FLUSH_PART,
> +	FLUSH_META,
> +	FLUSH_ALL,
> +};
> +
> +static inline int buffer_datalen(struct psz_zone *zone)
> +{
> +	return atomic_read(&zone->buffer->datalen);
> +}
> +
> +static inline bool is_on_panic(void)
> +{
> +	struct psz_context *cxt = &psz_cxt;
> +
> +	return atomic_read(&cxt->on_panic);
> +}
> +
> +static ssize_t psz_zone_read(struct psz_zone *zone, char *buf,
> +		size_t len, unsigned long off)
> +{
> +	if (!buf || !zone->buffer)
> +		return -EINVAL;
> +	if (off > zone->buffer_size)
> +		return -EINVAL;
> +	len = min_t(size_t, len, zone->buffer_size - off);
> +	memcpy(buf, zone->buffer->data + off, len);
> +	return len;
> +}
> +
> +static int psz_zone_write(struct psz_zone *zone,
> +		enum psz_flush_mode flush_mode, const char *buf,
> +		size_t len, unsigned long off)
> +{
> +	struct psz_info *info = psz_cxt.psz_info;
> +	ssize_t wcnt = 0;
> +	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
> +	size_t wlen;
> +
> +	if (off > zone->buffer_size)
> +		return -EINVAL;
> +
> +	wlen = min_t(size_t, len, zone->buffer_size - off);
> +	if (buf && wlen) {
> +		memcpy(zone->buffer->data + off, buf, wlen);
> +		atomic_set(&zone->buffer->datalen, wlen + off);
> +	}
> +
> +	/* avoid to damage old records */
> +	if (!is_on_panic() && !atomic_read(&psz_cxt.recovered))
> +		goto dirty;
> +
> +	writeop = is_on_panic() ? info->panic_write : info->write;
> +	if (!writeop)
> +		goto dirty;
> +
> +	switch (flush_mode) {
> +	case FLUSH_NONE:
> +		if (unlikely(buf && wlen))
> +			goto dirty;
> +		return 0;
> +	case FLUSH_PART:
> +		wcnt = writeop((const char *)zone->buffer->data + off, wlen,
> +				zone->off + sizeof(*zone->buffer) + off);
> +		if (wcnt != wlen)
> +			goto dirty;
> +		fallthrough;
> +	case FLUSH_META:
> +		wlen = sizeof(struct psz_buffer);
> +		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
> +		if (wcnt != wlen)
> +			goto dirty;
> +		break;
> +	case FLUSH_ALL:
> +		wlen = zone->buffer_size + sizeof(*zone->buffer);
> +		wcnt = writeop((const char *)zone->buffer, wlen, zone->off);
> +		if (wcnt != wlen)
> +			goto dirty;
> +		break;
> +	}
> +
> +	return 0;
> +dirty:
> +	atomic_set(&zone->dirty, true);
> +	return -EBUSY;
> +}
> +
> +static int psz_flush_dirty_zone(struct psz_zone *zone)
> +{
> +	int ret;
> +
> +	if (!zone)
> +		return -EINVAL;
> +
> +	if (!atomic_read(&zone->dirty))
> +		return 0;
> +
> +	if (!atomic_read(&psz_cxt.recovered))
> +		return -EBUSY;
> +
> +	ret = psz_zone_write(zone, FLUSH_ALL, NULL, 0, 0);
> +	if (!ret)
> +		atomic_set(&zone->dirty, false);
> +	return ret;
> +}

To avoid multi writers call flush_dirty_zone(), I modified codes by
using atomic_xchg()

	static int psz_flush_dirty_zone(struct psz_zone *zone)

	{

	        int ret;

	

	        if (unlikely(!zone))

	                return -EINVAL;

	

	        if (unlikely(!atomic_read(&psz_cxt.recovered)))

	                return -EBUSY;

	

	       if (!atomic_xchg(&zone->dirty, false))

	                return 0;

	

	        ret = psz_zone_write(zone, FLUSH_ALL, NULL, 0, 0);

	        if (ret)

	                atomic_set(&zone->dirty, true);

	        return ret;

	}

> +
> +static int psz_flush_dirty_zones(struct psz_zone **zones, unsigned int cnt)
> +{
> +	int i, ret;
> +	struct psz_zone *zone;
> +
> +	if (!zones)
> +		return -EINVAL;
> +
> +	for (i = 0; i < cnt; i++) {
> +		zone = zones[i];
> +		if (!zone)
> +			return -EINVAL;
> +		ret = psz_flush_dirty_zone(zone);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int psz_move_zone(struct psz_zone *old, struct psz_zone *new)
> +{
> +	const char *data = (const char *)old->buffer->data;
> +	int ret;
> +
> +	ret = psz_zone_write(new, FLUSH_ALL, data, buffer_datalen(old), 0);
> +	if (ret) {
> +		atomic_set(&new->buffer->datalen, 0);
> +		atomic_set(&new->dirty, false);
> +		return ret;
> +	}
> +	atomic_set(&old->buffer->datalen, 0);
> +	return 0;
> +}
> +
> +static int psz_recover_oops_data(struct psz_context *cxt)
> +{
> +	struct psz_info *info = cxt->psz_info;
> +	struct psz_zone *zone = NULL;
> +	struct psz_buffer *buf;
> +	unsigned long i;
> +	ssize_t rcnt;
> +
> +	if (!info->read)
> +		return -EINVAL;
> +
> +	for (i = 0; i < cxt->oops_max_cnt; i++) {
> +		zone = cxt->opszs[i];
> +		if (unlikely(!zone))
> +			return -EINVAL;
> +		if (atomic_read(&zone->dirty)) {
> +			unsigned int wcnt = cxt->oops_write_cnt;
> +			struct psz_zone *new = cxt->opszs[wcnt];
> +			int ret;
> +
> +			ret = psz_move_zone(zone, new);
> +			if (ret) {
> +				pr_err("move zone from %lu to %d failed\n",
> +						i, wcnt);
> +				return ret;
> +			}
> +			cxt->oops_write_cnt = (wcnt + 1) % cxt->oops_max_cnt;
> +		}
> +		if (!zone->should_recover)
> +			continue;
> +		buf = zone->buffer;
> +		rcnt = info->read((char *)buf, zone->buffer_size + sizeof(*buf),
> +				zone->off);
> +		if (rcnt != zone->buffer_size + sizeof(*buf))
> +			return (int)rcnt < 0 ? (int)rcnt : -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int psz_recover_oops_meta(struct psz_context *cxt)
> +{
> +	struct psz_info *info = cxt->psz_info;
> +	struct psz_zone *zone;
> +	size_t rcnt, len;
> +	struct psz_buffer *buf;
> +	struct psz_oops_header *hdr;
> +	struct timespec64 time = {0};
> +	unsigned long i;
> +	/*
> +	 * Recover may on panic, we can't allocate any memory by kmalloc.
> +	 * So, we use local array instead.
> +	 */
> +	char buffer_header[sizeof(*buf) + sizeof(*hdr)] = {0};
> +
> +	if (!info->read)
> +		return -EINVAL;
> +
> +	len = sizeof(*buf) + sizeof(*hdr);
> +	buf = (struct psz_buffer *)buffer_header;
> +	for (i = 0; i < cxt->oops_max_cnt; i++) {
> +		zone = cxt->opszs[i];
> +		if (unlikely(!zone))
> +			return -EINVAL;
> +
> +		rcnt = info->read((char *)buf, len, zone->off);
> +		if (rcnt != len) {
> +			pr_err("read %s with id %lu failed\n", zone->name, i);
> +			return (int)rcnt < 0 ? (int)rcnt : -EIO;
> +		}
> +
> +		if (buf->sig != zone->buffer->sig) {
> +			pr_debug("no valid data in oops zone %lu\n", i);
> +			continue;
> +		}
> +
> +		if (zone->buffer_size < atomic_read(&buf->datalen)) {
> +			pr_info("found overtop zone: %s: id %lu, off %lld, size %zu\n",
> +					zone->name, i, zone->off,
> +					zone->buffer_size);
> +			continue;
> +		}
> +
> +		hdr = (struct psz_oops_header *)buf->data;
> +		if (hdr->magic != OOPS_HEADER_MAGIC) {
> +			pr_info("found invalid zone: %s: id %lu, off %lld, size %zu\n",
> +					zone->name, i, zone->off,
> +					zone->buffer_size);
> +			continue;
> +		}
> +
> +		/*
> +		 * we get the newest zone, and the next one must be the oldest
> +		 * or unused zone, because we do write one by one like a circle.
> +		 */
> +		if (hdr->time.tv_sec >= time.tv_sec) {
> +			time.tv_sec = hdr->time.tv_sec;
> +			cxt->oops_write_cnt = (i + 1) % cxt->oops_max_cnt;
> +		}
> +
> +		if (hdr->reason == KMSG_DUMP_OOPS)
> +			cxt->oops_counter =
> +				max(cxt->oops_counter, hdr->counter);
> +		else
> +			cxt->panic_counter =
> +				max(cxt->panic_counter, hdr->counter);
> +
> +		if (!atomic_read(&buf->datalen)) {
> +			pr_debug("found erased zone: %s: id %lu, off %lld, size %zu, datalen %d\n",
> +					zone->name, i, zone->off,
> +					zone->buffer_size,
> +					atomic_read(&buf->datalen));
> +			continue;
> +		}
> +
> +		if (!is_on_panic())
> +			zone->should_recover = true;
> +		pr_debug("found nice zone: %s: id %lu, off %lld, size %zu, datalen %d\n",
> +				zone->name, i, zone->off,
> +				zone->buffer_size, atomic_read(&buf->datalen));
> +	}
> +
> +	return 0;
> +}
> +
> +static int psz_recover_oops(struct psz_context *cxt)
> +{
> +	int ret;
> +
> +	if (!cxt->opszs)
> +		return 0;
> +
> +	ret = psz_recover_oops_meta(cxt);
> +	if (ret)
> +		goto recover_fail;
> +
> +	ret = psz_recover_oops_data(cxt);
> +	if (ret)
> +		goto recover_fail;
> +
> +	return 0;
> +recover_fail:
> +	pr_debug("recover oops failed\n");
> +	return ret;
> +}
> +
> +/**
> + * psz_recovery() - recover data from storage
> + * @cxt: the context of pstore/zone
> + *
> + * recovery means reading data back from storage after rebooting
> + *
> + * Return: 0 on success, others on failure.
> + */
> +static inline int psz_recovery(struct psz_context *cxt)
> +{
> +	int ret = -EBUSY;
> +
> +	if (atomic_read(&cxt->recovered))
> +		return 0;
> +
> +	ret = psz_recover_oops(cxt);
> +	if (ret)
> +		goto recover_fail;
> +
> +	pr_debug("recover end!\n");
> +	atomic_set(&cxt->recovered, 1);
> +	return 0;
> +
> +recover_fail:
> +	pr_err("recover failed\n");
> +	return ret;
> +}
> +
> +static int psz_pstore_open(struct pstore_info *psi)
> +{
> +	struct psz_context *cxt = psi->data;
> +
> +	cxt->oops_read_cnt = 0;
> +	return 0;
> +}
> +
> +static inline bool psz_ok(struct psz_zone *zone)
> +{
> +	if (zone && zone->buffer && buffer_datalen(zone))
> +		return true;
> +	return false;
> +}
> +
> +static inline int psz_oops_erase(struct psz_context *cxt,
> +		struct psz_zone *zone, struct pstore_record *record)
> +{
> +	struct psz_buffer *buffer = zone->buffer;
> +	struct psz_oops_header *hdr =
> +		(struct psz_oops_header *)buffer->data;
> +
> +	if (unlikely(!psz_ok(zone)))
> +		return 0;
> +	/* this zone is already updated, no need to erase */
> +	if (record->count != hdr->counter)
> +		return 0;
> +
> +	atomic_set(&zone->buffer->datalen, 0);
> +	return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
> +}
> +
> +static int psz_pstore_erase(struct pstore_record *record)
> +{
> +	struct psz_context *cxt = record->psi->data;
> +
> +	switch (record->type) {
> +	case PSTORE_TYPE_DMESG:
> +		if (record->id >= cxt->oops_max_cnt)
> +			return -EINVAL;
> +		return psz_oops_erase(cxt, cxt->opszs[record->id], record);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void psz_write_kmsg_hdr(struct psz_zone *zone,
> +		struct pstore_record *record)
> +{
> +	struct psz_context *cxt = record->psi->data;
> +	struct psz_buffer *buffer = zone->buffer;
> +	struct psz_oops_header *hdr =
> +		(struct psz_oops_header *)buffer->data;
> +
> +	hdr->magic = OOPS_HEADER_MAGIC;
> +	hdr->compressed = record->compressed;
> +	hdr->time.tv_sec = record->time.tv_sec;
> +	hdr->time.tv_nsec = record->time.tv_nsec;
> +	hdr->reason = record->reason;
> +	if (hdr->reason == KMSG_DUMP_OOPS)
> +		hdr->counter = ++cxt->oops_counter;
> +	else
> +		hdr->counter = ++cxt->panic_counter;
> +}
> +
> +static inline int notrace psz_oops_write_record(struct psz_context *cxt,
> +		struct pstore_record *record)
> +{
> +	size_t size, hlen;
> +	struct psz_zone *zone;
> +	unsigned int zonenum;
> +
> +	zonenum = cxt->oops_write_cnt;
> +	zone = cxt->opszs[zonenum];
> +	if (unlikely(!zone))
> +		return -ENOSPC;
> +	cxt->oops_write_cnt = (zonenum + 1) % cxt->oops_max_cnt;
> +
> +	pr_debug("write %s to zone id %d\n", zone->name, zonenum);
> +	psz_write_kmsg_hdr(zone, record);
> +	hlen = sizeof(struct psz_oops_header);
> +	size = min_t(size_t, record->size, zone->buffer_size - hlen);
> +	return psz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
> +}
> +
> +static int notrace psz_oops_write(struct psz_context *cxt,
> +		struct pstore_record *record)
> +{
> +	int ret;
> +	struct psz_info *info = cxt->psz_info;
> +
> +	/*
> +	 * Out of the various oops/panic dump types, pstore/zone is currently
> +	 * designed to only store crash logs, rather than storing general
> +	 * kernel logs.
> +	 */
> +	if (record->reason != KMSG_DUMP_OOPS &&
> +			record->reason != KMSG_DUMP_PANIC)
> +		return -EINVAL;
> +
> +	/* Skip Oopes when configured to do so. */
> +	if (record->reason == KMSG_DUMP_OOPS && !info->dump_oops)
> +		return -EINVAL;
> +
> +	/*
> +	 * Explicitly only take the first part of any new crash.
> +	 * If our buffer is larger than kmsg_bytes, this can never happen,
> +	 * and if our buffer is smaller than kmsg_bytes, we don't want the
> +	 * report split across multiple records.
> +	 */
> +	if (record->part != 1)
> +		return -ENOSPC;
> +
> +	if (!cxt->opszs)
> +		return -ENOSPC;
> +
> +	ret = psz_oops_write_record(cxt, record);
> +	if (!ret) {
> +		pr_debug("try to flush other dirty oops zones\n");
> +		psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);
> +	}
> +
> +	/* alway return 0 as we had handled it on buffer */
> +	return 0;
> +}
> +
> +static int notrace psz_pstore_write(struct pstore_record *record)
> +{
> +	struct psz_context *cxt = record->psi->data;
> +
> +	if (record->type == PSTORE_TYPE_DMESG &&
> +			record->reason == KMSG_DUMP_PANIC)
> +		atomic_set(&cxt->on_panic, 1);
> +
> +	switch (record->type) {
> +	case PSTORE_TYPE_DMESG:
> +		return psz_oops_write(cxt, record);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static struct psz_zone *psz_read_next_zone(struct psz_context *cxt)
> +{
> +	struct psz_zone *zone = NULL;
> +
> +	while (cxt->oops_read_cnt < cxt->oops_max_cnt) {
> +		zone = cxt->opszs[cxt->oops_read_cnt++];
> +		if (psz_ok(zone))
> +			return zone;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int psz_read_oops_hdr(struct psz_zone *zone,
> +		struct pstore_record *record)
> +{
> +	struct psz_buffer *buffer = zone->buffer;
> +	struct psz_oops_header *hdr =
> +		(struct psz_oops_header *)buffer->data;
> +
> +	if (hdr->magic != OOPS_HEADER_MAGIC)
> +		return -EINVAL;
> +	record->compressed = hdr->compressed;
> +	record->time.tv_sec = hdr->time.tv_sec;
> +	record->time.tv_nsec = hdr->time.tv_nsec;
> +	record->reason = hdr->reason;
> +	record->count = hdr->counter;
> +	return 0;
> +}
> +
> +static ssize_t psz_oops_read(struct psz_zone *zone,
> +		struct pstore_record *record)
> +{
> +	ssize_t size, hlen = 0;
> +
> +	size = buffer_datalen(zone);
> +	/* Clear and skip this oops record if it has no valid header */
> +	if (psz_read_oops_hdr(zone, record)) {
> +		atomic_set(&zone->buffer->datalen, 0);
> +		atomic_set(&zone->dirty, 0);
> +		return -ENOMSG;
> +	}
> +	size -= sizeof(struct psz_oops_header);
> +
> +	if (!record->compressed) {
> +		char *buf = kasprintf(GFP_KERNEL, "%s: Total %d times\n",
> +				get_reason_str(record->reason), record->count);
> +		hlen = strlen(buf);
> +		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
> +		if (!record->buf) {
> +			kfree(buf);
> +			return -ENOMEM;
> +		}
> +	} else {
> +		record->buf = kmalloc(size, GFP_KERNEL);
> +		if (!record->buf)
> +			return -ENOMEM;
> +	}
> +
> +	size = psz_zone_read(zone, record->buf + hlen, size,
> +			sizeof(struct psz_oops_header) < 0);
> +	if (unlikely(size < 0)) {
> +		kfree(record->buf);
> +		return -ENOMSG;
> +	}
> +
> +	return size + hlen;
> +}
> +
> +static ssize_t psz_pstore_read(struct pstore_record *record)
> +{
> +	struct psz_context *cxt = record->psi->data;
> +	ssize_t (*readop)(struct psz_zone *zone,
> +			struct pstore_record *record);
> +	struct psz_zone *zone;
> +	ssize_t ret;
> +
> +	/* before read, we must recover from storage */
> +	ret = psz_recovery(cxt);
> +	if (ret)
> +		return ret;
> +
> +next_zone:
> +	zone = psz_read_next_zone(cxt);
> +	if (!zone)
> +		return 0;
> +
> +	record->type = zone->type;
> +	switch (record->type) {
> +	case PSTORE_TYPE_DMESG:
> +		readop = psz_oops_read;
> +		record->id = cxt->oops_read_cnt - 1;
> +		break;
> +	default:
> +		goto next_zone;
> +	}
> +
> +	ret = readop(zone, record);
> +	if (ret == -ENOMSG)
> +		goto next_zone;
> +	return ret;
> +}
> +
> +static struct psz_context psz_cxt = {
> +	.psz_info_lock = __SPIN_LOCK_UNLOCKED(psz_cxt.psz_info_lock),
> +	.recovered = ATOMIC_INIT(0),
> +	.on_panic = ATOMIC_INIT(0),
> +	.pstore = {
> +		.owner = THIS_MODULE,
> +		.name = MODNAME,
> +		.open = psz_pstore_open,
> +		.read = psz_pstore_read,
> +		.write = psz_pstore_write,
> +		.erase = psz_pstore_erase,
> +	},
> +};
> +
> +static struct psz_zone *psz_init_zone(enum pstore_type_id type,
> +		loff_t *off, size_t size)
> +{
> +	struct psz_info *info = psz_cxt.psz_info;
> +	struct psz_zone *zone;
> +	const char *name = pstore_type_to_name(type);
> +
> +	if (!size)
> +		return NULL;
> +
> +	if (*off + size > info->total_size) {
> +		pr_err("no room for %s (0x%zx@0x%llx over 0x%lx)\n",
> +			name, size, *off, info->total_size);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	zone = kzalloc(sizeof(struct psz_zone), GFP_KERNEL);
> +	if (!zone)
> +		return ERR_PTR(-ENOMEM);
> +
> +	zone->buffer = kmalloc(size, GFP_KERNEL);
> +	if (!zone->buffer) {
> +		kfree(zone);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	memset(zone->buffer, 0xFF, size);
> +	zone->off = *off;
> +	zone->name = name;
> +	zone->type = type;
> +	zone->buffer_size = size - sizeof(struct psz_buffer);
> +	zone->buffer->sig = type ^ PSZ_SIG;
> +	atomic_set(&zone->dirty, 0);
> +	atomic_set(&zone->buffer->datalen, 0);
> +
> +	*off += size;
> +
> +	pr_debug("pszone %s: off 0x%llx, %zu header, %zu data\n", zone->name,
> +			zone->off, sizeof(*zone->buffer), zone->buffer_size);
> +	return zone;
> +}
> +
> +static struct psz_zone **psz_init_zones(enum pstore_type_id type,
> +	loff_t *off, size_t total_size, ssize_t record_size,
> +	unsigned int *cnt)
> +{
> +	struct psz_info *info = psz_cxt.psz_info;
> +	struct psz_zone **zones, *zone;
> +	const char *name = pstore_type_to_name(type);
> +	int c, i;
> +
> +	if (!total_size || !record_size)
> +		return NULL;
> +
> +	if (*off + total_size > info->total_size) {
> +		pr_err("no room for zones %s (0x%zx@0x%llx over 0x%lx)\n",
> +			name, total_size, *off, info->total_size);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	c = total_size / record_size;
> +	zones = kcalloc(c, sizeof(*zones), GFP_KERNEL);
> +	if (!zones) {
> +		pr_err("allocate for zones %s failed\n", name);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	memset(zones, 0, c * sizeof(*zones));
> +
> +	for (i = 0; i < c; i++) {
> +		zone = psz_init_zone(type, off, record_size);
> +		if (!zone || IS_ERR(zone)) {
> +			pr_err("initialize zones %s failed\n", name);
> +			while (--i >= 0) {
> +				kfree(zones[i]->buffer);
> +				kfree(zones[i]);
> +			}
> +			kfree(zones);
> +			return (void *)zone;
> +		}
> +		zones[i] = zone;
> +	}
> +
> +	*cnt = c;
> +	return zones;
> +}
> +
> +static void psz_free_zone(struct psz_zone **pszone)
> +{
> +	struct psz_zone *zone = *pszone;
> +
> +	if (!zone)
> +		return;
> +
> +	kfree(zone->buffer);
> +	kfree(zone);
> +	*pszone = NULL;
> +}
> +
> +static void psz_free_zones(struct psz_zone ***pszones, unsigned int *cnt)
> +{
> +	struct psz_zone **zones = *pszones;
> +
> +	if (!zones)
> +		return;
> +
> +	while (*cnt > 0) {
> +		psz_free_zone(&zones[*cnt]);
> +		(*cnt)--;
> +	}
> +	kfree(zones);
> +	*pszones = NULL;
> +}
> +
> +static void psz_free_all_zones(struct psz_context *cxt)
> +{
> +	if (cxt->opszs)
> +		psz_free_zones(&cxt->opszs, &cxt->oops_max_cnt);
> +}
> +
> +static int psz_alloc_zones(struct psz_context *cxt)
> +{
> +	struct psz_info *info = cxt->psz_info;
> +	loff_t off = 0;
> +	int err;
> +	size_t size;
> +
> +	size = info->total_size;
> +	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off, size,
> +			info->oops_size, &cxt->oops_max_cnt);
> +	if (IS_ERR(cxt->opszs)) {
> +		err = PTR_ERR(cxt->opszs);
> +		goto fail_out;
> +	}
> +
> +	return 0;
> +fail_out:
> +	return err;
> +}
> +
> +/**
> + * psz_register() - register to pstore/zone
> + *
> + * @info: back-end driver information. See &struct psz_info.
> + *
> + * Only one back-end at one time.
> + *
> + * Return: 0 on success, others on failure.
> + */
> +int psz_register(struct psz_info *info)
> +{
> +	int err = -EINVAL;
> +	struct psz_context *cxt = &psz_cxt;
> +	struct module *owner = info->owner;
> +
> +	if (!info->total_size) {
> +		pr_warn("the total size must be non-zero\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!info->oops_size) {
> +		pr_warn("at least one of the records be non-zero\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!info->name || !info->name[0])
> +		return -EINVAL;
> +
> +	if (info->total_size < 4096) {
> +		pr_err("total size must be greater than 4096 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +#define check_size(name, size) {					\
> +		if (info->name > 0 && info->name < (size)) {		\
> +			pr_err(#name " must be over %d\n", (size));	\
> +			return -EINVAL;					\
> +		}							\
> +		if (info->name & (size - 1)) {				\
> +			pr_err(#name " must be a multiple of %d\n",	\
> +					(size));			\
> +			return -EINVAL;					\
> +		}							\
> +	}
> +
> +	check_size(total_size, 4096);
> +	check_size(oops_size, SECTOR_SIZE);
> +
> +#undef check_size
> +
> +	/*
> +	 * the @read and @write must be applied.
> +	 * if no @read, pstore may mount failed.
> +	 * if no @write, pstore do not support to remove record file.
> +	 */
> +	if (!info->read || !info->write) {
> +		pr_err("no valid general read/write interface\n");
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&cxt->psz_info_lock);
> +	if (cxt->psz_info) {
> +		pr_warn("'%s' already loaded: ignoring '%s'\n",
> +				cxt->psz_info->name, info->name);
> +		spin_unlock(&cxt->psz_info_lock);
> +		return -EBUSY;
> +	}
> +	cxt->psz_info = info;
> +	spin_unlock(&cxt->psz_info_lock);
> +
> +	if (owner && !try_module_get(owner)) {
> +		err = -EBUSY;
> +		goto fail_out;
> +	}
> +
> +	pr_debug("register %s with properties:\n", info->name);
> +	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
> +	pr_debug("\toops size : %ld Bytes\n", info->oops_size);
> +
> +	err = psz_alloc_zones(cxt);
> +	if (err) {
> +		pr_err("alloc zones failed\n");
> +		goto put_module;
> +	}
> +
> +	if (info->oops_size) {
> +		cxt->pstore.bufsize = cxt->opszs[0]->buffer_size -
> +			sizeof(struct psz_oops_header);
> +		cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
> +		if (!cxt->pstore.buf) {
> +			err = -ENOMEM;
> +			goto free_all_zones;
> +		}
> +	}
> +	cxt->pstore.data = cxt;
> +	if (info->oops_size)
> +		cxt->pstore.flags = PSTORE_FLAGS_DMESG;
> +
> +	pr_info("Registered %s as pszone backend for%s%s\n", info->name,
> +			cxt->opszs && cxt->psz_info->dump_oops ? " Oops" : "",
> +			cxt->opszs && cxt->psz_info->panic_write ? " Panic" : "");
> +
> +	err = pstore_register(&cxt->pstore);
> +	if (err) {
> +		pr_err("registering with pstore failed\n");
> +		goto free_pstore_buf;
> +	}
> +
> +	module_put(owner);
> +	return 0;
> +
> +free_pstore_buf:
> +	kfree(cxt->pstore.buf);
> +free_all_zones:
> +	psz_free_all_zones(cxt);
> +put_module:
> +	module_put(owner);
> +fail_out:
> +	spin_lock(&psz_cxt.psz_info_lock);
> +	psz_cxt.psz_info = NULL;
> +	spin_unlock(&psz_cxt.psz_info_lock);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(psz_register);
> +
> +/**
> + * psz_unregister() - unregister to pstore/zone
> + *
> + * @info: back-end driver information. See &struct psz_info.
> + */
> +void psz_unregister(struct psz_info *info)
> +{
> +	struct psz_context *cxt = &psz_cxt;
> +
> +	pstore_unregister(&cxt->pstore);
> +	kfree(cxt->pstore.buf);
> +	cxt->pstore.bufsize = 0;
> +
> +	spin_lock(&cxt->psz_info_lock);
> +	cxt->psz_info = NULL;
> +	spin_unlock(&cxt->psz_info_lock);
> +
> +	psz_free_all_zones(cxt);
> +}
> +EXPORT_SYMBOL_GPL(psz_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
> +MODULE_DESCRIPTION("Storage Manager for Pstore/blk and Pstore/ram");
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index e779441e6d26..859583a7104d 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -45,6 +45,7 @@ enum pstore_type_id {
>  
>  const char *pstore_type_to_name(enum pstore_type_id type);
>  enum pstore_type_id pstore_name_to_type(const char *name);
> +const char *get_reason_str(enum kmsg_dump_reason reason);
>  
>  struct pstore_info;
>  /**
> diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
> new file mode 100644
> index 000000000000..afc10a67a777
> --- /dev/null
> +++ b/include/linux/pstore_zone.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __PSTORE_ZONE_H_
> +#define __PSTORE_ZONE_H_
> +
> +#include <linux/types.h>
> +
> +typedef ssize_t (*psz_read_op)(char *, size_t, loff_t);
> +typedef ssize_t (*psz_write_op)(const char *, size_t, loff_t);
> +/**
> + * struct psz_info - pstore/zone back-end driver structure
> + *
> + * @owner:	Module which is responsible for this back-end driver.
> + * @name:	Name of the back-end driver.
> + * @total_size: The total size in bytes pstore/zone can use. It must be greater
> + *		than 4096 and be multiple of 4096.
> + * @oops_size:	The size of oops/panic zone. Zero means disabled, otherwise,
> + *		it must be multiple of SECTOR_SIZE(512 Bytes).
> + * @dump_oops:	Whether to dump oops log.
> + * @read:	The general read operation. Both of the function parameters
> + *		@size and @offset are relative value to storage.
> + *		On success, the number of bytes should be returned, others
> + *		means error.
> + * @write:	The same as @read.
> + * @panic_write:The write operation only used for panic case. It's optional
> + *		if you do not care panic log. The parameters and return value
> + *		are the same as @read.
> + */
> +struct psz_info {
> +	struct module *owner;
> +	const char *name;
> +
> +	unsigned long total_size;
> +	unsigned long oops_size;
> +	int dump_oops;
> +	psz_read_op read;
> +	psz_write_op write;
> +	psz_write_op panic_write;
> +};
> +
> +extern int psz_register(struct psz_info *info);
> +extern void psz_unregister(struct psz_info *info);
> +
> +#endif
> 

-- 
WeiXiong Liao
