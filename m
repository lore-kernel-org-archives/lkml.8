Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8082324680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QPWw56Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJKDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:03:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45589 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:03:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so12519713otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdbD/7XWvSw/02HF9kQLrOIbS54BEMNBRDVdiEv3sL4=;
        b=QPWw56Z+xZwgRUgHmt8qFXqf4ttDHd0mlGv2S20GVlhNZSiM6WMYlh0JaQns9U0k3P
         /U9WjH9uIWfVXA/VVLulKHjPGRTDmZuLHfXql8c+SuymBzPhqtFLYkRFXtzWWolZGXot
         Ea14S7Wv88k1ujM913n9T3zX/8EQYrZQyLDInDGOOPpocQhyF8u+VraDOiM67vNlUOTo
         ZYI7D90Z6G/RaKCEZgWafq63P5WyCJ9oP+9aDGZoTQ6T4IOPdd3i/Qb5+RoaRdBbB8ii
         YyRxjHDuhWMoeXh4vSbPXhnxLpW7XBgGiAmxjDKPNyQ+twF+mm0VD2dRAYjt/NRS+d6w
         GyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdbD/7XWvSw/02HF9kQLrOIbS54BEMNBRDVdiEv3sL4=;
        b=j005LCA77TCqoFtWNAQmjeb7ffQQF5N6CCNUDdDAYFWIjxmsSAsqS0JgMjPRYAeruS
         fmCt7BsdRB//CXr5dna4NMRPRoOMJChq43a3W42gS9C2buzMgzt8n8ob5AmFEqMMfh0G
         VTWtCzhl9w5H0V/7/uw+6tdMkmkNEKNaT+KrLpeN5uFskP1Y0yHK6VoXfTpgykWf245f
         4tD1RI5JjaHtL60IhA/iw8envlKamJcQQ1Q3dxq4B4oT96EIG/rN+IV0+Y2I33D5BLAo
         cSXYyoAwSi0qmVp3MdOLkKILXY33H6Y8VRTEeZ2Cu6ed5iVlB0FCNngM5d29IUw6TYm9
         l8Kg==
X-Gm-Message-State: ANhLgQ121YKqMAxvM0nz5vL4LRUYWjPDgJGrnRyuhrOO7ABfl6KOw8kg
        cvjJUtcJrB1lkT8cS8qYRHXhz3aiwdvdVredJ4zhCA==
X-Google-Smtp-Source: ADFU+vth5vrLxfc9gw8XLORvVUEghWYaA87vNPJwTLrhNx4/D5DHF2QoNR6wq4ecFyhf5XoZq5aBY9x7h+nDZ6gp7eU=
X-Received: by 2002:a05:6830:1684:: with SMTP id k4mr16883668otr.75.1583834580169;
 Tue, 10 Mar 2020 03:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200210083515.10864-1-zong.li@sifive.com> <20200210083515.10864-2-zong.li@sifive.com>
 <c7c798a2-b45c-7b06-5232-f268a9ae8eb9@ghiti.fr>
