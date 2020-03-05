Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A85FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22D20801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ASgy7a0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCETWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:22:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59407 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCETWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:22:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48YLH26gCqz9txHb;
        Thu,  5 Mar 2020 20:22:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ASgy7a0Z; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fd6PBkBp02eH; Thu,  5 Mar 2020 20:22:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48YLH25D6Gz9txHc;
        Thu,  5 Mar 2020 20:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583436142; bh=O7DpUFv/GFeL+4wPoRSCt6mdhdbvppZhJ64ANxysAUo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ASgy7a0ZqLkxRdb3DceHvO+mLgQKU1tMbZ07u7XCKHkkS4nXidpiHFN9k8MuwbRIE
         l/Q/M1sYuJlStSTJbl2Nn7+/4284wKMuasRg4hYceHY0SBe8UMVTKAog1cGcaEvmgp
         L9LIH9gWcqY2nIhw5m4y14tMiG9EQbEsN+cNbFlQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA4F38B880;
        Thu,  5 Mar 2020 20:22:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0fQKJ7guOVrA; Thu,  5 Mar 2020 20:22:22 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF5948B87E;
        Thu,  5 Mar 2020 20:22:21 +0100 (CET)
Subject: Re: [PATCH -next v2] powerpc/64s/pgtable: fix an undefined behaviour
To:     Qian Cai <cai@lca.pw>, mpe@ellerman.id.au,
        akpm@linux-foundation.org
Cc:     rashmicy@gmail.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1583418759-16105-1-git-send-email-cai@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a082f4c3-db68-6ca3-c832-b1abb5363e3a@c-s.fr>
Date:   Thu, 5 Mar 2020 20:22:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583418759-16105-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/03/2020 à 15:32, Qian Cai a écrit :
> Booting a power9 server with hash MMU could trigger an undefined
> behaviour because pud_offset(p4d, 0) will do,
> 
> 0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)
> 
> Fix it by converting pud_offset() and friends to static inline
> functions.

I was suggesting to convert pud_index() to static inline, because that's 
where the shift sits. Is it not possible ?

Here you seems to fix the problem for now, but if someone reuses 
pud_index() in another macro one day, the same problem may happen again.

Christophe

> 
>   UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
>   shift exponent 34 is too large for 32-bit type 'int'
>   CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ #13
>   Call Trace:
>   dump_stack+0xf4/0x164 (unreliable)
>   ubsan_epilogue+0x18/0x78
>   __ubsan_handle_shift_out_of_bounds+0x160/0x21c
>   walk_pagetables+0x2cc/0x700
>   walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
>   (inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
>   ptdump_check_wx+0x8c/0xf0
>   mark_rodata_ro+0x48/0x80
>   kernel_init+0x74/0x194
>   ret_from_kernel_thread+0x5c/0x74
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index fa60e8594b9f..4967bc9e25e2 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1016,12 +1016,20 @@ static inline bool p4d_access_permitted(p4d_t p4d, bool write)
>   
>   #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
>   
> -#define pud_offset(p4dp, addr)	\
> -	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
> -#define pmd_offset(pudp,addr) \
> -	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
> -#define pte_offset_kernel(dir,addr) \
> -	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
> +static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> +{
> +	return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
> +}
> +
> +static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
> +{
> +	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> +}
> +
> +static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
> +{
> +	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
> +}
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
>   
> 
