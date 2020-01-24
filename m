Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93914C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA01214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBdd9AOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgAXLXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:23:20 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35462 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391283AbgAXLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:23:09 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so716882qvi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwzQ3VCUqoiQqyG2DwDT1s000avPDz+MSypapI5GJkU=;
        b=tBdd9AOgbGoefVh+ESSREOiklsPn1d77K/Z5wFAES3zsRlmecr69hozwJsD6NXOiwr
         RS9KD3JteWX1fOpwBTGhtclav8Pe0gYHDDdj/dJtvD+vsycy9s7cOC27/EDv+oMXr9RU
         N0Mvcnkok5z5ftwgqX1r0IoOqXFcd5skObUigB52pxuTzPIxARasiFCgtQq7IIhG6Twp
         1e1r4j7OaEBbRPtsVcNZY7L07dR00eBKM0Y3O79/JgZYSKL5kqsKkFitVMMCu6wHkJt4
         fezr3Y07wnwe/dKxSkktfScgB9kVXndNX3zywa5Sh/XZL2QwZKzROJpBtv1kp4Dh2zDh
         Ydjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwzQ3VCUqoiQqyG2DwDT1s000avPDz+MSypapI5GJkU=;
        b=i6JQRlu0qZhoc4VaalJsyVEsHes/KN/d8xqfVG/orv1bsYiRYSpqI1qZ+K9goWJMVO
         R7rKj1QVQuyur9/U3/v0ZZQdKAbmq0MN3MyFJc5h06wTTQPMDBWpVM8kikh6jeVmIcG5
         TEmMV8DZVHopT0QZkojE91Heo/8GUrZ+4RM/oSzHnUnXUhZfM3fwGwNu/GYo6nVwQ+4j
         RRxE/ARNIlh5xAmIEfP9uDDNUA5ZjJHbkJg0K7xoiYdRYvrkk9K87bSsVB4ZvyCMs/B+
         +eHkF61MSNei94EEShkNas7Ul4D54BIYRbKIajH2eiiW3WNrcj4jsv2sbVOf7p5+3dp5
         mG5A==
X-Gm-Message-State: APjAAAXSmFzVjizZCGLNnR95t0txYDZ8KZQzEFAeEXRtWNKNNtx+MRWK
        rLw3LUkXt430ANDMmeVDr3HQRGTlvBqQ1xB3M/vUCQ==
X-Google-Smtp-Source: APXvYqwobgdvp5BoQe6vJueIBTtvwmjSRei1KJDbZLfuVUJ4xFnT3tCN7BW9EBcKj1JLiMydg7FDKvy9PT60+W+LLsk=
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr2207642qvs.159.1579864987764;
 Fri, 24 Jan 2020 03:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20200121160512.70887-1-elver@google.com>
In-Reply-To: <20200121160512.70887-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Jan 2020 12:22:56 +0100
Message-ID: <CACT4Y+aRk5=7UoPb9zmDm5XL9CcJDv9YnzndjXYtt+3FKd8maw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Axtens <dja@axtens.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, cyphar@cyphar.com,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 5:05 PM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user should use special instrumentation, since
> we should be able to instrument both source and destination memory
> accesses if both are kernel memory.
>
> The current patch only instruments the memory access where the address
> is always in kernel space, however, both may in fact be kernel addresses
> when a compat syscall passes an argument allocated in the kernel to a
> real syscall. In a future change, both KASAN and KCSAN should check both
> addresses in such cases, as well as KMSAN will make use of both
> addresses. [It made more sense to provide the completed function
> signature, rather than updating it and changing all locations again at a
> later time.]

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
> * Simplify header, since we currently do not need pre/post user-copy
>   distinction.
> * Make instrument_copy_{to,from}_user function arguments match
>   copy_{to,from}_user and update rationale in commit message.
> ---
>  include/linux/instrumented.h | 109 +++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 include/linux/instrumented.h
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> new file mode 100644
> index 000000000000..43e6ea591975
> --- /dev/null
> +++ b/include/linux/instrumented.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This header provides generic wrappers for memory access instrumentation that
> + * the compiler cannot emit for: KASAN, KCSAN.
> + */
> +#ifndef _LINUX_INSTRUMENTED_H
> +#define _LINUX_INSTRUMENTED_H
> +
> +#include <linux/compiler.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +#include <linux/types.h>
> +
> +/**
> + * instrument_read - instrument regular read access
> + *
> + * Instrument a regular read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_read(v, size);
> +}
> +
> +/**
> + * instrument_write - instrument regular write access
> + *
> + * Instrument a regular write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_write(v, size);
> +}
> +
> +/**
> + * instrument_atomic_read - instrument atomic read access
> + *
> + * Instrument an atomic read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_atomic_read(v, size);
> +}
> +
> +/**
> + * instrument_atomic_write - instrument atomic write access
> + *
> + * Instrument an atomic write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_atomic_write(v, size);
> +}
> +
> +/**
> + * instrument_copy_to_user - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants). The instrumentation must be inserted before the accesses.
> + *
> + * @to destination address
> + * @from source address
> + * @n number of bytes to copy
> + */
> +static __always_inline void
> +instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> +{
> +       kasan_check_read(from, n);
> +       kcsan_check_read(from, n);
> +}
> +
> +/**
> + * instrument_copy_from_user - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants). The instrumentation should be inserted before the accesses.
> + *
> + * @to destination address
> + * @from source address
> + * @n number of bytes to copy
> + */
> +static __always_inline void
> +instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
> +{
> +       kasan_check_write(to, n);
> +       kcsan_check_write(to, n);
> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_H */
> --
> 2.25.0.341.g760bfbb309-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200121160512.70887-1-elver%40google.com.
