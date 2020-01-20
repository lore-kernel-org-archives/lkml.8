Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784CA2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBOINAIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgATPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:53:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42640 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:53:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so28881019oin.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiceCXFRSUBzYMQE2f4OjMMcZXcb2LTrkgPg5J2K4zg=;
        b=gBOINAIWIpnwWTbIyBvKjan36BdH+BxlO5xhhZFoTHgA6xGmX/4keBv/6JREpFttf5
         +ayFbf7t2XeoV5N2ksZKvjp21ESf/IebZ+82ndA8d/pVADqqK1NTFe2PoHgql+OsICPU
         XSR1aldBTVM1v2P4FKGgv+RoorEyfMDPH1JMkJ3sQd5+CofRH5JGw/BcwiBkzHturPsb
         LCjMDMz22Qo2LwU9nuVO4qEc/owK4yssFR6A3yGg3RlB1+G/+PVgPyxBkU20tpCrUCSC
         swGskDd4v3KUmu3VV2XagGxzsVU56SbsvL6FWtpzL0/gvoxAthudPnIXOWLmNWsivtem
         NjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiceCXFRSUBzYMQE2f4OjMMcZXcb2LTrkgPg5J2K4zg=;
        b=N+dwJ2nTWkYjMEjTqn41xca0DNZsVVI2IHcnmardq0PwJD8ltom/xwLWXPhjLDuh6A
         0EjLt3SJn7P3rXCke7O5KXPxPnHhycvZXMS9BrIKltWiYC8fbHxirKzM2+IpTYmsUJqk
         oKTMNinkg4rBTMJxDFBJRvMMUgjT0jLqO/Xq0W519wKzKUD5vHAVYgNrOC1g0aOch5f7
         mqDWn2yjPyHqIkT9wxmwVOBsi0i6RyVqZr2qunwifDRZeAg8Bc+kYoD8LhbI+xKeTHAl
         hyh6zhiL5Xy1pfgNvF/Jk3xD24P11Of/VFkuk4+8du5f184Sv2TkJ3wi1+l2SHgP2aph
         +a3A==
X-Gm-Message-State: APjAAAXsCIHU0GCezEXJbQiyIRpd62mAvZMuZSTFamEa0Jvld2K+zCh8
        uZ/e9ylKTVTnT8dTiAs/kVkCQkvH2VCrGXOZ/8E/gQ==
X-Google-Smtp-Source: APXvYqwmflC/yNzWv+Db2nr3WV+DLKRgthZvh+EzUFiOuic5zA65sbECmY9Y8fx6wftlS5NL/KUU4onhHpTmPr84oRQ=
X-Received: by 2002:aca:2112:: with SMTP id 18mr12680928oiz.155.1579535633036;
 Mon, 20 Jan 2020 07:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+ajkjCzv2adupX9oVKjNppn-AKsGkGqLMExwjHXG37Lxw@mail.gmail.com>
In-Reply-To: <CACT4Y+ajkjCzv2adupX9oVKjNppn-AKsGkGqLMExwjHXG37Lxw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 16:53:41 +0100
Message-ID: <CANpmjNN4XhU6WL35bHF2Wu76fJMXO5++uRBk0nh_s6BiRV9jdA@mail.gmail.com>
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

On Mon, 20 Jan 2020 at 15:34, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> >
> > This adds instrumented.h, which provides generic wrappers for memory
> > access instrumentation that the compiler cannot emit for various
> > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > future this will also include KMSAN instrumentation.
> >
> > Note that, copy_{to,from}_user require special instrumentation,
> > providing hooks before and after the access, since we may need to know
> > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > also relevant in future for KMSAN).
>
> How will KMSAN instrumentation look like?
>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 include/linux/instrumented.h
> >
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > new file mode 100644
> > index 000000000000..9f83c8520223
> > --- /dev/null
> > +++ b/include/linux/instrumented.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This header provides generic wrappers for memory access instrumentation that
> > + * the compiler cannot emit for: KASAN, KCSAN.
> > + */
> > +#ifndef _LINUX_INSTRUMENTED_H
> > +#define _LINUX_INSTRUMENTED_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +#include <linux/types.h>
> > +
> > +/**
> > + * instrument_read - instrument regular read access
> > + *
> > + * Instrument a regular read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_read(v, size);
> > +}
> > +
> > +/**
> > + * instrument_write - instrument regular write access
> > + *
> > + * Instrument a regular write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_write(v, size);
> > +}
> > +
> > +/**
> > + * instrument_atomic_read - instrument atomic read access
> > + *
> > + * Instrument an atomic read access. The instrumentation should be inserted
> > + * before the actual read happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_read(v, size);
> > +       kcsan_check_atomic_read(v, size);
> > +}
> > +
> > +/**
> > + * instrument_atomic_write - instrument atomic write access
> > + *
> > + * Instrument an atomic write access. The instrumentation should be inserted
> > + * before the actual write happens.
> > + *
> > + * @ptr address of access
> > + * @size size of access
> > + */
> > +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> > +{
> > +       kasan_check_write(v, size);
> > +       kcsan_check_atomic_write(v, size);
> > +}
> > +
> > +/**
> > + * instrument_copy_to_user_pre - instrument reads of copy_to_user
> > + *
> > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted before the accesses. At this point the
> > + * actual number of bytes accessed is not yet known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + */
> > +static __always_inline void
> > +instrument_copy_to_user_pre(const volatile void *src, size_t size)
> > +{
> > +       /* Check before, to warn before potential memory corruption. */
> > +       kasan_check_read(src, size);
> > +}
> > +
> > +/**
> > + * instrument_copy_to_user_post - instrument reads of copy_to_user
> > + *
> > + * Instrument reads from kernel memory, that are due to copy_to_user (and
> > + * variants).
> > + *
> > + * The instrumentation must be inserted after the accesses. At this point the
> > + * actual number of bytes accessed should be known.
> > + *
> > + * @dst destination address
> > + * @size maximum access size
> > + * @left number of bytes left that were not copied
> > + */
> > +static __always_inline void
> > +instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
> > +{
> > +       /* Check after, to avoid false positive if memory was not accessed. */
> > +       kcsan_check_read(src, size - left);
>
> Why don't we check the full range?
> Kernel intending to copy something racy to user already looks like a
> bug to me, even if user-space has that page unmapped. User-space can
> always make the full range succeed. What am I missing?

Fair enough. I can move this into the pre-hooks in v2.

However, note that, that leaves us with a bunch of empty post-hooks in
the patch. While this will probably change when we get KMSAN, is it
reasonable to keep them empty for now?

Thanks,
-- Marco
