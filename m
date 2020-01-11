Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A8DC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A820842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3aNzHKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgAKKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:55:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32778 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgAKKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:55:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1878329plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 02:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZQVnsltuFIGEGv4VB2WGJgemVBmJS3Bgy+FfBsRHoc=;
        b=H3aNzHKfQEF2sU1RYhMU7P81CasygNH6mi0tGAiasCQkl7VqNPQ1sm8gx96zqYUsWM
         3wCmeDoqd8ASepSb4y/RSiybh0RMeT4SxE2fq8RCYr4l/+vs5x7nk4/yWiQDXIlG+dM5
         tvz1Zmo8t7sVV+dn44N1haiZvV2EgFhn6lM7hUpzXabkjxLzTf86Y3CN99a4MlRs3ntk
         vZpGujES41egbQt/Nk69Lah0PQxz4v9hAHB5N0FG4jsWIbxuJtIrriQZkCw7akuy0FXA
         l9xSwy2m4iaB3ZZ+ivzBFcVsHub54gwEXq4g4aAFm9NWCn+ZgD0xi6jEJaUJLpxyt511
         uuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZQVnsltuFIGEGv4VB2WGJgemVBmJS3Bgy+FfBsRHoc=;
        b=W8FR8x7Y1V51hFXvffl6pK7VHxU52hWiVtkbOdsEZdKHhb8ADsoj286WA0gJG03+0U
         +XNXRN5LFXw0twg24zJlWkljpnfsLUGs0AGqL38XyMDST2ITv2GhdkZxXVFDfAEQJvvR
         vx4ENu4sO/6yxNW5czCgr1aQxm0qFGaRXEI1oUw+ulwgx4/PW901Uko412QL89kX7x//
         rnsVezY03sEFxKFRIkuVgH3bM9rDz6ZRNAifPecIRvMIuAAtQpuP0dVEmVsOn9ObLwrX
         PYh4MIsArYsYyNKzF2RrlGWmRGWTcH2nXPF+p4G0DO/mVQ9jeDLDAgksqR7mPil6mbCR
         TKTw==
X-Gm-Message-State: APjAAAVQVlfSRaWX5Vr8ZprIivp7YGCpLHABv+6yB/AGcnU0Iy0o++Yy
        uzrZZ3XDzVACDtt6m+IrCAuxdifM/SZKulNoMYk=
X-Google-Smtp-Source: APXvYqyDeFO86zjH+/FDQkvvT0Kw72VrwbXPh6sK7CjvIiMF3sCPoZWdRX9mtaJxYPWqHzOwMFnw9CieRLuhwuwg4r0=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr11179878pjb.30.1578740115415;
 Sat, 11 Jan 2020 02:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20200110225602.91663-1-samitolvanen@google.com>
 <202001110830.00B8USV0024843@sdf.org> <CAHp75VcWryeiN_bwJjFk=RO1k+H5q7h6_3oGArf1XzF-6dNxKg@mail.gmail.com>
In-Reply-To: <CAHp75VcWryeiN_bwJjFk=RO1k+H5q7h6_3oGArf1XzF-6dNxKg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jan 2020 12:55:03 +0200
Message-ID: <CAHp75Vdpv57_3BixbJaxgWRDLNrB+j357TykSgr0jd5KWERAyg@mail.gmail.com>
Subject: Re: [PATCH] lib/list_sort: fix function type mismatches
To:     George Spelvin <lkml@sdf.org>
Cc:     samitolvanen@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrey Abramov <st5pub@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jan 11, 2020 at 10:31 AM George Spelvin <lkml@sdf.org> wrote:
> >
> > >  typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> > > -             struct list_head const *, struct list_head const *);
> > > +             struct list_head *, struct list_head *);
> >
> > I'd prefer to leave the const there for documentation.
>
> Not only. It's useful to show that we are not going to change those parameters.
>
> > Does anyone object to fixing it in the other direction by *adding*
> > const to all the call sites?
>
> Agree.
> Actually we have cmp_r_funct_t which might be used here (I didn't
> check for the possibility, though).

For the record, I have just checked users of list_sort() in regard to
constify of priv parameter and only ACPI HMAT is using it as not
const. UBIFS and XFS do not change the data (if I didn't miss
anything).

But the amount of changes there perhaps not worth of doing. So, maybe
new type like
cmp_w_func_t where priv is not const would be good enough for merge().


-- 
With Best Regards,
Andy Shevchenko
