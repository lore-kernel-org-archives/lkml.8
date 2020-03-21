Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E0C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C3B2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLC2bkd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCUEZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 00:25:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36779 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUEZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 00:25:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id s1so6143440lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPjvRjB9mS6/mLTE7KSZUdyp+PxTNmulH6mUWSEICho=;
        b=hLC2bkd3HN0Vi7czuBirbBPQDScO2DikGIDWVlQ55uWctTNTGqol26EOnbV2A/G4vP
         qCZ5d7A9s/kFvdUr6KPKS86LuO9B90q0bBdq/vHBoSz5a+5Y/5CylpbQE24FnK4MaXIA
         RKiAhhXmcFPvrv1YeIdrNqw9jL8Nb43pBSXXO1lAV9+NYPkgbMiD405AJlXBjJg4oB6B
         yis6E/zjyQa/GwEtQiAlEBwA+2Rg4Hlc+KbIlAnrP+46aICMuig4RUktyEmysapanq8X
         b6HzkpEavewd5dRhx1Hn8Id3hByl2MZjVPvXQP29DZcdNW3hXObl9kLicMHB7TiSA5Zn
         iTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPjvRjB9mS6/mLTE7KSZUdyp+PxTNmulH6mUWSEICho=;
        b=qQ+TIgns7xN9u9ZtmaGe0sucApoy5WDrRBpGkxDGxT3y9jW6p8hIpmuKUh8Dd3PfTT
         2d15Qz1vw4ScBU5JzNPHzrjZB7ebIsbcjZAsK4BhzUERxuVctDeEywzD/CmGf71jx0BZ
         gY0EGKkGcEz+AnBSD6DtzD5ERhhetUhkj7+D+TEZRerhX3WxviihO/5v2j7cfLaFfwSz
         KYOsz4giYXuL38KepFpPPokYQGenGvtwrOpmJ0CDsJtz5nC/A3epjoMRZrLk2vEjPBLL
         XDkmai+ImJLHUK3HOG5LSTrotWMiYc1rvrwAeJNmGlrq6fNWHVh7rFNIgSN/l54aZB6M
         yy3Q==
X-Gm-Message-State: ANhLgQ0GtS2w/B2UZsH8k6L3+HXLwTC1ETj50QvVQeMan0/FVe5hyBIH
        hVqBr1WJJOvfKZ8Gg63YBz4ecLkDbbHvq6GrCUY=
X-Google-Smtp-Source: ADFU+vvO8VkNVcgioFGI927I7iM81fSfR7vyT4gM/3ENs+wY4lX2RuRKeoHE1sIAokk4V0oRgzTNUmgG8TPoSb7yX34=
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr2497635lfq.16.1584764730836;
 Fri, 20 Mar 2020 21:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com> <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
In-Reply-To: <51568376-da8b-3265-ddb3-6ddba74207dc@akamai.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sat, 21 Mar 2020 12:25:19 +0800
Message-ID: <CA+H2tpHL0NHipiT1cnUbRYFKoxDsbU1BHRGmLjA=diUw-H3Pgw@mail.gmail.com>
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
To:     Jason Baron <jbaron@akamai.com>
Cc:     Orson Zhai <orson.unisoc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Mar 19, 2020 at 5:18 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 3/18/20 3:03 PM, Orson Zhai wrote:
> > There is the requirement from new Android that kernel image (GKI) and
> > kernel modules are supposed to be built at differnet places. Some people
> > want to enable dynamic debug for kernel modules only but not for kernel
> > image itself with the consideration of binary size increased or more
> > memory being used.
> >
> > By this patch, dynamic debug is divided into core part (the defination of
> > functions) and macro replacement part. We can only have the core part to
> > be built-in and do not have to activate the debug output from kenrel image.
> >
> > Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
>
> Hi Orson,
>
> I think this is a nice feature. Is the idea then that driver can do
> something like:
>
> #if defined(CONFIG_DRIVER_FOO_DEBUG)
> #define driver_foo_debug(fmt, ...) \
>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #else
>         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #enif

I am thinking this again.
Why don't we add a local macro ( I mean not like the global macro from
Kconfig ) just like the DEBUG macro?
Say DDEBUG or DYN_DEBUG.

We can add this to printk.h to let module owners decide when & which
module should be dynamic debugged?
#ifdef CONFIG_DYNAMIC_DUBUG || DDEUG
.....

Module owner can add this to his module's Makefile, for example:
....
ccflags-$(CONFIG_UFS_DEBUG)    += -DDDEBUG
....
This will enable macro replacement for even a single c file.

How do you think about it?

Best,
-Orson

>
> And then the Kconfig:
>
> config DYNAMIC_DRIVER_FOO_DEBUG
>         bool "Enable dynamic driver foo printk() support"
>         select DYNAMIC_DEBUG_CORE
>
>
> Or did you have something else in mind? Do you have an example
> code for the drivers that you mention?
>
> Thanks,
>
> -Jason
>
>
> > ---
> >  include/linux/dynamic_debug.h |  2 +-
> >  lib/Kconfig.debug             | 18 ++++++++++++++++--
> >  lib/Makefile                  |  2 +-
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> > index 4cf02ec..abcd5fd 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -48,7 +48,7 @@ struct _ddebug {
> >
> >
> >
> > -#if defined(CONFIG_DYNAMIC_DEBUG)
> > +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
> >  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> >                               const char *modname);
> >  extern int ddebug_remove_module(const char *mod_name);
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 69def4a..78a7256 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -97,8 +97,7 @@ config BOOT_PRINTK_DELAY
> >  config DYNAMIC_DEBUG
> >       bool "Enable dynamic printk() support"
> >       default n
> > -     depends on PRINTK
> > -     depends on DEBUG_FS
> > +     select DYNAMIC_DEBUG_CORE
> >       help
> >
> >         Compiles debug level messages into the kernel, which would not
> > @@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
> >         See Documentation/admin-guide/dynamic-debug-howto.rst for additional
> >         information.
> >
> > +config DYNAMIC_DEBUG_CORE
> > +     bool "Enable core functions of dynamic debug support"
> > +     depends on PRINTK
> > +     depends on DEBUG_FS
> > +     help
> > +       Enable this option to build ddebug_* and __dynamic_* routines
> > +       into kernel. If you want enable whole dynamic debug features,
> > +       select CONFIG_DYNAMIC_DEBUG directly and this option will be
> > +       automatically selected.
> > +
> > +       This option is selected when you want to enable dynamic debug
> > +       for kernel modules only but not for the kernel base. Especailly
> > +       in the case that kernel modules are built out of the place where
> > +       kernel base is built.
> > +
> >  config SYMBOLIC_ERRNAME
> >       bool "Support symbolic error names in printf"
> >       default y if PRINTK
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 611872c..2096d83 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
> >
> >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >
> > -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> > +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> >
> >  obj-$(CONFIG_NLATTR) += nlattr.o
> >
