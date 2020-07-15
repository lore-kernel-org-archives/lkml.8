Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EFFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81A92065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGOSVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:21:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40207 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGOSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:21:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id t198so2953454oie.7;
        Wed, 15 Jul 2020 11:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FF6NE3RgAgvvORLzrwBOqEqD//9KPcGwvYKX0LojsE=;
        b=TK3mi/bHffi/aEJRfbAnIouCrWpTtNeQDZe/DqmPNHb51FoaqS500TEpLr/0VH1HR6
         7nF4BxjxMQV5fb09OmQKUCceoKjMRsoLZBcnMHDOZfdwodIEYp3vPoxXJqVBSXCtSrSc
         4DEe2kvY6ftFCflhGfVCXso1k/6bbqAKOE/Kzm8EhSVa8dt2fVL7RnGGypJdgAA2fDvb
         2J8HelyKFvEdZfjEUoXZibAZFNujSWmpsmnAY30OgjVf8Aq8q+jBZSj3043nWd30ekng
         7Pz6X8Zet5HD8CYO9KeJJYFPxZ69Di3rTQOAtCI98QuLx0r+qZ5pzBkXmQBg/uKZBqjR
         6iqA==
X-Gm-Message-State: AOAM530Bn3OjDDGEI65oL27Q2HTp8THObFTm8iAJ/Ua2RnL+nxLargsk
        QpsHSUeR9askigdCjk3oMwGaS7JeA8mo7KXxlGg=
X-Google-Smtp-Source: ABdhPJwcV1vvhv5crG8UvMw8+zcm63bfpdE+L75sxCxC4Zcq61IpcOYcERI4IV670l+4nsLuAHvWr6g3bRI8fJaTsOI=
X-Received: by 2002:aca:5c41:: with SMTP id q62mr834458oib.148.1594837298177;
 Wed, 15 Jul 2020 11:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de> <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
In-Reply-To: <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 20:21:27 +0200
Message-ID: <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 6:18 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 4:37 PM, John Paul Adrian Glaubitz wrote:
> > Okay, kernel 5.0.0 does not suffer from this bug. So I should be able to bisect
> > this particular issue.
> >
> > I'm glad I don't have to start bisecting with earlier kernels because these
> > won't build easily with my current toolchain based on gcc-9.
> >
> > Will report once I found the bad commit that introduced the problem.
>
> Found the culprit:
>
> c5b27a889da92f4a969d61df77bd4f79ffce57c9 is the first bad commit
> commit c5b27a889da92f4a969d61df77bd4f79ffce57c9
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Sep 4 14:45:04 2018 +0200
>
>     sh/tlb: Convert SH to generic mmu_gather
>
>     Generic mmu_gather provides everything SH needs (range tracking and
>     cache coherency).
>
>     No change in behavior intended.
>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Andy Lutomirski <luto@kernel.org>
>     Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: Dave Hansen <dave.hansen@linux.intel.com>
>     Cc: H. Peter Anvin <hpa@zytor.com>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Nick Piggin <npiggin@gmail.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Rich Felker <dalias@libc.org>
>     Cc: Rik van Riel <riel@surriel.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
>  arch/sh/include/asm/pgalloc.h |   9 +++
>  arch/sh/include/asm/tlb.h     | 130 +-----------------------------------------
>  2 files changed, 10 insertions(+), 129 deletions(-)
>
> CC'ing the author (Peter Zijlstra <peterz@infradead.org>).

Oh, we actually discussed that:
https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/
but there was no conclusion...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
