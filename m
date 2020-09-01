Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2270C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67AD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIARE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:04:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgIAREN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:04:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02919ACC5;
        Tue,  1 Sep 2020 17:04:11 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
 <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <11d6c4ae-6eae-aef9-5652-73a8680cd6e4@suse.cz>
Date:   Tue, 1 Sep 2020 19:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 10:09 AM, Alex Shi wrote:
> 
> 
> 在 2020/8/19 下午3:57, Anshuman Khandual 写道:
>> 
>> 
>> On 08/19/2020 11:17 AM, Alex Shi wrote:
>>> Current pageblock_flags is only 4 bits, so it has to share a char size
>>> in cmpxchg when get set, the false sharing cause perf drop.
>>>
>>> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
>>> the only cost is half char per pageblock, which is half char per 128MB
>>> on x86, 4 chars in 1 GB.
>> 
>> Agreed that increase in memory utilization is negligible here but does
>> this really improve performance ?
>> 
> 
> It's no doubt in theory. and it would had a bad impact according to 
> commit e380bebe4771548  mm, compaction: keep migration source private to a single 

I don't think that commit is doing the test_and_set_skip() under lock to avoid
false sharing. I think it's done to simply make the test and set protected
against races without relying on e.g. a truly atomic test_and_set_bit(). It's
still noted that it's just a hint so it's not protected to others calling
set_pageblock_skip() from other contexts not under a lock.

> but I do have some problem in running thpscale/mmtest. I'd like to see if anyone
> could give a try.
> 
> BTW, I naturally hate the false sharing even it's in theory. Anyone who doesn't? :)
> 
> Thanks
> Alex 
> 

