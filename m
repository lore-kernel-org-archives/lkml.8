Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948AD206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgCDBUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:20:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:50660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgCDBUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:20:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 17:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="287177752"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2020 17:20:51 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Mel Gorman" <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Add PageLayzyFree() helper functions for MADV_FREE
References: <20200303033738.281908-1-ying.huang@intel.com>
        <20200303165859.7440f23d388503ca77fdb6c2@linux-foundation.org>
Date:   Wed, 04 Mar 2020 09:20:51 +0800
In-Reply-To: <20200303165859.7440f23d388503ca77fdb6c2@linux-foundation.org>
        (Andrew Morton's message of "Tue, 3 Mar 2020 16:58:59 -0800")
Message-ID: <87o8tc3ogc.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue,  3 Mar 2020 11:37:38 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Now PageSwapBacked() is used as the helper function to check whether
>> pages have been freed lazily via MADV_FREE.  This isn't very obvious.
>> So Dave suggested to add PageLazyFree() family helper functions to
>> improve the code readability.
>> 
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -498,6 +498,31 @@ static __always_inline int PageKsm(struct page *page)
>>  TESTPAGEFLAG_FALSE(Ksm)
>>  #endif
>>  
>> +/*
>> + * For pages freed lazily via MADV_FREE.  lazyfree pages are clean
>> + * anonymous pages.  They have SwapBacked flag cleared to distinguish
>> + * with normal anonymous pages
>> + */
>> +static __always_inline int PageLazyFree(struct page *page)
>> +{
>> +	page = compound_head(page);
>> +	return PageAnon(page) && !PageSwapBacked(page);
>> +}
>> +
>> +static __always_inline void SetPageLazyFree(struct page *page)
>> +{
>> +	VM_BUG_ON_PAGE(PageTail(page), page);
>> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
>> +	ClearPageSwapBacked(page);
>> +}
>> +
>> +static __always_inline void ClearPageLazyFree(struct page *page)
>> +{
>> +	VM_BUG_ON_PAGE(PageTail(page), page);
>> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
>> +	SetPageSwapBacked(page);
>> +}
>
> These BUG_ONs aren't present in the current code and are
> unchangelogged.
>
> And they aren't free!
>
> before:
>
> q:/usr/src/25> size -t mm/rmap.o mm/swap.o mm/vmscan.o 
>    text    data     bss     dec     hex filename
>   41580    4211     192   45983    b39f mm/rmap.o
>   50684    9259    1184   61127    eec7 mm/swap.o
>  117728   46775     128  164631   28317 mm/vmscan.o
>  209992   60245    1504  271741   4257d (TOTALS)
>
> after:
>
>    text    data     bss     dec     hex filename
>   42035    4299     192   46526    b5be mm/rmap.o
>   51091    9347    1184   61622    f0b6 mm/swap.o
>  118132   46775     128  165035   284ab mm/vmscan.o
>  211258   60421    1504  273183   42b1f (TOTALS)
>
> ALso, if they actually trigger, Linus goes berserk.
>
> If you have some special reason to add these assertions, please do it
> as a (changelogged!) followup patch and I'll keep it as a linux-next only thing.

Sorry, originally I thought that VM_BUG_ON_PAGE() will not be used in
the production kernel, so it's cheap.  But it seems that people do care
about its usage.  I will send v2 to fix this.

Best Regards,
Huang, Ying
