Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B03C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8A6206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flMy3BMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDGCnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:43:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26926 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726312AbgDGCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586227378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRbC1rzVADwFG25IejKrn57SzQYDjjpXJx3tCx1nnHU=;
        b=flMy3BMxErDBJkxgRqoZlx5caFaiACQciTrb9bnXGpTR7Drm4KtybCkGGU2Tqnd+3x+dTJ
        7x+ys74F/H3Mdu1wXeqLO+5Bb3+4rjfpNuRZ42pPLBh/OyVn0ScVQgdSZi6qwwd+Vy4m6f
        hT4j9gDMWuG37EfsUNqEGxX7FOwVu0c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169--tOAwA5JPguBVJnzeEifEA-1; Mon, 06 Apr 2020 22:42:57 -0400
X-MC-Unique: -tOAwA5JPguBVJnzeEifEA-1
Received: by mail-qv1-f72.google.com with SMTP id j7so1720647qvy.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 19:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRbC1rzVADwFG25IejKrn57SzQYDjjpXJx3tCx1nnHU=;
        b=j1knnvPQWIwLIdT72AcT86GyM32442+I7vG/eQu0wBAEkPl2rGcV9Whu+8Ly5nNm2V
         5FtD/uSTpJjid8RkHRgpg36i1y9pTFqjhqZG+TJB+nrCizANiJfLYzVbrktQLULc4onQ
         IcL502Mc0vKz2N+SUCbsdH7nN9RhhwfkEjdgHXZLEsCSsGCLe6icdkmRoCfBsJIQvoC3
         wqssmSp9APHDVuPBghB9r7MXjyYRh5ERAVy0r+U9I/2ZhJ6MdP8m65oyUQSK445/MYd6
         AMrC9t4My3vpVXFw2gEmKsofjV05npDtns9agKMGn0mZTa7MHw0xIGQtgS1IQwf1c0Bf
         mmaA==
X-Gm-Message-State: AGi0PubysPyMHRYmkDcOJN557RUKHatp/bWAFZvFzUz9D4R+/XjwsY3i
        u1C5xWpxId1MIT1mkVfAHadUPs+QE2x8H8xL9HulOsbQLoaQYLwdZRJJ7FLK2ySyjVFG3kcAE0+
        Svco0Pp7LrJ7EsGfsj7qgwFeo
X-Received: by 2002:a0c:ee43:: with SMTP id m3mr168863qvs.164.1586227376958;
        Mon, 06 Apr 2020 19:42:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKZUk6f94FsaqytTfxzUg3txoTEW6qWDqKeIkY3IOnUYwqNFVwRuP3nRvxR5AYnByyz8NRjlQ==
X-Received: by 2002:a0c:ee43:: with SMTP id m3mr168850qvs.164.1586227376652;
        Mon, 06 Apr 2020 19:42:56 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id y16sm9994696qtj.32.2020.04.06.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 19:42:56 -0700 (PDT)
Date:   Mon, 6 Apr 2020 22:42:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        bgeffon@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-ID: <20200407024254.GD48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
 <20200407004745.GA48345@xz-x1>
 <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
 <20200407015535.GC48345@xz-x1>
 <20200406191534.aafd8f74406c242ba1a42549@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406191534.aafd8f74406c242ba1a42549@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 07:15:34PM -0700, Andrew Morton wrote:
> On Mon, 6 Apr 2020 21:55:35 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Apr 06, 2020 at 06:39:41PM -0700, Andrew Morton wrote:
> > > On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > > > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > > > 
> > > > lookup_node() uses gup to pin the page and get node information.  It
> > > > checks against ret>=0 assuming the page will be filled in.  However
> > > > it's also possible that gup will return zero, for example, when the
> > > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > > gracefully return an error -EFAULT if it happens.
> > > > 
> > > > ...
> > > >
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> > > >  
> > > >  	int locked = 1;
> > > >  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > > > -	if (err >= 0) {
> > > > +	if (err == 0) {
> > > > +		/* E.g. GUP interupted by fatal signal */
> > > > +		err = -EFAULT;
> > > > +	} else if (err > 0) {
> > > >  		err = page_to_nid(p);
> > > >  		put_page(p);
> > > >  	}
> > > 
> > > Doh.  Thanks.
> > > 
> > > Should it have been -EINTR?
> > 
> > It looks ok to me too.  I was returning -EFAULT to follow the same
> > value as get_vaddr_frames() (which is the other caller of
> > get_user_pages_locked()).  So far the only path that I found can
> > trigger this is when there's a fatal signal pending right after the
> > gup.  If so, the userspace won't have a chance to see the -EINTR (or
> > whatever we return) anyways.
> 
> Yup.  I guess we're a victim of get_user_pages()'s screwy return value
> conventions - the caller cannot distinguish between invalid-addr and
> fatal-signal.

Indeed.

> 
> Which makes one wonder why lookup_node() ever worked.  What happens if
> get_mempolicy(MPOL_F_NODE) is passed a wild userspace address?
> 

I'm not familiar with mempolicy at all, but do you mean MPOL_F_NODE
with MPOL_F_ADDR?  Asked since iiuc if only MPOL_F_NODE is specified,
the kernel should not use the userspace addr at all (which seems to be
the thing we do now).  get_mempolicy(MPOL_F_NODE|MPOL_F_ADDR) seems to
return -EFAULT as expected, though I agree maybe it would still be
nicer to differentiate the two cases.

Thanks,

-- 
Peter Xu

