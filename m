Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B172253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/Pop3pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAUQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:14:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32835 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgAUQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:14:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so3094110oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXf7v5u4QW5b0oUhqlEbSYsuPaK7kUXwuaQl8tSfrCE=;
        b=D/Pop3pi/9T/J/oSC1bENHywcgIYAFOPdwbx0MZrz7SJzbwnbXbwEHEtiexEN5OR6w
         K3pzmf5ThEt1CKco6axerkBYKjN2f7T/IPcVceQcETFetnu+tgnhRan+8LBYwMN2+EsI
         0oSmjMRQ5JpH1+QZPW8Ql8uOjW34wd5/1uV7QnvWT6NvF2wgAd6Jl1ofygKTujFGE83o
         5xKnDfG6RZr5T9CnI0LoQL5LVm8aKF+bY+qFV2cYSrLiSV6BJI1WiwddD/3/dUhyidQz
         9gjFnKPglx7sMKHDEFzBOI0A72G84TjJYZ1t0vzif9x10I0ne+T9eg3XfpEfuYRsm2jr
         W30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXf7v5u4QW5b0oUhqlEbSYsuPaK7kUXwuaQl8tSfrCE=;
        b=bl4V11K04NbdcZRuu7MgXhC9wNR9pv3EYdUhKs4hcaF3fWXK1yVlz8NqvEXPGAu17O
         oVZJ/TQ4DJNRkkW2KSlvFj5xEw7hRxKN9IcHNYwFjKczC6rST/yHGRdsT3mA85+Uo2U1
         ADBll/xtlzKygy/ENy21WCM0iU+VUd6RJnDagTtLeC4qy0sW++um3F3/Ckxj+8LVI44R
         1tYDmoV3SL/2zmjXRAqzVuPQZ+csUips+Z1Bvxo4Gp77RsNk/aZeuhi/cpsgRWFzUc50
         ptrw15N2yNRCQ2dVRbd1I2V3i4pRieOP8NQ9R65Ef/LGWxwTqtn1JEkoEUY46yTLSPj+
         Txvw==
X-Gm-Message-State: APjAAAXyAF5+HqWFApM/xJ9swOk1lMnBBz0TNTYyHdqJsXueb7ttCpdJ
        CiQsW92vwXe3fD67RlZ0EzwpgrlyTRALaNy8jg+ZwzatuTeTiw==
X-Google-Smtp-Source: APXvYqxIvT2Q0nsN72pnq7MpH8LjZasGCfvRThBdyz359N8AxeOSUHaZ4FY6s6nVTXidaWPzw/IBpd8DDv9QJUjeIWM=
X-Received: by 2002:aca:2112:: with SMTP id 18mr3379090oiz.155.1579623256839;
 Tue, 21 Jan 2020 08:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+bjAn0g980ZCxCn4MkgCsg7KrA69CExCeJZ63eRON5fXw@mail.gmail.com>
