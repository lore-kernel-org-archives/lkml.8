Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B8FC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F702082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGKaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:30:46 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41971 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgBGKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:30:46 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436287|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.126263-0.0024786-0.871258;DS=CONTINUE|ham_regular_dialog|0.0595875-0.00190005-0.938512;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03279;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.GlYZUym_1581071437;
Received: from 192.168.31.126(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GlYZUym_1581071437)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 07 Feb 2020 18:30:38 +0800
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
 <e135f947-226f-8dd0-b328-fb87c5064914@allwinnertech.com>
 <20200206164559.59c5eb6a@xps13>
 <6a1b50f4-320f-43d1-50e3-b0a2c3c7fb96@allwinnertech.com>
 <20200207094121.0ad702d0@xps13>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <05c21cb6-988b-63a7-60ff-c4e975f25817@allwinnertech.com>
Date:   Fri, 7 Feb 2020 18:30:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207094121.0ad702d0@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Miquel Raynal,

On 2020/2/7 下午4:41, Miquel Raynal wrote:
> Hi Liao,
> 
> liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Fri, 7 Feb 2020
> 12:13:08 +0800:
> 
>> hi Miquel Raynal,
>>
>> On 2020/2/6 PM 11:45, Miquel Raynal wrote:
>>> Hi liao,
>>>
>>> liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Thu, 6 Feb 2020
>>> 21:10:47 +0800:
>>>    
>>>> hi Miquel Raynal,
>>>>
>>>> On 2020/1/23 AM 1:41, Miquel Raynal wrote:
>>>>> Hello,
>>>>>   
>>>>>     >>>>>>>> +/*
>>>>>>>>>> + * All zones will be read as pstore/blk will read zone one by one when do
>>>>>>>>>> + * recover.
>>>>>>>>>> + */
>>>>>>>>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
>>>>>>>>>> +{
>>>>>>>>>> +	struct mtdpstore_context *cxt = &oops_cxt;
>>>>>>>>>> +	size_t retlen;
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	if (mtdpstore_block_isbad(cxt, off))
>>>>>>>>>> +		return -ENEXT;
>>>>>>>>>> +
>>>>>>>>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
>>>>>>>>>> +	ret = mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
>>>>>>>>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size != retlen)  {
>>>>>>>>>
>>>>>>>>> IIRC size != retlen does not mean it failed, but that you should
>>>>>>>>> continue reading after retlen bytes, no?
>>>>>>>>>       >>
>>>>>>>> Yes, you are right. I will fix it. Thanks.
>>>>>>>>     >>>>> Also, mtd_is_bitflip() does not mean that you are reading a false
>>>>>>>>> buffer, but that the data has been corrected as it contained bitflips.
>>>>>>>>> mtd_is_eccerr() however, would be meaningful.
>>>>>>>>>       >>
>>>>>>>> Sure I know mtd_is_bitflip() does not mean failure, but I do not think
>>>>>>>> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
>>>>>>>> mtd_is_bitflip().
>>>>>>>
>>>>>>> Yes, just drop this check, only keep ret < 0.
>>>>>>>      >>
>>>>>> If I don't get it wrong, it should not	 be dropped here. Like your words,
>>>>>> "mtd_is_bitflip() does not mean that you are reading a false buffer,
>>>>>> but that the data has been corrected as it contained bitflips.", the
>>>>>> data I get are valid even if mtd_is_bitflip() return true. It's correct
>>>>>> data and it's no need to go to handle error. To me, the codes
>>>>>> should be:
>>>>>> 	if (ret < 0 && !mit_is_bitflip())
>>>>>> 		[error handling]
>>>>>
>>>>> Please check the implementation of mtd_is_bitflip(). You'll probably
>>>>> figure out what I am saying.
>>>>>
>>>>> https://elixir.bootlin.com/linux/latest/source/include/linux/mtd/mtd.h#L585
>>>>>     >>
>>>> How about the codes as follows:
>>>>
>>>> for (done = 0, retlen = 0; done < size; done += retlen) {
>>>> 	ret = mtd_read(..., &retlen, ...);
>>>> 	if (!ret)
>>>> 		continue;
>>>> 	/*
>>>> 	 * do nothing if bitflip and ecc error occurs because whether
>>>> 	 * it's bitflip or ECC error, just a small number of bits flip
>>>> 	 * and the impact on log data is so small. The mtdpstore just
>>>> 	 * hands over what it gets and user can judge whether the data
>>>> 	 * is valid or not.
>>>> 	 */
>>>> 	if (mtd_is_bitflip(ret)) {
>>>> 		dev_warn("bitflip at....");
>>>> 		continue;
>>
>>> I don't understand why do you check for bitflips. Bitflips have been
>>> corrected at this stage, you just get the information that there
>>> has been bitflips, but the data integrity is fine.
>>>    
>>
>> Both of bitflip and eccerror are not real wrong in this
>> case. So we must check them.
>>
>>> I am not against ignoring ECC errors in this case though. I would
>>> propose:
>>>
>>> 	for (...) {
>>> 		if (ret < 0) {
>>> 			complain;
>>> 			return;
>>> 		}
>>>    
>>
>> -117 (-EUCLEAN) means bitflip but be corrected.
>> -74 (-EBADMSG) means ecc error that uncorrectable
>> All of them are negative number that smaller than 0. If it just keeps
>> "ret < 0", it can never make a difference between bitflip/eccerror
>> and others.
> 
> I forgot about these, your're right, so what about:
> 
> 	static bool mtdpstore_is_io_error(int ret)
> 	{
> 		return ret < 0 && !mtd_is_eccerr(ret)> && !mtd_is_bitflip(ret);
> 	}
> 
> 	for (...) {
> 		if (mtdpstore_is_io_error(ret))
> 			return ret;
> 
> 		/*
> 		 * Comment explaining why we still return valid data
> 		 * despite ECC errors.
> 		 */
> 		if (mtd_is_eccerr(ret))
> 			just-complain();
> 	}
> 
> This snippet makes a difference between any "controller/bus
> timeout/error : data could not be retrieved" and "ECC error, maybe we
> can still read it and try to understand (risky, must be warned)".
> 

That seems good to me. I will fix it later.
Thanks for your review.

>>
>>> 		if (mtd_is_eccerr())
>>> 			complain;
>>> 	}
>>> 		
>>>> 	} else if (mtd_is_eccerr(ret)) {
>>>> 		dev_warn("eccerr at....");
>>>> 		retlen = retlen == 0 ? size : retlen;
>>>> 		continue;
>>>> 	} else {
>>>> 		dev_err("read failure at...");
>>>> 		/* this zone is broken, try next one */
>>>> 		return -ENEXT;
>>>> 	}
>>>> }
>>>>   
>>>
>>>
>>> Thanks,
>>> Miquèl
>>>    
> 
> Thanks,
> Miquèl
> 
