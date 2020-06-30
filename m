Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80955C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5909F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgF3TZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:25:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3TZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:25:22 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mi2eP-1jCK6T3JM9-00e1cG; Tue, 30 Jun 2020 21:25:20 +0200
Received: by mail-qv1-f49.google.com with SMTP id t7so9813284qvl.8;
        Tue, 30 Jun 2020 12:25:20 -0700 (PDT)
X-Gm-Message-State: AOAM533XNKdCu/boRlQlXHXOgCTzD9NSlo4eeDbnYZu/cr0B8NYTaFHE
        9kAOGVwZ4OFtu541UoXHbVqGl9X39c9TuPRHP0U=
X-Google-Smtp-Source: ABdhPJx+lRE51JRL6fCvRnoLPfTGDuD4BIZlGSJkoIdVSw7mHYOQQlzJvl0jgp7ZS50oAcVKQOmUzXKXW4PZLLmEroY=
X-Received: by 2002:a0c:ba0e:: with SMTP id w14mr21638836qvf.222.1593545119567;
 Tue, 30 Jun 2020 12:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 21:25:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
Message-ID: <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PHrO9izh4NNAQ0DpLs98Zi/cmfDRago2QI2t67m75yidnuOuK1y
 dRxsXcxsm8wiJuINEL+rhy5rzZ8DT7OLpRDD4XWCtmuiZIVsTQIEa6bq5gS71Un2O3OcJHZ
 VfoV4oxYRtJqd4TkIACF5ShEMlDu3Hb0fOa1W4wbIc0m72JV6V4P/vC5u23vyq3Hli5m6/f
 jHHhY9bmP4fbJwEHOtNhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W9+Tl/3NP3s=:dK9mjkydT8Mu8YiyXNKw+P
 qMs16YMejU0ODuWFv4qZ7ZlYlXkk4wHvecKoE0ODcvPYYXQPwS3c+CypwJnSnD1U87WKEvMcG
 cvirPkAQxR9sFbpxIRmCs0kVpvD+MLji7qeO19Jnv4OhJ4CsWfTI+oQFPMApbwvROvgmMUeiQ
 AdppnErFNSz2rcEruYJLcr8U8k9YSSb+sSxcgu+VU2wOqFqFB/PwVuNWPAXH9O7bjmk9zEh8+
 VgC49SQLnZcASQPNT0GNV6jPLGnH1e/OcU4A/6hdw9cV7gp2KjKAutsz3/I20S/s0o4HfjlyQ
 2joKjxMfWZeBTJZKY5BF/qJ3TCKudf1x1bHl7FJAJ+t763jGm39elvBO91wXb/THJ3R8juijS
 37LrD2jGWf5AGD7fyjvqXUIgg5QTRGykMqKt8TxOMdasC3cYWX/SXSfgO5ZtMhc4/j6u0b1y+
 CSBUA7YbUJIKTnZnpJD5jeVtOCiIpUlLC9QbhULUDATrfO+vNb4I1EXvmKkSJk+q926QmPAIU
 SCneudOiwHSm/nAzqQxSo4Qu9YLVeGrXNfOnaH/2mA6EjEVAru7GbzgI9OkiW7Wb1xzGY7j1Y
 LNz27F9dI0FQUQ79+rqHOHMpf5U4ck9vZXu8/RxY9voYkRZqRBt3BbGzqQvhaXy86uK2C1/FT
 7WtGOCDvTZ5BhTDfvpJM0Q7rP4zDKiJEZYRbgCl58flOBx65B8BF+YoOZEjH4yQWT5R0AbpfK
 o+PS/GjIzHzpNli5uctSF96tEHsEN8B38ttqdfa6ddxlQxUbZnmEbRJ9IuA1mD1UXsu8376qj
 l46sp0RFk5uPfmb8K64fcC2sK9ypzulKt2To3lDVC4u2sagdFY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> +#define __READ_ONCE(x)                                                 \
> +({                                                                     \
> +       int atomic = 1;                                                 \
> +       union { __unqual_scalar_typeof(x) __val; char __c[1]; } __u;    \
> +       typeof(&(x)) __x = &(x);                                        \
> +       switch (sizeof(x)) {                                            \
...
> +       atomic ? (typeof(x))__u.__val : (*(volatile typeof(x) *)__x);   \
> +})

This expands (x) nine times (five in __unqual_scala_typeof()), which can
lead to significant code bloat after preprocessing if something passes a
compound expression into READ_ONCE().
The compiler works it out eventually, but we've seen an actual slowdown
in compile speed from this recently, especially on clang.

I think if you move the

        typeof(&(x)) __x = &(x);

line first, all other instances can use typeof(*__x) instead of typeof(x)
and avoid this problem. Once we make gcc-4.9 the minimum version,
this could be further improved to

       __auto_type __x = &(x);

       Arnd
