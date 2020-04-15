Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A72C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE3D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393688AbgDOHdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:33:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52211 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgDOHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:32:56 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jOcXQ-0006Xs-J1
        for linux-kernel@vger.kernel.org; Wed, 15 Apr 2020 07:32:48 +0000
Received: by mail-wr1-f71.google.com with SMTP id y1so10133951wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MSC60tp9kRd115xx89W68VO0yl8bIwuRKlWrEsoTLMQ=;
        b=Q25Hqgv5HlWSyd9Mx51U5Lnv0O+SPutzZYuhhzZsgx1bEBbtSWYVWJs529YwQ4cybl
         TFX8DHNEcEQqrA9OMnpqNgTB6azxwTHDthmY4U9eQpb3OSqkH+ZJSG1A/F3PoPX4VTai
         sYJPogeFgl10UULEDuyDkGEFAS40eFeLkuYxQJB6hwFel+Hn5zng0nLYYpptemKDfXIv
         +5R99RiXY6U6sCnOGUvduMZI+2GDFCgsk6NLp9YF0kqAqzR0rJUpCu+i8YIlbsessjME
         8McNY8dL5D6DfIDmSZ/Ud5RfaEug6iDBMdjWbfeGo+5DvgLS2RNT6EtMayxv3lS46cOR
         kfgg==
X-Gm-Message-State: AGi0Pub0qw55XrT0We8Fgzph00SxW2lesJu/OLDQ7eBE3CGCOTiKfY+w
        io13BfBTuG/gTJ1r1c+aos7gAFzr+xcflBiPoTeIoalPhMKP9laCTWR/lZDqLSFLpG0meUMdp6I
        Mu9sR7MslgWuNLYrtjDA1/kctFoq2mN4Aja5xLmcs2w==
X-Received: by 2002:a1c:9e42:: with SMTP id h63mr3557296wme.115.1586935968037;
        Wed, 15 Apr 2020 00:32:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypIq2o9IWjIecgbO+YQxf8WgBa5+rervdLrHwanzlQECdmRrsV8iWg62F1DNCc/1lVmdyXXMtg==
X-Received: by 2002:a1c:9e42:: with SMTP id h63mr3557260wme.115.1586935967606;
        Wed, 15 Apr 2020 00:32:47 -0700 (PDT)
Received: from localhost ([79.36.127.123])
        by smtp.gmail.com with ESMTPSA id y16sm22085240wrp.78.2020.04.15.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:32:47 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:32:39 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200415073239.GG810380@xps-13>
References: <20200413111810.GA801367@xps-13>
 <87a73f7d71.fsf@yhuang-dev.intel.com>
 <20200413133150.GA810380@xps-13>
 <87wo6i6efn.fsf@yhuang-dev.intel.com>
 <20200414130520.GF810380@xps-13>
 <87v9m1zd83.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9m1zd83.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:37:00AM +0800, Huang, Ying wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> > On Tue, Apr 14, 2020 at 09:31:24AM +0800, Huang, Ying wrote:
