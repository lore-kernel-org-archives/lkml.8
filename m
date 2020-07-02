Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1059206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeEdBqeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgGBPQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:16:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41084 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbgGBPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593703017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaHGVjmAmXhp9lutE/R+X9XTXlXuXnf2H5y3xxwJ93o=;
        b=eeEdBqeDpzUZ2QharGAkPeijprs4unJMHJtTeIShJYlbJ2watqnC5ZPQcUG5odFffKTvyR
        HQ2ZG0v9YH9i04NT/lhDv69Vn7yfeqz5s6OW2y35A50/DMYC+0HUdhbB5z518CHELrtGvD
        0QT2ZFPtyRJZScvEuPky5cYQXE3JOTI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-jTv2jKfvMYC2hdU95xZ_7w-1; Thu, 02 Jul 2020 11:16:55 -0400
X-MC-Unique: jTv2jKfvMYC2hdU95xZ_7w-1
Received: by mail-ot1-f72.google.com with SMTP id g70so4024459otg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaHGVjmAmXhp9lutE/R+X9XTXlXuXnf2H5y3xxwJ93o=;
        b=kkNUesC+XNZA72NyaBqTrUW4t9ZzXmWM2cvwHhf9kWFqcJ8mog29LT4SDkAmmzoRF+
         LH+abNQ7sKWvuR7MGePaFYpzj/yBFxiOF0dpkYiagM+9mFJP3kadSFlPklD3dwUoR4rI
         BSz5dc4bixVeVTYXHkFJ3/XC98hgwYMLBWpgeS39H/0d3AnePiJ4HtPyeXa38qU6m2pJ
         7W/hVQRx2mpZEprTyJnbW2G5Gc5D9zCGlMB96JqHqw1X3ExFJToZ3nry5dHoWKAyCbyt
         i1M+Ce5bakH5LY8GrXUoogRZYXHbi4P6FS6J66nyRgEAtme2PRxrjH5FjmkxfzCgIvZZ
         aztA==
X-Gm-Message-State: AOAM530UyCj69J5Hvq4bEbSDzJv6xya19726L3GcrUNFjcfS7q3KYXne
        iRkiMyTHMWI0wOOrIzTCD+m8Wua/qA9Ke2qHRo8M38cpoR+U/Vs0JMGiaOWMLNmTszHNN/wv458
        mNAW8pd9h55YXCgeEr1kpyw4weghm/vp1/ySMTxTi
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr22045247otg.58.1593703014901;
        Thu, 02 Jul 2020 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI3bsBzuJ3Kf//oLr+uyYhe2RcCJSWhVflkhZK7zJVGNOpQZUZYdLgArfJLRyL4CcHxYQZONIFKjbIDY2zBQc=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr22045226otg.58.1593703014619;
 Thu, 02 Jul 2020 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <20200622003215.GC2040@dread.disaster.area>
 <CAHc6FU4b_z+vhjVPmaU46VhqoD+Y7jLN3=BRDZPrS2v=_pVpfw@mail.gmail.com>
 <20200622181338.GA21350@casper.infradead.org> <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
In-Reply-To: <CAHc6FU7R2vMZ9+aXLsQ+ubECbfrBTR+yh03b_T++PRxd479vsQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 17:16:43 +0200
Message-ID: <CAHc6FU5jZfz3Kv-Aa6MWbELhTscSp5eEAXTWBoVysrQg6f1moA@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 2:35 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Mon, Jun 22, 2020 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jun 22, 2020 at 04:35:05PM +0200, Andreas Gruenbacher wrote:
> > > I'm fine with not moving that functionality into the VFS. The problem
> > > I have in gfs2 is that taking glocks is really expensive. Part of that
> > > overhead is accidental, but we definitely won't be able to fix it in
> > > the short term. So something like the IOCB_CACHED flag that prevents
> > > generic_file_read_iter from issuing readahead I/O would save the day
> > > for us. Does that idea stand a chance?
> >
> > For the short-term fix, is switching to a trylock in gfs2_readahead()
> > acceptable?
>
> Well, it's the only thing we can do for now, right?

It turns out that gfs2 can still deadlock with a trylock in
gfs2_readahead, just differently: in this instance, gfs2_glock_nq will
call inode_dio_wait. When there is pending direct I/O, we'll end up
waiting for iomap_dio_complete, which will call
invalidate_inode_pages2_range, which will try to lock the pages
already locked for gfs2_readahead.

This late in the 5.8 release cycle, I'd like to propose converting
gfs2 back to use mpage_readpages. This requires reinstating
mpage_readpages, but it's otherwise relatively trivial.
We can then introduce an IOCB_CACHED or equivalent flag, fix the
locking order in gfs2, convert gfs2 to mpage_readahead, and finally
remove mage_readpages in 5.9.

I'll post a patch queue that does this for comment.

Thanks,
Andreas

