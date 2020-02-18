Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D86C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B07208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582064897;
	bh=RPFTQSRxnktySe5nChAtOug78vFi6iXhcrDAEFaRhSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZoYRZBKtiNcP+kY+EsUaq6MeZDgKp1uUGNyiLMu09X3Dfu8rZ/JXaZ9nCz6o4ndbe
	 VeVJcUTZx0e01YOMfcbg3KTXQe/Y/hr1e6bjJ/gdIj8oyEXNmWJ+k9UcKpBzAACS+4
	 jVEBXZ9Qe/ulmMVHOyqnqBX/i7ul5OkLAvnwqUJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBRW2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:28:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50449 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgBRW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:28:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1664699pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i+LdxAL8JFR+HR/vOGUczmLCXvRbYnwHbE5xUaDFUiY=;
        b=geKjqFFAsj4ztZRTzn3HOzlOUNaKSmz1mqF9/RPgi+MgSWmTjoFIdeY/qi6a9fEpZE
         3fsY9nxaj6KkokoZ1HYXGEOgOotI2d7PEdHDkIAUwPDhlSjWaV61P+GmCyH6tqpBizCG
         thNsjcYUvx5ElJabrWULixdO7k4igLUG8hKgMr1lNBr7EeNtI5i1ZQCV4LMon1Rliv4n
         mSUz2R36l6us8GUcFoAdPI0ukvBnEPAVulIY5QM+9URphGKKveM1zPKDuYu2kgZCtsc0
         RynfQKEAg5jmITVmUxY/87yboeXgvRsXmczMQTrx0UDIqnclCx/StparQnbKNab4r6Zb
         1e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+LdxAL8JFR+HR/vOGUczmLCXvRbYnwHbE5xUaDFUiY=;
        b=ESEyeFpD+9kddiJSZqmAq0xaMmLdEHjHblqKZvLDuSZQCBM72qBz9XEqqCDbZNVO5h
         klbGGIrs55yMrTcUR/dXzpsB7cFmfAXtcT24nJp0gld1+58eiAlQ5hGGaQ1Nz4a9wyJ4
         W/uRYkMvzSm8FZOyyfgScO0LWS5JrUutKAjfYtDseUBvB2oGEWBxPSBzovIrlUcwNrsJ
         a8tB36UMnTZsvC6Kq8NjeW9mNjEbd5USXKot93mWjU/QwKPtOodVP3495425uBwMOusw
         Qdb3R0iB0P/J92oiq3j0l1xXyhLkaLtf89jEz8tDQ/J/cNiDRkeYnsPOn3pi7jhMH+vz
         Si4Q==
X-Gm-Message-State: APjAAAU0tLtSP4w2wrFdurSyPnPi4RjNnR42kJ7bOqSAtiG2zrtyuYL3
        F0d1t0KyZIanhXecGbGTwEs=
X-Google-Smtp-Source: APXvYqz/hnJw2htfAoc3R+Ui8uOGDivQ61auUnYVaQ4Be224VAkM49K6bSVFQkNot6s7sjG0F2ms0Q==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr22961347plt.224.1582064893445;
        Tue, 18 Feb 2020 14:28:13 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id u4sm4316005pgu.75.2020.02.18.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:28:12 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:28:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Robert Stupp <snazy@gmx.de>
Subject: Re: [PATCH 3/3] mm: make PageReadahead more strict
Message-ID: <20200218222810.GA126504@google.com>
References: <20200212221614.215302-1-minchan@kernel.org>
 <20200212221614.215302-3-minchan@kernel.org>
 <20200217093128.GB12032@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217093128.GB12032@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:31:28AM +0100, Jan Kara wrote:
> On Wed 12-02-20 14:16:14, Minchan Kim wrote:
> > PG_readahead flag is shared with PG_reclaim but PG_reclaim is only
> > used in write context while PG_readahead is used for read context.
> > 
> > To make it clear, let's introduce PageReadahead wrapper with
> > !PageWriteback so it could make code clear and we could drop
> > PageWriteback check in page_cache_async_readahead, which removes
> > pointless dropping mmap_sem.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> ...
> 
> > +/* Clear PG_readahead only if it's PG_readahead, not PG_reclaim */
> > +static inline int TestClearPageReadahead(struct page *page)
> > +{
> > +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> > +
> > +	return !PageWriteback(page) ||
> > +			test_and_clear_bit(PG_reclaim, &page->flags);
> > +}
> 
> I think this is still wrong - if PageWriteback is not set, it will never
> clear PG_reclaim bit so effectively the page will stay in PageReadahead
> state!
> 
> The logic you really want to implement is:
> 
> 	if (PageReadahead(page)) { <- this is your new PageReadahead
> 				    implementation
> 		clear_bit(PG_reclaim, &page->flags);
> 		return 1;
> 	}
> 	return 0;
> 
> Now this has the problem that it is not atomic. The only way I see to make
> this fully atomic is using cmpxchg(). If we wanted to make this kinda-sorta
> OK, the proper condition would look like:
> 
> 	return !PageWriteback(page) **&&**
> 			test_and_clear_bit(PG_reclaim, &page->flags);
> 
> Which is similar to what you originally had but different because in C '&&'
> operator is not commutative due to side-effects committed at sequence points.

It's accurate. Thanks, Jan.

> 
> BTW: I share Andrew's view that we are piling hacks to fix problems caused
> by older hacks. But I don't see any good option how to unalias
> PG_readahead and PG_reclaim.

I believe it's okay to remove PG_writeback check in page_cache_async_readahead. 
It's merely optmization to accelerate page reclaim when the LRU victim page's
writeback is done by VM. If we removes the condition, we just lose few pages at
the moment for fast reclaim but finally they could be reclaimed in inactive LRU
and it would be *rare* in that that kinds of writeback from reclaim context
should be not common and doesn't affect system behavior a lot.


> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
