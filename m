Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C5C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB37920709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obihzlDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:04:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36101 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFUE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:04:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id t24so3812164oij.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVlYN/Md4CQuFbWSnNYxMJeZKuKOqQz+ggxE0H479rs=;
        b=obihzlDkCTNEy6Sxv9yUxeSALysMZc5Gze5sRzwGgAdeUYrYHe+yoFwmk/lcTLipYe
         9D8VW917A9Z4nTvkZS9hdAeObK6OUWTYNQOdPOnDsdS8I/KPYX0ztOjQNvjAOsURyLEi
         J028lMd6QV4t+h3Q8fnlpcI6bQRFS1MG73KO0bmnQaQaZ+Tu0xiGSzsSna9U/eXWptB6
         PZAjVKvVHGiv4EKsEzD+Xzj0gre5arJqkINfAc+Y+JbtGLrMSBFuWsBD6LcLGs1I97B7
         Jb/Ni/hL6a9lUok6978Z0SDdqmodafHoBfl6jMfDQ5DBYJUWOEnCUh3PiMorigK7neO3
         PEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVlYN/Md4CQuFbWSnNYxMJeZKuKOqQz+ggxE0H479rs=;
        b=dbZHur1TFM3Fnhe+Z0Z/+f0o6D2exodW5jQkD+XrvkFLJEYTYv3ddqMbhdFRrbHeQj
         y6alKK1lngNLJeML0wZMbluAuq1dYbR575APM4aPXVU2/5IuH9SqkcOGO23Na0ELDK3F
         LqntwEL9dOCQOa98Ul7halnAEkGIoWwGyI18U8LzalCFCuWNrEqbBGrMxsWHpEYOD2vt
         KfPdxX4zOmeSRysZorbqBR+wlThhtbG7/GZ4KPS8If0u5x4kWbKcn407K4zelBdnQO2y
         ZAzjnvLdKi8j3VW7oG6We5jk7bpeSz7wmqFkPwIBv5fOEhm/fAGA5Y4vmJu62t1iyEL3
         Kxpg==
X-Gm-Message-State: ANhLgQ1CxhfZFmX/G5khgAdzBhP/0kBg7tSm586YwGChjQC9kdCF4gBp
        0cP1g+JnjkX3VweDEi37pEJx7UspGi6opemqX742A8Sr
X-Google-Smtp-Source: ADFU+vtwCtEGKpC2Q99xYLVhMETGfqqUMJ3jol67I+DPcyZODBtUttHS41sz3DAN4oGtmzoBIyxux7jRK1FCp8ERFqs=
X-Received: by 2002:a54:4890:: with SMTP id r16mr885043oic.121.1583525065203;
 Fri, 06 Mar 2020 12:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20200304031551.1326-1-cai@lca.pw> <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72> <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72> <20200305151831.GM29971@bombadil.infradead.org>
 <20200305213946.GL2935@paulmck-ThinkPad-P72> <CANpmjNOtsdxh3YLcF-pUMua9afWfhg5P_2ziRGSMuT8Gi0c5TA@mail.gmail.com>
 <20200306165300.GC25710@bombadil.infradead.org> <20200306170316.GX2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200306170316.GX2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Mar 2020 21:04:13 +0100
