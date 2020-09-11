Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42773C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78362076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5Thz3ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgIKHqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgIKHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:46:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6798C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:46:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so7596050otq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAMAwKSgCkhLU1+HorKufuFkvoMc/AqgwnyXt9BkPkw=;
        b=A5Thz3ngEySbjfQozNWoh6kyDeOr9U6skoRVGg6dpWiZCUKS2cXHgK8tKD97zWjqBE
         h/JSJu8GJQFzRXDX/ojxxmD7e+K9lbeeqIiAm/dBnmcP9SZfZfisp48POI2qfeVDvKN4
         kRr9SzvaFldUyo1Y6OrPSB/pLYYgrZLOlEYEgFFf1oxcpVMLssBUvqrLQpd484fy4iwQ
         vtGirE+noKTJfQ+81hdDrwTnR1rcXTFqkbqUMbHKJdJjlh3KKzJr3sssp7tjvVGnZ70S
         HmUEQ9PCplcYemrPHsRJsREXcKs00sRDlJ4oSXRFnkfeQ2IRVxArxrOpaP0/WT9osDjA
         B/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAMAwKSgCkhLU1+HorKufuFkvoMc/AqgwnyXt9BkPkw=;
        b=MmuDhpjhSEUAXJftrVCEPhzbj+Mw+oh48H0Yb7tQ875Qh2W4yPDl1eRUImicMQ0ue9
         YEl3jaR7hQFZPfN+4Im7d8MLgzYE0bofEyVjNB8ns4dgICu+RdPKMWYrLJGgv3J+YJYY
         rS5ZZeQyUnxQSMFmNwhQDH50XsoTgmsJqeLmwGleAD/CfU3UB0frkXGeokbzXco5py1R
         vBmupRvjG14n117CTDmkp7iCaVYo6oDwTInl3sKqEXK3JkfAtsahvn9XkKuzwarRVuPL
         V0+f2iZqJdr51UTzJcElrcdCMly5UzXLiCN1+SezewO6Huy8YYA26+K3I5Z+yEVLkU7z
         6qTw==
X-Gm-Message-State: AOAM532PiAhJKMGxtVtFyR6+XYOjEtX8MfEPwjQLjRdR+iiau1Ld73Hn
        qaT5OsUN4ixJmtqgVG6GiEghqbTXBAQ+u7CcOkgw7A==
X-Google-Smtp-Source: ABdhPJxJoE5Uy6/u1TcmkOLjmHnuPd866OCz1co/k8yFa1X9QStslGeejlqv2wmuOYIl/lxDwiQ7sCHLJOT6KEt2gvk=
X-Received: by 2002:a9d:3da1:: with SMTP id l30mr459810otc.233.1599810372977;
 Fri, 11 Sep 2020 00:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-10-elver@google.com>
 <CACT4Y+b-RPYpqErLVPh+qtiuv_LhCyxLE_DJqbM0jegFd_nOKQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b-RPYpqErLVPh+qtiuv_LhCyxLE_DJqbM0jegFd_nOKQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Sep 2020 09:46:01 +0200
