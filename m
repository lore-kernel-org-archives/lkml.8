Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6881FC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7E206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rH4W7axa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBVL0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:26:38 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33579 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgBVL0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:26:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48PmHZ5d62z9v6f3;
        Sat, 22 Feb 2020 12:26:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rH4W7axa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eb4TsJikDmNu; Sat, 22 Feb 2020 12:26:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48PmHZ4MFYz9v6f2;
        Sat, 22 Feb 2020 12:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582370794; bh=4iT5oLUTroPjIccYuns5zqLIPkL8k2A2IrBunY3qOp8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rH4W7axalzOcHBRnuymJNHQcPX24IdgR45ag0MClwMYM1QnYKLxX8JXans4uwc62Y
         pOk6CCVCQZK9hqUjvIH3VmP+1zRV2aQNkfas5G1nL2c8JU4VXDwLlfTlm49E16O+Aj
         psqVKvLwdf6RJfD0wBIJTSoApFY3r9u5nRz4KWYQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE4FE8B762;
        Sat, 22 Feb 2020 12:26:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UQprTtsWVdWK; Sat, 22 Feb 2020 12:26:35 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 575228B755;
        Sat, 22 Feb 2020 12:26:35 +0100 (CET)
Subject: Re: [PATCH] powerpc/watchpoint: Don't call dar_within_range() for
 Book3S
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d2aad6ea-5b61-7321-13a6-5faef361c57d@c-s.fr>
Date:   Sat, 22 Feb 2020 11:26:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2020 08:20 AM, Ravi Bangoria wrote:
> DAR is set to the first byte of overlap between actual access and
> watched range at DSI on Book3S processor. But actual access range
> might or might not be within user asked range. So for Book3S, it
> must not call dar_within_range().
> 
> This revert portion of commit 39413ae00967 ("powerpc/hw_breakpoints:
> Rewrite 8xx breakpoints to allow any address range size.").
> 
> Before patch:
>    # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
>    ...
>    TESTED: No overlap
>    FAILED: Partial overlap: 0 != 2
>    TESTED: Partial overlap
>    TESTED: No overlap
>    FAILED: Full overlap: 0 != 2
>    failure: perf_hwbreak
> 
> After patch:
>    TESTED: No overlap
>    TESTED: Partial overlap
>    TESTED: Partial overlap
>    TESTED: No overlap
>    TESTED: Full overlap
>    success: perf_hwbreak
> 
> Fixes: 39413ae00967 ("powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.")

Oh, this seems to have been introduced by 27985b2a640e 
("powerpc/watchpoint: Don't ignore extraneous exceptions blindly").

I must have lost it through a rebase as we were doing our series 
approximately at the same time, sorry for that.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 2462cd7c565c..d0854320bb50 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -331,11 +331,13 @@ int hw_breakpoint_handler(struct die_args *args)
>   	}
>   
>   	info->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
> -	if (!dar_within_range(regs->dar, info))
> -		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
> -
> -	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info))
> -		goto out;
> +	if (IS_ENABLED(CONFIG_PPC_8xx)) {
> +		if (!dar_within_range(regs->dar, info))
> +			info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
> +	} else {
> +		if (!stepping_handler(regs, bp, info))
> +			goto out;
> +	}
>   
>   	/*
>   	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> 
