Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CB120739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCTNjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:39:31 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46300 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:39:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jFHrn-00Ax8I-UW; Fri, 20 Mar 2020 14:39:16 +0100
Message-ID: <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Fri, 20 Mar 2020 14:39:13 +0100
In-Reply-To: <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com> (sfid-20200311_183506_748492_1435E277)
References: <20200226004608.8128-1-trishalfonso@google.com>
         <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
         <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
         <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
         <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
         (sfid-20200311_183506_748492_1435E277)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 18:34 +0100, Dmitry Vyukov wrote:

> > $ gdb -p ...
> > (gdb) p/x task_size
> > $1 = 0x7fc0000000
> > (gdb) p/x __end_of_fixed_addresses
> > $2 = 0x0
> > (gdb) p/x end_iomem
> > $3 = 0x70000000
> > (gdb) p/x __va_space
> > 
> > #define TASK_SIZE (task_size)
> > #define FIXADDR_TOP        (TASK_SIZE - 2 * PAGE_SIZE)
> > 
> > #define FIXADDR_START      (FIXADDR_TOP - FIXADDR_SIZE)
> > #define FIXADDR_SIZE       (__end_of_fixed_addresses << PAGE_SHIFT)
> > 
> > #define VMALLOC_END       (FIXADDR_START-2*PAGE_SIZE)
> > 
> > #define MODULES_VADDR   VMALLOC_START
> > #define MODULES_END       VMALLOC_END
> > #define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> > #define VMALLOC_OFFSET  (__va_space)
> > #define __va_space (8*1024*1024)
> > 
> > 
> > So from that, it would look like the UML vmalloc area is from
> > 0x  70800000 all the way to
> > 0x7fbfffc000, which obviously clashes with the KASAN_SHADOW_OFFSET being
> > just 0x7fff8000.
> > 
> > 
> > I'm guessing that basically the module loading overwrote the kasan
> > shadow then?
> 
> Well, ok, this is definitely not going to fly :)

Yeah, not with vmalloc/modules at least, but you can't really prevent
vmalloc :)

> I don't know if it's easy to move modules to a different location.

We'd have to not just move modules, but also vmalloc space. They're one
and the same in UML.

> It
> would be nice because 0x7fbfffc000 is the shadow start that's used in
> userspace asan and it allows to faster instrumentation (if offset is
> within first 2 gigs, the instruction encoding is much more compact,
> for >2gigs it will require several instructions).

Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
confused the values - because I see, on userspace, the following:

|| `[0x10007fff8000, 0x7fffffffffff]` || HighMem    ||
|| `[0x02008fff7000, 0x10007fff7fff]` || HighShadow ||
|| `[0x00008fff7000, 0x02008fff6fff]` || ShadowGap  ||
|| `[0x00007fff8000, 0x00008fff6fff]` || LowShadow  ||
|| `[0x000000000000, 0x00007fff7fff]` || LowMem     ||


Now, I also don't really understand what UML is doing here -
os_get_top_address() determines some sort of "top address"? But all that
is only on 32-bit, on 64-bit, that's always 0x7fc0000000.

So basically that means it's just _slightly_ higher than what you
suggested as the KASAN_SHADOW_OFFSET now (even if erroneously?), and
shouldn't actually clash (and we can just change the top address value
to be slightly lower anyway to prevent clashing).

> But if it's not really easy, I guess we go with a large shadow start
> (at least initially). A slower but working KASAN is better than fast
> non-working KASAN :)

Indeed, but I can't even get it to work regardless of the offset.

Note that I have lockdep enabled, and at least some crashes appear to be
because of the stack unwinding code that is called by lockdep in various
situations...

> > I tried changing it
> > 
> >  config KASAN_SHADOW_OFFSET
> >         hex
> >         depends on KASAN
> > -       default 0x7fff8000
> > +       default 0x8000000000
> > 
> > 
> > and also put a check in like this:
> > 
> > +++ b/arch/um/kernel/um_arch.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/kmsg_dump.h>
> > +#include <linux/kasan.h>
> > 
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> > @@ -267,9 +268,11 @@ int __init linux_main(int argc, char **argv)
> >         /*
> >          * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
> >          * out
> >          */
> >         task_size = host_task_size & PGDIR_MASK;
> > 
> > +       if (task_size > KASAN_SHADOW_OFFSET)
> > +               panic("KASAN shadow offset must be bigger than task size");
> > 
> > 
> > but now I just crash accessing the shadow even though it was mapped fine?
> 
> Yes, this is puzzling.
> I noticed that RIP is the same in both cases and it relates to vmap code.
> A support for shadow for vmalloced-memory was added to KASAN recently
> and I suspect it may conflict with UML.

This can't be it - HAVE_ARCH_KASAN_VMALLOC isn't selected, so
KASAN_VMALLOC isn't set.

> What does pte-manipulation code even do under UML?

No idea.

> Looking at the code around, kasan_mem_notifier may be a problem too,
> or at least excessive and confusing. We already have shadow for
> everything, we don't need _any_ of dynamic/lazy shadow mapping.

CONFIG_MEMORY_HOTPLUG is also not supported in ARCH=um, or at least not
used in my config.

johannes

