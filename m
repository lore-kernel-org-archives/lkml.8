Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A254C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A4A20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcAtd2aU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgBKSPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:15:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41623 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgBKSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:15:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so5792930eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdXeqUNCDw6vsgwpKMP/mro201t4P8oOPu674oJy4F8=;
        b=lcAtd2aUQqohh2K0Qp0cG4w8CEdeevHMAAjggBICjP3g8TTLkE6xthXoS/Ta8ZeYDl
         DvwGeQJ1qx6WA7sRVYz3tJNRDrRPkKjdD+g5EoV5r9xF3XuQpugH2kko1tZSuLxwuj3Z
         urTKYEG00pKtZEOdMljxs4yXkN11J28toNguMinzhr9ZX2LyqLzJhXH/OeYwiHNhcAqy
         oGS5WnrQo9CWPSjxv3HkpKEpR8ww86hr95gQpRwB0EXoA701kNUJvNKPq6Xh8FCiOW+h
         YbHEwBG9Lj5H9F+nIPPFLe72M+3c96VbDlfz3d0Qj77TX8HximsjjXjPmPEuGRpjDJEF
         hcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdXeqUNCDw6vsgwpKMP/mro201t4P8oOPu674oJy4F8=;
        b=fGjywpGXM5Va8FxFpTsw4JT+MuTq0xTmZhDfo61430QH6vprFRwFxoZR9yBlpC5dEP
         TBbZYOJVaBcz85KbOrPxVsU+zjFDayh33L7pe3ZW26E0GuosobgHL/h8/5+E4ecPSmMs
         JxvVsDYEcLmpkS+soEJ0YQxAVo7On+MqVbacbMzm0sZi6ELpeXdoIqDHnGZcKc1LWTJJ
         bevYFrLxNCrhuEBfdk9IBR1CCNCghsbkbVS+ikVM0VNLQrUhITkgDYZMMelE0rBrlxTt
         rvAbOhuXu0k8UOw5HESPcsnZtTYfjyvfw2zcNzKCYD/Gam0/vpZjO0Cz8BhAvQ9Y98bv
         JJyQ==
X-Gm-Message-State: APjAAAUiojZHy3jiZzXI/IIyRbGfK9s4TL/yheszPiS5q00QUq+WZG/h
        kfjFIawp3GKoaqaGqbf77tjeQ51mGE2BSMHztdbk6oNu8co=
X-Google-Smtp-Source: APXvYqycu2Y1ZVwt/ChyzNJrYaYg7FHgeADvWYnd8vtFtMGhE6wwP2EQejZVnFXyO+H73vId2tEWagAI+641478qaiM=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr7213529edb.200.1581444914525;
 Tue, 11 Feb 2020 10:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20200211001958.170261-1-minchan@kernel.org> <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com> <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com> <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com> <20200211172803.GA7778@bombadil.infradead.org>
In-Reply-To: <20200211172803.GA7778@bombadil.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 11 Feb 2020 10:14:58 -0800
Message-ID: <CAHbLzkqexeZEWEr2aZj78Pg6ktL5jhZx1OdssxnoU9t+kW3bdA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 9:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
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

Not sure if the below race in vmscan matters or not.

               if (PageWriteback(page)) {
                      [snip]
                        /* Case 2 above */
                        } else if (writeback_throttling_sane(sc) ||
                            !PageReclaim(page) || !may_enter_fs) {
                                /*
                                 * This is slightly racy - end_page_writeback()
                                 * might have just cleared PageReclaim, then
                                 * setting PageReclaim here end up interpreted
                                 * as PageReadahead - but that does not matter
                                 * enough to care.  What we do want is for this
                                 * page to have PageReclaim set next time memcg
                                 * reclaim reaches the tests above, so it will
                                 * then wait_on_page_writeback() to avoid OOM;
                                 * and it's also appropriate in global reclaim.
                                 */
                                SetPageReclaim(page);
                                stat->nr_writeback++;
                                goto activate_locked;


>
>
