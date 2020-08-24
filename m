Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000A920738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHXPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:43:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:54606 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbgHXPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:38:33 -0400
Received: from [192.168.15.190]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kAEXY-00105K-KD; Mon, 24 Aug 2020 18:37:44 +0300
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jan Kara <jack@suse.cz>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <42bc9a68-ef9e-2542-0b21-392a7f47bd74@virtuozzo.com>
 <20200824143010.GG24877@quack2.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <dd6eb3e6-2797-1cf3-e1af-62a809ce83f2@virtuozzo.com>
Date:   Mon, 24 Aug 2020 18:37:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824143010.GG24877@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2020 17:30, Jan Kara wrote:
> On Mon 24-08-20 11:36:22, Kirill Tkhai wrote:
>> On 22.08.2020 02:49, Peter Xu wrote:
>>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>>
>>> How about we just make sure we're the only possible valid user fo the
>>> page before we bother to reuse it?
>>>
>>> Simplify, simplify, simplify.
>>>
>>> And get rid of the nasty serialization on the page lock at the same time.
>>>
>>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> [peterx: add subject prefix]
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  mm/memory.c | 59 +++++++++++++++--------------------------------------
>>>  1 file changed, 17 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 602f4283122f..cb9006189d22 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -2927,50 +2927,25 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>  	 * not dirty accountable.
>>>  	 */
>>>  	if (PageAnon(vmf->page)) {
>>> -		int total_map_swapcount;
>>> -		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
>>> -					   page_count(vmf->page) != 1))
>>> +		struct page *page = vmf->page;
>>> +
>>> +		/* PageKsm() doesn't necessarily raise the page refcount */
>>
>> No, this is wrong. PageKSM() always raises refcount.
> 
> OK, then I'm confused. The comment before get_ksm_page() states:
> 
>  * get_ksm_page: checks if the page indicated by the stable node
>  * is still its ksm page, despite having held no reference to it.
>  * In which case we can trust the content of the page, and it
>  * returns the gotten page; but if the page has now been zapped,
>  * remove the stale node from the stable tree and return NULL.
> ...
>  * You would expect the stable_node to hold a reference to the ksm page.
>  * But if it increments the page's count, swapping out has to wait for
>  * ksmd to come around again before it can free the page, which may take
>  * seconds or even minutes: much too unresponsive.  So instead we use a
>  * "keyhole reference": access to the ksm page from the stable node peeps
>  * out through its keyhole to see if that page still holds the right key,
>  * pointing back to this stable node.
> 
> So this all seems to indicate that KSM doesn't hold a proper page reference
> and relies on anyone making page writeable to change page->mapping so that
> KSM notices this and doesn't use the page anymore... Am I missing
> something?

Sure, KSM does not increment page counter, when a page becomes PageKsm().
Is patch comment about that? Even if so, I don't understand what this
comment is about. "PageKsm() does not take additional counter" is not
a reason the page can't be reused there. The reason is that readers
of this page may increase a counter without taking the lock, so
this page_count() == 1 under the lock does not guarantee anything.

>> There was another
>> problem: KSM may raise refcount without lock_page(), and only then it
>> takes the lock.  See get_ksm_page(GET_KSM_PAGE_NOLOCK) for the details.
>>
>> So, reliable protection against parallel access requires to freeze page
>> counter, which is made in reuse_ksm_page().
> 
> OK, this as well.
> 
> 								Honza
> 
>>
>>> +		if (PageKsm(page) || page_count(page) != 1)
>>> +			goto copy;
>>> +		if (!trylock_page(page))
>>> +			goto copy;
>>> +		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
>>> +			unlock_page(page);
>>>  			goto copy;
>>> -		if (!trylock_page(vmf->page)) {
>>> -			get_page(vmf->page);
>>> -			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -			lock_page(vmf->page);
>>> -			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>> -					vmf->address, &vmf->ptl);
>>> -			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
>>> -				update_mmu_tlb(vma, vmf->address, vmf->pte);
>>> -				unlock_page(vmf->page);
>>> -				pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -				put_page(vmf->page);
>>> -				return 0;
>>> -			}
>>> -			put_page(vmf->page);
>>> -		}
>>> -		if (PageKsm(vmf->page)) {
>>> -			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
>>> -						     vmf->address);
>>> -			unlock_page(vmf->page);
>>> -			if (!reused)
>>> -				goto copy;
>>> -			wp_page_reuse(vmf);
>>> -			return VM_FAULT_WRITE;
>>> -		}
>>> -		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
>>> -			if (total_map_swapcount == 1) {
>>> -				/*
>>> -				 * The page is all ours. Move it to
>>> -				 * our anon_vma so the rmap code will
>>> -				 * not search our parent or siblings.
>>> -				 * Protected against the rmap code by
>>> -				 * the page lock.
>>> -				 */
>>> -				page_move_anon_rmap(vmf->page, vma);
>>> -			}
>>> -			unlock_page(vmf->page);
>>> -			wp_page_reuse(vmf);
>>> -			return VM_FAULT_WRITE;
>>>  		}
>>> -		unlock_page(vmf->page);
>>> +		/*
>>> +		 * Ok, we've got the only map reference, and the only
>>> +		 * page count reference, and the page is locked,
>>> +		 * it's dark out, and we're wearing sunglasses. Hit it.
>>> +		 */
>>> +		wp_page_reuse(vmf);
>>> +		unlock_page(page);
>>> +		return VM_FAULT_WRITE;
>>>  	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
>>>  					(VM_WRITE|VM_SHARED))) {
>>>  		return wp_page_shared(vmf);
>>>
>>

