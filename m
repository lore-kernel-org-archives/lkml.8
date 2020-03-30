Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283AFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EC920733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI/9ewfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgC3XpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:45:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46734 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3XpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:45:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so12372379ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7faki+qTbZqs1tnRTRPj5acryZpFgYEfa44xgtLKEwE=;
        b=GI/9ewfXOq8r19Fw5SLQmYoPVqPLWHO3LQpMWPujX5y7AjN7HUmgPIoVZuIENfFgj+
         EBonZFEuL4y0Oebgee4CRwZU70zmq0fti/iTpCDxrlDUAM15jzr7OAD44LXYAipbpXc2
         x3PDPTzzPP+ijcb+SKm0I3fbQ4uJNkk0pdX+P7CKp6WvPGg58ETxRH+zbwAzeDVuScqp
         jA62JQWgLOP/7GcNrsOINZ19RSkvfiGamKYMNy8my2GBuOPGKImPTbrYP+YmSMPswvzO
         TvMiXd2SFKgvTVLfvB0zf00VISfcMp+MHd0UOd2CaBzHwp5y4/FmEdHGy3balAhs79RP
         C1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7faki+qTbZqs1tnRTRPj5acryZpFgYEfa44xgtLKEwE=;
        b=RJtB02j7VlQUZQYxNGvG9QgMJj/5PZlowt4pL5Ij01U02GNFhYXRy2dNVoK9R0Bi54
         gh+pglq/wgqsJQkErKWh+/qGkNQKpslL+F+FZAk0hGFOloUw9ijIz1WJ8bAz0kQXLOIc
         mBGwXG2QRoweeo+liZZUxFZknHpx6dWh8CMrr3d/Zg/4/uDlb4vDq7OsNJzaFVVOwHkq
         nZCEIWdvVkrl0+FFMbJnvdeKWcs4GVcIimI+ARJG3od5wWFun3ZJol0tObpSsIEb+hgZ
         6dqVbOkzCa3CldAShh7i2YtkgLpm/+EI969NikTnp+KkBAUtKEmfIQEjl3rIzqt9GEMK
         nlvQ==
X-Gm-Message-State: AGi0PuY1D3eadnfQTO3MnCtLyqgtIR2OYo+f8vz/NRwYFCewEQzbPSmA
        BdTpity2bMyHrYHeUR+Zi5YWYLn2TY+aUlirgCE=
X-Google-Smtp-Source: APiQypLCM8cJDJ9zVLWI1qIYRbJ5+t1RUTkt6hluGNFvVabTrsqN7dQDoYZm85QVCjyM+dt0YVOVmNdRVfhvtIHT8WQ=
X-Received: by 2002:a2e:854e:: with SMTP id u14mr8037597ljj.182.1585611906854;
 Mon, 30 Mar 2020 16:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <1585156347-8365-1-git-send-email-orson.unisoc@gmail.com>
 <CA+H2tpE5Fe5zJKEUM7H9xT10+ZGKVmZ2Aa5D7j_eq7dvZyX5wA@mail.gmail.com> <b8119cba-e660-d831-1f09-f99641e3d938@akamai.com>
In-Reply-To: <b8119cba-e660-d831-1f09-f99641e3d938@akamai.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Tue, 31 Mar 2020 07:44:55 +0800
Message-ID: <CA+H2tpEdtLBMVif3hk5YOAd6oQLT2pjY3882p2S8PAGzu6Vv4A@mail.gmail.com>
Subject: Re: [RFC PATCH V2] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
To:     Jason Baron <jbaron@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>, joe@perches.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Orson Zhai <orson.unisoc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Mar 30, 2020 at 11:19 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 3/28/20 2:17 AM, Orson Zhai wrote:
> > Hi Jason,
> >
> > On Thu, Mar 26, 2020 at 1:13 AM Orson Zhai <orson.unisoc@gmail.com> wrote:
> >>
> >> Instead of enabling whole kernel with CONFIG_DYNAMIC_DEBUG, CONFIG_
> >> DYNAMIC_DEBUG_CORE will only make the basic function definition and
> >> exported symbols to be built without replacing pr_debug or dev_dbg
> >> to dynamic version unless DEBUG is defined for any desired modules
> >
> > How do you think about this idea?
> > Optionally enable dynamic debug of modules by the DEBUG macro.
> >
>
> Hi Orson,
>
> So I like the idea of being able to use pr_debug() as a way for modules to
> tie into dynamic_debug() without having to enable everything via
> CONFIG_DYNAMIC_DEBUG. However the 'DEBUG' already has a specific meaning
> which is to enable the printing or enable by default (can be turned off
> at run-time if CONFIG_DYNAMIC_DEBUG is set).

You are right. We'd better not to break user's experience in their
mind by new added
feature.

>
> So I think generally modules want the printing off by default. So maybe
> what we want is instead of:
>
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
>
> is:
>
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG_MODULE))
>
>
> That is introduce a new per-module definition I've called it
> 'DEBUG_MODULE' (perhaps we can name it better), that enables

How about use DYNDBG for this?
It will be consistent with dyndbg in boot command line parameters.

Best,
-Orson

