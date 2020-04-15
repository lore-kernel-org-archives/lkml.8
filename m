Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9767A206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIMMgUiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416114AbgDOQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416090AbgDOQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:31:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B14C061A0C;
        Wed, 15 Apr 2020 09:31:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so4409340ljd.3;
        Wed, 15 Apr 2020 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biHfX7TxS2hrvsT9EkKm+1lGlRvqJ7rczB0q5SleTWQ=;
        b=EIMMgUiRVPldnHv6wMoU2kJK7GOMXnX6c10K+uNYLsE9NjTVLjFIxIP4y3SaEysC84
         5ednjSwjFDBjXmwORcR1cTu0UK0BOUyHqWQYFDrg/IC9W/+TyDKyBw/lyrBraEJr0quL
         IC1QlIsymRx83Qfc5M/HKUbKGpWQsZJldZZXB7PfocUbGua+bbPH/ODCr3ZKFgao2Hk6
         cE1lqUg1eaPHvFrNM/IB9SNi7Px7LWeVkJSRcyqNKdMUneQWH/NGsgcuX6peb4iBAwaq
         ugRwh0bRKcnVIlbltScyVD5xiCislpbMQt1dsB0QICZu5G5wdWRaga+N5lS60/8ZDp5+
         gVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biHfX7TxS2hrvsT9EkKm+1lGlRvqJ7rczB0q5SleTWQ=;
        b=MSBjh9o6lCjKGvUQQxC/d9Ofjl989yfe4qK9tiV3QUG5HyC4PgI7zQzrqNQR4RbOMU
         OHOLzVKgK5tF9sTTfAU0kTUvdE1VYrnAvk5w3hEesXOOIH559gMAdnZiBhE3FbNn1YcI
         P/4+oZcv12ddYF5Axiuz36RzmblYhhmnw/byoYlXkryCBAwi+gO7hpY2KDnKQHoWFAOl
         IGI02x17S77abwzrP7sbT8uVoPBlZLG0fin7y6ZntQ6yikYu4pWY9rYAQ61x9HyzqJ2p
         W+fVH3TH41cPKzAHIVLeJfvbF0bG6IR0TYpCoV2YuFDx7+qaqe7gBwunLmi84/3WCCce
         2FFQ==
X-Gm-Message-State: AGi0PuZRLvs1+CQJDiqiRf3ltjMYT6E1K7r+fj9tB0JvCtzGJxgs6l6z
        3DbDkXHIswKvNzDJH/4wwAn35JpD0/iaucqP5JU=
X-Google-Smtp-Source: APiQypIgJN8yNlYln75HND4ry9FlXmCJYwvhO3dcPcv6YMkNil3W3z3GW/QMglZSYyv0ilSdIyuKVj9txv2THaiExaU=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr3667624ljh.258.1586968294453;
 Wed, 15 Apr 2020 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
In-Reply-To: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Thu, 16 Apr 2020 00:31:22 +0800
Message-ID: <CA+H2tpH4+cLN0z7v50UdKCXOqZDt2rSYF5Lvm9-WBYJ3YWtJVg@mail.gmail.com>
Subject: Re: [PATCH] dynamic_debug: Add an option to enable dynamic debug for
 modules only
To:     Orson Zhai <orson.unisoc@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Apr 10, 2020 at 8:33 PM Orson Zhai <orson.unisoc@gmail.com> wrote:
>
> From: Orson Zhai <orson.zhai@unisoc.com>
>
> Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
> CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
> debug. With the DEBUG_MODULE defined for any modules, dynamic debug
> will be tied to them.
>
> This is useful for people who only want to enable dynamic debug for
> kernel modules without worrying about kernel image size and memory
> consumption is increasing too much.
>

Do you have any comments for this patch?

Best Regards,
Orson

> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
>  include/linux/dev_printk.h                        |  6 ++++--
>  include/linux/dynamic_debug.h                     |  2 +-
>  include/linux/printk.h                            | 14 +++++++++-----
>  lib/Kconfig.debug                                 | 12 ++++++++++++
>  lib/Makefile                                      |  2 +-
>  lib/dynamic_debug.c                               |  9 +++++++--
>  7 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 0dc2eb8..fa5b8d4 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -13,8 +13,11 @@ kernel code to obtain additional kernel information.  Currently, if
>  ``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
>  enabled per-callsite.
>
> -If ``CONFIG_DYNAMIC_DEBUG`` is not set, ``print_hex_dump_debug()`` is just
> -shortcut for ``print_hex_dump(KERN_DEBUG)``.
> +If ``CONFIG_DYNAMIC_DEBUG_CORE`` is set, only the modules with ``DEBUG_MODULE``
> +defined will be tied into dynamic debug.
> +
> +If ``CONFIG_DYNAMIC_DEBUG`` or ``CONFIG_DYNAMIC_DEBUG_CORE`` is not set,
> +``print_hex_dump_debug()`` is just shortcut for ``print_hex_dump(KERN_DEBUG)``.
>
>  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
>  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> index 5aad06b..2fb0671 100644
> --- a/include/linux/dev_printk.h
> +++ b/include/linux/dev_printk.h
> @@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
>  #define dev_info(dev, fmt, ...)                                                \
>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>  #define dev_dbg(dev, fmt, ...)                                         \
>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>  #elif defined(DEBUG)
> @@ -181,7 +182,8 @@ do {                                                                        \
>         dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
>  #define dev_info_ratelimited(dev, fmt, ...)                            \
>         dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
>  #define dev_dbg_ratelimited(dev, fmt, ...)                             \
>  do {                                                                   \
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 4cf02ec..abcd5fd 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -48,7 +48,7 @@ struct _ddebug {
>
>
>
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>                                 const char *modname);
>  extern int ddebug_remove_module(const char *mod_name);
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 1e6108b..77fab5b 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -291,8 +291,9 @@ extern int kptr_restrict;
>  /*
>   * These can be used to print at the various log levels.
>   * All of these will print unconditionally, although note that pr_debug()
> - * and other debug macros are compiled out unless either DEBUG is defined
> - * or CONFIG_DYNAMIC_DEBUG is set.
> + * and other debug macros are compiled out unless either DEBUG is defined,
> + * CONFIG_DYNAMIC_DEBUG is set, or CONFIG_DYNAMIC_DEBUG_CORE is set when
> + * DEBUG_MODULE being defined for any modules.
>   */
>  #define pr_emerg(fmt, ...) \
>         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> @@ -327,7 +328,8 @@ extern int kptr_restrict;
>
>
>  /* If you are writing a driver, please use dev_dbg instead */
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>  #include <linux/dynamic_debug.h>
>
>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> @@ -453,7 +455,8 @@ extern int kptr_restrict;
>  #endif
>
>  /* If you are writing a driver, please use dev_dbg instead */
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
>  #define pr_debug_ratelimited(fmt, ...)                                 \
>  do {                                                                   \
> @@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
>
>  #endif
>
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
>  #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
>                              groupsize, buf, len, ascii)        \
>         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 50c1f5f..25a1b9de 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
>         default n
>         depends on PRINTK
>         depends on (DEBUG_FS || PROC_FS)
> +       select DYNAMIC_DEBUG_CORE
>         help
>
>           Compiles debug level messages into the kernel, which would not
> @@ -165,6 +166,17 @@ config DYNAMIC_DEBUG
>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>           information.
>
> +config DYNAMIC_DEBUG_CORE
> +       bool "Enable core function of dynamic debug support"
> +       depends on PRINTK
> +       depends on (DEBUG_FS || PROC_FS)
> +       help
> +         Enable core functional support of dynamic debug. It is useful
> +         when you want to tie dynamic debug to your kernel modules with
> +         DEBUG_MODULE defined for each of them, especially for the case
> +         of embedded system where the kernel image size is sensitive for
> +         people.
> +
>  config SYMBOLIC_ERRNAME
>         bool "Support symbolic error names in printf"
>         default y if PRINTK
> diff --git a/lib/Makefile b/lib/Makefile
> index 685aee6..8952772 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -186,7 +186,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
>
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>
> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
>
>  obj-$(CONFIG_NLATTR) += nlattr.o
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 8f199f4..321437b 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1032,8 +1032,13 @@ static int __init dynamic_debug_init(void)
>         int verbose_bytes = 0;
>
>         if (&__start___verbose == &__stop___verbose) {
> -               pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> -               return 1;
> +               if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
> +                       pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> +                       return 1;
> +               }
> +               pr_info("Ignore empty _ddebug table in a CONFIG_DYNAMIC_DEBUG_CORE build\n");
> +               ddebug_init_success = 1;
> +               return 0;
>         }
>         iter = __start___verbose;
>         modname = iter->modname;
> --
> 2.7.4
>
