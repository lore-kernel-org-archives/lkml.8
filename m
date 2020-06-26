Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFD420768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5UV7DHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFZFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:36:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E50C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:36:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so8974670ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+l+muZt/sw8G/XSlHsPuBLXnNDdXq2H/AVjO/IHBoc=;
        b=K5UV7DHm9sm3s0sHYb6ba/xN6yhjka7U9GIVRvzcWhmYHefr1XG5DjTflYuMoeUMSq
         TUAn/RBtSxiX3HJvfVtUk9kCwiQmGcHx/xCyazjugjCJln4lJo5EjMf8spOFgpo0T5+N
         TRYQ6oLyMEmgzyYAjoUipGDHORX2lcIkK4ubblOYSITS0iDoK2UpHWGivXGOyqJQSgLs
         m/7M1p1kk233506tloZkznzt9JpH7aJ4qt/pW3GsFC699uzoZUruaZJJpnl04B+wQUcM
         V0UlqtGFtm0T2l2ovrVzXP8pqGkyWo7CGCtTYMnXKAMz4D0ityGEf68qvnJ7rktsoQbh
         FyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+l+muZt/sw8G/XSlHsPuBLXnNDdXq2H/AVjO/IHBoc=;
        b=tvZ1BCykjExGqlsstbDtEV7ZOwyJTG8tIeuThjLiuD3lF2UU+M+RHzz9e1HIGKUzDL
         k13to/2S0hQjxjQg2/7I+5rkaTOWoHzBiN7iko86Ljse1xSH4RAtpA+kXiEbJMrUETb+
         gcX5SaC9VR6kpEtKkME7ESyXYQQ85WCVEQHsyk08aDnPXrIg2y75ARNdHdo+m51XtG4i
         EQZ08gP7jgGbPgLoFlss/totNLl61c3IpktAoDl0LiCDniz302snpvs5YcAA739sMc6S
         I9TASk8iWKTor1gKTYSFm8NETPvcqvD3XkIGGLWvk9lDUoRF1UzMNUlSSosNDSP5Yovu
         wfPA==
X-Gm-Message-State: AOAM5339nrGFwDNX8iOtAAWAvocwKAqn08VO1aKp4ZxxtV/rJ2Bq69M9
        LRBX1XyI4SV9PFjZBlJTj1NCj8wtt6OCqXijUyI=
X-Google-Smtp-Source: ABdhPJzIUFNuOxJQ0Aijnx2p4E9Vz6x+8sGaNXNn5drRq5ZePW0EA4mQt/9xzTyw4YiwM8MaovWxJOaFTbifklgsRNA=
X-Received: by 2002:a2e:7208:: with SMTP id n8mr516027ljc.315.1593149788481;
 Thu, 25 Jun 2020 22:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com> <a9b8cc50-6635-0551-596b-5a67a8261e59@oracle.com>
In-Reply-To: <a9b8cc50-6635-0551-596b-5a67a8261e59@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 26 Jun 2020 11:06:17 +0530
Message-ID: <CAFqt6zZDLiz-+3H0Xq_WPYN_=PXtEuWYEvA-HXOUeup_nkVjeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xen/privcmd: Corrected error handling path and mark
 pages dirty
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 5:01 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 6/24/20 11:02 PM, Souptick Joarder wrote:
> > Previously, if lock_pages() end up partially mapping pages, it used
> > to return -ERRNO due to which unlock_pages() have to go through
> > each pages[i] till *nr_pages* to validate them. This can be avoided
> > by passing correct number of partially mapped pages & -ERRNO separately,
> > while returning from lock_pages() due to error.
> >
> > With this fix unlock_pages() doesn't need to validate pages[i] till
> > *nr_pages* for error scenario and few condition checks can be ignored.
> >
> > As discussed, pages need to be marked as dirty before unpinned it in
> > unlock_pages() which was oversight.
>
>
> There are two unrelated changes here (improving error path and marking
> pages dirty), they should be handled by separate patches.

Sure, will do it in v2.

>
>
> (I assume marking pages dirty is something you want to go to stable tree
> since otherwise there is no reason for making this change)
>
>
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Paul Durrant <xadimgnik@gmail.com>
> > ---
> > Hi,
> >
> > I'm compile tested this,
>
>
> I don't think so.

I compile test it against ARM and it was fine.
Against which ARCH is it failing ?

>
>
> >  but unable to run-time test, so any testing
> > help is much appriciated.
> >
> >  drivers/xen/privcmd.c | 34 +++++++++++++++++++---------------
> >  1 file changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index a250d11..0da417c 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -580,43 +580,44 @@ static long privcmd_ioctl_mmap_batch(
> >
> >  static int lock_pages(
> >       struct privcmd_dm_op_buf kbufs[], unsigned int num,
> > -     struct page *pages[], unsigned int nr_pages)
> > +     struct page *pages[], unsigned int nr_pages, int *pinned)
> >  {
> >       unsigned int i;
> > +     int errno = 0, page_count = 0;
>
>
> No need for error, really --- you can return the value immediately.

yes, this is unnecessary.

>
>
> >
> >       for (i = 0; i < num; i++) {
> >               unsigned int requested;
> > -             int pinned;
> >
> > +             *pinned += page_count;
>
>
> I'd move this lower, after a successful call to get_user_pages_fast()
> (and then you won't need to initialize it)

Ok.

>
>
> >               requested = DIV_ROUND_UP(
> >                       offset_in_page(kbufs[i].uptr) + kbufs[i].size,
> >                       PAGE_SIZE);
> >               if (requested > nr_pages)
> >                       return -ENOSPC;
> >
> > -             pinned = get_user_pages_fast(
> > +             page_count = get_user_pages_fast(
> >                       (unsigned long) kbufs[i].uptr,
> >                       requested, FOLL_WRITE, pages);
> > -             if (pinned < 0)
> > -                     return pinned;
> > +             if (page_count < 0) {
> > +                     errno = page_count;
> > +                     return errno;
> > +             }
> >
> > -             nr_pages -= pinned;
> > -             pages += pinned;
> > +             nr_pages -= page_count;
> > +             pages += page_count;
> >       }
> >
> > -     return 0;
> > +     return errno;
> >  }
> >
> >  static void unlock_pages(struct page *pages[], unsigned int nr_pages)
> >  {
> >       unsigned int i;
> >
> > -     if (!pages)
> > -             return;
> > -
> >       for (i = 0; i < nr_pages; i++) {
> > -             if (pages[i])
> > -                     put_page(pages[i]);
> > +             if (!PageDirty(page))
> > +                     set_page_dirty_lock(page);
> > +             put_page(pages[i]);
> >       }
>
>
> This won't compile.
>
>
> -boris
>
>
>
