Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EFAC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10912051A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaDfGFD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCRSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:13:18 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39105 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCRSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:13:18 -0400
Received: by mail-pj1-f68.google.com with SMTP id ck23so1538628pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNwNQ4/fdbVjQHkJDcFfL9rHU6zu+yh1atcjUXfSy9k=;
        b=WaDfGFD2ltnwnHRDBvQREFP6g0oENfV+HHD7YU1xs7M11y9efKBbHt4Fhtv5iJADK6
         DXezh+/2liaThBsMpp/GgbMM3uhMWbZida5ifFEkaSODiOCpwBqTf0UBHFPD1u+tflu9
         7jHfzm2HzxF1IaIdwN/5MIn8QJHkLxJHwKqbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNwNQ4/fdbVjQHkJDcFfL9rHU6zu+yh1atcjUXfSy9k=;
        b=Ok7aGTCUDa8Jashz9W2R1rTj5l/IVYXydTeDf9wtmxY/OEY4loKpQTWW48ZAYgKz+N
         cWBoHQNHQVVeB7Cn0vm7RbE1ClKEBDmvD1tmJhk2/BnRz1vNXkDl4nf8kjwh9wiaB/QV
         7JknHCjRa1TiJhekaOfpfh9nLbh0oiqFbOnTMdGBC9YfeJvcpC8L2r1XSwqC4IcYCO+B
         0jDGuhof/4Rw28l+RMnus+K3fc8SBuOP/pfa77p2qRtS4d/cCnyBZkhl1qOYZJEug+jB
         jMzUNO5KFbj2jnQBsipfZ5Rztb7oxdtEI07GXuEBZQrc+kfx6lXX9ZAgnLW2F1aPiNJ9
         YT6A==
X-Gm-Message-State: ANhLgQ3ItIRPG/hsPK/bY7i2/I2H8oV642Lp1WGXn+Cr87z3wstH8KIC
        1QRsmPNDE+0yLRQ/VEKV6bs+4g==
X-Google-Smtp-Source: ADFU+vvt8UDb1aMKzK4X1M7YTY29Igg9C5Jn0+LsiiRdzVrCI0chlEHUHdGluu7vXlOE23ulBV45rQ==
X-Received: by 2002:a17:90a:c793:: with SMTP id gn19mr5928090pjb.51.1584555194234;
        Wed, 18 Mar 2020 11:13:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm6534754pgf.33.2020.03.18.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:13:13 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:13:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 03/11] pstore/blk: blkoops: support pmsg recorder
Message-ID: <202003181107.6B776F0E5F@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-4-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581078355-19647-4-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 08:25:47PM +0800, WeiXiong Liao wrote:
> pmsg support recorder for userspace. To enable pmsg, just make pmsg_size
> be greater than 0 and a multiple of 4096.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> ---
>  fs/pstore/Kconfig          |  12 +++
>  fs/pstore/blkoops.c        |  11 +++
>  fs/pstore/blkzone.c        | 229 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pstore_blk.h |   4 +
>  4 files changed, 246 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 7a57a8edb612..bbf1fdb5eaa7 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -186,6 +186,18 @@ config PSTORE_BLKOOPS_DMESG_SIZE
>  	  NOTE that, both kconfig and module parameters can configure blkoops,
>  	  but module parameters have priority over kconfig.
>  
> +config PSTORE_BLKOOPS_PMSG_SIZE
> +	int "pmsg size in kbytes for blkoops"
> +	depends on PSTORE_BLKOOPS
> +	depends on PSTORE_PMSG
> +	default 64

Instead of "depends on PSTORE_PMSG", you can do:

	default 64 if PSTORE_PMSG
	default 0

> +	help
> +	  This just sets size of pmsg (pmsg_size) for pstore/blk. The size is
> +	  in KB and must be a multiple of 4.
> +
> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> +	  but module parameters have priority over kconfig.
> +
>  config PSTORE_BLKOOPS_BLKDEV
>  	string "block device for blkoops"
>  	depends on PSTORE_BLKOOPS
> diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
> index 8027c3af8c8d..02e6e4c1f965 100644
> --- a/fs/pstore/blkoops.c
> +++ b/fs/pstore/blkoops.c
> @@ -16,6 +16,10 @@
>  module_param(dmesg_size, long, 0400);
>  MODULE_PARM_DESC(dmesg_size, "demsg size in kbytes");
>  
> +static long pmsg_size = -1;

Now PSTORE_BLKOOPS_PMSG_SIZE will always be available and you can set it
here.

