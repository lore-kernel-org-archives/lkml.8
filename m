Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2ECC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E03206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAaMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:30:44 -0500
Received: from foss.arm.com ([217.140.110.172]:34938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgAaMan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:30:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42EF1063;
        Fri, 31 Jan 2020 04:30:42 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D5B3F67D;
        Fri, 31 Jan 2020 04:30:41 -0800 (PST)
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
Date:   Fri, 31 Jan 2020 12:30:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-31 12:17 am, Eric Dumazet wrote:
> On Thu, Jan 30, 2020 at 3:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Eric,
>>
>> On 2020-01-30 7:10 pm, Eric Dumazet via iommu wrote:
>>> Increasing the size of dma_entry_hash size by 327680 bytes
>>> has reached some bootloaders limitations.
>>
>> [ That might warrant some further explanation - I don't quite follow how
>> this would relate to a bootloader specifically :/ ]
> 
> I had no details, please look at the prior thread where this has been discussed.
> 
> https://www.spinics.net/lists/linux-renesas-soc/msg46157.html

Thanks for the pointer - that had passed me by as it doesn't seem to 
have been CCed to the IOMMU list or me as a reviewer.

>>> Simply use dynamic allocations instead, and take
>>> this opportunity to increase the hash table to 65536
>>> buckets. Finally my 40Gbit mlx4 NIC can sustain
>>> line rate with CONFIG_DMA_API_DEBUG=y.
>>
>> That's pretty cool, but I can't help but wonder if making the table
>> bigger caused a problem in the first place, whether making it bigger yet
>> again in the name of a fix is really the wisest move. How might this
>> impact DMA debugging on 32-bit embedded systems with limited vmalloc
>> space and even less RAM, for instance? More to the point, does vmalloc()
>> even work for !CONFIG_MMU builds? Obviously we don't want things to be
>> *needlessly* slow if avoidable, but is there a genuine justification for
>> needing to optimise what is fundamentally an invasive heavyweight
>> correctness check - e.g. has it helped expose race conditions that were
>> otherwise masked?
> 
> Not sure what you are saying.
> 
> vmalloc() _is_ supported by all arches, even !CONFIG_MMU

OK, that's good - I wasn't sure off-hand, and I was on the wrong machine 
to go digging into the source.

> I can not test all platforms, and this is a debugging
> feature no one uses in production.

...which is exactly why I'd prefer to see a stronger justification for 
making a change which only benefits performance on large systems, while 
potentially impacting usability on small ones.

>> That said, by moving to dynamic allocation maybe there's room to be
>> cleverer and make HASH_SIZE scale with, say, system memory size? (I
>> assume from the context it's not something we can expand on-demand like
>> we did for the dma_debug_entry pool)
>>
> 
> How memory size can serve as a proxy of the number of entries ?
> Current 10Gbit NIC need about 256,000 entries in the table.
> Needless to say, the prior hash size was unusable.

Because it's actually a reasonable proxy for "system size" in this 
context - there aren't many good reasons for a driver to maintain 
hundreds of mappings of the *same* buffer, so in general the maximum 
number of live mappings is effectively going to scale with the total 
amount of memory, particularly at the smaller end. Consider it a pretty 
safe assumption that an embedded system with RAM measured in megabytes 
won't ever be running anything like an MLX4, let alone in a debug 
situation. If those 256,000 mappings each represent a typical network 
packet, that implies well over 300MB of data alone, not to mention the 
size of the queues themselves, the actual DMA debug entries, and the 
whole rest of the kernel beyond that one driver - I doubt it's 
physically possible to 'need' 64K hash buckets without at very least 1GB 
of total RAM, quite likely much more.

> As I suggested one month ago, HASH_SIZE can be tuned by a developper
> eager to use this facility.
> 
> 65536 slots are 768 KB on 32bit platforms.

...and when that represents ~5% of the total system RAM it is a *lot* 
less reasonable than even 12KB. As I said, it's great to make a debug 
option more efficient such that what it observes is more representative 
of the non-debug behaviour, but it mustn't come at the cost of making 
the entire option unworkable for other users.

Robin.

>>> Fixes: 5e76f564572b ("dma-debug: increase HASH_SIZE")
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    kernel/dma/debug.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>>> index 2031ed1ad7fa109bb8a8c290bbbc5f825362baba..a310dbb1515e92c081f8f3f9a7290dd5e53fc889 100644
>>> --- a/kernel/dma/debug.c
>>> +++ b/kernel/dma/debug.c
>>> @@ -27,7 +27,7 @@
>>>
>>>    #include <asm/sections.h>
>>>
>>> -#define HASH_SIZE       16384ULL
>>> +#define HASH_SIZE       65536ULL
>>>    #define HASH_FN_SHIFT   13
>>>    #define HASH_FN_MASK    (HASH_SIZE - 1)
>>>
>>> @@ -90,7 +90,8 @@ struct hash_bucket {
>>>    };
>>>
>>>    /* Hash list to save the allocated dma addresses */
>>> -static struct hash_bucket dma_entry_hash[HASH_SIZE];
>>> +static struct hash_bucket *dma_entry_hash __read_mostly;
>>> +
>>>    /* List of pre-allocated dma_debug_entry's */
>>>    static LIST_HEAD(free_entries);
>>>    /* Lock for the list above */
>>> @@ -934,6 +935,10 @@ static int dma_debug_init(void)
>>>        if (global_disable)
>>>                return 0;
>>>
>>> +     dma_entry_hash = vmalloc(HASH_SIZE * sizeof(*dma_entry_hash));
>>> +     if (!dma_entry_hash)
>>> +             goto err;
>>> +
>>>        for (i = 0; i < HASH_SIZE; ++i) {
>>>                INIT_LIST_HEAD(&dma_entry_hash[i].list);
>>>                spin_lock_init(&dma_entry_hash[i].lock);
>>> @@ -950,6 +955,7 @@ static int dma_debug_init(void)
>>>                pr_warn("%d debug entries requested but only %d allocated\n",
>>>                        nr_prealloc_entries, nr_total_entries);
>>>        } else {
>>> +err:
>>>                pr_err("debugging out of memory error - disabled\n");
>>>                global_disable = true;
>>>
>>>
