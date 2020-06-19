Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A13E20888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt+wAPHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgFSDM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbgFSDMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:12:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1955CC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:12:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c21so4706698lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ux+RlrRIaul1vx3+RsucEfoBIW1+wn2hepN2AwYL3gA=;
        b=Bt+wAPHbtIEVMjqIuaGC/1uyx9g+h0JmstAgvL3YJl4+t451+WyOTbJOfEvXeXX9eD
         1Ltc346gaSEn7p3ivSehx5IBh4xH6ymqh+Cq5lYwtfijHLGYMnDbhhfUEQEC6v7QTi9t
         Gvpm/+doEjzk2t50RGWoXl/eMh2lar/D82DnoQZeJv6XzRq+Fc5AvAcG2D+/Hskhaijt
         5qOCFYr9fyIP7Xa+r/t0Lv45+tYjKdVg59nS+ejWw+WcV4bkYdYXGAGgDgDTeKjRc7CK
         GEn4QL8/i4qrDlg0rT9E35HKdjJaOz/dsHKWRrtezLn9lpB9h6gMQoE0SemWFonpZquG
         NmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ux+RlrRIaul1vx3+RsucEfoBIW1+wn2hepN2AwYL3gA=;
        b=thahU3ZsmCJ3g5d+Se9Zcg+BQ1lkINFOxlOWbIyh/JxmOjPhGP3gdgmakcQ6hMuF31
         V+M9iD04Lt8NjtX/05fAkx98Ma1ZyczUV6odFMGHKRXTxayVTYu5qAZOofI6o8J2K+Qo
         HHMg3POrLiK16QEcdw4uN/i4h2Fq8jp8zaIrjD9tw3PbP/MxRpuiydTPYC8Ayf2+yOKy
         vRZebsNqiIuzfBay9AtO12v4sW+pQjvVozXsy9cVfivN+8xRHaB3+GBaEWA1OryVKInw
         UVBhg2xaUjD+FT4+0fc+GIPNMUeDvF8BVKswqYKja7SsTlwIAnn5pY8isWvZYUrzI7fN
         yvVQ==
X-Gm-Message-State: AOAM533xGEJTVtrLk8pGcgQm0P5h3bAmOBqARAgvf4DLChtX4OUHYU+k
        UmQmZsMDBtgH33JC/qr/Jby+WXvCKKD3Hf4o+ud8fAqI
X-Google-Smtp-Source: ABdhPJwoJSHfdvQytNKngbcarE9utMq6l97RiL9akPNyVTfXUc439uP32EBiYbbxCOoeDZvLjAyRLu9iHNLCGLt7VZU=
X-Received: by 2002:a19:b07:: with SMTP id 7mr509645lfl.38.1592536371497; Thu,
 18 Jun 2020 20:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com> <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com>
In-Reply-To: <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 19 Jun 2020 08:42:39 +0530
Message-ID: <CAFqt6zbJD+k9xkV9Se0nL2qKfnea3mRrWJ4gzPmPJBquYk4M+w@mail.gmail.com>
Subject: Re: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 6/16/20 11:14 PM, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information.
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >         https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> > Hi,
> >
> > I have compile tested this patch but unable to run-time test,
> > so any testing help is much appriciated.
> >
> > Also have a question, why the existing code is not marking the
> > pages dirty (since it did FOLL_WRITE) ?
>
>
> Indeed, seems to me it should. Paul?
>
>
> >
> >  drivers/xen/privcmd.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index a250d11..543739e 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -594,7 +594,7 @@ static int lock_pages(
> >               if (requested > nr_pages)
> >                       return -ENOSPC;
> >
> > -             pinned = get_user_pages_fast(
> > +             pinned = pin_user_pages_fast(
> >                       (unsigned long) kbufs[i].uptr,
> >                       requested, FOLL_WRITE, pages);
> >               if (pinned < 0)
> > @@ -614,10 +614,7 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
> >       if (!pages)
> >               return;
> >
> > -     for (i = 0; i < nr_pages; i++) {
> > -             if (pages[i])
> > -                     put_page(pages[i]);
> > -     }
> > +     unpin_user_pages(pages, nr_pages);
>
>
> Why are you no longer checking for valid pages?

My understanding is, in case of lock_pages() end up returning partial
mapped pages,
we should pass no. of partial mapped pages to unlock_pages(), not nr_pages.
This will avoid checking extra check to validate the pages[i].

and if lock_pages() returns 0 in success, anyway we have all the pages[i] valid.
I will try to correct it in v2.

But I agree, there is no harm to check for pages[i] and I believe,
unpin_user_pages()
is the right place to do so.

John any thought ?
