Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7AB2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="iZHQqTm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFVTMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFVTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:12:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90891C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:12:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so8773057wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fmod96j6xSUGJvqDNAIW99FGIv8l2jLCCShrGVZU87w=;
        b=iZHQqTm6aehdoK6+OOOAUInhKTxurNGYzryo6H3vwvMgNB8OVOqDmaUZAw8OgwLOjV
         hf8mlbm5er0KysDTkDYBxm5pIT7gDKnwYnHgScwfPSlB80Zxu1R9ZDRAeJByzrfn125K
         XAIVZ+2q2cmqkw2Wo53575jm/7LQ1kC4yIgq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fmod96j6xSUGJvqDNAIW99FGIv8l2jLCCShrGVZU87w=;
        b=PalHsCQBdJ9lZO8ALqsL0tvpGoxMPZCkvKU76XqS+blWvcNFwInESyH2BKuorVobXC
         11k0eoxv3evqRu85zGpAHBuCgb3iBLLGMl6bxZkfEfOcOwLoOjI1FAOuzmpP1tPe1Z9R
         o0WCGWrNSdb2UaYgpqEBLDrATBsPj9mv3WG9PBn9AVitLTzJr2pH5OhTY4pK0oRQOYkE
         JbmmMTiWfm6sCM5+r3pDGQBT/mDTqkPgZVr4RuBsGrvy/27spRPZeydpF+8kvATTyZdx
         A+Eg5Iv+HLVNzCLyeB1w/aA5/l7HieFS47Dh1klZ6JxX/qC2/d6LgkDPAtbJXs7p2wMU
         pwoQ==
X-Gm-Message-State: AOAM530mtrKxbKUMTMF687NCxR3lxuC0YKiIGiDckpO7+4evODzcVYZT
        4FqUy4uzB1IPyjjgB7ANMzMAYwDCbpVwiuA11gZo
X-Google-Smtp-Source: ABdhPJwywlArloKwHoRSCBso38VgVWBoaC9NnX2sVxnpDse5ZoAvIMHyfOLUwtV8sMj+jbeTVvDeAjcFIW8bNC8PgxI=
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr3479861wrr.176.1592853125238;
 Mon, 22 Jun 2020 12:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr> <20200603153608.30056-3-alex@ghiti.fr>
 <CAOnJCU+JSuOGbOmZW-vqb-A_qR7CJc=qG16FbgOLWSm1vhJH1A@mail.gmail.com>
 <23529a84-44a0-3c45-f16d-5a7ee528610d@ghiti.fr> <CAOnJCU+s5JuNdPg_R-Cg2+WnMjR51DD0ekbRr84EFCig6=YyZA@mail.gmail.com>
 <f1a5ec6e-540b-497f-a9ad-f2d1e7adfc65@ghiti.fr> <2588a00a-b042-4902-1602-7cb8d587ac2b@ghiti.fr>
