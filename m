Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D0B2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAWqvZMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgIGR4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgIGRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:55:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DBC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 10:55:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a8so4753799plm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4B8wz43QQLuWWblupatTWjpJe93fxRU2T0MWJH8f8E=;
        b=NAWqvZMHlmPQJJm5AQMU0Fqio6pVD2tnoBrz4YgSAWEk++3ZTLa9YQoz9d3TgWcSS5
         R/H8I7U0QozFU9rsOB6S1tdUd+ael3kRLTedDueuzH9j3llPup03JCsFlAioE0CLwmb7
         0hMcan3bIGfMSMD4nvyowJayksmZo1d7PKbWcbAzI3vgIMMR6om2JatKFpIqbNKlj/H8
         DP2xkpTLZBgulmjFqeyTbJc9z+uE31rV7U32ZaHwyzef3DWHkWXz4AEBZd0zbQynytTy
         q1ySZ7GBm44C4EQiqcGLWLpAAF3xHhoDEss6EKY2c9nMEqwm4C5nI+rrfpgkDMtgiBfX
         Ntfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4B8wz43QQLuWWblupatTWjpJe93fxRU2T0MWJH8f8E=;
        b=F5N6s2XFUQT9QaYWmYQ08OwFLp//vel/JAuKgPb2ECZUDKJlb23IkKJe8a4FHbJhNM
         KppDE25+Fjoa74FADfDbbfkvUeRyMhJcQPqmsh9b3IggDFW74WGrwBLa/b7tV/zR8c3d
         jqXAp1CvtmrW7mPeLlHutA2fXarkE6E/EA0+OEdhcxcw00snqIimz6h/sWGMWOSC50lf
         3vQcC3S5n98xOqASlcr3QSMvapLMtv8cilu6ByhAFz3XPEJmGsxmYkhb4JWR/F8hE3Y9
         OdGMLkfmcIYsTFNVwcUwfzXXMs7ovf63GodLlvOFFQJvkXcZwVoQdFBxjPRV9FdLUc3p
         ph/A==
X-Gm-Message-State: AOAM531lcxCC/RWrJg8r7dIGmycaSEaiFFCwQDN/yTOZEdSaSCl365rd
        MiE6MEt+uMBwRiNzCdRpTzip/9intasy7CsfIAMcLg==
X-Google-Smtp-Source: ABdhPJzolJVYZEv1F1ujJY7UUGd/gpHugBunzuUe0jhzEq1gWG+MDg3rUz4M6Rbxq54vA6nmfkSZKbxgoJEog82WMD4=
X-Received: by 2002:a17:90b:140c:: with SMTP id jo12mr383099pjb.41.1599501342008;
 Mon, 07 Sep 2020 10:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-10-elver@google.com>
 <CAAeHK+zGpJd6szPounYz6wogO9TMT18TmQu_mfXUWQd65QTf0w@mail.gmail.com> <CANpmjNM14iW8vDuLANrCGBds930r2bZ=gwkoqORpuLa5-8gW6g@mail.gmail.com>
