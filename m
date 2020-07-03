Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D64EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EEB2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua3/jOaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgGCOgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgGCOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:36:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5203C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:36:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so28905749qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0p6+MkcMCuJnYjdDnNybQAxnSXPvknTUY7McNjJwwE=;
        b=ua3/jOaYiuad/A6oUVKiv6KmvX6MNirakevmM94FrWmTtIlFXpcajuKPIUGh2ZLRnr
         VyW/ECx9she01cOsrX6Yqph5uHEEt3nC5Cgp6GZ9RKXjlcoR8IigZydfEXPk+hl+GGtH
         M8c29Lahha13qRP6Hn/16Jy5NjYYBBILsoDWTUnWj+7n3+NWrSxA8JCDqqZby3BrFpnH
         rhto96SMjXHkjnQmgooOT1i65Nz5C8PZUMZHpVkaS/jMDhKqLe86iC+4gAEIRM1hg5zZ
         T7vu7AYWH5n9URuMNnvWeBbageVLWwjQI09KgfPUXR15WXrk3lJqAMGvXP+YG+X9OtsF
         Hqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0p6+MkcMCuJnYjdDnNybQAxnSXPvknTUY7McNjJwwE=;
        b=cojzfdNkiDCD5uvG1tXZwSZ5VbIr0yeh9/4QclcobcjQutzEyCrQJbee2kVnbhO6np
         Af6JtzPnHZR9lORHpfeRXT3E6RoMweypecuLFadiXsx9ed/BCu9cusA/NPSL6AJsdlLd
         cup+gQGHsAuW+5HQtmVFUPYv4SPGZVpQ0kh52twe097fqwTbfY4/m9ozMXk6y+eLqn2L
         swohsqdx6YXJbuaZJEWt21BXS/Oc8Z61U8INxjij95nWlqIW2YaOq1rb85FG1PzUwu3l
         JYy55HPCVed50ohnOH35xPw6qAhYGgWPJTDOGLPL85zYh4OK7aVz76dz/xlaC8MJtxyJ
         llVw==
X-Gm-Message-State: AOAM5319eUXvkLjLyAPS/NSs5ssILxNEOpD2gqTBxwYQsrn1msiG5/Vs
        3QhcIoDx1qRUkJuuz7+uOMvx5/uruZpKtZ4i+aIPfQ==
X-Google-Smtp-Source: ABdhPJzvbqdlubyQE8dkNe8oi+z6vJcxUnu0dI3MRBlXSZVQ3rOgEg5eEzgJSENjg0xkvhy6O84iAqNCPQJOIpVgBUs=
X-Received: by 2002:a37:7682:: with SMTP id r124mr17230924qkc.43.1593786983628;
 Fri, 03 Jul 2020 07:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200703134031.3298135-1-elver@google.com>
