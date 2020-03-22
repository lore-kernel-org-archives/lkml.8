Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C498C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342A2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCVNIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:08:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47192 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgCVNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:08:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436284|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.0771343-0.00168174-0.921184;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H3Rvpeu_1584882375;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H3Rvpeu_1584882375)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sun, 22 Mar 2020 21:06:16 +0800
Subject: Re: [PATCH v2 08/11] blkoops: respect for device to pick recorders
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
 <1581078355-19647-9-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181136.5F115BFCC1@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <909c27a3-38d7-4825-6085-5b941c904e57@allwinnertech.com>
Date:   Sun, 22 Mar 2020 21:06:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003181136.5F115BFCC1@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/3/19 AM 2:42, Kees Cook wrote:
> In the subject and through-out:
> 
> s/recorders/pstore front-ends/
> 

OK.

> On Fri, Feb 07, 2020 at 08:25:52PM +0800, WeiXiong Liao wrote:
>> It's one of a series of patches for adaptive to MTD device.
> 
> typo: adapting
> 

Fixed.

>>
>> MTD device is not block device. The sector of flash (MTD device) will be
>> broken if erase over limited cycles. Avoid damaging block so fast, we
>> can not write to a sector frequently. So, the recorders of pstore/blk
>> like console and ftrace recorder should not be supported.
>>
>> Besides, mtd device need aligned write/erase size. To avoid
>> over-erasing/writing flash, we should keep a aligned cache and read old
>> data to cache before write/erase, which make codes more complex. So,
>> pmsg do not be supported now because it writes misaligned.
>>
>> How about dmesg? Luckly, pstore/blk keeps several aligned chunks for
>> dmesg and uses one by one for wear balance.
>>
>> So, MTD device for pstore should pick recorders, that is why the patch
>> here.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> ---
>>  Documentation/admin-guide/pstore-block.rst |  9 +++++++++
>>  fs/pstore/blkoops.c                        | 29 +++++++++++++++++++++--------
>>  include/linux/blkoops.h                    | 14 +++++++++++++-
>>  3 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>> index be865dfc1a28..299142b3d8e6 100644
>> --- a/Documentation/admin-guide/pstore-block.rst
>> +++ b/Documentation/admin-guide/pstore-block.rst
>> @@ -166,6 +166,15 @@ It is only required by block device which is registered by
>>  ``blkoops_register_blkdev``.  It's the major device number of registered
>>  devices, by which blkoops can get the matching driver for @blkdev.
>>  
>> +flags
>> +~~~~~
>> +
>> +Refer to macro starting with *BLKOOPS_DEV_SUPPORT_* which is defined in
>> +*linux/blkoops.h*. They tell us that which pstore/blk recorders this device
>> +supports. Default zero means all recorders for compatible, witch is the same
> 
> typo: witch -> which
> 

Fixed.

>> +as BLKOOPS_DEV_SUPPORT_ALL. Recorder works only when chunk size is not zero
>> +and device support.
> 
> There are already flags for this, please see "Supported frontends"
> in include/linux/pstore.h
> 

yes. You are right. I will change it.

>> +
>>  total_size
>>  ~~~~~~~~~~
>>  
>> diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
>> index c76bab671b0b..01170b344f00 100644
>> --- a/fs/pstore/blkoops.c
>> +++ b/fs/pstore/blkoops.c
>> @@ -128,9 +128,16 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
>>  		return -ENOMEM;
>>  	}
>>  
>> -#define verify_size(name, defsize, alignsize) {				\
>> -		long _##name_ = (name);					\
>> -		if (_##name_ < 0)					\
>> +	/* zero means all recorders for compatible */
>> +	if (bo_dev->flags == BLKOOPS_DEV_SUPPORT_DEFAULT)
>> +		bo_dev->flags = BLKOOPS_DEV_SUPPORT_ALL;
>> +#define verify_size(name, defsize, alignsize, enable) {			\
>> +		long _##name_;						\
>> +		if (!(enable))						\
>> +			_##name_ = 0;					\
>> +		else if ((name) >= 0)					\
>> +			_##name_ = (name);				\
>> +		else							\
>>  			_##name_ = (defsize);				\
>>  		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
>>  		if (_##name_ & ((alignsize) - 1)) {			\
>> @@ -142,10 +149,14 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
>>  		bzinfo->name = _##name_;				\
>>  	}
>>  
>> -	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
>> -	verify_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096);
>> -	verify_size(console_size, DEFAULT_CONSOLE_SIZE, 4096);
>> -	verify_size(ftrace_size, DEFAULT_FTRACE_SIZE, 4096);
>> +	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096,
>> +			bo_dev->flags & BLKOOPS_DEV_SUPPORT_DMESG);
>> +	verify_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096,
>> +			bo_dev->flags & BLKOOPS_DEV_SUPPORT_PMSG);
>> +	verify_size(console_size, DEFAULT_CONSOLE_SIZE, 4096,
>> +			bo_dev->flags & BLKOOPS_DEV_SUPPORT_CONSOLE);
>> +	verify_size(ftrace_size, DEFAULT_FTRACE_SIZE, 4096,
>> +			bo_dev->flags & BLKOOPS_DEV_SUPPORT_FTRACE);
> 
> I'd kind of prefer this patch be moved much earlier in the series so
> that the later additions of front-end support doesn't have to be touched
> twice. i.e. when PMSG support is added, it is added as a whole here and
> does the flag check in that patch, etc.
> 

