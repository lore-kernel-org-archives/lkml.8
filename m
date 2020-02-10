Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5DC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD7920842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+lzJ4Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBJNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:38:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43579 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBJNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:38:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so9164462oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 05:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n4VkksM4yOFdYfQnXs70fdXcOaBAA6a7KVukuRv0B/0=;
        b=k+lzJ4LdVh/1CbBpkXb4FWY8y+vVjD7ltGBGbPuFD0uyLFRLCgr/86TNCv3ZuIO5lc
         iZAhHWmfya+7eTMixVFHqktD33bGbumFIeGqGriRe8MJdzMkrzO3wrfYvo0c6novP3w1
         MDf//CvojUaFeIuzJCuWfCOD+OBT9yUirBAEc35ypZ7soOcXMip1sh0I3w1TuTeaVqYw
         tkqXQSdt6ZAvkY1IfvcwxsqLi0bGerDdyF+WjzpcxhLeGSj1oH6P6MYtVV/4kWMWXfj6
         sxccmVhTQ0Zwi9obne74Az6QxE9/MC53fssklkMXyCJhYmKzLFbvxsROdwd2VjNYWjkj
         MGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n4VkksM4yOFdYfQnXs70fdXcOaBAA6a7KVukuRv0B/0=;
        b=Vblq41TojGwYCsQFWkrkaLPoFezKS2ywL4dZTvQFtC2RMR9AbtsygPy88uxFxmBOaC
         /G/vjEakSIWpz/dIv5k0mu6JV9NMWppClW9tDvuzt+wjLhbXD/ZQVa/LX6qsK0mW0SGU
         U/svI/SXEpVEyueyAgWcvXsW8B+6RejrFAfpe9B50C6XSWu/xoE4Av7zvP8A4KzzvSxN
         +0FHI4zx34cV+kvRjBLEZ/jPFXX9ZTi/7NxBOWq2RWewd6sJr1qxXLKIhUJQkijE+xjc
         nd7B7u+RuIl8Os/j1n/cwApniJGOHO2t3AaSNiKDfTdsnz5evoBaeoHLXzknYScN4gXh
         gxZA==
X-Gm-Message-State: APjAAAUXgfKJNK561PNGgv0vARZrWcdgQEs/tlYjFEDkyQeW/tG+47LO
        WaboJd48G7ncIjW6DeerZiLBBmDK+IDBn0mCZrnEvQ==
X-Google-Smtp-Source: APXvYqwYyimiAXF9GFpmoWjkeLpxZAVT1sw988pbvyOIWijKr+khjLBniVC+M11IYa0DLswdQMWJYiVEA+7edQrYJVU=
X-Received: by 2002:aca:2112:: with SMTP id 18mr788817oiz.155.1581341918727;
 Mon, 10 Feb 2020 05:38:38 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
 <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw> <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
 <1581341769.7365.25.camel@lca.pw>
In-Reply-To: <1581341769.7365.25.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 14:38:27 +0100
Message-ID: <CANpmjNPdwuMpJvwdVj6zm6G5rXzjvkF+GZqqxvpC8Ui4iN8New@mail.gmail.com>
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

On Mon, 10 Feb 2020 at 14:36, Qian Cai <cai@lca.pw> wrote:
>
> On Mon, 2020-02-10 at 13:58 +0100, Marco Elver wrote:
> > On Mon, 10 Feb 2020 at 13:16, Qian Cai <cai@lca.pw> wrote:
> > >
> > >
> > >
> > > > On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wrote:
> > > >
> > > > Here is an alternative:
> > > >
> > > > Let's say KCSAN gives you this:
> > > >   /* ... Assert that the bits set in mask are not written
> > > > concurrently; they may still be read concurrently.
> > > >     The access that immediately follows is assumed to access those
> > > > bits and safe w.r.t. data races.
> > > >
> > > >     For example, this may be used when certain bits of @flags may
> > > > only be modified when holding the appropriate lock,
> > > >     but other bits may still be modified locklessly.
> > > >   ...
> > > >  */
> > > >   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> > > >
> > > > Then we can write page_zonenum as follows:
> > > >
> > > > static inline enum zone_type page_zonenum(const struct page *page)
> > > > {
> > > > +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSH=
IFT);
> > > >        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > > > }
> > > >
> > > > This will accomplish the following:
> > > > 1. The current code is not touched, and we do not have to verify th=
at
> > > > the change is correct without KCSAN.
> > > > 2. We're not introducing a bunch of special macros to read bits in =
various ways.
> > > > 3. KCSAN will assume that the access is safe, and no data race repo=
rt
> > > > is generated.
> > > > 4. If somebody modifies ZONES bits concurrently, KCSAN will tell yo=
u
> > > > about the race.
> > > > 5. We're documenting the code.
> > > >
> > > > Anything I missed?
> > >
> > > I don=E2=80=99t know. Having to write the same line twice does not fe=
el me any better than data_race() with commenting occasionally.
> >
> > Point 4 above: While data_race() will ignore cause KCSAN to not report
> > the data race, now you might be missing a real bug: if somebody
> > concurrently modifies the bits accessed, you want to know about it!
> > Either way, it's up to you to add the ASSERT_EXCLUSIVE_BITS, but just
> > remember that if you decide to silence it with data_race(), you need
> > to be sure there are no concurrent writers to those bits.
>
> Right, in this case, there is no concurrent writers to those bits, so I'l=
l add a
> comment should be sufficient. However, I'll keep ASSERT_EXCLUSIVE_BITS() =
in mind
> for other places.

Right now there are no concurrent writers to those bits. But somebody
might introduce a bug that will write them, even though they shouldn't
have. With ASSERT_EXCLUSIVE_BITS() you can catch that. Once I have the
patches for this out, I would consider adding it here for this reason.

> >
> > There is no way to automatically infer all over the kernel which bits
> > we care about, and the most reliable is to be explicit about it. I
> > don't see a problem with it per se.
> >
> > Thanks,
> > -- Marco
