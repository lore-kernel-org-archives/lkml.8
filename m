Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB131C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F71E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAUITg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:19:36 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:57398 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:19:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07455563|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.222157-0.0182336-0.75961;DS=CONTINUE|ham_system_inform|0.0500038-0.00267614-0.94732;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03297;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gff7Z1N_1579594766;
Received: from 192.168.31.122(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gff7Z1N_1579594766)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 21 Jan 2020 16:19:27 +0800
Subject: Re: [PATCH v1 06/11] Documentation: pstore/blk: blkoops: create
 document for pstore_blk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1579482233-2672-7-git-send-email-liaoweixiong@allwinnertech.com>
 <b9cd734b-8bb1-5e26-a7ed-fbc79ab2d958@infradead.org>
 <c87bdf3a-f129-a2a7-40b2-2220f79b505a@allwinnertech.com>
 <40d7f57a-119e-e51f-99a5-63e85ab5ab91@infradead.org>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <3337f687-a668-c058-178b-a1438641c519@allwinnertech.com>
Date:   Tue, 21 Jan 2020 16:19:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <40d7f57a-119e-e51f-99a5-63e85ab5ab91@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Randy Dunlap,

On 2020/1/21 2:36 PM, Randy Dunlap wrote:
> On 1/20/20 9:23 PM, liaoweixiong wrote:
>> hi Randy Dunlap,
>>
>> On 2020/1/21 PM12:13, Randy Dunlap wrote:
>>> Hi,
>>>
>>> I have some documentation comments for you:
>>>
>>>
>>> On 1/19/20 5:03 PM, WeiXiong Liao wrote:
>>>> The document, at Documentation/admin-guide/pstore-block.rst, tells us
>>>> how to use pstore/blk and blkoops.
>>>>
>>>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>>>> ---
>>>>   Documentation/admin-guide/pstore-block.rst | 278 +++++++++++++++++++++++++++++
>>>>   MAINTAINERS                                |   1 +
>>>>   fs/pstore/Kconfig                          |   2 +
>>>>   3 files changed, 281 insertions(+)
>>>>   create mode 100644 Documentation/admin-guide/pstore-block.rst
>>>>
>>>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>>>> new file mode 100644
>>>> index 000000000000..58418d429c55
>>>> --- /dev/null
>>>> +++ b/Documentation/admin-guide/pstore-block.rst
>>>> +
>>>> +
>>>> +dmesg_size
>>>> +~~~~~~~~~~
>>>> +
>>>> +The chunk size in bytes for dmesg(oops/panic). It **MUST** be a multiple of
>>>> +4096. If you don't need it, safely set it 0 or ignore it.
>>>
>>>                                        set it to 0 or ignore it.
>>>
>>
>> I will fix it, thank you.
>>
>>> The example above is:  blkoops.dmesg_size=64
>>> where 64 is not a multiple of 4096. (?)
>>>
>>
>> The module parameter dmesg_size is in unit KB.
> 
> I didn't see that documented anywhere.
> 

Oh, sorry, that is my oversight. It seems that not only the other size 
introductions but also introductions on Kconfig should be corrected. 
Thank you very much and is the following modification OK?

The chunk size in KB for dmesg(oops/panic). It **MUST** be a multiple of 4.

> 
>>>> +Normally the number of bytes written should be returned, while for error,
>>>> +negative number should be returned.
>>>> +
>>>> +panic_write (for block device)
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +It's much similar to panic_write for non-block device, but panic_write for
>>>> +block device writes alignment to SECTOR_SIZE, that's why the parameters are
>>>
>>>                  writes only aligned sectors of SECTOR_SIZE  (??)
>>>
>>
>> How about this?
>>
>> It's much similar to panic_write for non-block device, but the position and
>> data size of panic_write for block device must be aligned to SECTOR_SIZE,
>> that's why the parameters are @sects and @start_sect. Block device driver
>> should register it by ``blkoops_register_blkdev``.
> 
> OK.
> 
>>>> +@sects and @start_sect. Block device driver should register it by
>>>> +``blkoops_register_blkdev``.
>>>> +
>>>> +The parameter @start_sect is the relative position of the block device and
>>>> +partition. If block driver requires absolute position for panic_write,
>>>> +``blkoops_blkdev_info`` will be helpful, which can provide the absolute
>>>> +position of the block device (or partition) on the whole disk/flash.
>>>> +
>>>> +Normally zero should be returned, otherwise it indicates an error.
>>>> +
>>>> +Compression and header
>>>> +----------------------
>>>> +
>>>> +Block device is large enough for uncompressed dmesg data. Actually we do not
>>>> +recommend data compression because pstore/blk will insert some information into
>>>> +the first line of dmesg data. For example::
>>>> +
>>>> +        Panic: Total 16 times
>>>> +
>>>> +It means that it's the 16th times panic log since the first booting. Sometimes
>>>
>>>                                 time of a panic log since ...
>>>
>>
>> Should it be like this?
>> It means the time of a panic log since the first booting.
> 
> That sounds like clock time, not the number of instances or occurrences.
> 

It is an oops/panic counter too. How about this?

It means that it's OOPS/PANIC for the 16th time since the first booting.

>>
>>>> +the oops|panic occurs since burning is very important for embedded device to
>>>
>>>                                 ^^^^^^^ huh??
>>>
>>
>> How about this?
>>
>> Sometimes the number of occurrences of oops|panic since the first
>> booting is important
>> to judge whether the system is stable.
> 
> OK.
> 
>>>> +judge whether the system is stable.
>>>> +
>>>> +The following line is inserted by pstore filesystem. For example::
>>>> +
>>>> +        Oops#2 Part1
>>>> +
>>>> +It means that it's the 2nd times oops log on last booting.
>>>
>>>                            2nd time of an oops log on the last boot. (?)
>>>
>>
>> How about this?
>>
>> It means that it's OOPS for the 2nd time on the last boot.
> 
> OK. It's an oops counter.
> 
>>>> +#. Just use CPU to transfer.
>>>> +   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
>>>> +#. Operate register directly.
>>>
>>>        Don't know what that means.
>>>
>>
>> How about this?
>>
>> #. Control registers directly.
>>      Please control registers directly rather than use Linux kernel
>> resources.
> 
> OK.
> 
>>      Do I/O map while initializing rather than wait until a panic occurs.
>>
>>>> +   Try not to use Linux kernel resources. Do I/O map while initializing rather
>>>> +   than waiting until the panic.
> 
> 