> dynamic debugging without having to turn it on globally. Then,
> modules can in addition enabled 'DEBUG' if they want all the printing
> on by default.
>
> Thanks,
>
> -Jason
>
>
> > Best Regards,
> > -Orson
> >
> >> together by users.
> >>
> >> This is useful for people who only want to enable dynamic debug for some
> >> specific kernel modules without worrying about whole kernel image size will
> >> be significantly increased and more memory consumption caused by CONFIG_
> >> DYNAMIC_DEBUG.
> >>
> >> Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
> >> ---
> >> Changes from V1:
> >> - Rewrite commit message for more generic usage.
> >> - Add combination use of CONFIG_DYNAMIC_DEBUG_CORE and DEBUG to enable
> >>   dynamic debug seperately.
> >> - Ignore empty _ddtable and return success when only the core is enabled.
> >> - Fix all typoes.
> >>
> >>  include/linux/dev_printk.h    |  6 ++++--
> >>  include/linux/dynamic_debug.h |  2 +-
> >>  include/linux/printk.h        | 12 ++++++++----
> >>  lib/Kconfig.debug             | 18 ++++++++++++++++++
> >>  lib/Makefile                  |  2 +-
> >>  lib/dynamic_debug.c           |  9 +++++++--
> >>  6 files changed, 39 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> >> index 5aad06b..ed40030 100644
> >> --- a/include/linux/dev_printk.h
> >> +++ b/include/linux/dev_printk.h
> >> @@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
> >>  #define dev_info(dev, fmt, ...)                                                \
> >>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
> >>  #define dev_dbg(dev, fmt, ...)                                         \
> >>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>  #elif defined(DEBUG)
> >> @@ -181,7 +182,8 @@ do {                                                                        \
> >>         dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
> >>  #define dev_info_ratelimited(dev, fmt, ...)                            \
> >>         dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
> >>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>  #define dev_dbg_ratelimited(dev, fmt, ...)                             \
> >>  do {                                                                   \
> >> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> >> index 4cf02ec..abcd5fd 100644
> >> --- a/include/linux/dynamic_debug.h
> >> +++ b/include/linux/dynamic_debug.h
> >> @@ -48,7 +48,7 @@ struct _ddebug {
> >>
> >>
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
> >>  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> >>                                 const char *modname);
> >>  extern int ddebug_remove_module(const char *mod_name);
> >> diff --git a/include/linux/printk.h b/include/linux/printk.h
> >> index 1e6108b..44d5378 100644
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -292,7 +292,8 @@ extern int kptr_restrict;
> >>   * These can be used to print at the various log levels.
> >>   * All of these will print unconditionally, although note that pr_debug()
> >>   * and other debug macros are compiled out unless either DEBUG is defined
> >> - * or CONFIG_DYNAMIC_DEBUG is set.
> >> + * or CONFIG_DYNAMIC_DEBUG is set, or both CONFIG_DYNAMIC_DEBUG_CORE and
> >> + * DEBUG is defined.
> >>   */
> >>  #define pr_emerg(fmt, ...) \
> >>         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> >> @@ -327,7 +328,8 @@ extern int kptr_restrict;
> >>
> >>
> >>  /* If you are writing a driver, please use dev_dbg instead */
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
> >>  #include <linux/dynamic_debug.h>
> >>
> >>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> >> @@ -453,7 +455,8 @@ extern int kptr_restrict;
> >>  #endif
> >>
> >>  /* If you are writing a driver, please use dev_dbg instead */
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
> >>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>  #define pr_debug_ratelimited(fmt, ...)                                 \
> >>  do {                                                                   \
> >> @@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
> >>
> >>  #endif
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_CORE) && defined(DEBUG))
> >>  #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
> >>                              groupsize, buf, len, ascii)        \
> >>         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 69def4a..8381b19 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
> >>         default n
> >>         depends on PRINTK
> >>         depends on DEBUG_FS
> >> +       select DYNAMIC_DEBUG_CORE
> >>         help
> >>
> >>           Compiles debug level messages into the kernel, which would not
> >> @@ -164,6 +165,23 @@ config DYNAMIC_DEBUG
> >>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
> >>           information.
> >>
> >> +config DYNAMIC_DEBUG_CORE
> >> +       bool "Enable core functions of dynamic debug support"
> >> +       depends on PRINTK
> >> +       depends on DEBUG_FS
> >> +       help
> >> +         Enable this option to build ddebug_* and __dynamic_* routines
> >> +         into kernel. If you want enable whole dynamic debug features,
> >> +         select CONFIG_DYNAMIC_DEBUG directly and this option will be
> >> +         automatically selected as well.
> >> +
> >> +         This option can be selected with DEBUG together which could be
> >> +         defined for desired kernel modules to enable dynamic debug
> >> +         features instead for whole kernel. Especially being used in
> >> +         the case that kernel modules are built out of kernel tree to
> >> +         have dynamic debug capabilities without affecting the kernel
> >> +         base.
> >> +
> >>  config SYMBOLIC_ERRNAME
> >>         bool "Support symbolic error names in printf"
> >>         default y if PRINTK
> >> diff --git a/lib/Makefile b/lib/Makefile
> >> index 611872c..2096d83 100644
> >> --- a/lib/Makefile
> >> +++ b/lib/Makefile
> >> @@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
> >>
> >>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >>
> >> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> >> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> >>
> >>  obj-$(CONFIG_NLATTR) += nlattr.o
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index c604091..34f303a 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> >> @@ -1014,8 +1014,13 @@ static int __init dynamic_debug_init(void)
> >>         int verbose_bytes = 0;
> >>
> >>         if (__start___verbose == __stop___verbose) {
> >> -               pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> >> -               return 1;
> >> +               if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
> >> +                       pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> >> +                       return 1;
> >> +               }
> >> +               pr_info("Ignore empty _ddebug table in a core only build\n");
> >> +               ddebug_init_success = 1;
> >> +               return 0;
> >>         }
> >>         iter = __start___verbose;
> >>         modname = iter->modname;
> >> --
> >> 2.7.4
> >>
