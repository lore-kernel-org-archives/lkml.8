Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD0320723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgE3RWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 13:22:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15272 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE3RWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:22:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49Z7Y64FKHzB09b6;
        Sat, 30 May 2020 19:22:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oBdg8nh7GnbL; Sat, 30 May 2020 19:22:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49Z7Y62k5CzB09b5;
        Sat, 30 May 2020 19:22:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0A798B7B1;
        Sat, 30 May 2020 19:22:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PZJBAGeee5Vz; Sat, 30 May 2020 19:22:36 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A9AD8B75E;
        Sat, 30 May 2020 19:22:36 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32: disable KASAN with pages bigger than 16k
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
Message-ID: <afb1a3a9-8d7d-4c99-d42f-f6d78dcef0a5@csgroup.eu>
Date:   Sat, 30 May 2020 19:22:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/05/2020 à 12:17, Christophe Leroy a écrit :
> Mapping of early shadow area is implemented by using a single static
> page table having all entries pointing to the same early shadow page.
> The shadow area must therefore occupy full PGD entries.
> 
> The shadow area has a size of 128Mbytes starting at 0xf8000000.
> With 4k pages, a PGD entry is 4Mbytes
> With 16k pages, a PGD entry is 64Mbytes
> With 64k pages, a PGD entry is 256Mbytes which is too big.

That's for 32k pages that a PGD is 256Mbytes.

With 64k pages, a PGD entry is 1Gbytes which is too big.

Michael, can you fix the commit log ?

Thanks
Christophe

> 
> Until we rework the early shadow mapping, disable KASAN when the
> page size is too big.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1dfa59126fcf..066b36bf9efa 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -169,8 +169,8 @@ config PPC
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>   	select HAVE_ARCH_JUMP_LABEL
> -	select HAVE_ARCH_KASAN			if PPC32
> -	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
> +	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
> +	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> 
