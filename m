Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16884C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1E20873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581438851;
	bh=HAF9UF+4lnB297TrbRVoBXSSejhgiWznackbBSrtY70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GkppuwkG2afmlNa7h2BrE3p02kSZDMgK+i1JIbGpfGtLcmj/UcDYJY/WZRugPUYle
	 RliS7j1ouKP0DjRXzRdDYaBMhKaYImtAWN/pGFMgWxBIprWAImjp/OU43XUG3vBp1+
	 ZZ1JPxc3VVxUePGflqd52ROjAEeWCA9iHgyfFADg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgBKQeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:34:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBKQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:34:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so5715655pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DcogQqT/L9uwP1yMzCrGQYpSSLcJ6csEli1u/M+9NC4=;
        b=LRxzWKOC4zHMz/9PTrk1682dTwlx4tFC6jZmyDfZA4fhdNbthovhVHVqMZ1qmaKiip
         71flcMUrOJ6szRSPZgJB9Ir2AT/lQJWsflPMrdiDSRd9BvtguFv2ZKzJhOptvfSKCsoR
         EpCXoei53H5m+CTK40OenXUgOX0bnAUGcB4Sse1fP7ZjjQ23i3/Hy9cqgTPtV4Q5J1bK
         YS8phOfP8spleZNSTbvtUbjd7Mv+z8CleeYMbOdYvRfhsKGhk5vnrW6RlNZUmiIh1o5J
         NFOstpWhwRB8OZ7h+cTk5w+rwqX0pKd9RUtawYBOzTN2nRuwwCGp7aD9DCoPU5OIAB6R
         TFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcogQqT/L9uwP1yMzCrGQYpSSLcJ6csEli1u/M+9NC4=;
        b=uQV8M/S8ncduDrWoBJ0RKNK1MfHgFxbrQzg27a0D0E3qWovyvmDCTV42km2nD2WQ4A
         6D9XI1idPX2X4UZzLeNocezLz72UChuks04muRokkppXgFD7nfC+UsDZvr2t8x+gF9SK
         pTZ+4oC1QCO3jXS0IIh5jg/cSKPJWq+DX5RHsmhqGpd1DtirHvGr2P1GyueyA2DwqXT3
         yU8vxeD6gkihCGWSwZFenxbd7QPia67T3Ex2Kf563ljAiJkNXQcZiYSsWDyDwcdm6r9j
         qBL52XL5xmzvm4wy1Q/TBc3YiYG5EOU1eSmzNq+ZvxFanaD/h5t4lg9WPn/JNpKenT5w
         TzWw==
X-Gm-Message-State: APjAAAWXg/LocT9WSjsZKHED84DNVdweEgxrTHXmDVtYaHSyYYKsdxlz
        xwylXWP8duZwmQyx0dv4CiE=
X-Google-Smtp-Source: APXvYqyuoIukPc1izp+pVUfL075f0kUmc4wnvEqg2lvp7wpaD4YxIQBjABu+TnwOdTvlhfsL5K33qw==
X-Received: by 2002:a63:4c4:: with SMTP id 187mr7719262pge.362.1581438847389;
        Tue, 11 Feb 2020 08:34:07 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id ep2sm3831545pjb.31.2020.02.11.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:34:06 -0800 (PST)
Date:   Tue, 11 Feb 2020 08:34:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211163404.GC242563@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211122323.GS8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:23:23AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 08:25:36PM -0800, Minchan Kim wrote:
> > On Mon, Feb 10, 2020 at 07:54:12PM -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> > > > On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > > > > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > > > > >       filemap_fault
> > > > > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > > > > 
> > > > > Uh ... That shouldn't be possible.
> > > > 
> > > > Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> > > > page reclaim when the writeback is done so the page will have both
> > > > flags at the same time and the PG reclaim could be regarded as
> > > > PG_readahead in fault conext.
> > > 
> > > What part of fault context can make that mistake?  The snippet I quoted
> > > below is from page_cache_async_readahead() where it will clearly not
> > > make that mistake.  There's a lot of code here; please don't presume I
> > > know all the areas you're talking about.
> > 
> > Sorry about being not clear. I am saying  filemap_fault ->
> > do_async_mmap_readahead
> > 
> > Let's assume the page is hit in page cache and vmf->flags is !FAULT_FLAG
> > TRIED so it calls do_async_mmap_readahead. Since the page has PG_reclaim
> > and PG_writeback by shrink_page_list, it goes to 
> > 
> > do_async_mmap_readahead
> >   if (PageReadahead(page))
> >     fpin = maybe_unlock_mmap_for_io();
> >     page_cache_async_readahead
> >       if (PageWriteback(page))
> >         return;
> >       ClearPageReadahead(page); <- doesn't reach here until the writeback is clear
> >       
> > So, mm_populate will repeat the loop until the writeback is done.
> > It's my just theory but didn't comfirm it by the testing.
> > If I miss something clear, let me know it.
> 
> Ah!  Surely the right way to fix this is ...

I'm not sure it's right fix. Actually, I wanted to remove PageWriteback check
in page_cache_async_readahead because I don't see corelation. Why couldn't we
do readahead if the marker page is PG_readahead|PG_writeback design PoV?
Only reason I can think of is it makes *a page* will be delayed for freeing
since we removed PG_reclaim bit, which would be over-optimization for me.

Other concern is isn't it's racy? IOW, page was !PG_writeback at the check below
in your snippet but it was under PG_writeback in page_cache_async_readahead and
then the IO was done before refault reaching the code again. It could be repeated
*theoretically* even though it's very hard to happen in real practice.
Thus, I think it would be better to remove PageWriteback check from
page_cache_async_readahead if we really want to go the approach.

However, page_cache_async_readahead has another condition to bail out: ra_pages
I think it's also racy with fadvise or shrinking the window size from other tasks.

That's why I thought second trial with non-fault retry logic from caller would fix
all potnetial issues all at once like page fault handler have done.

> 
> +++ b/mm/filemap.c
> @@ -2420,7 +2420,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>                 return fpin;
>         if (ra->mmap_miss > 0)
>                 ra->mmap_miss--;
> -       if (PageReadahead(page)) {
> +       if (!PageWriteback(page) && PageReadahead(page)) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>                 page_cache_async_readahead(mapping, ra, file,
>                                            page, offset, ra->ra_pages);
> 
