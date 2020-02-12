Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A50C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0107421569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581549137;
	bh=pWWHdP6GrECP8E3iDyf+/9tvlwEBB6UWAwUF8Oj7sgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=opxOK39wy0aXYiJIbhJ75OgJfcykeah6xnCPJQaRozllLDeioRP0bWEqCouMamO1P
	 AOTAcguHn14KqjwSorqG/yixPAhbK549M3iTNShZSIp1+BdAOoKXiYD5VqVAC6/6iZ
	 wpHz3T5c9zdJjOSVHL9s60FweG6L7XBjMQJnNYEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgBLXMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:12:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37846 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgBLXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:12:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so1534738plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tra7DkW4Ug7XOH+KIBkrjPoBiq7GSiJb0g4w8xR1qLU=;
        b=Dp1Nk18ZQOEKIuvucaP3mFLGhGNU+WNbsa6ok4EsqiH/zPfBTLJgNlur3OAyp2ZECq
         hNIYEHA7KfCg2SUnDHNLHt4GirxR8vHBz/M/k0KqkC7T9LF0SVz5cYeo+wlHwFTCf72N
         bNLaMvX/zYa1OC6eY3MpZnRMJPIa9MakGAMbOL9achr1odxxY4QegR7YJnjuZm4yw4In
         WyMujejgPqtlCsuHzuN1wUq8KGMcC2zMY8dj1/81hwZIF2e+4zn7d3jy/P0BsICq/ped
         hKEZXxQ8x5vs9Lu8oKhtpU5umlvvkyNZxLWGTDVWGdhpHQ+fQT636HoXr2Bukwc3R96D
         3JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tra7DkW4Ug7XOH+KIBkrjPoBiq7GSiJb0g4w8xR1qLU=;
        b=I5AmFXaQUQ2B/5PeArNwE9MBCZVyXi/fGurZUH4/EoCh6y0ABL/RiXZfo/eV5UQd/9
         W8GwYFGSJcQK46t+bewvD/K+lRfWt2u2hoXntl25kcWwnCJMmCY7qlSJ7AOuXIVvB7ac
         W3n1EsTTjDoykpWGe96lg+gc6MtZEn/RT2MIcR7RPCAy+vewn7rmfNu17IvNQv6qyeUX
         C4/OJarHIF0g+TVtwtfvBlsQa4fC1gMb9/KoByZu6+5akZSnKS5/Vwyfwnlt0yf8zhHb
         U9ea9+RPKzy73nM/esVr8CfgScCzzo2o4heOVXasJUiuGJA5m4WaFSYiJ14MRmg+y6Ms
         xqTw==
X-Gm-Message-State: APjAAAUXtnGZ2ROtGivCxNBCZDh6TaFnpgUZsWMQ8sTj4ysQuTltpQhy
        5jvJ2ybx76H/n/s5ibEotsk=
X-Google-Smtp-Source: APXvYqxq+wTt5eTDOqBxkwHZDh17Z5BbAhBV+PFDTOZA10znnMjHEg1B0gOvk3ml2wPVfquTYK4sfA==
X-Received: by 2002:a17:90a:8547:: with SMTP id a7mr1763279pjw.0.1581549133392;
        Wed, 12 Feb 2020 15:12:13 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z3sm283795pfz.155.2020.02.12.15.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:12:12 -0800 (PST)
Date:   Wed, 12 Feb 2020 15:12:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212231210.GA233109@google.com>
References: <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
 <20200211175731.GA185752@google.com>
 <20200212101804.GD25573@quack2.suse.cz>
 <20200212174015.GB93795@google.com>
 <20200212182851.GG7778@bombadil.infradead.org>
 <20200212195322.GA83146@google.com>
 <20200212142435.0b7e938fe8112fa35fcbcc71@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212142435.0b7e938fe8112fa35fcbcc71@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:24:35PM -0800, Andrew Morton wrote:
> On Wed, 12 Feb 2020 11:53:22 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > > That's definitely wrong.  It'll clear PageReclaim and then pretend it did
> > > nothing wrong.
> > > 
> > > 	return !PageWriteback(page) ||
> > > 		test_and_clear_bit(PG_reclaim, &page->flags);
> > > 
> > 
> > Much better, Thanks for the review, Matthew!
> > If there is no objection, I will send two patches to Andrew.
> > One is PageReadahead strict, the other is limit retry from mm_populate.
> 
> With much more detailed changelogs, please!
> 
> This all seems rather screwy.  if a page is under writeback then it is
> uptodate and we should be able to fault it in immediately.

Hi Andrew,

This description in cover-letter will work? If so, I will add each part
below in each patch.

Subject: [PATCH 0/3] fixing mm_populate long stall

I got several reports major page fault takes several seconds sometime.
When I review drop mmap_sem in page fault hanlder, I found several bugs.

   CPU 1							CPU 2
mm_populate
 for ()
   ..
   ret = populate_vma_page_range
     __get_user_pages
       faultin_page
         handle_mm_fault
	   filemap_fault
	     do_async_mmap_readahead
	     						shrink_page_list
							  pageout
							    SetPageReclaim(=SetPageReadahead)
							      writepage
							        SetPageWriteback
	       if (PageReadahead(page))
	         maybe_unlock_mmap_for_io
		   up_read(mmap_sem)
		 page_cache_async_readahead()
		   if (PageWriteback(page))
		     return;

    here, since ret from populate_vma_page_range is zero,
    the loop continue to run with same address with previous
    iteration. It will repeat the loop until the page's
    writeout is done(ie, PG_writeback or PG_reclaim clear).

We could fix the above specific case via adding PageWriteback. IOW,

   ret = populate_vma_page_range
   	   ...
	   ...
	   filemap_fault
	     do_async_mmap_readahead
	       if (!PageWriteback(page) && PageReadahead(page))
	         maybe_unlock_mmap_for_io
		   up_read(mmap_sem)
		 page_cache_async_readahead()
		   if (PageWriteback(page))
		     return;

That's a thing [3/3] is fixing here. Even though it could fix the
problem effectively, it has still livelock problem theoretically
because the page of faulty address could be reclaimed and then
allocated/become readahead marker on other CPUs during faulty
process is retrying in mm_populate's loop. [2/3] is fixing the
such livelock via limiting retry count.
There is another hole for the livelock or hang of the process as well
as ageWriteback - ra_pages.

mm_populate
 for ()
   ..
   ret = populate_vma_page_range
     __get_user_pages
       faultin_page
         handle_mm_fault
	   filemap_fault
	     do_async_mmap_readahead
	       if (PageReadahead(page))
	         maybe_unlock_mmap_for_io
		   up_read(mmap_sem)
		 page_cache_async_readahead()
		   if (!ra->ra_pages)
		     return;

It will repeat the loop until ra->ra_pages become non-zero.
[1/3] is fixing the problem.

Jan Kara (1):
  mm: Don't bother dropping mmap_sem for zero size readahead

Minchan Kim (2):
  mm: fix long time stall from mm_populate
  mm: make PageReadahead more strict

 include/linux/page-flags.h | 28 ++++++++++++++++++++++++++--
 mm/filemap.c               |  2 +-
 mm/gup.c                   |  9 +++++++--
 mm/readahead.c             |  6 ------
 4 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.25.0.225.g125e21ebc7-goog