In-Reply-To: <2588a00a-b042-4902-1602-7cb8d587ac2b@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 22 Jun 2020 12:11:54 -0700
Message-ID: <CAOnJCU+JOdoJfVCAKOHK52m47UwR_NzpJoGXQywD+Mx-6JRw5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Use PUD/PGDIR entries for linear mapping when possible
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 2:39 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Atish,
>
> Le 6/20/20 =C3=A0 5:04 AM, Alex Ghiti a =C3=A9crit :
> > Hi Atish,
> >
> > Le 6/19/20 =C3=A0 2:16 PM, Atish Patra a =C3=A9crit :
> >> On Thu, Jun 18, 2020 at 9:28 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>> Hi Atish,
> >>>
> >>> Le 6/18/20 =C3=A0 8:47 PM, Atish Patra a =C3=A9crit :
> >>>> On Wed, Jun 3, 2020 at 8:38 AM Alexandre Ghiti <alex@ghiti.fr> wrote=
:
> >>>>> Improve best_map_size so that PUD or PGDIR entries are used for
> >>>>> linear
> >>>>> mapping when possible as it allows better TLB utilization.
> >>>>>
> >>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >>>>> ---
> >>>>>    arch/riscv/mm/init.c | 45
> >>>>> +++++++++++++++++++++++++++++++++-----------
> >>>>>    1 file changed, 34 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >>>>> index 9a5c97e091c1..d275f9f834cf 100644
> >>>>> --- a/arch/riscv/mm/init.c
> >>>>> +++ b/arch/riscv/mm/init.c
> >>>>> @@ -424,13 +424,29 @@ static void __init create_pgd_mapping(pgd_t
> >>>>> *pgdp,
> >>>>>           create_pgd_next_mapping(nextp, va, pa, sz, prot);
> >>>>>    }
> >>>>>
> >>>>> -static uintptr_t __init best_map_size(phys_addr_t base,
> >>>>> phys_addr_t size)
> >>>>> +static bool is_map_size_ok(uintptr_t map_size, phys_addr_t base,
> >>>>> +                          uintptr_t base_virt, phys_addr_t size)
> >>>>>    {
> >>>>> -       /* Upgrade to PMD_SIZE mappings whenever possible */
> >>>>> -       if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
> >>>>> -               return PAGE_SIZE;
> >>>>> +       return !((base & (map_size - 1)) || (base_virt & (map_size
> >>>>> - 1)) ||
> >>>>> +                       (size < map_size));
> >>>>> +}
> >>>>> +
> >>>>> +static uintptr_t __init best_map_size(phys_addr_t base, uintptr_t
> >>>>> base_virt,
> >>>>> +                                     phys_addr_t size)
> >>>>> +{
> >>>>> +#ifndef __PAGETABLE_PMD_FOLDED
> >>>>> +       if (is_map_size_ok(PGDIR_SIZE, base, base_virt, size))
> >>>>> +               return PGDIR_SIZE;
> >>>>> +
> >>>>> +       if (pgtable_l4_enabled)
> >>>>> +               if (is_map_size_ok(PUD_SIZE, base, base_virt, size)=
)
> >>>>> +                       return PUD_SIZE;
> >>>>> +#endif
> >>>>> +
> >>>>> +       if (is_map_size_ok(PMD_SIZE, base, base_virt, size))
> >>>>> +               return PMD_SIZE;
> >>>>>
> >>>>> -       return PMD_SIZE;
> >>>>> +       return PAGE_SIZE;
> >>>>>    }
> >>>>>
> >>>>>    /*
> >>>>> @@ -576,7 +592,7 @@ void create_kernel_page_table(pgd_t *pgdir,
> >>>>> uintptr_t map_size)
> >>>>>    asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>>>>    {
> >>>>>           uintptr_t va, end_va;
> >>>>> -       uintptr_t map_size =3D best_map_size(load_pa,
> >>>>> MAX_EARLY_MAPPING_SIZE);
> >>>>> +       uintptr_t map_size;
> >>>>>
> >>>>>           load_pa =3D (uintptr_t)(&_start);
> >>>>>           load_sz =3D (uintptr_t)(&_end) - load_pa;
> >>>>> @@ -587,6 +603,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_p=
a)
> >>>>>
> >>>>>           kernel_virt_addr =3D KERNEL_VIRT_ADDR;
> >>>>>
> >>>>> +       map_size =3D best_map_size(load_pa, PAGE_OFFSET,
> >>>>> MAX_EARLY_MAPPING_SIZE);
> >>>>>           va_pa_offset =3D PAGE_OFFSET - load_pa;
> >>>>>           va_kernel_pa_offset =3D kernel_virt_addr - load_pa;
> >>>>>           pfn_base =3D PFN_DOWN(load_pa);
> >>>>> @@ -700,6 +717,8 @@ static void __init setup_vm_final(void)
> >>>>>
> >>>>>           /* Map all memory banks */
> >>>>>           for_each_memblock(memory, reg) {
> >>>>> +               uintptr_t remaining_size;
> >>>>> +
> >>>>>                   start =3D reg->base;
> >>>>>                   end =3D start + reg->size;
> >>>>>
> >>>>> @@ -707,15 +726,19 @@ static void __init setup_vm_final(void)
> >>>>>                           break;
> >>>>>                   if (memblock_is_nomap(reg))
> >>>>>                           continue;
> >>>>> -               if (start <=3D __pa(PAGE_OFFSET) &&
> >>>>> -                   __pa(PAGE_OFFSET) < end)
> >>>>> -                       start =3D __pa(PAGE_OFFSET);
> >>>>>
> >>>>> -               map_size =3D best_map_size(start, end - start);
> >>>>> -               for (pa =3D start; pa < end; pa +=3D map_size) {
> >>>>> +               pa =3D start;
> >>>>> +               remaining_size =3D reg->size;
> >>>>> +
> >>>>> +               while (remaining_size) {
> >>>>>                           va =3D (uintptr_t)__va(pa);
> >>>>> +                       map_size =3D best_map_size(pa, va,
> >>>>> remaining_size);
> >>>>> +
> >>>>> create_pgd_mapping(swapper_pg_dir, va, pa,
> >>>>>                                              map_size, PAGE_KERNEL)=
;
> >>>>> +
> >>>>> +                       pa +=3D map_size;
> >>>>> +                       remaining_size -=3D map_size;
> >>>>>                   }
> >>>>>           }
> >>>>>
> >>>> This may not work in the RV32 with 2G memory  and if the map_size is
> >>>> determined to be a page size
> >>>> for the last memblock. Both pa & remaining_size will overflow and th=
e
> >>>> loop will try to map memory from zero again.
> >>> I'm not sure I understand: if pa starts at 0x8000_0000 and size is 2G=
,
> >>> then pa will overflow in the last iteration, but remaining_size will
> >>> then be equal to 0 right ?
> >>>
> >> Not unless the remaining_size is at least page size aligned. The last
> >> remaining size would "fff".
> >> It will overflow as well after subtracting the map_size.
>
>
> While fixing this issue, I noticed that if the size in the device tree
> is not aligned on PAGE_SIZE, the size is then automatically realigned on
> PAGE_SIZE: see early_init_dt_add_memory_arch where size is and-ed with
> PAGE_MASK to remove the unaligned part.
>
Yes. But the memblock size is not guaranteed to be PAGE_SIZE aligned.
The memblock size is updated in memblock_cap_size

    /* adjust *@size so that (@base + *@size) doesn't overflow, return
new size */
   static inline phys_addr_t memblock_cap_size(phys_addr_t base,
phys_addr_t *size)
   {
            return *size =3D min(*size, PHYS_ADDR_MAX - base);
   }

You will not see this issue right away even if you allocate 2GB of
memory while running 32 bit linux in qemu
because the kernel removes anything beyond 0xc0400000 for 32 bit in
bootmem setup.

=E2=94=82[    0.000000][    T0] memblock_remove: [0xc0400000-0xfffffffe]
setup_bootmem+0x90/0x216

This also restricts the kernel to use only 1GB of memory even if
maximum physical memory supported is 2GB.

> So the issue does not need to be fixed :)
>
> Thanks anyway,
>
> Alex
>
>
> >>
> >>> And by the way, I realize that this loop only handles sizes that are
> >>> aligned on map_size.
> >>>
> >> Yeah.
> >
> >
> > Thanks for noticing, I send a v2.
> >
> > Alex
> >
> >
> >>
> >>> Thanks,
> >>>
> >>> Alex
> >>>
> >>>
> >>>>> --
> >>>>> 2.20.1
> >>>>>
> >>>>>
> >>
> >>
> >



--
Regards,
Atish
