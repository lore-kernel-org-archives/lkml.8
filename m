Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124FC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6634B207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Mlu6cmGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgBTNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:49:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32729 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgBTNtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:49:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48NbYh1hVyz9v0MK;
        Thu, 20 Feb 2020 14:49:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Mlu6cmGM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OFAoWcNwe3RW; Thu, 20 Feb 2020 14:49:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48NbYh0JY5z9v0MJ;
        Thu, 20 Feb 2020 14:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582206584; bh=BNmen+R0A95fKF9yP5dTxuzGe+sL7dAQ7ChpuSoUS5c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mlu6cmGMba4L0sYZwxMEPfQwvJ+HCjrFncFIsGGZhNyFJqdvp9qEWWiTgnEWpp9RL
         pciPb9n1ehAPK8yK4dlvakvdTx+sF/pfbSYPOROhLft3wEXG7RqrGpunAuYLHnv2JL
         o4VjCgVlhpSuA13ZUihgB11Y+lLOuB4UgA0nkJHE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61A838B86D;
        Thu, 20 Feb 2020 14:49:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N_Jiuu8x05kS; Thu, 20 Feb 2020 14:49:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACB748B866;
        Thu, 20 Feb 2020 14:49:44 +0100 (CET)
Subject: Re: [PATCH v3 5/6] powerpc/fsl_booke/64: clear the original kernel if
 randomized
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com,
        oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <20200206025825.22934-6-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0f778e1c-5e29-e600-1cf0-aeb3e1a6fe08@c-s.fr>
Date:   Thu, 20 Feb 2020 14:49:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200206025825.22934-6-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/02/2020 à 03:58, Jason Yan a écrit :
> The original kernel still exists in the memory, clear it now.

No such problem with PPC32 ? Or is that common ?

Christophe

> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/mm/nohash/kaslr_booke.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
> index c6f5c1db1394..ed1277059368 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -378,8 +378,10 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
>   	unsigned int *__kaslr_offset = (unsigned int *)(KERNELBASE + 0x58);
>   	unsigned int *__run_at_load = (unsigned int *)(KERNELBASE + 0x5c);
>   
> -	if (*__run_at_load == 1)
> +	if (*__run_at_load == 1) {
> +		kaslr_late_init();
>   		return;
> +	}
>   
>   	/* Setup flat device-tree pointer */
>   	initial_boot_params = dt_ptr;
> 
