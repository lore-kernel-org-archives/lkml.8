Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A01EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D933520738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598032952;
	bh=Xl6jcL9hhy3BgiZkNLXsUqLrgDzkUaiMnW3SLPVcDK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hyw+KvYlSqr4EyeBl1agnbXQ5fpgzSPFOlGW0Jc+rumtOJDZZYvOAoeUrDvVLiCEA
	 deaI/9+KGrJYT0OHtiCAJ0MvUK/bk764lb6Qh0u8xzG1Ggci+StOJsPsPL+KRagjoe
	 oeEVHqctu9Fm5bQj1lUNnrf9+PapwLjgQ3Wz23xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHUSC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHUSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:02:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B7C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:02:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so2775595ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5jlbfKRCl3JIOGz2Ss/o2Y7bPu9rBvFEngYmreq1Cw=;
        b=XdIrKLreG3mWA0Sd5hGpTYI4JB4BZR668IVI8Q/2P4m+46HsQmwrBjgqHESZb6n9zJ
         QHgdBE8kWpe39ioWRxyYwUfSIq+91IB9t13h/N7011Gb97HTKzOp+ui928AEOkIbRhXP
         QclUoQWTcwkjMCaHsF+xRHWLLfxntTzt9G7EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5jlbfKRCl3JIOGz2Ss/o2Y7bPu9rBvFEngYmreq1Cw=;
        b=P5J7L6gZ4m1pATgVkVPGDKr0NcX/a8uWtfN6Vy9eFnrcchk3e3Gl4Jccxq/SgEzsEV
         fPTZ5rBtHhcMJo3sEpXf8/zFNl1rIuW9lrN1wccW/H8xf7DDp8gTOzApSR1HWW82SXNH
         oid2dLmDjbZynhqCFzQ/EGqifYkYBczahChJUPDOS3QTKy03uxzmqmaNQq6Z7D44JvsO
         C6GYlxNxwKhru4cnND6D7nSt2i1AtT2mBu2ROEhBKPx0WIJdgRAOhpz2xSAIkSVN4fie
         aawONa9otk+jUXKjMiqBVEDgIEl6tsWe7thQCOfsbvcfAk2ygu0kJ2wfVTgZyaIr0p5L
         UsZA==
X-Gm-Message-State: AOAM531UquTRp5pc62mbbACfRmYAg/M8tFqmPaAin65//rnaS7FC0Wx7
        Z6BzLlDtkfRYCIigq5f6VB+1vBXMXy9Bww==
X-Google-Smtp-Source: ABdhPJxLaXCkqGsM2nUv2BSnPQmY3vkbgsBhcXtFN05rPGq+qjpFlQJKIvepvrQ55/OCGlJ15fmt3Q==
X-Received: by 2002:a05:651c:1344:: with SMTP id j4mr2189172ljb.164.1598032945153;
        Fri, 21 Aug 2020 11:02:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h6sm514142ljg.86.2020.08.21.11.02.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:02:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w14so2809767ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:02:24 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr2226306ljf.285.1598032944089;
 Fri, 21 Aug 2020 11:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <20200818202407.GA3143683@rani.riverdale.lan> <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan> <df6c1da4-b910-ecb8-0de2-6156dd651be6@rasmusvillemoes.dk>
 <20200820175617.GA604994@rani.riverdale.lan> <CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com>
 <20200821172935.GA1411923@rani.riverdale.lan> <CAHk-=wi8vdb+wo-DACDpSijYfAbCs135YcnnAbRhGJcU+A=-+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi8vdb+wo-DACDpSijYfAbCs135YcnnAbRhGJcU+A=-+Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 11:02:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjVCTjZG0Y88WhJruLdbxF=7q3mmFThD+N5WK0P5giSw@mail.gmail.com>
Message-ID: <CAHk-=whjVCTjZG0Y88WhJruLdbxF=7q3mmFThD+N5WK0P5giSw@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Aug 21, 2020 at 10:29 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This is why I'm saying clang's no-builtin-foo option is useful for
> > embedded: it doesn't prevent the programmer using __builtin_foo(), it
> > prevents the _compiler_ using __builtin_foo() on its own.
>
> And that's fine. But it's apparently not what gcc does.

Oh, testing it seems to say that that is exactly what gcc does too. I
must have misunderstood some comment in this thread to mean otherwise.

                Linus
