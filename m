Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B532C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2212073C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:03:34 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60272 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgCVNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:03:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.118824-0.000382246-0.880794;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H3RzwCQ_1584882206;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H3RzwCQ_1584882206)
          by smtp.aliyun-inc.com(10.147.40.44);
          Sun, 22 Mar 2020 21:03:27 +0800
Subject: Re: [PATCH v2 09/11] pstore/blk: blkoops: support special removing
 jobs for dmesg.
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
 <1581078355-19647-10-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181144.BD1DE93@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <bb740a71-66b4-e9fb-c3c4-5ecd6fda0fcb@allwinnertech.com>
Date:   Sun, 22 Mar 2020 21:03:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003181144.BD1DE93@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/3/19 AM 2:47, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 08:25:53PM +0800, WeiXiong Liao wrote:
>> It's one of a series of patches for adaptive to MTD device.
>>
>> MTD device is not block device. To write to flash device on MTD, erase
>> must to be done before. However, pstore/blk just set datalen as 0 when
>> remove, which is not enough for mtd device. That's why this patch here,
>> to support special jobs when removing pstore/blk record.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> ---
>>  Documentation/admin-guide/pstore-block.rst |  9 +++++++++
>>  fs/pstore/blkoops.c                        |  4 +++-
>>  fs/pstore/blkzone.c                        |  9 ++++++++-
>>  include/linux/blkoops.h                    | 10 ++++++++++
>>  include/linux/pstore_blk.h                 | 11 +++++++++++
>>  5 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>> index 299142b3d8e6..1735476621df 100644
>> --- a/Documentation/admin-guide/pstore-block.rst
>> +++ b/Documentation/admin-guide/pstore-block.rst
>> @@ -200,6 +200,15 @@ negative number will be returned. The following return numbers mean more:
>>  1. -EBUSY: pstore/blk should try again later.
>>  #. -ENEXT: this zone is used or broken, pstore/blk should try next one.
>>  
>> +erase
>> +~~~~~
>> +
>> +It's generic erase API for pstore/blk, which is requested by non-block device.
>> +It will be called while pstore record is removing. It's required only when the
>> +device has special removing jobs. For example, MTD device tries to erase block.
>> +
>> +Normally zero should be returned, otherwise it indicates an error.
>> +
>>  panic_write (for non-block device)
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  
>> diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
>> index 01170b344f00..7cf4731e52f7 100644
>> --- a/fs/pstore/blkoops.c
>> +++ b/fs/pstore/blkoops.c
>> @@ -164,6 +164,7 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
>>  	bzinfo->dump_oops = dump_oops;
>>  	bzinfo->read = bo_dev->read;
>>  	bzinfo->write = bo_dev->write;
>> +	bzinfo->erase = bo_dev->erase;
>>  	bzinfo->panic_write = bo_dev->panic_write;
>>  	bzinfo->name = "blkoops";
>>  	bzinfo->owner = THIS_MODULE;
>> @@ -383,10 +384,11 @@ int blkoops_register_blkdev(unsigned int major, unsigned int flags,
>>  	bo_dev.total_size = blkoops_bdev_size(bdev);
>>  	if (bo_dev.total_size == 0)
>>  		goto err_put_bdev;
>> -	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
>>  	bo_dev.flags = flags;
>>  	bo_dev.read = blkoops_generic_blk_read;
>>  	bo_dev.write = blkoops_generic_blk_write;
>> +	bo_dev.erase = NULL;
>> +	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
>>  
>>  	ret = blkoops_register_device(&bo_dev);
>>  	if (ret)
> 
> I think this patch, like the prior, needs to be reordered in the series.
> How about adding
> 
> blkoops_register_device()
> 
> as a single patch, which is what provides support for the "non-block"
> block devices? Then the blkoops_register_blkdev() can stand alone in the
> first patch?
> 
> It just might be easier to review, since nothing uses
> blkoops_register_device() until the mtd driver is added. So that
> function and this patch would go together as a single "support non-block
> devices" change.
> 

That's OK. I will do it.

>> diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
>> index 205aeff28992..a17fff77b875 100644
>> --- a/fs/pstore/blkzone.c
>> +++ b/fs/pstore/blkzone.c
>> @@ -593,11 +593,18 @@ static inline bool blkz_ok(struct blkz_zone *zone)
>>  static inline int blkz_dmesg_erase(struct blkz_context *cxt,
>>  		struct blkz_zone *zone)
>>  {
>> +	size_t size;
>> +
>>  	if (unlikely(!blkz_ok(zone)))
>>  		return 0;
>>  
>>  	atomic_set(&zone->buffer->datalen, 0);
>> -	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
>> +
>> +	size = buffer_datalen(zone) + sizeof(*zone->buffer);
>> +	if (cxt->bzinfo->erase)
>> +		return cxt->bzinfo->erase(size, zone->off);
>> +	else
>> +		return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
>>  }
>>  
>>  static inline int blkz_record_erase(struct blkz_context *cxt,
>> diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
>> index bc7665d14a98..11cb3036ad5f 100644
>> --- a/include/linux/blkoops.h
>> +++ b/include/linux/blkoops.h
>> @@ -33,6 +33,15 @@
>>   *	number means more:
>>   *	  -EBUSY: pstore/blk should try again later.
>>   *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
>> + * @erase:
>> + *	The general (not panic) erase operation. It will be call while pstore
>> + *	record is removing. It's required only when device have special
>> + *	removing jobs, for example, MTD device try to erase block.
>> + *
>> + *	Both of the @size and @offset parameters on this interface are
>> + *	the relative size of the space provided, not the whole disk/flash.
>> + *
>> + *	On success, 0 should be returned. Others mean error.
>>   * @panic_write:
>>   *	The write operation only used for panic.
>>   *
>> @@ -53,6 +62,7 @@ struct blkoops_device {
>>  	unsigned long total_size;
>>  	blkz_read_op read;
>>  	blkz_write_op write;
>> +	blkz_erase_op erase;
>>  	blkz_write_op panic_write;
>>  };
>>  
>> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
>> index bbbe4fe37f7c..9641969f888f 100644
>> --- a/include/linux/pstore_blk.h
>> +++ b/include/linux/pstore_blk.h
>> @@ -46,6 +46,15 @@
>>   *	number means more:
>>   *	  -EBUSY: pstore/blk should try again later.
>>   *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
>> + * @erase:
>> + *	The general (not panic) erase operation. It will be call while pstore
>> + *	record is removing. It's required only when device have special
>> + *	removing jobs, for example, MTD device try to erase block.
>> + *
>> + *	Both of the @size and @offset parameters on this interface are
>> + *	the relative size of the space provided, not the whole disk/flash.
>> + *
>> + *	On success, 0 should be returned. Others mean error.
>>   * @panic_write:
>>   *	The write operation only used for panic. It's optional if you do not
>>   *	care panic record. If panic occur but blkzone do not recover yet, the
>> @@ -59,6 +68,7 @@
>>   */
>>  typedef ssize_t (*blkz_read_op)(char *, size_t, loff_t);
>>  typedef ssize_t (*blkz_write_op)(const char *, size_t, loff_t);
>> +typedef ssize_t (*blkz_erase_op)(size_t, loff_t);
>>  struct blkz_info {
>>  	struct module *owner;
>>  	const char *name;
>> @@ -71,6 +81,7 @@ struct blkz_info {
>>  	int dump_oops;
>>  	blkz_read_op read;
>>  	blkz_write_op write;
>> +	blkz_erase_op erase;
>>  	blkz_write_op panic_write;
>>  };
>>  
>> -- 
>> 1.9.1
>>
> 

-- 
WeiXiong Liao
