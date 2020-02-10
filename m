Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC25C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C504420733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXDgZ3uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJHsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:48:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41360 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:48:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so8317934oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=az0xrMz0KQMndBSBLSGsJUmYrXwbi8MgNFXptPawpwg=;
        b=BXDgZ3uI2irXH6zT/gifdNcv7nCjk7pZhD42pVBWHKq59GZUclbYjtViuBYnbGH/NJ
         f28NfKV50uApfPpLsqxGxYYAJ/fryIFi+hZg6WmSWiWX1ED9MLCMEbr3ARoZQt2NKGYg
         4c899fSe63UshoYOZtRHpgOm/4Pyp4csme7aicmSDdKo3XDC4oFUg0npTv4FgW5fNXaJ
         AzUFBivouhh0RsNCmX9mKzOClGUdzJtkv09oVet1eS8QXtCMrDU5RhZRWRl9bDYcQNCU
         jGLIGt0xH3AAfHNskA55+D/v6kII65sNxD/PCaxoB8wWz3+N5Hf+kQxus5Nww6u8es0S
         S90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=az0xrMz0KQMndBSBLSGsJUmYrXwbi8MgNFXptPawpwg=;
        b=eM/O9QfFbQdRH8wtOwB5I/xqYGrdRKx1+A+hM4mn1sTtwRXBfzXqZHJ/fXOONhHLIM
         j9fEy7N8EyzchCLF7NuE0lDvSR8mX6KZe3TLRrDiBt8QTfbI4Vmx9qH0uNBQ2ZJVFPpM
         eMwCruM7vC58CgtfpH3ECOZFv5expdMFMZk1LZ6XnSmmP831aRCrEzvjVR7EArmGiQJi
         8NFVkVaYNKJS0uxNhIQW5CpKW+moOC6G0BVhpSTTqzbxfqygwohydpCoP3hnIT+Of640
         LvXV5KEftZ6C+CjeDlN/sSu2+6YK8G+Ya9GTsQV5yG8yjVq5HEtkW/+4catwMjzLWCIr
         YHOw==
X-Gm-Message-State: APjAAAUpMFIXIg87mHB6lOHovLWJd7Stz00386Y0wDVWP2linjNQgIh5
        LjcmGcMnYGKmoGjTueVP6/RC7UvscGz1kV+MDypZzg==
X-Google-Smtp-Source: APXvYqwMbeaXG3Sz7qHsRX47oXkIhuutnWaPEv5fN5WphFC3UU7JOYieEtNVEIf+akx1/VERerkSuhLGeFSADcWieL0=
X-Received: by 2002:aca:2112:: with SMTP id 18mr61094oiz.155.1581320901440;
 Sun, 09 Feb 2020 23:48:21 -0800 (PST)
MIME-Version: 1.0
References: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
 <8602A57D-B420-489C-89CC-23D096014C47@lca.pw> <1a179bea-fd71-7b53-34c5-895986c24931@nvidia.com>
In-Reply-To: <1a179bea-fd71-7b53-34c5-895986c24931@nvidia.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 08:48:10 +0100
Message-ID: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Qian Cai <cai@lca.pw>, Jan Kara <jack@suse.cz>,
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

On Sun, 9 Feb 2020 at 08:15, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/8/20 7:10 PM, Qian Cai wrote:
> >
> >
> >> On Feb 8, 2020, at 8:44 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> >>
> >> So it looks like we're probably stuck with having to annotate the code=
. Given
> >> that, there is a balance between how many macros, and how much comment=
ing. For
> >> example, if there is a single macro (data_race, for example), then we'=
ll need to
> >> add comments for the various cases, explaining which data_race situati=
on is
> >> happening.
> >
> > On the other hand, it is perfect fine of not commenting on each data_ra=
ce() that most of times, people could run git blame to learn more details. =
Actually, no maintainers from various of subsystems asked for commenting so=
 far.