In-Reply-To: <CACT4Y+bjAn0g980ZCxCn4MkgCsg7KrA69CExCeJZ63eRON5fXw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 17:14:05 +0100
Message-ID: <CANpmjNOQPwn-+iL38RkfsJ6tWj8pZyB_dfh8174FmaYz5tfBTA@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Tue, 21 Jan 2020 at 14:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> > >
> > > This adds instrumented.h, which provides generic wrappers for memory
> > > access instrumentation that the compiler cannot emit for various
> > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > future this will also include KMSAN instrumentation.
> > >
> > > Note that, copy_{to,from}_user require special instrumentation,
> > > providing hooks before and after the access, since we may need to know
> > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > also relevant in future for KMSAN).
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 153 insertions(+)
> > >  create mode 100644 include/linux/instrumented.h
> > >
> > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > new file mode 100644
> > > index 000000000000..9f83c8520223
> > > --- /dev/null
> > > +++ b/include/linux/instrumented.h
> > > @@ -0,0 +1,153 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * This header provides generic wrappers for memory access instrumentation that
> > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > + */
> > > +#ifndef _LINUX_INSTRUMENTED_H
> > > +#define _LINUX_INSTRUMENTED_H
> > > +
> > > +#include <linux/compiler.h>
> > > +#include <linux/kasan-checks.h>
> > > +#include <linux/kcsan-checks.h>
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * instrument_read - instrument regular read access
> > > + *
> > > + * Instrument a regular read access. The instrumentation should be inserted
> > > + * before the actual read happens.
> > > + *
> > > + * @ptr address of access
> > > + * @size size of access
> > > + */
> >
> > Based on offline discussion, that's what we add for KMSAN:
> >
> > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > +{
> > > +       kasan_check_read(v, size);
> > > +       kcsan_check_read(v, size);
> >
> > KMSAN: nothing
> >
> > > +}
> > > +
> > > +/**
> > > + * instrument_write - instrument regular write access
> > > + *
> > > + * Instrument a regular write access. The instrumentation should be inserted
> > > + * before the actual write happens.
> > > + *
> > > + * @ptr address of access
> > > + * @size size of access
> > > + */
> > > +static __always_inline void instrument_write(const volatile void *v, size_t size)
> > > +{
> > > +       kasan_check_write(v, size);
> > > +       kcsan_check_write(v, size);
> >
> > KMSAN: nothing
> >
> > > +}
> > > +
> > > +/**
> > > + * instrument_atomic_read - instrument atomic read access
> > > + *
> > > + * Instrument an atomic read access. The instrumentation should be inserted
> > > + * before the actual read happens.
> > > + *
> > > + * @ptr address of access
> > > + * @size size of access
> > > + */
> > > +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> > > +{
> > > +       kasan_check_read(v, size);
> > > +       kcsan_check_atomic_read(v, size);
> >
> > KMSAN: nothing
> >
> > > +}
> > > +
> > > +/**
> > > + * instrument_atomic_write - instrument atomic write access
> > > + *
> > > + * Instrument an atomic write access. The instrumentation should be inserted
> > > + * before the actual write happens.
> > > + *
> > > + * @ptr address of access
> > > + * @size size of access
> > > + */
> > > +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> > > +{
> > > +       kasan_check_write(v, size);
> > > +       kcsan_check_atomic_write(v, size);
> >
> > KMSAN: nothing
> >
> > > +}
> > > +
> > > +/**
> > > + * instrument_copy_to_user_pre - instrument reads of copy_to_user
> > > + *
> > > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > > + * variants).
> > > + *
> > > + * The instrumentation must be inserted before the accesses. At this point the
> > > + * actual number of bytes accessed is not yet known.
> > > + *
> > > + * @dst destination address
> > > + * @size maximum access size
> > > + */
> > > +static __always_inline void
> > > +instrument_copy_to_user_pre(const volatile void *src, size_t size)
> > > +{
> > > +       /* Check before, to warn before potential memory corruption. */
> > > +       kasan_check_read(src, size);
> >
> > KMSAN: check that (src,size) is initialized
> >
> > > +}
> > > +
> > > +/**
> > > + * instrument_copy_to_user_post - instrument reads of copy_to_user
> > > + *
> > > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > > + * variants).
> > > + *
> > > + * The instrumentation must be inserted after the accesses. At this point the
> > > + * actual number of bytes accessed should be known.
> > > + *
> > > + * @dst destination address
> > > + * @size maximum access size
> > > + * @left number of bytes left that were not copied
> > > + */
> > > +static __always_inline void
> > > +instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
> > > +{
> > > +       /* Check after, to avoid false positive if memory was not accessed. */
> > > +       kcsan_check_read(src, size - left);
> >
> > KMSAN: nothing
>
> One detail I noticed for KMSAN is that kmsan_copy_to_user has a
> special case when @to address is in kernel-space (compat syscalls
> doing tricky things), in that case it only copies metadata. We can't
> handle this with existing annotations.
>
>
>  * actually copied to ensure there was no information leak. If @to belongs to
>  * the kernel space (which is possible for compat syscalls), KMSAN just copies
>  * the metadata.
>  */
> void kmsan_copy_to_user(const void *to, const void *from, size_t
> to_copy, size_t left);

Sent v2: http://lkml.kernel.org/r/20200121160512.70887-1-elver@google.com
I hope it'll satisfy our various constraints for now.

Thanks,
-- Marco
