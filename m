Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDD82073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581529220;
	bh=SQXxous8KTqdQay0gdX7MtgEPbyeqG5mLK09Bu8a9OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=djT2gPuCPYdD5muVhZWZiWyUm5jyZ15Lj6re9F36NnTK6ZjI1ZxiMVQ2gvfzUCovV
	 IjeABsAh1sy/Y6uYMmMW/fpHp0wMGJNBpDfF953h/8ZYhUpum3QcSVSMuPpD6uGwf4
	 i0ttu9QB2pS+p+15fXt1gSmLZIGqOxnGLtwtExuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLRkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:40:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51992 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:40:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so1177191pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOSy7fZEOqrizfLBXW93oK+mjPOVPvgmn6j6M6OCZlg=;
        b=I6nQz2uP8UF8I0bpL6iCQnrw6Q6qdr135W3Tfa+/Q7BFjLoZtiOGiiZsiYA2AuYnMR
         CTUmDMdmnJzAE/QWU4mTlMmeCytpCfEy8mVJg9Vydkct5/7fAy/AEuTwDeaBcioDTJ7G
         7yCv6drT8nZZRS4R8w6x6qCJjq6Yj3W6k5Ctjnr6QdHXd8J7kxLn3M7lOs5W2uIA3ner
         uuCjl1EhBaBja63J5hutTm/QSnkbp4rWOlGQ4XUYy3A7MambEF3fashhJuudmMfWRJ1L
         L0OP1vmaiCxuARqIahzE0TdWoOjeEj4vgOc2ONlwk2sSzZNb3StQRKSEp9mi9a3WpCPm
         yGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOSy7fZEOqrizfLBXW93oK+mjPOVPvgmn6j6M6OCZlg=;
        b=MIM3W2BccP25Uba23WY+xCShBgVi5PdVq0tSZpquPYjrwcVhYJZSX/d9OW/fWjHreJ
         UOogndCnViQdprtFk2+R4gpMXJ/pBdjLGOOHs16KkibGyjscR5KSslMp/IG1+t9Lu9BU
         1SPrrgZtrsaiRRP4kAQhy5umY+4gsNYYMZRr7IGqs7d+qqZxsZoYafBh9QEGaNRvfjK6
         vRDVl3xuSmGRQYDtZr04F4uOsMUCC7PsdqVoG6GvBevBBgwvE7y2qAesW9dR2xHHu5ee
         EAT+YB+bDuY1570DLdaxPIpAnzl7hreUnAB0WVOHeurVr0hhDKO04aSOhWbbELhoW/8U
         o8kA==
X-Gm-Message-State: APjAAAWj7SzLBjCffOBW3x1q7Ao2kbP3Hj0PnULyse7/gXd1CBzTqGOs
        My/CvHMSvpGqUGSjuTZ/s+w=
X-Google-Smtp-Source: APXvYqzCk3LiEqDixuoG89FgoXuiTBFnBdwj6CAwd/ZgSYoR23/QLLVDT4LhqMg4JCeEPVgXEzdleg==
X-Received: by 2002:a17:90a:c084:: with SMTP id o4mr173095pjs.35.1581529218189;
        Wed, 12 Feb 2020 09:40:18 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 72sm1697064pfw.7.2020.02.12.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 09:40:16 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:40:15 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212174015.GB93795@google.com>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
 <20200211175731.GA185752@google.com>
 <20200212101804.GD25573@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212101804.GD25573@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Wed, Feb 12, 2020 at 11:18:04AM +0100, Jan Kara wrote:
