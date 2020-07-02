Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12CF206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiMQcGxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGBOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGBOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:44:07 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:44:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so12768132qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9S+YyJ0fLCRa1Cwm+n/NH94ez6mz+li88d6osWWRvM=;
        b=OiMQcGxeqkk/4Awal6X4kYe1CxbqnKK7VEheoiH3nPUyKTnh9LF8J5gXTddg4gACKu
         dh7LZ0+LYuI7eqJHJ/AOZoqkJzff1V810uiOwUOHFE+0aGzlogkuyZKbPBFv84u7O+82
         iBovoaZQTQBeCuaGsrzbeLV4btzHi1QdWyxSlKo044c9PeU1XUjKQxS3EQeKAng4pmlT
         4YVlrSTVQcZQxbJ+BF1o13Dqwp33TXJKbcXMD9hbtHnqzGzI4Ka8Si7zs63nzb5C0tAm
         nldmoql8GIbqwZCsgy/B6gF2hROWsp1mdTX3sJXXQs4X/OGGdw9bHJb71AyFIbVPyFWZ
         FqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9S+YyJ0fLCRa1Cwm+n/NH94ez6mz+li88d6osWWRvM=;
        b=SMxVmb62AbSqHUNCU5FdbV8U5VTk/MNb9iU1BVzc3sFZVlIYo1gCXAYPsC+uPTcPSF
         D0jGl+F0rXT/w0uoCpY57m0BEHcWDavWxBv9I37zXbd1Jy7TXkhqtLOLV7B21XyWnj30
         GCCKB3dGKDF0y/TqAl0Xp04MboBeyjHMR7tnsYWQWGRmTFXLuaMLIkh4WStTp7dbT9SY
         hCpCFvEFqnsiHlhWyqiITF6f+Py9hOvq9E+THszEl/LipQW5lmeLRmN9F6ONogoNhOnR
         GEliZzN8lf4ikLsZPtqiWDY++ELoRm6n4Tp2JQKCMXmpmUzaUZgDpCek7nwerb02DsfN
         8ZSw==
X-Gm-Message-State: AOAM531xfpH0ikb5wskAAMBQ8AdCh789bNe/HG3vh4+9Pby93YCUbhgk
        3RIHda98BFwzOitt1FkKCqKcZpVLz5I5eGgVc0Fbrw==
X-Google-Smtp-Source: ABdhPJxhkIJSSmI1llDnnlyk/fpATcXAk1fIHgpTA/vpWwX47DrmByr6pNIiRXw7kSOA73Cz6sk6VvuYvB41dQWJMqI=
X-Received: by 2002:a05:6214:14e5:: with SMTP id k5mr6836956qvw.125.1593701046654;
 Thu, 02 Jul 2020 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
