Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92B20578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUv6cigW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgDNNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:45:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgDNNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586871902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAjHZAEZYG2NzzIedG41qKCwl04MlOTWCmwhUGP0Hp4=;
        b=UUv6cigW6wiMIAXqE+4BxRmNsIbL27duuDwI1IR+dz+6E+Zy2q4+yWU08jYTsssEqSOO/4
        6R5u2HdTK47USEtzZY30uZxdkWCDcVik2o1oeGKNTqaUS4wO8DDYaTAW2D7ISqdp+uqnxq
        X4B9xF9yib1KFBN8qZV8CqFq0wQETuA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-v3zhZHm1OcKrdFys0PRPMA-1; Tue, 14 Apr 2020 09:45:01 -0400
X-MC-Unique: v3zhZHm1OcKrdFys0PRPMA-1
Received: by mail-wm1-f71.google.com with SMTP id 72so6473979wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LAjHZAEZYG2NzzIedG41qKCwl04MlOTWCmwhUGP0Hp4=;
        b=bp7m49coGL2TkwSMTpQNadA6FM074sisEFw2w1HfZpDIr0V/PkZP60Rt1bGs6pOREo
         VzqM4dzWu3iJZ+jOrTd3A1O0aRA7Gx7TIAuWMe23lEpeuPok4cdXeEUiYdB23m2jnNjT
         xlT9f4zg96r8TbGeWVHVwtofIyfDpBdDbMpq/w2LITES7YdaCYCVGDn/henoNgaHkzwM
         EGJ/mvSoemw5h0wvzcWXguEV4yKwXfo0qGJNlYLFvbrDHG4i4XkvRnQnlg3nUEpkhphc
         cuu4qz/XWbmipSHRZKuTSiKvrWfJZ62SpWuph4oJodu1K6EfnzSRd770PutCRLi7jp1q
         yzWA==
X-Gm-Message-State: AGi0PuZtOTZEqO6dtnIpU+9miUDnRvn1jbwq+ZP52ezpKs7GM6wqD7aB
        k+XAIeAhs21wxOVDivTyHVRxuWPd6jYe9Rxj7vzM9/z1WO80/XECrP1wZw1tcvqS0tEDJz6jTom
        vO/sBDmlSFTow9lxadXdDhjom
X-Received: by 2002:adf:eccb:: with SMTP id s11mr14836893wro.138.1586871899707;
        Tue, 14 Apr 2020 06:44:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypINXWKFS4v4QYvNh9/dnnZ8+o2f7YrEJ47iU560dzbCv1SvW8IgwcXIhK8PFbUt3AK0i16roA==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr14836873wro.138.1586871899410;
        Tue, 14 Apr 2020 06:44:59 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id z10sm17152395wrg.69.2020.04.14.06.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 06:44:58 -0700 (PDT)
Subject: Re: [PATCH V3 4/9] objtool: Handle return instruction with
 intra-function call
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-5-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <050ba999-5d16-170f-8a70-44d3856eb1ea@redhat.com>
Date:   Tue, 14 Apr 2020 14:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414103618.12657-5-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 4/14/20 11:36 AM, Alexandre Chartre wrote:
> Intra-function calls are implemented in objtool like unconditional
> jumps. Keep track of intra-functin calls return addresses so that

intra-function*

> objtool can make a return instruction continues the flow at the
> right location.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   tools/objtool/arch/x86/decode.c |   7 +++
>   tools/objtool/check.c           | 104 ++++++++++++++++++++++++++++++--
>   tools/objtool/check.h           |   3 +
>   3 files changed, 110 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index f4d70b8835c4..76b593bb2e4f 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -427,6 +427,13 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>   	case 0xc2:
>   	case 0xc3:
>   		*type = INSN_RETURN;
> +		/*
> +		 * For the impact on the stack, a ret behaves like
> +		 * a pop of the return address.
> +		 */
> +		op->src.type = OP_SRC_POP;
> +		op->dest.type = OP_DEST_REG;
> +		op->dest.reg = CFI_RA;
>   		break;
>   
>   	case 0xca: /* retf */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index ad362c5de281..8b1df659cd68 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -26,9 +26,50 @@ struct alternative {
>   	bool skip_orig;
>   };
>   
> +/*
> + * List to keep track of intra-function call return addresses.
> + * The list is a simple static array because we don't expect
> + * to have a lot of nested intra-function calls.
> + */
> +#define RADDR_COUNT_MAX		32
> +#define RADDR_ALTERED		((void *)-1)
> +
> +static struct instruction *raddr_list[RADDR_COUNT_MAX];
> +static int raddr_count;

Could this be part of the insn_state?

