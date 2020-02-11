Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B8C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DAE20661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581443856;
	bh=2GLnU7gkg34WRP7oYPhsHi3Gf2Gz+rkE9pWEj+jtpAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfHp+fw8vwtApiNu+O3Ff6+GfeHDXoz4jASXbFDFjc/SDmyRKwOKDABDrrVl74yR3
	 mKpoUlUuZcAkAXSm2Y9DB5sunZSuycPtm4BxJhTU9/rsla0VSB9riX6UUlSEZQWRfX
	 HlsEHCW/U465IjFmvabFhZIiugqZKAEbCCHC/5n4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgBKR5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:57:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44056 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgBKR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:57:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so4548031plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ee/QPVUg4JGlwVOzU8K+YCc/CraaQUhiWKFtj6iWDA0=;
        b=mOWoGN/xq5ldX9x2Jl/Yr3A9lTAyWJcsXsEEzsHx8DIwic7D8eZbicDVojpUJCm3fj
         5KUIXy2OiT1PddkwIj1o9paqpmYMwrObDreM5q/T1RUwg2hHe/KAbCze+X4yzEC8uG5c
         vSgWTtj8KYPECj7yGgG45ruxlAA8qLSdgjcdgU7mdqMz7sibokla7klShVjQLH3EFNc3
         q0S+9FYL6UikzrQG+Whi13GyUjSCiQxsBspVpqY4k98ZHyNn7v2XmUwH4RscOEG42mnY
         P6NeykkGb74WjnYKeTmarvsgeNOhzh2w34StKPp1squDpOetyLUfTWve/lZVyswYZdUm
         ERwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ee/QPVUg4JGlwVOzU8K+YCc/CraaQUhiWKFtj6iWDA0=;
        b=G14NDSV80Ybhvr2jjx8/3y2Th7LjL8+cnaAwAx6QSIQ0dkOg+lO2otLuOlLrem9ShI
         hsO8hk1hj9Qn69M0n/UpLUA1uO1eMHqyY770rx83TLZ/3dzhUAM5jqUHHeSsjfl/rgZs
         3bOXF4h51enLqh5IZez25By+x1UMeEQM8d6Mtl0061LrVswr0fbtczIEXNY5Yavmi+LJ
         YjqKbDYdW8gwAfZLNsog9Xy11PpzV20o4NODL8kjKgOCerfRyVnjylMQk17NuH22djme
         vVxdFQ96Golu/WICaqWzMT9XEaIBD4b2dfM97vXGe2OmhRm6VpnXCajixGZT44VCPHaI
         SA7w==
X-Gm-Message-State: APjAAAX7YxMIjTdHli8T/n8QsgvT1ckZCRrYoBgOO1HX527mtod6nUvx
        ScDn3njmpWDt4udPGMccEwc=
X-Google-Smtp-Source: APXvYqy/TGOb9tzofwDr3E69kRs8YnvZcECcYVGKsZStAadrg0H3M1mXekJQywMwu6tjRKMel4tKog==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr4353288plo.282.1581443854319;
        Tue, 11 Feb 2020 09:57:34 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z3sm5037869pfz.155.2020.02.11.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:57:33 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:57:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211175731.GA185752@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211172803.GA7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:28:03AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 11, 2020 at 08:34:04AM -0800, Minchan Kim wrote:
