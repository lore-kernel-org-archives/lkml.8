Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CAC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA1D2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dyq1Yvhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCTPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:18:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43263 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:18:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so1424750qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMdn/vEztvR1JjJusqBbOT1Y2kMsnjTOnNP0m/IulTk=;
        b=Dyq1YvhzCMXXJn5C3ZtTSfvSLGH/jsTRYChDT+32XwQEgscbnwPh3yTchjEuWiOl7y
         gqyHg15oGFEyqu9dRA9MQ9zJs1BUkymVQwrs589VVRq9LP/7lfpwwBhs7eW8A0ifbXwm
         AfP0CpEXgSQNeN5tnkDHE78f3txWsKMmHpdm2r+G0/InoZbJwhIl2TtIK3/JIuWhor18
         er4D8FHEDc4bzwueUYtW+ONFWM8JZ4BcxQl7Y+U4T2RRB85Epu9HhCTTCoADot4PRsIb
         Ps0omVR6YqqE6fhI7uvdlZ4GZ/3uyRPr9hpjljGF51PBLEamauaDTCUqzPPy0Q85Dicm
         4v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMdn/vEztvR1JjJusqBbOT1Y2kMsnjTOnNP0m/IulTk=;
        b=RZXHiedHq19oADIRFRDf5Y4SNkAvB3CpPZalWu8x+vvcPuxJx4l28XeifbamQtEjkm
         EGyf5pCyE9dgaI5rETVcWpS72nDpADZnBfH13pFHmO07cjCL7OebnBXx2kz35Ec7k/m9
         WFGieddm5a0wBkssUH4N9GJ3atyb/DY/yF7P42fpvubIUdVycicj+w/omND6/iIGX1Yo
         9fYloGtg73yfkEgL1DQcDBQIo3XHOTy6Q6IXc1v3X202PW76Mx/Dmr7/+D7GOi4nTUiG
         HrrC/3iS4XZGFlz+Er5bmql4sgGdpt769CYsKPCkN1Kk7jQZz9baHPhCfkvyX2BnieoC
         S5sg==
X-Gm-Message-State: ANhLgQ3mWUJjHvw8KZf3SewLNHqdqvKL0H2ee4KJRbZfwERIUFqfrwys
        XZa5qkABgSHxRy5+sXJyMQR6gLasqYQyHd8RtQyh0g==
X-Google-Smtp-Source: ADFU+vtzr7VU58zGNc4KSQSr/KCr50ImaVWUg3vTbElEM7j6/APuIlOpZtpoy4ufI1XzPHmHv/tIvaQBOrIhaQmySrU=
X-Received: by 2002:a37:8b01:: with SMTP id n1mr7514871qkd.407.1584717521649;
 Fri, 20 Mar 2020 08:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com> <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
In-Reply-To: <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Mar 2020 16:18:30 +0100
Message-ID: <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 2:39 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-03-11 at 18:34 +0100, Dmitry Vyukov wrote:
>
> > > $ gdb -p ...
> > > (gdb) p/x task_size
> > > $1 = 0x7fc0000000
> > > (gdb) p/x __end_of_fixed_addresses
> > > $2 = 0x0
> > > (gdb) p/x end_iomem
> > > $3 = 0x70000000
> > > (gdb) p/x __va_space
> > >
> > > #define TASK_SIZE (task_size)
> > > #define FIXADDR_TOP        (TASK_SIZE - 2 * PAGE_SIZE)
> > >
> > > #define FIXADDR_START      (FIXADDR_TOP - FIXADDR_SIZE)
> > > #define FIXADDR_SIZE       (__end_of_fixed_addresses << PAGE_SHIFT)
> > >
> > > #define VMALLOC_END       (FIXADDR_START-2*PAGE_SIZE)
> > >
> > > #define MODULES_VADDR   VMALLOC_START
> > > #define MODULES_END       VMALLOC_END
> > > #define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> > > #define VMALLOC_OFFSET  (__va_space)
> > > #define __va_space (8*1024*1024)
> > >
> > >
> > > So from that, it would look like the UML vmalloc area is from
> > > 0x  70800000 all the way to
> > > 0x7fbfffc000, which obviously clashes with the KASAN_SHADOW_OFFSET being
> > > just 0x7fff8000.
> > >
> > >
> > > I'm guessing that basically the module loading overwrote the kasan
> > > shadow then?
> >
> > Well, ok, this is definitely not going to fly :)
>
> Yeah, not with vmalloc/modules at least, but you can't really prevent
> vmalloc :)
>
> > I don't know if it's easy to move modules to a different location.
>
> We'd have to not just move modules, but also vmalloc space. They're one
> and the same in UML.
>
> > It
> > would be nice because 0x7fbfffc000 is the shadow start that's used in
> > userspace asan and it allows to faster instrumentation (if offset is
> > within first 2 gigs, the instruction encoding is much more compact,
> > for >2gigs it will require several instructions).
>
> Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> confused the values - because I see, on userspace, the following:

Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000. Here is the
user-space mapping that uses it:
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/asan/asan_mapping.h#L25


