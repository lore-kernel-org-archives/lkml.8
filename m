Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC38C54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58020769
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCVM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:28:00 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47704 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbgCVM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:28:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.232732-0.000359942-0.766908;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H3RTJAs_1584880056;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H3RTJAs_1584880056)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 22 Mar 2020 20:27:37 +0800
Subject: Re: [PATCH v2 07/11] pstore/blk: skip broken zone for mtd device
To:     Kees Cook <keescook@chromium.org>
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
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-8-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181131.3A8F861F@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <a65c9f15-c510-caf5-9bc8-98941a30488c@allwinnertech.com>
Date:   Sun, 22 Mar 2020 20:27:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003181131.3A8F861F@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/3/19 AM 2:35, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 08:25:51PM +0800, WeiXiong Liao wrote:
>> It's one of a series of patches for adaptive to MTD device.
>>
>> MTD device is not block device. As the block of flash (MTD device) will
>> be broken, it's necessary for pstore/blk to skip the broken block
>> (bad block).
>>
>> If device drivers return -ENEXT, pstore/blk will try next zone of dmesg.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> ---
>>  Documentation/admin-guide/pstore-block.rst |  3 +-
>>  fs/pstore/blkzone.c                        | 74 +++++++++++++++++++++++-------
>>  include/linux/blkoops.h                    |  4 +-
>>  include/linux/pstore_blk.h                 |  4 ++
>>  4 files changed, 66 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>> index c8a5f68960c3..be865dfc1a28 100644
>> --- a/Documentation/admin-guide/pstore-block.rst
>> +++ b/Documentation/admin-guide/pstore-block.rst
>> @@ -188,7 +188,8 @@ The parameter @offset of these interface is the relative position of the device.
>>  Normally the number of bytes read/written should be returned, while for error,
>>  negative number will be returned. The following return numbers mean more:
>>  
>> --EBUSY: pstore/blk should try again later.
>> +1. -EBUSY: pstore/blk should try again later.
>> +#. -ENEXT: this zone is used or broken, pstore/blk should try next one.
>>  
>>  panic_write (for non-block device)
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
>> index 442e5a5bbfda..205aeff28992 100644
>> --- a/fs/pstore/blkzone.c
>> +++ b/fs/pstore/blkzone.c
>> @@ -207,6 +207,9 @@ static int blkz_zone_write(struct blkz_zone *zone,
>>  
>>  	return 0;
>>  set_dirty:
>> +	/* no need to mark dirty if going to try next zone */
>> +	if (wcnt == -ENEXT)
>> +		return -ENEXT;
>>  	atomic_set(&zone->dirty, true);
>>  	/* flush dirty zones nicely */
>>  	if (wcnt == -EBUSY && !is_on_panic())
>> @@ -360,7 +363,11 @@ static int blkz_recover_dmesg_meta(struct blkz_context *cxt)
>>  			return -EINVAL;
>>  
>>  		rcnt = info->read((char *)buf, len, zone->off);
>> -		if (rcnt != len) {
>> +		if (rcnt == -ENEXT) {
>> +			pr_debug("%s with id %lu may be broken, skip\n",
>> +					zone->name, i);
>> +			continue;
>> +		} else if (rcnt != len) {
>>  			pr_err("read %s with id %lu failed\n", zone->name, i);
>>  			return (int)rcnt < 0 ? (int)rcnt : -EIO;
>>  		}
>> @@ -650,24 +657,58 @@ static void blkz_write_kmsg_hdr(struct blkz_zone *zone,
>>  		hdr->counter = 0;
>>  }
>>  
>> +/*
>> + * In case zone is broken, which may occur to MTD device, we try each zones,
>> + * start at cxt->dmesg_write_cnt.
>> + */
>>  static inline int notrace blkz_dmesg_write_do(struct blkz_context *cxt,
>>  		struct pstore_record *record)
>>  {
>> +	int ret = -EBUSY;
>>  	size_t size, hlen;
>>  	struct blkz_zone *zone;
>> -	unsigned int zonenum;
>> +	unsigned int i;
>>  
>> -	zonenum = cxt->dmesg_write_cnt;
>> -	zone = cxt->dbzs[zonenum];
>> -	if (unlikely(!zone))
>> -		return -ENOSPC;
>> -	cxt->dmesg_write_cnt = (zonenum + 1) % cxt->dmesg_max_cnt;
>> +	for (i = 0; i < cxt->dmesg_max_cnt; i++) {
>> +		unsigned int zonenum, len;
>> +
>> +		zonenum = (cxt->dmesg_write_cnt + i) % cxt->dmesg_max_cnt;
>> +		zone = cxt->dbzs[zonenum];
>> +		if (unlikely(!zone))
>> +			return -ENOSPC;
>>  
>> -	pr_debug("write %s to zone id %d\n", zone->name, zonenum);
>> -	blkz_write_kmsg_hdr(zone, record);
>> -	hlen = sizeof(struct blkz_dmesg_header);
>> -	size = min_t(size_t, record->size, zone->buffer_size - hlen);
>> -	return blkz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
>> +		/* avoid destorying old data, allocate a new one */
>> +		len = zone->buffer_size + sizeof(*zone->buffer);
>> +		zone->oldbuf = zone->buffer;
>> +		zone->buffer = kzalloc(len, GFP_KERNEL);
>> +		if (!zone->buffer) {
>> +			zone->buffer = zone->oldbuf;
>> +			return -ENOMEM;
>> +		}
>> +		zone->buffer->sig = zone->oldbuf->sig;
>> +
>> +		pr_debug("write %s to zone id %d\n", zone->name, zonenum);
>> +		blkz_write_kmsg_hdr(zone, record);
>> +		hlen = sizeof(struct blkz_dmesg_header);
>> +		size = min_t(size_t, record->size, zone->buffer_size - hlen);
>> +		ret = blkz_zone_write(zone, FLUSH_ALL, record->buf, size, hlen);
>> +		if (likely(!ret || ret != -ENEXT)) {
>> +			cxt->dmesg_write_cnt = zonenum + 1;
>> +			cxt->dmesg_write_cnt %= cxt->dmesg_max_cnt;
>> +			/* no need to try next zone, free last zone buffer */
>> +			kfree(zone->oldbuf);
>> +			zone->oldbuf = NULL;
>> +			return ret;
>> +		}
>> +
>> +		pr_debug("zone %u may be broken, try next dmesg zone\n",
>> +				zonenum);
>> +		kfree(zone->buffer);
>> +		zone->buffer = zone->oldbuf;
>> +		zone->oldbuf = NULL;
>> +	}
>> +
>> +	return -EBUSY;
>>  }
>>  
>>  static int notrace blkz_dmesg_write(struct blkz_context *cxt,
>> @@ -791,7 +832,6 @@ static int notrace blkz_pstore_write(struct pstore_record *record)
>>  	}
>>  }
>>  
>> -#define READ_NEXT_ZONE ((ssize_t)(-1024))
>>  static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
>>  {
>>  	struct blkz_zone *zone = NULL;
>> @@ -852,7 +892,7 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
>>  	if (blkz_read_dmesg_hdr(zone, record)) {
>>  		atomic_set(&zone->buffer->datalen, 0);
>>  		atomic_set(&zone->dirty, 0);
>> -		return READ_NEXT_ZONE;
>> +		return -ENEXT;
>>  	}
>>  	size -= sizeof(struct blkz_dmesg_header);
>>  
>> @@ -877,7 +917,7 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
>>  	if (unlikely(blkz_zone_read(zone, record->buf + hlen, size,
>>  				sizeof(struct blkz_dmesg_header)) < 0)) {
>>  		kfree(record->buf);
>> -		return READ_NEXT_ZONE;
>> +		return -ENEXT;
>>  	}
>>  
>>  	return size + hlen;
>> @@ -891,7 +931,7 @@ static ssize_t blkz_record_read(struct blkz_zone *zone,
>>  
>>  	buf = (struct blkz_buffer *)zone->oldbuf;
>>  	if (!buf)
>> -		return READ_NEXT_ZONE;
>> +		return -ENEXT;
>>  
>>  	size = atomic_read(&buf->datalen);
>>  	start = atomic_read(&buf->start);
>> @@ -943,7 +983,7 @@ static ssize_t blkz_pstore_read(struct pstore_record *record)
>>  	}
>>  
>>  	ret = readop(zone, record);
>> -	if (ret == READ_NEXT_ZONE)
>> +	if (ret == -ENEXT)
>>  		goto next_zone;
>>  	return ret;
>>  }
>> diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
>> index 8f40f225545d..71c596fd4cc8 100644
>> --- a/include/linux/blkoops.h
>> +++ b/include/linux/blkoops.h
>> @@ -27,6 +27,7 @@
>>   *	On error, negative number should be returned. The following returning
>>   *	number means more:
>>   *	  -EBUSY: pstore/blk should try again later.
>> + *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
>>   * @panic_write:
>>   *	The write operation only used for panic.
>>   *
>> @@ -45,7 +46,8 @@ struct blkoops_device {
>>  
>>  /*
>>   * Panic write for block device who should write alignmemt to SECTOR_SIZE.
>> - * On success, zero should be returned. Others mean error.
>> + * On success, zero should be returned. Others mean error except that -ENEXT
>> + * means the zone is used or broken, pstore/blk should try next one.
>>   */
>>  typedef int (*blkoops_blk_panic_write_op)(const char *buf, sector_t start_sect,
>>  		sector_t sects);
>> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
>> index 77704c1b404a..bbbe4fe37f7c 100644
>> --- a/include/linux/pstore_blk.h
>> +++ b/include/linux/pstore_blk.h
>> @@ -6,6 +6,9 @@
>>  #include <linux/types.h>
>>  #include <linux/blkdev.h>
>>  
>> +/* read/write function return -ENEXT means try next zone */
>> +#define ENEXT ((ssize_t)(1024))
> 
> I really don't like inventing errno numbers. Can you just reuse an
> existing (but non-block) errno like ESRCH or ENOMSG or something?
> 

ENOMSG is OK.

>> +
>>  /**
>>   * struct blkz_info - backend blkzone driver structure
>>   *
>> @@ -42,6 +45,7 @@
>>   *	On error, negative number should be returned. The following returning
>>   *	number means more:
>>   *	  -EBUSY: pstore/blk should try again later.
>> + *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
>>   * @panic_write:
>>   *	The write operation only used for panic. It's optional if you do not
>>   *	care panic record. If panic occur but blkzone do not recover yet, the
>> -- 
>> 1.9.1
>>
> 

-- 
WeiXiong Liao
