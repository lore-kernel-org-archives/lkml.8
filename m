Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1EC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515920644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XV0GW62c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDGLS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:18:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40932 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGLS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:18:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id r19so2670718otn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZAVo9+HNGe4MaXXVl9xUc8s9QKfb+sT+eiPhTxTG5U=;
        b=XV0GW62ciOqxEETw8wJv6Oth2eGmlatDGNuw+gZqKoXVLI0RdbpFprrdp2eOiMxVtD
         4pZ07DrxYK9YxDqOpTeTPV/ovg3FC1qGZWPmAqadgyfUj9DiBMRlf1qrjEfuo5NJa4zF
         YiDl7Rz8+r88yxSKZFahLRSiIaBbkP0rnwbBDRWnT2qGgt4Fq/8dkdBTtI5kAHhpuw1k
         sn2BV0WhqcRnAEHX6q5fd0AkSnlGIX3Zo9nD+T7cZAbF4cDE2kQtpIjSm3tvNleGCUim
         5YZ7Px3HssWPlVK5TEFw7PXU9LC0kpxLsJ6WrwCw9pJUYLPrkC4keuKxO45HmgQ6Y8iE
         dEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZAVo9+HNGe4MaXXVl9xUc8s9QKfb+sT+eiPhTxTG5U=;
        b=KK9qqSsJuMt8Hke/OviOMvO1wSmB0IwHVTM963yErSl9EL+gVd1Vr1uYoRiDmmXPxU
         taF3bs2CH5rD1NTEH4yjqeLVnqNTTglMNNZRvbMWBUetZIORJpikaltAzB4mgeYErTax
         CuYSgWRC/x8CXX0kWEsO/HLq1Uz3MccRoYjw4jo+LuQ6smjfZ0iDaB0Yta4yAWpSz2ZZ
         d1XTfuEdJQdP+b1aWRGz45CmpIaUL3rr365n4KEblL396h8MQrQUCZgADyzeBneOW5Um
         4Eddtur4iPYD1naB6XS7d0CiaKzG4MYfe/wQi+8Rh1jwoR/85gc+BBdBWYKNW/kMAInx
         EiSA==
X-Gm-Message-State: AGi0PubCldRTDzYbGQJp2VFp31MxUbdB+ej7UYCdya1U+/7BzviB9rtC
        aHVT4jHM7xKzt6PccsvjkeUcOFG6nB8tZvRB9QYxYdX0LvI=
X-Google-Smtp-Source: APiQypJLVHhoj0UjmeuSiOx0Fd7uW4nYXpoS78J4JE3Q2ljIgCGZnkHAgJj9uGwfTHEAykkog+Y/elCqe2KnloqIBOk=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr1147351ota.127.1586258303389;
 Tue, 07 Apr 2020 04:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584352425.git.zong.li@sifive.com> <8373a9d18958b99b72ed9499786dffe45adf9617.1584352425.git.zong.li@sifive.com>
 <772ee8e0-f5ff-cf40-4e84-3f703953cd08@ghiti.fr>
In-Reply-To: <772ee8e0-f5ff-cf40-4e84-3f703953cd08@ghiti.fr>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 7 Apr 2020 19:18:12 +0800
Message-ID: <CANXhq0p7A2HeyFDRQaw5brzembsFM0-v3kPwQKvFZuyeCm6tsg@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] riscv/kaslr: clear the original kernel image
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:11 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> On 3/24/20 3:30 AM, Zong Li wrote:
> > After completing final page table, we can clear original kernel image
> > and remove executable permission.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >   arch/riscv/include/asm/kaslr.h | 12 ++++++++++++
> >   arch/riscv/kernel/kaslr.c      | 12 ++++++++++++
> >   arch/riscv/mm/init.c           |  6 ++++++
> >   3 files changed, 30 insertions(+)
> >   create mode 100644 arch/riscv/include/asm/kaslr.h
> >
> > diff --git a/arch/riscv/include/asm/kaslr.h b/arch/riscv/include/asm/kaslr.h
> > new file mode 100644
> > index 000000000000..b165fe71dd4a
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/kaslr.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 SiFive
> > + * Copyright (C) 2020 Zong Li <zong.li@sifive.com>
> > + */
> > +
> > +#ifndef _ASM_RISCV_KASLR_H
> > +#define _ASM_RISCV_KASLR_H
> > +
> > +void __init kaslr_late_init(void);
> > +
> > +#endif /* _ASM_RISCV_KASLR_H */
> > diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
> > index 59001d6fdfc3..0bd30831c455 100644
> > --- a/arch/riscv/kernel/kaslr.c
> > +++ b/arch/riscv/kernel/kaslr.c
> > @@ -356,6 +356,18 @@ static __init uintptr_t get_random_offset(u64 seed, uintptr_t kernel_size)
> >       return get_legal_offset(random, kernel_size_align);
> >   }
> >
> > +void __init kaslr_late_init(void)
> > +{
> > +     uintptr_t kernel_size;
> > +
> > +     /* Clear original kernel image. */
> > +     if (kaslr_offset) {
> > +             kernel_size = (uintptr_t) _end - (uintptr_t) _start;
>
> kernel_size = (uintptr_t) _end - (uintptr_t) _start + 1;

OK, change it in the next version. Thanks.

>
> > +             memset((void *)PAGE_OFFSET, 0, kernel_size);
>
> I have been thinking again about our discussion regarding PAGE_OFFSET:
> PAGE_OFFSET actually points to the address where the kernel was loaded,
> not the beginning of memory, that's a bit weird.
>
> Just saying that here, because it took me a few seconds to remember that
> and understand what you were doing here.

In non-kaslr case, we load the kernel to PAGE_OFFSET which points to,
so we clear the old kernel image through PAGE_OFFSET here. Certainly,
we could use a symbol to record the start address of the old kernel
image instead of PAGE_OFFSET here. I don't see other architectures
changing PAGE_OFFSET after copying the kernel to the new location in
kaslr. If you think the PAGE_OFFSET needs to be changed, we need to
give another way to make the page table could create the mappings for
the whole memory and memblock/buddy system could see the whole memory
after the kernel moves.

>
> > +             set_memory_nx(PAGE_OFFSET, kaslr_offset >> PAGE_SHIFT);
>
> Again, I certainly missed something but when do you use old kernel
> mappings ?

We use old kernel mappings when KASLR calculates the random offset, at
that moment, kernel is running on old kernel location.

>
> > +     }
> > +}
> > +
> >   uintptr_t __init kaslr_early_init(void)
> >   {
> >       u64 seed;
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 34c6ecf2c599..08e2ce170533 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/set_memory.h>
> >   #ifdef CONFIG_RELOCATABLE
> >   #include <linux/elf.h>
> > +#include <asm/kaslr.h>
> >   #endif
> >
> >   #include <asm/fixmap.h>
> > @@ -649,6 +650,11 @@ static void __init setup_vm_final(void)
> >       /* Move to swapper page table */
> >       csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
> >       local_flush_tlb_all();
> > +
> > +#ifdef CONFIG_RANDOMIZE_BASE
> > +     /* Clear orignial kernel image and set the right permission. */
> > +     kaslr_late_init();
> > +#endif
> >   }
> >
> >   void free_initmem(void)
> >
>
> Alex
