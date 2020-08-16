Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C29206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tp8pglj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgHPP4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:56:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990E5C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:56:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c6so12418187ilo.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6yfTzPdmjn3x3BwO/mgMcDzgBtWRhHR4dd4RQVq0xFg=;
        b=tp8pglj0pK2RHLFfLw3O7kFiZ2oDncRr25yVOqkK/3lLouUmj+p4ASniwde5BqyM0T
         gD2uky5AdMRm2khpb3lciDolnQoLvGbmQTQPzVSJDgKz9RHf8tALZyksTZLjvIhiINxs
         4ep//tqaSlaxZiViqsS+AvBGuvcwNfw4biBgjtfvuqfux+dmGBJ9/qSUIa7QEoKI/dAx
         jh3zijNGXpvCfVPNwKJqBJXXVid8KetzGwQgzcl/n1Cg7Ml53iHpgM6+uItZAhSr2zMl
         6KUx6QYP/cZ7+6HqDiAvQDOZPud2ZqmOWlNZIxcrnv1/A9fFiBwLESGoSh1GtQ79WzFZ
         7Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6yfTzPdmjn3x3BwO/mgMcDzgBtWRhHR4dd4RQVq0xFg=;
        b=jjWlM4StsYQj4PUOWqCVQOcPof8DgNbNmUWTULr25Zp9QP9o/utBEYMVcrBK+X13/1
         hX5HLOs8jryruCpezcR+9TPbltWUR+9K0UC1XjyhpmkfvYazGVf49e/8tJJ/4rf9Jkui
         CqFvGkiQJo1kqMYfYiT5g4y8TkqDd56an/lWtakV48VNOtUKovrJ2EkeIC58ZuOT0gS0
         wVWOYWicsCkF34OiTTNaWA2MmpEpyxFmvWn9WarT0UtkD9HLcbL3bIB8dR7yGRHZTdk6
         dNp7XkstBH14s+ivm8UcRmouEJVbZNG8IpIohxpEBiC74ICRWD/snFDbMGr8TvsZdLyt
         nLcg==
X-Gm-Message-State: AOAM533s+INUVBfcLmksD/s3uz977F4dyWnt5ufIukCl41fJf+2SgKkd
        RxN+tEFn8WVroXpiGMC0DmxIkQYIitpvsqNzCYs=
X-Google-Smtp-Source: ABdhPJzKy+817QpPO9T7ZwQC+EUeigIycIA+oNzLS+t2ge2e4rqtm3KTVJenT93Z8r3O9kCjGLOC2T0spqxOqogARC4=
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr10495399ilq.42.1597593372472;
 Sun, 16 Aug 2020 08:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200816041720.GG17456@casper.infradead.org> <957eee62-1f46-49b6-4d5a-9671dc07c562@linux.alibaba.com>
In-Reply-To: <957eee62-1f46-49b6-4d5a-9671dc07c562@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sun, 16 Aug 2020 08:56:01 -0700
Message-ID: <CAKgT0UeT0VK4zW+aXn0-6VcO0hYF9u+h+0Cb9kgjvChUQ0w=6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/pageblock: remove false sharing in pageblock_flags
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 7:11 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/16 =E4=B8=8B=E5=8D=8812:17, Matthew Wilcox =E5=86=99=E9=
=81=93:
> > On Sun, Aug 16, 2020 at 11:47:57AM +0800, Alex Shi wrote:
> >> Current pageblock_flags is only 4 bits, so it has to share a char size
> >> in cmpxchg when get set, the false sharing cause perf drop.
> >>
> >> If we incrase the bits up to 8, false sharing would gone in cmpxchg. a=
nd
> >> the only cost is half char per pageblock, which is half char per 128MB
> >> on x86, 4 chars in 1 GB.
> >
> > I don't believe this patch has that effect, mostly because it still doe=
s
> > cmpxchg() on words instead of bytes.
>
> Hi Matthew,
>
> Thank a lot for comments!
>
> Sorry, I must overlook sth, would you like point out why the cmpxchg is s=
till
> on words after patch 1 applied?
>

I would take it one step further. You still have false sharing as the
pageblocks bits still occupy the same cacheline so you are going to
see them cache bouncing regardless.

What it seems like you are attempting to address is the fact that
multiple threads could all be attempting to update the same long
value. As I pointed out for the migrate type it seems to be protected
by the zone lock, but for compaction the skip bit doesn't have the
same protection as there are some threads using the zone lock and
others using the LRU lock. I'm still not sure it makes much of a
difference though.

> >
> > But which functions would benefit?  It seems to me this cmpxchg() is
> > only called from the set_pageblock_migratetype() morass of functions,
> > none of which are called in hot paths as far as I can make out.
> >
> > So are you just reasoning by analogy with the previous patch where you
> > have measured a performance improvement, or did you send the wrong patc=
h,
> > or did I overlook a hot path that calls one of the pageblock migration
> > functions?
> >
>
> Uh, I am reading compaction.c and found the following commit introduced
> test_and_set_skip under a lock. It looks like the pagelock_flags setting
> has false sharing in cmpxchg. but I have no valid data on this yet.
>
> Thanks
> Alex
>
> e380bebe4771548  mm, compaction: keep migration source private to a singl=
e compaction instance
>
>                 if (!locked) {
>                         locked =3D compact_trylock_irqsave(zone_lru_lock(=
zone),
>                                                                 &flags, c=
c);
> -                       if (!locked)
> +
> +                       /* Allow future scanning if the lock is contended=
 */
> +                       if (!locked) {
> +                               clear_pageblock_skip(page);
>                                 break;
> +                       }
> +
> +                       /* Try get exclusive access under lock */
> +                       if (!skip_updated) {
> +                               skip_updated =3D true;
> +                               if (test_and_set_skip(cc, page, low_pfn))
> +                                       goto isolate_abort;
> +                       }
>

I'm not sure that is a good grounds for doubling the size of the
pageblock flags. If you look further down in the code there are bits
that are setting these bits without taking the lock. The assumption
here is that by taking the lock the test_and_set_skip will be
performed atomically since another thread cannot perform that while
the zone lock is held. If you look in the function itself it only does
anything if the skip bits are checked and if the page is the first
page in the pageblock.

I think you might be confusing some of my earlier comments. I still
believe the 3% regression you reported with my patch is not directly
related to the test_and_set_skip as the test you ran seems unlikely to
trigger compaction. However with that said one of the advantages of
using the locked section to perform these types of tests is that it
reduces the number of times the test is run since it will only be on
the first unlocked page in any batch of pages and the first page in
the pageblock is always going to be handled without the lock held
since it is the first page processed.

Until we can get a test up such as thpscale that does a good job of
stressing the compaction code I don't think we can rely on just
observations to say if this is an improvement or not.

Thanks.

- Alex
