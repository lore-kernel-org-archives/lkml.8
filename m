Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA256C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BDB20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8AaOmsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBJOMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:12:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46302 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBJOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:12:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so9244109oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ST/uAoLQf5dHHFUuf0J7KbsthQeZglVfBV4jHCEUrUk=;
        b=s8AaOmsFVM0GA9jC2Tczro3BYFoLxXIOBSxxUWDjuB6jyDEsErr7lKQfFa19KplyW9
         QEiDYYoqPk4EdpaNkEEecW92J4qiKm7k+1rY1VQXjl8wNysewW/T9aPRyROh9GGCaCu1
         8/41DUE+1mSL+E8KVwuOiJczOt7BBqeJj+HW5I1pCq9xgbSGBhlSk+b74kiLGS2qnjAK
         kKliFyUZuX2nWSRNKfw7euo7AhfJOQT7Mxs9ZdtXWPcjoUHrxZcdlXTCLXh+BlrWGZGw
         4mZTCnVnVU/ogkpvCKIj5fEuG3caJ5XIGg1QkfydB+4hakKv7Bo6bzgDNPuTEVWShOnk
         rXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ST/uAoLQf5dHHFUuf0J7KbsthQeZglVfBV4jHCEUrUk=;
        b=P/ndUxBtSm8yyMBdHwC+Acy/itl5zls35wxKh2Lo7kjv5lxoHMfg9rsrbBaMkDwYph
         frmtcqz7N6wGjHyfQvo94XqRYH7LnP7BSEuddPE7PixPPL/Z/eftIwRh/xtFcv08nFdJ
         ynga//Nu22sq5PihLYVJ5hr65epw6CB6e/9+17jXmnfxxv15EKLzCO9k6JTncx4HG1Fl
         2gqyzHgYcZNp7MmYJusLuLrbLRju9rhUOA7W7xvMQ/RYfIlyeCXoCTo9qM9sCV+SduWE
         SzH1XWAbpvQPJhKrFXZEfaCNWv6yTqXxtHHAg9hiqmMtF0ntQkZ2HJx32pHM+NxRVQzS
         ZAzA==
X-Gm-Message-State: APjAAAUyqGHfPSIbtBAih40Fj4WT0cx0w9CtASRirbs5/By+gwpCM4EJ
        tT7iRp9sN1UHfp3YBfm4P5XGSR3ccoSKlsxOcww2ag==
X-Google-Smtp-Source: APXvYqyilkeieETLUtlWsaZxWWNnXMGbFUWwwT1ioaFhLLgSZcwf1zmxIKLG+fZLDbn3qccY1YLfmGwCOf9CuVX0P4A=
X-Received: by 2002:aca:2112:: with SMTP id 18mr884734oiz.155.1581343963985;
 Mon, 10 Feb 2020 06:12:43 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
 <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw> <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
 <1581341769.7365.25.camel@lca.pw> <CANpmjNPdwuMpJvwdVj6zm6G5rXzjvkF+GZqqxvpC8Ui4iN8New@mail.gmail.com>
 <1581342954.7365.27.camel@lca.pw>
In-Reply-To: <1581342954.7365.27.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 15:12:32 +0100
Message-ID: <CANpmjNN=SNr=HJMLrQUno2F1L4PmQL19JfvVjngKee77tN2q-Q@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 14:55, Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2020-02-10 at 14:38 +0100, Marco Elver wrote:
> > On Mon, 10 Feb 2020 at 14:36, Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Mon, 2020-02-10 at 13:58 +0100, Marco Elver wrote:
> > > > On Mon, 10 Feb 2020 at 13:16, Qian Cai <cai@lca.pw> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wro=
te:
> > > > > >
> > > > > > Here is an alternative:
> > > > > >
> > > > > > Let's say KCSAN gives you this:
> > > > > >   /* ... Assert that the bits set in mask are not written
> > > > > > concurrently; they may still be read concurrently.
> > > > > >     The access that immediately follows is assumed to access th=
ose
> > > > > > bits and safe w.r.t. data races.
> > > > > >
> > > > > >     For example, this may be used when certain bits of @flags m=
ay
> > > > > > only be modified when holding the appropriate lock,
> > > > > >     but other bits may still be modified locklessly.
> > > > > >   ...
> > > > > >  */
> > > > > >   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> > > > > >
> > > > > > Then we can write page_zonenum as follows:
> > > > > >
> > > > > > static inline enum zone_type page_zonenum(const struct page *pa=
ge)
> > > > > > {
> > > > > > +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_=
PGSHIFT);
> > > > > >        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > > > > > }
> > > > > >
> > > > > > This will accomplish the following:
> > > > > > 1. The current code is not touched, and we do not have to verif=
y that
> > > > > > the change is correct without KCSAN.
> > > > > > 2. We're not introducing a bunch of special macros to read bits=
 in various ways.
> > > > > > 3. KCSAN will assume that the access is safe, and no data race =
report
> > > > > > is generated.
> > > > > > 4. If somebody modifies ZONES bits concurrently, KCSAN will tel=
l you
> > > > > > about the race.
> > > > > > 5. We're documenting the code.
> > > > > >
> > > > > > Anything I missed?
> > > > >
> > > > > I don=E2=80=99t know. Having to write the same line twice does no=
t feel me any better than data_race() with commenting occasionally.
> > > >
> > > > Point 4 above: While data_race() will ignore cause KCSAN to not rep=
ort
> > > > the data race, now you might be missing a real bug: if somebody
> > > > concurrently modifies the bits accessed, you want to know about it!
> > > > Either way, it's up to you to add the ASSERT_EXCLUSIVE_BITS, but ju=
st
> > > > remember that if you decide to silence it with data_race(), you nee=
d
> > > > to be sure there are no concurrent writers to those bits.
> > >
> > > Right, in this case, there is no concurrent writers to those bits, so=
 I'll add a
> > > comment should be sufficient. However, I'll keep ASSERT_EXCLUSIVE_BIT=
S() in mind
> > > for other places.
> >
> > Right now there are no concurrent writers to those bits. But somebody
> > might introduce a bug that will write them, even though they shouldn't
> > have. With ASSERT_EXCLUSIVE_BITS() you can catch that. Once I have the
> > patches for this out, I would consider adding it here for this reason.
>
> Surely, we could add many of those to catch theoretical issues. I can thi=
nk of
> more like ASSERT_HARMLESS_COUNTERS() because the worry about one day some=
one
> might change the code to use counters from printing out information to ma=
king
> important MM heuristic decisions. Then, we might end up with those too ma=
ny
> macros situation again. The list goes on, ASSERT_COMPARE_ZERO_NOLOOP(),
> ASSERT_SINGLE_BIT() etc.

I'm sorry, but the above don't assert any quantifiable properties in the co=
de.

What we want is to be able to catch bugs that violate the *current*
properties of the code *today*. A very real property of the code
*today* is that nobody should modify zonenum without taking a lock. If
you mark the access here, there is no tool that can help you. I'm
trying to change that.

The fact that we have bits that can be modified locklessly and some
that can't is an inconvenience, but can be solved.

Makes sense?

Thanks,
-- Marco

> On the other hand, maybe to take a more pragmatic approach that if there =
are
> strong evidences that developers could easily make mistakes in a certain =
place,
> then we could add a new macro, so the next time Joe developer wants to a =
new
> macro, he/she has to provide the same strong justifications?
>
> >
> > > >
> > > > There is no way to automatically infer all over the kernel which bi=
ts
> > > > we care about, and the most reliable is to be explicit about it. I
> > > > don't see a problem with it per se.
> > > >
> > > > Thanks,
> > > > -- Marco
