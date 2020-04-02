Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2B206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejcf9Fl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbgDBN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:27:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387752AbgDBN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5YufENQqi2Bpt6zl9jG3AJ+7jLikzsdpJuwtUMqHU4=;
        b=ejcf9Fl6h6yNfkPCOG9JaTfOe+m7nsEGMGzKGatnCAVmPow40DQ/8F874b6imfQy6pylXB
        D8vxekqggWVGio2FLLZ19g3uLEIWaLLs5uEW1ilfFII4qNcivj5NVBwDDuLpUsgmJ1Caqv
        gXBPqvgEyYrIm3UtPX9kNtQYS5WUS/w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-PtRUzGQePt6lkLt943Y2tg-1; Thu, 02 Apr 2020 09:27:00 -0400
X-MC-Unique: PtRUzGQePt6lkLt943Y2tg-1
Received: by mail-wr1-f70.google.com with SMTP id d1so1469846wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5YufENQqi2Bpt6zl9jG3AJ+7jLikzsdpJuwtUMqHU4=;
        b=l266+yMYr39XlNzOfnWIQR4y269jGVDe4AHFxU0ZWnTU9FhuuN9MVNR9QGNMO3/Hf5
         7c+YRyF4kWgjYiAlY5JAVaHfDLfekzuvKzuI+DZS5g5MY6Zowlt3e6MIJrzNnyMpsQQO
         SH6EoAxqVCNLQ3S+7h7B6cNF0S9kPtblZC46OHjIoKGX8dJuFGqpfxTAh78dvLyxYXc/
         Ip3Sh1OqbPhF/LvYiB8offE1FmLW3ZvGabBRJC360ECcw72WjplQgth443C/08Q1lK20
         VSFD/7FNqD62UrvKBsuh7GMNyqAr6SRNIZp+X8Y0nRNwN6ajiir2yXHj9XQGUx92j+Q8
         CxAg==
