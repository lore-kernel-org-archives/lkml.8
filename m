Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA99C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB522076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgDOChI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:37:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:51829 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgDOChE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:37:04 -0400
IronPort-SDR: xfJ8WIxWazuE5u/v+FHd1vQq7G+Nar+3vYb4PVVbw/BY0JP1GzlgfDm89s5fEl42XVNelMVU6F
 tfhIf0QlzHhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 19:37:03 -0700
IronPort-SDR: AMHlRo+LO8uj3ZNUS2Hd9uh8XI3zarbgrcH/3NmesvnteyCS8bb+RX/kbl54GrOnBDo+9cRSR5
 uWJfhv4Ycfhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="454765081"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2020 19:37:01 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
        <87a73f7d71.fsf@yhuang-dev.intel.com> <20200413133150.GA810380@xps-13>
        <87wo6i6efn.fsf@yhuang-dev.intel.com> <20200414130520.GF810380@xps-13>
Date:   Wed, 15 Apr 2020 10:37:00 +0800
In-Reply-To: <20200414130520.GF810380@xps-13> (Andrea Righi's message of "Tue,
        14 Apr 2020 15:05:20 +0200")
Message-ID: <87v9m1zd83.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Tue, Apr 14, 2020 at 09:31:24AM +0800, Huang, Ying wrote:
>> Andrea Righi <andrea.righi@canonical.com> writes:
>> 
>> > On Mon, Apr 13, 2020 at 09:00:34PM +0800, Huang, Ying wrote:
>> >> Andrea Righi <andrea.righi@canonical.com> writes:
>> >> 
>> >> [snip]
>> >> 
>> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> >> > index ebed37bbf7a3..c71abc8df304 100644
>> >> > --- a/mm/swap_state.c
>> >> > +++ b/mm/swap_state.c
>> >> > @@ -20,6 +20,7 @@
>> >> >  #include <linux/migrate.h>
>> >> >  #include <linux/vmalloc.h>
>> >> >  #include <linux/swap_slots.h>
>> >> > +#include <linux/oom.h>
>> >> >  #include <linux/huge_mm.h>
>> >> >  
>> >> >  #include <asm/pgtable.h>
>> >> > @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
>> >> >  	max_pages = 1 << READ_ONCE(page_cluster);
>> >> >  	if (max_pages <= 1)
>> >> >  		return 1;
>> >> > +	/*
>> >> > +	 * If current task is using too much memory or swapoff is running
>> >> > +	 * simply use the max readahead size. Since we likely want to load a
>> >> > +	 * lot of pages back into memory, using a fixed-size max readhaead can
>> >> > +	 * give better performance in this case.
>> >> > +	 */
>> >> > +	if (oom_task_origin(current))
>> >> > +		return max_pages;
>> >> >  
>> >> >  	hits = atomic_xchg(&swapin_readahead_hits, 0);
>> >> >  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
>> >> 
>> >> Thinks this again.  If my understanding were correct, the accessing
>> >> pattern during swapoff is sequential, why swap readahead doesn't work?
>> >> If so, can you root cause that firstly?
>> >
>> > Theoretically if the pattern is sequential the current heuristic should
>> > already select a big readahead size, but apparently it's not doing that.
>> >
>> > I'll repeat my tests tracing the readahead size during swapoff to see
>> > exactly what's going on here.
>> 
>> I haven't verify it.  It may be helpful to call lookup_swap_cache()
>> before swapin_readahead() in unuse_pte_range().  The theory behind it is
>> to update the swap readahead statistics via lookup_swap_cache().
>
> I did more tests trying to collect some useful information.
>
> In particular I've been focusing at tracing the distribution of the
> values returned by swapin_nr_pages() in different scenarios.
>
> To do so I made swapin_nr_pages() trace-able and I used the following
> bcc command to measure the distrubution of the returned values:
>
>  # argdist-bpfcc -c -C 'r::swapin_nr_pages(unsigned long offset):unsigned long:$retval'
>
> I've collected this metric in the following scenarios:
>   - 5.6 vanilla
>   - 5.6 + lookup_swap_cache() before swapin_readahead() in
>     unuse_pte_range()
>   - 5.6 + atomic_inc(&swapin_readahead_hits) before swapin_readahead()
>     in unuse_pte_range()
>   - 5.6 + swapin_readahead_hits=last_readahead_pages (in the atomic way)
>     before swapin_readahead() in unuse_pte_range()
>
> Each kernel has been tested both with swappiness=0 and swappiness=60.
> Results are pretty much identical changing the swappiness, so I'm just
> reporting the default case here (w/ swappiness=60).
>
> Result
> ======
>
>  = swapoff performance (elapsed time) =
>
>  vanilla                 22.09s
>  lookup_swap_cache()     23.87s
>  hits++                  16.10s
>  hits=last_ra_pages       8.81s
>
>  = swapin_nr_pages() $retval distribution =
>
> 5.6 vanilla:
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> 	COUNT      EVENT
> 	36948      $retval = 8
> 	44151      $retval = 4
> 	49290      $retval = 1
> 	527771     $retval = 2
>
> 5.6 lookup_swap_cache() before swapin_readahead():
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> 	COUNT      EVENT
> 	13093      $retval = 1
> 	56703      $retval = 8
> 	123067     $retval = 2
> 	366118     $retval = 4
>
> 5.6 atomic_inc(&swapin_readahead_hits) before swapin_readahead():
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> 	COUNT      EVENT
> 	2589       $retval = 1
> 	8016       $retval = 2
> 	40021      $retval = 8
> 	566038     $retval = 4
>
> 5.6 swapin_readahead_hits=last_readahead_pages before swapin_readahead():
> r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> 	COUNT      EVENT
> 	785        $retval = 2
> 	1072       $retval = 1
> 	21844      $retval = 4
> 	644168     $retval = 8
>
> In the vanilla case, the readahead heuristic seems to choose 2 pages
> most of the time. This is because we are not properly considering the
> hits (hits are always 0 in the swapoff code path) and, as you correctly
> pointed out, we can fix this by calling lookup_swap_cache() in
> unuse_pte_range() before calling swapin_readahead().
>
> With this change the distribution of the readahead size moves more
> toward 4 pages, but we still have some 2s. That looks good, however it
> doesn't seem to speed up swapoff very much... maybe because calling
> lookup_swap_cache() introduces a small overhead? (still need to
> investigate about this theory).
>
> In the next test I've tried to always increment hits by 1 before calling
> swapin_readahead() in unuse_pte_range(). This is basically cheating,
> because I'm faking the hit ratio, forcing the heuristic to use a larger
> readahead size; in fact, the readahead size moves even more toward 4
> pages and swapoff performance are a little better now.
>
> Pushing even more the "cheating" I can pretend that the previous
> readahead was all hits (swapin_readahead_hits=last_readahead_pages), so
> I'm forcing the heuristic to move toward the max size and keep using it.
> The result here is pretty much identical to my fixed-size patch, because
> swapin_nr_pages() returns the max readahead size pretty much all the
> time during swapoff (8 pages or, more in general, vm.page-cluster).
>
> Personally I don't like very much forcing the heuristic in this way,
> it'd be nice if it would just work by accounting the proper hit ratio
> (so just by adding lookup_swap_cache() as you correctly suggested), but
> this solution doesn't seem to improve performance in reality. For this
> reason I still think we should consider the swapoff scenario like a
> special one and somehow bypass the readahead heuristic and always return
> the max readahead size.
>
> Looking at the hits of the previous step in the swapoff case just
> doesn't work, because we may have some misses, but they will become hits
> very soon, since we are reading all the swapped out pages back into
> memory. This is why using the max readahead size gives better
> swapoff performance.
>
> What do you think?

From your description, it appears that you are using cluster readahead
instead of vma readahead.  Can you verify this via,

# cat /sys/kernel/mm/swap/vma_ra_enabled

And if it returns false, you can enable it via,

# echo 1 > /sys/kernel/mm/swap/vma_ra_enabled

Because now swapoff code swapin pages in the page table order instead of
the swap entry order.  But this will turn the sequential disk read to
random disk read too.  Let's see the performance results.

And please make sure that in unuse_pte_range(), after
lookup_swap_cache() returns non-NULL page, it's unnecessary to call
swapin_readahead().

Best Regards,
Huang, Ying

> Thanks,
> -Andrea