> On Tue 11-02-20 09:57:31, Minchan Kim wrote:
> > On Tue, Feb 11, 2020 at 09:28:03AM -0800, Matthew Wilcox wrote:
> > > On Tue, Feb 11, 2020 at 08:34:04AM -0800, Minchan Kim wrote:
> > > > On Tue, Feb 11, 2020 at 04:23:23AM -0800, Matthew Wilcox wrote:
> > > > > On Mon, Feb 10, 2020 at 08:25:36PM -0800, Minchan Kim wrote:
> > > > > > On Mon, Feb 10, 2020 at 07:54:12PM -0800, Matthew Wilcox wrote:
> > > > > > > On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> > > > > > > > On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > > > > > > > > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > > > > > > > > >       filemap_fault
> > > > > > > > > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > > > > > > > > 
> > > > > > > > > Uh ... That shouldn't be possible.
> > > > > > > > 
> > > > > > > > Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> > > > > > > > page reclaim when the writeback is done so the page will have both
> > > > > > > > flags at the same time and the PG reclaim could be regarded as
> > > > > > > > PG_readahead in fault conext.
> > > > > > > 
> > > > > > > What part of fault context can make that mistake?  The snippet I quoted
> > > > > > > below is from page_cache_async_readahead() where it will clearly not
> > > > > > > make that mistake.  There's a lot of code here; please don't presume I
> > > > > > > know all the areas you're talking about.
> > > > > > 
> > > > > > Sorry about being not clear. I am saying  filemap_fault ->
> > > > > > do_async_mmap_readahead
> > > > > > 
> > > > > > Let's assume the page is hit in page cache and vmf->flags is !FAULT_FLAG
> > > > > > TRIED so it calls do_async_mmap_readahead. Since the page has PG_reclaim
> > > > > > and PG_writeback by shrink_page_list, it goes to 
> > > > > > 
> > > > > > do_async_mmap_readahead
> > > > > >   if (PageReadahead(page))
> > > > > >     fpin = maybe_unlock_mmap_for_io();
> > > > > >     page_cache_async_readahead
> > > > > >       if (PageWriteback(page))
> > > > > >         return;
> > > > > >       ClearPageReadahead(page); <- doesn't reach here until the writeback is clear
> > > > > >       
> > > > > > So, mm_populate will repeat the loop until the writeback is done.
> > > > > > It's my just theory but didn't comfirm it by the testing.
> > > > > > If I miss something clear, let me know it.
> > > > > 
> > > > > Ah!  Surely the right way to fix this is ...
> > > > 
> > > > I'm not sure it's right fix. Actually, I wanted to remove PageWriteback check
> > > > in page_cache_async_readahead because I don't see corelation. Why couldn't we
> > > > do readahead if the marker page is PG_readahead|PG_writeback design PoV?
> > > > Only reason I can think of is it makes *a page* will be delayed for freeing
> > > > since we removed PG_reclaim bit, which would be over-optimization for me.
> > > 
> > > You're confused.  Because we have a shortage of bits in the page flags,
> > > we use the same bit for both PageReadahead and PageReclaim.  That doesn't
> > > mean that a page marked as PageReclaim should be treated as PageReadahead.
> > 
> > My point is why we couldn't do readahead if the marker page is under PG_writeback.
> 
> Well, as far as I'm reading the code, this shouldn't usually happen -
> PageReadahead is set on a page that the preread into memory. Once it is
> used for the first time (either by page fault or normal read), readahead
> logic triggers starting further readahead and PageReadahead gets cleared.
> 
> What could happen though is that the page gets written into (say just a few
> bytes). That would keep PageReadahead set although the page will become
> dirty and can later be written back. I don't find not triggering writeback in
> this case too serious though since it should be very rare.

Please see pageout in vmscan.c which set PG_reclaim righ before calling
writepage. Since PG_reclaim and PG_readahead shares the same bit of the
page flags, do_async_mmap_readahead will decipher the PG_reclaim as
PageReadahead so it releases mmap but page_cache_async_readahead just
returns by PageWriteback check. It will be repeated until the writeback
is done.

> 
> So I'd be OK with the change Matthew suggested although I'd prefer if we
> had this magic "!PageWriteback && PageReadahead" test in some helper
> function (like page_should_trigger_readahead()?) with a good comment explaining
> the details.

