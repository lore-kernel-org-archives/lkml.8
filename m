Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C205BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEEF20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="j67gzIKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgCQKtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:49:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54571 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQKtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:49:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hVKY5c7Mz9tyNJ;
        Tue, 17 Mar 2020 11:49:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=j67gzIKY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KdhfvOzmaLlu; Tue, 17 Mar 2020 11:49:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hVKY4NJhz9tyN5;
        Tue, 17 Mar 2020 11:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584442161; bh=nfLjp3MIAmsdfZWziaVp6Ka0lgWqIySyeyR3GRcKGoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j67gzIKYj7CE+P+UJF3m9dLRXT66wVmUfEtuzRmmtAz0fzB+ux6Hw/+MZCrb7C6G0
         VCZ2GMdLmnBReYLq3YzKjCW2Xy9Ocxow9rk2GKGejme/wmSgkLEqnisQ8ncvZG9BPa
         +r2n2RxsAo1SS6XekVLZiynDHu6KIzqAyWFJEs7s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C4848B786;
        Tue, 17 Mar 2020 11:49:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 36f5t3XzvCeZ; Tue, 17 Mar 2020 11:49:21 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 345AF8B785;
        Tue, 17 Mar 2020 11:49:18 +0100 (CET)
Subject: Re: [PATCH 11/15] powerpc/watchpoint: Introduce is_ptrace_bp()
 function
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-12-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <69fcb33b-0e77-cadd-a8ea-888d0f6b25a2@c-s.fr>
Date:   Tue, 17 Mar 2020 11:49:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-12-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
> Introduce is_ptrace_bp() function and move the check inside the
> function. We will utilize it more in later set of patches.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index b27aca623267..0e35ff372d8e 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -90,6 +90,11 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
>   	hw_breakpoint_disable();
>   }
>   
> +static bool is_ptrace_bp(struct perf_event *bp)
> +{
> +	return (bp->overflow_handler == ptrace_triggered);

You don't need parenthesis here.

> +}
> +
>   /*
>    * Perform cleanup of arch-specific counters during unregistration
>    * of the perf-event
> @@ -324,7 +329,7 @@ int hw_breakpoint_handler(struct die_args *args)
>   	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
>   	 * generated in do_dabr().
>   	 */
> -	if (bp->overflow_handler == ptrace_triggered) {
> +	if (is_ptrace_bp(bp)) {
>   		perf_bp_event(bp, regs);
>   		rc = NOTIFY_DONE;
>   		goto out;
> 

Christophe
