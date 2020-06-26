Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BB620775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRZemnxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgFZF1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgFZF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:27:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981ECC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:27:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so9016324ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuCEJOiQoqa0Rytop5ZoclTGnejYAU1zTtQWpgV+XJk=;
        b=tRZemnxbVY6+6epMlhA+YSEtiuBGPEfAgB7O3fyn6uOiRsNkYm8inikyYy99XChNgC
         IjyB5mPxS+WDnHZLaTELQk0or68E/i08k+5eQ3qHN3hKJ1lSGExWo7fLmnSljN8CSPZs
         3aotvq09CnSbdrOE4Qao5qky74s3HwM8Lhtc8h6mzIfbma4aaEyH8/pfiNoqDA0cMX7m
         Hua8P47pfUW94Ms5WNu2oeE2qYHV5+np7uwKMXTbrBkfI6BepiAUIbwVtsafO2aWaVhP
         ZEYnQCUjJEmgnL+8WiH40CxOdIE5lltvkb7bOjS9g6lRMmYGAfsqdBfeGs60h3rO6SNw
         RTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuCEJOiQoqa0Rytop5ZoclTGnejYAU1zTtQWpgV+XJk=;
        b=mTM8/hKmqdgbI4vwBnuvYKVJn7+sp9j7A7OzYP5fKH5huOgz69286RYuFi+VBo/fI0
         xMzTj8X8jueLHZoIDgoI71hRQWskujeKErBcxTcn0L07pcQ1KYWyyDUNSt/NjgGRS/P6
         LpyRKWiE7WB3iCsnGB4k/K3rDeZNmVvvNuADUgraGe+DEeVwuQoKlYeGKpXVbF7EYQEz
         b4n95/dCmYv8dW/V7UJ7dm3N3htDKzL/Oxn66jP/JgSvaEHr1VcSl2X+R8ADoegJfjpT
         QY/jB23oX4bFDK/xexiq5P9Kl7mFIsZ+pGEp0ZMWRIzIvRxVjOQ8gYuairoHYewXENgz
         bWuA==
X-Gm-Message-State: AOAM532VWpc+gjllk8auEREyxlSlynfVJf8PCNm34KBXfo9ge122YOP0
        /FGGLm2UqMeeHsgiO1IlKmQo9/je73cm11xcsNk=
X-Google-Smtp-Source: ABdhPJympWOSvfCz5C0Bh0T+ZGbmTwsB4TIChwXQNXDAd0cIBhtJwVxJLh3CgynI4lIIQS2Vw2jHrcfucD0IFOhz1vE=
X-Received: by 2002:a2e:b704:: with SMTP id j4mr593539ljo.458.1593149225080;
 Thu, 25 Jun 2020 22:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
 <1593054160-12628-2-git-send-email-jrdr.linux@gmail.com> <59afe2fe-3718-85aa-f3b5-83ca0b9df577@nvidia.com>
In-Reply-To: <59afe2fe-3718-85aa-f3b5-83ca0b9df577@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 26 Jun 2020 10:56:53 +0530
Message-ID: <CAFqt6zZdq_OMZ3EBDGC+Bn4uPBEhDGOYF=jB4B16z7rY6hpZ7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:19 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-24 20:02, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information. This is case 5 as per document [1].
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >          https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Paul Durrant <xadimgnik@gmail.com>
> > ---
> > Hi,
> >
> > I'm compile tested this, but unable to run-time test, so any testing
> > help is much appriciated.
> >
> >   drivers/xen/privcmd.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index 0da417c..eb05254 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -595,7 +595,7 @@ static int lock_pages(
> >               if (requested > nr_pages)
> >                       return -ENOSPC;
> >
> > -             page_count = get_user_pages_fast(
> > +             page_count = pin_user_pages_fast(
> >                       (unsigned long) kbufs[i].uptr,
> >                       requested, FOLL_WRITE, pages);
> >               if (page_count < 0) {
> > @@ -612,13 +612,7 @@ static int lock_pages(
> >
> >   static void unlock_pages(struct page *pages[], unsigned int nr_pages)
> >   {
> > -     unsigned int i;
> > -
> > -     for (i = 0; i < nr_pages; i++) {
> > -             if (!PageDirty(page))
> > -                     set_page_dirty_lock(page);
> > -             put_page(pages[i]);
> > -     }
> > +     unpin_user_pages_dirty_lock(pages, nr_pages, 1);
>
> "true", not "1", is the correct way to call that function.

Ok.

>
> Also, this approach changes the behavior slightly, but I think it's
> reasonable to just set_page_dirty_lock() on the whole range--hard to
> see much benefit in checking PageDirty first.

unpin_user_pages_dirty_lock() internally will do the same check after
patch [2/2]
So I thought to keep old and new code in sync. Shall we avoid this check ?


>
>
> >   }
> >
> >   static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
> >
>
> thanks,
> --
> John Hubbard
> NVIDIA
