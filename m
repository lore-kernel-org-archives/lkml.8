Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52B4207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIMTVbyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgEaHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgEaHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:05:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5DC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:05:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so2095465lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZQNtJ99m5kQqODdsifS/JxQkSLWec/LxM/meZdb8vU=;
        b=JIMTVbyNNdao524HnT4WD+PzP6sTUKiUgb+k68kVVGkvCNL2aEOT/wMHr345wiqdI9
         +RPbLKKAhxj/2c5x2PVrBgdvu4up6NHSi+/ZV3LSngU/yS0j6O1I7K2WJwVs1+kuQGWV
         z0OKQcEMPAFIIbtXqnQwx/xUMJXXHPOAYuzl2QlmWrGs045nACeIalj6/zMBJlSfTupn
         UATzzqXDaB7MmLpPbobD/dNrNtLNvrbO7O9KX5NjCOWZtiUZ5TZ96qXGUmyOVVl/SyWm
         5EIpMI5qTDnHYu3/gBO0CO8cm1HS+CvVb5yJ6jj++1jQsd/ulNnSDfbNiW86EIPqQ0cU
         Wp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZQNtJ99m5kQqODdsifS/JxQkSLWec/LxM/meZdb8vU=;
        b=VvZmwMlN5zZSeJTEdam7AweFQRmGJTLXTNwrVVSNSeAJyG/msr81imR5d34xldIFur
         5BkPEPes7UYON1TrrWOl8frIjUkF9/1Cwd9AQeTjqolVBD/DdHOGHo7/G+I/Fsx6wCOz
         l7r6yQzayq9TEsCg+/EYcP+C4174X8cdDOgAbWwStaMwsj6Rsx5jFgRNud2M+prvwVxt
         lW//XEo0us2+FUw4wreXhoB+0V8GpUsITSiaCzi3M0ZCf7FP6FZcyrAgXU2EtOKHnsh5
         BcJ+V/Xf1MetxH2RJxV6dElc8w6Z+xiPhBs7p6xWA7LS/up8Y+i5YMU1nnNNCUabgnrw
         uR1w==
X-Gm-Message-State: AOAM533WUQm5ASyG66rQhfD+qsvfWw19AgeLGjiMAuNG955gGJfLe38Y
        GVj3bbg+n1OVpT9zhqf702KbSbziqW8L/OcREzq3oJ4joxk=
X-Google-Smtp-Source: ABdhPJyairki+0H3QhXGPYH+WHxOAMixdpy5xpwbxZA83QboKU7UfoIjl3v8IkYjJaK4xER6VbFVc9SkU9Y7/3uhwSI=
X-Received: by 2002:a19:2250:: with SMTP id i77mr8582463lfi.133.1590908714696;
 Sun, 31 May 2020 00:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200527223243.884385-1-jhubbard@nvidia.com> <20200527223243.884385-2-jhubbard@nvidia.com>
 <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
In-Reply-To: <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 31 May 2020 12:43:23 +0530
Message-ID: <CAFqt6zaz21GQZYSGZ5Md0hCrPv8UFQ7gQMiV_oBzX0zSTZ16-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 4:02 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > Introduce pin_user_pages_locked(), which is nearly identical to
> > get_user_pages_locked() except that it sets FOLL_PIN and rejects
> > FOLL_GET.

Forget to ask, is it fine to add this new pin_user_pages_locked() in
Documentation/core-api/pin_user_pages.rst ?

> >
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  include/linux/mm.h |  2 ++
> >  mm/gup.c           | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 98be7289d7e9..d16951087c93 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1700,6 +1700,8 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
> >                     struct vm_area_struct **vmas);
> >  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> >                     unsigned int gup_flags, struct page **pages, int *locked);
> > +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> > +                   unsigned int gup_flags, struct page **pages, int *locked);
> >  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> >                     struct page **pages, unsigned int gup_flags);
> >  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 2f0a0b497c23..17418a949067 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2992,3 +2992,33 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> >         return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
> >  }
> >  EXPORT_SYMBOL(pin_user_pages_unlocked);
> > +
> > +/*
> > + * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
> > + * Behavior is the same, except that this one sets FOLL_PIN and rejects
> > + * FOLL_GET.
> > + */
> > +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> > +                          unsigned int gup_flags, struct page **pages,
> > +                          int *locked)
> > +{
> > +       /*
> > +        * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> > +        * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> > +        * vmas.  As there are no users of this flag in this call we simply
> > +        * disallow this option for now.
> > +        */
> > +       if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> > +               return -EINVAL;
> > +
> > +       /* FOLL_GET and FOLL_PIN are mutually exclusive. */
> > +       if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> > +               return -EINVAL;
> > +
> > +       gup_flags |= FOLL_PIN;
>
> Right now get_user_pages_locked() doesn't have similar check for FOLL_PIN
> and also not setting FOLL_GET internally irrespective of gup_flags
> passed by user.
> Do we need to add the same in get_user_pages_locked() ?
>
> > +       return __get_user_pages_locked(current, current->mm, start, nr_pages,
> > +                                      pages, NULL, locked,
> > +                                      gup_flags | FOLL_TOUCH);
> > +}
> > +EXPORT_SYMBOL(pin_user_pages_locked);
> > +
> > --
> > 2.26.2
> >
> >
