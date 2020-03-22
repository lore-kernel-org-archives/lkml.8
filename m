Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84A5C54FCE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82882072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCVK2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:28:49 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:53744 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgCVK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 06:28:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438739|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.185973-0.000472118-0.813555;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H3OteXN_1584872892;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H3OteXN_1584872892)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 22 Mar 2020 18:28:13 +0800
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
 <dab67ab1-c03f-0507-3d56-4a9578e85f6b@allwinnertech.com>
 <202003201111.BE5EAB9A@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <c49f1d24-b818-aeda-7447-b89d8eddb1c6@allwinnertech.com>
Date:   Sun, 22 Mar 2020 18:28:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003201111.BE5EAB9A@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/3/21 上午2:20, Kees Cook wrote:
> On Fri, Mar 20, 2020 at 09:50:36AM +0800, WeiXiong Liao wrote:
>> On 2020/3/19 AM 1:23, Kees Cook wrote:
>>> On Thu, Feb 27, 2020 at 04:21:51PM +0800, liaoweixiong wrote:
>>>> On 2020/2/26 AM 8:52, Kees Cook wrote:
>>>>> On Fri, Feb 07, 2020 at 08:25:45PM +0800, WeiXiong Liao wrote:
>>>>>> +obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
>>>>>> +pstore_blk-y += blkzone.o
>>>>>
>>>>> Why this dance with files? I would just expect:
>>>>>
>>>>> obj-$(CONFIG_PSTORE_BLK)     += blkzone.o
>>>>>
>>>>
>>>> This makes the built module named blkzone.ko rather than
>>>> pstore_blk.ko.
>>>
>>> You can just do a regular build rule:
>>>
>>> obj-$(CONFIG_PSTORE_BLK) += blkzone.o
>>>
>>
>> I don't get it. If make it as your words, the built module will be
>> blkzone.ko.
>> The module is named pstore/blk, however it built out blkzone.ko. I think
>> it's confusing.
> 
> I mean just pick whatever filename you want it to be named. The Makefile
> case for ramoops was that ramoops got renamed but we wanted to keep the
> old API name.
> 
> So, if you want it named pstore-blk.ko, just rename blkzone.c to
> pstore-blk.c.
> 

How about rename blkzone.c to psotre_zone.c and blkoops.c to pstore_blk.c?

Please refer to my reply email for patch 2.

>>>>> If you're expecting concurrent writers (use of atomic_set(), I would
>>>>> expect the whole write to be locked instead. (i.e. what happens if
>>>>> multiple callers call blkz_zone_write()?)
>>>>>
>>>>
>>>> I don't agree with it. The datalen will be updated everywhere. It's useless
>>>> to lock here.
>>>
>>> But there could be multiple writers; locking should be needed.
>>>
>>
>> All the recorders such as dmesg, pmsg, console and ftrace have been
>> locked on
>> pstore and upper layers. So, a recorder will not write in parallel and
>> different
>> recorders operate privately zone. They don't have any influence on each
>> other.
> 
> Yes, sorry, I was confusing myself about pmsg, and I forgot it had a
> global lock. Each are locked or split by CPU.
> 
>> The only parallel case I think is that recorder writes while dirty-flush
>> thread is
>> working. And the dirty-flusher will flush the whole zone rather than
>> part of it, so,
>> it is OK to call in parallel.
> 
> Okay, thanks for clarifying.
> 
>> Based on these reasons, I don't think locking should be needed.
> 
> Agreed.
> 

-- 
WeiXiong Liao
