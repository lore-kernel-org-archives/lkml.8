Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC9820C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgIDLk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:40:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgIDLk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:40:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E590B7FC;
        Fri,  4 Sep 2020 11:40:57 +0000 (UTC)
Date:   Fri, 4 Sep 2020 13:40:52 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm,hwpoison: Take free pages off the buddy freelists
Message-ID: <20200904114043.GA4037@linux>
References: <20200902094510.10727-1-osalvador@suse.de>
 <20200902094510.10727-2-osalvador@suse.de>
 <20200904020205.GA32236@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904020205.GA32236@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:02:05AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Sep 02, 2020 at 11:45:07AM +0200, Oscar Salvador wrote:
> > The crux of the matter is that historically we left poisoned pages
> > in the buddy system because we have some checks in place when
> > allocating a page that a gatekeeper for poisoned pages.
> > Unfortunately, we do have other users (e.g: compaction [1]) that scan
> > buddy freelists and try to get a page from there without checking
> > whether the page is HWPoison.
> > 
> > As I stated already, I think it is fundamentally wrong to keep
> > HWPoison pages within the buddy systems, checks in place or not.
> > 
> > Let us fix this we same way we did for soft_offline [2], and take
> > the page off the buddy freelist, so it is completely unreachable.
> > 
> > Note that this is fairly simple to trigger, as we only need
> > to poison free buddy pages (madvise MADV_HWPOISON) and then we need
> > to run some sort of memory stress system.
> > 
> > Just for a matter of reference, I put a dump_page in compaction_alloc
> > to trigger for HWPoison patches:
> > 
> > kernel: page:0000000012b2982b refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1d5db
> > kernel: flags: 0xfffffc0800000(hwpoison)
> > kernel: raw: 000fffffc0800000 ffffea00007573c8 ffffc90000857de0 0000000000000000
> > kernel: raw: 0000000000000001 0000000000000000 00000001ffffffff 0000000000000000
> > kernel: page dumped because: compaction_alloc
> > 
> > kernel: CPU: 4 PID: 123 Comm: kcompactd0 Tainted: G            E     5.9.0-rc2-mm1-1-default+ #5
> > kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> > kernel: Call Trace:
> > kernel:  dump_stack+0x6d/0x8b
> > kernel:  compaction_alloc+0xb2/0xc0
> > kernel:  migrate_pages+0x2a6/0x12a0
> > kernel:  ? isolate_freepages+0xc80/0xc80
> > kernel:  ? __ClearPageMovable+0xb0/0xb0
> > kernel:  compact_zone+0x5eb/0x11c0
> > kernel:  ? finish_task_switch+0x74/0x300
> > kernel:  ? lock_timer_base+0xa8/0x170
> > kernel:  proactive_compact_node+0x89/0xf0
> > kernel:  ? kcompactd+0x2d0/0x3a0
> > kernel:  kcompactd+0x2d0/0x3a0
> > kernel:  ? finish_wait+0x80/0x80
> > kernel:  ? kcompactd_do_work+0x350/0x350
> > kernel:  kthread+0x118/0x130
> > kernel:  ? kthread_associate_blkcg+0xa0/0xa0
> > kernel:  ret_from_fork+0x22/0x30
> 
> Thanks for spotting this.
> 
> > After that, if e.g: someone faults in the page, that someone will get killed
> > unexpectedly.
> > 
> > [1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
> > [2] https://patchwork.kernel.org/patch/11694847/
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >  mm/memory-failure.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 696505f56910..d349dcb45056 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1325,6 +1325,7 @@ int memory_failure(unsigned long pfn, int flags)
> >  	struct dev_pagemap *pgmap;
> >  	int res;
> >  	unsigned long page_flags;
> > +	bool retry = true;
> >  
> >  	if (!sysctl_memory_failure_recovery)
> >  		panic("Memory failure on page %lx", pfn);
> > @@ -1364,10 +1365,20 @@ int memory_failure(unsigned long pfn, int flags)
> >  	 * In fact it's dangerous to directly bump up page count from 0,
> >  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
> >  	 */
> > +try_again:
> >  	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
> >  		if (is_free_buddy_page(p)) {
> > -			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> > -			return 0;
> > +			if (take_page_off_buddy(p)) {
> > +				action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
> > +				return 0;
> > +			} else {
> > +				/* We lost the race, try again */
> > +				if (retry) {
> > +					retry = false;
> > +					goto try_again;
> > +				}
> 
> You might need add calling action_result() here.

Yeah, I figured we would need something like:

action_result(pfn, MF_MSG_BUDDY_2ND, MF_FAILED) ?
Although checking other parts of the code, MF_IGNORED can suit here as well,
and it is probably better.

> And the following block also handles buddy pages, so you could also call
> take_page_off_buddy() here?
> 
>         /*
>          * We ignore non-LRU pages for good reasons.
>          * - PG_locked is only well defined for LRU pages and a few others
>          * - to avoid races with __SetPageLocked()
>          * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
>          * The check (unnecessarily) ignores LRU pages being isolated and
>          * walked by the page reclaim code, however that's not a big loss.
>          */
>         shake_page(p, 0);
>         /* shake_page could have turned it free. */
>         if (!PageLRU(p) && is_free_buddy_page(p)) {
>                 if (flags & MF_COUNT_INCREASED)
>                         action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
>                 else
>                         action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
>                 return 0;
>         }
> 
> Or if get_hwpoison_page() handles retry inside it as will be done in patch 3/4,
> we don't need this block any more?

I __think__ we do not need the following anymore:

         if (!PageLRU(p) && is_free_buddy_page(p)) {
                 if (flags & MF_COUNT_INCREASED)
                         action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
                 else
                         action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
                 return 0;
         }

We have this block because shake_page() (among other things) sends pcp-pages
back to the buddy freelists, so we could have the chance to handle the page.
Since we will be doing that in get_hwpoison_page, and such scenario should
have been handled in the block from above, I think it is safe to skip that
block.

But I think that the skape_page() has to stay as it flushes pages from pagevecs
to their respective LRU lists, otherwise we could do the wrong thing in:

	if (!PageTransTail(p) && !PageLRU(p))
		goto identify_page_state;

So, I will send V2 with a 5th patch cleaning that up as I do not want to get
it convulated with the fix itself.

thanks Naoya

-- 
Oscar Salvador
SUSE L3
