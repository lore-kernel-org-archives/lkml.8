Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73562C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2E20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L8h8JHWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgDGJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:17:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40830 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:17:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id y71so871389oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D77AbQbLILoEautT7eBJR6pylqABbqtx1s3GXkCGPvU=;
        b=L8h8JHWPPE5e5IjKHj/KIrGUW7OQSTxyIdoYT0avlrAxkQPITdHDJTCss8bsl6BDVo
         Bv6BYIQZtU56B8GM2b23qbu4M3zaRj7HqQcUSVsJ7gb+IaWtYK8RsCUQBAo93GBtmvcx
         /e6n3xQUuo28Leh45AXBUL7HOcHn2lKhbwCZARkCSnCZz1brOLsHEgZiThmFPUt69rIb
         yrcRpoEY+NM2dP5So+XBvyqvoTrGcT3tEMVH82rAG2eKeSiKuLYXolsPDZDImYKl3R45
         5IpPxLz4n4rTGmQvGoJe6y//E04Y2SU92MpczmEiKdtABlx96GLPxoXlaGY2RyAMAt4+
         Ij1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D77AbQbLILoEautT7eBJR6pylqABbqtx1s3GXkCGPvU=;
        b=ue4ESYVju2XyHvsmk2S/om5KUu2CB06g7bXLEI+UbU0a5RFMpczl+gHlAvWDg3sI/l
         Be7zWlN6ybgtZ8nKlU+KPKQk1/ndQi4DnTvrQwVQkl1VkZ5JSkVA5g/06d3IybH2aV7G
         El1sVbsBFpL45rqqYtKuhuqV5EB1qDm3g44275Bfa7qJ/nkMrGqhPrk1PJgu2+bwl6tT
         fQJimfrW7tVi+blOUghgaO/MinHJW90gfEU9PZk4LLKlaSFjrRAMQ82x8/xgRW7Lygzi
         y96NRV7Ti/PU5rorMxibAzhDD8ihMa6MMyr+AI4/zCHB1GYHB6+bw6GH1B22yOFhTMN0
         273A==
X-Gm-Message-State: AGi0PuaQqSFYoJAZ665eZFXf5Ulk9V55OoUeICszE5jDardaVQZqY+kV
        fPnh4tZ+tn9IqGsJbpAnXX5DuBzR/MQhMnQDeBzxwfXq
X-Google-Smtp-Source: APiQypIE+B91iz8/BuW7W1OkVLd6tGb2FK7jOm9bG10/ZZbWWtcBmU0LGdfCSLwh++ulbiEdTNQ6PM/IdVf7ydrdWXI=
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr929598oij.91.1586251052494;
 Tue, 07 Apr 2020 02:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584352425.git.zong.li@sifive.com> <286a940ef8fbc4480c63679271eea440d167a258.1584352425.git.zong.li@sifive.com>
 <507f88a2-63c0-f615-2684-a200dd44c34a@ghiti.fr>
In-Reply-To: <507f88a2-63c0-f615-2684-a200dd44c34a@ghiti.fr>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 7 Apr 2020 17:17:22 +0800
Message-ID: <CANXhq0oduoX-gdG17FCwqpS5GAvY9w13B8a7YP0t2vNAHvKB_g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] riscv/kaslr: introduce functions to clear page table
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

On Tue, Apr 7, 2020 at 1:09 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> On 3/24/20 3:30 AM, Zong Li wrote:
> > In KASLR, we need to re-create page table after getting a random
> > destination. Introduce clear function to clear old content. Also, the
> > page table entries allow writing value when it's empty, so we have to
> > clear the early page table.
> >
> > This patch is a preparation to support KASLR.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >   arch/riscv/mm/init.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index ace5d74fd939..51e263c04fa2 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -315,6 +315,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
> >   #define get_pgd_next_virt(__pa)     get_pmd_virt(__pa)
> >   #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)  \
> >       create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
> > +#define clear_pgd_next_mapping(__nextp)      clear_pmd(__nextp)
> >   #define fixmap_pgd_next             fixmap_pmd
> >   #else
> >   #define pgd_next_t          pte_t
> > @@ -322,6 +323,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
> >   #define get_pgd_next_virt(__pa)     get_pte_virt(__pa)
> >   #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)  \
> >       create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
> > +#define clear_pgd_next_mapping(__nextp)      clear_pte(__nextp)
> >   #define fixmap_pgd_next             fixmap_pte
> >   #endif
> >
> > @@ -361,6 +363,58 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
> >       return PMD_SIZE;
> >   }
> >
> > +#ifdef CONFIG_RANDOMIZE_BASE
> > +static void __init clear_pte(pte_t *ptep)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < PTRS_PER_PTE; i++)
> > +             if (!pte_none(ptep[i]))
> > +                     ptep[i] = __pte(0);
> > +}
> > +
> > +static void __init clear_pmd(pmd_t *pmdp)
> > +{
> > +     unsigned int i;
> > +     pte_t *ptep;
> > +     phys_addr_t pte_phys;
> > +     uintptr_t kaslr_offset = get_kaslr_offset();
> > +
> > +     for (i = 0; i < PTRS_PER_PMD; i++)
> > +             if (!pmd_none(pmdp[i])) {
> > +                     if (pmd_leaf(pmdp[i])) {
> > +                             pmd_clear(&pmdp[i]);
> > +                     } else {
> > +                             pte_phys = PFN_PHYS(_pmd_pfn(pmdp[i]));
> > +                             ptep = get_pte_virt(pte_phys + kaslr_offset);
> > +                             clear_pte(ptep);
> > +                             pmd_clear(&pmdp[i]);
> > +                     }
> > +             }
> > +}
> > +
> > +static void __init clear_pgd(pgd_t *pgdp)
> > +{
> > +     unsigned int i;
> > +     pgd_next_t *nextp;
> > +     phys_addr_t next_phys;
> > +     uintptr_t kaslr_offset = get_kaslr_offset();
> > +
> > +     for (i = 0; i < PTRS_PER_PGD; i++)
> > +             if (pgd_val(pgdp[i]) != 0) {
> > +                     if (pgd_leaf(pgd_val(pgdp[i]))) {
> > +                             set_pgd(&pgdp[i], __pgd(0));
> > +                     } else {
> > +                             next_phys = PFN_PHYS(_pgd_pfn(pgdp[i]));
> > +                             nextp = get_pgd_next_virt(next_phys +
> > +                                                       kaslr_offset);
> > +                             clear_pgd_next_mapping(nextp);
> > +                             set_pgd(&pgdp[i], __pgd(0));
> > +                     }
> > +             }
> > +}
> > +#endif
> > +
> >   /*
> >    * setup_vm() is called from head.S with MMU-off.
> >    *
> >
>
> If this is only for clearing early page tables, a memset is way easier
> as there is only one page per level to clear.
>

Yes, it's a better way. Thanks.

> Alex
