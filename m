Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD24C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C942072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhUgLm+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438911AbgDNLFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438866AbgDNLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:05:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2b+mWK8ulZOvDrigGt8wqwwRenucGM7sN6FozV26lOk=; b=MhUgLm+Z6Y/xc1JJ7fxzI3awMK
        BtTsa8qoUlOcStx2UtfNXZt552UzPDqqO5reddnYqF3McbmnKw9jqX+hs1EeTL0Tdh/I2sAjgnkn0
        jToKNqr37y3mzAGNP2G75xlUXlBqnlgaF8IX0w7B0JqyRI0i0ALj9lzFuHESHxLY8VCxB0YMbnfqH
        E1BBoz3jEu8RmzC5QAAfFMjGusciyAF9680BYrBuImEW0n4ChoMlI2Hf8/HJDPtAJNzZhQFhjCOwd
        Rv0bCHrY2PO40clS60Wu8QWctXldwjODS96spghiuAbYioIyXWiOMH5480iUGfKehhGlH8vKaRQe1
        FvzlM6pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJNW-0001f0-3Z; Tue, 14 Apr 2020 11:05:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9155B305EEC;
        Tue, 14 Apr 2020 13:05:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30A392038BC5C; Tue, 14 Apr 2020 13:05:16 +0200 (CEST)
Date:   Tue, 14 Apr 2020 13:05:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, mingo@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Message-ID: <20200414110516.GO20713@hirez.programming.kicks-ass.net>
References: <20200409134558.90863-1-songmuchun@bytedance.com>
 <20200410115658.GB24814@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410115658.GB24814@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 12:56:58PM +0100, Will Deacon wrote:
> On Thu, Apr 09, 2020 at 09:45:58PM +0800, Muchun Song wrote:
> > The creators of the C language gave us the while keyword. Let's use
> > that instead of synthesizing it from if+goto.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/seqlock.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 8b97204f35a77..7bdea019814ce 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> >  {
> >  	unsigned ret;
> >  
> > -repeat:
> > -	ret = READ_ONCE(s->sequence);
> > -	if (unlikely(ret & 1)) {
> > +	while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
> >  		cpu_relax();
> > -		goto repeat;
> > -	}
> >  	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >  	return ret;
> 
> Patch looks fine to me, but I'll leave it to Peter as I don't have a
> preference either way.

Linus sometimes prefers the goto variant as that better expresses the
exception model. But like Will, I don't particularly care. That said,
Will, would it make sense to use smp_cond_load_relaxed() here ?
