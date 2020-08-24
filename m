Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34072C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019032074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hB78woS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHXTWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgHXTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:22:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kYjuOG42Pf1wUxE3HuOUosmUkIHVzXaCDeTnguR2S+w=; b=hB78woS93z82XwwFsV7G/ATAG8
        C0SM1mmWjKAl/yzV/7UkikVcMgxdHFKOo8uWwYoxDOIfynZUuCOokRpnyKKvJa4O/hujdcFNx/3zt
        Plkq6oRbJJclVBQ2UyfXi9SMfWhr4hNk7sCQITVQJwJ4Vq4tlXnA9/aIwhySYtzTksla+ts0CJOcl
        ZdUghgSdZpdoEycIpMHVX2zx1CISvNY5h6JHi72L3T3pmgGjgufMNiio6WB7bQUTO0IjyboPmc0VR
        zaCm1ojsYb4PYufBWQ/n1h2WQtwtImtjmPmg8YZ/WZCZP9boCKoGhm6SOGpbvsDn0DK/mexegKk4d
        LVI4TQfw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAI2o-0004PU-M2; Mon, 24 Aug 2020 19:22:14 +0000
Date:   Mon, 24 Aug 2020 20:22:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempool: Add 'else' to split mutually exclusive case
Message-ID: <20200824192214.GF17456@casper.infradead.org>
References: <20200824115354.7879-1-linmiaohe@huawei.com>
 <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:18:40PM -0700, Andrew Morton wrote:
> On Mon, 24 Aug 2020 07:53:54 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> > Add else to split mutually exclusive case and avoid some unnecessary check.
> > 
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -60,9 +60,8 @@ static void check_element(mempool_t *pool, void *element)
> >  	/* Mempools backed by slab allocator */
> >  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
> >  		__check_element(pool, element, ksize(element));
> > -
> >  	/* Mempools backed by page allocator */
> > -	if (pool->free == mempool_free_pages) {
> > +	else if (pool->free == mempool_free_pages) {
> >  		int order = (int)(long)pool->pool_data;
> >  		void *addr = kmap_atomic((struct page *)element);
> >  
> 
> It doesn't seem to change code generation (compiler is smart), but I
> think it helps readability.

Not with the comments where they are
