Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA675C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4820842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZVzy7pg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgCCI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:59:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32168 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCCI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:59:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48WrYM44cWz9txZT;
        Tue,  3 Mar 2020 09:59:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZVzy7pg/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FrUTaAzeZjFb; Tue,  3 Mar 2020 09:59:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48WrYM2KgFz9txZS;
        Tue,  3 Mar 2020 09:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583225975; bh=0L++rQNOyOX2RddDfCYMG2qzx/vV9crQ/cfo3VeGzfg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZVzy7pg/L8fYkbRPrmDrcX/BAYqB6gqtgOrkG28Ea3kgN+dSD8SLT2M6ucSJXnw0l
         /3Dtm1C02MddqetTTT73+qvZbDhyGRsq7I94k/zB076YvJV+nsIQG477tGp1vsKou7
         6bDiG/ItO4tWp5UbSjoiCnbGrZrx92aSuYYVYCtM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AE8B8B7E8;
        Tue,  3 Mar 2020 09:59:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FSGT-1GJCZt8; Tue,  3 Mar 2020 09:59:36 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90FAD8B755;
        Tue,  3 Mar 2020 09:59:35 +0100 (CET)
Subject: Re: [PATCH v2 -next] powerpc/pmac/smp: drop unnecessary volatile
 qualifier
To:     YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20191225114943.17216-1-yuehaibing@huawei.com>
 <20200303085604.24952-1-yuehaibing@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0e2ed3d6-7f16-736e-9392-a326e8c89113@c-s.fr>
Date:   Tue, 3 Mar 2020 09:59:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303085604.24952-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/03/2020 à 09:56, YueHaibing a écrit :
> core99_l2_cache/core99_l3_cache no need to mark as volatile,
> just remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> v2: remove 'volatile' qualifier
> ---
>   arch/powerpc/platforms/powermac/smp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index f95fbde..69ad567 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -661,8 +661,8 @@ static void smp_core99_gpio_tb_freeze(int freeze)
>   #endif /* !CONFIG_PPC64 */
>   
>   /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
> -volatile static long int core99_l2_cache;
> -volatile static long int core99_l3_cache;
> +static long core99_l2_cache;
> +static long core99_l3_cache;
>   
>   static void core99_init_caches(int cpu)
>   {
> 
