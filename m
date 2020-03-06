Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C76C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B447C2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Jz35VSqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgCFG43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:56:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6097 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgCFG43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:56:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Ydgt3B8Hz9txgh;
        Fri,  6 Mar 2020 07:56:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Jz35VSqC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FyjWRpBQZ4C9; Fri,  6 Mar 2020 07:56:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Ydgt206Pz9txgZ;
        Fri,  6 Mar 2020 07:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583477786; bh=H55nzcmxh7V1cddi0UhKfI61T6Z6P/Eblvkn6q2IeGA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jz35VSqCtC5bJghsDpbJwtCkfUQxPVtusOPGOj8Lircxn2BSUDyzTN2ynWXXi/dq+
         K4vmRkwxSO1GvH+X+RGt1vKT2wjeLdwH5NPMNo0KhpjGlI+dG/rwU2gED8Tw3s/Bx5
         tIxB6RG/JdszizpCWwPDG0g0k8YHaxhD/w/N4RbQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2025C8B77E;
        Fri,  6 Mar 2020 07:56:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dg2xiB3HEfHY; Fri,  6 Mar 2020 07:56:27 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E552E8B752;
        Fri,  6 Mar 2020 07:56:26 +0100 (CET)
Subject: Re: [PATCH v3] powerpc/64s/pgtable: fix an undefined behaviour
To:     Qian Cai <cai@lca.pw>, mpe@ellerman.id.au
Cc:     rashmicy@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200306044852.3236-1-cai@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <952c3921-5aa8-bff5-9a87-baf5f901c535@c-s.fr>
Date:   Fri, 6 Mar 2020 07:56:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306044852.3236-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/03/2020 à 05:48, Qian Cai a écrit :
> Booting a power9 server with hash MMU could trigger an undefined
> behaviour because pud_offset(p4d, 0) will do,
> 
> 0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)
> 
> Fix it by converting pud_index() and friends to static inline
> functions.
> 
> UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
> shift exponent 34 is too large for 32-bit type 'int'
> CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ #13
> Call Trace:
> dump_stack+0xf4/0x164 (unreliable)
> ubsan_epilogue+0x18/0x78
> __ubsan_handle_shift_out_of_bounds+0x160/0x21c
> walk_pagetables+0x2cc/0x700
> walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
> (inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
> ptdump_check_wx+0x8c/0xf0
> mark_rodata_ro+0x48/0x80
> kernel_init+0x74/0x194
> ret_from_kernel_thread+0x5c/0x74
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> 
> v3: convert pud_index() etc to static inline functions.
> v2: convert pud_offset() etc to static inline functions.
> 
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 23 ++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 201a69e6a355..bd432c6706b9 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -998,10 +998,25 @@ extern struct page *pgd_page(pgd_t pgd);
>   #define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
>   #define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
>   
> -#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
> -#define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
> -#define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
> -#define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
> +static inline unsigned long pgd_index(unsigned long address)
> +{
> +	return (address >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1);
> +}
> +
> +static inline unsigned long pud_index(unsigned long address)
> +{
> +	return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
> +}
> +
> +static inline unsigned long pmd_index(unsigned long address)
> +{
> +	return (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
> +}
> +
> +static inline unsigned long pte_index(unsigned long address)
> +{
> +	return (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
> +}
>   
>   /*
>    * Find an entry in a page-table-directory.  We combine the address region
> 
