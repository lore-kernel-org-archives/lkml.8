Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146AC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0D7205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbgCQAJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:09:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:38425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733023AbgCQAJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:09:58 -0400
IronPort-SDR: 406hLhuOexCsEZ8NRv3Vatgd1ifZPAmg9jKWzHrYLfT2/cTPSkCfa2AdxYsjL6YqQFFnrBXGWr
 kqUNGnjYp1jA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 17:09:57 -0700
IronPort-SDR: 1mju6VfkWy0cor19qBf5YzeF+KyO2QIqmzxPUyz9i+5AfpCwdqgIo9CENHwv+zBXU83VEsBzM4
 Bl3ljq7KfSeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,562,1574150400"; 
   d="scan'208";a="417355196"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2020 17:09:54 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH -V2] mm: Code cleanup for MADV_FREE
References: <20200316063740.2542014-1-ying.huang@intel.com>
        <b328ac30-6c4e-0dfb-c771-cb09c6346c75@suse.cz>
Date:   Tue, 17 Mar 2020 08:09:53 +0800
In-Reply-To: <b328ac30-6c4e-0dfb-c771-cb09c6346c75@suse.cz> (Vlastimil Babka's
        message of "Mon, 16 Mar 2020 18:17:23 +0100")
Message-ID: <878sjzsuy6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka <vbabka@suse.cz> writes:

> On 3/16/20 7:37 AM, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Some comments for MADV_FREE is revised and added to help people understand the
>> MADV_FREE code, especially the page flag, PG_swapbacked.  This makes
>> page_is_file_cache() isn't consistent with its comments.  So the function is
>> renamed to page_is_file_lru() to make them consistent again.  All these are put
>> in one patch as one logical change.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Suggested-and-acked-by: David Rientjes <rientjes@google.com>
>> Acked-by: Michal Hocko <mhocko@kernel.org>
>> Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Rik van Riel <riel@surriel.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Thanks! A grammar nit below:
>
>> --- a/include/linux/mm_inline.h
>> +++ b/include/linux/mm_inline.h
>> @@ -6,19 +6,20 @@
>>  #include <linux/swap.h>
>>  
>>  /**
>> - * page_is_file_cache - should the page be on a file LRU or anon LRU?
>> + * page_is_file_lru - should the page be on a file LRU or anon LRU?
>>   * @page: the page to test
>>   *
>> - * Returns 1 if @page is page cache page backed by a regular filesystem,
>> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
>> - * Used by functions that manipulate the LRU lists, to sort a page
>> - * onto the right LRU list.
>> + * Returns 1 if @page is page cache page backed by a regular filesystem or
>> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
>
>       a lazily freed anonymous page (e.g. ...

Thanks!  Will update patch with this.

Best Regards,
Huang, Ying

>> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
>> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
>> + * list.
>>   *
>>   * We would like to get this info without a page flag, but the state
>>   * needs to survive until the page is last deleted from the LRU, which
>>   * could be as far down as __page_cache_release.
>>   */
>> -static inline int page_is_file_cache(struct page *page)
>> +static inline int page_is_file_lru(struct page *page)
>>  {
>>  	return !PageSwapBacked(page);
>>  }