> >> Andrea Righi <andrea.righi@canonical.com> writes:
> >> 
> >> > On Mon, Apr 13, 2020 at 09:00:34PM +0800, Huang, Ying wrote:
> >> >> Andrea Righi <andrea.righi@canonical.com> writes:
> >> >> 
> >> >> [snip]
> >> >> 
> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> >> > index ebed37bbf7a3..c71abc8df304 100644
> >> >> > --- a/mm/swap_state.c
> >> >> > +++ b/mm/swap_state.c
> >> >> > @@ -20,6 +20,7 @@
> >> >> >  #include <linux/migrate.h>
> >> >> >  #include <linux/vmalloc.h>
> >> >> >  #include <linux/swap_slots.h>
> >> >> > +#include <linux/oom.h>
> >> >> >  #include <linux/huge_mm.h>
> >> >> >  
> >> >> >  #include <asm/pgtable.h>
> >> >> > @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
> >> >> >  	max_pages = 1 << READ_ONCE(page_cluster);
> >> >> >  	if (max_pages <= 1)
> >> >> >  		return 1;
> >> >> > +	/*
> >> >> > +	 * If current task is using too much memory or swapoff is running
> >> >> > +	 * simply use the max readahead size. Since we likely want to load a
> >> >> > +	 * lot of pages back into memory, using a fixed-size max readhaead can
> >> >> > +	 * give better performance in this case.
> >> >> > +	 */
> >> >> > +	if (oom_task_origin(current))
> >> >> > +		return max_pages;
> >> >> >  
> >> >> >  	hits = atomic_xchg(&swapin_readahead_hits, 0);
> >> >> >  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
> >> >> 
> >> >> Thinks this again.  If my understanding were correct, the accessing
> >> >> pattern during swapoff is sequential, why swap readahead doesn't work?
> >> >> If so, can you root cause that firstly?
> >> >
> >> > Theoretically if the pattern is sequential the current heuristic should
> >> > already select a big readahead size, but apparently it's not doing that.
> >> >
> >> > I'll repeat my tests tracing the readahead size during swapoff to see
> >> > exactly what's going on here.
> >> 
> >> I haven't verify it.  It may be helpful to call lookup_swap_cache()
> >> before swapin_readahead() in unuse_pte_range().  The theory behind it is
> >> to update the swap readahead statistics via lookup_swap_cache().
> >
> > I did more tests trying to collect some useful information.
> >
> > In particular I've been focusing at tracing the distribution of the
> > values returned by swapin_nr_pages() in different scenarios.
> >
> > To do so I made swapin_nr_pages() trace-able and I used the following
> > bcc command to measure the distrubution of the returned values:
> >
> >  # argdist-bpfcc -c -C 'r::swapin_nr_pages(unsigned long offset):unsigned long:$retval'
> >
> > I've collected this metric in the following scenarios:
> >   - 5.6 vanilla
> >   - 5.6 + lookup_swap_cache() before swapin_readahead() in
> >     unuse_pte_range()
> >   - 5.6 + atomic_inc(&swapin_readahead_hits) before swapin_readahead()
> >     in unuse_pte_range()
> >   - 5.6 + swapin_readahead_hits=last_readahead_pages (in the atomic way)
> >     before swapin_readahead() in unuse_pte_range()
> >
> > Each kernel has been tested both with swappiness=0 and swappiness=60.
> > Results are pretty much identical changing the swappiness, so I'm just
> > reporting the default case here (w/ swappiness=60).
> >
> > Result
> > ======
> >
> >  = swapoff performance (elapsed time) =
> >
> >  vanilla                 22.09s
> >  lookup_swap_cache()     23.87s
> >  hits++                  16.10s
> >  hits=last_ra_pages       8.81s
> >
> >  = swapin_nr_pages() $retval distribution =
> >
> > 5.6 vanilla:
> > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > 	COUNT      EVENT
> > 	36948      $retval = 8
> > 	44151      $retval = 4
> > 	49290      $retval = 1
> > 	527771     $retval = 2
> >
> > 5.6 lookup_swap_cache() before swapin_readahead():
> > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > 	COUNT      EVENT
> > 	13093      $retval = 1
> > 	56703      $retval = 8
> > 	123067     $retval = 2
> > 	366118     $retval = 4
> >
> > 5.6 atomic_inc(&swapin_readahead_hits) before swapin_readahead():
> > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > 	COUNT      EVENT
> > 	2589       $retval = 1
> > 	8016       $retval = 2
> > 	40021      $retval = 8
> > 	566038     $retval = 4
> >
> > 5.6 swapin_readahead_hits=last_readahead_pages before swapin_readahead():
> > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > 	COUNT      EVENT
> > 	785        $retval = 2
> > 	1072       $retval = 1
> > 	21844      $retval = 4
> > 	644168     $retval = 8
> >
> > In the vanilla case, the readahead heuristic seems to choose 2 pages
> > most of the time. This is because we are not properly considering the
> > hits (hits are always 0 in the swapoff code path) and, as you correctly
> > pointed out, we can fix this by calling lookup_swap_cache() in
> > unuse_pte_range() before calling swapin_readahead().
> >
> > With this change the distribution of the readahead size moves more
> > toward 4 pages, but we still have some 2s. That looks good, however it
> > doesn't seem to speed up swapoff very much... maybe because calling
> > lookup_swap_cache() introduces a small overhead? (still need to
> > investigate about this theory).
> >
> > In the next test I've tried to always increment hits by 1 before calling
> > swapin_readahead() in unuse_pte_range(). This is basically cheating,
> > because I'm faking the hit ratio, forcing the heuristic to use a larger
> > readahead size; in fact, the readahead size moves even more toward 4
> > pages and swapoff performance are a little better now.
> >
> > Pushing even more the "cheating" I can pretend that the previous
> > readahead was all hits (swapin_readahead_hits=last_readahead_pages), so
> > I'm forcing the heuristic to move toward the max size and keep using it.
> > The result here is pretty much identical to my fixed-size patch, because
> > swapin_nr_pages() returns the max readahead size pretty much all the
> > time during swapoff (8 pages or, more in general, vm.page-cluster).
> >
> > Personally I don't like very much forcing the heuristic in this way,
> > it'd be nice if it would just work by accounting the proper hit ratio
> > (so just by adding lookup_swap_cache() as you correctly suggested), but
> > this solution doesn't seem to improve performance in reality. For this
> > reason I still think we should consider the swapoff scenario like a
> > special one and somehow bypass the readahead heuristic and always return
> > the max readahead size.
> >
> > Looking at the hits of the previous step in the swapoff case just
> > doesn't work, because we may have some misses, but they will become hits
> > very soon, since we are reading all the swapped out pages back into
> > memory. This is why using the max readahead size gives better
> > swapoff performance.
> >
> > What do you think?
> 
> >From your description, it appears that you are using cluster readahead
> instead of vma readahead.  Can you verify this via,
> 
> # cat /sys/kernel/mm/swap/vma_ra_enabled

