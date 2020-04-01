Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4953207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cb5oyV75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgDAGdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:33:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25085 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbgDAGdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:33:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sbxY6r4Xz9txbT;
        Wed,  1 Apr 2020 08:33:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cb5oyV75; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zYu6vhpDCY0H; Wed,  1 Apr 2020 08:33:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sbxY5JsVz9txbR;
        Wed,  1 Apr 2020 08:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585722817; bh=Wu7Hf+9jIPkGojr6+lEuEJG5F/BNn5V9Djrlob/oB1k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cb5oyV75n6MwS+iynLK6NifEgmf7iS8oiMbsGzDJYP6M+CimG8gcDwmrXaVQnkBR5
         0NkTyWqUYmOsih9w2j8opcqOzvtsvYWWAleV2te74sxesizpoeUi0wDuLkvBc0LC+5
         xAF9u4BTnHvt7mSwR3hZdmDXf2UB/vKuTo0XJulI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 878D78B7B3;
        Wed,  1 Apr 2020 08:33:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9DYyir0Z_bBL; Wed,  1 Apr 2020 08:33:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AEAA8B778;
        Wed,  1 Apr 2020 08:33:36 +0200 (CEST)
Subject: Re: [PATCH v2 08/16] powerpc/watchpoint: Disable all available
 watchpoints when !dawr_force_enable
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-9-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1bef7056-b862-3b20-c3b8-8b161511c60a@c-s.fr>
Date:   Wed, 1 Apr 2020 08:33:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401061309.92442-9-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
> Instead of disabling only first watchpoint, disable all available
> watchpoints while clearing dawr_force_enable.

Can you also explain why you change the function name ?

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/dawr.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
> index 311e51ee09f4..5c882f07ac7d 100644
> --- a/arch/powerpc/kernel/dawr.c
> +++ b/arch/powerpc/kernel/dawr.c
> @@ -50,9 +50,13 @@ int set_dawr(struct arch_hw_breakpoint *brk, int nr)
>   	return 0;
>   }
>   
> -static void set_dawr_cb(void *info)
> +static void disable_dawrs(void *info)

Wouldn't it be better to keep _cb at the end of the function ?

>   {
> -	set_dawr(info, 0);
> +	struct arch_hw_breakpoint null_brk = {0};
> +	int i;
> +
> +	for (i = 0; i < nr_wp_slots(); i++)
> +		set_dawr(&null_brk, i);
>   }
>   
>   static ssize_t dawr_write_file_bool(struct file *file,
> @@ -74,7 +78,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
>   
>   	/* If we are clearing, make sure all CPUs have the DAWR cleared */
>   	if (!dawr_force_enable)
> -		smp_call_function(set_dawr_cb, &null_brk, 0);
> +		smp_call_function(disable_dawrs, NULL, 0);
>   
>   	return rc;
>   }
> 

Christophe
