Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A538C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76202206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgEEP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:29:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgEEP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:29:14 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N4i3d-1j6vcM1OR5-011hLo for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 17:29:13 +0200
Received: by mail-qk1-f171.google.com with SMTP id t3so2708313qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:29:13 -0700 (PDT)
X-Gm-Message-State: AGi0Pub9vNLVkkV5nOTNWRycAHBPZYj6sGmwid95hn5R0fdu2VbNCqei
        TFIcpr++LXSUf5khJ+knt4Et0a+bb/kxE6kmTms=
X-Google-Smtp-Source: APiQypKAatSudP8aUlQtpECyiIhS5dMTJTbNMrIUHmJFtKEtt151ryEXaQP5JMg42FXgb88XoxDiySGwQlzjdXW+i50=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr3905009qke.3.1588692552175;
 Tue, 05 May 2020 08:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de> <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
 <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com>
 <CAK8P3a23XzLhZQNuFbeQhaSNru1abPwXV_mXR_P6N6Dvxm6jFw@mail.gmail.com> <CANpmjNOE+GUG7O=WaJKQg6rdUOn+YMBhdS8enNWkD_8mdtaSBQ@mail.gmail.com>
In-Reply-To: <CANpmjNOE+GUG7O=WaJKQg6rdUOn+YMBhdS8enNWkD_8mdtaSBQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:28:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36w+QFqik_sHS3T5+_DZ7XP9Y5BYqT72pnjC67T9Sn3Q@mail.gmail.com>
Message-ID: <CAK8P3a36w+QFqik_sHS3T5+_DZ7XP9Y5BYqT72pnjC67T9Sn3Q@mail.gmail.com>
Subject: Re: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
To:     Marco Elver <elver@google.com>
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
X-Provags-ID: V03:K1:Smh/UD1h+RCatZUNh5fAt4NdOdRLO2xoRL8DVAvW2SR5yA27ihp
 wd95R9B7Q4grRRSt57pSWM2839NHsjnDFKpgd5/wTvqlL8XZf58ymUDUyEe97Jz1gFaYn3b
 z1s+pwCeuaMq4lEjCJl1/vMhP0ZoQcOuz0WQ07/VuZg74q+4skF35iutbiBsWL3Zp445nZ+
 iEbMi61YGB6k4/RcQveoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BsAAcAL5tts=:ZQhyVcdDkNSCeAYivkFOPj
 m089480LrJwsc2an4TYFDqh3Ujfa7EkEoRj7UlP/IXnHG8tMiCDxKk5cbHWKvNNZvIGrElk1a
 imQzrgu+311UKTjyaH9N6GCMKm48iyQAt0eD8vvhA1D/c76ZN3guwtUDiNmmPgcH2Nhw2LlDv
 xp7v2Yyxb4+CokhXrX1kTyBsOs46axbWG3UecsRUxRVV4PZg81Ncgy0pl6pXfS4RsDtXES1Am
 JP3Q7zN9Rgk5nMFVwPLzc7EZe8DXKNikhwcF9ncHCDirbMQPkrSlsox/U1L48f/pFFgFof+oO
 P26BuWp3h5lzkjsYz5mcIVI9ja5EoHwFLGVepwdcxrdx3LWfXze9iUPZLwHIrxiV9KUmk7dLC
 5FJc+IxAwXRuZ4UKI2zkHeCIU5I/Naaro0XfOeCOEeLe9ZEx8bLcUHnF6sriUxrK0wPu5Itf7
 xZpYX4TS+jaHmaIN/R5h1ZtBRlsGeyzh71PFXxI3NeKDSMLyRb06YiSLDEUsiJj7Fn4uDzOIS
 owOKD96k85Oo4p1lBhkYe6LXmf/nwKfeerGarm7GCMcQOnIBb6/PIaA0cI3V6TYcNSFIgj97y
 Vbqz+8UpSrYFyKLvXJUMGBkGc3MQoYf/tdag4U4a4duG6NlKr8o9OZIsaAtJTU2SoTf7AnkN6
 aqj44Dta+LOPZqvE1FWfZrqr4kQu+AIKXvFxFECYowXwZeiy7HtYYLm9/XGg2jTYL4jDYeGfb
 BvP/M8NdhTzvY36b5paw4CDBm9UL3ZAfE9MQiP1Cv3QGBOVMm+IoLb5N8JNvNPzC/ub3ERHMy
 uTHHzaHVfr1oGMo+0DyocY0EPUQt0DJrLfuVhkVLe+ORAcBpvE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 5:20 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:

> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
> >
> >  menuconfig KCSAN
> >         bool "KCSAN: dynamic data race detector"
> > -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
> > +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !(KCOV
> > && CC_IS_CLANG)
>
> I wonder if we can just add this:  depends on !(KCOV &&
> !$(cc-option,-Werror -fsanitize=thread -fsanitize-coverage=trace-pc))
>
> Similarly for UBSAN.
>
> That way, once Clang supports this combination, we don't need another
> patch to fix it.

Good idea. It probably get a little more complicated because kcov uses
different flags depending on other options:

kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)     += -fsanitize-coverage=trace-pc
kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)    += -fsanitize-coverage=trace-cmp
kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)          +=
-fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so

Do you have any preference on whether we should make KCSAN or KCOV
conditional in this case? It may be easier to move the compiletime check
into CONFIG_KCOV_ENABLE_COMPARISONS and
CONFIG_CC_HAS_SANCOV_TRACE_PC.

      Arnd
