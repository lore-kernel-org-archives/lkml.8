Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA81BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2A0217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgBFNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:10:57 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:57380 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgBFNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:10:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.774386-0.00992849-0.215685;DS=SPAM|spam_ad|0.977435-0.000146245-0.0224188;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07426;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.GlHG0bB_1580994647;
Received: from 192.168.31.126(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GlHG0bB_1580994647)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 06 Feb 2020 21:10:48 +0800
Subject: Re: [PATCH v1 11/11] mtd: new support oops logger based on pstore/blk
To:     Miquel Raynal <mraynal@kernel.org>
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
 <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
 <20200122184114.125b42c8@xps13>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <e135f947-226f-8dd0-b328-fb87c5064914@allwinnertech.com>
Date:   Thu, 6 Feb 2020 21:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122184114.125b42c8@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Miquel Raynal,

On 2020/1/23 AM 1:41, Miquel Raynal wrote:
> Hello,
> 
> 
>>>>>> +/*
>>>>>> + * All zones will be read as pstore/blk will read zone one by one when do
>>>>>> + * recover.
>>>>>> + */
>>>>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
>>>>>> +{
>>>>>> +	struct mtdpstore_context *cxt = &oops_cxt;
>>>>>> +	size_t retlen;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (mtdpstore_block_isbad(cxt, off))
>>>>>> +		return -ENEXT;
>>>>>> +
>>>>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
>>>>>> +	ret = mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
>>>>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size != retlen)  {
>>>>>
>>>>> IIRC size != retlen does not mean it failed, but that you should
>>>>> continue reading after retlen bytes, no?
>>>>>     >>
>>>> Yes, you are right. I will fix it. Thanks.
>>>>   
>>>>> Also, mtd_is_bitflip() does not mean that you are reading a false
>>>>> buffer, but that the data has been corrected as it contained bitflips.
>>>>> mtd_is_eccerr() however, would be meaningful.
>>>>>     >>
>>>> Sure I know mtd_is_bitflip() does not mean failure, but I do not think
>>>> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
>>>> mtd_is_bitflip().
>>>
>>> Yes, just drop this check, only keep ret < 0.
>>>    
>>
>> If I don't get it wrong, it should not	 be dropped here. Like your words,
>> "mtd_is_bitflip() does not mean that you are reading a false buffer,
>> but that the data has been corrected as it contained bitflips.", the
>> data I get are valid even if mtd_is_bitflip() return true. It's correct
>> data and it's no need to go to handle error. To me, the codes
>> should be:
>> 	if (ret < 0 && !mit_is_bitflip())
>> 		[error handling]
> 
> Please check the implementation of mtd_is_bitflip(). You'll probably
> figure out what I am saying.
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/mtd/mtd.h#L585
> 

How about the codes as follows:

for (done = 0, retlen = 0; done < size; done += retlen) {
	ret = mtd_read(..., &retlen, ...);
	if (!ret)
		continue;
	/*
	 * do nothing if bitflip and ecc error occurs because whether
	 * it's bitflip or ECC error, just a small number of bits flip
	 * and the impact on log data is so small. The mtdpstore just
	 * hands over what it gets and user can judge whether the data
	 * is valid or not.
	 */
	if (mtd_is_bitflip(ret)) {
		dev_warn("bitflip at....");
		continue;
	} else if (mtd_is_eccerr(ret)) {
		dev_warn("eccerr at....");
		retlen = retlen == 0 ? size : retlen;
		continue;
	} else {
		dev_err("read failure at...");
		/* this zone is broken, try next one */
		return -ENEXT;
	}
}

> 
> |...]
> 
>>>>>> +		return;
>>>>>> +	}
>>>>>> +	if (unlikely(info->dmesg_size % mtd->writesize)) {
>>>>>> +		pr_err("record size %lu KB must align to write size %d KB\n",
>>>>>> +				info->dmesg_size / 1024,
>>>>>> +				mtd->writesize / 1024);
>>>>>
>>>>> This condition is weird, why would you check this?
>>>>>     >>
>>>> pstore/blk will write 'record_size' dmesg log at one time.
>>>> Since each write data must be aligned to 'writesize' for flash, I am not
>>>> sure
>>>> all flash drivers are compatible with misaligned data, that's why i
>>>> check this.
>>>
>>> I think you should enforce this alignment instead of checking it.
>>>    
>>
>> Do you mean that mtdpstore should enforce this alignment while running?
>> The way I can think of is to handle a buffer aligned to writesize and
>> write to flash with this aligned buffer.
>>
>> That causes some error. The MTD device will be divided into mutil
>> chunks accroding to dmesg_size. Each chunk stores a individual
>> OOPS/Panic log. If dmesg_size is misaligned to writesize, the last
>> write results in next write failure because the page of flash can only
>> be programed once before next erase and the page shared by two chunks
>> has been used by the last write. Besides, we can not read to buffer,
>> ersae and write back as there is no read/erase for panic case.
> 
> I mean: what is the usual size of dmesg? I don't get why you need it to

The usual size of dmesg is 64K, usually be equal to log_buf size.

> be ie. a multiple of 2k. It probably is actually, I don't know if there
> is a standard. But if dmesg_size is eg 3k, just skip the end of the
> partially written page and start writing at the next page?
> 

1. upper layer do not support to skip partially written page
The upper layer pstore/blk will not skip the end of the partially
written page since it is not only used for MTD device, but also
block device, which has no page limited. A common practice at the
upper layer is to check the size and limit size to be aligned. We
make dmesg_size to be a multiple of 4K for greater compatibility.

2. chunks management and size per write
The mtdpstore tells pstore/blk how large the device is. Then
pstore/blk will divide it into several chunks according to
dmesg_size. The pstore/blk will write dmesg_size data at a time.

In a word, the amount of data written each time can not lead to page
slicing, so, dmesg_size must be aligned to writesize.

>>
>>>>   
>>>>>> +		return;
>>>>>> +	}
>>>>>> +	if (unlikely(mtd->size > MTDPSTORE_MAX_MTD_SIZE)) {
>>>>>> +		pr_err("mtd%d is too large (limit is %d MiB)\n",
>>>>>> +				mtd->index,
>>>>>> +				MTDPSTORE_MAX_MTD_SIZE / 1024 / 1024);
>>>>>
>>>>> Same question? I could understand that it is easier to manage blocks
>>>>> knowing their maximum number though.
>>>>>     >>
>>>> It refers to mtdoops.
>>>
>>> What do you mean?
>>>    
>>
>> To me, it's unnecessary to check at all, however it is really there
>> on codes of mtdoops. I refer to module mtdoops when I design mtdpstore.
>> It may be helpfull for some cases out of my think, that's why I keep it.
> 
> Why not.
> 

OK, I will drop it.

> [...]
> 
>>>>
>>>> In case of repeated erase when users remove several log files, mtdpstore
>>>> do remove jobs when exit.
>>>>
>>>> Besides, mtdpstore do not check the return code to ensure write back valid
>>>> log as much as possible.
>>>
>>> You are not in a critical path, I don't understand why you don't check
>>> it? If it returns an error, it means the data is not written. IMHO it
>>> is best to alert the user than to silently fail.
>>>    
>>
>> This function will be called only when mtd device is removing. It's
>> useless to alert the user but try to flush the other valid data to
> 
> It is useful to alert the user! It means something went wrong while
> everything seems fine.
> 
>> flash as mush as possible by which reduce losses. If it's just
>> because of busy, what happens next time?
> 
> Just because of busy? I don't get it.

I want to express that if the write fails due to busy, the next one
may succeed.

> 
> I'm okay with the idea of trying to write the other chunks though:
> 
> 	while (remaining_chunk) {
> 		ret = mtd_write()
> 		if (ret) {
> 			alert-user;
> 			continue;
> 		}
> 	}
> 

OK, I will fix it.

>>
>>>>   
>>>>>> +. >>>> +		off += zonesize;
>>>>>> +		size -= min_t(unsigned int, zonesize, size);
>>>>>> +	}
>>>>>> +
>>>>>> +free:
>>>>>> +	kfree(buf);
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>
>>>
>>> [...]
>>>    
>>>>>
>>>>> Thanks,
>>>>> Miquèl
>>>>>     >>
>>>> I will collect more suggestions and submit the new version at one time.
>>>>   
>>>
>>> Sure, no hurry.
>>>    
>>
>> I am on holiday, please forgive me for my slow response.
> 
> Take your time, as I said, no hurry.
> 
>>
>>>
>>> Thanks,
>>> Miquèl
>>>    
> 
> 
> 
> 
> Thanks,
> Miquèl
> 