In-Reply-To: <c7c798a2-b45c-7b06-5232-f268a9ae8eb9@ghiti.fr>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 10 Mar 2020 18:02:48 +0800
Message-ID: <CANXhq0o90stdGaYbb46fPAq7uRNfJd7aAFJYqiCWsU=Au_bjRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Add support to dump the kernel page tables
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 1:40 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Zong,
>
> On 2/10/20 3:35 AM, Zong Li wrote:
> > In a similar manner to arm64, x86, powerpc, etc., it can traverse all
> > page tables, and dump the page table layout with the memory types and
> > permissions.
> >
> > Add a debugfs file at /sys/kernel/debug/kernel_page_tables to export
> > the page table layout to userspace.
> >
> > Changes in v2:
> > - Remove #ifdef CONFIG_PTDUMP_CORE in header. Suggested by Steven Price.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >   arch/riscv/Kconfig               |   1 +
> >   arch/riscv/include/asm/pgtable.h |  10 +
> >   arch/riscv/include/asm/ptdump.h  |  11 ++
> >   arch/riscv/mm/Makefile           |   1 +
> >   arch/riscv/mm/ptdump.c           | 317 +++++++++++++++++++++++++++++++
> >   5 files changed, 340 insertions(+)
> >   create mode 100644 arch/riscv/include/asm/ptdump.h
> >   create mode 100644 arch/riscv/mm/ptdump.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 73f029eae0cc..6e81da55b5e4 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -29,6 +29,7 @@ config RISCV
> >       select GENERIC_SMP_IDLE_THREAD
> >       select GENERIC_ATOMIC64 if !64BIT
> >       select GENERIC_IOREMAP
> > +     select GENERIC_PTDUMP
> >       select HAVE_ARCH_AUDITSYSCALL
> >       select HAVE_ARCH_SECCOMP_FILTER
> >       select HAVE_ASM_MODVERSIONS
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index e43041519edd..ac353e44f80c 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -444,6 +444,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> >   #endif
> >   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> >
> > +/*
> > + * In the RV64 Linux scheme, we give the user half of the virtual-address space
> > + * and give the kernel the other (upper) half.
> > + */
> > +#ifdef CONFIG_64BIT
> > +#define KERN_VIRT_START      (-(BIT(CONFIG_VA_BITS)) + TASK_SIZE) > +#else
> > +#define KERN_VIRT_START      FIXADDR_START
> > +#endif
> > +
> >   /*
> >    * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
> >    * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> > diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
> > new file mode 100644
> > index 000000000000..e29af7191909
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/ptdump.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2019 SiFive
> > + */
> > +
> > +#ifndef _ASM_RISCV_PTDUMP_H
> > +#define _ASM_RISCV_PTDUMP_H
> > +
> > +void ptdump_check_wx(void);
> > +
> > +#endif /* _ASM_RISCV_PTDUMP_H */
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index 50b7af58c566..814e16a8d68a 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -15,6 +15,7 @@ ifeq ($(CONFIG_MMU),y)
> >   obj-$(CONFIG_SMP) += tlbflush.o
> >   endif
> >   obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> > +obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
> >   obj-$(CONFIG_KASAN)   += kasan_init.o
> >
> >   ifdef CONFIG_KASAN
> > diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> > new file mode 100644
> > index 000000000000..9a67e723fff7
> > --- /dev/null
> > +++ b/arch/riscv/mm/ptdump.c
> > @@ -0,0 +1,317 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2019 SiFive
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/ptdump.h>
> > +
> > +#include <asm/ptdump.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/kasan.h>
> > +
> > +#define pt_dump_seq_printf(m, fmt, args...)  \
> > +({                                           \
> > +     if (m)                                  \
> > +             seq_printf(m, fmt, ##args);     \
> > +})
> > +
> > +#define pt_dump_seq_puts(m, fmt)     \
> > +({                                   \
> > +     if (m)                          \
> > +             seq_printf(m, fmt);     \
> > +})
> > +
> > +/*
> > + * The page dumper groups page table entries of the same type into a single
> > + * description. It uses pg_state to track the range information while
> > + * iterating over the pte entries. When the continuity is broken it then
> > + * dumps out a description of the range.
> > + */
> > +struct pg_state {
> > +     struct ptdump_state ptdump;
> > +     struct seq_file *seq;
> > +     const struct addr_marker *marker;
> > +     unsigned long start_address;
> > +     unsigned long start_pa;
> > +     unsigned long last_pa;
> > +     int level;
> > +     u64 current_prot;
> > +     bool check_wx;
> > +     unsigned long wx_pages;
> > +};
> > +
> > +/* Address marker */
> > +struct addr_marker {
> > +     unsigned long start_address;
> > +     const char *name;
> > +};
> > +
> > +static struct addr_marker address_markers[] = {
> > +#ifdef CONFIG_KASAN
> > +     {KASAN_SHADOW_START,    "Kasan shadow start"},
> > +     {KASAN_SHADOW_END,      "Kasan shadow end"},
> > +#endif
> > +     {FIXADDR_START,         "Fixmap start"},
> > +     {FIXADDR_TOP,           "Fixmap end"},
> > +     {PCI_IO_START,          "PCI I/O start"},
> > +     {PCI_IO_END,            "PCI I/O end"},
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +     {VMEMMAP_START,         "vmemmap start"},
> > +     {VMEMMAP_END,           "vmemmap end"},
> > +#endif
> > +     {VMALLOC_START,         "vmalloc() area"},
> > +     {VMALLOC_END,           "vmalloc() end"},
> > +     {PAGE_OFFSET,           "Linear mapping"},
> > +     {-1, NULL},
> > +};
> > +
> > +/* Page Table Entry */
> > +struct prot_bits {
> > +     u64 mask;
> > +     u64 val;
> > +     const char *set;
> > +     const char *clear;
> > +};
> > +
> > +static const struct prot_bits pte_bits[] = {
> > +     {
> > +             .mask = _PAGE_SOFT,
> > +             .val = _PAGE_SOFT,
> > +             .set = "RSW",
> > +             .clear = "   ",
> > +     }, {
> > +             .mask = _PAGE_DIRTY,
> > +             .val = _PAGE_DIRTY,
> > +             .set = "D",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_ACCESSED,
> > +             .val = _PAGE_ACCESSED,
> > +             .set = "A",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_GLOBAL,
> > +             .val = _PAGE_GLOBAL,
> > +             .set = "G",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_USER,
> > +             .val = _PAGE_USER,
> > +             .set = "U",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_EXEC,
> > +             .val = _PAGE_EXEC,
> > +             .set = "X",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_WRITE,
> > +             .val = _PAGE_WRITE,
> > +             .set = "W",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_READ,
> > +             .val = _PAGE_READ,
> > +             .set = "R",
> > +             .clear = ".",
> > +     }, {
> > +             .mask = _PAGE_PRESENT,
> > +             .val = _PAGE_PRESENT,
> > +             .set = "V",
> > +             .clear = ".",
> > +     }
> > +};
> > +
> > +/* Page Level */
> > +struct pg_level {
> > +     const char *name;
> > +     u64 mask;
> > +};
> > +
> > +static struct pg_level pg_level[] = {
> > +     { /* pgd */
> > +             .name = "PGD",
> > +     }, { /* p4d */
> > +             .name = (CONFIG_PGTABLE_LEVELS > 4) ? "P4D" : "PGD",
> > +     }, { /* pud */
> > +             .name = (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
> > +     }, { /* pmd */
> > +             .name = (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
> > +     }, { /* pte */
> > +             .name = "PTE",
> > +     },
> > +};
> > +
> > +static void dump_prot(struct pg_state *st)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
> > +             const char *s;
> > +
> > +             if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
> > +                     s = pte_bits[i].set;
> > +             else
> > +                     s = pte_bits[i].clear;
> > +
> > +             if (s)
> > +                     pt_dump_seq_printf(st->seq, " %s", s);
> > +     }
> > +}
> > +
> > +#ifdef CONFIG_64BIT
> > +#define ADDR_FORMAT  "0x%016lx"
> > +#else
> > +#define ADDR_FORMAT  "0x%08lx"
> > +#endif
> > +static void dump_addr(struct pg_state *st, unsigned long addr)
> > +{
> > +     static const char units[] = "KMGTPE";
> > +     const char *unit = units;
> > +     unsigned long delta;
> > +
> > +     pt_dump_seq_printf(st->seq, ADDR_FORMAT "-" ADDR_FORMAT "   ",
> > +                        st->start_address, addr);
> > +
> > +     pt_dump_seq_printf(st->seq, " " ADDR_FORMAT " ", st->start_pa);
> > +     delta = (addr - st->start_address) >> 10;
> > +
> > +     while (!(delta & 1023) && unit[1]) {
> > +             delta >>= 10;
> > +             unit++;
> > +     }
> > +
> > +     pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
> > +                        pg_level[st->level].name);
> > +}
> > +
> > +static void note_prot_wx(struct pg_state *st, unsigned long addr)
> > +{
> > +     if (!st->check_wx)
> > +             return;
> > +
> > +     if ((st->current_prot & (_PAGE_WRITE | _PAGE_EXEC)) !=
> > +         (_PAGE_WRITE | _PAGE_EXEC))
> > +             return;
> > +
> > +     WARN_ONCE(1, "riscv/mm: Found insecure W+X mapping at address %p/%pS\n",
> > +               (void *)st->start_address, (void *)st->start_address);
> > +
> > +     st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
> > +}
> > +
> > +static void note_page(struct ptdump_state *pt_st, unsigned long addr,
> > +                   int level, unsigned long val)
> > +{
> > +     struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
> > +     u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
> > +     u64 prot = 0;
> > +
> > +     if (level >= 0)
> > +             prot = val & pg_level[level].mask;
> > +
> > +     if (st->level == -1) {
> > +             st->level = level;
> > +             st->current_prot = prot;
> > +             st->start_address = addr;
> > +             st->start_pa = pa;
> > +             st->last_pa = pa;
> > +             pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> > +     } else if (prot != st->current_prot ||
> > +                level != st->level || addr >= st->marker[1].start_address) {
> > +             if (st->current_prot) {
> > +                     note_prot_wx(st, addr);
> > +                     dump_addr(st, addr);
> > +                     dump_prot(st);
> > +                     pt_dump_seq_puts(st->seq, "\n");
> > +             }
> > +
> > +             while (addr >= st->marker[1].start_address) {
> > +                     st->marker++;
> > +                     pt_dump_seq_printf(st->seq, "---[ %s ]---\n",
> > +                                        st->marker->name);
> > +             }
> > +
> > +             st->start_address = addr;
> > +             st->start_pa = pa;
> > +             st->last_pa = pa;
> > +             st->current_prot = prot;
> > +             st->level = level;
> > +     } else {
> > +             st->last_pa = pa;
> > +     }
> > +}
> > +
> > +static void ptdump_walk(struct seq_file *s)
> > +{
> > +     struct pg_state st = {
> > +             .seq = s,
> > +             .marker = address_markers,
> > +             .level = -1,
> > +             .ptdump = {
> > +                     .note_page = note_page,
> > +                     .range = (struct ptdump_range[]) {
> > +                             {KERN_VIRT_START, ULONG_MAX},
> > +                             {0, 0}
> > +                     }
> > +             }
> > +     };
> > +
> > +     ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
> > +}
> > +
> > +void ptdump_check_wx(void)
> > +{
> > +     struct pg_state st = {
> > +             .seq = NULL,
> > +             .marker = (struct addr_marker[]) {
> > +                     {0, NULL},
> > +                     {-1, NULL},
> > +             },
> > +             .level = -1,
> > +             .check_wx = true,
> > +             .ptdump = {
> > +                     .note_page = note_page,
> > +                     .range = (struct ptdump_range[]) {
> > +                             {KERN_VIRT_START, ULONG_MAX},
> > +                             {0, 0}
> > +                     }
> > +             }
> > +     };
> > +
> > +     ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
> > +
> > +     if (st.wx_pages)
> > +             pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
>
> "FAILED" should be lowercase like "passed" below (or the other way around).

OK, I'll change them to be consistent in next version.

>
> > +                     st.wx_pages);
> > +     else
> > +             pr_info("Checked W+X mappings: passed, no W+X pages found\n");
> > +}
> > +
> > +static int ptdump_show(struct seq_file *m, void *v)
> > +{
> > +     ptdump_walk(m);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(ptdump);
> > +
> > +static int ptdump_init(void)
> > +{
> > +     unsigned int i, j;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> > +             for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
> > +                     pg_level[i].mask |= pte_bits[j].mask;
> > +
> > +     debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> > +                         &ptdump_fops);
> > +
> > +     return 0;
> > +}
> > +
> > +device_initcall(ptdump_init);
> >
>
> Other than the small comment above, I have tested it on my sv48 series
> (I had to do some small changes to adapt it, but nothing significant):

