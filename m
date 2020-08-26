Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA89C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6735620707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHZIhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:37:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63943 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgHZIhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:37:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bbzkh37FWz9tyjT;
        Wed, 26 Aug 2020 10:37:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F7HkzAmN4Nfz; Wed, 26 Aug 2020 10:37:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bbzkh2GV1z9tyjS;
        Wed, 26 Aug 2020 10:37:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 748488B82E;
        Wed, 26 Aug 2020 10:37:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zkDSwkkPY4fl; Wed, 26 Aug 2020 10:37:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B61B58B835;
        Wed, 26 Aug 2020 10:37:32 +0200 (CEST)
Subject: Re: [PATCH] Revert "powerpc/powernv/idle: Replace CPU feature check
 with PVR check"
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, mikey@neuling.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
References: <20200826082918.89306-1-psampat@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1fb7fcef-a39d-d36e-35d5-021a5c9ea82c@csgroup.eu>
Date:   Wed, 26 Aug 2020 10:37:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826082918.89306-1-psampat@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/08/2020 à 10:29, Pratik Rajesh Sampat a écrit :
> Cpuidle stop state implementation has minor optimizations for P10
> where hardware preserves more SPR registers compared to P9.
> The current P9 driver works for P10, although does few extra
> save-restores. P9 driver can provide the required power management
> features like SMT thread folding and core level power savings
> on a P10 platform.
> 
> Until the P10 stop driver is available, revert the commit which
> allows for only P9 systems to utilize cpuidle and blocks all
> idle stop states for P10.
> Cpu idle states are enabled and tested on the P10 platform
> with this fix.
> 
> This reverts commit 8747bf36f312356f8a295a0c39ff092d65ce75ae.
> 
> Fixes: 8747bf36f312 ("powerpc/powernv/idle: Replace CPU feature check with PVR check")
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>   @mpe: This revert would resolve a staging issue wherein the P10 stop
>   driver is not yet ready while cpuidle stop states need not be blocked
>   on 5.9 for Power10 systems which could cause SMT folding related
>   performance issues.
> 
>   The P10 stop driver is in the works here:
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216773.html
> 
>   arch/powerpc/platforms/powernv/idle.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 77513a80cef9..345ab062b21a 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -1223,7 +1223,7 @@ static void __init pnv_probe_idle_states(void)
>   		return;
>   	}
>   
> -	if (pvr_version_is(PVR_POWER9))
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))

Why not something like:

	if (pvr_version_is(PVR_POWER9) || pvr_version_is(PVR_POWER10))
		pnv_power9_idle_init();


>   		pnv_power9_idle_init();
>   
>   	for (i = 0; i < nr_pnv_idle_states; i++)
> 

Christophe
