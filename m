Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8046C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9EE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="t7TBskuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894837AbgDPPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:45:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408807AbgDPPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:45:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4933Sz0Q8Xz9v1Gk;
        Thu, 16 Apr 2020 17:45:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=t7TBskuI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gM0sTaOXWo6j; Thu, 16 Apr 2020 17:45:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4933Sy6KrZz9v1Gh;
        Thu, 16 Apr 2020 17:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587051906; bh=fx3Isv14Y2j4eGDqA4En7E6BdVY5FSeetdllcbdJEPg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t7TBskuIRkQdJeP7ytl69BTcntGTppR6QIPHUrCDaBfZv89SuMjA+te/RJnEf8yzu
         eOGGhnfKB1iPTjV4HFENaodWX7NVguUmm6gXye3WzpM1n115rYp21fscPSq9OcjXIc
         niBfeNj9xo0YcAfX9IJLZq+hclqsRluykpEThpdI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9E638BB9E;
        Thu, 16 Apr 2020 17:45:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9HsEZqbDwChe; Thu, 16 Apr 2020 17:45:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9898F8BB8C;
        Thu, 16 Apr 2020 17:45:07 +0200 (CEST)
Subject: Re: [PATCH v4,1/4] powerpc: sysdev: fix compile error for
 fsl_85xx_l2ctlr
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
 <20200416153537.23736-2-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1105bd86-9647-7975-6232-7aae3d0a63cf@c-s.fr>
Date:   Thu, 16 Apr 2020 17:45:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416153537.23736-2-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 17:35, Wang Wenhu a écrit :
> Include "linux/of_address.h" to fix the compile error for
> mpc85xx_l2ctlr_of_probe() when compiling fsl_85xx_cache_sram.c.
> 
>    CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c: In function ‘mpc85xx_l2ctlr_of_probe’:
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:11: error: implicit declaration of function ‘of_iomap’; did you mean ‘pci_iomap’? [-Werror=implicit-function-declaration]
>    l2ctlr = of_iomap(dev->dev.of_node, 0);
>             ^~~~~~~~
>             pci_iomap
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:9: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>    l2ctlr = of_iomap(dev->dev.of_node, 0);
>           ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:267: recipe for target 'arch/powerpc/sysdev/fsl_85xx_l2ctlr.o' failed
> make[2]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
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
>   arch/powerpc/sysdev/fsl_85xx_l2ctlr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> index 2d0af0c517bb..7533572492f0 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
> @@ -10,6 +10,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of_platform.h>
> +#include <linux/of_address.h>
>   #include <asm/io.h>
>   
>   #include "fsl_85xx_cache_ctlr.h"
> 
