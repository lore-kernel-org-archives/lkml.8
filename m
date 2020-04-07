Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB257C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C992075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXaKzs4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDGI12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:27:28 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33748 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgDGI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:27:28 -0400
Received: by mail-qv1-f68.google.com with SMTP id p19so1449436qve.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0fv8G5tSR5zfgqRJ7kmXqHUjkYyQ4WMqgE23q9f+8k=;
        b=AXaKzs4Y1JJ1yJjug64YQEfY47sgV0n1JjDaXos2mbA4eEd/too2PMZxpPO1+Y2/8i
         kwaTaHFI1UbMT2aB6gF7e3ib6SYq0GbUTumyqsc2HWhg+fhy8Rn1C4eKQzUq3vqHznki
         pDBgOGROQXx5pochMS97FO7ti8GD1Q3Calyphx4vkQksMqX2OzoxGwe4vJbaVcsvzP03
         i1YfMQ/iaWMzdo8FwaLMxRwtf4GMkKAGXkS+uT3GDikgHDya7sj1aN4yTbDpLCYY64Mk
         JNxYU/5ObVtr38AC6op9/gS+w06afMM0wrGm/3iX40kiVXlz1lNJIXmEBrP6C8h5Ptll
         MWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0fv8G5tSR5zfgqRJ7kmXqHUjkYyQ4WMqgE23q9f+8k=;
        b=VBqHKg0/GZ/GQzaaMlo0/min3p9Olzley3o4FHCVMzjMBOzIKbRbIVLM9Fb5Ez6OQg
         3duKdh+8N1ewWl6GXi9SH1RIw6js+5g1+HN/7o69aKkBRyNqWwgYar5Rif0+WOICTPY5
         sbvPBGAvGikkTa2HBW9gy2ecZ+Xba9r+KqvlDFKs4gg8cjkOvwQA+EJ9o0Wo5C58gGMI
         coHXWSbBsGiVRVQx8x1B6z+6KfZE5h8GQXwjuLRdt7h8ftu1JjyUNoVGHrl1X/fp1oWL
         JLQGM5M8e21SFTQvY7AgpJOWsFRZwTbxFqpDtXWlcZihbW12aK/w1wsgQo9f1TQRmjo9
         vBqQ==
X-Gm-Message-State: AGi0Pua4YGJDeM7S0uPTfzgpN+vtCDJKv8CzWGDX+B4YMTkdtSPQpBV4
        9OFyPK5UgrXQ4nhwE67Y7fYLW3DX8Qf50LOUWy5Ywg==
X-Google-Smtp-Source: APiQypIukN0mpQ0mqADuRT4G3/MTr+GVI1aZKhZS0qVMDYrulKWYXyvikpiCsukL/N1WMUtnGv1BUyfJDEYFmb4Hr70=
X-Received: by 2002:a0c:b442:: with SMTP id e2mr1069768qvf.34.1586248046646;
 Tue, 07 Apr 2020 01:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b25f105a2a3434d@google.com> <20200407004745.GA48345@xz-x1>
 <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
 <20200407015535.GC48345@xz-x1> <20200406191534.aafd8f74406c242ba1a42549@linux-foundation.org>
 <20200407024254.GD48345@xz-x1>
In-Reply-To: <20200407024254.GD48345@xz-x1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Apr 2020 10:27:15 +0200
Message-ID: <CACT4Y+bxjLaK-QG+7WQ0S-N4_1-2-gtDU=ytUDd5fUOjsxEjdA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in kernel_get_mempolicy
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        Brian Geffon <bgeffon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 4:43 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 06, 2020 at 07:15:34PM -0700, Andrew Morton wrote:
> > On Mon, 6 Apr 2020 21:55:35 -0400 Peter Xu <peterx@redhat.com> wrote:
> >
> > > On Mon, Apr 06, 2020 at 06:39:41PM -0700, Andrew Morton wrote:
> > > > On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > > >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > > > > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > > > >
> > > > > lookup_node() uses gup to pin the page and get node information.  It
> > > > > checks against ret>=0 assuming the page will be filled in.  However
> > > > > it's also possible that gup will return zero, for example, when the
> > > > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > > > gracefully return an error -EFAULT if it happens.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/mm/mempolicy.c
> > > > > +++ b/mm/mempolicy.c
> > > > > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> > > > >
> > > > >         int locked = 1;
> > > > >         err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > > > > -       if (err >= 0) {
> > > > > +       if (err == 0) {
> > > > > +               /* E.g. GUP interupted by fatal signal */
> > > > > +               err = -EFAULT;
> > > > > +       } else if (err > 0) {
> > > > >                 err = page_to_nid(p);
> > > > >                 put_page(p);
> > > > >         }
> > > >
> > > > Doh.  Thanks.
> > > >
> > > > Should it have been -EINTR?
> > >
> > > It looks ok to me too.  I was returning -EFAULT to follow the same
> > > value as get_vaddr_frames() (which is the other caller of
> > > get_user_pages_locked()).  So far the only path that I found can
> > > trigger this is when there's a fatal signal pending right after the
> > > gup.  If so, the userspace won't have a chance to see the -EINTR (or
> > > whatever we return) anyways.
> >
> > Yup.  I guess we're a victim of get_user_pages()'s screwy return value
> > conventions - the caller cannot distinguish between invalid-addr and
> > fatal-signal.
>
> Indeed.
>
> >
> > Which makes one wonder why lookup_node() ever worked.  What happens if
> > get_mempolicy(MPOL_F_NODE) is passed a wild userspace address?
> >
>
> I'm not familiar with mempolicy at all, but do you mean MPOL_F_NODE
> with MPOL_F_ADDR?  Asked since iiuc if only MPOL_F_NODE is specified,
> the kernel should not use the userspace addr at all (which seems to be
> the thing we do now).  get_mempolicy(MPOL_F_NODE|MPOL_F_ADDR) seems to
> return -EFAULT as expected, though I agree maybe it would still be
> nicer to differentiate the two cases.

Am I reading this correctly that we put an initialized struct page* in
this case? If so, with stack spraying this looks like an "interesting"
bug.