X-Gm-Message-State: AGi0PuYAyq46Rakyq3imFXFyjXy0nUQ8w2aQqd+CEBpmI0knPKzhWNw8
        S2n4Is2VoGz11Fzt7J7JfKkKNIV7Dut+DvuF5Ey+qnG/qsntuKWBt/N/X42ujXQ8yUv78V6qQAW
        C0H+Esq+OCLXNw2d8q2YYprJD
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr3810004wrx.210.1585834019156;
        Thu, 02 Apr 2020 06:26:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVLsl9eDCugQ6ZdFQIJcEExFwSr+mKQ1eiNAZpKrKVQh1lAUmRJdObkjxrym4AfsIzoGdCGQ==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr3809984wrx.210.1585834018917;
        Thu, 02 Apr 2020 06:26:58 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id t67sm7307002wmt.48.2020.04.02.06.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:26:58 -0700 (PDT)
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
Date:   Thu, 2 Apr 2020 14:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402082220.808-5-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 4/2/20 9:22 AM, Alexandre Chartre wrote:
> With retpoline, the return instruction is used to branch to an address
> stored on the stack. So, unlike a regular return instruction, when a
> retpoline return instruction is reached the stack has been modified
> compared to what we have when the function was entered.
> 
> Provide the mechanism to explicitly call-out such return instruction
> so that objtool can correctly handle them.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   tools/objtool/check.c | 78 +++++++++++++++++++++++++++++++++++++++++--
>   tools/objtool/check.h |  1 +
>   2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0cec91291d46..ed8e3ea1d8da 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1344,6 +1344,48 @@ static int read_intra_function_call(struct objtool_file *file)
>   	return 0;
>   }
>   
> +static int read_retpoline_ret(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct rela *rela;
> +
> +	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_ret");
> +	if (!sec)
> +		return 0;
> +
> +	list_for_each_entry(rela, &sec->rela_list, list) {
> +		if (rela->sym->type != STT_SECTION) {
> +			WARN("unexpected relocation symbol type in %s",
> +			     sec->name);
> +			return -1;
> +		}
> +
> +		insn = find_insn(file, rela->sym->sec, rela->addend);
> +		if (!insn) {
> +			WARN("bad .discard.retpoline_ret entry");
> +			return -1;
> +		}
> +
> +		if (insn->type != INSN_RETURN) {
> +			WARN_FUNC("retpoline_ret not a return",
> +				  insn->sec, insn->offset);
> +			return -1;
> +		}
> +
> +		insn->retpoline_ret = true;
> +		/*
> +		 * For the impact on the stack, make a return trampoline
> +		 * behaves like a pop of the return address.
> +		 */
> +		insn->stack_op.src.type = OP_SRC_POP;
> +		insn->stack_op.dest.type = OP_DEST_REG;
> +		insn->stack_op.dest.reg = CFI_RA;
> +	}
> +
> +	return 0;
> +}
> +
>   static void mark_rodata(struct objtool_file *file)
>   {
>   	struct section *sec;
> @@ -1403,6 +1445,10 @@ static int decode_sections(struct objtool_file *file)
>   	if (ret)
>   		return ret;
>   
> +	ret = read_retpoline_ret(file);
> +	if (ret)
> +		return ret;
> +
>   	ret = add_call_destinations(file);
>   	if (ret)
>   		return ret;
> @@ -1432,7 +1478,8 @@ static bool is_fentry_call(struct instruction *insn)
>   	return false;
>   }
>   
> -static bool has_modified_stack_frame(struct insn_state *state)
> +static bool has_modified_stack_frame(struct insn_state *state,
> +				     bool check_registers)
>   {
>   	int i;
>   
> @@ -1442,6 +1489,9 @@ static bool has_modified_stack_frame(struct insn_state *state)
>   	    state->drap)
>   		return true;
>   
> +	if (!check_registers)
> +		return false;
> +
>   	for (i = 0; i < CFI_NUM_REGS; i++)
>   		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>   		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
> @@ -1987,7 +2037,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
>   
>   static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
>   {
> -	if (has_modified_stack_frame(state)) {
> +	if (has_modified_stack_frame(state, true)) {
>   		WARN_FUNC("sibling call from callable instruction with modified stack frame",
>   				insn->sec, insn->offset);
>   		return 1;
> @@ -2009,6 +2059,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   	struct alternative *alt;
>   	struct instruction *insn, *next_insn;
>   	struct section *sec;
> +	bool check_registers;
>   	u8 visited;
>   	int ret;
>   
> @@ -2130,7 +2181,28 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   				return 1;
>   			}
>   
> -			if (func && has_modified_stack_frame(&state)) {
> +			/*
> +			 * With retpoline, the return instruction is used
> +			 * to branch to an address stored on the stack.
> +			 * So when we reach the ret instruction, the stack
> +			 * frame has been modified with the address to
> +			 * branch to and we need update the stack state.
> +			 *
> +			 * The retpoline address to branch to is typically
> +			 * pushed on the stack from a register, but this
> +			 * confuses the logic which checks callee saved
> +			 * registers. So we don't check if registers have
> +			 * been modified if we have a return trampoline.

I think there are two different things to consider here.

First, the update of the stack frame which I believe should be done when 
returning from intra_function_calls, as it undoes what the call 
instruction did (push more stuff on the stack in the case of x86).

This might mean that intra_function_call should be part of the state (as 
intra_function_calls pass a modified state to validate_branch() ).

Second is supporting retpoline_ret which is just accepting that the 
return address in the stack frame has changed.

> +			 */
> +			if (insn->retpoline_ret) {
> +				update_insn_state(insn, &state);
> +				check_registers = false;
> +			} else {
> +				check_registers = true;
> +			}
> +
> +			if (func && has_modified_stack_frame(&state,
> +							     check_registers)) {
>   				WARN_FUNC("return with modified stack frame",
>   					  sec, insn->offset);
>   				return 1;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 2bd6d2f46baa..5ecd16ad71a8 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -37,6 +37,7 @@ struct instruction {
>   	bool dead_end, ignore, hint, save, restore, ignore_alts;
>   	bool intra_function_call;
>   	bool retpoline_safe;
> +	bool retpoline_ret;
>   	u8 visited;
>   	struct symbol *call_dest;
>   	struct instruction *jump_dest;
> 

Cheers,

-- 
Julien Thierry

