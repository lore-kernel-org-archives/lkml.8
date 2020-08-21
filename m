Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DD720656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgHUKNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:13:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUKNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:13:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8F65AE38;
        Fri, 21 Aug 2020 10:14:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B8F31E1312; Fri, 21 Aug 2020 12:13:33 +0200 (CEST)
Date:   Fri, 21 Aug 2020 12:13:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200821101333.GA3432@quack2.suse.cz>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
 <20200811214255.GE6353@xz-x1>
 <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1>
 <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-08-20 15:01:00, Linus Torvalds wrote:
> On Thu, Aug 20, 2020 at 2:54 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > I kind of prefer the new suggestion to remove code rather than adding new
> > codes.  I definitely don't know enough on the side effect of it, especially
> > performance-wise on either ksm or swap, but... IIUC the worst case is we'll get
> > some perf report later on, and it seems also not hard to revert the patch later
> > if we want.
> 
> Well, would you be willing to try this patch out?
> 
> After you apply that patch, you should be able to remove the
> should_force_cow_break() games entirely, because a write to the page
> should always break cow towards the writer if there are any GUP users
> around (put another way: away from the GUP).
> 
> However, to make the test meaningful, it really should do some swap testing too.
> 
>             Linus

> From f41082844ea82ad1278e167fe6e973fa4efc974a Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 11 Aug 2020 14:23:04 -0700
> Subject: [PATCH] Trial do_wp_page() simplification
> 
> How about we just make sure we're the only possible valid user fo the
> page before we bother to reuse it?
> 
> Simplify, simplify, simplify.
> 
> And get rid of the nasty serialization on the page lock at the same time.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  mm/memory.c | 58 +++++++++++++++--------------------------------------
>  1 file changed, 16 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 602f4283122f..a43004dd2ff6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2927,50 +2927,24 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	 * not dirty accountable.
>  	 */
>  	if (PageAnon(vmf->page)) {
> -		int total_map_swapcount;
> -		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
> -					   page_count(vmf->page) != 1))
> +		struct page *page = vmf->page;
> +
> +		if (page_count(page) != 1)
> +			goto copy;
> +		if (!trylock_page(page))
> +			goto copy;
> +		if (page_mapcount(page) != 1 && page_count(page) != 1) {

So this condition looks strange to me... Did you mean:

		if (page_mapcount(page) != 1 || page_count(page) != 1)

? Because page mapcount is >= 1 here, and if mapcount is > 1, then page_count
is certainly greater than 1 as well...

> +			unlock_page(page);
>  			goto copy;
> -		if (!trylock_page(vmf->page)) {
> -			get_page(vmf->page);
> -			pte_unmap_unlock(vmf->pte, vmf->ptl);
> -			lock_page(vmf->page);
> -			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -					vmf->address, &vmf->ptl);
> -			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
> -				update_mmu_tlb(vma, vmf->address, vmf->pte);
> -				unlock_page(vmf->page);
> -				pte_unmap_unlock(vmf->pte, vmf->ptl);
> -				put_page(vmf->page);
> -				return 0;
> -			}
> -			put_page(vmf->page);
> -		}
> -		if (PageKsm(vmf->page)) {

Also I know nothing about KSM but looking at reuse_ksm_page() I can see it
plays some tricks with page index & mapping even for pages with page_count
== 1 so you cannot just drop those bits AFAICT.

> -			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
> -						     vmf->address);
> -			unlock_page(vmf->page);
> -			if (!reused)
> -				goto copy;
> -			wp_page_reuse(vmf);
> -			return VM_FAULT_WRITE;
> -		}
> -		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {

Also I'm not sure if dropping this is safe for THP - reuse_swap_page()
seems to be a misnomer and seems to do also some THP handling. In
particular a comment before page_trans_huge_mapcount() states that
page_mapcount() isn't fully accurate for THP and page_trans_huge_mapcount()
should be used instead for checking whether a copy is needed on write fault.

									Honza
> -			if (total_map_swapcount == 1) {
> -				/*
> -				 * The page is all ours. Move it to
> -				 * our anon_vma so the rmap code will
> -				 * not search our parent or siblings.
> -				 * Protected against the rmap code by
> -				 * the page lock.
> -				 */
> -				page_move_anon_rmap(vmf->page, vma);
> -			}
> -			unlock_page(vmf->page);
> -			wp_page_reuse(vmf);
> -			return VM_FAULT_WRITE;
>  		}
> -		unlock_page(vmf->page);
> +		/*
> +		 * Ok, we've got the only map reference, and the only
> +		 * page count reference, and the page is locked,
> +		 * it's dark out, and we're wearing sunglasses. Hit it.
> +		 */
> +		wp_page_reuse(vmf);
> +		unlock_page(page);
> +		return VM_FAULT_WRITE;
>  	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
>  					(VM_WRITE|VM_SHARED))) {
>  		return wp_page_shared(vmf);
> -- 
> 2.28.0.218.gc12ef3d349
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
