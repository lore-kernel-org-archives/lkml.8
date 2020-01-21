Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611A822522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vYJPhRPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAUIhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:37:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55485 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgAUIhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:37:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48222r2tbWz9v0DF;
        Tue, 21 Jan 2020 09:37:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=vYJPhRPa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gKX4BKKZNaEM; Tue, 21 Jan 2020 09:37:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48222r1nMXz9v0DD;
        Tue, 21 Jan 2020 09:37:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579595828; bh=pWuTMOvIrZ5e55NW6SuX7mpcZeq3kBteI+512yICmEk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vYJPhRPa4PwpO2Lpn0rpPnvwd5qCVoDLsK/98O8D06VUkF7nz0YMzO6YDfvBZnHFC
         ZUpSHzlOFHz5jTl8QTVvKYd3kGrCEUejTSh1ERLdgMz3xpPruS5N3hMoP4EavI6vhI
         mFIKJqImSrrJ2DP3Cos/mGRPynA+uBt6fEKnYwQY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 44B3E8B7DB;
        Tue, 21 Jan 2020 09:37:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AVCj8jgSnr4G; Tue, 21 Jan 2020 09:37:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 70EFA8B776;
        Tue, 21 Jan 2020 09:37:07 +0100 (CET)
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
To:     =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, wangwenhu <wenhu.pku@gmail.com>,
        Paul Mackerras <paulus@samba.org>, trivial@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, lonehugo@hotmail.com
References: <ANcAOwAACK7otVnG7VF8E4rQ.3.1579589949706.Hmail.wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d3b340dc-54df-24f6-2831-50456beea7ab@c-s.fr>
Date:   Tue, 21 Jan 2020 09:37:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ANcAOwAACK7otVnG7VF8E4rQ.3.1579589949706.Hmail.wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/01/2020 à 07:59, 王文虎 a écrit :
> 发件人：Andrew Donnellan <ajd@linux.ibm.com>
> 发送日期：2020-01-21 14:13:07
> 收件人：wangwenhu <wenhu.pku@gmail.com>,Benjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,Kate Stewart <kstewart@linuxfoundation.org>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,Richard Fontana <rfontana@redhat.com>,Thomas Gleixner <tglx@linutronix.de>,linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
> 抄送人：trivial@kernel.org,lonehugo@hotmail.com,wenhu.wang@vivo.com
> 主题：Re: [PATCH] powerpc/sysdev: fix compile errors>On 21/1/20 4:31 pm, wangwenhu wrote:
>>> From: wangwenhu <wenhu.wang@vivo.com>
>>>
>>> Include arch/powerpc/include/asm/io.h into fsl_85xx_cache_sram.c to
>>> fix the implicit declaration compile errors when building Cache-Sram.
>>>
>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
>>>     cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>>>                             ^~~~~~~~~~~~~~~~
>>>                             bitmap_complement
>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>>>     cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>>>                           ^
>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
>>>     iounmap(cache_sram->base_virt);
>>>     ^~~~~~~
>>>     roundup
>>> cc1: all warnings being treated as errors
>>>
>>> Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
>>
>> How long has this code been broken for?
> 
> It's been broken almost 15 months since the commit below:
> "commit aa91796ec46339f2ed53da311bd3ea77a3e4dfe1
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Tue Oct 9 13:51:41 2018 +0000
> 
>      powerpc: don't use ioremap_prot() nor __ioremap() unless really needed."
> 
> And we are working on it now for further development.

That's pretty surprising. That commit didn't change the iounmap(). It 
only replaced ioremap_prot() by ioremap_coherent(). Both are defined in io.h

Christophe

> 
>>
>>> ---
>>>    arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
>>> index f6c665dac725..29b6868eff7d 100644
>>> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
>>> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/of_platform.h>
>>>    #include <asm/pgtable.h>
>>>    #include <asm/fsl_85xx_cache_sram.h>
>>> +#include <asm/io.h>
>>>
>>>    #include "fsl_85xx_cache_ctlr.h"
>>>
>>
>> -- 
>> Andrew Donnellan              OzLabs, ADL Canberra
>> ajd@linux.ibm.com             IBM Australia Limited
>>
> 
> Wenhu
> 
