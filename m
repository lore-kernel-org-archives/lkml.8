Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B65520675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgEEO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:59:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgEEO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:59:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MsHwC-1jHC0u2cLi-00tn7t for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 16:59:38 +0200
Received: by mail-qk1-f172.google.com with SMTP id n14so2532077qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:59:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuabN9nQlHCgPXPtj1+ir2eBU2NO2vau6XtR7t4mVfDrLPE+a5Wi
        5Cfy4astOxR/f8gS0kfiP1eJIMhqRsbdBMsorpk=
X-Google-Smtp-Source: APiQypJi/76QhRVdc+yW/pYu2L2GnXBV94TIXhJN+xU3dR7NHMQQ/moHBExDNnsaZW9gUGLCHjavVQrKeC2MV+cv6Qs=
X-Received: by 2002:a37:a492:: with SMTP id n140mr4097616qke.352.1588690777455;
 Tue, 05 May 2020 07:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de> <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
 <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com>
In-Reply-To: <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 16:59:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com>
Message-ID: <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com>
Subject: Re: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qFFk2RLj/uY71OHUiaA14GzvWqBW6SDJYA1ReCU22/4VkQRc5Gp
 Z2UnsiGtBxv0IONeNhCkmVrnW14KT29cg7s7TrhN7AZn2F4ZKT3O1IAKhqUnSf56uGhpCXX
 +vi3wYOlnXdTOmAb4/ckwQ7wQUYl+Clzga8yqCmJXTsDv8ph8Z3Va2n8YAxuqJdYgK0PyyQ
 CbbGh+eNqNc0MVEo6LkTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBph94ODDzQ=:sPIeU8ZJENhFlgwSAXjHdM
 ZP+TUngWYziWKxCESqx8ogD/CmzWXuEzyuDvlbHE3lc4cdvckXUbJpwasvGRz6JpTlXz9qLn3
 vNIz0kYGrceAVNsfU0jiLlMSvTaRBMe2UvmlGNgW0p+Dk4k/WxAeY354JIJCxE7Cg+vHjjyv/
 1doCEqVAsB1AUThS3l0c9yerNYQ78KgpkN9TMmUdqs7Q7AxUc78a99C/yT0nNqwWu7IEt4U0r
 O8EKqYtdkVZ7R3tzeeRgHkU+bfnWk2hy6ncTflznS1zzJ8ZsIEs87S55hQKSP/qWN6caqGJwN
 SFiFzzRsHdbTN7coSLA8WoRJuNlLtgDSnKyX+vm0qejREPnYgtiQqPb5gqzVAJmQcXqdpMEpQ
 DLMGgL6g2QNid7z7f/gn446UlpE/TN2y1pWFXUSFxvhBOk4f7vx20tsMRDKqq7UGd/HVWr1LO
 yF75NKuKA1GinSiTBXuinpJC0XIFfykyr+/CEIlwdl/f3CNlqdDvrairhPIsaRAStKJIIsA1o
 4hFhZwXh32NxnS2wgu38gC7qDpbSboN4Sm1UVCvxBU46B73R2JWOpEk37gsdsXhvaxc+9k2IU
 44OeggTwM4wxhoJrTjhIbiVZdgYuuJSc2/46NsTqCsmVWQiRWaskVKgUFVN/fsFCsHhRBK3L/
 1smJmuZL+yzP9KEKzY27vNkK2bIWAPs4VgyZMzF0ff5Cy53cjigdVnjM7tpEYAIZXuUryiUSK
 q5hEJ4EKhvSvigZdVqIfYx7OvmY4VQaJwSG6s+4NF/xJMFAT10J1ukiOb+AClTmEN0/10nxxc
 UJ0NN9v2w8GXEJ2Qh+s+5/uoyiCgvffdqIRld90Nk0eAONXQZc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:50 PM 'Dmitry Vyukov' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Tue, May 5, 2020 at 4:36 PM Marco Elver <elver@google.com> wrote:
> > > Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> > > with -fsanitize=bounds or with ubsan:
> > >
> > > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> > > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
> > >
> > >  menuconfig KCSAN
> > >         bool "KCSAN: dynamic data race detector"
> > > -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> > > +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
> >
> > This also disables KCOV with GCC. Why does this not work with KCSAN?

My mistake, this should be kept enabled for gcc. If we can get the combination
to work in clang, that's something that should also get enabled.

> > This is a huge problem for us, since syzbot requires KCOV. In fact
> > I've always been building KCSAN kernels with CONFIG_KCOV=y (with GCC
> > or Clang) and cannot reproduce the problem.

I have some local patches that change the way we pick the warning options
for each compiler, and enable more of the warnings that are normally disabled.

Maybe -Wunused-command-line-argument is disabled by default?
I only started seeing this problem recently. It's also possible that there
are some other options that interact with it so only Kcov+FOO leads to
KCSAN being ignored.

> > Ditto, we really need KCOV for all sanitizers. I also just tried to
> > reproduce the problem but can't.
> >
> > Which version of clang is causing this? I'm currently using Clang 9.
> > My guess is that we should not fix this by disallowing KCOV, but
> > rather make Clang work with these configs.
> >
> > Dmitry, can you comment?
>
> FWIW I can reproduce both with clang:
>
> $ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds
> clang-11: warning: argument unused during compilation:
> '-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]
>
> $ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
> clang-11: warning: argument unused during compilation:
> '-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]
>
> with both my disto's 9.0.1 and fresher 11.0.0
> (7b80cb7cf45faf462d6193cc41c2cb7ad556600d.
>
> But both work with gcc
>
> $ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
> $ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds
>
> Is it a known issue in clang?
>
> Can we somehow disable it only for clang and not gcc?
>
> This will immediately break KCSAN on syzbot as it enables KCSAN and KCOV:
> https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce

I can respin the patch with this fixup if you like:

--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN

 menuconfig KCSAN
        bool "KCSAN: dynamic data race detector"
-       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
+       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !(KCOV
&& CC_IS_CLANG)
        select STACKTRACE
        help
          The Kernel Concurrency Sanitizer (KCSAN) is a dynamic

As you both say, the combination seems to be quite important, so maybe there
is something else that can be to also enable it with clang.

      Arnd
