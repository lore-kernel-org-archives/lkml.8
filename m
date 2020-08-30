Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF49C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E5520714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgH3KAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:00:25 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47164 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgH3KAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:00:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7FbXgd_1598781620;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7FbXgd_1598781620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 30 Aug 2020 18:00:21 +0800
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
 <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
 <CAKgT0UcXRB2HH4S+k=SmTz0Dgw9pKp=i4kT4U+yy8MFVC6_JWQ@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e2bda56b-445d-f2a3-3a3c-3193d65cc743@linux.alibaba.com>
Date:   Sun, 30 Aug 2020 18:00:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcXRB2HH4S+k=SmTz0Dgw9pKp=i4kT4U+yy8MFVC6_JWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/20 上午12:50, Alexander Duyck 写道:
> On Wed, Aug 19, 2020 at 1:11 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2020/8/19 下午3:57, Anshuman Khandual 写道:
>>>
>>>
>>> On 08/19/2020 11:17 AM, Alex Shi wrote:
>>>> Current pageblock_flags is only 4 bits, so it has to share a char size
>>>> in cmpxchg when get set, the false sharing cause perf drop.
>>>>
>>>> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
>>>> the only cost is half char per pageblock, which is half char per 128MB
>>>> on x86, 4 chars in 1 GB.
>>>
>>> Agreed that increase in memory utilization is negligible here but does
>>> this really improve performance ?
>>>
>>
>> It's no doubt in theory. and it would had a bad impact according to
>> commit e380bebe4771548  mm, compaction: keep migration source private to a single
>>
>> but I do have some problem in running thpscale/mmtest. I'd like to see if anyone
>> could give a try.
>>
>> BTW, I naturally hate the false sharing even it's in theory. Anyone who doesn't? :)
> 
> You keep bringing up false sharing but you don't fix the false sharing
> by doing this. You are still allowing the flags for multiple
> pageblocks per cacheline so you still have false sharing even after
> this.

yes, the cacheline false sharing is still there. But as you pointed, cmpxchg level
false sharing could be addressed much by the patchset.


> 
> What I believe you are attempting to address is the fact that multiple
> pageblocks share a single long value and that long is being used with
> a cmpxchg so you end up with multiple threads potentially all banging
> on the same value and watching it change. However the field currently
> consists of only 4 bits, 3 of them for migratetype and 1 for the skip
> bit. In the case of the 3 bit portion a cmpxchg makes sense and is
> usually protected by the zone lock so you would only have one thread
> accessing it in most cases with the possible exception of a section
> that spans multiple zones.
> 
> For the case such as the skip bit and MIGRATE_UNMOVABLE (0x0) where we
> would be clearing or setting the entire mask maybe it would make more
> sense to simply use an atomic_or or atomic_and depending on if you are
> setting or clearing the flag? It would allow you to avoid the spinning
> or having to read the word before performing the operation since you
> would just be directly applying an AND or OR via a mask value.

Right that the different level to fix this problem, but narrow the cmpxchg
comparsion is still needed and helpful.

Thanks
Alex
> 