> +
>   const char *objname;
>   struct cfi_state initial_func_cfi;
>   
> +static void raddr_clear(void)
> +{
> +	raddr_count = 0;
> +}
> +
> +static bool raddr_push(struct instruction *insn)
> +{
> +	if (raddr_count == RADDR_COUNT_MAX) {
> +		WARN_FUNC("return address list is full",
> +			  insn->sec, insn->offset);
> +		return false;
> +	}
> +
> +	raddr_list[raddr_count++] = insn;
> +	return true;
> +}
> +
> +static bool raddr_pop(struct instruction **insn)
> +{
> +	if (raddr_count == 0)
> +		return false;
> +
> +	*insn = raddr_list[--raddr_count];
> +	return true;
> +}
> +
> +static int validate_branch(struct objtool_file *file, struct symbol *func,
> +			   struct instruction *from,
> +			   struct instruction *first, struct insn_state state);
> +
>   struct instruction *find_insn(struct objtool_file *file,
>   			      struct section *sec, unsigned long offset)
>   {
> @@ -2039,8 +2080,52 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
>   	return validate_call(insn, state);
>   }
>   
> -static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
> +static int validate_return_address(struct objtool_file *file,
> +				   struct symbol *func,
> +				   struct instruction *insn,
> +				   struct insn_state *state)
>   {
> +	struct instruction *raddr_insn;
> +	int ret;
> +
> +	while (raddr_pop(&raddr_insn)) {

Why is this a loop? Either there is something on the return address 
stack, it gets validated as a branch and the function returns, or 
nothing is on the stack and the function returns.

There doesn't seem to be a point where the loop gets to a second iteration.

> +		/*
> +		 * We are branching somewhere and so processing
> +		 * a return instruction. So update the stack
> +		 * state for this instruction.
> +		 */
> +		update_insn_state(insn, state);
> +
> +		/*
> +		 * If the return address has no instruction then
> +		 * that's the end of the function.
> +		 */
> +		if (!raddr_insn)

I can't think of a valid case where raddr_pop() returns "true" for a 
NULL return address. If you check for that case, it should probably be a 
warning/error rather than silently returning (especially since you'd 
have updated the state).

> +			break;
> +
> +		/*
> +		 * If we are branching to a defined address then
> +		 * just do an unconditional jump there.
> +		 */
> +		ret = validate_branch(file, func, insn,
> +				      raddr_insn, *state);
> +		if (ret) {
> +			if (backtrace)
> +				BT_FUNC("(ret-branch)", insn);
> +			return ret;
> +		}
> +
> +		return 0;
> +	}
> +
> +	return -1;

Returning "-1" is a bit confusing. One might think this is reporting an 
error, but the only caller actually uses it as "I'll just carry on with 
the rest of my checks".

Maybe validate_return() could call validate_return_address() as follows:

	if (radd_pop(&raddr_insn))
		return validate_return_address(file, func, insn, state, raddr_insn);


> +}
> +
> +static int validate_return(struct objtool_file *file, struct symbol *func,
> +			   struct instruction *insn, struct insn_state *state)
> +{
> +	int ret;
> +
>   	if (state->uaccess && !func_uaccess_safe(func)) {
>   		WARN_FUNC("return with UACCESS enabled",
>   			  insn->sec, insn->offset);
> @@ -2059,6 +2144,11 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
>   		return 1;
>   	}
>   
> +	/* check if we have return address to branch to */
> +	ret = validate_return_address(file, func, insn, state);
> +	if (ret >= 0)
> +		return ret;
> +
>   	if (func && has_modified_stack_frame(state)) {
>   		WARN_FUNC("return with modified stack frame",
>   			  insn->sec, insn->offset);
> @@ -2200,7 +2290,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   		switch (insn->type) {
>   
>   		case INSN_RETURN:
> -			return validate_return(func, insn, &state);
> +			return validate_return(file, func, insn, &state);
>   
>   		case INSN_CALL:
>   		case INSN_CALL_DYNAMIC:
> @@ -2223,12 +2313,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   				/*
>   				 * The call instruction can update the stack
>   				 * state. Then make the intra-function call
> -				 * behaves like and unconditional jump.
> +				 * behaves like and unconditional jump. We
> +				 * track the return address to handle any
> +				 * return instruction.
>   				 */
>   				ret = update_insn_state(insn, &state);
>   				if (ret)
>   					return ret;
>   
> +				if (!raddr_push(next_insn))
> +					return 1;
> +
>   				ret = validate_branch(file, func, insn,
>   						      insn->jump_dest, state);
>   				if (ret) {
> @@ -2383,6 +2478,7 @@ static int validate_unwind_hints(struct objtool_file *file)
>   
>   	for_each_insn(file, insn) {
>   		if (insn->hint && !insn->visited) {
> +			raddr_clear();
>   			ret = validate_branch(file, insn->func,
>   					      NULL, insn, state);
>   			if (ret && backtrace)
> @@ -2522,7 +2618,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
>   			continue;
>   
>   		state.uaccess = func->uaccess_safe;
> -
> +		raddr_clear();
>   		ret = validate_branch(file, func, NULL, insn, state);
>   		if (ret && backtrace)
>   			BT_FUNC("<=== (func)", insn);
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 6a80903fc4aa..f7dbecd46bed 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -23,6 +23,7 @@ struct insn_state {
>   	unsigned int uaccess_stack;
>   	int drap_reg, drap_offset;
>   	struct cfi_reg vals[CFI_NUM_REGS];
> +	bool stack_altered;

This isn't used in this patch.

>   };
>   
>   struct instruction {
> @@ -39,6 +40,8 @@ struct instruction {
>   	bool intra_function_call;
>   	bool retpoline_safe;
>   	u8 visited;
> +	u8 raddr_delete;
> +	u8 raddr_alter;

These fields (and the RADDR_ALTERED) don't seem to be used elsewhere in 
this patch. I guess they should be part of patch 5.

>   	struct symbol *call_dest;
>   	struct instruction *jump_dest;
>   	struct instruction *first_jump_src;
> 

Cheers,

-- 
Julien Thierry

