Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC3C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9E206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgMhYAYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgEERHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729209AbgEERHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:07:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:07:35 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o24so2635001oic.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwCBEJLwe7+6OV63AZ4GOUwDgwYhujIY1KxrxYevf8k=;
        b=AgMhYAYI7oAoN+75kXJTQfJ9xq+4PvF/xfadMC/kGz0bHK0cWBykACmtXpL2yg133v
         IxetqIswOnRfoQeEkVvvafM74+y59R9S9mXPGam75gzOQSBbyOJNGzZ9fSYJmQSSM7dM
         ke4i6aZQm5a8vwCRRp1rBwG8Z4F/VM4idvH7Qps/TFZF7g+9FjQ4+h7okAyFlR9wx4jO
         n5uAIpknyy4Hj7hMpFIqxJo4Ti2klvjCXoD0t4T8UZniP7vwPVCp4IS7ScrK3PiMcDXs
         4t4uRzxmPxZHwCkFnd3xg6egwy5pt07YK/j/7g8tEOijdeTuA1PR3NtmeEynQmd58Pf+
         FxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwCBEJLwe7+6OV63AZ4GOUwDgwYhujIY1KxrxYevf8k=;
        b=Wr/MJ7+v0jPOprAtePv64MJaFTXiY7kn3g1Ja6ioeEW8gmcSkB7XqnfdE1JYK3WOlV
         Wt5MfZl0oIwR61SXAoaN7F5yoSFPjey3DADu4JgD+5GLVxcbkkXZ4HqXTHnc/GOPKPbt
         ihV9ghsahdHMtMM9hzAEXubsCHlfo2ff/eTrMXEIr3FfYYnXaHMkuaEk2MiHBGpss7hm
         txA3z2Xn5Rcmk1R/ZYtvfWHhDLfIQMAPvrn3uUtfdJU9p9jaoIpb49t+p6iwTo4r34j8
         +kOeQ48wSCYxTY84cihd5GKYTg+0accAXk//LVEaaMZaDmFmoA15hRU6gwLg4FGL34SL
         Ygiw==
X-Gm-Message-State: AGi0PualGFuyjz8Vn1N4e9LOPWcb6TKC20YMEapqbtJwKsNuzvFgDivq
        FoVuJr+qy2Pwf/Ol/5SrQDD5p5B1Exox8kK8ITCvtw==
X-Google-Smtp-Source: APiQypJfG29VS70oZa7J3OZeMprXzjXSrYWiHd6+IM0iA5V1iEiRQGVpAuu2w/He9wLcHpoqlnBRZ8gOQodF2S7Yyyg=
X-Received: by 2002:aca:c646:: with SMTP id w67mr3335582oif.70.1588698454453;
 Tue, 05 May 2020 10:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de> <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
 <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com>
 <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com>
 <CANpmjNOE+GUG7O=WaJKQg6rdUOn+YMBhdS8enNWkD_8mdtaSBQ@mail.gmail.com> <CAK8P3a36w+QFqik_sHS3T5+_DZ7XP9Y5BYqT72pnjC67T9Sn3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a36w+QFqik_sHS3T5+_DZ7XP9Y5BYqT72pnjC67T9Sn3Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 19:07:22 +0200
Message-ID: <CANpmjNPCZ2r9V7t50_yy+F_-roBWJdiQWgmvvcqTFxzdzOwKhg@mail.gmail.com>
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

On Tue, 5 May 2020 at 17:29, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 5, 2020 at 5:20 PM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
>
> > > --- a/lib/Kconfig.kcsan
> > > +++ b/lib/Kconfig.kcsan
> > > @@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
> > >
> > >  menuconfig KCSAN
> > >         bool "KCSAN: dynamic data race detector"
> > > -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
> > > +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !(KCOV
> > > && CC_IS_CLANG)
> >
> > I wonder if we can just add this:  depends on !(KCOV &&
> > !$(cc-option,-Werror -fsanitize=thread -fsanitize-coverage=trace-pc))
> >
> > Similarly for UBSAN.
> >
> > That way, once Clang supports this combination, we don't need another
> > patch to fix it.
>
> Good idea. It probably get a little more complicated because kcov uses
> different flags depending on other options:
>
> kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)     += -fsanitize-coverage=trace-pc
> kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)    += -fsanitize-coverage=trace-cmp
> kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)          +=
> -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
>
> Do you have any preference on whether we should make KCSAN or KCOV
> conditional in this case? It may be easier to move the compiletime check
> into CONFIG_KCOV_ENABLE_COMPARISONS and
> CONFIG_CC_HAS_SANCOV_TRACE_PC.

Whichever is easier. I think if we have a config that tries to set
both, but then one gets silently disabled, it likely already breaks
the usecase. It'd be nice if there was a way to warn about only one
being selected so that a developer can then go back and choose the one
they're most interested in (or change compiler).

Thanks,
-- Marco
