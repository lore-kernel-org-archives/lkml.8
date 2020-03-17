Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B520663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mkaK6jid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgCQKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:35:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55577 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgCQKf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:35:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hV1T3fyXz9tyNJ;
        Tue, 17 Mar 2020 11:35:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mkaK6jid; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0CaV5ugBkrom; Tue, 17 Mar 2020 11:35:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hV1T2YLTz9tyN5;
        Tue, 17 Mar 2020 11:35:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584441325; bh=A+PMivXF8uTOY5GbFU434SmPOEkpNOTireCO2xVWYl0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mkaK6jidkr43As4esiENyHFYX84ztCbm8h4X0bLyvndSpFGjyOqOyTihyQk5cxx16
         Psg76xPSO6QvcZA/j78sx4oZPGGnnKZRu8EvzM17zvgCRBIhVTNs9DRZi37lVR4XH8
         JeMdo4namM1z0N8G3A23mnKwcqC+CD5cu6qxPIe0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C6DB8B785;
        Tue, 17 Mar 2020 11:35:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FkbONcCnIi0G; Tue, 17 Mar 2020 11:35:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B67B8B787;
        Tue, 17 Mar 2020 11:35:24 +0100 (CET)
Subject: Re: [PATCH 08/15] powerpc/watchpoint: Disable all available
 watchpoints when !dawr_force_enable
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-9-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1381b9f9-4999-0e03-8344-af84a88fa074@c-s.fr>
Date:   Tue, 17 Mar 2020 11:35:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-9-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
> Instead of disabling only first watchpoint, disable all available
> watchpoints while clearing dawr_force_enable.
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

Can you explain a bit more what you do exactly ? Why do you change the 
name of the function and why the parameter becomes NULL ? And why it 
doens't take into account the parameter anymore ?

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