How about this?

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..d07d602476df 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -363,8 +363,28 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+/*
+ * Since PG_readahead is shared with PG_reclaim of the page flags,
+ * PageReadahead should double check whether it's readahead marker
+ * or PG_reclaim. It could be done by PageWriteback check because
+ * PG_reclaim is always with PG_writeback.
+ */
+static inline int PageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+	return test_bit(PG_reclaim, &(page)->flags) && !PageWriteback(page);
+}
+
+static inline int TestClearPageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return test_and_clear_bit(PG_reclaim, &page->flags) && !PageWriteback(page);
+}
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..85b15e5a1d7b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -553,12 +553,6 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
-	/*
-	 * Same bit is used for PG_readahead and PG_reclaim.
-	 */
-	if (PageWriteback(page))
-		return;
-
 	ClearPageReadahead(page);
 
 	/*
-- 
2.25.0.225.g125e21ebc7-goog


> 
> > It was there for a long time and you were adding one more so I was curious what's
> > reasoning comes from. Let me find why PageWriteback check in
> > page_cache_async_readahead from the beginning.
> > 
> > 	fe3cba17c4947, mm: share PG_readahead and PG_reclaim
> > 
> > The reason comes from the description
> > 
> >     b) clear PG_readahead => implicit clear of PG_reclaim
> >             one(and only one) page will not be reclaimed in time
> >             it can be avoided by checking PageWriteback(page) in readahead first
> > 
> > The goal was to avoid delay freeing of the page by clearing PG_reclaim.
> > I'm saying that I feel it's over optimization. IOW, it would be okay to
> > lose a page to be accelerated reclaim.
> > 
> > > 
> > > > Other concern is isn't it's racy? IOW, page was !PG_writeback at the check below
> > > > in your snippet but it was under PG_writeback in page_cache_async_readahead and
> > > > then the IO was done before refault reaching the code again. It could be repeated
> > > > *theoretically* even though it's very hard to happen in real practice.
> > > > Thus, I think it would be better to remove PageWriteback check from
> > > > page_cache_async_readahead if we really want to go the approach.
> > > 
> > > PageReclaim is always cleared before PageWriteback.  eg here:
> > > 
> > > void end_page_writeback(struct page *page)
> > > ...
> > >         if (PageReclaim(page)) {
> > >                 ClearPageReclaim(page);
> > >                 rotate_reclaimable_page(page);
> > >         }
> > > 
> > >         if (!test_clear_page_writeback(page))
> > >                 BUG();
> > > 
> > > so if PageWriteback is clear, PageReclaim must already be observable as clear.
> > > 
> > 
> > I'm saying live lock siutation below.
> > It would be hard to trigger since IO is very slow but isn't it possible
> > theoretically?
> > 
> > 
> >                  CPU 1                                                CPU 2
> > mm_populate
> > 1st trial
> >   __get_user_pages
> >     handle_mm_fault
> >       filemap_fault
> >         do_async_mmap_readahead 
> >         if (!PageWriteback(page) && PageReadahead(page)) {
> >           fpin = maybe_unlock_mmap_for_io
> >           page_cache_async_readahead
> >                                                                     set_page_writeback here
> >             if (PageWriteback(page))
> > 	      return; <- hit
> > 
> >                                                                      writeback completed and reclaimed the page
> > 								     ..
> > 								     ondemand readahead allocates new page and mark it to PG_readahead
> > 2nd trial
> >  __get_user_pages
> >     handle_mm_fault
> >       filemap_fault
> >         do_async_mmap_readahead 
> >         if (!PageWriteback(page) && PageReadahead(page)) {
> >           fpin = maybe_unlock_mmap_for_io
> >           page_cache_async_readahead
> >                                                                     set_page_writeback here
> >             if (PageWriteback(page))
> > 	      return; <- hit
> > 
> >                                                                      writeback completed and reclaimed the page
> > 								     ..
> > 								     ondemand readahead allocates new page and mark it to PG_readahead
> > 
> > 3rd trial
> > ..
> > 
> > 
> > Let's consider ra_pages, too as I mentioned. Isn't it another hole to make
> > such live lock if other task suddenly reset it to zero?
> > 
> > void page_cache_async_readahead(..)
> > {
> >         /* no read-ahead */
> >         if (!ra->ra_pages)
> >                 return;
> 
> So this is definitively a bug which was already reported previously. I've
> just sent out a patch to fix this which has somehow fallen through the
> cracks.
> 
> Now I agree that regardless of this fix and the fix Matthew has proposed,
> mm_populate() would benefit from being more robust like you suggested so
> I'll check that separately (but I'm no expert in that area).

True because I think we couldn't prevent live lock as I wrote above.
Thanks for the review, Jan!
