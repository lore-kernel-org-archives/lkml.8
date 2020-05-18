Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F4EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC2520787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgERKhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:37:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38755 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERKhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:37:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49Qb6W1q99z9txc5;
        Mon, 18 May 2020 12:36:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aoBlJkWUGX65; Mon, 18 May 2020 12:36:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49Qb6W12mbz9txc4;
        Mon, 18 May 2020 12:36:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6DC38B76A;
        Mon, 18 May 2020 12:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ure_5nwPKksx; Mon, 18 May 2020 12:36:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91A498B796;
        Mon, 18 May 2020 12:36:56 +0200 (CEST)
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
To:     Jiri Kosina <jikos@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     WANG Wenhu <wenhu.wang@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wenhu.pku@gmail.com
References: <20200302053801.26027-1-wenhu.wang@vivo.com>
 <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr>
 <nycvar.YFH.7.76.2005181228480.25812@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2005181232140.25812@cbobk.fhfr.pm>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <494faa28-e994-14e9-71da-07f5214b4579@csgroup.eu>
Date:   Mon, 18 May 2020 12:36:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2005181232140.25812@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/05/2020 à 12:32, Jiri Kosina a écrit :
> On Mon, 18 May 2020, Jiri Kosina wrote:
> 
>>>> Include linux/io.h into fsl_85xx_cache_sram.c to fix the
>>>> implicit-declaration compile errors when building Cache-Sram.
>>>>
>>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function
>>>> ‘instantiate_cache_sram’:
>>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration
>>>> of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’?
>>>> [-Werror=implicit-function-declaration]
>>>>     cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>>>>                             ^~~~~~~~~~~~~~~~
>>>>                             bitmap_complement
>>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes
>>>> pointer from integer without a cast [-Werror=int-conversion]
>>>>     cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>>>>                           ^
>>>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration
>>>> of function ‘iounmap’; did you mean ‘roundup’?
>>>> [-Werror=implicit-function-declaration]
>>>>     iounmap(cache_sram->base_virt);
>>>>     ^~~~~~~
>>>>     roundup
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
>>>> Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
>>>
>>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> As this doesn't seem to have been picked up for linux-next yet, I am
>> picking it up now.
> 
> Only now I've noticed that this is actually a dead code o_O as this file
> can't be built by any combination of config options. So I am dropping the
> patch again, but why do we keep it in the tree in the first place?
> 

There is a series aiming at making use of it, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=172421

Christophe
