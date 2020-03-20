Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15667C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F5820754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCTBui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:38 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:45590 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727411AbgCTBui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.0186957-0.00101085-0.980293;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16370;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H2GhozF_1584669031;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H2GhozF_1584669031)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 20 Mar 2020 09:50:32 +0800
Subject: Re: [PATCH v2 01/11] pstore/blk: new support logger for block devices
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
 <1581078355-19647-2-git-send-email-liaoweixiong@allwinnertech.com>
 <202002251626.63FE3E7C6@keescook>
 <5fd540be-6ed9-a1c7-4932-e67194dddca8@allwinnertech.com>
 <202003180944.3B36871@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <dab67ab1-c03f-0507-3d56-4a9578e85f6b@allwinnertech.com>
Date:   Fri, 20 Mar 2020 09:50:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003180944.3B36871@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees Cook,

On 2020/3/19 AM 1:23, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 04:21:51PM +0800, liaoweixiong wrote:
>> On 2020/2/26 AM 8:52, Kees Cook wrote:
>>> On Fri, Feb 07, 2020 at 08:25:45PM +0800, WeiXiong Liao wrote:
>>>> +obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
>>>> +pstore_blk-y += blkzone.o
>>>
>>> Why this dance with files? I would just expect:
>>>
>>> obj-$(CONFIG_PSTORE_BLK)     += blkzone.o
>>>
>>
>> This makes the built module named blkzone.ko rather than
>> pstore_blk.ko.
> 
> You can just do a regular build rule:
> 
> obj-$(CONFIG_PSTORE_BLK) += blkzone.o
> 

I don't get it. If make it as your words, the built module will be
blkzone.ko.
The module is named pstore/blk, however it built out blkzone.ko. I think
it's
confusing.

>>>> +#define BLK_SIG (0x43474244) /* DBGC */
>>>
>>> I was going to suggest extracting PERSISTENT_RAM_SIG, renaming it and
>>> using it in here and in ram_core.c, but then I realize they're not
>>> marking the same structure. How about choosing a new magic sig for the
>>> blkzone data header?
>>>
>>
>> That's OK to me. I don't know if there is a rule to get a new magic?
>> In addition, all members of this structure are the same as
>> struct persistent_ram_buffer after patch 2. Maybe it's a good idea to
>> extract it
>> if you want to merge ramoops and pstore/blk.
> 
> Okay, let's leave it as-is for now.
> 
>>>> +	uint32_t sig;
>>>> +	atomic_t datalen;
>>>> +	uint8_t data[];
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct blkz_dmesg_header: dmesg information
>>>
>>> This is the on-disk structure also?
>>>
>> Yes. The structure blkz_buffer is a generic header for all recorder
>> zone, and the
>> structure blkz_dmesg_header is a header for dmesg, saved in
>> blkz_buffer->data.
>> The dmesg recorder use it to save it's specific attributes.
> 
> Okay, can you add comments to distinguish the on-disk structures from
> the in-memory, etc?
> 

Sure. I will do it.

>>>> +#define DMESG_HEADER_MAGIC 0x4dfc3ae5
>>>
>>> How was this magic chosen?
>>
>> It's a random number. Maybe should I chose a meaningful magic?
> 
> That's fine; just add a comment to say so.
> 

OK.

>>>> + * @dirty:
>>>> + *	mark whether the data in @buffer are dirty (not flush to storage yet)
>>>> + */
>>>
>>> Thank you for the kerndoc! :) Is it linked to from any .rst files?
>>>
>>
>> I don't get your words. There is a document on the 6th patch. I don't know
>> whether it is what you want?
> 
> Patch 6 is excellent; I think you might want to add references back to
> these kern-doc structures using the ".. kernel-doc::
> fs/pstore/blkzone.c" syntax:
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#including-kernel-doc-comments
> 

Wow! I marvel at kernel-doc. Your link has helped me a lot.

I will optimize all my comment and document later.

>>>> +static int blkz_zone_write(struct blkz_zone *zone,
>>>> +		enum blkz_flush_mode flush_mode, const char *buf,
>>>> +		size_t len, unsigned long off)
>>>> +{
>>>> +	struct blkz_info *info = blkz_cxt.bzinfo;
>>>> +	ssize_t wcnt = 0;
>>>> +	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
>>>> +	size_t wlen;
>>>> +
>>>> +	if (off > zone->buffer_size)
>>>> +		return -EINVAL;
>>>> +	wlen = min_t(size_t, len, zone->buffer_size - off);
>>>> +	if (buf && wlen) {
>>>> +		memcpy(zone->buffer->data + off, buf, wlen);
>>>> +		atomic_set(&zone->buffer->datalen, wlen + off);
>>>> +	}
>>>
>>> If you're expecting concurrent writers (use of atomic_set(), I would
>>> expect the whole write to be locked instead. (i.e. what happens if
>>> multiple callers call blkz_zone_write()?)
>>>
>>
>> I don't agree with it. The datalen will be updated everywhere. It's useless
>> to lock here.
> 
> But there could be multiple writers; locking should be needed.
> 

All the recorders such as dmesg, pmsg, console and ftrace have been
locked on
pstore and upper layers. So, a recorder will not write in parallel and
different
recorders operate privately zone. They don't have any influence on each
other.

The only parallel case I think is that recorder writes while dirty-flush
thread is
working. And the dirty-flusher will flush the whole zone rather than
part of it, so,
it is OK to call in parallel.

Based on these reasons, I don't think locking should be needed.

>> One more things. During the analysis, I found another problem.
>> Removing old files will cause new logs to be lost. Take console recorder as
>> am example. After new rebooting, new logs are saved to buf while old
>> logs are
>> saved to old_buf. If we remove old file at that time, not only old_buf
>> is freed, but
>> also length of buf for new data is reset to zero. The ramoops may also
>> has this
>> problem.
> 
> Hmm. I'll need to double-check this. It's possible the call to
> persistent_ram_zap() in ramoops_pstore_erase() is not needed.
> 
>>>> +static int blkz_recover_dmesg_data(struct blkz_context *cxt)
>>>
>>> What does "recover" mean in this context? Is this "read from storage"?
>>
>> Yes. "recover" means reading data back from storage.
> 
> Okay. Please add some comments here. I would think of it more as "read"
> or "load". When I think of "recover" I think of "finding something that
> was lost". But the name isn't important as long as there is a comment
> somewhere about what it's doing.
> 

OK. I will add some comments on entry function blkz_recovery()。

> -Kees
> 

-- 
WeiXiong Liao
