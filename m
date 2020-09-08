Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF26AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17C92098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgIHLwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:52:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgIHLun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:50:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF95EAC6E;
        Tue,  8 Sep 2020 11:48:29 +0000 (UTC)
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Marco Elver <elver@google.com>, glider@google.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mark.rutland@arm.com,
        penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20200907134055.2878499-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4dc8852a-120d-0835-1dc4-1a91f8391c8a@suse.cz>
Date:   Tue, 8 Sep 2020 13:48:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907134055.2878499-1-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 3:40 PM, Marco Elver wrote:
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.  This
> series enables KFENCE for the x86 and arm64 architectures, and adds
> KFENCE hooks to the SLAB and SLUB allocators.
> 
> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.

Looks nice!

> KFENCE objects each reside on a dedicated page, at either the left or
> right page boundaries. The pages to the left and right of the object
> page are "guard pages", whose attributes are changed to a protected
> state, and cause page faults on any attempted access to them. Such page
> faults are then intercepted by KFENCE, which handles the fault
> gracefully by reporting a memory access error.
> 
> Guarded allocations are set up based on a sample interval (can be set
> via kfence.sample_interval). After expiration of the sample interval, a
> guarded allocation from the KFENCE object pool is returned to the main
> allocator (SLAB or SLUB). At this point, the timer is reset, and the
> next allocation is set up after the expiration of the interval.
> 
> To enable/disable a KFENCE allocation through the main allocator's
> fast-path without overhead, KFENCE relies on static branches via the
> static keys infrastructure. The static branch is toggled to redirect the
> allocation to KFENCE.

Toggling a static branch is AFAIK quite disruptive (PeterZ will probably tell
you better), and with the default 100ms sample interval, I'd think it's not good
to toggle it so often? Did you measure what performance would you get, if the
static key was only for long-term toggling the whole feature on and off (boot
time or even runtime), but the decisions "am I in a sample interval right now?"
would be normal tests behind this static key? Thanks.

> We have verified by running synthetic benchmarks (sysbench I/O,
> hackbench) that a kernel with KFENCE is performance-neutral compared to
> a non-KFENCE baseline kernel.
> 
> KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
> properties. The name "KFENCE" is a homage to the Electric Fence Malloc
> Debugger [2].
> 
> For more details, see Documentation/dev-tools/kfence.rst added in the
> series -- also viewable here:
> 
> 	https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst
> 
> [1] http://llvm.org/docs/GwpAsan.html
> [2] https://linux.die.net/man/3/efence
> 
> Alexander Potapenko (6):
>   mm: add Kernel Electric-Fence infrastructure
>   x86, kfence: enable KFENCE for x86
>   mm, kfence: insert KFENCE hooks for SLAB
>   mm, kfence: insert KFENCE hooks for SLUB
>   kfence, kasan: make KFENCE compatible with KASAN
>   kfence, kmemleak: make KFENCE compatible with KMEMLEAK
> 
> Marco Elver (4):
>   arm64, kfence: enable KFENCE for ARM64
>   kfence, lockdep: make KFENCE compatible with lockdep
>   kfence, Documentation: add KFENCE documentation
>   kfence: add test suite
> 
>  Documentation/dev-tools/index.rst  |   1 +
>  Documentation/dev-tools/kfence.rst | 285 +++++++++++
>  MAINTAINERS                        |  11 +
>  arch/arm64/Kconfig                 |   1 +
>  arch/arm64/include/asm/kfence.h    |  39 ++
>  arch/arm64/mm/fault.c              |   4 +
>  arch/x86/Kconfig                   |   2 +
>  arch/x86/include/asm/kfence.h      |  60 +++
>  arch/x86/mm/fault.c                |   4 +
>  include/linux/kfence.h             | 174 +++++++
>  init/main.c                        |   2 +
>  kernel/locking/lockdep.c           |   8 +
>  lib/Kconfig.debug                  |   1 +
>  lib/Kconfig.kfence                 |  70 +++
>  mm/Makefile                        |   1 +
>  mm/kasan/common.c                  |   7 +
>  mm/kfence/Makefile                 |   6 +
>  mm/kfence/core.c                   | 730 +++++++++++++++++++++++++++
>  mm/kfence/kfence-test.c            | 777 +++++++++++++++++++++++++++++
>  mm/kfence/kfence.h                 | 104 ++++
>  mm/kfence/report.c                 | 201 ++++++++
>  mm/kmemleak.c                      |  11 +
>  mm/slab.c                          |  46 +-
>  mm/slab_common.c                   |   6 +-
>  mm/slub.c                          |  72 ++-
>  25 files changed, 2591 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/dev-tools/kfence.rst
>  create mode 100644 arch/arm64/include/asm/kfence.h
>  create mode 100644 arch/x86/include/asm/kfence.h
>  create mode 100644 include/linux/kfence.h
>  create mode 100644 lib/Kconfig.kfence
>  create mode 100644 mm/kfence/Makefile
>  create mode 100644 mm/kfence/core.c
>  create mode 100644 mm/kfence/kfence-test.c
>  create mode 100644 mm/kfence/kfence.h
>  create mode 100644 mm/kfence/report.c
> 

