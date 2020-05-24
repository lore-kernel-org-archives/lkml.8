Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19AAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2AF20878
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HYCLbggl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgEXLVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgEXLVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:21:20 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C67C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 04:21:20 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 48FA32E14F5;
        Sun, 24 May 2020 14:21:16 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id cPMFzIToUY-LEYGKdUM;
        Sun, 24 May 2020 14:21:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590319276; bh=b0o68+aOnARHj9/nq/+LVPyiRVbyiqWIANFK3o0ma0M=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=HYCLbgglTXT05CLaIJVZjXdf/rzckKrZ+/2ZP/jyUDm2xknikSiBhtHai7/ijVxKm
         NTQfnbR+O8eKOM1N6iogGjrHt/6fROslkz5crWqGKRkBXiUC4oJw8KlUXY97hUzB+G
         cKPxwa7Rszg6hvmpAr3/MHZX+wDZEwwUs49QbdsY=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:606::1:1])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 3faDg9DMvq-LEWCw22w;
        Sun, 24 May 2020 14:21:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <158937872515.474360.5066096871639561424.stgit@buzz>
 <alpine.LSU.2.11.2005231650070.1171@eggly.anvils>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <63fe94c7-78d1-ae03-00da-ba0e6d207a70@yandex-team.ru>
Date:   Sun, 24 May 2020 14:21:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2005231650070.1171@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2020 04.01, Hugh Dickins wrote:
> On Wed, 13 May 2020, Konstantin Khlebnikov wrote:
> 
>> Function isolate_migratepages_block() runs some checks out of lru_lock
>> when choose pages for migration. After checking PageLRU() it checks extra
>> page references by comparing page_count() and page_mapcount(). Between
>> these two checks page could be removed from lru, freed and taken by slab.
>>
>> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
>> Race window is tiny. For certain workload this happens around once a year.
> 
> Around once a year, that was my guess too. I have no record of us ever
> hitting this, but yes it could happen when you have CONFIG_DEBUG_VM=y
> (which I too like to run with, but would not recommend for users).

Yep, but for large cluster and pinpointed workload this happens surprisingly
frequently =) I've believed into this race only after seeing statistics for
count of compactions and how it correlates with incidents.

Probably the key component is a slab allocation from network irq/bh context
which interrupts compaction exactly at this spot.

> 
>>
>>
>>   page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>>   flags: 0x500000000008100(slab|head)
>>   raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>>   raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>>   page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>>   ------------[ cut here ]------------
>>   kernel BUG at ./include/linux/mm.h:628!
>>   invalid opcode: 0000 [#1] SMP NOPTI
>>   CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>>   Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>>   RIP: 0010:isolate_migratepages_block+0x986/0x9b0
>>
>>
>> To fix just opencode page_mapcount() in racy check for 0-order case and
>> recheck carefully under lru_lock when page cannot escape from lru.
>>
>> Also add checking extra references for file pages and swap cache.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Fixes: 119d6d59dcc0 ("mm, compaction: avoid isolating pinned pages")
> 
> Not really, that commit was correct at the time it went in.
> 
>> Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
> 
> Exactly, that commit was well-intentioned, but did not allow for this
> (admittedly very exceptional) usage.  How many developers actually
> make the mistake of applying page_mapcount() to their slab pages?
> None, I expect.  That VM_BUG_ON_PAGE() is there for documentation,
> and could just be replaced by a comment - and Linus would be happy
> with that.

Ok, I'll redo the fix in this way.

> 
>> ---
>>   mm/compaction.c |   17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 46f0fcc93081..91bb87fd9420 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   		}
>>   
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> +		 * Migration will fail if an page is pinned in memory,
>>   		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * admittedly racy check simplest case for 0-order pages.
>> +		 *
>> +		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
> 
> But open coding page_mapcount() is not all that you did.  You have
> (understandably) chosen to avoid calling page_mapping(page), but...
> 
>> +		 * Page could have extra reference from mapping or swap cache.
>>   		 */
>> -		if (!page_mapping(page) &&
>> -		    page_count(page) > page_mapcount(page))
>> +		if (!PageCompound(page) &&
>> +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
>> +				(!PageAnon(page) || PageSwapCache(page)))
>>   			goto isolate_fail;
> 
> Isn't that test going to send all the file cache pages with buffer heads
> in page->private, off to isolate_fail when they're actually great
> candidates for migration?

Yes. What a shame. Adding page_has_private() could fix that?

Kind of

page_count(page) > page_mapcount(page) +
(PageAnon(page) ? PageSwapCache(page) : (1 + page_has_private(page)))

or probably something like this:

page_count(page) > page_mapcount(page) +
(PageAnon(page) ? PageSwapCache(page) : GUP_PIN_COUNTING_BIAS)

I.e. skip only file pages pinned by dma or something slower.
I see some movements in this direction in recent changes.

of course that's independent matter.

> 
> Given that the actual bug spotted was with the VM_BUG_ON_PAGE(PageSlab),
> and nobody has reported any crash from the use of page_mapping() there
> (and we only need the test to be right most of the time: all of this
> knowingly racy, as you explain in other mail): I'd go for just replacing
> the VM_BUG_ON_PAGE in page_mapcount() by a comment about this case.
> 
> But if you think developers are really in danger of coding page_mapcount()
> on their slab pages, then you could add a _page_mapcount() to linux/mm.h,
> which omits the VM_BUG_ON_PAGE, for use here only.
> 
> Then we wouldn't have to think so hard about the counting above!
> 
>>   
>>   		/*
>> @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   				low_pfn += compound_nr(page) - 1;
>>   				goto isolate_fail;
>>   			}
>> +
>> +			/* Recheck page extra references under lock */
>> +			if (page_count(page) > page_mapcount(page) +
>> +				    (!PageAnon(page) || PageSwapCache(page)))
>> +				goto isolate_fail;
> 
> Well, that lru_lock (and the intervening PageLRU check after getting it)
> may restrict PageAnon and PageSwapCache transitions to some extent, but
> it certainly has no effect on page_count and page_mapcount: so I think
> such an additional check here is rather superfluous, and we should just
> rely on the final checks in migrate_page_move_mapping(), as before.
> 
>>   		}
>>   
>>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
