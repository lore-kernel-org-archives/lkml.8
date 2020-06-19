Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D63C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8A82073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="dS4o87kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgFSSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgFSSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:17:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:16:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so9321698wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pdRjq7c/C/ExAewHNaf0dxUTQHfeQV9fMMSHlW7P0AE=;
        b=dS4o87kUMtecMW/ZQvrys54WL2/itW2B/vToYbHnOcr9N48VVNJ9xgI659JhyNw4PH
         HKSeh9slMa7USwzD2nDspF8ls9FiQhsIZLlqGaOFEtAXHzx8QHXyj9XelWR+FyreNNe8
         60KfPSUtf3c7d/Tf5MGr9q+/5uZjYMxSgW5r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pdRjq7c/C/ExAewHNaf0dxUTQHfeQV9fMMSHlW7P0AE=;
        b=SY6iGuX4uvxT1mpfpgstMXTwfx5F0QmC/QaJ/pqoHr898pw6holk4dKLfPbLl7E/yO
         SCN4Gvw8YvEMkYBUHcgTz4hrYXKZqZQbI0cB++ZurHo31PYYxIdtp7R1nc+Squ1QeDse
         jqvJVIJn7RE0Cv90bZpuToPMQMA36aBBG8vaU0x4mk5U+eklQKRLq6hCFZluwnFt98y3
         bUS8Oh/r15YCW14X9O40ctLTZVHphx0Lx/PcW7Cg6bXfx53Y5cJmZK7wmlYGdVwgf6FS
         y4F04NUXorVX46cFpc/ZzkoKwzleHYnmmv2zuWyV/IKA0vV8Ky8/942+CGY/ZwMaQmQh
         4NTg==
X-Gm-Message-State: AOAM5332K5Cie55+CIkjIQ1SUB/MMoGReJZyImSwY4F6Nw8cOOyJMjr4
        O4QvHmWrZvimvbzrbpxl7tzZplGw9/gJOFnfiFiU
X-Google-Smtp-Source: ABdhPJwslo2aZ//Il/+AnJDXJ+Og9D8A3zuCJ0ipsamQcWxfOxHFCDRIthtT+4r3npxgym3eQiMm3dd4E8fsfjnrrW0=
X-Received: by 2002:a1c:f608:: with SMTP id w8mr4878392wmc.78.1592590618426;
 Fri, 19 Jun 2020 11:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200603153608.30056-1-alex@ghiti.fr> <20200603153608.30056-3-alex@ghiti.fr>
 <CAOnJCU+JSuOGbOmZW-vqb-A_qR7CJc=qG16FbgOLWSm1vhJH1A@mail.gmail.com> <23529a84-44a0-3c45-f16d-5a7ee528610d@ghiti.fr>