In-Reply-To: <CANpmjNM14iW8vDuLANrCGBds930r2bZ=gwkoqORpuLa5-8gW6g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 7 Sep 2020 19:55:31 +0200
Message-ID: <CAAeHK+w35Aqt8csAvBHg5rcKHm4cL0rPCM4VupfyG-58eMK-UQ@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] kfence, Documentation: add KFENCE documentation
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 6:33 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 7 Sep 2020 at 17:34, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Add KFENCE documentation in dev-tools/kfence.rst, and add to index.
> > >
> > > Co-developed-by: Alexander Potapenko <glider@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  Documentation/dev-tools/index.rst  |   1 +
> > >  Documentation/dev-tools/kfence.rst | 285 +++++++++++++++++++++++++++++
> > >  2 files changed, 286 insertions(+)
> > >  create mode 100644 Documentation/dev-tools/kfence.rst
> > >
> > > diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> > > index f7809c7b1ba9..1b1cf4f5c9d9 100644
> > > --- a/Documentation/dev-tools/index.rst
> > > +++ b/Documentation/dev-tools/index.rst
> > > @@ -22,6 +22,7 @@ whole; patches welcome!
> > >     ubsan
> > >     kmemleak
> > >     kcsan
> > > +   kfence
> > >     gdb-kernel-debugging
> > >     kgdb
> > >     kselftest
> > > diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
> > > new file mode 100644
> > > index 000000000000..254f4f089104
> > > --- /dev/null
> > > +++ b/Documentation/dev-tools/kfence.rst
> > > @@ -0,0 +1,285 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +Kernel Electric-Fence (KFENCE)
> > > +==============================
> > > +
> > > +Kernel Electric-Fence (KFENCE) is a low-overhead sampling-based memory safety
> > > +error detector. KFENCE detects heap out-of-bounds access, use-after-free, and
> > > +invalid-free errors.
> > > +
> > > +KFENCE is designed to be enabled in production kernels, and has near zero
> > > +performance overhead. Compared to KASAN, KFENCE trades performance for
> > > +precision. The main motivation behind KFENCE's design, is that with enough
> > > +total uptime KFENCE will detect bugs in code paths not typically exercised by
> > > +non-production test workloads. One way to quickly achieve a large enough total
> > > +uptime is when the tool is deployed across a large fleet of machines.
> > > +
> > > +Usage
> > > +-----
> > > +
> > > +To enable KFENCE, configure the kernel with::
> > > +
> > > +    CONFIG_KFENCE=y
> > > +
> > > +KFENCE provides several other configuration options to customize behaviour (see
> > > +the respective help text in ``lib/Kconfig.kfence`` for more info).
> > > +
> > > +Tuning performance
> > > +~~~~~~~~~~~~~~~~~~
> > > +
> > > +The most important parameter is KFENCE's sample interval, which can be set via
> > > +the kernel boot parameter ``kfence.sample_interval`` in milliseconds. The
> > > +sample interval determines the frequency with which heap allocations will be
> > > +guarded by KFENCE. The default is configurable via the Kconfig option
> > > +``CONFIG_KFENCE_SAMPLE_INTERVAL``. Setting ``kfence.sample_interval=0``
> > > +disables KFENCE.
> > > +
> > > +With the Kconfig option ``CONFIG_KFENCE_NUM_OBJECTS`` (default 255), the number
> > > +of available guarded objects can be controlled. Each object requires 2 pages,
> > > +one for the object itself and the other one used as a guard page; object pages
> > > +are interleaved with guard pages, and every object page is therefore surrounded
> > > +by two guard pages.
> > > +
> > > +The total memory dedicated to the KFENCE memory pool can be computed as::
> > > +
> > > +    ( #objects + 1 ) * 2 * PAGE_SIZE
> > > +
> > > +Using the default config, and assuming a page size of 4 KiB, results in
> > > +dedicating 2 MiB to the KFENCE memory pool.
> > > +
> > > +Error reports
> > > +~~~~~~~~~~~~~
> > > +
> > > +A typical out-of-bounds access looks like this::
> > > +
> > > +    ==================================================================
> > > +    BUG: KFENCE: out-of-bounds in test_out_of_bounds_read+0xa3/0x22b
> > > +
> > > +    Out-of-bounds access at 0xffffffffb672efff (left of kfence-#17):
> > > +     test_out_of_bounds_read+0xa3/0x22b
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=32, cache=kmalloc-32] allocated in:
> >
> > Does the user need to know that this is object #17? This doesn't seem
> > like something that can be useful for anything.
>
> Some arguments for keeping it:
>
> - We need to write something like "left of <object>". And then we need
> to say where <object> is allocated. Giving objects names makes it
> easier to understand the link between "left of <object>" and the
> stacktrace shown after "<object> allocated in". We could make <object>
> just "object", but reading "left/right of object" and then "object
> allocated in:" can be a little confusing.
>
> - We can look up the object via its number in the debugfs objects list
> (/sys/kernel/debug/kfence/objects). For example, if we see an OOB
> access, we can then check the objects file and see if the object is
> still allocated or not, or if it has been recycled.
>
> I don't believe it's distracting anyone, and if there is a chance that
> keeping this information can help debug a problem, we ought to keep
> it.
>
> > > +     __kfence_alloc+0x42d/0x4c0
> > > +     __kmalloc+0x133/0x200
> > > +     test_alloc+0xf3/0x25b
> > > +     test_out_of_bounds_read+0x98/0x22b
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    CPU: 4 PID: 107 Comm: kunit_try_catch Not tainted 5.8.0-rc6+ #7
> > > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > +    ==================================================================
> > > +
> > > +The header of the report provides a short summary of the function involved in
> > > +the access. It is followed by more detailed information about the access and
> > > +its origin.
> > > +
> > > +Use-after-free accesses are reported as::
> > > +
> > > +    ==================================================================
> > > +    BUG: KFENCE: use-after-free in test_use_after_free_read+0xb3/0x143
> > > +
> > > +    Use-after-free access at 0xffffffffb673dfe0:
> > > +     test_use_after_free_read+0xb3/0x143
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    kfence-#24 [0xffffffffb673dfe0-0xffffffffb673dfff, size=32, cache=kmalloc-32] allocated in:
> >
> > Same here.
> >
> > Also, this says object #24, but the stack trace above doesn't mention
> > which object it is. Is it the same one?
>
> Right, the above stacktrace should then say "kfence-#24". (But the
> address also hints at this.)
>
> > > +     __kfence_alloc+0x277/0x4c0
> > > +     __kmalloc+0x133/0x200
> > > +     test_alloc+0xf3/0x25b
> > > +     test_use_after_free_read+0x76/0x143
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +    freed in:
> > > +     kfence_guarded_free+0x158/0x380
> > > +     __kfence_free+0x38/0xc0
> > > +     test_use_after_free_read+0xa8/0x143
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    CPU: 4 PID: 109 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > +    ==================================================================
> > > +
> > > +KFENCE also reports on invalid frees, such as double-frees::
> > > +
> > > +    ==================================================================
> > > +    BUG: KFENCE: invalid free in test_double_free+0xdc/0x171
> > > +
> > > +    Invalid free of 0xffffffffb6741000:
> > > +     test_double_free+0xdc/0x171
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    kfence-#26 [0xffffffffb6741000-0xffffffffb674101f, size=32, cache=kmalloc-32] allocated in:
> > > +     __kfence_alloc+0x42d/0x4c0
> > > +     __kmalloc+0x133/0x200
> > > +     test_alloc+0xf3/0x25b
> > > +     test_double_free+0x76/0x171
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +    freed in:
> > > +     kfence_guarded_free+0x158/0x380
> > > +     __kfence_free+0x38/0xc0
> > > +     test_double_free+0xa8/0x171
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    CPU: 4 PID: 111 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > +    ==================================================================
> > > +
> > > +KFENCE also uses pattern-based redzones on the other side of an object's guard
> > > +page, to detect out-of-bounds writes on the unprotected side of the object.
> > > +These are reported on frees::
> > > +
> > > +    ==================================================================
> > > +    BUG: KFENCE: memory corruption in test_kmalloc_aligned_oob_write+0xef/0x184
> > > +
> > > +    Detected corrupted memory at 0xffffffffb6797ff9 [ 0xac . . . . . . ]:
> >
> > It's not really clear what is 0xac here. Value of the corrupted byte?
> > What does '.' stand for?
>
> We can probably explain that better below. The values are the corrupt
> bytes, the '.' are untouched bytes.
>
> > Also, if this is to be used in production, printing kernel memory
> > bytes might lead to info-leaks.
>
> We do not print them if !CONFIG_DEBUG_KERNEL, and instead show '!' for
> changed bytes. Maybe we can add this somewhere here as well.
>
> > > +     test_kmalloc_aligned_oob_write+0xef/0x184
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    kfence-#69 [0xffffffffb6797fb0-0xffffffffb6797ff8, size=73, cache=kmalloc-96] allocated in:
> > > +     __kfence_alloc+0x277/0x4c0
> > > +     __kmalloc+0x133/0x200
> > > +     test_alloc+0xf3/0x25b
> > > +     test_kmalloc_aligned_oob_write+0x57/0x184
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    CPU: 4 PID: 120 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > +    ==================================================================
> > > +
> > > +For such errors, the address where the corruption as well as the corrupt bytes
> > > +are shown.
> > > +
> > > +And finally, KFENCE may also report on invalid accesses to any protected page
> > > +where it was not possible to determine an associated object, e.g. if adjacent
> > > +object pages had not yet been allocated::
> > > +
> > > +    ==================================================================
> > > +    BUG: KFENCE: invalid access in test_invalid_access+0x26/0xe0
> > > +
> > > +    Invalid access at 0xffffffffb670b00a:
> > > +     test_invalid_access+0x26/0xe0
> > > +     kunit_try_run_case+0x51/0x85
> > > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > > +     kthread+0x137/0x160
> > > +     ret_from_fork+0x22/0x30
> > > +
> > > +    CPU: 4 PID: 124 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > > +    ==================================================================
> > > +
> > > +DebugFS interface
> > > +~~~~~~~~~~~~~~~~~
> > > +
> > > +Some debugging information is exposed via debugfs:
> > > +
> > > +* The file ``/sys/kernel/debug/kfence/stats`` provides runtime statistics.
> > > +
> > > +* The file ``/sys/kernel/debug/kfence/objects`` provides a list of objects
> > > +  allocated via KFENCE, including those already freed but protected.
> > > +
> > > +Implementation Details
> > > +----------------------
> > > +
> > > +Guarded allocations are set up based on the sample interval. After expiration
> > > +of the sample interval, a guarded allocation from the KFENCE object pool is
> > > +returned to the main allocator (SLAB or SLUB).
> >
> > Only for freed allocations, right?
>
> Which "freed allocation"? What this paragraph says is that after the
> sample interval elapsed, we'll return a KFENCE allocation on kmalloc.
> It doesn't yet talk about freeing.

It says that an allocation is returned to the main allocator, and this
is what is usually described with the word "freed". Do you mean
something else here?

> > > At this point, the timer is
> > > +reset, and the next allocation is set up after the expiration of the interval.
> > > +To "gate" a KFENCE allocation through the main allocator's fast-path without
> > > +overhead, KFENCE relies on static branches via the static keys infrastructure.
> > > +The static branch is toggled to redirect the allocation to KFENCE.
> > > +
> > > +KFENCE objects each reside on a dedicated page, at either the left or right
> > > +page boundaries selected at random. The pages to the left and right of the
> > > +object page are "guard pages", whose attributes are changed to a protected
> > > +state, and cause page faults on any attempted access. Such page faults are then
> > > +intercepted by KFENCE, which handles the fault gracefully by reporting an
> > > +out-of-bounds access.
> >
> > I'd start a new paragraph here:
> >
> > > The side opposite of an object's guard page is used as a
> >
> > Not a native speaker, but "The side opposite _to_" sounds better. Or
> > "The opposite side of".
>
> All are fine. Using "to" indicates direction, which in this case is valid too.
>
> > > +pattern-based redzone, to detect out-of-bounds writes on the unprotected sed of
> >
> > "sed"?
>
> side
>
> > > +the object on frees (for special alignment and size combinations, both sides of
> > > +the object are redzoned).
> > > +
> > > +KFENCE also uses pattern-based redzones on the other side of an object's guard
> > > +page, to detect out-of-bounds writes on the unprotected side of the object;
> > > +these are reported on frees.
> >
> > Not really clear, what is "other side" and how it's different from the
> > "opposite side" mentioned above. The figure doesn't really help.
>
> Redzone and guard page sandwich the object. Not sure how I can make it
> clearer yet, but I'll try.
>
> > > +
> > > +The following figure illustrates the page layout::
> > > +
> > > +    ---+-----------+-----------+-----------+-----------+-----------+---
> > > +       | xxxxxxxxx | O :       | xxxxxxxxx |       : O | xxxxxxxxx |
> > > +       | xxxxxxxxx | B :       | xxxxxxxxx |       : B | xxxxxxxxx |
> > > +       | x GUARD x | J : RED-  | x GUARD x | RED-  : J | x GUARD x |
> > > +       | xxxxxxxxx | E :  ZONE | xxxxxxxxx |  ZONE : E | xxxxxxxxx |
> > > +       | xxxxxxxxx | C :       | xxxxxxxxx |       : C | xxxxxxxxx |
> > > +       | xxxxxxxxx | T :       | xxxxxxxxx |       : T | xxxxxxxxx |
> > > +    ---+-----------+-----------+-----------+-----------+-----------+---
> > > +
> > > +Upon deallocation of a KFENCE object, the object's page is again protected and
> > > +the object is marked as freed. Any further access to the object causes a fault
> > > +and KFENCE reports a use-after-free access. Freed objects are inserted at the
> > > +tail of KFENCE's freelist, so that the least recently freed objects are reused
> > > +first, and the chances of detecting use-after-frees of recently freed objects
> > > +is increased.
> >
> > Seems really similar to KASAN's quarantine? Is the implementation much
> > different?
>
> It's a list, and we just insert at the tail. Why does it matter?

If the implementation is similar, we can then reuse quarantine. But I
guess it's not.
