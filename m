Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D546C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9CC20708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na0yHElP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2JGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:06:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38674 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgA2JGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:06:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so13262272oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2s6x20EEWG92600QNdFV4esykKiTJqORk9G9g0F7T8=;
        b=na0yHElPJgb8ZKTDyya2uNiDGIJ+JxF+qDGOrdj03iQI5D/HgjkyxO2oMTJR+GaHZV
         FN5f3LwUUXQj4q/8MRhZwRHC6Hq+FlnzM8IQ+/LxLiUF25E3PA8AwkXB6uFCE8uLbxUW
         i6JBkHhySsci7kLCUKlI4rmsWuMIlCqAvR7WMseWdw4lJShZ2f+xcV6f88OTGviPuV9y
         GgUXrUe13YEGDZliycAuhs6uw9mTjQq/aDen6gLTAr9WJfpxHycbodZElceAoQugypuP
         DnAB4j3JpB1gUtAlf/qBWLoSVsskkEec3DkNC2mdH3vMUWKcCPwxA/TgccaxtxEw/b+t
         DYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2s6x20EEWG92600QNdFV4esykKiTJqORk9G9g0F7T8=;
        b=tbbEr/5KprKMoEQIu94vzvQ4Ot2TwQldkWhZVh/MtDkB4uLA0M7kqXAOeaOIqM0hiG
         MGgynpkVeylb+5XLBXbJ/ttOJ7TuXsLrv9SQ6FwjeXeuFhGa+feOVjpgVlBcwV4mGXki
         I7wkisqfHW07auRIxVVlH0ZFwPL9/3eaOWg/tWnAo9331nd/SWI1/R8W8aoILgFQGK7d
         JO8QChVvxLxM5YHkWM3rEFT/ysf5eLUrlHHdCR8S7C569FqUbzFwlls49/ShReQdMCsP
         JVbdpSj2RkhGsjW8pcNh8I1Xi2X/pMPrQf4DTpBZtOik+mbi50bAszRPBw8uEo/ubx3+
         Wz6g==
X-Gm-Message-State: APjAAAX4COkxcOaOtLdegRmwFqwMWJs/+mt7iCqlxSaoWl8i9yL+dDlZ
        SdTi29kmruf2iVfvYDm59Y8s8LDzajCCFokQoDTKhg==
X-Google-Smtp-Source: APXvYqwpzNHXG7UZJVurZ6ZnBKo2tCEq58PM1Lk3Ya7fuzeuWmvDzy1wRuCPRWutEkSn9Cjd0ohlbPdxDhaTqokQ5O8=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr5832340oig.172.1580288811877;
 Wed, 29 Jan 2020 01:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20200129042019.3632-1-cai@lca.pw> <20200129085124.GF24244@dhcp22.suse.cz>
In-Reply-To: <20200129085124.GF24244@dhcp22.suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Jan 2020 10:06:40 +0100
Message-ID: <CANpmjNNaCtL+vqpPKug9_DoFUue=PdoTyQFXLOx5H_BYCyDMzA@mail.gmail.com>
Subject: Re: [PATCH -next] mm/page_counter: mark intentional data races
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 09:51, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-01-20 23:20:19, Qian Cai wrote:
> > The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
> > had memcg->memsw->failcnt and ->watermark could be accessed concurrently
> > as reported by KCSAN,
> >
> >  Reported by Kernel Concurrency Sanitizer on:
> >  BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge
> >
> >  read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
> >   page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
> >   try_charge+0x131/0xd50

Why are the line numbers for the remaining symbols missing?  Doesn't
scripts/decode_stacktrace.sh give you all line numbers?

[ As an aside: if you want to use what syzbot uses to put line numbers
on symbols, which is a bit faster:
https://github.com/google/syzkaller/tree/master/tools/syz-symbolize
https://github.com/google/syzkaller/blob/master/docs/linux/setup.md
then 'go build tools/syz-symbolize'. ]

> >   __memcg_kmem_charge_memcg+0x58/0x140
> >   __memcg_kmem_charge+0xcc/0x280
> >   __alloc_pages_nodemask+0x1e1/0x450
> >   alloc_pages_current+0xa6/0x120
> >   pte_alloc_one+0x17/0xd0
> >   __pte_alloc+0x3a/0x1f0
> >   copy_p4d_range+0xc36/0x1990
> >   copy_page_range+0x21d/0x360
> >   dup_mmap+0x5f5/0x7a0
> >   dup_mm+0xa2/0x240
> >   copy_process+0x1b3f/0x3460
> >   _do_fork+0xaa/0xa20
> >   __x64_sys_clone+0x13b/0x170
> >   do_syscall_64+0x91/0xb47
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> >  write to 0xffff8fb18c4cd190 of 8 bytes by task 1153 on cpu 120:
> >   page_counter_try_charge+0x5b/0x150 mm/page_counter.c:139
> >   try_charge+0x131/0xd50
> >   mem_cgroup_try_charge+0x159/0x460
> >   mem_cgroup_try_charge_delay+0x3d/0xa0
> >   wp_page_copy+0x14d/0x930
> >   do_wp_page+0x107/0x7b0
> >   __handle_mm_fault+0xce6/0xd40
> >   handle_mm_fault+0xfc/0x2f0
> >   do_page_fault+0x263/0x6f9
> >   page_fault+0x34/0x40
> >
> > Since the failcnt and watermark are tolerant of some inaccuracy, a data
> > race will not be harmful, thus mark them as intentional data races with
> > the data_race() macro.
>
> I am not familiar with KCSAN and git grep for data_race on the current
> linux-next doesn't really show any users of this macro. Is there a
> general consensus that data_race is going to be used to silence all
> KCSAN false positives?

It was discussed here:
https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/

If they're intentional data races that should remain, data_race() is
one option. There are 4 options (other than address the data race) to
deal with 'false positives':
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/dev-tools/kcsan.rst#n101

That being said, every use of data_race() needs to be justified, and
not just applied without understanding the issue. See below.

> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  mm/page_counter.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > index de31470655f6..13934636eafd 100644
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
> >                * This is indeed racy, but we can live with some
> >                * inaccuracy in the watermark.
> >                */
> > -             if (new > c->watermark)
> > -                     c->watermark = new;
> > +             if (data_race(new > c->watermark))
> > +                     data_race(c->watermark = new);

These should be using 'READ_ONCE' and 'WRITE_ONCE' for c->watermark.
Store or load tearing would change the logic here, since the
comparison might see garbage.

> >       }
> >  }
> >
> > @@ -126,7 +126,7 @@ bool page_counter_try_charge(struct page_counter *counter,
> >                        * This is racy, but we can live with some
> >                        * inaccuracy in the failcnt.
> >                        */
> > -                     c->failcnt++;
> > +                     data_race(c->failcnt++);

This is probably fine.

> >                       *fail = c;
> >                       goto failed;
> >               }
> > @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
> >                * Just like with failcnt, we can live with some
> >                * inaccuracy in the watermark.
> >                */
> > -             if (new > c->watermark)
> > -                     c->watermark = new;
> > +             if (data_race(new > c->watermark))
> > +                     data_race(c->watermark = new);

This should be READ_ONCE / WRITE_ONCE.

> >       }
> >       return true;
> >
> > --
> > 2.21.0 (Apple Git-122.2)
>
> --
> Michal Hocko
> SUSE Labs
