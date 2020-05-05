Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B52C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D28720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxBGwppW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgEEPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729951AbgEEPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:20:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:20:14 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so1923170otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8efal+sgU1en3J4nQ9rg/ceJ49rrnhyDi/kAbpO9w0=;
        b=lxBGwppWljXJZO33BcCG8KoqAAmjWhtBl+eWw/n4r5atXyD/OKHd5SxYHZx5Sn8phF
         JDk/tpvNCpaXGAo2Bv8uB1pDdzg72+GOZQVnmEcBcuzaPt242hiYIcMeYeNoV4EV4G9f
         NwKVxQ0zuL3cSe8AzienovyKPEGN0k3RabrTMc8LqClPjwWx5E5BM+vva5UQvF2+Mh7M
         DjkxjvIJuUFOr+lbK8Evyk10L4jkQ0QwxPfSPPvPZgbCgmgGhrvDRZnpK1wSnnIgzJbs
         VHS5rDEJ7wRbfQSE1cwPrFJbYMbrZQ/gbC8AoXgsxjm2E3JaRKEhsC/f6AI8D6rS+OMy
         kJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8efal+sgU1en3J4nQ9rg/ceJ49rrnhyDi/kAbpO9w0=;
        b=jp+ARHxqjiVtOtCDx+eSMYFCs9ce1fYCpkUu0CeG942EfmX4jriSEn0OlDNngAo0Yy
         ONvan5HbIys4rPoBScbBnCopR79qVrPu7qZZ0SPYe4ChkPM2Gk5Hhl9S+A84FR5KR60r
         9PONTdIYTgtGp0n/02Ycl+tGEbSrxguTQzeuuBpJLDa2Yg4S9UHi1+JnPYCPd+IQwWWF
         /E0zYcDoqhJsXMPE8VAqAJ8SHZVcWUCN9u7acJ8hl6QQ5EQYcs1TeuKYcsJLnCAlvSwp
         krDFMneXAKnFMXl0IJWEcBZ5w3f4B40QFNejMbRFJq1mKlgZVisNwJkM4+Z64OTGXkjU
         iQOw==
X-Gm-Message-State: AGi0PuYpuldFDjWdAH0hKd7hpesfSYmRjfnc+/CEKkYadNz7HInCpQT+
        rtrF502klu8Q0JIaui2PgIOoFZ38Ui1cYrQu4p7jsA==
X-Google-Smtp-Source: APiQypLwXOUqn3+C8eU3KpIVewgquQ7RlElMmwoTJNU9i9gYwxhLPbNOcFoOfjuDD/piS63oaY71amxzeEjB4MuCHSc=
X-Received: by 2002:a9d:509:: with SMTP id 9mr3055453otw.17.1588692013635;
 Tue, 05 May 2020 08:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de> <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
 <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com> <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com>
In-Reply-To: <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 17:19:58 +0200
Message-ID: <CANpmjNOE+GUG7O=WaJKQg6rdUOn+YMBhdS8enNWkD_8mdtaSBQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 16:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 5, 2020 at 4:50 PM 'Dmitry Vyukov' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> > On Tue, May 5, 2020 at 4:36 PM Marco Elver <elver@google.com> wrote:
> > > > Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> > > > with -fsanitize=bounds or with ubsan:
> > > >
> > > > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> > > > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
> > > >
> > > >  menuconfig KCSAN
> > > >         bool "KCSAN: dynamic data race detector"
> > > > -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> > > > +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
> > >
> > > This also disables KCOV with GCC. Why does this not work with KCSAN?
>
> My mistake, this should be kept enabled for gcc. If we can get the combination
> to work in clang, that's something that should also get enabled.

See my suggestion below how we might dynamically determine if the
combination is supported.

> > > This is a huge problem for us, since syzbot requires KCOV. In fact
> > > I've always been building KCSAN kernels with CONFIG_KCOV=y (with GCC
> > > or Clang) and cannot reproduce the problem.
>
> I have some local patches that change the way we pick the warning options
> for each compiler, and enable more of the warnings that are normally disabled.
>
> Maybe -Wunused-command-line-argument is disabled by default?
> I only started seeing this problem recently. It's also possible that there
> are some other options that interact with it so only Kcov+FOO leads to
> KCSAN being ignored.

I see. It certainly seems quite bad if one or the other option is
effectively ignored.

> > > Ditto, we really need KCOV for all sanitizers. I also just tried to
> > > reproduce the problem but can't.
> > >
> > > Which version of clang is causing this? I'm currently using Clang 9.
> > > My guess is that we should not fix this by disallowing KCOV, but
> > > rather make Clang work with these configs.
> > >
> > > Dmitry, can you comment?
> >
> > FWIW I can reproduce both with clang:
> >
> > $ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds
> > clang-11: warning: argument unused during compilation:
> > '-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]
> >
> > $ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
> > clang-11: warning: argument unused during compilation:
> > '-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]
> >
> > with both my disto's 9.0.1 and fresher 11.0.0
> > (7b80cb7cf45faf462d6193cc41c2cb7ad556600d.
> >
> > But both work with gcc
> >
> > $ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
> > $ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds
> >
> > Is it a known issue in clang?
> >
> > Can we somehow disable it only for clang and not gcc?
> >
> > This will immediately break KCSAN on syzbot as it enables KCSAN and KCOV:
> > https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
>
> I can respin the patch with this fixup if you like:
>
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
>
>  menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
> -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
> +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !(KCOV
> && CC_IS_CLANG)

I wonder if we can just add this:  depends on !(KCOV &&
!$(cc-option,-Werror -fsanitize=thread -fsanitize-coverage=trace-pc))

Similarly for UBSAN.

That way, once Clang supports this combination, we don't need another
patch to fix it.

Thanks,
-- Marco

>         select STACKTRACE
>         help
>           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
>
> As you both say, the combination seems to be quite important, so maybe there
> is something else that can be to also enable it with clang.
>
>       Arnd
