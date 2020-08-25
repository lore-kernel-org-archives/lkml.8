Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB591C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E420706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgHYJaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:30:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8883 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgHYJaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:30:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbNy20M3jz9txvL;
        Tue, 25 Aug 2020 11:30:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DLp4VNLfgl2e; Tue, 25 Aug 2020 11:30:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbNy16dWVz9txvH;
        Tue, 25 Aug 2020 11:30:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F0C178B806;
        Tue, 25 Aug 2020 11:30:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id emBSym7Dg09c; Tue, 25 Aug 2020 11:30:18 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDDB68B803;
        Tue, 25 Aug 2020 11:30:17 +0200 (CEST)
Subject: Re: [PATCH v5 4/8] powerpc/watchpoint: Move DAWR detection logic
 outside of hw_breakpoint.c
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
 <20200825043617.1073634-5-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0a73280b-c231-a7bb-18d9-abf2a37ba24b@csgroup.eu>
Date:   Tue, 25 Aug 2020 11:30:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825043617.1073634-5-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/08/2020 à 06:36, Ravi Bangoria a écrit :
> Power10 hw has multiple DAWRs but hw doesn't tell which DAWR caused
> the exception. So we have a sw logic to detect that in hw_breakpoint.c.
> But hw_breakpoint.c gets compiled only with CONFIG_HAVE_HW_BREAKPOINT=Y.
> Move DAWR detection logic outside of hw_breakpoint.c so that it can be
> reused when CONFIG_HAVE_HW_BREAKPOINT is not set.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h      |   8 +
>   arch/powerpc/kernel/Makefile                  |   3 +-
>   arch/powerpc/kernel/hw_breakpoint.c           | 159 +----------------
>   .../kernel/hw_breakpoint_constraints.c        | 162 ++++++++++++++++++
>   4 files changed, 174 insertions(+), 158 deletions(-)
>   create mode 100644 arch/powerpc/kernel/hw_breakpoint_constraints.c
> 

[...]

> diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
> new file mode 100644
> index 000000000000..867ee4aa026a
> --- /dev/null
> +++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
> @@ -0,0 +1,162 @@

[...]

> +
> +static int cache_op_size(void)
> +{
> +#ifdef __powerpc64__
> +	return ppc64_caches.l1d.block_size;
> +#else
> +	return L1_CACHE_BYTES;
> +#endif
> +}

You've got l1_dcache_bytes() in arch/powerpc/include/asm/cache.h to do that.

> +
> +void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
> +			 int *type, int *size, unsigned long *ea)
> +{
> +	struct instruction_op op;
> +
> +	if (__get_user_instr_inatomic(*instr, (void __user *)regs->nip))
> +		return;
> +
> +	analyse_instr(&op, regs, *instr);
> +	*type = GETTYPE(op.type);
> +	*ea = op.ea;
> +#ifdef __powerpc64__
> +	if (!(regs->msr & MSR_64BIT))
> +		*ea &= 0xffffffffUL;
> +#endif

This #ifdef is unneeded, it should build fine on a 32 bits too.

> +
> +	*size = GETSIZE(op.type);
> +	if (*type == CACHEOP) {
> +		*size = cache_op_size();
> +		*ea &= ~(*size - 1);
> +	} else if (*type == LOAD_VMX || *type == STORE_VMX) {
> +		*ea &= ~(*size - 1);
> +	}
> +}
> 

Christophe
