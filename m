Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C8C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C3320727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSqHM8iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:21:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583745709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=35Fqn91KTsp+nbtyNrqhSGie2+eGkJNYycKiLotOV/0=;
        b=iSqHM8iSFGwUi7086hgoct3isfJ5FCdPsJRN3KosnSuotUmRFmSPMf03ghTtWXuNzPIb9M
        7bZ+5ryt/jn/mxbgLZvAwqE/Nmiz0WZIcy8tXeeqwETDJgKYOtS7XSyWdcllFxbMOTOjFc
        qCpBPPw8hBr7GMI1N1EKUHDtAw9FSY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-HdV7dvOVMAqwpOs1L7wz7A-1; Mon, 09 Mar 2020 05:21:45 -0400
X-MC-Unique: HdV7dvOVMAqwpOs1L7wz7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21504101FC70;
        Mon,  9 Mar 2020 09:21:43 +0000 (UTC)
Received: from [10.36.118.32] (unknown [10.36.118.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13F3528980;
        Mon,  9 Mar 2020 09:21:35 +0000 (UTC)
Subject: Re: [PATCH -V3] mm: Add PageLayzyFree() helper functions for
 MADV_FREE
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
References: <20200309021744.1309482-1-ying.huang@intel.com>
 <68360241-eb18-b3d8-bf6f-4dbbed258ee6@redhat.com>
 <87r1y1yjll.fsf@yhuang-dev.intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <23076072-7875-cabf-768f-ce27cba3480d@redhat.com>
Date:   Mon, 9 Mar 2020 10:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1y1yjll.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.20 10:15, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 09.03.20 03:17, Huang, Ying wrote:
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> Now PageSwapBacked() is used as the helper function to check whether
>>> pages have been freed lazily via MADV_FREE.  This isn't very obvious.
>>> So Dave suggested to add PageLazyFree() family helper functions to
>>> improve the code readability.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> ---
>>> Changelog:
>>>
>>> v3:
>>>
>>> - Improved comments, Thanks David Hildenbrand!
>>>
>>> - Use the helper function in /proc/PID/smaps lazyfree reporting.
>>>
>>> v2:
>>>
>>> - Avoid code bloat via removing VM_BUG_ON_PAGE(), which doesn't exist
>>>   in the original code.  Now there is no any text/data/bss size
>>>   change.
>>>
>>> - Fix one wrong replacement in try_to_unmap_one().
>>>
>>> ---
>>>  fs/proc/task_mmu.c         |  2 +-
>>>  include/linux/page-flags.h | 25 +++++++++++++++++++++++++
>>>  mm/rmap.c                  |  4 ++--
>>>  mm/swap.c                  | 11 +++--------
>>>  mm/vmscan.c                |  7 +++----
>>>  5 files changed, 34 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 3ba9ae83bff5..3458d5711e57 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -471,7 +471,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>  	 */
>>>  	if (PageAnon(page)) {
>>>  		mss->anonymous += size;
>>> -		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
>>> +		if (__PageLazyFree(page) && !dirty && !PageDirty(page))
>>>  			mss->lazyfree += size;
>>>  	}
>>>  
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 49c2697046b9..bb26f74cbe8e 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -498,6 +498,31 @@ static __always_inline int PageKsm(struct page *page)
>>>  TESTPAGEFLAG_FALSE(Ksm)
>>>  #endif
>>>  
>>> +/*
>>> + * For pages freed lazily via MADV_FREE.  Lazyfree pages are clean
>>> + * anonymous pages.  They don't have PG_swapbacked set, to distinguish
>>> + * them from normal anonymous pages.
>>> + */
>>> +static __always_inline int __PageLazyFree(struct page *page)
>>> +{
>>> +	return !PageSwapBacked(page);
>>> +}
>>> +
>>> +static __always_inline int PageLazyFree(struct page *page)
>>> +{
>>> +	return PageAnon(page) && __PageLazyFree(page);
>>> +}
>>> +
>>> +static __always_inline void SetPageLazyFree(struct page *page)
>>> +{
>>> +	ClearPageSwapBacked(page);
>>> +}
>>> +
>>> +static __always_inline void ClearPageLazyFree(struct page *page)
>>> +{
>>> +	SetPageSwapBacked(page);
>>> +}
>>> +
>>>  u64 stable_page_flags(struct page *page);
>>>  
>>>  static inline int PageUptodate(struct page *page)
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 1c02adaa233e..6ec96c8e7826 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1609,7 +1609,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>  			}
>>>  
>>>  			/* MADV_FREE page check */
>>> -			if (!PageSwapBacked(page)) {
>>> +			if (__PageLazyFree(page)) {
>>>  				if (!PageDirty(page)) {
>>>  					/* Invalidate as we cleared the pte */
>>>  					mmu_notifier_invalidate_range(mm,
>>> @@ -1623,7 +1623,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>  				 * discarded. Remap the page to page table.
>>>  				 */
>>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>>> -				SetPageSwapBacked(page);
>>> +				ClearPageLazyFree(page);
>>>  				ret = false;
>>>  				page_vma_mapped_walk_done(&pvmw);
>>>  				break;
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index c1d3ca80ea10..d83f2cd4cdb8 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -563,7 +563,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
>>>  static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>>>  			    void *arg)
>>>  {
>>> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>>> +	if (PageLRU(page) && PageAnon(page) && !__PageLazyFree(page) &&
>>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>>>  		bool active = PageActive(page);
>>>  
>>> @@ -571,12 +571,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>>>  				       LRU_INACTIVE_ANON + active);
>>>  		ClearPageActive(page);
>>>  		ClearPageReferenced(page);
>>> -		/*
>>> -		 * lazyfree pages are clean anonymous pages. They have
>>> -		 * SwapBacked flag cleared to distinguish normal anonymous
>>> -		 * pages
>>> -		 */
>>> -		ClearPageSwapBacked(page);
>>> +		SetPageLazyFree(page);
>>>  		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
>>>  
>>>  		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
>>> @@ -678,7 +673,7 @@ void deactivate_page(struct page *page)
>>>   */
>>>  void mark_page_lazyfree(struct page *page)
>>>  {
>>> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>>> +	if (PageLRU(page) && PageAnon(page) && !__PageLazyFree(page) &&
>>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>>>  		struct pagevec *pvec = &get_cpu_var(lru_lazyfree_pvecs);
>>>  
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index eca49a1c2f68..40bb41ada2d2 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1043,8 +1043,7 @@ static void page_check_dirty_writeback(struct page *page,
>>>  	 * Anonymous pages are not handled by flushers and must be written
>>>  	 * from reclaim context. Do not stall reclaim based on them
>>>  	 */
>>> -	if (!page_is_file_cache(page) ||
>>> -	    (PageAnon(page) && !PageSwapBacked(page))) {
>>> +	if (!page_is_file_cache(page) || PageLazyFree(page)) {
>>>  		*dirty = false;
>>>  		*writeback = false;
>>>  		return;
>>> @@ -1235,7 +1234,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>  		 * Try to allocate it some swap space here.
>>>  		 * Lazyfree page could be freed directly
>>>  		 */
>>> -		if (PageAnon(page) && PageSwapBacked(page)) {
>>> +		if (PageAnon(page) && !__PageLazyFree(page)) {
>>>  			if (!PageSwapCache(page)) {
>>>  				if (!(sc->gfp_mask & __GFP_IO))
>>>  					goto keep_locked;
>>> @@ -1411,7 +1410,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>  			}
>>>  		}
>>>  
>>> -		if (PageAnon(page) && !PageSwapBacked(page)) {
>>> +		if (PageLazyFree(page)) {
>>>  			/* follow __remove_mapping for reference */
>>>  			if (!page_ref_freeze(page, 1))
>>>  				goto keep_locked;
>>>
>>
>> I still prefer something like
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index fd6d4670ccc3..7538501230bd 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -63,6 +63,10 @@
>>   * page_waitqueue(page) is a wait queue of all tasks waiting for the page
>>   * to become unlocked.
>>   *
>> + * PG_swapbacked used with anonymous pages (PageAnon()) indicates that a
>> + * page is backed by swap. Anonymous pages without PG_swapbacked are
>> + * pages that can be lazily freed (e.g., MADV_FREE) on demand.
>> + *
>>   * PG_uptodate tells whether the page's contents is valid.  When a read
>>   * completes, the page becomes uptodate, unless a disk I/O error happened.
>>   *
> 
> Why not just send a formal patch?  So Andrew can just pick anything he
> likes.  I am totally OK with that.

Because you're working on cleaning this up.

> 
>> and really don't like the use of !__PageLazyFree() instead of PageSwapBacked().
> 
> If adopted, !__PageLazyFree() should only be used in the context where
> we really want to check whether pages are freed lazily.  Otherwise,
> PageSwapBacked() should be used.
> 

Yeah, and once again, personally, I don't like this approach. E.g.,
ClearPageLazyFree() sets PG_swapbacked. You already have to be aware
that this is a single flag being used in the background and what the
implications are. IMHO, in no way better than the current approach. I
prefer better documentation instead.

But I am just a reviewer and not a maintainer, so it's just my 2 cents.

-- 
Thanks,

David / dhildenb