> >
>
> Well, maybe I'm looking at this wrong. I was thinking that one should att=
empt to
> understand the code on the screen, and that's generally best--but here, m=
aybe
> "data_race" is just something that means "tool cruft", really. So mentall=
y we
> would move toward visually filtering out the data_race "key word".

One thing to note is that 'data_race()' points out concurrency, and
that somebody has deemed that the code won't break even with data
races. Somebody trying to understand or modify the code should ensure
this will still be the case. So, 'data_race()' isn't just tool cruft.
It's documentation for something that really isn't obvious from the
code alone.

Whenever we see a READ_ONCE or other marked access it is obvious to
the reader that there are concurrent accesses happening.  I'd argue
that for intentional data races, we should convey similar information,
to avoid breaking the code (of course KCSAN would tell you, but only
after the change was done). Even moreso, since changes to code
involving 'data_race()' will need re-verification that the data races
are still safe.

> I really don't like it but at least there is a significant benefit from t=
he tool
> that probably makes it worth the visual noise.
>
> Blue sky thoughts for The Far Future: It would be nice if the tools got a=
 lot
> better--maybe in the direction of C language extensions, even if only use=
d in
> this project at first.

Still thinking about this.  What we want to convey is that, while
there are races on the particular variable, nobody should be modifying
the bits here. Adding a READ_ONCE (or data_race()) would miss a
harmful race where somebody modifies these bits, so in principle I
agree. However, I think the tool can't automatically tell (even if we
had compiler extensions to give us the bits accessed) which bits we
care about, because we might have something like:

int foo_bar =3D READ_ONCE(flags) >> FOO_BAR_SHIFT;  // need the
READ_ONCE because of FOO bits
.. (foo_bar & FOO_MASK) ..  // FOO bits can be modified concurrently
.. (foo_bar & BAR_MASK) ..  // nobody should modify BAR bits
concurrently though !

What we want is to assert that nobody touches a particular set of
bits. KCSAN has recently gotten ASSERT_EXCLUSIVE_{WRITER,ACCESS}
macros which help assert properties of concurrent code, where bugs
won't manifest as data races. Along those lines, I can see the value
in doing an exclusivity check on a bitmask of a variable.

I don't know how much a READ_BITS macro could help, since it's
probably less ergonomic to have to say something like:
  READ_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT) >> ZONES_PGSHIFT.

Here is an alternative:

Let's say KCSAN gives you this:
   /* ... Assert that the bits set in mask are not written
concurrently; they may still be read concurrently.
     The access that immediately follows is assumed to access those
bits and safe w.r.t. data races.

     For example, this may be used when certain bits of @flags may
only be modified when holding the appropriate lock,
     but other bits may still be modified locklessly.
   ...
  */
   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....

Then we can write page_zonenum as follows:

static inline enum zone_type page_zonenum(const struct page *page)
 {
+       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }

This will accomplish the following:
1. The current code is not touched, and we do not have to verify that
the change is correct without KCSAN.
2. We're not introducing a bunch of special macros to read bits in various =
ways.
3. KCSAN will assume that the access is safe, and no data race report
is generated.
4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
about the race.
5. We're documenting the code.

Anything I missed?

Thanks,
-- Marco





> thanks,
> --
> John Hubbard
> NVIDIA
>
> >>
> >> That's still true, but to a lesser extent if more macros are added. In=
 this case,
> >> I suspect that READ_BITS() makes the commenting easier and shorter. So=
 I'd tentatively
> >> lead towards adding it, but what do others on the list think?
> >
> > Even read bits could be dangerous from data races and confusing at best=
, so I am not really sure what the value of introducing this new macro. Peo=
ple who like to understand it correctly still need to read the commit logs.
> >
> > This flags->zonenum is such a special case that I don=E2=80=99t really =
see it regularly for the last few weeks digging KCSAN reports, so even if i=
t is worth adding READ_BITS(), there are more equally important macros need=
 to be added together to be useful initially. For example, HARMLESS_COUNTER=
S(), READ_SINGLE_BIT(), READ_IMMUTATABLE_BITS() etc which Linus said exactl=
y wanted to avoid.
> >
