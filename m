Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8DC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CED2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WBcizLfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAOOz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:55:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9046 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOOzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:55:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yVkd1L6Qz9tylV;
        Wed, 15 Jan 2020 15:55:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WBcizLfB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yej87JrYwKck; Wed, 15 Jan 2020 15:55:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yVkd0G7Zz9tylT;
        Wed, 15 Jan 2020 15:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579100153; bh=drzSvcOTpHXGDw4v5FPxHbIJiwf/PfYcxldvnk1kSwk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WBcizLfBm8MCg5j0/7mTLx79/XdaaeLBVsccrdfLkd25w0FQKLPdjjv2cEs65IzaG
         n7kbUMCh+PZxCzwPJMNrVX+L9UuptNN6BSkmJe/H8+LBkp0v3k/wUYLdqKncLAGHca
         1HF86g2D7YcBKJ5kr3I0fUYximDPIOfMNE5i8k8k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82FF08B805;
        Wed, 15 Jan 2020 15:55:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4a6NedTi81Jj; Wed, 15 Jan 2020 15:55:54 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 60D828B774;
        Wed, 15 Jan 2020 15:55:54 +0100 (CET)
Subject: Re: [PATCH v2] Fix display of Maximum Memory
To:     Michael Bringmann <mwb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
References: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9a3b1c39-8c4f-6376-ff00-2e06190d0c67@c-s.fr>
Date:   Wed, 15 Jan 2020 15:55:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/01/2020 à 15:53, Michael Bringmann a écrit :
> Correct overflow problem in calculation+display of Maximum Memory
> value to syscfg where 32bits is insufficient.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/platforms/pseries/lparcfg.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index e33e8bc..f00411c 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -433,12 +433,12 @@ static void parse_em_data(struct seq_file *m)
>   
>   static void maxmem_data(struct seq_file *m)
>   {
> -	unsigned long maxmem = 0;
> +	u64 maxmem = 0;
>   
> -	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
> -	maxmem += hugetlb_total_pages() * PAGE_SIZE;
> +	maxmem += (u64)drmem_info->n_lmbs * drmem_info->lmb_size;
> +	maxmem += (u64)hugetlb_total_pages() * PAGE_SIZE;
>   
> -	seq_printf(m, "MaxMem=%ld\n", maxmem);
> +	seq_printf(m, "MaxMem=%llu\n", maxmem);
>   }
>   
>   static int pseries_lparcfg_data(struct seq_file *m, void *v)
> 
