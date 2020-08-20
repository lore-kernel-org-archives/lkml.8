Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AB52075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cT3s3iCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHTTE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgHTTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:04:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC4C061388
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oA8uW7xzETbBJpktLvfoWrpUHRp3r6xKbF8SQ19fA74=; b=cT3s3iCAC3O1Z0gjwp8wfy0/UJ
        0IlYiuYJqtSKiuOtkFuqtSTJftpvNc0G3FNGHl8++L/N+AgGgrPnmGv6ufwuCy9feDahFCESKaDBp
        c6l19FIZp0icjVgWPF39E5cmYa2SGBM4saE85Ea4yh99q2kEgazuqHe5BypI3B0h5xvLmIjl3BeL3
        zR56Ns2uW9KWR/5tiBoz8mX+MpVMcLe1kkIsrvp9INELNG6xpJfBZ5zeTVFihCnWK4vIxo6WCI15A
        k2H/LxikQ/83B0Mkd03UggIezRV9DnBaOc8EzNDNw+Q3LxZ/4PRqqogqr7dp1Uotkb+mLPI09xCA/
        M3k+d14w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8prg-0003MN-B9; Thu, 20 Aug 2020 19:04:44 +0000
Date:   Thu, 20 Aug 2020 20:04:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm: Rewrite shmem_seek_hole_data
Message-ID: <20200820190444.GN17456@casper.infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-3-willy@infradead.org>
 <20200820164546.GD752365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820164546.GD752365@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 07:45:46PM +0300, Mike Rapoport wrote:
> > - * llseek SEEK_DATA or SEEK_HOLE through the page cache.
> > + * llseek SEEK_DATA or SEEK_HOLE through the page cache.  We don't need
> > + * to get a reference on the page because this interface is racy anyway.
> > + * The page we find will have had the state at some point.
> 
> For my non-native ear "will have had" is too complex ;-)

Fair!  How about simply "The page we find did have the state at some point".

But now I'm thinking about it some more, and I'm not so sure of it now.
What if we put a page in the cache that was !Uptodate, then we do a
lookup, find this pointer, then the page is removed from the cache,
then it's allocated somewhere else, marked Uptodate, and now we're
scheduled back in and find it's Uptodate, when there was never a page
at this location that was Uptodate?

So maybe I have to retract this patch after all.

> >   */
> >  static pgoff_t shmem_seek_hole_data(struct address_space *mapping,
> >  				    pgoff_t index, pgoff_t end, int whence)
> >  {
> > +	XA_STATE(xas, &mapping->i_pages, index);
> >  	struct page *page;
> > -	struct pagevec pvec;
> > -	pgoff_t indices[PAGEVEC_SIZE];
> > -	bool done = false;
> > -	int i;
> >  
> > -	pagevec_init(&pvec);
> > -	pvec.nr = 1;		/* start small: we may be there already */
> > -	while (!done) {
> > -		pvec.nr = find_get_entries(mapping, index,
> > -					pvec.nr, pvec.pages, indices);
> > -		if (!pvec.nr) {
> > -			if (whence == SEEK_DATA)
> > -				index = end;
> > -			break;
> > +	rcu_read_lock();
> > +	if (whence == SEEK_DATA) {
> > +		for (;;) {
> > +			page = xas_find(&xas, end);
> > +			if (xas_retry(&xas, page))
> > +				continue;
> > +			if (!page || xa_is_value(page) || PageUptodate(page))
> > +				break;
> >  		}
> > -		for (i = 0; i < pvec.nr; i++, index++) {
> > -			if (index < indices[i]) {
> > -				if (whence == SEEK_HOLE) {
> > -					done = true;
> > -					break;
> > -				}
> > -				index = indices[i];
> > -			}
> > -			page = pvec.pages[i];
> > -			if (page && !xa_is_value(page)) {
> > -				if (!PageUptodate(page))
> > -					page = NULL;
> > -			}
> > -			if (index >= end ||
> > -			    (page && whence == SEEK_DATA) ||
> > -			    (!page && whence == SEEK_HOLE)) {
> > -				done = true;
> > +	} else /* SEEK_HOLE */ {
> > +		for (;;) {
> > +			page = xas_next(&xas);
> > +			if (xas_retry(&xas, page))
> > +				continue;
> > +			if (!xa_is_value(page) &&
> > +					(!page || !PageUptodate(page)))
> > +				break;
> > +			if (xas.xa_index >= end)
> >  				break;
> > -			}
> >  		}
> > -		pagevec_remove_exceptionals(&pvec);
> > -		pagevec_release(&pvec);
> > -		pvec.nr = PAGEVEC_SIZE;
> > -		cond_resched();
> >  	}
> > -	return index;
> > +	rcu_read_unlock();
> > +
> > +	return xas.xa_index;
> >  }
> >  
> >  static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
> > -- 
> > 2.28.0
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
