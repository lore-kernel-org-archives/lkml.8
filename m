Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D6BC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8477A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="StiymXhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgBJNz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:55:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40590 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgBJNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:55:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so5135155qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvc+HCAjGfX6aDuiEDkX1stZqSNz9kTlsYc/8zRaw1M=;
        b=StiymXhXU8O8XtYolLxmQCpaPboJPGmag5L97rZ1HtVEAypI2ojif8OJMfrxHNxGgP
         f9TeY01de6tYRd/pz9atN9bfseymq13x1E+bI6DyQJ8gGLeDqjDnoSbHF5oUvs8IKmWf
         uIp8m0FiL6gKKn/bQ62WMwVcur18Vk8JTz4sSl91hVOjU7uKqukzQAp2iRVZ3t6rT0Sl
         I+b5cPeX2vr0DNr6ik7kYoZsPIbpl2RPSho8osX5lOzKvqSL3KensYUwzX/C24EYOYRh
         VphGzULJ6PyiOElvDG8i+swpGjQcYJ62V0iY96ZpW34GL6gmc65lxFhaScgdb7nrWt2/
         wmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvc+HCAjGfX6aDuiEDkX1stZqSNz9kTlsYc/8zRaw1M=;
        b=cwWS+4EczXERCGngzemmEKW3VELZw4fMMOhiJ+qJpq4S+qmd7CoiIomPcbGKsZzuRF
         Y97LsFFdz5p3KFGaAH3088lZzj6uFjWacpnunGlgvC2bpjpw9pZ1gpxFzGddgIlhXJaX
         8wSmI7wMAqv/C+9gpVjt6dzXA1Xyne34sH5kRk0kAMA+tLvLJtQ84aFML1SwjT5odZHC
         nzMcxpgzlFapvKwMuPKL3EWKbRw1Qx2Ln3qwcOHpQ7lfZPuZduFo6EIlU6y6RugQY25N
         74dMZ/RYp1TfBNDMlOAqx4lY6JoiQXm64v9trjnY+Fp8K5hSuVMNB877esVYfZ0uLNeG
         eCTA==
X-Gm-Message-State: APjAAAUn6zxzNtdUU1uOPnxu/K3SDsL+xUnsoOgB2iGA7ZfITrVt5sJ5
        NmvpNoAOOdICWqt3mgDSZY5zWw==
X-Google-Smtp-Source: APXvYqxHJugKywFkG5dTaHKtVSfIc+JAdwSQurvj8aM2E0xJYwwDdipVzimIaYrkcQ+CX1qgGcwGVQ==
X-Received: by 2002:aed:3eee:: with SMTP id o43mr10143047qtf.33.1581342956768;
        Mon, 10 Feb 2020 05:55:56 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a24sm157600qkl.82.2020.02.10.05.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 05:55:56 -0800 (PST)
Message-ID: <1581342954.7365.27.camel@lca.pw>
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Mon, 10 Feb 2020 08:55:54 -0500
In-Reply-To: <CANpmjNPdwuMpJvwdVj6zm6G5rXzjvkF+GZqqxvpC8Ui4iN8New@mail.gmail.com>
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
         <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw>
         <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
         <1581341769.7365.25.camel@lca.pw>
         <CANpmjNPdwuMpJvwdVj6zm6G5rXzjvkF+GZqqxvpC8Ui4iN8New@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 14:38 +0100, Marco Elver wrote:
> On Mon, 10 Feb 2020 at 14:36, Qian Cai <cai@lca.pw> wrote:
> > 
> > On Mon, 2020-02-10 at 13:58 +0100, Marco Elver wrote:
> > > On Mon, 10 Feb 2020 at 13:16, Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > 
> > > > 
> > > > > On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wrote:
> > > > > 
> > > > > Here is an alternative:
> > > > > 
> > > > > Let's say KCSAN gives you this:
> > > > >   /* ... Assert that the bits set in mask are not written
> > > > > concurrently; they may still be read concurrently.
> > > > >     The access that immediately follows is assumed to access those
> > > > > bits and safe w.r.t. data races.
> > > > > 
> > > > >     For example, this may be used when certain bits of @flags may
> > > > > only be modified when holding the appropriate lock,
> > > > >     but other bits may still be modified locklessly.
> > > > >   ...
> > > > >  */
> > > > >   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> > > > > 
> > > > > Then we can write page_zonenum as follows:
> > > > > 
> > > > > static inline enum zone_type page_zonenum(const struct page *page)
> > > > > {
> > > > > +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> > > > >        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > > > > }
> > > > > 
> > > > > This will accomplish the following:
> > > > > 1. The current code is not touched, and we do not have to verify that
> > > > > the change is correct without KCSAN.
> > > > > 2. We're not introducing a bunch of special macros to read bits in various ways.
> > > > > 3. KCSAN will assume that the access is safe, and no data race report
> > > > > is generated.
> > > > > 4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
> > > > > about the race.
> > > > > 5. We're documenting the code.
> > > > > 
> > > > > Anything I missed?
> > > > 
> > > > I don’t know. Having to write the same line twice does not feel me any better than data_race() with commenting occasionally.
> > > 
> > > Point 4 above: While data_race() will ignore cause KCSAN to not report
> > > the data race, now you might be missing a real bug: if somebody
> > > concurrently modifies the bits accessed, you want to know about it!
> > > Either way, it's up to you to add the ASSERT_EXCLUSIVE_BITS, but just
> > > remember that if you decide to silence it with data_race(), you need
> > > to be sure there are no concurrent writers to those bits.
> > 
> > Right, in this case, there is no concurrent writers to those bits, so I'll add a
> > comment should be sufficient. However, I'll keep ASSERT_EXCLUSIVE_BITS() in mind
> > for other places.
> 
> Right now there are no concurrent writers to those bits. But somebody
> might introduce a bug that will write them, even though they shouldn't
> have. With ASSERT_EXCLUSIVE_BITS() you can catch that. Once I have the
> patches for this out, I would consider adding it here for this reason.

Surely, we could add many of those to catch theoretical issues. I can think of
more like ASSERT_HARMLESS_COUNTERS() because the worry about one day someone
might change the code to use counters from printing out information to making
important MM heuristic decisions. Then, we might end up with those too many
macros situation again. The list goes on, ASSERT_COMPARE_ZERO_NOLOOP(),
ASSERT_SINGLE_BIT() etc.

On the other hand, maybe to take a more pragmatic approach that if there are
strong evidences that developers could easily make mistakes in a certain place,
then we could add a new macro, so the next time Joe developer wants to a new
macro, he/she has to provide the same strong justifications?

> 
> > > 
> > > There is no way to automatically infer all over the kernel which bits
> > > we care about, and the most reliable is to be explicit about it. I
> > > don't see a problem with it per se.
> > > 
> > > Thanks,
> > > -- Marco
