Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88706C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FE02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="psuhvaDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgGJUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgGJUBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2588C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gZ14XZU76Moz0JJm/DTbCynhQSKBoFpfiud9XVKdk/0=; b=psuhvaDfJScNec39Soi5BOpt5S
        Blx+Orwk8ErlcTCSvyahfRbPncIDtWPPHHv4YcfjBNvSRrvJhUPhyKXDOGNAwPnQzXad8jIfANotY
        zOmi4y0B3bW/igWaJOfDCL58kLNQpk1qYW3jFLaR+uueRxn3onAYSnSHJ+EAAXTffc1ZUf2uw5m6E
        7ZcWc9n+lFU75t645LTPojJuSJehnVpjSyCc4x9inIyCruXvd4lbbNh/ReodNvltd3e3bP6O3SMno
        yXn5b7T/ryTNNq7K7CtEt2cs3ugM1G+k9xFeZCU3HgqZgT+D0ToIHV/R+weU32CN8bmmbNJqCfhly
        lN5Y+7FQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtzDG-00048T-DR; Fri, 10 Jul 2020 20:01:38 +0000
Date:   Fri, 10 Jul 2020 21:01:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas
 overlap
Message-ID: <20200710200138.GQ12769@casper.infradead.org>
References: <20200710194042.2510-1-urezki@gmail.com>
 <20200710194406.GP12769@casper.infradead.org>
 <20200710200030.GB19487@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710200030.GB19487@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:00:30PM +0200, Uladzislau Rezki wrote:
> On Fri, Jul 10, 2020 at 08:44:06PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 10, 2020 at 09:40:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Before triggering a BUG() it would be useful to understand
> > > how two areas overlap between each other. Print information
> > > about start/end addresses of both VAs and their addresses.
> > > 
> > > For example if both are identical it could mean double free.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 5a2b55c8dd9a..1679b01febcd 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
> > >  		else if (va->va_end > tmp_va->va_start &&
> > >  				va->va_start >= tmp_va->va_end)
> > >  			link = &(*link)->rb_right;
> > > -		else
> > > +		else {
> > > +			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
> > > +				va, va->va_start, va->va_end, tmp_va,
> > > +				tmp_va->va_start, tmp_va->va_end);
> > 
> > It might be helpful to have a "vmalloc:" prefix to that string to indicate
> > where to start searching.  And I don't think we're supposed to use %px
> > without a really good justification these days.
> >
> That makes sense, i will add such prefix for sure. As for %px i can just
> use a casting to (unsigned long) and 0x%lx prefix.

That's not the point.  Linus wants us to not display actual pointers to
the user.

