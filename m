Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37092C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44F207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6Rz7dKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGBzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:55:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgDGBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586224540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oItCj2q8YHb63ZBfFyBFQkDD3U/LJfbIS9cHzfIZ+kg=;
        b=B6Rz7dKmqjP/KZc/yHJLXh5qkViWKUmVdbJHXVWDpYNpF4GSCLOLl5E5YMazBfhaNyFkTf
        7ZrCwbnlb4mfKto+XLkIQKRWmcjGxCdPfAGDGvaXqnos+7KVxeJOBDkw6tRlCGKPTc47mR
        FSrvw5rjSd/jmmk+pa5K4YuaEh4t+Y8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-2xOz6wj1N22t3dsDwhlmSA-1; Mon, 06 Apr 2020 21:55:38 -0400
X-MC-Unique: 2xOz6wj1N22t3dsDwhlmSA-1
Received: by mail-qt1-f198.google.com with SMTP id n89so1748662qte.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oItCj2q8YHb63ZBfFyBFQkDD3U/LJfbIS9cHzfIZ+kg=;
        b=rAS68Ug9Up1JhHOXOWlTBX1Ta+iH+DNfq0epE4Pd+8yxcYbGfMFReANkGRs+EiDfFA
         Amr8QnaPrEuIS6qYen1tHu2vDRAvGteSXTBgwGJJqsPRVQ7uSwR5a7k1MPvVrkJY+T5s
         GwDf4ZVOXB2INzSAZdjo15hNhr81QqjrF6q6tXvxYhmEYZPfRIsSxpms8R0Yra9Cb5Yi
         w+LHYn/TgfO/YaDOo1AlB9d6iXBMYEUw+j4j4Lh6BQ8JijSf2mNqvnjtld72Ni66kGdn
         h1ogYc+rRzAbwjcAU29X2RtU7fOKaXWLkZqMnbZxgNpZ0ERwEnXagRcK1+SOHsJsZ2cr
         VlGA==
X-Gm-Message-State: AGi0PuY/AS8Okh8kT51rFT2/MjxEqMs3SxJOzfjHhzIOvKhvsTxOm108
        01Nqve61XjeSFBxJD+HrxzSgi7e5mohordfxWJ4odkUfoKMD6Td/pyBMnXYAGHk44gi3LZE3m3q
        bL2PDsqkV4GbY2XUr+dZUS+VX
X-Received: by 2002:ac8:4d8b:: with SMTP id a11mr143478qtw.391.1586224538182;
        Mon, 06 Apr 2020 18:55:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+gNlV/6Oyl3ckqIUc2Hc29srtoZnCqrcc5MKHtt+qWVWRdKpz+NvsF8oAGL3g8gWu3juB0g==
X-Received: by 2002:ac8:4d8b:: with SMTP id a11mr143461qtw.391.1586224537863;
        Mon, 06 Apr 2020 18:55:37 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id c6sm13998002qkg.88.2020.04.06.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:55:37 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:55:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        bgeffon@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-ID: <20200407015535.GC48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
 <20200407004745.GA48345@xz-x1>
 <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:39:41PM -0700, Andrew Morton wrote:
> On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > 
> > lookup_node() uses gup to pin the page and get node information.  It
> > checks against ret>=0 assuming the page will be filled in.  However
> > it's also possible that gup will return zero, for example, when the
> > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > gracefully return an error -EFAULT if it happens.
> > 
> > ...
> >
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> >  
> >  	int locked = 1;
> >  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > -	if (err >= 0) {
> > +	if (err == 0) {
> > +		/* E.g. GUP interupted by fatal signal */
> > +		err = -EFAULT;
> > +	} else if (err > 0) {
> >  		err = page_to_nid(p);
> >  		put_page(p);
> >  	}
> 
> Doh.  Thanks.
> 
> Should it have been -EINTR?

It looks ok to me too.  I was returning -EFAULT to follow the same
value as get_vaddr_frames() (which is the other caller of
get_user_pages_locked()).  So far the only path that I found can
trigger this is when there's a fatal signal pending right after the
gup.  If so, the userspace won't have a chance to see the -EINTR (or
whatever we return) anyways.

Thanks,

-- 
Peter Xu

