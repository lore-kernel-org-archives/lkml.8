Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F8C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF020873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCKFW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:22:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:27105 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgCKFW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:22:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 22:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="236305814"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2020 22:22:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mel Gorman" <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: Add more comments for MADV_FREE
References: <20200311011117.1656744-1-ying.huang@intel.com>
        <alpine.DEB.2.21.2003102204450.255869@chino.kir.corp.google.com>
Date:   Wed, 11 Mar 2020 13:22:54 +0800
In-Reply-To: <alpine.DEB.2.21.2003102204450.255869@chino.kir.corp.google.com>
        (David Rientjes's message of "Tue, 10 Mar 2020 22:08:54 -0700")
Message-ID: <87imjbv51t.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Wed, 11 Mar 2020, Huang, Ying wrote:
>
>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>> index 6f2fef7b0784..01144dd02a5f 100644
>> --- a/include/linux/mm_inline.h
>> +++ b/include/linux/mm_inline.h
>> @@ -9,10 +9,11 @@
>>   * page_is_file_cache - should the page be on a file LRU or anon LRU?
>>   * @page: the page to test
>>   *
>> - * Returns 1 if @page is page cache page backed by a regular filesystem,
>> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
>> - * Used by functions that manipulate the LRU lists, to sort a page
>> - * onto the right LRU list.
>> + * Returns 1 if @page is page cache page backed by a regular filesystem or
>> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
>> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
>> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
>> + * list.
>
> The function name is misleading: anonymous pages that can be lazily freed 
> are not file cache.  This returns 1 because of the question it is asking: 
> anonymous lazily freeable pages should be on the file lru, not the anon 
> lru.  So before adjusting the comment I'd suggest renaming the function to 
> something like page_is_file_lru().

Yes.  I think page_is_file_lru() is a better name too.  And whether
tmpfs pages are file cache pages is confusing too.  But I think we can
do that after this patch if others think this is a good idea too.

Best Regards,
Huang, Ying
