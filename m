Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE1C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF024656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sfBhmYet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAOFlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:41:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:50218 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgAOFlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:41:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yGQX1mqXz9vJ9w;
        Wed, 15 Jan 2020 06:41:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sfBhmYet; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Rdx1R27WK1OZ; Wed, 15 Jan 2020 06:41:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yGQX0hprz9vJ9v;
        Wed, 15 Jan 2020 06:41:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579066868; bh=bRfKh/Cnz206aPF3lzBprN9c8zs4SrTAq3h16N+7SHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sfBhmYetSsi3Ss5SJ7e9KTZnHFjPXC9u/9eu80eR3zJl3thbTW15nJ05CUMBW0uVk
         pIRVniOt4PsZXoKE66DQwekei9xTv9g5nPtQzUZ/+rKGbFbOWZ5En6M3LW7E8ukZE1
         5Qf6V6TbteuqusiEM6OBNedAG9HkllYRJ9h6BETA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D655D8B77B;
        Wed, 15 Jan 2020 06:41:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ph2qjykawEAp; Wed, 15 Jan 2020 06:41:08 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9E618B774;
        Wed, 15 Jan 2020 06:41:08 +0100 (CET)
Subject: Re: [PATCH] Fix display of Maximum Memory
To:     Michael Bringmann <mwb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
References: <55f25626-20ca-0acb-3571-ff636ca4632c@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <41380afd-05f5-f36f-c857-041243c73ee3@c-s.fr>
Date:   Wed, 15 Jan 2020 06:41:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <55f25626-20ca-0acb-3571-ff636ca4632c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/01/2020 à 22:07, Michael Bringmann a écrit :
> Correct overflow problem in calculation+display of Maximum Memory
> value to syscfg where 32bits is insufficient.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/lparcfg.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index 4ee2594..183aeb7 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -435,12 +435,12 @@ static void parse_em_data(struct seq_file *m)
> 
>   static void maxmem_data(struct seq_file *m)
>   {
> -       unsigned long maxmem = 0;
> +       unsigned long long maxmem = 0;

What about using u64 instead, for readability ?

> 
> -       maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
> -       maxmem += hugetlb_total_pages() * PAGE_SIZE;
> +       maxmem += (unsigned long long)drmem_info->n_lmbs * (unsigned long long)drmem_info->lmb_size;

This line is likely too long. You only need to cast one of the two 
operants to force a 64 bits multiply. And using u64 would shorten the line.

Can both multiplications overflow ?

Christophe

> +       maxmem += (unsigned long long)hugetlb_total_pages() * (unsigned long long)PAGE_SIZE;
> 
> -       seq_printf(m, "MaxMem=%ld\n", maxmem);
> +       seq_printf(m, "MaxMem=%llu\n", maxmem);
>   }
> 
>   static int pseries_lparcfg_data(struct seq_file *m, void *v)
> 
