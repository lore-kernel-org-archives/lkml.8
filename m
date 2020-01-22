Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8DC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491932465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:23:02 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33298 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgAVRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:23:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.747911-0.00840901-0.24368;DS=SPAM|spam_education_ad|0.90854-0.000331589-0.0911281;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03279;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.GgH4S0P_1579713773;
Received: from 192.168.43.221(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GgH4S0P_1579713773)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 23 Jan 2020 01:22:54 +0800
Subject: Re: [PATCH v1 11/11] mtd: new support oops logger based on pstore/blk
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
 <20200120110306.32e53fd8@xps13>
 <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
 <20200121094802.61f8cb4d@xps13>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
Date:   Thu, 23 Jan 2020 01:22:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121094802.61f8cb4d@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Miquel Raynal,

On 2020/1/21 4:48 PM, Miquel Raynal wrote:
> Hello,
> 
> liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Tue, 21 Jan 2020
> 11:36:00 +0800:
> 
>> hi Miquel Raynal,
>>
>> On 2020/1/20 PM 6:03, Miquel Raynal wrote:
>>> Hi WeiXiong,
>>>
>>> WeiXiong Liao <liaoweixiong@allwinnertech.com> wrote on Mon, 20 Jan
>>> 2020 09:03:53 +0800:
>>>    
>>>> It's the last one of a series of patches for adaptive to MTD device.
>>>>
>>>> The mtdpstore is similar to mtdoops but more powerful. It bases on
>>>> pstore/blk, aims to store panic and oops log to a flash partition,
>>>
>>>                                             logs?
>>>    
>>
>> I will fix it. Thanks.
>>
>>>> where it can be read back as files after mounting pstore filesystem.
>>>>
>>>> The pstore/blk and blkoops, a wrapper for pstore/blk, are designed for
>>>> block device at the very beginning, but now, compatible to not only
>>>> block device. After this series of patches, pstore/blk can also work
>>>> for MTD device. To make it work, 'blkdev' on kconfig or module
>>>> parameter of blkoops should be set as mtd device name or mtd number.
>>>> See more about pstore/blk and blkoops on:
>>>>      Documentation/admin-guide/pstore-block.rst
>>>>
>>>> Why do we need mtdpstore?
>>>> 1. repetitive jobs between pstore and mtdoops
>>>>     Both of pstore and mtdoops do the same jobs that store panic/oops log.
>>>>     They have much similar logic that register to kmsg dumper and store
>>>>     log to several chunks one by one.
>>>> 2. do what a driver should do
>>>>     To me, a driver should provide methods instead of policies. What MTD
>>>>     should do is to provide read/write/erase operations, geting rid of codes
>>>>     about chunk management, kmsg dumper and configuration.
>>>> 3. enhanced feature
>>>>     Not only store log, but also show it as files.
>>>>     Not only log, but also trigger time and trigger count.
>>>>     Not only panic/oops log, but also log recorder for pmsg, console and
>>>>     ftrace in the future.
>>>>
>>>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> I don't thing the test robot has a meaning here.
>>>    
>>
>> I do not know what meaning the test rebot tag has, but i was suggested
>> from kbuild test rebot to do so. How should i do to it ? Drop the tag or
>> keep the tag or other?
>> The email from kbuild test rebot said that:
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> You probably pushed your work on a dedicated repository on which this
> robot has run. It does not make any difference between upstream sources
> and downstream contributions. You may add this tag when you are
> fixing something reported by the robot against the upstream kernel.
> Here, the driver is new, this is a feature you are adding, so please
> drop the tag.
> 

OK. I will fix it later. Thank you.

