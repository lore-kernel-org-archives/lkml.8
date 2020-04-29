Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418C0C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE622203
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0NgVJZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2SZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2SZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:25:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388EC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mk8Z9sCY0AhAexl6PYPVinqKRa9QYElOCdGLIqmtc8Y=; b=h0NgVJZnMQxSMXEuqfJICAC3T9
        DVTnQvYxycKsv119y9J9+OnK1xPBqKoOR2PzIMa+JPHZwiYWXb4EMkeDgGRU2AX5x0vdOMVmgOmSE
        8eWtvR4CrHy/U2yEyWpy2SBgyZ/tKI2xbT7qpHjwOT3x+1mXJLdnuBHtSnaiVPx3lnW7fL0HLCoer
        29gnZMWOkrivqfvC//UzEW8RHJmYHhDxbsAYgo35Goc1Khg5XZ9dIfEOm24XjJVFDS02HP8OFBot/
        wvNgnzAQtcHCHkX4ANTRtpwbAjyrfCGobZGvRfPs5bApZTRz1dot8UtI4KoccJkt/8ho14puFjqGZ
        /VKECLDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTrOO-0006rY-LW; Wed, 29 Apr 2020 18:25:08 +0000
Date:   Wed, 29 Apr 2020 11:25:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Changbin Du <changbin.du@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
Message-ID: <20200429182508.GU29705@bombadil.infradead.org>
References: <20200429135328.26976-1-longman@redhat.com>
 <af19e771-062f-6ed7-0b9a-e8cd8d0fdb6a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af19e771-062f-6ed7-0b9a-e8cd8d0fdb6a@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:42:55PM +0200, Markus Elfring wrote:
> > In a couple of places in the slub memory allocator, the code uses
> > "s->offset" as a check to see if the free pointer is put right after the
> > object. That check is no longer true with commit 3202fa62fb43 ("slub:
> > relocate freelist pointer to middle of object").
> 
> Will any further collateral evolution become interesting?

What do you mean by this question?

> > +static inline unsigned int get_info_end(struct kmem_cache *s)
> > +{
> > +	if (freeptr_outside_object(s))
> > +		return s->inuse + sizeof(void *);
> > +	else
> > +		return s->inuse;
> > +}
> 
> How do you think about the following source code variants?
> 
> +	return freeptr_outside_object(s)
> +	       ? s->inuse + sizeof(void *)
> +	       : s->inuse;

That is less clear than the version Wayman posted.

> >  static struct track *get_track(struct kmem_cache *s, void *object,
> >  	enum track_item alloc)
> >  {
> >  	struct track *p;
> >
> > -	if (s->offset)
> > -		p = object + s->offset + sizeof(void *);
> > -	else
> > -		p = object + s->inuse;
> > +	p = object + get_info_end(s);
> >
> >  	return p + alloc;
> >  }
> 
> +	struct track *p = object + get_info_end(s);
> 
>  	return p + alloc;

Yes, I think that's an improvement.
