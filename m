Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1962078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M2cJ07AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgDAGcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:32:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31373 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbgDAGcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:32:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sbvn111rz9txbS;
        Wed,  1 Apr 2020 08:32:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=M2cJ07AQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id N82vlwFNG6uA; Wed,  1 Apr 2020 08:32:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sbvm6lDrz9txbR;
        Wed,  1 Apr 2020 08:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585722724; bh=fz42DDV9ApxpNWS9T44dvSssW81bIergY+V0OGliRCc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M2cJ07AQx+wEWbJgoO7fxKln758xBxks6FjTnnm5oYwoVzyuOkCV216Qwwh5oxJIK
         9oTk8dh//opPicmXTptz+XB74i+IwhiG7ij7iZo9c5nnu3Na44QIvaxca3P08EB5RA
         2+eZoW8s3LmzBjQlO4IA5//hYNUTkrWB6KqB4rV0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC48E8B7B3;
        Wed,  1 Apr 2020 08:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G8hXNfMZR6VY; Wed,  1 Apr 2020 08:32:05 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57F1E8B778;
        Wed,  1 Apr 2020 08:32:03 +0200 (CEST)
Subject: Re: [PATCH v2 07/16] powerpc/watchpoint: Get watchpoint count
 dynamically while disabling them
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-8-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3c2312bb-9689-830e-3bc8-c828eddf369c@c-s.fr>
Date:   Wed, 1 Apr 2020 08:32:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401061309.92442-8-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
> Instead of disabling only one watchpoint, get num of available
> watchpoints dynamically and disable all of them.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index 4e4976c3248b..fae33c729ba9 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -78,14 +78,13 @@ extern void ptrace_triggered(struct perf_event *bp,
>   			struct perf_sample_data *data, struct pt_regs *regs);
>   static inline void hw_breakpoint_disable(void)
>   {
> -	struct arch_hw_breakpoint brk;
> -
> -	brk.address = 0;
> -	brk.type = 0;
> -	brk.len = 0;
> -	brk.hw_len = 0;
> -	if (ppc_breakpoint_available())
> -		__set_breakpoint(&brk, 0);
> +	int i;
> +	struct arch_hw_breakpoint null_brk = {0};

Those declaration should be in the block unsigned them below.

> +
> +	if (ppc_breakpoint_available()) {
> +		for (i = 0; i < nr_wp_slots(); i++)
> +			__set_breakpoint(&null_brk, i);
> +	}

I would have had a preference to the following, but that's detail I guess:

	int i;
	struct arch_hw_breakpoint null_brk = {0};

	if (!ppc_breakpoint_available())
		return;

	for (i = 0; i < nr_wp_slots(); i++)
		__set_breakpoint(&null_brk, i);

>   }
>   extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
>   int hw_breakpoint_handler(struct die_args *args);
> 

Christophe
