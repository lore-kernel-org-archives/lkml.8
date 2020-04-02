Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2961206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpGHxnGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbgDBI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:29:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728612AbgDBI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585816165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0iHlOllBygHsYMbqMA3iOkY4BobEis4zE9y42TCiqU=;
        b=JpGHxnGZcLWiKQZ309AWTzyfMXUeJbngx3wtH/Ljn3KpQhgAdy30cKyCtrdL4jTXOQiZLO
        jT5se40qdCFV5Z2sH4dokO6DdfNEKgKJMePcgFx4ieX4QO/bAR1zJH8QNS7h6714+2Xanc
        lmMN+UnoPXY92O9i+DzSIMhgZYrY5Bk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-qern79ZNNCm5vZMeIEWezA-1; Thu, 02 Apr 2020 04:29:23 -0400
X-MC-Unique: qern79ZNNCm5vZMeIEWezA-1
Received: by mail-wr1-f69.google.com with SMTP id o18so1126235wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0iHlOllBygHsYMbqMA3iOkY4BobEis4zE9y42TCiqU=;
        b=ugwtqPYvJ6k903BFxaoeK6LKdtH06jNCch9ix545+MTGLnVDo+NJKwzBs5SJFBjGEO
         dXnNVM9GB32YKbSBfZanqDThnozzintyn1xVlKCM8pcz1OO9nGVcse/dzvvDhfnC5CzC
         lxHtCB4CZhcTkdp3Nx3Nu0GquX7eQjdfTc2ldXuK8S99IeN7xgzarszwU/EXjGa9TUk4
         x9koLde/c12yV329MSuAUDAL2mFCSJlYqaNRmseHT4uA81DeY01C2YNzeHVheZpwJdiB
         VlO13QJvTLVmgi8K/oOFFnh0XsJqEVmYclgGQDPtMjXJ6Zg9kIGgF+I3oi70KNtJbGC9
         ekcA==
X-Gm-Message-State: AGi0PubHVInUdxvi7a8q6kLxS0k71iHSDwjwBVyD4iaN6manubXbV0VA
        SOZcioqPdKMu5ky6dBWQbvOpgHOyh/Y9I5YMk+da5dO9hnVMe2JfKHu9LYuSgiLaLiwOBRDXuB3
        hAf2oUs29V9DdO0QSQlbmVxfO
X-Received: by 2002:adf:e288:: with SMTP id v8mr979124wri.141.1585816162450;
        Thu, 02 Apr 2020 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLNje4DWkmfS7voZ4tZ2XbU02U6aNSxQoDZ9gJ/Armb6+aCmBBzQt41vI0lz6DucEsaWUrWHQ==
X-Received: by 2002:adf:e288:: with SMTP id v8mr979100wri.141.1585816162199;
        Thu, 02 Apr 2020 01:29:22 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f20sm5889187wmc.35.2020.04.02.01.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 01:29:21 -0700 (PDT)
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
References: <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
 <20200402075036.GA20730@hirez.programming.kicks-ass.net>
 <20200402081710.GJ20760@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <0a750745-b069-9ef2-61d3-a15b8fecb649@redhat.com>
Date:   Thu, 2 Apr 2020 09:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402081710.GJ20760@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 9:17 AM, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 09:50:36AM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 02, 2020 at 07:41:46AM +0100, Julien Thierry wrote:
> 
>>> Also, instead of adding a special "arch_exception_frame_size", I could
>>> suggest:
>>> - Picking this patch [1] from a completely arbitrary source
>>> - Getting rid of INSN_STACK type, any instruction could then include stack
>>> ops on top of their existing semantics, they can just have an empty list if
>>> they don't touch SP/BP
>>> - x86 decoder adds a stack_op to the iret to modify the stack pointer by the
>>> right amount
>>
>> That's not the worst idea, lemme try that.
> 
> Something like so then?
> 

Yes, you could even remove INSN_STACK from insn_type and just always 
call handle_insn_ops() before the switch statement on insn->type. If the 
list is empty it does nothing.
This way you wouldn't need to call it for the INSN_EXCEPTION_RETURN 
case, and any type of instructions could use stack_ops.


And the other suggestion is my other email was that you don't even need 
to add INSN_EXCEPTION_RETURN. You can keep IRET as INSN_CONTEXT_SWITCH 
by default and x86 decoder lookups the symbol conaining an iret. If it's 
a function symbol, it can just set the type to INSN_OTHER so that it 
caries on to the next instruction after having handled the stack_op.

And everything fits under tools/objtool/arch/x86 :) .

Or is it too far-fetch'd?


> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -738,7 +738,6 @@ static inline void sync_core(void)
>   	unsigned int tmp;
>   
>   	asm volatile (
> -		UNWIND_HINT_SAVE
>   		"mov %%ss, %0\n\t"
>   		"pushq %q0\n\t"
>   		"pushq %%rsp\n\t"
> @@ -748,7 +747,6 @@ static inline void sync_core(void)
>   		"pushq %q0\n\t"
>   		"pushq $1f\n\t"
>   		"iretq\n\t"
> -		UNWIND_HINT_RESTORE
>   		"1:"
>   		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
>   #endif
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -19,6 +19,7 @@ enum insn_type {
>   	INSN_CALL,
>   	INSN_CALL_DYNAMIC,
>   	INSN_RETURN,
> +	INSN_EXCEPTION_RETURN,
>   	INSN_CONTEXT_SWITCH,
>   	INSN_STACK,
>   	INSN_BUG,
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -435,9 +435,19 @@ int arch_decode_instruction(struct elf *
>   		*type = INSN_RETURN;
>   		break;
>   
> +	case 0xcf: /* iret */
> +		*type = INSN_EXCEPTION_RETURN;
> +
> +		/* add $40, %rsp */
> +		op->src.type = OP_SRC_ADD;
> +		op->src.reg = CFI_SP;
> +		op->src.offset = 5*8;
> +		op->dest.type = OP_DEST_REG;
> +		op->dest.reg = CFI_SP;
> +		break;
> +
>   	case 0xca: /* retf */
>   	case 0xcb: /* retf */
> -	case 0xcf: /* iret */
>   		*type = INSN_CONTEXT_SWITCH;
>   		break;
>   
> @@ -483,7 +493,7 @@ int arch_decode_instruction(struct elf *
>   
>   	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
>   
> -	if (*type == INSN_STACK)
> +	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
>   		list_add_tail(&op->list, ops_list);
>   	else
>   		free(op);
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2224,6 +2224,20 @@ static int validate_branch(struct objtoo
>   
>   			break;
>   
> +		case INSN_EXCEPTION_RETURN:
> +			if (handle_insn_ops(insn, &state))
> +				return 1;
> +
> +			/*
> +			 * This handles x86's sync_core() case, where we use an
> +			 * IRET to self. All 'normal' IRET instructions are in
> +			 * STT_NOTYPE entry symbols.
> +			 */
> +			if (func)
> +				break;
> +
> +			return 0;
> +
>   		case INSN_CONTEXT_SWITCH:
>   			if (func && (!next_insn || !next_insn->hint)) {
>   				WARN_FUNC("unsupported instruction in callable function",
> 

Cheers,

-- 
Julien Thierry