OK.

>>  #undef verify_size
>>  	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
>>  
>> @@ -336,6 +347,7 @@ static ssize_t blkoops_blk_panic_write(const char *buf, size_t size,
>>   * register block device to blkoops
>>   * @major: the major device number of registering device
>>   * @panic_write: the write interface for panic case.
>> + * @flags: Refer to macro starting with BLKOOPS_DEV_SUPPORT.
>>   *
>>   * It is ONLY used for block device to register to blkoops. In this case,
>>   * the module parameter @blkdev must be valid. Generic read/write interfaces
>> @@ -349,7 +361,7 @@ static ssize_t blkoops_blk_panic_write(const char *buf, size_t size,
>>   * panic occurs but pstore/blk does not recover yet, the first zone of dmesg
>>   * will be used.
>>   */
>> -int blkoops_register_blkdev(unsigned int major,
>> +int blkoops_register_blkdev(unsigned int major, unsigned int flags,
>>  		blkoops_blk_panic_write_op panic_write)
>>  {
>>  	struct block_device *bdev;
>> @@ -372,6 +384,7 @@ int blkoops_register_blkdev(unsigned int major,
>>  	if (bo_dev.total_size == 0)
>>  		goto err_put_bdev;
>>  	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
>> +	bo_dev.flags = flags;
>>  	bo_dev.read = blkoops_generic_blk_read;
>>  	bo_dev.write = blkoops_generic_blk_write;
>>  
>> diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
>> index 71c596fd4cc8..bc7665d14a98 100644
>> --- a/include/linux/blkoops.h
>> +++ b/include/linux/blkoops.h
>> @@ -6,6 +6,7 @@
>>  #include <linux/types.h>
>>  #include <linux/blkdev.h>
>>  #include <linux/pstore_blk.h>
>> +#include <linux/bitops.h>
>>  
>>  /**
>>   * struct blkoops_device - backend blkoops driver structure.
>> @@ -14,6 +15,10 @@
>>   * blkoops_register_device(). If block device, you are strongly recommended
>>   * to use blkoops_register_blkdev().
>>   *
>> + * @flags:
>> + *	Refer to macro starting with BLKOOPS_DEV_SUPPORT_. These macros tell
>> + *	us that which pstore/blk recorders this device supports. Zero means
>> + *	all recorders for compatible.
>>   * @total_size:
>>   *	The total size in bytes pstore/blk can use. It must be greater than
>>   *	4096 and be multiple of 4096.
>> @@ -38,6 +43,13 @@
>>   *	On error, negative number should be returned.
>>   */
>>  struct blkoops_device {
>> +	unsigned int flags;
>> +#define BLKOOPS_DEV_SUPPORT_ALL		UINT_MAX
>> +#define BLKOOPS_DEV_SUPPORT_DEFAULT	(0)
>> +#define BLKOOPS_DEV_SUPPORT_DMESG	BIT(0)
>> +#define BLKOOPS_DEV_SUPPORT_PMSG	BIT(1)
>> +#define BLKOOPS_DEV_SUPPORT_CONSOLE	BIT(2)
>> +#define BLKOOPS_DEV_SUPPORT_FTRACE	BIT(3)
>>  	unsigned long total_size;
>>  	blkz_read_op read;
>>  	blkz_write_op write;
>> @@ -54,7 +66,7 @@ typedef int (*blkoops_blk_panic_write_op)(const char *buf, sector_t start_sect,
>>  
>>  int  blkoops_register_device(struct blkoops_device *bo_dev);
>>  void blkoops_unregister_device(struct blkoops_device *bo_dev);
>> -int  blkoops_register_blkdev(unsigned int major,
>> +int  blkoops_register_blkdev(unsigned int major, unsigned int flags,
>>  		blkoops_blk_panic_write_op panic_write);
>>  void blkoops_unregister_blkdev(unsigned int major);
>>  int  blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
>> -- 
>> 1.9.1
>>
> 

-- 
WeiXiong Liao
