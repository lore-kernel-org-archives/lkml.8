Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D89C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C55E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwHaZKo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBLGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:23:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45543 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBLGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:23:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so770558qte.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCIGTDCK3CFLiIsiFAwO9TOgJOimjyz3BYLMXapp1co=;
        b=qwHaZKo3KsqKr8AlD7RU0Lj3K3IPFPgtOiJTCzqROhD3TL0MYBfbu5JO95ACseI2Z3
         SbQRysvUUuqdnFfo7RAvxd5OpiCrU7ezqjcq0TsOs2kGpdM0azBqCYoAKnbHUlk+l1dK
         Zztydhox5XLGXe1NSAS6X90916opnB7psuUEz3IcHy6+Zwp/A1lO8jKH+h2goUAeUyyd
         mF8WJ1b+II1J7STjDKQ1K90mhkRivAMI/y3geqANhrCwd2nt1o1VAzFeJlfuPRwPQnpv
         n6WnTu0fTh9a9V3ckvGqg/uw8ZNBkJHDX3mM/FiCivYM/GQ3PdGog9h2GpSItggcT5xS
         cadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCIGTDCK3CFLiIsiFAwO9TOgJOimjyz3BYLMXapp1co=;
        b=Qp+ESooRvPnhqkg4VdjnMepP/5fUp+jt2mDQSxeFLgwn5p4mHwa1TUeA+iehlX/3CN
         yY4ATg5rxsI1Eh5lDSZuKip2uVpAnKyuexJ2Tz63A1uuj3i2HPPpd4TuQbuxyLM9+DLf
         h1JX3gQOItZgqCw2vdMy8bX36y4RES7VCRB1XFdIY1IEKAc7Uv+5tetJcOJrNus8cNOA
         yTpBEE2Hn0og8pwsvIEIY7ilN+7FT1TtHkdEtgfCkaCLKYbubHPMNx1P/pg90wm21RBr
         VlEUryVroDafO038PWe3j9ZTaIE77o4ZqkeDQ0XnSLb/nD6ORzg4INqTJDkxIq+77s72
         yy0Q==
X-Gm-Message-State: APjAAAVtQ7FdC+y5m53z2Ushm0yjqQ5ie9byfwXJeFRYD6sNIW5k6Um1
        i/H/wl5w4WWI1QbHvh59RBVf7IvvK73TWg3Fwd6Icw==
X-Google-Smtp-Source: APXvYqzFx6k10gUgdOT63zuzi1P3uHNFriTd2XVMEv/caoOhPibQxYxk5pUIa+ygHIDuwfr2kaKBHXeZBfRntB2PXkw=
X-Received: by 2002:ac8:7159:: with SMTP id h25mr5774429qtp.380.1581488608196;
 Tue, 11 Feb 2020 22:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com> <CAKFsvUKhwAOV9O+LWBr=-zLEJCFJvKOH-ePsXMMVJzHotqd3Ug@mail.gmail.com>
In-Reply-To: <CAKFsvUKhwAOV9O+LWBr=-zLEJCFJvKOH-ePsXMMVJzHotqd3Ug@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Feb 2020 07:23:16 +0100
Message-ID: <CACT4Y+aRq9j=3GODWBcnDnW=Pgp4e=N2++FTYEuq-00OmfXpbw@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:48 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> On Thu, Jan 16, 2020 at 12:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > > +config KASAN_SHADOW_OFFSET
> > > +       hex
> > > +       depends on KASAN
> > > +       default 0x100000000000
> > > +       help
> > > +         This is the offset at which the ~2.25TB of shadow memory is
> > > +         initialized and used by KASAN for memory debugging. The default
> > > +         is 0x100000000000.
> >
> > What are restrictions on this value?
> The only restriction is that there is enough space there to map all of
> the KASAN shadow memory without conflicting with anything else.
>
> > In user-space we use 0x7fff8000 as a base (just below 2GB) and it's
> > extremely profitable wrt codegen since it fits into immediate of most
> > instructions.
> > We can load and add the base with a short instruction:
> >     2d8c: 48 81 c2 00 80 ff 7f    add    $0x7fff8000,%rdx
> > Or even add base, load shadow and check it with a single 7-byte instruction:
> >      1e4: 80 b8 00 80 ff 7f 00    cmpb   $0x0,0x7fff8000(%rax)
> >
> I just tested with 0x7fff8000 as the KASAN_SHADOW_OFFSET and it worked
> so I can make that the default if it will be more efficient.

I think it's the right thing to do if it works.
