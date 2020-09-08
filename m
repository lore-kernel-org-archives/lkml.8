Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2520768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgIHUAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:00:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbgIHPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F5BBB605;
        Tue,  8 Sep 2020 14:40:02 +0000 (UTC)
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, paulmck@kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20200907134055.2878499-1-elver@google.com>
 <4dc8852a-120d-0835-1dc4-1a91f8391c8a@suse.cz>
 <CAG_fn=UdnN4EL6OtAV8RY7kuqO+VXqSsf+grx2Le64UQJOUMvQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1c4a5a6e-1f11-b04f-ebd0-17919ba93bca@suse.cz>
Date:   Tue, 8 Sep 2020 16:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UdnN4EL6OtAV8RY7kuqO+VXqSsf+grx2Le64UQJOUMvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 2:16 PM, Alexander Potapenko wrote:
>> Toggling a static branch is AFAIK quite disruptive (PeterZ will probably tell
>> you better), and with the default 100ms sample interval, I'd think it's not good
>> to toggle it so often? Did you measure what performance would you get, if the
>> static key was only for long-term toggling the whole feature on and off (boot
>> time or even runtime), but the decisions "am I in a sample interval right now?"
>> would be normal tests behind this static key? Thanks.
> 
> 100ms is the default that we use for testing, but for production it
> should be fine to pick a longer interval (e.g. 1 second or more).
> We haven't noticed any performance impact with neither 100ms nor bigger values.

Hmm, I see.

> Regarding using normal branches, they are quite expensive.
> E.g. at some point we used to have a branch in slab_free() to check
> whether the freed object belonged to KFENCE pool.
> When the pool address was taken from memory, this resulted in some
> non-zero performance penalty.

Well yeah, if the checks involve extra cache misses, that adds up. But AFAICS
you can't avoid that kind of checks with static key anyway (am I looking right
at is_kfence_address()?) because some kfence-allocated objects will exist even
after the sampling period ended, right?
So AFAICS kfence_alloc() is the only user of the static key and I wonder if it
really makes such difference there.

> As for enabling the whole feature at runtime, our intention is to let
> the users have it enabled by default, otherwise someone will need to
> tell every machine in the fleet when the feature is to be enabled.

Sure, but I guess there are tools that make it no difference in effort between 1
machine and fleet.

I'll try to explain my general purpose distro-kernel POV. What I like e.g. about
debug_pagealloc and page_owner (and contributed to that state of these features)
is that a distro kernel can be shipped with them compiled in, but they are
static-key disabled thus have no overhead, until a user enables them on boot,
without a need to replace the kernel with a debug one first. Users can enable
them for their own debugging, or when asked by somebody from the distro
assisting with the debugging.

I think KFENCE has similar potential and could work the same way - compiled in
always, but a static key would eliminate everything, even the
is_kfence_address() checks, until it became enabled (but then it would probably
be a one-way street for the rest of the kernel's uptime). Some distro users
would decide to enable it always, some not, but could be advised to when needed.
So the existing static key could be repurposed for this, or if it's really worth
having the current one to control just the sampling period, then there would be two?

Thanks.

>> > We have verified by running synthetic benchmarks (sysbench I/O,
>> > hackbench) that a kernel with KFENCE is performance-neutral compared to
>> > a non-KFENCE baseline kernel.
>> >
>> > KFENCE is inspired by GWP-ASan [1], a userspace tool with similar
>> > properties. The name "KFENCE" is a homage to the Electric Fence Malloc
>> > Debugger [2].
>> >
>> > For more details, see Documentation/dev-tools/kfence.rst added in the
>> > series -- also viewable here:
>> >
>> >       https://raw.githubusercontent.com/google/kasan/kfence/Documentation/dev-tools/kfence.rst
>> >
>> > [1] http://llvm.org/docs/GwpAsan.html
>> > [2] https://linux.die.net/man/3/efence
>> >
>> > Alexander Potapenko (6):
>> >   mm: add Kernel Electric-Fence infrastructure
>> >   x86, kfence: enable KFENCE for x86
>> >   mm, kfence: insert KFENCE hooks for SLAB
>> >   mm, kfence: insert KFENCE hooks for SLUB
>> >   kfence, kasan: make KFENCE compatible with KASAN
>> >   kfence, kmemleak: make KFENCE compatible with KMEMLEAK
>> >
>> > Marco Elver (4):
>> >   arm64, kfence: enable KFENCE for ARM64
>> >   kfence, lockdep: make KFENCE compatible with lockdep
>> >   kfence, Documentation: add KFENCE documentation
>> >   kfence: add test suite
>> >
>> >  Documentation/dev-tools/index.rst  |   1 +
>> >  Documentation/dev-tools/kfence.rst | 285 +++++++++++
>> >  MAINTAINERS                        |  11 +
>> >  arch/arm64/Kconfig                 |   1 +
>> >  arch/arm64/include/asm/kfence.h    |  39 ++
>> >  arch/arm64/mm/fault.c              |   4 +
>> >  arch/x86/Kconfig                   |   2 +
>> >  arch/x86/include/asm/kfence.h      |  60 +++
>> >  arch/x86/mm/fault.c                |   4 +
>> >  include/linux/kfence.h             | 174 +++++++
>> >  init/main.c                        |   2 +
>> >  kernel/locking/lockdep.c           |   8 +
>> >  lib/Kconfig.debug                  |   1 +
>> >  lib/Kconfig.kfence                 |  70 +++
>> >  mm/Makefile                        |   1 +
>> >  mm/kasan/common.c                  |   7 +
>> >  mm/kfence/Makefile                 |   6 +
>> >  mm/kfence/core.c                   | 730 +++++++++++++++++++++++++++
>> >  mm/kfence/kfence-test.c            | 777 +++++++++++++++++++++++++++++
>> >  mm/kfence/kfence.h                 | 104 ++++
>> >  mm/kfence/report.c                 | 201 ++++++++
>> >  mm/kmemleak.c                      |  11 +
>> >  mm/slab.c                          |  46 +-
>> >  mm/slab_common.c                   |   6 +-
>> >  mm/slub.c                          |  72 ++-
>> >  25 files changed, 2591 insertions(+), 32 deletions(-)
>> >  create mode 100644 Documentation/dev-tools/kfence.rst
>> >  create mode 100644 arch/arm64/include/asm/kfence.h
>> >  create mode 100644 arch/x86/include/asm/kfence.h
>> >  create mode 100644 include/linux/kfence.h
>> >  create mode 100644 lib/Kconfig.kfence
>> >  create mode 100644 mm/kfence/Makefile
>> >  create mode 100644 mm/kfence/core.c
>> >  create mode 100644 mm/kfence/kfence-test.c
>> >  create mode 100644 mm/kfence/kfence.h
>> >  create mode 100644 mm/kfence/report.c
>> >
>>
> 
> 

