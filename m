Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EF020714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585031910;
	bh=YHmxPLk7xsrCqMibnpPOp4+KlNmcqIXEP+uJ6dA0dQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=emjBSGQm0fz1m28W4woPh0s18ScoHiwlYVkXUJZl2YUjOTtLBOqgL+ADtUiadCXa2
	 Kv5TufqcZftlKScZU6+q/BXDzl/rs3jGl04tprcSyPko0Jj/J+AcAPX0tjfGD6HfRD
	 R0i62UM7MzkUOZPdSdZRLPp4+13RcKVO5YUMFPo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCXGi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgCXGi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:38:28 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FC72073E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585031907;
        bh=YHmxPLk7xsrCqMibnpPOp4+KlNmcqIXEP+uJ6dA0dQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sKWJNytmD0Hbm46pl2mSUPX5IUNmLW/zyfsiSGwnxI8QKfoKFCzDg4OpgDwriJvYZ
         gf7fMQub3wDLINiKEal0YRbbqXNCdqyVNn7pkoT5qGqArunLmyLxaNVWdMO5tAZIQz
         ZHS4iXk6t1GGMGXZJQr1NYLpG6P6ljFvv8pmPfqc=
Received: by mail-lf1-f52.google.com with SMTP id s1so12235206lfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:38:26 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1qYfc78ml1K0nHtJiEmiGpulnQiM9QNE2V8NecdsnORj3J3Jhq
        2V80EcsZJdUBJGKlU4PVBJCKlnAWqaF0SyKpy50=
X-Google-Smtp-Source: ADFU+vuVBnqtUtC8s4liLpWIYdpYefGqMsDSqXF43YebtyO81P2fmLftfJ85/O71bF8FyG2Y4poDJ9zX2AnRJaLWnNc=
X-Received: by 2002:a19:41c5:: with SMTP id o188mr4668305lfa.52.1585031904839;
 Mon, 23 Mar 2020 23:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200324054945.26733-1-nickhu@andestech.com>
In-Reply-To: <20200324054945.26733-1-nickhu@andestech.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 24 Mar 2020 14:38:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS-SokSES0fUQxEXJpX3Puk8r-Dyoowhv422T4r-PVO0w@mail.gmail.com>
Message-ID: <CAJF2gTS-SokSES0fUQxEXJpX3Puk8r-Dyoowhv422T4r-PVO0w@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: synchronize MMU after page table update
To:     Nick Hu <nickhu@andestech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, nylon7@andestech.com,
        Alan Kao <alankao@andestech.com>, alexios.zavras@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, npiggin@gmail.com,
        Anup Patel <anup@brainfault.org>, Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:50 PM Nick Hu <nickhu@andestech.com> wrote:
>
> Similar to commit bf587caae305 ("riscv: mm: synchronize MMU after pte change")
>
> For those riscv implementations whose TLB cannot synchronize with dcache,
> an SFENCE.VMA is necessary after page table update.
> This patch fixed two functions:
>
> 1. pgd_alloc
> During fork, a parent process prepares pgd for its child and updates satp
> later, but they may not run on the same core. Adding a remote SFENCE.VMA to
> invalidate TLB in other cores is needed. Thus use flush_tlb_all() instead
> of local_flush_tlb_all() here.
> Similar approaches can be found in arm and csky.
>
> 2. __set_fixmap
> Add a SFENCE.VMA after fixmap pte update.
> Similar approaches can be found in arm and sh.
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> Cc: Alan Kao <alankao@andestech.com>
> ---
>  arch/riscv/include/asm/pgalloc.h | 1 +
>  arch/riscv/mm/init.c             | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 3f601ee8233f..071468fa14b7 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -51,6 +51,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>                 memcpy(pgd + USER_PTRS_PER_PGD,
>                         init_mm.pgd + USER_PTRS_PER_PGD,
>                         (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +               flush_tlb_all();
Are you sure to put a tlb flush operation here ? I think it should be
a dcache flush ops (but there is no solution for riscv ISA :P)

Ref to csky's implementation, just some old cores need sync dcache
with tlb by a simple dcache flush range ops and tlb ops should be put
in another place due to Linux infrastructure.

static inline pgd_t *pgd_alloc(struct mm_struct *mm)
{
        pgd_t *ret;
        pgd_t *init;

        ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
        if (ret) {
                init = pgd_offset(&init_mm, 0UL);
                pgd_init((unsigned long *)ret);
                memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
                        (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
                /* prevent out of order excute */
                smp_mb();
#ifdef CONFIG_CPU_NEED_TLBSYNC
                dcache_wb_range((unsigned int)ret,
                                (unsigned int)(ret + PTRS_PER_PGD));
#endif
        }

        return ret;
}


>         }
>         return pgd;
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fab855963c73..a7f329503ed0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -203,8 +203,8 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
>         } else {
>                 pte_clear(&init_mm, addr, ptep);
> -               local_flush_tlb_page(addr);
>         }
> +       local_flush_tlb_page(addr);
>  }
>
>  static pte_t *__init get_pte_virt(phys_addr_t pa)
> --
> 2.17.0
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
