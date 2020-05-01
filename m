Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC94C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F6621924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGlzSNtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEAVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:38:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72367C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:38:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so3811617lja.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmcdipzgY1Nm1KXrImEVFcXHk9g8rdDKWZCNtxFitno=;
        b=FGlzSNtxTM+Pacz+O/M9t0vRdXoDnTsFtPa7jbcIqF34jEjXmAxn+k/Sd0TI8nkvas
         0eTH8/sQlFcmK9KtbHE6QbEslIvvYRvcP417Js4Gt9zc1QBLalx6s1nU57/nai9FIxZZ
         Fd2tGphBTKPMiRmuErFAlderCbJaRiqEuXzLVoX7K00NXnznk4eSMnISP3agPakhuA8R
         VuprJMSY31APUe1S+hOlQZQGW1SOlv7apQ6SB93/JtZGr7S8HPRcoQy/p6dcZ8k34EZK
         9YMjTe8f9VPCJF7wQ0a1KTnpbgBRRBI1pxTSRIUzfEKU9XTkI1j//j3L/uIBeUb+x6h0
         DY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmcdipzgY1Nm1KXrImEVFcXHk9g8rdDKWZCNtxFitno=;
        b=J0/SVrO4O4K8tLYRAxjbZDjGkv+TsWC2ZcI79OB+Pg4XbraxbMrONt/vCkVnVAtKe9
         UpnnPSeBcr+e5/1bN7rObFLwBf65U6Xfkcg7y2tuI+bl69qmLVDE2WNTgVqbexPXI3fB
         nw3q0fHLLD+sPmggW30syCfu+GLYFBNQBcoStl5oVOKXErmpFkfMSe8xZgSOKkBpGnsl
         oVMD4DKiIehXuuNoieYQ5hau2EdH0OUieT3Fk6hk63nlexHSkXAM8Rlm2QRPy7yh0yLm
         MGzstD6AjmxZd+kKD6J00E3d/TUBeX2Vk9tl5WE/PyEL9cfRZwajy0LT9aTxnfpgxOM5
         /YJw==
X-Gm-Message-State: AGi0Pub5ucgnS0FMH4/7P10YMLmOttmR+3+torFnr+yNCrhDk8+VFLIc
        QpmZZH4f9of/8dIqe99iyoQZlN58u0R8+EukoFE=
X-Google-Smtp-Source: APiQypJT8Fb0if/6Vo7PhY7i0k2oxLsCFkb/XsjaemmIsbxtxAN552H3CqOFxI+Y8FQ3twLOF7lrwV5j2DuHUbGSr3k=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr3504664ljc.146.1588369126880;
 Fri, 01 May 2020 14:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com> <c25cf212-8684-a107-bc9c-c7067dea7447@nvidia.com>
In-Reply-To: <c25cf212-8684-a107-bc9c-c7067dea7447@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 2 May 2020 03:16:40 +0530
Message-ID: <CAFqt6zaZcTeh+-ZQCanpu-tQL7zD7-iQ0DFvHLJ6Bdwkr9ZXrg@mail.gmail.com>
Subject: Re: [PATCH] mm/gup.c: Handle error at earliest for incorrect nr_pages value
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 3:03 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-04-30 13:11, Souptick Joarder wrote:
> > As per documentation, pin_user_pages_fast() & get_user_pages_fast()
> > will return 0, if nr_pages <= 0. But this can be figure out only after
> > going inside the internal_get_user_pages_fast().
> >
> > This can be handled early. Adding a check for the same.
>
>
> Please, no. For precisely the reasons that Andrew gave: you are
> attempting to optimize for a case that doesn't matter other than
> for error handling, and which is already handled adequately. And
> as he also pointed out, it very slightly UN-optimizes the path that
> we *do* care about. So why are you still advocating for this?
>
> If you want to change the gup/pup API so that asking for zero pages
> means -EINVAL, then fine, go for it. That's a large thing, and a
> tree-wide audit, but if you feel it's worth pursuing then it's at
> least consistent.
>
> But this patch here needs to be abandoned.

Sure, will drop this patch.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >   mm/gup.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 50681f0..a13aaa6 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2817,6 +2817,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >        */
> >       if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> >               return -EINVAL;
> > +     if (nr_pages <= 0)
> > +             return 0;
> >
> >       /*
> >        * The caller may or may not have explicitly set FOLL_GET; either way is
> > @@ -2854,6 +2856,8 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
> >       /* FOLL_GET and FOLL_PIN are mutually exclusive. */
> >       if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >               return -EINVAL;
> > +     if (nr_pages <= 0)
> > +             return 0;
> >
> >       gup_flags |= FOLL_PIN;
> >       return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
> >
>