Message-ID: <CANpmjNOkGChKcav-zRLUTS1tsobXNkounFGSVp0srEk5BDGweg@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] kfence, Documentation: add KFENCE documentation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 at 09:14, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
> >
> > Add KFENCE documentation in dev-tools/kfence.rst, and add to index.
> >
> > Co-developed-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  Documentation/dev-tools/index.rst  |   1 +
> >  Documentation/dev-tools/kfence.rst | 285 +++++++++++++++++++++++++++++
> >  2 files changed, 286 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kfence.rst
> >
> > diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
> > index f7809c7b1ba9..1b1cf4f5c9d9 100644
> > --- a/Documentation/dev-tools/index.rst
> > +++ b/Documentation/dev-tools/index.rst
> > @@ -22,6 +22,7 @@ whole; patches welcome!
> >     ubsan
> >     kmemleak
> >     kcsan
> > +   kfence
> >     gdb-kernel-debugging
> >     kgdb
> >     kselftest
> > diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
> > new file mode 100644
> > index 000000000000..254f4f089104
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kfence.rst
> > @@ -0,0 +1,285 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel Electric-Fence (KFENCE)
> > +==============================
> > +
> > +Kernel Electric-Fence (KFENCE) is a low-overhead sampling-based memory safety
> > +error detector. KFENCE detects heap out-of-bounds access, use-after-free, and
> > +invalid-free errors.
> > +
> > +KFENCE is designed to be enabled in production kernels, and has near zero
> > +performance overhead. Compared to KASAN, KFENCE trades performance for
> > +precision. The main motivation behind KFENCE's design, is that with enough
> > +total uptime KFENCE will detect bugs in code paths not typically exercised by
> > +non-production test workloads. One way to quickly achieve a large enough total
> > +uptime is when the tool is deployed across a large fleet of machines.
> > +
> > +Usage
> > +-----
> > +
> > +To enable KFENCE, configure the kernel with::
> > +
> > +    CONFIG_KFENCE=y
> > +
> > +KFENCE provides several other configuration options to customize behaviour (see
> > +the respective help text in ``lib/Kconfig.kfence`` for more info).
> > +
> > +Tuning performance
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +The most important parameter is KFENCE's sample interval, which can be set via
> > +the kernel boot parameter ``kfence.sample_interval`` in milliseconds. The
> > +sample interval determines the frequency with which heap allocations will be
> > +guarded by KFENCE. The default is configurable via the Kconfig option
> > +``CONFIG_KFENCE_SAMPLE_INTERVAL``. Setting ``kfence.sample_interval=0``
> > +disables KFENCE.
> > +
> > +With the Kconfig option ``CONFIG_KFENCE_NUM_OBJECTS`` (default 255), the number
> > +of available guarded objects can be controlled. Each object requires 2 pages,
> > +one for the object itself and the other one used as a guard page; object pages
> > +are interleaved with guard pages, and every object page is therefore surrounded
> > +by two guard pages.
> > +
> > +The total memory dedicated to the KFENCE memory pool can be computed as::
> > +
> > +    ( #objects + 1 ) * 2 * PAGE_SIZE
> > +
> > +Using the default config, and assuming a page size of 4 KiB, results in
> > +dedicating 2 MiB to the KFENCE memory pool.
> > +
> > +Error reports
> > +~~~~~~~~~~~~~
> > +
> > +A typical out-of-bounds access looks like this::
> > +
> > +    ==================================================================
> > +    BUG: KFENCE: out-of-bounds in test_out_of_bounds_read+0xa3/0x22b
> > +
> > +    Out-of-bounds access at 0xffffffffb672efff (left of kfence-#17):
> > +     test_out_of_bounds_read+0xa3/0x22b
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=32, cache=kmalloc-32] allocated in:
> > +     __kfence_alloc+0x42d/0x4c0
> > +     __kmalloc+0x133/0x200
> > +     test_alloc+0xf3/0x25b
> > +     test_out_of_bounds_read+0x98/0x22b
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    CPU: 4 PID: 107 Comm: kunit_try_catch Not tainted 5.8.0-rc6+ #7
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +The header of the report provides a short summary of the function involved in
> > +the access. It is followed by more detailed information about the access and
> > +its origin.
> > +
> > +Use-after-free accesses are reported as::
> > +
> > +    ==================================================================
> > +    BUG: KFENCE: use-after-free in test_use_after_free_read+0xb3/0x143
> > +
> > +    Use-after-free access at 0xffffffffb673dfe0:
> > +     test_use_after_free_read+0xb3/0x143
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    kfence-#24 [0xffffffffb673dfe0-0xffffffffb673dfff, size=32, cache=kmalloc-32] allocated in:
> > +     __kfence_alloc+0x277/0x4c0
> > +     __kmalloc+0x133/0x200
> > +     test_alloc+0xf3/0x25b
> > +     test_use_after_free_read+0x76/0x143
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
>
> Empty line between stacks for consistency and readability.

Done for v2.

> > +    freed in:
> > +     kfence_guarded_free+0x158/0x380
> > +     __kfence_free+0x38/0xc0
> > +     test_use_after_free_read+0xa8/0x143
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    CPU: 4 PID: 109 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +KFENCE also reports on invalid frees, such as double-frees::
> > +
> > +    ==================================================================
> > +    BUG: KFENCE: invalid free in test_double_free+0xdc/0x171
> > +
> > +    Invalid free of 0xffffffffb6741000:
> > +     test_double_free+0xdc/0x171
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    kfence-#26 [0xffffffffb6741000-0xffffffffb674101f, size=32, cache=kmalloc-32] allocated in:
> > +     __kfence_alloc+0x42d/0x4c0
> > +     __kmalloc+0x133/0x200
> > +     test_alloc+0xf3/0x25b
> > +     test_double_free+0x76/0x171
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +    freed in:
> > +     kfence_guarded_free+0x158/0x380
> > +     __kfence_free+0x38/0xc0
> > +     test_double_free+0xa8/0x171
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    CPU: 4 PID: 111 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +KFENCE also uses pattern-based redzones on the other side of an object's guard
> > +page, to detect out-of-bounds writes on the unprotected side of the object.
> > +These are reported on frees::
> > +
> > +    ==================================================================
> > +    BUG: KFENCE: memory corruption in test_kmalloc_aligned_oob_write+0xef/0x184
> > +
> > +    Detected corrupted memory at 0xffffffffb6797ff9 [ 0xac . . . . . . ]:
> > +     test_kmalloc_aligned_oob_write+0xef/0x184
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    kfence-#69 [0xffffffffb6797fb0-0xffffffffb6797ff8, size=73, cache=kmalloc-96] allocated in:
> > +     __kfence_alloc+0x277/0x4c0
> > +     __kmalloc+0x133/0x200
> > +     test_alloc+0xf3/0x25b
> > +     test_kmalloc_aligned_oob_write+0x57/0x184
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    CPU: 4 PID: 120 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +For such errors, the address where the corruption as well as the corrupt bytes
> > +are shown.
> > +
> > +And finally, KFENCE may also report on invalid accesses to any protected page
> > +where it was not possible to determine an associated object, e.g. if adjacent
> > +object pages had not yet been allocated::
> > +
> > +    ==================================================================
> > +    BUG: KFENCE: invalid access in test_invalid_access+0x26/0xe0
> > +
> > +    Invalid access at 0xffffffffb670b00a:
> > +     test_invalid_access+0x26/0xe0
> > +     kunit_try_run_case+0x51/0x85
> > +     kunit_generic_run_threadfn_adapter+0x16/0x30
> > +     kthread+0x137/0x160
> > +     ret_from_fork+0x22/0x30
> > +
> > +    CPU: 4 PID: 124 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
> > +    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > +    ==================================================================
> > +
> > +DebugFS interface
> > +~~~~~~~~~~~~~~~~~
> > +
> > +Some debugging information is exposed via debugfs:
> > +
> > +* The file ``/sys/kernel/debug/kfence/stats`` provides runtime statistics.
> > +
> > +* The file ``/sys/kernel/debug/kfence/objects`` provides a list of objects
> > +  allocated via KFENCE, including those already freed but protected.
> > +
> > +Implementation Details
> > +----------------------
> > +
> > +Guarded allocations are set up based on the sample interval. After expiration
> > +of the sample interval, a guarded allocation from the KFENCE object pool is
> > +returned to the main allocator (SLAB or SLUB). At this point, the timer is
> > +reset, and the next allocation is set up after the expiration of the interval.
> > +To "gate" a KFENCE allocation through the main allocator's fast-path without
> > +overhead, KFENCE relies on static branches via the static keys infrastructure.
> > +The static branch is toggled to redirect the allocation to KFENCE.
> > +
> > +KFENCE objects each reside on a dedicated page, at either the left or right
>
> Do we mention anywhere explicitly that KFENCE currently only supports
> allocations <=page_size?
> May be worth mentioning. It kinda follows from implementation but
> quite implicitly. One may also be confused assuming KFENCE handles
> larger allocations, but then not being able to figure out.

We can add a note that "allocation sizes up to PAGE_SIZE are supported".

Thanks,
-- Marco
