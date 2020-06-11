Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E291207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFKD2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:28:55 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34042 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgFKD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:28:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U.E6nrM_1591846127;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.E6nrM_1591846127)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 11:28:48 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [patch 113/131] mm: balance LRU lists based on relative thrashing
To:     Joonsoo Kim <js1304@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?6rmA66+87LCs?= <minchan@kernel.org>,
        mm-commits@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200603230303.kSkT62Lb5%akpm@linux-foundation.org>
 <a60f7866-3b32-7a0e-5d0a-a48d77f845a8@linux.alibaba.com>
 <20200609144551.GA452252@cmpxchg.org>
 <CAAmzW4OrmCBQC05E6Kr-pLw3VU=cthzZCpfEzDabhO5vTaq8KA@mail.gmail.com>
Message-ID: <beaf9c3e-2f77-f6b7-b80f-60cc50c33cee@linux.alibaba.com>
Date:   Thu, 11 Jun 2020 11:28:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4OrmCBQC05E6Kr-pLw3VU=cthzZCpfEzDabhO5vTaq8KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/6/10 下午1:23, Joonsoo Kim 写道:
> 2020년 6월 9일 (화) 오후 11:46, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
>>
>> On Tue, Jun 09, 2020 at 05:15:33PM +0800, Alex Shi wrote:
>>>
>>>
>>> 在 2020/6/4 上午7:03, Andrew Morton 写道:
>>>>
>>>> +   /* XXX: Move to lru_cache_add() when it supports new vs putback */
>>>
>>> Hi Hannes,
>>>
>>> Sorry for a bit lost, would you like to explain a bit more of your idea here?
>>>
>>>> +   spin_lock_irq(&page_pgdat(page)->lru_lock);
>>>> +   lru_note_cost(page);
>>>> +   spin_unlock_irq(&page_pgdat(page)->lru_lock);
>>>> +
>>>
>>>
>>> What could we see here w/o the lru_lock?

Why I want to know the lru_lock protection here is that currently we have 5 lru lists
but only guarded by one lock, that would cause much contention when different apps
active on a server.

I guess originally we have only one lru_lock, since 5 locks would cause cacheline bouncing
if we put them together, or a bit cacheline waste to separate them in cacheline. But
after we have qspinlock, each of cpu will just loop lock on their cacheline, no interfer 
to others. It would much much relief the performance drop by cacheline bounce.

And we could use page.mapping bits to store the using lru list index for the page.
As a quick thought, I guess, except the 5 locks for 5 lists, we still need 1 more lock for
common lruvec data or for others which relay on lru_lock now, like mlock, hpage_nr_pages..
That's the reason I want to know everything under lru_lock. :)

Any comments for this idea? :)

Thanks
Alex


>>
>> It'll just be part of the existing LRU locking in
>> pagevec_lru_move_fn(), when the new pages are added to the LRU in
>> batch. See this older patch for example:
>>
>> https://lore.kernel.org/linux-mm/20160606194836.3624-6-hannes@cmpxchg.org/
>>
>> I didn't include it in this series to reduce conflict with Joonsoo's
>> WIP series that also operates in this area and does something similar:
> 
> Thanks!
> 
>> https://lkml.org/lkml/2020/4/3/63
> 
> I haven't completed the rebase of my series but I guess that referenced patch
> "https://lkml.org/lkml/2020/4/3/63" would be removed in the next version.

Thanks a lot for the info, Johannes&Joonsoo! A long history for a interesting idea. :)

> 
> Before the I/O cost model, a new anonymous page contributes to the LRU reclaim
> balance. But, now, a new anonymous page doesn't contributes to the I/O cost
> so this adjusting patch would not be needed anymore.
> 
> If anyone wants to change this part,
> "/* XXX: Move to lru_cache_add() when it supports new vs putback */", feel free
> to do it.

