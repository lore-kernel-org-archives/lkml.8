Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4411CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077CE212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOyCc4Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgCaQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:39:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:39:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so3257527wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgoMF0cL9ZUADYdGprv6AZfHS2idq4rpQGViQrbTh3g=;
        b=MOyCc4PgavB5gSASpI6clKEFNY8K2buCcld4kUOHT2U6+ZQD2QBLgweg819jEBdBmH
         3B9tDDscrZBDI4FwQuUuqfjtvh/MpztQ9r8K3LEqBZcOaSxJKvQSfcPYIF9azVlNiLbz
         tZmwU4/gZX2ta8YRKxbZdzOAyUVZaSHjXVx2q2W4Ua+HLIgmzpHsU+tejH9k/rNScbFv
         9wfBwW3l4EVy/+GM/Rb4eRtSonYmvPKq9PAvjlzVq5lUsw+7+RYt3c0Fq34dWNp2i8TA
         0lcLJZlx0N4M0KVXGD6kjXWagBLecurFWWNfg7DyVUj76MCGtAZB869ZvlLV340LEuyR
         L5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgoMF0cL9ZUADYdGprv6AZfHS2idq4rpQGViQrbTh3g=;
        b=iIpt3JKw/p37VbuBRlCb7zZnK98TPyJzhxc4OnHbVHe9Yn/o0oI0hS2s5cpmXjmTwN
         IEnwlmx6EJc3GYqg6Dd035NCv7FOMgBQZYZMbLY6Zv8/7Uv6FVSRaM819QCsdDJWN+XU
         Ei5174+3XHabi3NYe5fhaQ+BTHxX35GYScclgL2wMztmR+J3h1boqcP12Aa+WRtSa831
         dQSf4KIhJ/0Lm1ATb8PGQWPqgzBfJbVtQTT2lsud1TOqsjFzi4lJg0zgoqaGowgmYwiQ
         CCEjfsXIwhnleqMY+noZ8Yn7WQAESBeZHumM/b+Rx3E5LfxH0AXwxsuQ0Qt92sfyI7oS
         9m5Q==
X-Gm-Message-State: ANhLgQ1b4QldVYDdb6FgMgpS2bAkoMJqE+p9GHcyCjZSIx1Qzuqg228w
        2NokI3Z+ID3KIs5yUM6E4kfa0kVKMQbWawuznJvHoQ==
X-Google-Smtp-Source: ADFU+vvhJPSVd5yxnSsDuvriYVo33KEBmUD4VOfuBWlib7JCT2jIdpNHf/MvE4O71XY1jLiZ7wL2mWmFGr62DUp1Pxw=
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr4444781wmb.112.1585672772708;
 Tue, 31 Mar 2020 09:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
 <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com> <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
In-Reply-To: <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 31 Mar 2020 09:39:21 -0700
Message-ID: <CAKFsvULjkQ7T6QhspHg87nnDpo-VW1qg2M3jJGB+NcwTQNeXGQ@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 1:41 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-03-30 at 10:38 +0200, Dmitry Vyukov wrote:
> > On Mon, Mar 30, 2020 at 9:44 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> > > > > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > > > > confused the values - because I see, on userspace, the following:
> > > >
> > > > Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000.
> > >
> > > Right, ok.
> > >
> > > > Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...
> > >
> > > So it just occurred to me - as I was mentioning this whole thing to
> > > Richard - that there's probably somewhere some check about whether some
> > > space is userspace or not.
> > >

Yeah, it seems the "Kernel panic - not syncing: Segfault with no mm",
"Kernel mode fault at addr...", and "Kernel tried to access user
memory at addr..." errors all come from segv() in
arch/um/kernel/trap.c due to what I think is this type of check
whether the address is
in userspace or not.

> > > I'm beginning to think that we shouldn't just map this outside of the
> > > kernel memory system, but properly treat it as part of the memory that's
> > > inside. And also use KASAN_VMALLOC.
> > >
> > > We can probably still have it at 0x7fff8000, just need to make sure we
> > > actually map it? I tried with vm_area_add_early() but it didn't really
> > > work once you have vmalloc() stuff...
> >

What x86 does when KASAN_VMALLOC is disabled is make all vmalloc
region accesses succeed by default
by using the early shadow memory to have completely unpoisoned and
unpoisonable read-only pages for all of vmalloc (which includes
modules). When KASAN_VMALLOC is enabled in x86, the shadow memory is not
allocated for the vmalloc region at startup. New chunks of shadow
memory are allocated and unpoisoned every time there's a vmalloc()
call. A similar thing might have to be done here by mprotect()ing
the vmalloc space as read only, unpoisoned without KASAN_VMALLOC. This
issue here is that
kasan_init runs so early in the process that the vmalloc region for
uml is not setup yet.


> > But we do mmap it, no? See kasan_init() -> kasan_map_memory() -> mmap.
>
> Of course. But I meant inside the UML PTE system. We end up *unmapping*
> it when loading modules, because it overlaps vmalloc space, and then we
> vfree() something again, and unmap it ... because of the overlap.
>
> And if it's *not* in the vmalloc area, then the kernel doesn't consider
> it valid, and we seem to often just fault when trying to determine
> whether it's valid kernel memory or not ... Though I'm not really sure I
> understand the failure part of this case well yet.
>

I have been testing this issue in a multitude of ways and have only
been getting more confused. It's still very unclear where exactly the
problem occurs, mostly because the errors I found most frequently were
reported in segv(), but the stack traces never contained segv.

Does anyone know if/how UML determines if memory being accessed is
kernel or user memory?

> johannes
>


--
Best,
Patricia
