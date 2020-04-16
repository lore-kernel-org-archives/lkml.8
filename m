Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C2C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64BE21927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VQu6onov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896978AbgDPPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:47:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43161 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896922AbgDPPq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4933W23z1pz9v0Dg;
        Thu, 16 Apr 2020 17:46:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VQu6onov; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VcrSYe2_p3NK; Thu, 16 Apr 2020 17:46:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4933W22vFtz9v0Dd;
        Thu, 16 Apr 2020 17:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587052014; bh=dWtRS9v/g4OXTcObUgbK9gVeQ++nhY+FRB6UPZHaVb8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VQu6onovHrrv/JfhFDrCMMDp6V0Xn5VI4FFrZYWWDbirAe7+04uSNueSpIfM6egzD
         Pi425RVy0Q2Dv9v0bILGdeEWJOM5Zw/zpT7iXvH8n2vkGHC68fxqnphaB1KL264nKf
         4MijVpMWNOqK871Gg153J5J3JnJbXGWpgtqxY3MY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 953FC8BB8C;
        Thu, 16 Apr 2020 17:46:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7R2fX6PA1p5v; Thu, 16 Apr 2020 17:46:55 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1747F8BB89;
        Thu, 16 Apr 2020 17:46:51 +0200 (CEST)
Subject: Re: [PATCH v4,3/4] powerpc: sysdev: fix compile warning for
 fsl_85xx_cache_sram
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
 <20200416153537.23736-4-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fc8056f5-d1b1-8915-1884-2403f7b7a3f3@c-s.fr>
Date:   Thu, 16 Apr 2020 17:46:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416153537.23736-4-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 17:35, Wang Wenhu a écrit :
> Function instantiate_cache_sram should not be linked into the init
> section for its caller mpc85xx_l2ctlr_of_probe is none-__init.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> 
> Warning information:
>    MODPOST vmlinux.o
> WARNING: modpost: vmlinux.o(.text+0x1e540): Section mismatch in reference from the function mpc85xx_l2ctlr_of_probe() to the function .init.text:instantiate_cache_sram()
> The function mpc85xx_l2ctlr_of_probe() references
> the function __init instantiate_cache_sram().
> This is often because mpc85xx_l2ctlr_of_probe lacks a __init
> annotation or the annotation of instantiate_cache_sram is wrong.
> ---
> Changes since v1:
>   * None
> Changes since v2:
>   * None
> Changes since v3:
>   * None
> ---
>   arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> index be3aef4229d7..3de5ac8382c0 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -68,7 +68,7 @@ void mpc85xx_cache_sram_free(void *ptr)
>   }
>   EXPORT_SYMBOL(mpc85xx_cache_sram_free);
>   
> -int __init instantiate_cache_sram(struct platform_device *dev,
> +int instantiate_cache_sram(struct platform_device *dev,
>   		struct sram_parameters sram_params)
>   {
>   	int ret = 0;
> 
