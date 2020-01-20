Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29671C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E726222464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A33lYU15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgATOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:52:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44269 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:52:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so30283525qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r7hLAzJ5XLPlBLlLKXbueYWLmX6BTOI1cJJxqLCq6Q=;
        b=A33lYU15woJADc37Yd8l/Tk+tXslqR8+HwmIFXwz+bmidG/q0xW1W06s9peuwaoaVe
         Ku7yw5P2dKxhNoc5JK1uahdePTnEDQ0VixgGWk+DNN4BNPRqkZlcnCo9ea6Euw/cGlWp
         n9dZjyhlEYgub2FPZHvW1t99RTH6v8GSpiwEBNldm/gilrDWLHUoSf0tWIbMDwGm19Xs
         zXrFsS4Tts5l3j0i8gO3bschp7mBiVJwLRIPUj/ujGcly/zsuBtiXvIf0k4NJK9DpUxb
         NUiEAPTOhpjCe+YNV9KDiF1J6/FEfR3GpAkCbymgh6zbUHZu4FLktrzg+xE57vSuymIR
         LiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r7hLAzJ5XLPlBLlLKXbueYWLmX6BTOI1cJJxqLCq6Q=;
        b=spuRQkddgNmPrzrEVQyki1Qs9Pe6jXpqZely//qnoLeFBxThuLfX4VQE23yaCXP2ic
         BHtEpIb31PabjM5SKw/Rtjz803KblCUum7V5S0zOglj/1d1OSwJWXw+wutEEIXibXfiO
         v2cPD63225u8VmG6AtL1NDUTL7xdfFOff8vsez73OiC+xRlFnT5WBGrHzGmYsbaV+76v
         J7x2RjE8Dcr6lbMhe69wTfMsmytPzoSzhyNAgCq9ADU2e1GX9ALIoXm4GsHzHN7HMxvA
         UIXT5qIR7FO0BXxUB7Z/3nfpb1yEZZCXpghfatsuPc4gi7fTYIMVpQDae+ibFmmXvt6B
         gmmQ==
X-Gm-Message-State: APjAAAXXMxl0nnnfrgpBCYEkuOYWYxNrnWktYItOYDQxpk30t2YTNNJU
        uVOH7cQqtjR4EKJrChB14jHtNlVPrQFC5ldAR6EDGQ==
X-Google-Smtp-Source: APXvYqyMb/ksir73hL05SZw2P5HvQaVJaB6gVL/FfKNkJYTZNpc4zZtxepiL7b6UZTTyAveu5qcMYuu6LsATYT8+Okg=
X-Received: by 2002:a37:e312:: with SMTP id y18mr52657374qki.250.1579531920632;
 Mon, 20 Jan 2020 06:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <20200120141927.114373-5-elver@google.com>
In-Reply-To: <20200120141927.114373-5-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 15:51:48 +0100
Message-ID: <CACT4Y+bUvoePVPV+BqU-cwhF6bR41_eaYkr9WLLMYi-2q11JjQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This replaces the KASAN instrumentation with generic instrumentation,
> implicitly adding KCSAN instrumentation support.
>
> For KASAN no functional change is intended.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
>  lib/usercopy.c          | 14 ++++++++-----
>  2 files changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..d3f2d9a8cae3 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -2,9 +2,9 @@
>  #ifndef __LINUX_UACCESS_H__
>  #define __LINUX_UACCESS_H__
>
> +#include <linux/instrumented.h>
>  #include <linux/sched.h>
>  #include <linux/thread_info.h>
> -#include <linux/kasan-checks.h>
>
>  #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
>
> @@ -58,18 +58,26 @@
>  static __always_inline __must_check unsigned long
>  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> -       kasan_check_write(to, n);
> +       unsigned long res;
> +
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_pre(to, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_post(to, n, res);
> +       return res;
>  }

There is also something called strncpy_from_user() that has kasan
instrumentation now:
https://elixir.bootlin.com/linux/v5.5-rc6/source/lib/strncpy_from_user.c#L117

>  static __always_inline __must_check unsigned long
>  __copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> +       unsigned long res;
> +
>         might_fault();
> -       kasan_check_write(to, n);
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_pre(to, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_post(to, n, res);
> +       return res;
>  }
>
>  /**
> @@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>  static __always_inline __must_check unsigned long
>  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
>  {
> -       kasan_check_read(from, n);
> +       unsigned long res;
> +
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_pre(from, n);
> +       res = raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_post(from, n, res);
> +       return res;
>  }
>
>  static __always_inline __must_check unsigned long
>  __copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res;
> +
>         might_fault();
> -       kasan_check_read(from, n);
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_pre(from, n);
> +       res = raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_post(from, n, res);
> +       return res;
>  }
>
>  #ifdef INLINE_COPY_FROM_USER
> @@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>         unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
> -               kasan_check_write(to, n);
> +               instrument_copy_from_user_pre(to, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_post(to, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
>  static inline __must_check unsigned long
>  _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res = n;
> +
>         might_fault();
>         if (access_ok(to, n)) {
> -               kasan_check_read(from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_pre(from, n);
> +               res = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_post(from, n, res);
>         }
> -       return n;
> +       return res;
>  }
>  #else
>  extern __must_check unsigned long
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index cbb4d9ec00f2..1c20d4423b86 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/uaccess.h>
>  #include <linux/bitops.h>
> +#include <linux/instrumented.h>
> +#include <linux/uaccess.h>
>
>  /* out-of-line parts */
>
> @@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
>         unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
> -               kasan_check_write(to, n);
> +               instrument_copy_from_user_pre(to, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_post(to, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
>  #ifndef INLINE_COPY_TO_USER
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(to, n))) {
> -               kasan_check_read(from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_pre(from, n);
> +               res = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_post(from, n, res);
>         }
> -       return n;
> +       return res;
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> --
> 2.25.0.341.g760bfbb309-goog
>
