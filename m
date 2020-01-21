Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF022522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBGUwf1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgAUJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:26:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34810 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:26:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so2347166otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=015iS5ab+bbbbqMto8iml1toavjBX/achPCg/YdPZXI=;
        b=mBGUwf1spvYZf9aFcmTrpdCatsnzV28NF2Iulhvl37FQidV/Sb8q/fRo66G5tdixYK
         pySnzNwWjF6pb3nTpQB4v+3FxmP1dgO4YpwDNaZAg14XI+VvjkyQth+VWsr3vmy6VqA1
         +XcquIQgOrsv8XkWpJ828ZuXnZZQRdVW6N7hyQbpxaT4xVe+sjyxOeaa8fGVMeLQvpaW
         NJTxAeq3X8BwieYTtkGrdGXQ0doEtBkNZFaSpsriMwTZcioKK1ypCfIJPvSgUNiu0Wy6
         iDtSJNKspPd6vUHJPAs/WJjBCno4ysLB8vgTCjmtLanqQSbVOnkuMDk94fWQ9y+f8gQg
         /VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=015iS5ab+bbbbqMto8iml1toavjBX/achPCg/YdPZXI=;
        b=J5dfZ8Nri1PV7aSNRWyXZ8LFKd74ao63fp+UzUWSZhYAnqP7UIWJ373xmA4W9OXQX8
         pJVtt/+ZRHkq1tnrRdB2+hAWPFYmR+8P2xUgZw56sxIiPEhC5EQgRAcPtOOIVzP7scpN
         +uCtAQ4QhGu7rau2y5k7gzRsY19MK7xaJS3rFGMG6EMUJbPLGKTFpW+VadyL5nPWBxK4
         tVQsC0q1n1sscAOjjEJzlATNVLmHWqhg78cLXIAH0dOy1TOJ4ovHhmYJbcckjppk35Ey
         ym8bjLVOOsmdJmeymYZp9J48/a/XBEPOQYM7ft3aFU83eRKPlcQnHaiRTlqgciJ1stxg
         Te1A==
X-Gm-Message-State: APjAAAWwYksnj9vFMMwWZfPnRwmVdZegk3HTeEQzdJA8B7BDdTT6t4Hk
        BKBT45tm/LR72yci8GyNVgWfQxfkXz6qvrwZ9YRD/g==
X-Google-Smtp-Source: APXvYqx5S5usi1vwj/772yfSdbnumknzUZMoWDH+DDcFbK+cc/0m2U2mpFUD46GX+AyVTi7VBQQ9tuKuy4LUEAbLPQA=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr3006138otk.23.1579598807989;
 Tue, 21 Jan 2020 01:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20200121041200.2260-1-cai@lca.pw> <20200121072744.GA7808@zn.tnic>
 <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com> <20200121091633.GF7808@zn.tnic>
In-Reply-To: <20200121091633.GF7808@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 10:26:36 +0100
Message-ID: <CANpmjNMi8ULSt3MJ+MGUQRHj4xYE1FY4PmTSbHZr3TTe4-g7TQ@mail.gmail.com>
Subject: Re: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 10:16, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jan 21, 2020 at 09:19:18AM +0100, Marco Elver wrote:
> > As I said in my email that you also copied to the message, this is
> > just a stats counter. For the general case, I think we reached
> > consensus that such accesses should intentionally remain data races:
> >   https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/T/#u
>
> Yap, I agree with Linus on the legibility aspect.
>
> > Either you can use the data_race() macro, making this
> > 'data_race(cpa_4k_install++)' -- this effectively documents the
> > intentional data race --
> >
> > or just blacklist the entire file by putting
> >   KCSAN_SANITIZE_set_memory.o := n
> > into the Makefile.
> >
> > [ Note that there are 2 more ways to blacklist:
> >   - __no_kcsan function attribute, for blacklisting entire functions.
> >   - KCSAN_SANITIZE :=n in the Makefile, blacklisting all compilation
> > units in the Makefile. ]
>
> Do we have all those official methods how to make KCSAN happy,
> documented somewhere?

Yes, it's in Documentation/dev-tools/kcsan.rst. I sent a patch last
month, which is in the -rcu tree:
  http://lkml.kernel.org/r/20191212000709.166889-1-elver@google.com

> > I leave it to you what makes more sense. I don't know if there are
> > other data races lurking here, since cpa_4k_install is not the only
> > stats counter.
>
> In this particular case and if it were me, I'd prefer the __no_kcsan
> function attribute because it is kept outside of the function body. But
> I can't find __no_kcsan in current tip:
>
> $ git grep __no_kcsan
> .h:204:static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> include/linux/compiler.h:215:# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
> include/linux/compiler.h:216:# define __no_sanitize_or_inline __no_kcsan_or_inline
> include/linux/compiler.h:218:# define __no_kcsan_or_inline __always_inline
> include/linux/compiler.h:225:static __no_kcsan_or_inline
> include/linux/compiler.h:238:static __no_kcsan_or_inline
>
> just this "glued together" thing __no_kcsan_or_inline.

As far as I can tell it's not yet in -tip, but only in -rcu (and
-next). I believe it should be in -tip soon.

Thanks,
-- Marco
