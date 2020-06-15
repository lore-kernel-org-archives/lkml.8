Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D335C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ADB2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=notmuch.email header.i=@notmuch.email header.b="R8p8tQbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFOM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:59:47 -0400
Received: from mx.h4ck.space ([159.69.146.50]:51238 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgFOM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:59:46 -0400
Date:   Mon, 15 Jun 2020 14:59:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1592225982;
        bh=xEaHOZrOGFdQ2ZrwzvdfXydcdbqmR2TMLyGFVx8L8Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=R8p8tQbJcszCLNq0puYi9G3zOC1OTfFpmli4OCFJxHtmYkHIyy1VoyYW9i8fZT7oB
         GuyGEBGJ1lHJVDTzSHjBnP/vOu3/w9QX3Ddy4INc43vtpkHiKbLyJLbd3QCbcViqs6
         nr6kMJE2Ii23XuYntAEzjkkZ4adGqMwytc6hnejE=
From:   andi@notmuch.email
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        ebiederm@xmission.com, Babu.Moger@amd.com
Subject: Re: [PATCH v4] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200615125930.qydseozyrzjjz42e@wrt>
References: <20200609175423.31568-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609175423.31568-1-bshanks@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:54 09.06.20, Brendan Shanks wrote:
> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> processes.
> 
> Wine users have found a small number of Windows apps using SLDT that
> were crashing when run on UMIP-enabled systems.
> 
> Reported-by: Andreas Rammhold <andi@notmuch.email>
> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> ---
> 
> v4: Use braces for every clause of the conditional. I tried a switch(),
> but it takes more lines and looks more cluttered (especially with the
> #ifdef).
> Also replace out-of-date comment at top of file.
> 
>  arch/x86/kernel/umip.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 8d5cbe1bbb3b..62f4f0afb979 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -45,11 +45,12 @@
>   * value that, lies close to the top of the kernel memory. The limit for the GDT
>   * and the IDT are set to zero.
>   *
> - * Given that SLDT and STR are not commonly used in programs that run on WineHQ
> - * or DOSEMU2, they are not emulated.
> - *
>   * The instruction smsw is emulated to return the value that the register CR0
>   * has at boot time as set in the head_32.
> + * sldt and str are emulated to return the values that the kernel programmatically
> + * assigns:
> + * - sldt returns (GDT_ENTRY_LDT * 8) if an LDT has been set, 0 if not.
> + * - str returns (GDT_ENTRY_TSS * 8).
>   *
>   * Emulation is provided for both 32-bit and 64-bit processes.
>   *
> @@ -244,16 +245,34 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
>  		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
>  		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
>  
> -	} else if (umip_inst == UMIP_INST_SMSW) {
> -		unsigned long dummy_value = CR0_STATE;
> +	} else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
> +		   umip_inst == UMIP_INST_STR) {
> +		unsigned long dummy_value;
> +
> +		if (umip_inst == UMIP_INST_SMSW) {
> +			dummy_value = CR0_STATE;
> +		} else if (umip_inst == UMIP_INST_STR) {
> +			dummy_value = GDT_ENTRY_TSS * 8;
> +		} else if (umip_inst == UMIP_INST_SLDT) {
> +#ifdef CONFIG_MODIFY_LDT_SYSCALL
> +			down_read(&current->mm->context.ldt_usr_sem);
> +			if (current->mm->context.ldt)
> +				dummy_value = GDT_ENTRY_LDT * 8;
> +			else
> +				dummy_value = 0;
> +			up_read(&current->mm->context.ldt_usr_sem);
> +#else
> +			dummy_value = 0;
> +#endif
> +		}
>  
>  		/*
> -		 * Even though the CR0 register has 4 bytes, the number
> +		 * For these 3 instructions, the number
>  		 * of bytes to be copied in the result buffer is determined
>  		 * by whether the operand is a register or a memory location.
>  		 * If operand is a register, return as many bytes as the operand
>  		 * size. If operand is memory, return only the two least
> -		 * siginificant bytes of CR0.
> +		 * siginificant bytes.
>  		 */
>  		if (X86_MODRM_MOD(insn->modrm.value) == 3)
>  			*data_size = insn->opnd_bytes;
> @@ -261,7 +280,6 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
>  			*data_size = 2;
>  
>  		memcpy(data, &dummy_value, *data_size);
> -	/* STR and SLDT  are not emulated */
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -383,10 +401,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
>  			umip_insns[umip_inst]);
>  
> -	/* Do not emulate (spoof) SLDT or STR. */
> -	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
> -		return false;
> -
>  	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
>  
>  	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
> -- 
> 2.26.2
> 

A bit late but I was able to test my workload with the above patch
applied on 5.7.2.

Tested-by: Andreas Rammhold <andi@notmuch.email>