> [...]
> 
>>>> +/*
>>>> + * All zones will be read as pstore/blk will read zone one by one when do
>>>> + * recover.
>>>> + */
>>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
>>>> +{
>>>> +	struct mtdpstore_context *cxt = &oops_cxt;
>>>> +	size_t retlen;
>>>> +	int ret;
>>>> +
>>>> +	if (mtdpstore_block_isbad(cxt, off))
>>>> +		return -ENEXT;
>>>> +
>>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
>>>> +	ret = mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
>>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size != retlen)  {
>>>
>>> IIRC size != retlen does not mean it failed, but that you should
>>> continue reading after retlen bytes, no?
>>>    
>>
>> Yes, you are right. I will fix it. Thanks.
>>
>>> Also, mtd_is_bitflip() does not mean that you are reading a false
>>> buffer, but that the data has been corrected as it contained bitflips.
>>> mtd_is_eccerr() however, would be meaningful.
>>>    
>>
>> Sure I know mtd_is_bitflip() does not mean failure, but I do not think
>> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
>> mtd_is_bitflip().
> 
> Yes, just drop this check, only keep ret < 0.
> 

If I don't get it wrong, it should not	 be dropped here. Like your words,
"mtd_is_bitflip() does not mean that you are reading a false buffer,
but that the data has been corrected as it contained bitflips.", the
data I get are valid even if mtd_is_bitflip() return true. It's correct
data and it's no need to go to handle error. To me, the codes
should be:
	if (ret < 0 && !mit_is_bitflip())
		[error handling]

>>
>>>> +		pr_err("read failure at %lld (%zu of %zu read), err %d\n",
>>>> +				off, retlen, size, ret);
>>>> +		return -EIO;
>>>> +	}
>>>> +
>>>> +	if (mtdpstore_is_empty(cxt, buf, size))
>>>> +		mtdpstore_mark_unused(cxt, off);
>>>> +	else
>>>> +		mtdpstore_mark_used(cxt, off);
>>>> +
>>>> +	mtdpstore_security(cxt, off);
>>>> +	return retlen;
>>>> +}
>>>> +
>>>> +static ssize_t mtdpstore_panic_write(const char *buf, size_t size, loff_t off)
>>>> +{
>>>> +	struct mtdpstore_context *cxt = &oops_cxt;
>>>> +	size_t retlen;
>>>> +	int ret;
>>>> +
>>>> +	if (mtdpstore_panic_block_isbad(cxt, off))
>>>> +		return -ENEXT;
>>>> +
>>>> +	/* zone is used, please try next one */
>>>> +	if (mtdpstore_is_used(cxt, off))
>>>> +		return -ENEXT;
>>>> +
>>>> +	ret = mtd_panic_write(cxt->mtd, off, size, &retlen, (u_char *)buf);
>>>> +	if (ret < 0 || size != retlen) {
>>>> +		pr_err("panic write failure at %lld (%zu of %zu read), err %d\n",
>>>> +				off, retlen, size, ret);
>>>> +		return -EIO;
>>>> +	}
>>>> +	mtdpstore_mark_used(cxt, off);
>>>> +
>>>> +	return retlen;
>>>> +}
>>>> +
>>>> +static void mtdpstore_notify_add(struct mtd_info *mtd)
>>>> +{
>>>> +	int ret;
>>>> +	struct mtdpstore_context *cxt = &oops_cxt;
>>>> +	struct blkoops_info *info = &cxt->bo_info;
>>>> +	unsigned long longcnt;
>>>> +
>>>> +	if (!strcmp(mtd->name, info->device))
>>>> +		cxt->index = mtd->index;
>>>> +
>>>> +	if (mtd->index != cxt->index || cxt->index < 0)
>>>> +		return;
>>>> +
>>>> +	pr_debug("found matching MTD device %s\n", mtd->name);
>>>> +
>>>> +	if (mtd->size < info->dmesg_size * 2) {
>>>> +		pr_err("MTD partition %d not big enough\n", mtd->index);
>>>> +		return;
>>>> +	}
>>>> +	if (mtd->erasesize < info->dmesg_size) {
>>>> +		pr_err("eraseblock size of MTD partition %d too small\n",
>>>> +				mtd->index);
>>>
>>> What is the usual size of dmesg? Could this check be too limiting?
>>>    
>>
>> The size must be aligned to 4096, which is limited by blkoops. The
>> default value is 64K. If it is larger than erasesize, some errors will occur
>> since mtdpstore is designed on it.
> 
> Please add a comment with the above explanation.
> 

OK, I will do it later. Thank you.

>>
>>>> +		return;
>>>> +	}
>>>> +	if (unlikely(info->dmesg_size % mtd->writesize)) {
>>>> +		pr_err("record size %lu KB must align to write size %d KB\n",
>>>> +				info->dmesg_size / 1024,
>>>> +				mtd->writesize / 1024);
>>>
>>> This condition is weird, why would you check this?
>>>    
>>
>> pstore/blk will write 'record_size' dmesg log at one time.
>> Since each write data must be aligned to 'writesize' for flash, I am not
>> sure
>> all flash drivers are compatible with misaligned data, that's why i
>> check this.
> 
> I think you should enforce this alignment instead of checking it.
> 

Do you mean that mtdpstore should enforce this alignment while running?
The way I can think of is to handle a buffer aligned to writesize and
write to flash with this aligned buffer.

That causes some error. The MTD device will be divided into mutil
chunks accroding to dmesg_size. Each chunk stores a individual
OOPS/Panic log. If dmesg_size is misaligned to writesize, the last
write results in next write failure because the page of flash can only
be programed once before next erase and the page shared by two chunks
has been used by the last write. Besides, we can not read to buffer,
ersae and write back as there is no read/erase for panic case.

>>
>>>> +		return;
>>>> +	}
>>>> +	if (unlikely(mtd->size > MTDPSTORE_MAX_MTD_SIZE)) {
>>>> +		pr_err("mtd%d is too large (limit is %d MiB)\n",
>>>> +				mtd->index,
>>>> +				MTDPSTORE_MAX_MTD_SIZE / 1024 / 1024);
>>>
>>> Same question? I could understand that it is easier to manage blocks
>>> knowing their maximum number though.
>>>    
>>
>> It refers to mtdoops.
> 
> What do you mean?
> 

To me, it's unnecessary to check at all, however it is really there
on codes of mtdoops. I refer to module mtdoops when I design mtdpstore.
It may be helpfull for some cases out of my think, that's why I keep it.

>>
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->dmesg_size));
>>>> +	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>>> +	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>>> +
>>>> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>>>> +	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>>> +
>>>> +	cxt->bo_dev.total_size = mtd->size;
>>>> +	/* just support dmesg right now */
>>>> +	cxt->bo_dev.flags = BLKOOPS_DEV_SUPPORT_DMESG;
>>>> +	cxt->bo_dev.read = mtdpstore_read;
>>>> +	cxt->bo_dev.write = mtdpstore_write;
>>>> +	cxt->bo_dev.erase = mtdpstore_erase;
>>>> +	cxt->bo_dev.panic_write = mtdpstore_panic_write;
>>>> +
>>>> +	ret = blkoops_register_device(&cxt->bo_dev);
>>>> +	if (ret) {
>>>> +		pr_err("mtd%d register to blkoops failed\n", mtd->index);
>>>> +		return;
>>>> +	}
>>>> +	cxt->mtd = mtd;
>>>> +	pr_info("Attached to MTD device %d\n", mtd->index);
>>>> +}
>>>> +
>>>> +static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,
>>>> +		loff_t off, size_t size)
>>>> +{
>>>> +	struct mtd_info *mtd = cxt->mtd;
>>>> +	u_char *buf;
>>>> +	int ret;
>>>> +	size_t retlen;
>>>> +	struct erase_info erase;
>>>> +
>>>> +	buf = kmalloc(mtd->erasesize, GFP_KERNEL);
>>>> +	if (!buf)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	/* 1st. read to cache */
>>>> +	ret = mtd_read(mtd, off, mtd->erasesize, &retlen, buf);
>>>> +	if (ret || retlen != mtd->erasesize)
>>>> +		goto free;
>>>> +
>>>> +	/* 2nd. erase block */
>>>> +	erase.len = mtd->erasesize;
>>>> +	erase.addr = off;
>>>> +	ret = mtd_erase(mtd, &erase);
>>>> +	if (ret)
>>>> +		goto free;
>>>> +
>>>> +	/* 3rd. write back */
>>>> +	while (size) {
>>>> +		unsigned int zonesize = cxt->bo_info.dmesg_size;
>>>> +
>>>> +		/* remove must clear used bit */
>>>> +		if (mtdpstore_is_used(cxt, off))
>>>> +			mtd_write(mtd, off, zonesize, &retlen, buf);
>>>
>>> Besides the fact that should definitely check the write return code, I
>>> don't understand what you do in this function. What does
>>> flush_removed_do mean?
>>>    
>>
>> When user remove one log file on pstore filesystem, mtdpstore should do
>> something to ensure log file removed. If the whole block is no longer used,
>> it is nice to erase the block. However, if the block still contains
>> valid log,
>> what mtdpstore can do is to erase and write the valid log back.
>> That is what flush_removed_do() do.
> 
> Please explain with a comment.
> 

OK, I will do it later. Thank you.

>>
>> In case of repeated erase when users remove several log files, mtdpstore
>> do remove jobs when exit.
>>
>> Besides, mtdpstore do not check the return code to ensure write back valid
>> log as much as possible.
> 
> You are not in a critical path, I don't understand why you don't check
> it? If it returns an error, it means the data is not written. IMHO it
> is best to alert the user than to silently fail.
> 

This function will be called only when mtd device is removing. It's
useless to alert the user but try to flush the other valid data to
flash as mush as possible by which reduce losses. If it's just
because of busy, what happens next time?

>>
>>>> +. 
>>>> +		off += zonesize;
>>>> +		size -= min_t(unsigned int, zonesize, size);
>>>> +	}
>>>> +
>>>> +free:
>>>> +	kfree(buf);
>>>> +	return ret;
>>>> +}
>>>> +
> 
> 
> [...]
> 
>>>
>>> Thanks,
>>> Miquèl
>>>    
>>
>> I will collect more suggestions and submit the new version at one time.
>>
> 
> Sure, no hurry.
> 

I am on holiday, please forgive me for my slow response.

> 
> Thanks,
> Miquèl
> 