Message-ID: <CANpmjNOGCmTXLFR=ycdtTVtRSqbj75MzYOo5V8PZ47trpcVddg@mail.gmail.com>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 at 18:03, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Mar 06, 2020 at 08:53:00AM -0800, Matthew Wilcox wrote:
> > On Fri, Mar 06, 2020 at 02:38:39PM +0100, Marco Elver wrote:
> > > On Thu, 5 Mar 2020 at 22:39, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Thu, Mar 05, 2020 at 07:18:31AM -0800, Matthew Wilcox wrote:
> > > > > I have found three locations where we use the ->marks array:
> > > > >
> > > > > 1.
> > > > >                         unsigned long data = *addr & (~0UL << offset);
> > > > >                         if (data)
> > > > >                                 return __ffs(data);
> > > > >
> > > > > 2.
> > > > >         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> > > > > 3.
> > > > >         return test_bit(offset, node_marks(node, mark));
> > > > >
> > > > > The modifications -- all done with the spinlock held -- use the non-atomic
> > > > > bitops:
> > > > >         return __test_and_set_bit(offset, node_marks(node, mark));
> > > > >         return __test_and_clear_bit(offset, node_marks(node, mark));
> > > > >         bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
> > > > > (that last one doesn't really count -- it's done prior to placing the node
> > > > > in the tree)
> > > > >
> > > > > The first read seems straightforward; I can place a READ_ONCE around
> > > > > *addr.  The second & third reads are rather less straightforward.
> > > > > find_next_bit() and test_bit() are common code and use plain loads today.
> > > >
> > > > Yes, those last two are a bit annoying, aren't they?  I guess the first
> > > > thing would be placing READ_ONCE() inside them, and if that results in
> > > > regressions, have an alternative API for concurrent access?
> > >
> > > FWIW test_bit() is an "atomic" bitop (per atomic_bitops.txt), and
> > > KCSAN treats it as such. On x86 arch_test_bit() is not instrumented,
> > > and then in asm-generic/bitops/instrumented-non-atomic.h test_bit() is
> > > instrumented with instrument_atomic_read(). So on x86, things should
> > > already be fine for test_bit(). Not sure about other architectures.
> >
> > Hum.  It may well be documented as atomic, but is it?  Here's the
> > generic implementation:
> >
> > static inline int test_bit(int nr, const volatile unsigned long *addr)
> > {
> >         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > }
> >
> > arch_test_bit is only used by the instrumented variants:
> >
> > $ git grep arch_test_bit include
> > include/asm-generic/bitops/instrumented-non-atomic.h:   return arch_test_bit(nr, addr);
> >
> > As far as I can tell, the generic version is what's used on x86.  Does
> > the 'volatile' qualifier save us here?

x86 uses its own implementation of test_bit(), which we had to address
early on, otherwise we would still have tons of false reports due to
test_bit() usage.

$ grep -E -A3 'test_bit|instrumented' arch/x86/include/asm/bitops.h
static __no_kcsan_or_inline bool constant_test_bit(long nr, const
volatile unsigned long *addr)
{
        /*
         * Because this is a plain access, we need to disable KCSAN here to
         * avoid double instrumentation via instrumented bitops.
         */
        return ((1UL << (nr & (BITS_PER_LONG-1))) &
                (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
--
static __always_inline bool variable_test_bit(long nr, volatile const
unsigned long *addr)
--
#define arch_test_bit(nr, addr)                 \
        (__builtin_constant_p((nr))             \
         ? constant_test_bit((nr), (addr))      \
         : variable_test_bit((nr), (addr)))
--
#include <asm-generic/bitops/instrumented-atomic.h>
#include <asm-generic/bitops/instrumented-non-atomic.h>
#include <asm-generic/bitops/instrumented-lock.h>


For the asm-generic variant, the cast to volatile should have the same
effect as READ_ONCE today (except maybe on Alpha?).  We would still
need to use READ_ONCE() in asm-generic's test_bit() though, to avoid
KCSAN false positives on other architectures. The code-gen should be
the same. I can try to send a patch and see if that's ok to do.

> > find_next_bit() doesn't have the 'volatile' qualifier, so may still be
> > a problem?
>
> One approach would be to add the needed READ_ONCE().
>
> Another, if someone is crazy enough to do the work, would be to verify
> that the code output is as if there was a READ_ONCE().
>
> Thoughts?

find_next_bit() is difficult. The code is definitely not the same with
READ_ONCE(), there are 8 more instructions (x86-64). For now the only
thing we can do if we're fine with data-racy behaviour in
find_next_bit(), without changing it, is to use it with
'data_race(find_next_bit(...))'. Not great though. :-/

Thanks,
-- Marco