In-Reply-To: <20200703134031.3298135-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 3 Jul 2020 16:36:11 +0200
Message-ID: <CACT4Y+YoicOtXEGsV9fJwfA7PpQY0sKbyWq1gY27P-oaXDJ3RA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kcsan: Add support for atomic builtins
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 3:40 PM Marco Elver <elver@google.com> wrote:
>
> Some architectures (currently e.g. s390 partially) implement atomics
> using the compiler's atomic builtins (__atomic_*, __sync_*). To support
> enabling KCSAN on such architectures in future, or support experimental
> use of these builtins, implement support for them.
>
> We should also avoid breaking KCSAN kernels due to use (accidental or
> otherwise) of atomic builtins in drivers, as has happened in the past:
> https://lkml.kernel.org/r/5231d2c0-41d9-6721-e15f-a7eedf3ce69e@infradead.org
>
> The instrumentation is subtly different from regular reads/writes: TSAN
> instrumentation replaces the use of atomic builtins with a call into the
> runtime, and the runtime's job is to also execute the desired atomic
> operation. We rely on the __atomic_* compiler builtins, available with
> all KCSAN-supported compilers, to implement each TSAN atomic
> instrumentation function.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcsan/core.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index d803765603fb..6843169da759 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -856,3 +856,113 @@ void __tsan_init(void)
>  {
>  }
>  EXPORT_SYMBOL(__tsan_init);
> +
> +/*
> + * Instrumentation for atomic builtins (__atomic_*, __sync_*).
> + *
> + * Normal kernel code _should not_ be using them directly, but some
> + * architectures may implement some or all atomics using the compilers'
> + * builtins.
> + *
> + * Note: If an architecture decides to fully implement atomics using the
> + * builtins, because they are implicitly instrumented by KCSAN (and KASAN,
> + * etc.), implementing the ARCH_ATOMIC interface (to get instrumentation via
> + * atomic-instrumented) is no longer necessary.
> + *
> + * TSAN instrumentation replaces atomic accesses with calls to any of the below
> + * functions, whose job is to also execute the operation itself.
> + */
> +
> +#define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
> +       u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
> +       u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
> +       {                                                                                          \
> +               check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
> +               return __atomic_load_n(ptr, memorder);                                             \
> +       }                                                                                          \
> +       EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
> +       void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
> +       void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
> +       {                                                                                          \
> +               check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> +               __atomic_store_n(ptr, v, memorder);                                                \
> +       }                                                                                          \
> +       EXPORT_SYMBOL(__tsan_atomic##bits##_store)
> +
> +#define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
> +       u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
> +       u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
> +       {                                                                                          \
> +               check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> +               return __atomic_##op##suffix(ptr, v, memorder);                                    \
> +       }                                                                                          \
> +       EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
> +
> +/*
> + * Note: CAS operations are always classified as write, even in case they
> + * fail. We cannot perform check_access() after a write, as it might lead to
> + * false positives, in cases such as:
> + *
> + *     T0: __atomic_compare_exchange_n(&p->flag, &old, 1, ...)
> + *
> + *     T1: if (__atomic_load_n(&p->flag, ...)) {
> + *             modify *p;
> + *             p->flag = 0;
> + *         }
> + *
> + * The only downside is that, if there are 3 threads, with one CAS that
> + * succeeds, another CAS that fails, and an unmarked racing operation, we may
> + * point at the wrong CAS as the source of the race. However, if we assume that
> + * all CAS can succeed in some other execution, the data race is still valid.
> + */
> +#define DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strength, weak)                                           \
> +       int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
> +                                                             u##bits val, int mo, int fail_mo);   \
> +       int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
> +                                                             u##bits val, int mo, int fail_mo)    \
> +       {                                                                                          \
> +               check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> +               return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
> +       }                                                                                          \
> +       EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
> +
> +#define DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)                                                       \
> +       u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
> +                                                          int mo, int fail_mo);                   \
> +       u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
> +                                                          int mo, int fail_mo)                    \
> +       {                                                                                          \
> +               check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> +               __atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
> +               return exp;                                                                        \
> +       }                                                                                          \
> +       EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_val)
> +
> +#define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
> +       DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
> +       DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits, );                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits, );                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits, );                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits, );                                                  \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits, );                                                 \
> +       DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits, );                                                \
> +       DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
> +       DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
> +       DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
> +
> +DEFINE_TSAN_ATOMIC_OPS(8);
> +DEFINE_TSAN_ATOMIC_OPS(16);
> +DEFINE_TSAN_ATOMIC_OPS(32);
> +DEFINE_TSAN_ATOMIC_OPS(64);
> +
> +void __tsan_atomic_thread_fence(int memorder);
> +void __tsan_atomic_thread_fence(int memorder)
> +{
> +       __atomic_thread_fence(memorder);
> +}
> +EXPORT_SYMBOL(__tsan_atomic_thread_fence);
> +
> +void __tsan_atomic_signal_fence(int memorder);
> +void __tsan_atomic_signal_fence(int memorder) { }
> +EXPORT_SYMBOL(__tsan_atomic_signal_fence);
> --
> 2.27.0.212.ge8ba1cc988-goog
>