# cat /sys/kernel/mm/swap/vma_ra_enabled
true

However, it's still using the cluster readahead because I'm using a
swap file and nr_rotate_swap=1, so, according to the following, it's
never using the vma readahead:

 static inline bool swap_use_vma_readahead(void)
 {
         return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
 }

I'll investigate more on this, I think there's no reason to prevent the
usage of vma readahead if the underlying device is non-rotational.

> 
> And if it returns false, you can enable it via,
> 
> # echo 1 > /sys/kernel/mm/swap/vma_ra_enabled
> 
> Because now swapoff code swapin pages in the page table order instead of
> the swap entry order.  But this will turn the sequential disk read to
> random disk read too.  Let's see the performance results.
> 
> And please make sure that in unuse_pte_range(), after
> lookup_swap_cache() returns non-NULL page, it's unnecessary to call
> swapin_readahead().

This is what I was missing! Sorry about that, I was still calling
swapin_readahead() even if the page was already in case, that was
unnecessary overhead and it was messing up the hit ratio!

With lookup_swap_cache() applied properly eveything looks way better:

r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
	COUNT      EVENT
	378        $retval = 1
	2138       $retval = 2
	25365      $retval = 4
	105314     $retval = 8

swapof time: 9.87s

So, basically it gives the same performance result of my fixed-size
approach, but it's definitely a better and cleaner solution.

Just to make it clear, here's the patch that I applied (if it looks good
to you I can send another version with a better description):

 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fd47e6f7a86..cb9eb517178d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1944,7 +1944,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		vmf.pmd = pmd;
 		last_ra = atomic_read(&last_readahead_pages);
 		atomic_set(&swapin_readahead_hits, last_ra);
-		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
+		page = lookup_swap_cache(entry, vma, addr);
+		if (!page)
+			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
 		if (!page) {
 			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
 				goto try_next;

Thanks!
-Andrea
