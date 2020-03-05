Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1291CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968A2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEElc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:41:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:21012 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEElc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:41:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 20:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="240684644"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2020 20:41:27 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] mm: Add PageLayzyFree() helper functions for MADV_FREE
References: <20200304081732.563536-1-ying.huang@intel.com>
        <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com>
Date:   Thu, 05 Mar 2020 12:41:26 +0800
In-Reply-To: <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com> (David
        Hildenbrand's message of "Wed, 4 Mar 2020 09:28:37 +0100")
Message-ID: <87y2sf1ki1.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 04.03.20 09:17, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Now PageSwapBacked() is used as the helper function to check whether
>> pages have been freed lazily via MADV_FREE.  This isn't very obvious.
>> So Dave suggested to add PageLazyFree() family helper functions to
>> improve the code readability.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> ---
>> 
>> Changelog:
>> 
>> v2:
>> 
>> - Avoid code bloat via removing VM_BUG_ON_PAGE(), which doesn't exist
>>   in the original code.  Now there is no any text/data/bss size
>>   change.
>> 
>> - Fix one wrong replacement in try_to_unmap_one().
>> ---
>>  include/linux/page-flags.h | 25 +++++++++++++++++++++++++
>>  mm/rmap.c                  |  4 ++--
>>  mm/swap.c                  | 11 +++--------
>>  mm/vmscan.c                |  7 +++----
>>  4 files changed, 33 insertions(+), 14 deletions(-)
>> 
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 49c2697046b9..192b593750d3 100644
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
>
> "They don't have PG_swapbacked set, to distinguish them from normal
> anonymous pages." ?

Thanks!

>> + */
>> +static __always_inline int __PageLazyFree(struct page *page)
>> +{
>> +	return !PageSwapBacked(page);
>> +}
>> +
>> +static __always_inline int PageLazyFree(struct page *page)
>> +{
>> +	return PageAnon(page) && __PageLazyFree(page);
>> +}
>> +
>> +static __always_inline void SetPageLazyFree(struct page *page)
>> +{
>> +	ClearPageSwapBacked(page);
>> +}
>> +
>> +static __always_inline void ClearPageLazyFree(struct page *page)
>> +{
>> +	SetPageSwapBacked(page);
>> +}
>> +
>>  u64 stable_page_flags(struct page *page);
>>  
>>  static inline int PageUptodate(struct page *page)
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1c02adaa233e..6ec96c8e7826 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1609,7 +1609,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  			}
>>  
>>  			/* MADV_FREE page check */
>> -			if (!PageSwapBacked(page)) {
>> +			if (__PageLazyFree(page)) {
>>  				if (!PageDirty(page)) {
>>  					/* Invalidate as we cleared the pte */
>>  					mmu_notifier_invalidate_range(mm,
>> @@ -1623,7 +1623,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  				 * discarded. Remap the page to page table.
>>  				 */
>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>> -				SetPageSwapBacked(page);
>> +				ClearPageLazyFree(page);
>>  				ret = false;
>>  				page_vma_mapped_walk_done(&pvmw);
>>  				break;
>> diff --git a/mm/swap.c b/mm/swap.c
>> index c1d3ca80ea10..d83f2cd4cdb8 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -563,7 +563,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
>>  static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>>  			    void *arg)
>>  {
>> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>> +	if (PageLRU(page) && PageAnon(page) && !__PageLazyFree(page) &&
>
> See my comment below
>
>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>>  		bool active = PageActive(page);
>>  
>> @@ -571,12 +571,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
>>  				       LRU_INACTIVE_ANON + active);
>>  		ClearPageActive(page);
>>  		ClearPageReferenced(page);
>> -		/*
>> -		 * lazyfree pages are clean anonymous pages. They have
>> -		 * SwapBacked flag cleared to distinguish normal anonymous
>> -		 * pages
>> -		 */
>> -		ClearPageSwapBacked(page);
>> +		SetPageLazyFree(page);
>>  		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
>>  
>>  		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
>> @@ -678,7 +673,7 @@ void deactivate_page(struct page *page)
>>   */
>>  void mark_page_lazyfree(struct page *page)
>>  {
>> -	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
>> +	if (PageLRU(page) && PageAnon(page) && !__PageLazyFree(page) &&
>
> See my comment below.
>
>>  	    !PageSwapCache(page) && !PageUnevictable(page)) {
>>  		struct pagevec *pvec = &get_cpu_var(lru_lazyfree_pvecs);
>>  
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index eca49a1c2f68..40bb41ada2d2 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1043,8 +1043,7 @@ static void page_check_dirty_writeback(struct page *page,
>>  	 * Anonymous pages are not handled by flushers and must be written
>>  	 * from reclaim context. Do not stall reclaim based on them
>>  	 */
>> -	if (!page_is_file_cache(page) ||
>> -	    (PageAnon(page) && !PageSwapBacked(page))) {
>> +	if (!page_is_file_cache(page) || PageLazyFree(page)) {
>>  		*dirty = false;
>>  		*writeback = false;
>>  		return;
>> @@ -1235,7 +1234,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>  		 * Try to allocate it some swap space here.
>>  		 * Lazyfree page could be freed directly
>>  		 */
>> -		if (PageAnon(page) && PageSwapBacked(page)) {
>> +		if (PageAnon(page) && !__PageLazyFree(page)) {
>
> I don't think this chunk makes this code easier to understand. I'd just
> keep this as is. IOW, I prefer PageSwapBacked() over !__PageLazyFree().
>
>
> In general, I don't think this patch really improves the situation ...
> it's only a handful of places where this change slightly makes the code
> easier to understand. And there, only slightly ... I'd prefer better
> comments instead (e.g., in PageAnon()), documenting what it means for a
> anon page to either have PageSwapBacked() set or not.

Personally, I still prefer the better named functions than the comments
here and there.  But I can understand that people may have different
flavor.

Best Regards,
Huang, Ying
