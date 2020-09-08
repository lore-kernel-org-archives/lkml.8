Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D48C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA4F2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPX3it+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgIHRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbgIHQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2EC0617B9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:16:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so17091120wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25SuQDI0eyCRm9y5WDHzplEK9oGtQL3VKe10BEOjmTA=;
        b=QPX3it+b0HCvDkvbnLXnuah4CoH16gftRJ7806vrwP3qNieZtYGGzWOWb5H6s2Ymo6
         tFciYxxHwZ+bLk25IzxWbtHz0zL7hPxojHfBsUJqxOPoVKqSYMw4s5Jhs4CWSe+lLKvZ
         c5AwWr450MpqcX6CXpFhLMMNrVYkQ9Fjd8nqLWMfFi9LnzsfdtWd0LpKQYtzz+NCxHB3
         J637fA5b93NLgh+gh4KvKv3RMjqzd73wNSnuCBKM/un+6MXqTcJ0HEPCNbet4mb1L5NA
         cKFb0yVJxMPcpuUS6t+uXVXwP2CwZFGY4q8U86OqXN4i0oaciML3l3t5SgA2Rsr+bZIa
         dFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25SuQDI0eyCRm9y5WDHzplEK9oGtQL3VKe10BEOjmTA=;
        b=boefQ8avXQ0E42bqc2BFMAzZoV8ybYrVJvNGYhi189YPd5vouqN9MmBrP0Tha5RFo1
         bVKZnvQcjJ1IbdQiAvrqAvQXSC7KO9m8rZRIUtXyvecCkZcDl3xIOhqCKiddiGIyfWA4
         4PdUwPr4kn51e34P2gpHdKAIZ00Pqzu10qSQpGepPXGI7PetV+l4rSharXpPaAu/93/R
         fcB1+SsIHKovrAqELN1M3DMpPn1uRfj7r+JLH53ClGQCAS4tQQjPF9ElQeS1FrA+lig+
         FL/31kYRTVIM2nDEp9mRDxiK8CYafuIhanksD2JRduy38/qntsscabjixCvwBauTcCss
         dKpA==
X-Gm-Message-State: AOAM533GZAKh1VDluVY3uG07/aHmOgQtgQ9JXW+NM5LwEG0huFdyJiO2
        pduAP81gJPGjEtFa0ZMWWGhShXZDv/lbhRTm2fkThw==
X-Google-Smtp-Source: ABdhPJzNFarnK0nYdbKJBLU0NMJuC6Hpm534oaFYqrVkXTx051ncwUm57xW2hX6Fd0DEO38hfYKPpM9pZm6/JEEqxdA=
X-Received: by 2002:a1c:105:: with SMTP id 5mr4078883wmb.175.1599567380842;
 Tue, 08 Sep 2020 05:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <4dc8852a-120d-0835-1dc4-1a91f8391c8a@suse.cz>
In-Reply-To: <4dc8852a-120d-0835-1dc4-1a91f8391c8a@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 8 Sep 2020 14:16:09 +0200
Message-ID: <CAG_fn=UdnN4EL6OtAV8RY7kuqO+VXqSsf+grx2Le64UQJOUMvQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, paulmck@kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Toggling a static branch is AFAIK quite disruptive (PeterZ will probably =
tell
> you better), and with the default 100ms sample interval, I'd think it's n=
ot good
> to toggle it so often? Did you measure what performance would you get, if=
 the
> static key was only for long-term toggling the whole feature on and off (=
boot
> time or even runtime), but the decisions "am I in a sample interval right=
 now?"
> would be normal tests behind this static key? Thanks.

100ms is the default that we use for testing, but for production it
should be fine to pick a longer interval (e.g. 1 second or more).
We haven't noticed any performance impact with neither 100ms nor bigger val=
ues.

Regarding using normal branches, they are quite expensive.
E.g. at some point we used to have a branch in slab_free() to check
whether the freed object belonged to KFENCE pool.
When the pool address was taken from memory, this resulted in some
non-zero performance penalty.

As for enabling the whole feature at runtime, our intention is to let
the users have it enabled by default, otherwise someone will need to
tell every machine in the fleet when the feature is to be enabled.
>
> > We have verified by running synthetic benchmarks (sysbench I/O,
> > hackbench) that a kernel with KFENCE is performance-neutral compared to
> > a non-KFENCE baseline kernel.
> >
> > KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
> > properties. The name "KFENCE" is a homage to the Electric Fence Malloc
> > Debugger [2].
> >
> > For more details, see Documentation/dev-tools/kfence.rst added in the
> > series -- also viewable here:
> >
> >       https://raw.githubusercontent.com/google/kasan/kfence/Documentati=
on/dev-tools/kfence.rst
> >
> > [1] http://llvm.org/docs/GwpAsan.html
> > [2] https://linux.die.net/man/3/efence
> >
> > Alexander Potapenko (6):
> >   mm: add Kernel Electric-Fence infrastructure
> >   x86, kfence: enable KFENCE for x86
> >   mm, kfence: insert KFENCE hooks for SLAB
> >   mm, kfence: insert KFENCE hooks for SLUB
> >   kfence, kasan: make KFENCE compatible with KASAN
> >   kfence, kmemleak: make KFENCE compatible with KMEMLEAK
> >
> > Marco Elver (4):
> >   arm64, kfence: enable KFENCE for ARM64
> >   kfence, lockdep: make KFENCE compatible with lockdep
> >   kfence, Documentation: add KFENCE documentation
> >   kfence: add test suite
> >
> >  Documentation/dev-tools/index.rst  |   1 +
> >  Documentation/dev-tools/kfence.rst | 285 +++++++++++
> >  MAINTAINERS                        |  11 +
> >  arch/arm64/Kconfig                 |   1 +
> >  arch/arm64/include/asm/kfence.h    |  39 ++
> >  arch/arm64/mm/fault.c              |   4 +
> >  arch/x86/Kconfig                   |   2 +
> >  arch/x86/include/asm/kfence.h      |  60 +++
> >  arch/x86/mm/fault.c                |   4 +
> >  include/linux/kfence.h             | 174 +++++++
> >  init/main.c                        |   2 +
> >  kernel/locking/lockdep.c           |   8 +
> >  lib/Kconfig.debug                  |   1 +
> >  lib/Kconfig.kfence                 |  70 +++
> >  mm/Makefile                        |   1 +
> >  mm/kasan/common.c                  |   7 +
> >  mm/kfence/Makefile                 |   6 +
> >  mm/kfence/core.c                   | 730 +++++++++++++++++++++++++++
> >  mm/kfence/kfence-test.c            | 777 +++++++++++++++++++++++++++++
> >  mm/kfence/kfence.h                 | 104 ++++
> >  mm/kfence/report.c                 | 201 ++++++++
> >  mm/kmemleak.c                      |  11 +
> >  mm/slab.c                          |  46 +-
> >  mm/slab_common.c                   |   6 +-
> >  mm/slub.c                          |  72 ++-
> >  25 files changed, 2591 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/dev-tools/kfence.rst
> >  create mode 100644 arch/arm64/include/asm/kfence.h
> >  create mode 100644 arch/x86/include/asm/kfence.h
> >  create mode 100644 include/linux/kfence.h
> >  create mode 100644 lib/Kconfig.kfence
> >  create mode 100644 mm/kfence/Makefile
> >  create mode 100644 mm/kfence/core.c
> >  create mode 100644 mm/kfence/kfence-test.c
> >  create mode 100644 mm/kfence/kfence.h
> >  create mode 100644 mm/kfence/report.c
> >
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
