Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E898C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EB6205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRHQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:16:50 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52034 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgHRHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:16:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U67H3Vd_1597735003;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U67H3Vd_1597735003)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 15:16:45 +0800
Subject: Re: [PATCH 2/2] mm/pageblock: remove false sharing in pageblock_flags
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200816041720.GG17456@casper.infradead.org>
 <957eee62-1f46-49b6-4d5a-9671dc07c562@linux.alibaba.com>
 <CAKgT0UeT0VK4zW+aXn0-6VcO0hYF9u+h+0Cb9kgjvChUQ0w=6g@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a604ab69-d5c6-42a7-4487-a2fe6915940b@linux.alibaba.com>
Date:   Tue, 18 Aug 2020 15:15:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeT0VK4zW+aXn0-6VcO0hYF9u+h+0Cb9kgjvChUQ0w=6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/16 下午11:56, Alexander Duyck 写道:
> On Sun, Aug 16, 2020 at 7:11 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2020/8/16 下午12:17, Matthew Wilcox 写道:
>>> On Sun, Aug 16, 2020 at 11:47:57AM +0800, Alex Shi wrote:
>>>> Current pageblock_flags is only 4 bits, so it has to share a char size
>>>> in cmpxchg when get set, the false sharing cause perf drop.
>>>>
>>>> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
>>>> the only cost is half char per pageblock, which is half char per 128MB
>>>> on x86, 4 chars in 1 GB.
>>>
>>> I don't believe this patch has that effect, mostly because it still does
>>> cmpxchg() on words instead of bytes.
>>
>> Hi Matthew,
>>
>> Thank a lot for comments!
>>
>> Sorry, I must overlook sth, would you like point out why the cmpxchg is still
>> on words after patch 1 applied?
>>
> 
> I would take it one step further. You still have false sharing as the
> pageblocks bits still occupy the same cacheline so you are going to
> see them cache bouncing regardless.

Right, there 2 level false sharing here, cacheline and cmpxchg comparsion range.
this patch could fix the cmpxchg level with a very cheap price.
the cacheline size is too huge to resovle here.

> 
> What it seems like you are attempting to address is the fact that
> multiple threads could all be attempting to update the same long
> value. As I pointed out for the migrate type it seems to be protected
> by the zone lock, but for compaction the skip bit doesn't have the
> same protection as there are some threads using the zone lock and
> others using the LRU lock. I'm still not sure it makes much of a
> difference though.

It looks with this patch, lock are not needed anymore on the flags.

> 
>>>
>>> But which functions would benefit?  It seems to me this cmpxchg() is
>>> only called from the set_pageblock_migratetype() morass of functions,
>>> none of which are called in hot paths as far as I can make out.
>>>
>>> So are you just reasoning by analogy with the previous patch where you
>>> have measured a performance improvement, or did you send the wrong patch,
>>> or did I overlook a hot path that calls one of the pageblock migration
>>> functions?
>>>
>>
>> Uh, I am reading compaction.c and found the following commit introduced
>> test_and_set_skip under a lock. It looks like the pagelock_flags setting
>> has false sharing in cmpxchg. but I have no valid data on this yet.
>>
>> Thanks
>> Alex
>>
>> e380bebe4771548  mm, compaction: keep migration source private to a single compaction instance
>>
>>                 if (!locked) {
>>                         locked = compact_trylock_irqsave(zone_lru_lock(zone),
>>                                                                 &flags, cc);
>> -                       if (!locked)
>> +
>> +                       /* Allow future scanning if the lock is contended */
>> +                       if (!locked) {
>> +                               clear_pageblock_skip(page);
>>                                 break;
>> +                       }
>> +
>> +                       /* Try get exclusive access under lock */
>> +                       if (!skip_updated) {
>> +                               skip_updated = true;
>> +                               if (test_and_set_skip(cc, page, low_pfn))
>> +                                       goto isolate_abort;
>> +                       }
>>
> 
> I'm not sure that is a good grounds for doubling the size of the
> pageblock flags. If you look further down in the code there are bits
> that are setting these bits without taking the lock. The assumption
> here is that by taking the lock the test_and_set_skip will be
> performed atomically since another thread cannot perform that while
> the zone lock is held. If you look in the function itself it only does
> anything if the skip bits are checked and if the page is the first
> page in the pageblock.
> 
> I think you might be confusing some of my earlier comments. I still
> believe the 3% regression you reported with my patch is not directly
> related to the test_and_set_skip as the test you ran seems unlikely to
> trigger compaction. However with that said one of the advantages of
> using the locked section to perform these types of tests is that it
> reduces the number of times the test is run since it will only be on
> the first unlocked page in any batch of pages and the first page in
> the pageblock is always going to be handled without the lock held
> since it is the first page processed.
> 
> Until we can get a test up such as thpscale that does a good job of
> stressing the compaction code I don't think we can rely on just
> observations to say if this is an improvement or not.

I still struggle on thpscale meaningful running. But if the patch is 
clearly right in theory. Do we have to hang on a benchmark result?

Thanks
Alex
