Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E720674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgCQIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:51:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0D9AAD94;
        Tue, 17 Mar 2020 08:51:05 +0000 (UTC)
Subject: Re: [PATCH -V2] mm: Code cleanup for MADV_FREE
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
References: <20200316063740.2542014-1-ying.huang@intel.com>
 <b328ac30-6c4e-0dfb-c771-cb09c6346c75@suse.cz>
 <87v9n3qu4p.fsf@yhuang-dev.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <29193b53-b83a-b595-3117-f8d10342a49a@suse.cz>
Date:   Tue, 17 Mar 2020 09:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9n3qu4p.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 9:10 AM, Huang, Ying wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
>> On 3/16/20 7:37 AM, Huang, Ying wrote:
>>> From: Huang Ying <ying.huang@intel.com>
>>> 
>>> Some comments for MADV_FREE is revised and added to help people understand the
>>> MADV_FREE code, especially the page flag, PG_swapbacked.  This makes
>>> page_is_file_cache() isn't consistent with its comments.  So the function is
>>> renamed to page_is_file_lru() to make them consistent again.  All these are put
>>> in one patch as one logical change.
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Suggested-and-acked-by: David Rientjes <rientjes@google.com>
>>> Acked-by: Michal Hocko <mhocko@kernel.org>
>>> Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Rik van Riel <riel@surriel.com>
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> Thanks! A grammar nit below:
>>
>>> --- a/include/linux/mm_inline.h
>>> +++ b/include/linux/mm_inline.h
>>> @@ -6,19 +6,20 @@
>>>  #include <linux/swap.h>
>>>  
>>>  /**
>>> - * page_is_file_cache - should the page be on a file LRU or anon LRU?
>>> + * page_is_file_lru - should the page be on a file LRU or anon LRU?
>>>   * @page: the page to test
>>>   *
>>> - * Returns 1 if @page is page cache page backed by a regular filesystem,
>>> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
>>> - * Used by functions that manipulate the LRU lists, to sort a page
>>> - * onto the right LRU list.
>>> + * Returns 1 if @page is page cache page backed by a regular filesystem or
>>> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
>>
>>       a lazily freed anonymous page (e.g. ...
> 
> Thought again.  Should we make the 2 sub-clauses consistent?  That is,
> either
> 
> if @page is page cache page backed by a regular filesystem or anonymous
> page freed lazily
> 
> or
> 
> if @page is a regular filesystem backed page cache page or a lazily
> freed anonymous page

Yeah this one looks fine :)

> But I know that my English grammar isn't good enough :-(
> 
> Best Regards,
> Huang, Ying
> 
>>> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
>>> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
>>> + * list.
>>>   *
>>>   * We would like to get this info without a page flag, but the state
>>>   * needs to survive until the page is last deleted from the LRU, which
>>>   * could be as far down as __page_cache_release.
>>>   */
>>> -static inline int page_is_file_cache(struct page *page)
>>> +static inline int page_is_file_lru(struct page *page)
>>>  {
>>>  	return !PageSwapBacked(page);
>>>  }
> 