In-Reply-To: <20200630173734.14057-5-will@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 2 Jul 2020 10:43:55 -0400
Message-ID: <CAJWu+oqs-d0oDswB2Owyh-4Zo4WXAqKhKU0L=1HEwEfQbc1izw@mail.gmail.com>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 1:38 PM Will Deacon <will@kernel.org> wrote:
>
> Rather then relying on the core code to use smp_read_barrier_depends()
> as part of the READ_ONCE() definition, instead override __READ_ONCE()
> in the Alpha code so that it is treated the same way as
> smp_load_acquire().
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/alpha/include/asm/barrier.h | 61 ++++----------------------------
>  arch/alpha/include/asm/rwonce.h  | 19 ++++++++++
>  2 files changed, 26 insertions(+), 54 deletions(-)
>  create mode 100644 arch/alpha/include/asm/rwonce.h
>
> diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
> index 92ec486a4f9e..2ecd068d91d1 100644
> --- a/arch/alpha/include/asm/barrier.h
> +++ b/arch/alpha/include/asm/barrier.h
> @@ -2,64 +2,17 @@
>  #ifndef __BARRIER_H
>  #define __BARRIER_H
>
> -#include <asm/compiler.h>
> -
>  #define mb()   __asm__ __volatile__("mb": : :"memory")
>  #define rmb()  __asm__ __volatile__("mb": : :"memory")
>  #define wmb()  __asm__ __volatile__("wmb": : :"memory")
>
> -/**
> - * read_barrier_depends - Flush all pending reads that subsequents reads
> - * depend on.
> - *
> - * No data-dependent reads from memory-like regions are ever reordered
> - * over this barrier.  All reads preceding this primitive are guaranteed
> - * to access memory (but not necessarily other CPUs' caches) before any
> - * reads following this primitive that depend on the data return by
> - * any of the preceding reads.  This primitive is much lighter weight than
> - * rmb() on most CPUs, and is never heavier weight than is
> - * rmb().
> - *
> - * These ordering constraints are respected by both the local CPU
> - * and the compiler.
> - *
> - * Ordering is not guaranteed by anything other than these primitives,
> - * not even by data dependencies.  See the documentation for
> - * memory_barrier() for examples and URLs to more information.
> - *
> - * For example, the following code would force ordering (the initial
> - * value of "a" is zero, "b" is one, and "p" is "&a"):
> - *
> - * <programlisting>
> - *     CPU 0                           CPU 1
> - *
> - *     b = 2;
> - *     memory_barrier();
> - *     p = &b;                         q = p;
> - *                                     read_barrier_depends();
> - *                                     d = *q;
> - * </programlisting>
> - *
> - * because the read of "*q" depends on the read of "p" and these
> - * two reads are separated by a read_barrier_depends().  However,
> - * the following code, with the same initial values for "a" and "b":
> - *

Would it be Ok to keep this example in the kernel sources? I think it
serves as good documentation and highlights the issue in the Alpha
architecture well.

> - * <programlisting>
> - *     CPU 0                           CPU 1
> - *
> - *     a = 2;
> - *     memory_barrier();
> - *     b = 3;                          y = b;
> - *                                     read_barrier_depends();
> - *                                     x = a;
> - * </programlisting>
> - *
> - * does not enforce ordering, since there is no data dependency between
> - * the read of "a" and the read of "b".  Therefore, on some CPUs, such
> - * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
> - * in cases like this where there are no data dependencies.
> - */
> -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> +#define __smp_load_acquire(p)                                          \
> +({                                                                     \
> +       __unqual_scalar_typeof(*p) ___p1 =                              \
> +               (*(volatile typeof(___p1) *)(p));                       \
> +       compiletime_assert_atomic_type(*p);                             \
> +       ___p1;                                                          \
> +})

I had the same question as Mark about the need for a memory barrier
here, otherwise alpha will again break right? Looking forward to the
future fix you mentioned.

BTW,  do you know any architecture where speculative execution of
address-dependent loads can cause similar misorderings? That would be
pretty insane though. In Alpha's case it is not speculation but rather
the split local cache design as the docs mention.   The reason I ask
is it is pretty amusing that control-dependent loads do have such
misordering issues due to speculative branch execution and I wondered
what other games the CPUs are playing. FWIW I ran into [1] which talks
about analogy between memory dependence and control dependence.

[1] https://en.wikipedia.org/wiki/Memory_dependence_prediction


 - Joel


>
>  #ifdef CONFIG_SMP
>  #define __ASM_SMP_MB   "\tmb\n"
> diff --git a/arch/alpha/include/asm/rwonce.h b/arch/alpha/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..83a92e49a615
> --- /dev/null
> +++ b/arch/alpha/include/asm/rwonce.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Google LLC.
> + */
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#include <asm/barrier.h>
> +
> +/*
> + * Alpha is apparently daft enough to reorder address-dependent loads
> + * on some CPU implementations. Knock some common sense into it with
> + * a memory barrier in READ_ONCE().
> + */
> +#define __READ_ONCE(x) __smp_load_acquire(&(x))
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif /* __ASM_RWONCE_H */
> --
> 2.27.0.212.ge8ba1cc988-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