In-Reply-To: <23529a84-44a0-3c45-f16d-5a7ee528610d@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 19 Jun 2020 11:16:47 -0700
Message-ID: <CAOnJCU+s5JuNdPg_R-Cg2+WnMjR51DD0ekbRr84EFCig6=YyZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Use PUD/PGDIR entries for linear mapping when possible
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 9:28 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Atish,
>
> Le 6/18/20 =C3=A0 8:47 PM, Atish Patra a =C3=A9crit :
> > On Wed, Jun 3, 2020 at 8:38 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> >> Improve best_map_size so that PUD or PGDIR entries are used for linear
> >> mapping when possible as it allows better TLB utilization.
> >>
> >> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >> ---
> >>   arch/riscv/mm/init.c | 45 +++++++++++++++++++++++++++++++++---------=
--
> >>   1 file changed, 34 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> index 9a5c97e091c1..d275f9f834cf 100644
> >> --- a/arch/riscv/mm/init.c
> >> +++ b/arch/riscv/mm/init.c
> >> @@ -424,13 +424,29 @@ static void __init create_pgd_mapping(pgd_t *pgd=
p,
> >>          create_pgd_next_mapping(nextp, va, pa, sz, prot);
> >>   }
> >>
> >> -static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t s=
ize)
> >> +static bool is_map_size_ok(uintptr_t map_size, phys_addr_t base,
> >> +                          uintptr_t base_virt, phys_addr_t size)
> >>   {
> >> -       /* Upgrade to PMD_SIZE mappings whenever possible */
> >> -       if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
> >> -               return PAGE_SIZE;
> >> +       return !((base & (map_size - 1)) || (base_virt & (map_size - 1=
)) ||
> >> +                       (size < map_size));
> >> +}
> >> +
> >> +static uintptr_t __init best_map_size(phys_addr_t base, uintptr_t bas=
e_virt,
> >> +                                     phys_addr_t size)
> >> +{
> >> +#ifndef __PAGETABLE_PMD_FOLDED
> >> +       if (is_map_size_ok(PGDIR_SIZE, base, base_virt, size))
> >> +               return PGDIR_SIZE;
> >> +
> >> +       if (pgtable_l4_enabled)
> >> +               if (is_map_size_ok(PUD_SIZE, base, base_virt, size))
> >> +                       return PUD_SIZE;
> >> +#endif
> >> +
> >> +       if (is_map_size_ok(PMD_SIZE, base, base_virt, size))
> >> +               return PMD_SIZE;
> >>
> >> -       return PMD_SIZE;
> >> +       return PAGE_SIZE;
> >>   }
> >>
> >>   /*
> >> @@ -576,7 +592,7 @@ void create_kernel_page_table(pgd_t *pgdir, uintpt=
r_t map_size)
> >>   asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>   {
> >>          uintptr_t va, end_va;
> >> -       uintptr_t map_size =3D best_map_size(load_pa, MAX_EARLY_MAPPIN=
G_SIZE);
> >> +       uintptr_t map_size;
> >>
> >>          load_pa =3D (uintptr_t)(&_start);
> >>          load_sz =3D (uintptr_t)(&_end) - load_pa;
> >> @@ -587,6 +603,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>
> >>          kernel_virt_addr =3D KERNEL_VIRT_ADDR;
> >>
> >> +       map_size =3D best_map_size(load_pa, PAGE_OFFSET, MAX_EARLY_MAP=
PING_SIZE);
> >>          va_pa_offset =3D PAGE_OFFSET - load_pa;
> >>          va_kernel_pa_offset =3D kernel_virt_addr - load_pa;
> >>          pfn_base =3D PFN_DOWN(load_pa);
> >> @@ -700,6 +717,8 @@ static void __init setup_vm_final(void)
> >>
> >>          /* Map all memory banks */
> >>          for_each_memblock(memory, reg) {
> >> +               uintptr_t remaining_size;
> >> +
> >>                  start =3D reg->base;
> >>                  end =3D start + reg->size;
> >>
> >> @@ -707,15 +726,19 @@ static void __init setup_vm_final(void)
> >>                          break;
> >>                  if (memblock_is_nomap(reg))
> >>                          continue;
> >> -               if (start <=3D __pa(PAGE_OFFSET) &&
> >> -                   __pa(PAGE_OFFSET) < end)
> >> -                       start =3D __pa(PAGE_OFFSET);
> >>
> >> -               map_size =3D best_map_size(start, end - start);
> >> -               for (pa =3D start; pa < end; pa +=3D map_size) {
> >> +               pa =3D start;
> >> +               remaining_size =3D reg->size;
> >> +
> >> +               while (remaining_size) {
> >>                          va =3D (uintptr_t)__va(pa);
> >> +                       map_size =3D best_map_size(pa, va, remaining_s=
ize);
> >> +
> >>                          create_pgd_mapping(swapper_pg_dir, va, pa,
> >>                                             map_size, PAGE_KERNEL);
> >> +
> >> +                       pa +=3D map_size;
> >> +                       remaining_size -=3D map_size;
> >>                  }
> >>          }
> >>
> > This may not work in the RV32 with 2G memory  and if the map_size is
> > determined to be a page size
> > for the last memblock. Both pa & remaining_size will overflow and the
> > loop will try to map memory from zero again.
>
> I'm not sure I understand: if pa starts at 0x8000_0000 and size is 2G,
> then pa will overflow in the last iteration, but remaining_size will
> then be equal to 0 right ?
>
Not unless the remaining_size is at least page size aligned. The last
remaining size would "fff".
It will overflow as well after subtracting the map_size.

> And by the way, I realize that this loop only handles sizes that are
> aligned on map_size.
>

Yeah.

> Thanks,
>
> Alex
>
>
> >
> >> --
> >> 2.20.1
> >>
> >>
> >



--=20
Regards,
Atish