> > On Tue, Feb 11, 2020 at 04:23:23AM -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 10, 2020 at 08:25:36PM -0800, Minchan Kim wrote:
> > > > On Mon, Feb 10, 2020 at 07:54:12PM -0800, Matthew Wilcox wrote:
> > > > > On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> > > > > > On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > > > > > > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > > > > > > >       filemap_fault
> > > > > > > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > > > > > > 
> > > > > > > Uh ... That shouldn't be possible.
> > > > > > 
> > > > > > Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> > > > > > page reclaim when the writeback is done so the page will have both
> > > > > > flags at the same time and the PG reclaim could be regarded as
> > > > > > PG_readahead in fault conext.
> > > > > 
> > > > > What part of fault context can make that mistake?  The snippet I quoted
> > > > > below is from page_cache_async_readahead() where it will clearly not
> > > > > make that mistake.  There's a lot of code here; please don't presume I
> > > > > know all the areas you're talking about.
> > > > 
> > > > Sorry about being not clear. I am saying  filemap_fault ->
> > > > do_async_mmap_readahead
> > > > 
> > > > Let's assume the page is hit in page cache and vmf->flags is !FAULT_FLAG
> > > > TRIED so it calls do_async_mmap_readahead. Since the page has PG_reclaim
> > > > and PG_writeback by shrink_page_list, it goes to 
> > > > 
> > > > do_async_mmap_readahead
> > > >   if (PageReadahead(page))
> > > >     fpin = maybe_unlock_mmap_for_io();
> > > >     page_cache_async_readahead
> > > >       if (PageWriteback(page))
> > > >         return;
> > > >       ClearPageReadahead(page); <- doesn't reach here until the writeback is clear
> > > >       
> > > > So, mm_populate will repeat the loop until the writeback is done.
> > > > It's my just theory but didn't comfirm it by the testing.
> > > > If I miss something clear, let me know it.
> > > 
> > > Ah!  Surely the right way to fix this is ...
> > 
> > I'm not sure it's right fix. Actually, I wanted to remove PageWriteback check
> > in page_cache_async_readahead because I don't see corelation. Why couldn't we
> > do readahead if the marker page is PG_readahead|PG_writeback design PoV?
> > Only reason I can think of is it makes *a page* will be delayed for freeing
> > since we removed PG_reclaim bit, which would be over-optimization for me.
> 
> You're confused.  Because we have a shortage of bits in the page flags,
> we use the same bit for both PageReadahead and PageReclaim.  That doesn't
> mean that a page marked as PageReclaim should be treated as PageReadahead.

My point is why we couldn't do readahead if the marker page is under PG_writeback.
It was there for a long time and you were adding one more so I was curious what's
reasoning comes from. Let me find why PageWriteback check in
page_cache_async_readahead from the beginning.

	fe3cba17c4947, mm: share PG_readahead and PG_reclaim

The reason comes from the description

    b) clear PG_readahead => implicit clear of PG_reclaim
            one(and only one) page will not be reclaimed in time
            it can be avoided by checking PageWriteback(page) in readahead first

The goal was to avoid delay freeing of the page by clearing PG_reclaim.
I'm saying that I feel it's over optimization. IOW, it would be okay to
lose a page to be accelerated reclaim.

> 
> > Other concern is isn't it's racy? IOW, page was !PG_writeback at the check below
> > in your snippet but it was under PG_writeback in page_cache_async_readahead and
> > then the IO was done before refault reaching the code again. It could be repeated
> > *theoretically* even though it's very hard to happen in real practice.
> > Thus, I think it would be better to remove PageWriteback check from
> > page_cache_async_readahead if we really want to go the approach.
> 
> PageReclaim is always cleared before PageWriteback.  eg here:
> 
> void end_page_writeback(struct page *page)
> ...
>         if (PageReclaim(page)) {
>                 ClearPageReclaim(page);
>                 rotate_reclaimable_page(page);
>         }
> 
>         if (!test_clear_page_writeback(page))
>                 BUG();
> 
> so if PageWriteback is clear, PageReclaim must already be observable as clear.
> 

I'm saying live lock siutation below.
It would be hard to trigger since IO is very slow but isn't it possible
theoretically?


                 CPU 1                                                CPU 2
mm_populate
1st trial
  __get_user_pages
    handle_mm_fault
      filemap_fault
        do_async_mmap_readahead 
        if (!PageWriteback(page) && PageReadahead(page)) {
          fpin = maybe_unlock_mmap_for_io
          page_cache_async_readahead
                                                                    set_page_writeback here
            if (PageWriteback(page))
	      return; <- hit

                                                                     writeback completed and reclaimed the page
								     ..
								     ondemand readahead allocates new page and mark it to PG_readahead
2nd trial
 __get_user_pages
    handle_mm_fault
      filemap_fault
        do_async_mmap_readahead 
        if (!PageWriteback(page) && PageReadahead(page)) {
          fpin = maybe_unlock_mmap_for_io
          page_cache_async_readahead
                                                                    set_page_writeback here
            if (PageWriteback(page))
	      return; <- hit

                                                                     writeback completed and reclaimed the page
								     ..
								     ondemand readahead allocates new page and mark it to PG_readahead

3rd trial
..


Let's consider ra_pages, too as I mentioned. Isn't it another hole to make
such live lock if other task suddenly reset it to zero?

void page_cache_async_readahead(..)
{
        /* no read-ahead */
        if (!ra->ra_pages)
                return;

