Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96468C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4BF2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIINtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:49:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbgIINYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AAC9B211;
        Wed,  9 Sep 2020 12:14:08 +0000 (UTC)
Subject: Re: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-6-vbabka@suse.cz>
 <d5d5ef64-b239-0640-5640-75c7a3c78584@suse.cz>
 <20200909113647.GG7348@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b057e618-94f1-3f5a-a4f6-55fc93ac34eb@suse.cz>
Date:   Wed, 9 Sep 2020 13:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909113647.GG7348@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 1:36 PM, Michal Hocko wrote:
> On Wed 09-09-20 12:48:54, Vlastimil Babka wrote:
>> Here's a version that will apply on top of next-20200908. The first 4 patches need no change.
>> 
>> ----8<----
>> >From 8febc17272b8e8b378e2e5ea5e76b2616f029c5b Mon Sep 17 00:00:00 2001
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Date: Mon, 7 Sep 2020 17:20:39 +0200
>> Subject: [PATCH] mm, page_alloc: disable pcplists during page isolation
>> 
>> Page isolation can race with process freeing pages to pcplists in a way that
>> a page from isolated pageblock can end up on pcplist. This can be fixed by
>> repeated draining of pcplists, as done by patch "mm/memory_hotplug: drain
>> per-cpu pages again during memory offline" in [1].
>> 
>> David and Michal would prefer that this race was closed in a way that callers
>> of page isolation don't need to care about drain. David suggested disabling
>> pcplists usage completely during page isolation, instead of repeatedly draining
>> them.
>> 
>> To achieve this without adding special cases in alloc/free fastpath, we can use
>> the same 'trick' as boot pagesets - when pcp->high is 0, any pcplist addition
>> will be immediately flushed.
>> 
>> The race can thus be closed by setting pcp->high to 0 and draining pcplists
>> once in start_isolate_page_range(). The draining will serialize after processes
>> that already disabled interrupts and read the old value of pcp->high in
>> free_unref_page_commit(), and processes that have not yet disabled interrupts,
>> will observe pcp->high == 0 when they are rescheduled, and skip pcplists.
>> This guarantees no stray pages on pcplists in zones where isolation happens.
>> 
>> We can use the variable zone->nr_isolate_pageblock (protected by zone->lock)
>> to detect transitions from 0 to 1 (to change pcp->high to 0 and issue drain)
>> and from 1 to 0 (to restore original pcp->high and batch values cached in
>> struct zone). We have to avoid external updates to high and batch by taking
>> pcp_batch_high_lock. To allow multiple isolations in parallel, change this
>> lock from mutex to rwsem.
>> 
>> For callers that pair start_isolate_page_range() with
>> undo_isolated_page_range() properly, this is transparent. Currently that's
>> alloc_contig_range(). __offline_pages() doesn't call undo_isolated_page_range()
>> in the succes case, so it has to be carful to handle restoring pcp->high and batch
>> and unlocking pcp_batch_high_lock.
> 
> I was hoping that it would be possible to have this completely hidden
> inside start_isolate_page_range code path.

I hoped so too, but we can't know the moment when all processes that were in the
critical part of freeing pages to pcplists have moved on (they might have been
rescheduled).
We could change free_unref_page() to disable IRQs sooner, before
free_unref_page_prepare(), or at least the get_pfnblock_migratetype() part. Then
after the single drain, we should be safe, AFAICS?
RT guys might not be happy though, but it's much simpler than this patch. I
still like some of the cleanups in 1-4 though tbh :)

> If we need some sort of
> disable_pcp_free/enable_pcp_free then it seems like a better fit to have
> an explicit API for that (the naming would be obviously different
> because we do not want to call out pcp free lists). I strongly suspect
> that only the memory hotplug really cares for this hard guanrantee.
> alloc_contig_range simply goes with EBUSY.
>  
>> This commit also changes drain_all_pages() to not trust reading pcp->count during
>> drain for page isolation - I believe that could be racy and lead to missing some
>> cpu's to drain. If others agree, this can be separated and potentially backported.
>> 
>> [1] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/
>> 
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/gfp.h |  1 +
>>  mm/internal.h       |  4 +++
>>  mm/memory_hotplug.c | 55 ++++++++++++++++++++++++++++-------------
>>  mm/page_alloc.c     | 60 +++++++++++++++++++++++++++++----------------
>>  mm/page_isolation.c | 45 ++++++++++++++++++++++++++++------
>>  5 files changed, 119 insertions(+), 46 deletions(-)
> 
> This has turned out much larger than I would expect.
> 

