Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F35C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCEA207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSIhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:37:55 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33717 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgHSIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:37:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U6DSz3L_1597826267;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6DSz3L_1597826267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 16:37:48 +0800
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
 <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
 <0dc33af2-4d2d-9531-03fa-d26654ab79fb@redhat.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <420c8091-f0c7-f7e6-be95-85d81f877aae@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 16:36:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0dc33af2-4d2d-9531-03fa-d26654ab79fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/19 下午4:13, David Hildenbrand 写道:
> On 19.08.20 10:09, Alex Shi wrote:
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

The above commit is a good disproof, the false sharing caused performance issue,
and need using a lock protect cmpxchg, the instruction was designed for lockless
using. The false sharing, it was a trouble, and would trouble again sometime.

Thanks
Alex

>>
>> but I do have some problem in running thpscale/mmtest. I'd like to see if anyone
>> could give a try.
>>
>> BTW, I naturally hate the false sharing even it's in theory. Anyone who doesn't? :)
> 
> I hate wasting memory, even if it's just a little bit, anyone who
> doesn't? ;)
> 
> 
