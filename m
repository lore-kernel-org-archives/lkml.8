Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB4C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7C920732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cqogE+Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894958AbgDPPpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:45:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27965 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409697AbgDPPpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:45:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4933T9602Wz9v0Dg;
        Thu, 16 Apr 2020 17:45:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cqogE+Hg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6-P7NnOgxhsJ; Thu, 16 Apr 2020 17:45:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4933T94ngbz9v0Dd;
        Thu, 16 Apr 2020 17:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587051917; bh=JkpBj3S6Dr6booFxkuWAdt+jfr5g9VwGCNV78c0UroA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cqogE+HgxEBYPVWoDPYCHajDziZwrXF0HE3ko9cPEuSvvrnGlEGBUqC6d/PbV24mk
         Jtpcn+Ku9dwngiYaXXz1A1jpCGs/KQwwo5r2QmHHyvXnXNVH+68PPX1TZLiMSw6HrG
         K5+BkxgUEMauepYfavBO8FaXRo+uFlBOfl35Vwug=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5824E8BB89;
        Thu, 16 Apr 2020 17:45:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jTN2uoGRYiGp; Thu, 16 Apr 2020 17:45:19 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEBF78BB8C;
        Thu, 16 Apr 2020 17:45:18 +0200 (CEST)
Subject: Re: [PATCH v4,2/4] powerpc: sysdev: fix compile error for
 fsl_85xx_cache_sram
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
 <20200416153537.23736-3-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8e9cff87-cf9c-da16-fc96-73b974e8203f@c-s.fr>
Date:   Thu, 16 Apr 2020 17:45:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416153537.23736-3-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 17:35, Wang Wenhu a écrit :
> Include linux/io.h into fsl_85xx_cache_sram.c to fix the
> implicit-declaration compile error when building Cache-Sram.
> 
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                            ^~~~~~~~~~~~~~~~
>                            bitmap_complement
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                          ^
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
>    iounmap(cache_sram->base_virt);
>    ^~~~~~~
>    roundup
> cc1: all warnings being treated as errors
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> Changes since v1:
>   * None
> Changes since v2:
>   * None
> Changes since v3:
>   * None
> ---
>   arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> index f6c665dac725..be3aef4229d7 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -17,6 +17,7 @@
>   #include <linux/of_platform.h>
>   #include <asm/pgtable.h>
>   #include <asm/fsl_85xx_cache_sram.h>
> +#include <linux/io.h>
>   
>   #include "fsl_85xx_cache_ctlr.h"
>   
> 