OK, maybe you could help to add the changes in your sv48 patch series.

>
> ---[ Fixmap start ]---
> 0xffff9dfffef00000-0xffff9dffff000000    0x0000000082200000         1M
> PTE     D A . . . W R V
> ---[ Fixmap end ]---
> ---[ PCI I/O start ]---
> ---[ PCI I/O end ]---
> ---[ vmalloc() area ]---
> 0xffffa00000000000-0xffffa00004000000    0x000000000c000000        64M
> PTE     D A . . . W R V
> 0xffffa00004001000-0xffffa00004002000    0x0000000010008000         4K
> PTE     D A . . . W R V
> 0xffffa00004003000-0xffffa00004004000    0x0000000010007000         4K
> PTE     D A . . . W R V
> 0xffffa00004005000-0xffffa00004006000    0x0000000010006000         4K
> PTE     D A . . . W R V
> 0xffffa00004011000-0xffffa00004012000    0x0000000010000000         4K
> PTE     D A . . . W R V
> 0xffffa0000401c000-0xffffa0000401f000    0x00000007af979000        12K
> PTE     D A . . . W R V
> 0xffffbffffffbb000-0xffffbffffffbe000    0x00000007b030e000        12K
> PTE     D A . . . W R V
> 0xffffbffffffcc000-0xffffbffffffcf000    0x00000007b0311000        12K
> PTE     D A . . . W R V
> 0xffffbffffffdd000-0xffffbffffffe0000    0x00000007b0314000        12K
> PTE     D A . . . W R V
> 0xffffbffffffee000-0xffffbfffffff1000    0x00000007b0317000        12K
> PTE     D A . . . W R V
> ---[ vmalloc() end ]---
> ---[ Linear mapping ]---
> 0xffffc00000000000-0xffffc00752e00000    0x0000000080200000     29998M
> PMD     D A . . X W R V
>
> You can then add:
>
> Tested-by: Alexandre Ghiti <alex@ghiti.fr>
>

Thank you for your testing.

> Thanks,
>
> Alex
