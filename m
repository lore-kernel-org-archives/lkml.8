Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC82DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0185206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD1UUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:20:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgD1UUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:20:05 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9W78-1jZ2U33HnA-005amh for <linux-kernel@vger.kernel.org>; Tue, 28 Apr
 2020 22:20:03 +0200
Received: by mail-qk1-f176.google.com with SMTP id o135so10774131qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubKgcYCGZPTlcNXDC5FD3z7xFmdxIjENtynmQ8XSZuA7Y3XBobC
        Waz3nFEU/sQzt6HwxZsk+b99L1HJ4K5Ucmw9JqY=
X-Google-Smtp-Source: APiQypK7QLahmWkvMcrJNx933CG5RbP5aw9XWv8As8rK7Pv5GXGKoN3E2TLZueHbBgo06RXBr1L+3zcz7OOllKVEfZU=
X-Received: by 2002:a37:851:: with SMTP id 78mr30349558qki.352.1588105202639;
 Tue, 28 Apr 2020 13:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
In-Reply-To: <20200428161044.caamvx67t2z4t6vd@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Apr 2020 22:19:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
Message-ID: <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M9bglFZb+K6kjAzvIp0DTzz0ZI+jPfA3kZ/9EXjCk8gmUoZSO96
 qym1S3NjYSTF4rnIF94t2VCf+pRiwx+gYxH2FKqC9pxALjfLSd971KPFF6EVtMKD88Xs7kL
 brRpn1QwDslZuu9hJ6M1pogOEBVhR+DMIE47ybJxxIGKwJKX2q9zBlmyM6QyNfLREQLDFGj
 gEp1+yyDbyiV6aZ9fpVtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9p/VePi+Xg8=:f1lD2KPpHOPuf1+Yc523WU
 /TZxdR/6KHad3WP8AWJo/34IQRT4ISPg+G3q42M/QarTBhXjaA+RG0/SOgKrK5rk21eXEzyTh
 Lporl3AhUMxaEAnmkWf0RVYHRbs4rHRQmMUmr9+KcBTd58aL0I5dPLIPEQpgCZzfZni/EAS96
 6HXMH0thqZi5MRgC1fU9qgs2+4dLERtMxgacbr0GiUnZdxrSe+T+FIYUSeDXbO0pK7HkuE5DQ
 C0EssWbq/O118u7Yzv5fz4iwukxF03iMmlGW7C7HgHilP/LKfoa8NyULCz9o70eIDkAqENEBJ
 13l7bSmrsAnLKWmCquX74ObqQuKy2MlzIRtZE4TcmQ3E3WyphgQPCCKYNZNRwgZVqkEJWY8KL
 83KVnbWpY+fvJ/4x+RDrRkZ8fhjcIW6nnFFSUgPS0tSLpDPh8xY+rkbHthjkvDCO6kqeHrd3C
 dmVW3YwDQUaJ3T3UqdK7kyDSMfc6qhrV66mbGepuFn7xHgs2kvrFhI2aKZ+dSu/NfHrYznsfO
 ahE0K7k3R129SIjXBMfG/28u2FSyUA7Acpyw2A721TUOqONSCUPNtWyJas1mMBenKb7H4VjSA
 lIXj1GmOqzJ7RAksQAK/zz7sdGxFed59HPnMGjvA46pnyDeBZrKyGYlpYdQvJY4PSRgFPcsIh
 PmLKLEschymgsH3Nto8mHZQCFe55veIolJonx7yYCGE/0jYjRzU6x2wynrGuTYc9Q+EfT5uNn
 rM2uir2x57wbN4dEdcxCd6KzQV+RvWx2mMxPb2AaYz6D2e0QSpMcaXbpPIkcoy9Ny4dRwWPxS
 NIfmUqSKMCyOZZnyhEnwvn233C8JKKLmZsMpCFG2vgx/QphLyE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 6:10 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Apr 28, 2020 at 04:49:15PM +0200, Arnd Bergmann wrote:
> > ==> build/x86/0xFD7B7323_defconfig/log <==
> > arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x991: unreachable instruction
>
> This warning looks correct, did you make a change to entry_64.S?

I bisected my local patches and found that I had a local hack that turned
off CONFIG_RETPOLINE for testing something unrelated. I can reproduce
it on linux-next with this patch:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -447,8 +447,7 @@ config GOLDFISH
        depends on X86_GOLDFISH

 config RETPOLINE
-       bool "Avoid speculative indirect branches in kernel"
-       default y
+       def_bool n
        select STACK_VALIDATION if HAVE_STACK_VALIDATION
        help
          Compile kernel with the retpoline compiler options to guard against

> > ==> build/x86/0xE0F2ACFF_defconfig/log <==
> > kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
> >
> > ==> build/x86/0x2EA4CE4F_defconfig/log <==
> > kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled
> > kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled
> >
> > ==> build/x86/0x500B1B82_defconfig/log <==
> > kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x1269: call
> > without frame pointer save/setup
>
> I'll look into these.

Thanks!

    Arnd
