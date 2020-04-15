Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940BBC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E53206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441209AbgDOMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:07:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368081AbgDOMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:00:20 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jOgiF-0001JT-II
        for linux-kernel@vger.kernel.org; Wed, 15 Apr 2020 12:00:15 +0000
Received: by mail-wr1-f70.google.com with SMTP id s11so5576624wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=paWID5GD2CyHtrfzE8kDJuv1xktaMYYpgt4XAytthsQ=;
        b=nuxAhJvVN3X9yYIE+M9D7JNv0V8Gv4c63f7uYvyeEWoaggC2lnsAH1+tRROa4JqlP5
         g3ePbox54I1VW5FiYM8u7cWq3vjFfsXbqx6h3ncgtDxGc8UKMw6G+b03IstaK79BOq3/
         /EJTFkZT/Etz3yw0d2KhdD5gJ7Xo46Mzcb3ciM5I/TLECZpwnnezL2idSO5lQLnbHKBI
         zL8QeeA8g7gRhjVYIqDW+QRRDErRuZ7QxRq7x7s3scaZmvd37D18OnjcU5r5W3my11cV
         G+aV+EBMdnq5DRq4hS4768C/ecTG63y2iB4BkrCo79Z79o9/GPT01x0HUNeE4nidHZWQ
         6Uww==
X-Gm-Message-State: AGi0PuZeQhHAXrep4NKf7ub+pVx/QHPXA7IAoZQzYckRJV+iP52IrPoA
        bPm1tA+KXJ6qFItBC9h2si9IJYmhTAJb/0rGdcDGspFtbIrJOAzjk3gm4gDe/wDt8OZE9693kZ4
        7a//3P1fF1AbwZA/wmcUufQzGuIv9UoV53lY3fq3I7A==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr4645559wmi.64.1586952014943;
        Wed, 15 Apr 2020 05:00:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+GtDSfKHIATCf0SYiqXqrxk4H7vO6NBFCxqPV0D+73FYw8IcG1dmtruTj9oEfRm0BzkKZww==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr4645529wmi.64.1586952014538;
        Wed, 15 Apr 2020 05:00:14 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id q10sm19362170wrv.95.2020.04.15.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 05:00:13 -0700 (PDT)
Date:   Wed, 15 Apr 2020 14:00:11 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200415120011.GI810380@xps-13>
References: <20200413111810.GA801367@xps-13>
 <87a73f7d71.fsf@yhuang-dev.intel.com>
 <20200413133150.GA810380@xps-13>
 <87wo6i6efn.fsf@yhuang-dev.intel.com>
 <20200414130520.GF810380@xps-13>
 <87v9m1zd83.fsf@yhuang-dev.intel.com>
 <20200415073239.GG810380@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415073239.GG810380@xps-13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:32:47AM +0200, Andrea Righi wrote:
> On Wed, Apr 15, 2020 at 10:37:00AM +0800, Huang, Ying wrote:
> > Andrea Righi <andrea.righi@canonical.com> writes:
> > 
> > > On Tue, Apr 14, 2020 at 09:31:24AM +0800, Huang, Ying wrote:
> > >> Andrea Righi <andrea.righi@canonical.com> writes:
> > >> 
> > >> > On Mon, Apr 13, 2020 at 09:00:34PM +0800, Huang, Ying wrote:
> > >> >> Andrea Righi <andrea.righi@canonical.com> writes:
> > >> >> 
> > >> >> [snip]
> > >> >> 
> > >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > >> >> > index ebed37bbf7a3..c71abc8df304 100644
> > >> >> > --- a/mm/swap_state.c
> > >> >> > +++ b/mm/swap_state.c
> > >> >> > @@ -20,6 +20,7 @@
> > >> >> >  #include <linux/migrate.h>
> > >> >> >  #include <linux/vmalloc.h>
> > >> >> >  #include <linux/swap_slots.h>
> > >> >> > +#include <linux/oom.h>
> > >> >> >  #include <linux/huge_mm.h>
> > >> >> >  
> > >> >> >  #include <asm/pgtable.h>
> > >> >> > @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
> > >> >> >  	max_pages = 1 << READ_ONCE(page_cluster);
> > >> >> >  	if (max_pages <= 1)
> > >> >> >  		return 1;
> > >> >> > +	/*
> > >> >> > +	 * If current task is using too much memory or swapoff is running
> > >> >> > +	 * simply use the max readahead size. Since we likely want to load a
> > >> >> > +	 * lot of pages back into memory, using a fixed-size max readhaead can
> > >> >> > +	 * give better performance in this case.
> > >> >> > +	 */
> > >> >> > +	if (oom_task_origin(current))
> > >> >> > +		return max_pages;
> > >> >> >  
> > >> >> >  	hits = atomic_xchg(&swapin_readahead_hits, 0);
> > >> >> >  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
> > >> >> 
> > >> >> Thinks this again.  If my understanding were correct, the accessing
> > >> >> pattern during swapoff is sequential, why swap readahead doesn't work?
> > >> >> If so, can you root cause that firstly?
> > >> >
> > >> > Theoretically if the pattern is sequential the current heuristic should
> > >> > already select a big readahead size, but apparently it's not doing that.
> > >> >
> > >> > I'll repeat my tests tracing the readahead size during swapoff to see
> > >> > exactly what's going on here.
> > >> 
> > >> I haven't verify it.  It may be helpful to call lookup_swap_cache()
> > >> before swapin_readahead() in unuse_pte_range().  The theory behind it is
> > >> to update the swap readahead statistics via lookup_swap_cache().
> > >
> > > I did more tests trying to collect some useful information.
> > >
> > > In particular I've been focusing at tracing the distribution of the
> > > values returned by swapin_nr_pages() in different scenarios.
> > >
> > > To do so I made swapin_nr_pages() trace-able and I used the following
> > > bcc command to measure the distrubution of the returned values:
> > >
> > >  # argdist-bpfcc -c -C 'r::swapin_nr_pages(unsigned long offset):unsigned long:$retval'
> > >
> > > I've collected this metric in the following scenarios:
> > >   - 5.6 vanilla
> > >   - 5.6 + lookup_swap_cache() before swapin_readahead() in
> > >     unuse_pte_range()
> > >   - 5.6 + atomic_inc(&swapin_readahead_hits) before swapin_readahead()
> > >     in unuse_pte_range()
> > >   - 5.6 + swapin_readahead_hits=last_readahead_pages (in the atomic way)
> > >     before swapin_readahead() in unuse_pte_range()
> > >
> > > Each kernel has been tested both with swappiness=0 and swappiness=60.
> > > Results are pretty much identical changing the swappiness, so I'm just
> > > reporting the default case here (w/ swappiness=60).
> > >
> > > Result
> > > ======
> > >
> > >  = swapoff performance (elapsed time) =
> > >
> > >  vanilla                 22.09s
> > >  lookup_swap_cache()     23.87s
> > >  hits++                  16.10s
> > >  hits=last_ra_pages       8.81s
> > >
> > >  = swapin_nr_pages() $retval distribution =
> > >
> > > 5.6 vanilla:
> > > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > > 	COUNT      EVENT
> > > 	36948      $retval = 8
> > > 	44151      $retval = 4
> > > 	49290      $retval = 1
> > > 	527771     $retval = 2
> > >
> > > 5.6 lookup_swap_cache() before swapin_readahead():
> > > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > > 	COUNT      EVENT
> > > 	13093      $retval = 1
> > > 	56703      $retval = 8
> > > 	123067     $retval = 2
> > > 	366118     $retval = 4
> > >
> > > 5.6 atomic_inc(&swapin_readahead_hits) before swapin_readahead():
> > > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > > 	COUNT      EVENT
> > > 	2589       $retval = 1
> > > 	8016       $retval = 2
> > > 	40021      $retval = 8
> > > 	566038     $retval = 4
> > >
> > > 5.6 swapin_readahead_hits=last_readahead_pages before swapin_readahead():
> > > r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
> > > 	COUNT      EVENT
> > > 	785        $retval = 2
> > > 	1072       $retval = 1
> > > 	21844      $retval = 4
> > > 	644168     $retval = 8
> > >
> > > In the vanilla case, the readahead heuristic seems to choose 2 pages
> > > most of the time. This is because we are not properly considering the
> > > hits (hits are always 0 in the swapoff code path) and, as you correctly
> > > pointed out, we can fix this by calling lookup_swap_cache() in
> > > unuse_pte_range() before calling swapin_readahead().
> > >
> > > With this change the distribution of the readahead size moves more
> > > toward 4 pages, but we still have some 2s. That looks good, however it
> > > doesn't seem to speed up swapoff very much... maybe because calling
> > > lookup_swap_cache() introduces a small overhead? (still need to
> > > investigate about this theory).
> > >
> > > In the next test I've tried to always increment hits by 1 before calling
> > > swapin_readahead() in unuse_pte_range(). This is basically cheating,
> > > because I'm faking the hit ratio, forcing the heuristic to use a larger
> > > readahead size; in fact, the readahead size moves even more toward 4
> > > pages and swapoff performance are a little better now.
> > >
> > > Pushing even more the "cheating" I can pretend that the previous
> > > readahead was all hits (swapin_readahead_hits=last_readahead_pages), so
> > > I'm forcing the heuristic to move toward the max size and keep using it.
> > > The result here is pretty much identical to my fixed-size patch, because
> > > swapin_nr_pages() returns the max readahead size pretty much all the
> > > time during swapoff (8 pages or, more in general, vm.page-cluster).
> > >
> > > Personally I don't like very much forcing the heuristic in this way,
> > > it'd be nice if it would just work by accounting the proper hit ratio
> > > (so just by adding lookup_swap_cache() as you correctly suggested), but
> > > this solution doesn't seem to improve performance in reality. For this
> > > reason I still think we should consider the swapoff scenario like a
> > > special one and somehow bypass the readahead heuristic and always return
> > > the max readahead size.
> > >
> > > Looking at the hits of the previous step in the swapoff case just
> > > doesn't work, because we may have some misses, but they will become hits
> > > very soon, since we are reading all the swapped out pages back into
> > > memory. This is why using the max readahead size gives better
> > > swapoff performance.
> > >
> > > What do you think?
> > 
> > >From your description, it appears that you are using cluster readahead
> > instead of vma readahead.  Can you verify this via,
> > 
> > # cat /sys/kernel/mm/swap/vma_ra_enabled
> 
> # cat /sys/kernel/mm/swap/vma_ra_enabled
> true
> 
> However, it's still using the cluster readahead because I'm using a
> swap file and nr_rotate_swap=1, so, according to the following, it's
> never using the vma readahead:
> 
>  static inline bool swap_use_vma_readahead(void)
>  {
>          return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
>  }
> 
> I'll investigate more on this, I think there's no reason to prevent the
> usage of vma readahead if the underlying device is non-rotational.

Few more details about this.

Even if I have vma_ra_enabled (in /sys/kernel/mm/swap/vma_ra_enabled) it
looks like my virtio_blk device is considered rotational by default:

$ cat /sys/block/vda/queue/rotational
1

Therefore the vma readahead is not used. If I change this to
"rotational" then the vma readahead is used; this is confirmed by the
fact that swapin_nr_pages isn't called anymore:

r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
	COUNT      EVENT
	13         $retval = 1
	18         $retval = 2
	23         $retval = 4
	29         $retval = 8

swapoff time: 16.44s

In terms of swapoff performance vma readahead works better than the
vanilla cluster readahead (~21s), but the "improved" cluster readahead
(with lookup_swap_cache() in unuse_pte_range()) still gives slightly
better results (~12s).

-Andrea