> || `[0x10007fff8000, 0x7fffffffffff]` || HighMem    ||
> || `[0x02008fff7000, 0x10007fff7fff]` || HighShadow ||
> || `[0x00008fff7000, 0x02008fff6fff]` || ShadowGap  ||
> || `[0x00007fff8000, 0x00008fff6fff]` || LowShadow  ||
> || `[0x000000000000, 0x00007fff7fff]` || LowMem     ||
>
>
> Now, I also don't really understand what UML is doing here -
> os_get_top_address() determines some sort of "top address"? But all that
> is only on 32-bit, on 64-bit, that's always 0x7fc0000000.

Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...

> So basically that means it's just _slightly_ higher than what you
> suggested as the KASAN_SHADOW_OFFSET now (even if erroneously?), and
> shouldn't actually clash (and we can just change the top address value
> to be slightly lower anyway to prevent clashing).
>
> > But if it's not really easy, I guess we go with a large shadow start
> > (at least initially). A slower but working KASAN is better than fast
> > non-working KASAN :)
>
> Indeed, but I can't even get it to work regardless of the offset.
>
> Note that I have lockdep enabled, and at least some crashes appear to be
> because of the stack unwinding code that is called by lockdep in various
> situations...

This is something new, right? The previous stacks you posted did not
mention lockdep.

> > > I tried changing it
> > >
> > >  config KASAN_SHADOW_OFFSET
> > >         hex
> > >         depends on KASAN
> > > -       default 0x7fff8000
> > > +       default 0x8000000000
> > >
> > >
> > > and also put a check in like this:
> > >
> > > +++ b/arch/um/kernel/um_arch.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/sched/task.h>
> > >  #include <linux/kmsg_dump.h>
> > > +#include <linux/kasan.h>
> > >
> > >  #include <asm/pgtable.h>
> > >  #include <asm/processor.h>
> > > @@ -267,9 +268,11 @@ int __init linux_main(int argc, char **argv)
> > >         /*
> > >          * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
> > >          * out
> > >          */
> > >         task_size = host_task_size & PGDIR_MASK;
> > >
> > > +       if (task_size > KASAN_SHADOW_OFFSET)
> > > +               panic("KASAN shadow offset must be bigger than task size");
> > >
> > >
> > > but now I just crash accessing the shadow even though it was mapped fine?
> >
> > Yes, this is puzzling.
> > I noticed that RIP is the same in both cases and it relates to vmap code.
> > A support for shadow for vmalloced-memory was added to KASAN recently
> > and I suspect it may conflict with UML.
>
> This can't be it - HAVE_ARCH_KASAN_VMALLOC isn't selected, so
> KASAN_VMALLOC isn't set.
>
> > What does pte-manipulation code even do under UML?
>
> No idea.
>
> > Looking at the code around, kasan_mem_notifier may be a problem too,
> > or at least excessive and confusing. We already have shadow for
> > everything, we don't need _any_ of dynamic/lazy shadow mapping.
>
> CONFIG_MEMORY_HOTPLUG is also not supported in ARCH=um, or at least not
> used in my config.

Ack.

Maybe if you dump /proc/self/maps for the process, it will shed some light.
Or is it possible to run it under strace? If we get all
mmap/munmap/mprotect, we will maybe see the offender that messes the
shadow...
