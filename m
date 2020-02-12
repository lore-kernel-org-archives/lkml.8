Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4272C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F62B24676
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmgrHctQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBLS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:28:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fiNTQReZCzf5ki8UYp8YB655RFJQRv4FxAcgm3ILX0E=; b=RmgrHctQbwrh8Lc+P+PsTV6h86
        Wt8LzgxQUJAa+pRJNwMUjfeXLGKLjrKcj8cifXoiBqcXyyd9TeSTuMLnO5esIVqWGiiuVkBtMnnK1
        0EneixQ2IE91dH7HMlub64wkcZs5RLSgJ0VFC6080stpAmmtnq2wPXSPgn/6s8YVnRNuCadYCAFTh
        ugTrY67xV1duRfOnCNScwnj/rcGL9FnbLAOqcXF7r7oRZDl/I89XC31w3vmcVTPlyRwNA77l6J3uR
        w6/74p0x74Q71bVEilT4ySQ8gTumNNXdgo/wX800NCmW+wmQsY8m3PPmB9yZr33obTxk13ypPLTPN
        Fv7bfZ+g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1wkl-0001AR-8g; Wed, 12 Feb 2020 18:28:51 +0000
Date:   Wed, 12 Feb 2020 10:28:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212182851.GG7778@bombadil.infradead.org>
References: <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
 <20200211035412.GR8731@bombadil.infradead.org>
 <20200211042536.GB242563@google.com>
 <20200211122323.GS8731@bombadil.infradead.org>
 <20200211163404.GC242563@google.com>
 <20200211172803.GA7778@bombadil.infradead.org>
 <20200211175731.GA185752@google.com>
 <20200212101804.GD25573@quack2.suse.cz>
 <20200212174015.GB93795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212174015.GB93795@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:40:15AM -0800, Minchan Kim wrote:
> How about this?
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1bf83c8fcaa7..d07d602476df 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -363,8 +363,28 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
>  /* PG_readahead is only used for reads; PG_reclaim is only for writes */
>  PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
>  	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
> -PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> -	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> +
> +SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> +CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
> +
> +/*
> + * Since PG_readahead is shared with PG_reclaim of the page flags,
> + * PageReadahead should double check whether it's readahead marker
> + * or PG_reclaim. It could be done by PageWriteback check because
> + * PG_reclaim is always with PG_writeback.
> + */
> +static inline int PageReadahead(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> +	return test_bit(PG_reclaim, &(page)->flags) && !PageWriteback(page);

Why not ...

	return page->flags & (1UL << PG_reclaim | 1UL << PG_writeback) ==
		(1UL << PG_reclaim);

> +static inline int TestClearPageReadahead(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> +
> +	return test_and_clear_bit(PG_reclaim, &page->flags) && !PageWriteback(page);

That's definitely wrong.  It'll clear PageReclaim and then pretend it did
nothing wrong.

	return !PageWriteback(page) ||
		test_and_clear_bit(PG_reclaim, &page->flags);