> +module_param(pmsg_size, long, 0400);
> +MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
> +
>  static int dump_oops = -1;
>  module_param(dump_oops, int, 0400);
>  MODULE_PARM_DESC(total_size, "whether dump oops");
> @@ -60,6 +64,12 @@
>  #define DEFAULT_DMESG_SIZE 0
>  #endif
>  
> +#ifdef CONFIG_PSTORE_BLKOOPS_PMSG_SIZE
> +#define DEFAULT_PMSG_SIZE CONFIG_PSTORE_BLKOOPS_PMSG_SIZE
> +#else
> +#define DEFAULT_PMSG_SIZE 0
> +#endif

And drop this.

> +
>  #ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
>  #define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
>  #else
> @@ -113,6 +123,7 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
>  	}
>  
>  	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
> +	verify_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096);
>  #undef verify_size
>  	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
>  
> diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
> index f77f612b50ba..a3464252d52e 100644
> --- a/fs/pstore/blkzone.c
> +++ b/fs/pstore/blkzone.c
> @@ -24,12 +24,14 @@
>   *
>   * @sig: signature to indicate header (BLK_SIG xor BLKZONE-type value)
>   * @datalen: length of data in @data
> + * @start: offset into @data where the beginning of the stored bytes begin
>   * @data: zone data.
>   */
>  struct blkz_buffer {
>  #define BLK_SIG (0x43474244) /* DBGC */
>  	uint32_t sig;
>  	atomic_t datalen;
> +	atomic_t start;
>  	uint8_t data[];
>  };
>  
> @@ -85,8 +87,10 @@ struct blkz_zone {
>  
>  struct blkz_context {
>  	struct blkz_zone **dbzs;	/* dmesg block zones */
> +	struct blkz_zone *pbz;		/* Pmsg block zone */
>  	unsigned int dmesg_max_cnt;
>  	unsigned int dmesg_read_cnt;
> +	unsigned int pmsg_read_cnt;
>  	unsigned int dmesg_write_cnt;
>  	/*
>  	 * the counter should be recovered when recover.
> @@ -119,6 +123,11 @@ static inline int buffer_datalen(struct blkz_zone *zone)
>  	return atomic_read(&zone->buffer->datalen);
>  }
>  
> +static inline int buffer_start(struct blkz_zone *zone)
> +{
> +	return atomic_read(&zone->buffer->start);
> +}
> +
>  static inline bool is_on_panic(void)
>  {
>  	struct blkz_context *cxt = &blkz_cxt;
> @@ -410,6 +419,69 @@ static int blkz_recover_dmesg(struct blkz_context *cxt)
>  	return ret;
>  }
>  
> +static int blkz_recover_pmsg(struct blkz_context *cxt)
> +{
> +	struct blkz_info *info = cxt->bzinfo;
> +	struct blkz_buffer *oldbuf;
> +	struct blkz_zone *zone = NULL;
> +	int ret = 0;
> +	ssize_t rcnt, len;
> +
> +	zone = cxt->pbz;
> +	if (!zone || zone->oldbuf)
> +		return 0;
> +
> +	if (is_on_panic())
> +		goto out;
> +
> +	if (unlikely(!info->read))
> +		return -EINVAL;
> +
> +	len = zone->buffer_size + sizeof(*oldbuf);
> +	oldbuf = kzalloc(len, GFP_KERNEL);
> +	if (!oldbuf)
> +		return -ENOMEM;
> +
> +	rcnt = info->read((char *)oldbuf, len, zone->off);
> +	if (rcnt != len) {
> +		pr_debug("recover pmsg failed\n");
> +		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
> +		goto free_oldbuf;
> +	}
> +
> +	if (oldbuf->sig != zone->buffer->sig) {
> +		pr_debug("no valid data in zone %s\n", zone->name);
> +		goto free_oldbuf;
> +	}
> +
> +	if (zone->buffer_size < atomic_read(&oldbuf->datalen) ||
> +		zone->buffer_size < atomic_read(&oldbuf->start)) {
> +		pr_info("found overtop zone: %s: off %lu, size %zu\n",
> +				zone->name, zone->off, zone->buffer_size);
> +		goto free_oldbuf;
> +	}
> +
> +	if (!atomic_read(&oldbuf->datalen)) {
> +		pr_debug("found erased zone: %s: id 0, off %lu, size %zu, datalen %d\n",
> +				zone->name, zone->off, zone->buffer_size,
> +				atomic_read(&oldbuf->datalen));
> +		kfree(oldbuf);
> +		goto out;
> +	}
> +
> +	pr_debug("found nice zone: %s: id 0, off %lu, size %zu, datalen %d\n",
> +			zone->name, zone->off, zone->buffer_size,
> +			atomic_read(&oldbuf->datalen));
> +	zone->oldbuf = oldbuf;
> +out:
> +	blkz_flush_dirty_zone(zone);
> +	return 0;
> +
> +free_oldbuf:
> +	kfree(oldbuf);
> +	return ret;
> +}
> +
>  static inline int blkz_recovery(struct blkz_context *cxt)
>  {
>  	int ret = -EBUSY;
> @@ -421,6 +493,10 @@ static inline int blkz_recovery(struct blkz_context *cxt)
>  	if (ret)
>  		goto recover_fail;
>  
> +	ret = blkz_recover_pmsg(cxt);
> +	if (ret)
> +		goto recover_fail;
> +
>  	pr_debug("recover end!\n");
>  	atomic_set(&cxt->recovered, 1);
>  	return 0;
> @@ -435,9 +511,17 @@ static int blkz_pstore_open(struct pstore_info *psi)
>  	struct blkz_context *cxt = psi->data;
>  
>  	cxt->dmesg_read_cnt = 0;
> +	cxt->pmsg_read_cnt = 0;
>  	return 0;
>  }
>  
> +static inline bool blkz_old_ok(struct blkz_zone *zone)
> +{
> +	if (zone && zone->oldbuf && atomic_read(&zone->oldbuf->datalen))
> +		return true;
> +	return false;
> +}
> +
>  static inline bool blkz_ok(struct blkz_zone *zone)
>  {
>  	if (zone && zone->buffer && buffer_datalen(zone))
> @@ -455,6 +539,25 @@ static inline int blkz_dmesg_erase(struct blkz_context *cxt,
>  	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
>  }
>  
> +static inline int blkz_pmsg_erase(struct blkz_context *cxt,
> +		struct blkz_zone *zone)
> +{
> +	if (unlikely(!blkz_old_ok(zone)))
> +		return 0;
> +
> +	kfree(zone->oldbuf);
> +	zone->oldbuf = NULL;
> +	/*
> +	 * if there are new data in zone buffer, that means the old data
> +	 * are already invalid. It is no need to flush 0 (erase) to
> +	 * block device.
> +	 */
> +	if (!buffer_datalen(zone))
> +		return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
> +	blkz_flush_dirty_zone(zone);
> +	return 0;
> +}
> +
>  static int blkz_pstore_erase(struct pstore_record *record)
>  {
>  	struct blkz_context *cxt = record->psi->data;
> @@ -462,6 +565,8 @@ static int blkz_pstore_erase(struct pstore_record *record)
>  	switch (record->type) {
>  	case PSTORE_TYPE_DMESG:
>  		return blkz_dmesg_erase(cxt, cxt->dbzs[record->id]);
> +	case PSTORE_TYPE_PMSG:
> +		return blkz_pmsg_erase(cxt, cxt->pbz);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -482,8 +587,10 @@ static void blkz_write_kmsg_hdr(struct blkz_zone *zone,
>  	hdr->reason = record->reason;
>  	if (hdr->reason == KMSG_DUMP_OOPS)
>  		hdr->counter = ++cxt->oops_counter;
> -	else
> +	else if (hdr->reason == KMSG_DUMP_PANIC)
>  		hdr->counter = ++cxt->panic_counter;
> +	else
> +		hdr->counter = 0;
>  }
>  
>  static inline int notrace blkz_dmesg_write_do(struct blkz_context *cxt,
> @@ -546,6 +653,55 @@ static int notrace blkz_dmesg_write(struct blkz_context *cxt,
>  	return 0;
>  }
>  
> +static int notrace blkz_pmsg_write(struct blkz_context *cxt,
> +		struct pstore_record *record)
> +{
> +	struct blkz_zone *zone;
> +	size_t start, rem;
> +	int cnt = record->size;
> +	bool is_full_data = false;
> +	char *buf = record->buf;
> +
> +	zone = cxt->pbz;
> +	if (!zone)
> +		return -ENOSPC;
> +
> +	if (atomic_read(&zone->buffer->datalen) >= zone->buffer_size)
> +		is_full_data = true;
> +
> +	if (unlikely(cnt > zone->buffer_size)) {
> +		buf += cnt - zone->buffer_size;
> +		cnt = zone->buffer_size;
> +	}
> +
> +	start = buffer_start(zone);
> +	rem = zone->buffer_size - start;
> +	if (unlikely(rem < cnt)) {
> +		blkz_zone_write(zone, FLUSH_PART, buf, rem, start);
> +		buf += rem;
> +		cnt -= rem;
> +		start = 0;
> +		is_full_data = true;
> +	}
> +
> +	atomic_set(&zone->buffer->start, cnt + start);
> +	blkz_zone_write(zone, FLUSH_PART, buf, cnt, start);
> +
> +	/**
> +	 * blkz_zone_write will set datalen as start + cnt.
> +	 * It work if actual data length lesser than buffer size.
> +	 * If data length greater than buffer size, pmsg will rewrite to
> +	 * beginning of zone, which make buffer->datalen wrongly.
> +	 * So we should reset datalen as buffer size once actual data length
> +	 * greater than buffer size.
> +	 */
> +	if (is_full_data) {
> +		atomic_set(&zone->buffer->datalen, zone->buffer_size);
> +		blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
> +	}
> +	return 0;
> +}
> +
>  static int notrace blkz_pstore_write(struct pstore_record *record)
>  {
>  	struct blkz_context *cxt = record->psi->data;
> @@ -557,6 +713,8 @@ static int notrace blkz_pstore_write(struct pstore_record *record)
>  	switch (record->type) {
>  	case PSTORE_TYPE_DMESG:
>  		return blkz_dmesg_write(cxt, record);
> +	case PSTORE_TYPE_PMSG:
> +		return blkz_pmsg_write(cxt, record);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -573,6 +731,13 @@ static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
>  			return zone;
>  	}
>  
> +	if (cxt->pmsg_read_cnt == 0) {
> +		cxt->pmsg_read_cnt++;
> +		zone = cxt->pbz;
> +		if (blkz_old_ok(zone))
> +			return zone;
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -611,7 +776,8 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
>  		char *buf = kasprintf(GFP_KERNEL,
>  				"%s: Total %d times\n",
>  				record->reason == KMSG_DUMP_OOPS ? "Oops" :
> -				"Panic", record->count);
> +				record->reason == KMSG_DUMP_PANIC ? "Panic" :
> +				"Unknown", record->count);

Please use get_reason_str() here.

>  		hlen = strlen(buf);
>  		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
>  		if (!record->buf) {
> @@ -633,6 +799,29 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
>  	return size + hlen;
>  }
>  
> +static ssize_t blkz_pmsg_read(struct blkz_zone *zone,
> +		struct pstore_record *record)
> +{
> +	size_t size, start;
> +	struct blkz_buffer *buf;
> +
> +	buf = (struct blkz_buffer *)zone->oldbuf;
> +	if (!buf)
> +		return READ_NEXT_ZONE;
> +
> +	size = atomic_read(&buf->datalen);
> +	start = atomic_read(&buf->start);
> +
> +	record->buf = kmalloc(size, GFP_KERNEL);
> +	if (!record->buf)
> +		return -ENOMEM;
> +
> +	memcpy(record->buf, buf->data + start, size - start);
> +	memcpy(record->buf + size - start, buf->data, start);
> +
> +	return size;
> +}
> +
>  static ssize_t blkz_pstore_read(struct pstore_record *record)
>  {
>  	struct blkz_context *cxt = record->psi->data;
> @@ -657,6 +846,9 @@ static ssize_t blkz_pstore_read(struct pstore_record *record)
>  		blkz_read = blkz_dmesg_read;
>  		record->id = cxt->dmesg_read_cnt - 1;
>  		break;
> +	case PSTORE_TYPE_PMSG:
> +		blkz_read = blkz_pmsg_read;
> +		break;
>  	default:
>  		goto next_zone;
>  	}
> @@ -712,8 +904,10 @@ static struct blkz_zone *blkz_init_zone(enum pstore_type_id type,
>  	zone->type = type;
>  	zone->buffer_size = size - sizeof(struct blkz_buffer);
>  	zone->buffer->sig = type ^ BLK_SIG;
> +	zone->oldbuf = NULL;
>  	atomic_set(&zone->dirty, 0);
>  	atomic_set(&zone->buffer->datalen, 0);
> +	atomic_set(&zone->buffer->start, 0);
>  
>  	*off += size;
>  
> @@ -798,17 +992,26 @@ static int blkz_cut_zones(struct blkz_context *cxt)
>  	struct blkz_info *info = cxt->bzinfo;
>  	unsigned long off = 0;
>  	int err;
> -	size_t size;
> +	size_t off_size = 0;
>  
> -	size = info->total_size;
> -	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off, size,
> +	off_size += info->pmsg_size;
> +	cxt->pbz = blkz_init_zone(PSTORE_TYPE_PMSG, &off, info->pmsg_size);
> +	if (IS_ERR(cxt->pbz)) {
> +		err = PTR_ERR(cxt->pbz);
> +		goto fail_out;
> +	}
> +
> +	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off,
> +			info->total_size - off_size,
>  			info->dmesg_size, &cxt->dmesg_max_cnt);
>  	if (IS_ERR(cxt->dbzs)) {
>  		err = PTR_ERR(cxt->dbzs);
> -		goto fail_out;
> +		goto free_pmsg;
>  	}
>  
>  	return 0;
> +free_pmsg:
> +	blkz_free_zone(&cxt->pbz);
>  fail_out:
>  	return err;
>  }
> @@ -824,7 +1027,7 @@ int blkz_register(struct blkz_info *info)
>  		return -EINVAL;
>  	}
>  
> -	if (!info->dmesg_size) {
> +	if (!info->dmesg_size && !info->pmsg_size) {
>  		pr_warn("at least one of the records be non-zero\n");
>  		return -EINVAL;
>  	}
> @@ -851,6 +1054,7 @@ int blkz_register(struct blkz_info *info)
>  
>  	check_size(total_size, 4096);
>  	check_size(dmesg_size, SECTOR_SIZE);
> +	check_size(pmsg_size, SECTOR_SIZE);
>  
>  #undef check_size
>  
> @@ -882,6 +1086,7 @@ int blkz_register(struct blkz_info *info)
>  	pr_debug("register %s with properties:\n", info->name);
>  	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
>  	pr_debug("\tdmesg size : %ld Bytes\n", info->dmesg_size);
> +	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
>  
>  	err = blkz_cut_zones(cxt);
>  	if (err) {
> @@ -900,11 +1105,14 @@ int blkz_register(struct blkz_info *info)
>  	}
>  	cxt->pstore.data = cxt;
>  	if (info->dmesg_size)
> -		cxt->pstore.flags = PSTORE_FLAGS_DMESG;
> +		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
> +	if (info->pmsg_size)
> +		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
>  
> -	pr_info("Registered %s as blkzone backend for %s%s\n", info->name,
> +	pr_info("Registered %s as blkzone backend for %s%s%s\n", info->name,
>  			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
> -			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "");
> +			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "",
> +			cxt->pbz ? "Pmsg" : "");

I'd switch to leading spaces so can leave these strings unchanged as you
add them:

	for%s%s%s\n", info->name,
		cxt->dbzs && cxt->bzinfo->dump_oops ? " Oops" : "",
		cxt->dbzs && cxt->bzinfo->panic_write ? " Panic" : "",
		cxt->pbz ? " Pmsg" : "");

etc

>  
>  	err = pstore_register(&cxt->pstore);
>  	if (err) {
> @@ -940,6 +1148,7 @@ void blkz_unregister(struct blkz_info *info)
>  	spin_unlock(&cxt->bzinfo_lock);
>  
>  	blkz_free_zones(&cxt->dbzs, &cxt->dmesg_max_cnt);
> +	blkz_free_zone(&cxt->pbz);
>  }
>  EXPORT_SYMBOL_GPL(blkz_unregister);
>  
> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
> index 589d276fa4e4..af06be25bd01 100644
> --- a/include/linux/pstore_blk.h
> +++ b/include/linux/pstore_blk.h
> @@ -19,6 +19,9 @@
>   * @dmesg_size:
>   *	The size of each zones for dmesg (oops & panic). Zero means disabled,
>   *	otherwise, it must be multiple of SECTOR_SIZE(512 Bytes).
> + * @pmsg_size:
> + *	The size of zone for pmsg. Zero means disabled, othewise, it must be
> + *	multiple of SECTOR_SIZE(512).
>   * @dump_oops:
>   *	Dump oops and panic log or only panic.
>   * @read, @write:
> @@ -50,6 +53,7 @@ struct blkz_info {
>  
>  	unsigned long total_size;
>  	unsigned long dmesg_size;
> +	unsigned long pmsg_size;
>  	int dump_oops;
>  	blkz_read_op read;
>  	blkz_write_op write;
> -- 
> 1.9.1
> 

-- 
Kees Cook
