Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1121C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782DF2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz68M9cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgFZGsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgFZGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:48:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:48:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so9164651ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tAiutF2JVV2jVzi4JN5lKA5pAFxBJvB1zS7W+zLCNGU=;
        b=Jz68M9cZSFRsa1lfuYI3fBa8wMImUyWpZmFLLZbO40bbGfouXOj3N6vDdnVrcVqqTX
         Lbi15a+HZlQXw04tJgZx7ZXkGgXgQERKqgR7Z/sv2m7ETVW9mami6HmOgwYPMhOdUecQ
         wvzjWm6VbFP3Jly0snbok9qhBxmvxgclwE3n0J0kwGzahrDuDGL9ZhVzLJyH8Znv3FDx
         lqoAb4K+DUnybEjiQ7y3HXXOpNX9vwZL5Ce+k22vvFszcQcxlNO+rRwx5WziQwbbXVhq
         my1X1ocgZrIQp7b2Leqc5DRVI+4Qf/008okO2tVZ1QGMj84x5Tj6SYrNxSBZ8/fqkyq0
         thCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAiutF2JVV2jVzi4JN5lKA5pAFxBJvB1zS7W+zLCNGU=;
        b=t0XxCTeNwp40UEhq8f+koKZIHwYEKa50MnKQh40+xqj/CxU5WQbEl5pjriEV/wFcU+
         dPiKhOW5IT9kqMKNCAgDh7ZH82Iy2p//nE47fL3IUHCXNknwNcQcuhpsYD7x5MxheToD
         Kf59+yyoLzAtFv33m/ciQyQuHuTXz8fnu6/iPhor7vfei0u33Ap9sWu51CjcaleypHpf
         z63w9sZIoAjAuY2niFq6FJczYSnzFJaCyZ/2nrQT1+mVU6vVIY7PCcIN0o7DoyWVPcGN
         /jUgkxE317C2dafQHBRlszBgRAn0ZwtH+NyN7/RHBoHSMwVYasFlb/TthEqbBwpUnIPl
         AM3w==
X-Gm-Message-State: AOAM53055+PkiYOo21k6XLECus3mXj/hU6vjy6G037rZ8bUGwV/Gc8bh
        Fi2245thGnsDP4BxzwSC1VSQtnHxxwyUDqsLCbU=
X-Google-Smtp-Source: ABdhPJwywRiIDFcdW8SgEjZ9w6GKNMQWagCVc2TIKPv5IsPXc4jb6x5KjKPF+JpzzRyAUIZFamnEc6LM3RArfv1S/9I=
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr551883ljf.257.1593154114931;
 Thu, 25 Jun 2020 23:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com> <9ff52733-6ce0-6bda-8e49-a6908b4ff7dc@suse.com>
In-Reply-To: <9ff52733-6ce0-6bda-8e49-a6908b4ff7dc@suse.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 26 Jun 2020 12:18:23 +0530
Message-ID: <CAFqt6zYvU7hFoY_5T2P0C4=G_gZWoQZYCpdcMM6Mn9WQ_rnXaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xen/privcmd: Corrected error handling path and mark
 pages dirty
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:22 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wr=
ote:
>
> On 25.06.20 05:02, Souptick Joarder wrote:
> > Previously, if lock_pages() end up partially mapping pages, it used
> > to return -ERRNO due to which unlock_pages() have to go through
> > each pages[i] till *nr_pages* to validate them. This can be avoided
> > by passing correct number of partially mapped pages & -ERRNO separately=
,
> > while returning from lock_pages() due to error.
> >
> > With this fix unlock_pages() doesn't need to validate pages[i] till
> > *nr_pages* for error scenario and few condition checks can be ignored.
> >
> > As discussed, pages need to be marked as dirty before unpinned it in
> > unlock_pages() which was oversight.
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
> >   drivers/xen/privcmd.c | 34 +++++++++++++++++++---------------
> >   1 file changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index a250d11..0da417c 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -580,43 +580,44 @@ static long privcmd_ioctl_mmap_batch(
> >
> >   static int lock_pages(
> >       struct privcmd_dm_op_buf kbufs[], unsigned int num,
> > -     struct page *pages[], unsigned int nr_pages)
> > +     struct page *pages[], unsigned int nr_pages, int *pinned)
>
> unsigned int *pinned, please.
>
> >   {
> >       unsigned int i;
> > +     int errno =3D 0, page_count =3D 0;
>
> Please drop the errno variable. It is misnamed (you never assign an
> errno value to it) and not needed, as you can ...
>
> >
> >       for (i =3D 0; i < num; i++) {
> >               unsigned int requested;
> > -             int pinned;
> >
> > +             *pinned +=3D page_count;
> >               requested =3D DIV_ROUND_UP(
> >                       offset_in_page(kbufs[i].uptr) + kbufs[i].size,
> >                       PAGE_SIZE);
> >               if (requested > nr_pages)
> >                       return -ENOSPC;
> >
> > -             pinned =3D get_user_pages_fast(
> > +             page_count =3D get_user_pages_fast(
> >                       (unsigned long) kbufs[i].uptr,
> >                       requested, FOLL_WRITE, pages);
> > -             if (pinned < 0)
> > -                     return pinned;
> > +             if (page_count < 0) {
> > +                     errno =3D page_count;
> > +                     return errno;
>
> ... just return page_count her, and ...
>
> > +             }
> >
> > -             nr_pages -=3D pinned;
> > -             pages +=3D pinned;
> > +             nr_pages -=3D page_count;
> > +             pages +=3D page_count;
> >       }
> >
> > -     return 0;
> > +     return errno;
>
> ... leave this as it was.
>
> >   }
> >
> >   static void unlock_pages(struct page *pages[], unsigned int nr_pages)
> >   {
> >       unsigned int i;
> >
> > -     if (!pages)
> > -             return;
> > -
> >       for (i =3D 0; i < nr_pages; i++) {
> > -             if (pages[i])
> > -                     put_page(pages[i]);
> > +             if (!PageDirty(page))
> > +                     set_page_dirty_lock(page);
>
> page? Not pages[i]?

I fixed it in compile branch, but missed it in patch creation work
space at the time of posting.
I think, this is the compile error Boris was pointing to.
Sorry about it. I will fix it and post the v2.

>
> > +             put_page(pages[i]);
> >       }
> >   }
> >
> > @@ -630,6 +631,7 @@ static long privcmd_ioctl_dm_op(struct file *file, =
void __user *udata)
> >       struct xen_dm_op_buf *xbufs =3D NULL;
> >       unsigned int i;
> >       long rc;
> > +     int pinned =3D 0;
> >
> >       if (copy_from_user(&kdata, udata, sizeof(kdata)))
> >               return -EFAULT;
> > @@ -683,9 +685,11 @@ static long privcmd_ioctl_dm_op(struct file *file,=
 void __user *udata)
> >               goto out;
> >       }
> >
> > -     rc =3D lock_pages(kbufs, kdata.num, pages, nr_pages);
> > -     if (rc)
> > +     rc =3D lock_pages(kbufs, kdata.num, pages, nr_pages, &pinned);
> > +     if (rc < 0) {
> > +             nr_pages =3D pinned;
> >               goto out;
> > +     }
> >
> >       for (i =3D 0; i < kdata.num; i++) {
> >               set_xen_guest_handle(xbufs[i].h, kbufs[i].uptr);
> >
>
>
> Juergen
