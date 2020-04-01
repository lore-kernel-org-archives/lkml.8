Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E92BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B2F214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqgeBs7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbgDAPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:43:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732705AbgDAPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585755820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xr6rSfDKjU4jA3ujLSUMvsu7+ReZdg+FiDFpha34S8g=;
        b=BqgeBs7s7xajWNpUh7RRYOrH7WVV9l8zX+Ft6aO6lbHWfNQWx8HqzEug5atwJ8/kBqq16L
        B57q+lf2ncx9usnrnwBDv/uaVY0vKEL3FrdTkBs8jTQRmpv58GcZ2RHCpCKq5aSj+0/idy
        YV+ySsMYynck9kgfotRH3rhKTtd1PmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-gbymVUbwNYCy0PIlN3UdYA-1; Wed, 01 Apr 2020 11:43:39 -0400
X-MC-Unique: gbymVUbwNYCy0PIlN3UdYA-1
Received: by mail-wr1-f69.google.com with SMTP id t25so19511wrb.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xr6rSfDKjU4jA3ujLSUMvsu7+ReZdg+FiDFpha34S8g=;
        b=D7LPrLxFpuk3MM48Da76m6n5V8QsLaJsqXsDxRijN0kskPS3KEczp6ydt+6LOQA2xF
         nP6lTPsxk6/ZYo+fLP27VphUmIj07XC06g8J3K4zeg+GjGUea75VY2yiR3q6wLE0t9up
         XOrKmTN/iKO7KZiFjmKFSJtufd6xNzp/j4aMYJ2Di9EAOEWMm+HK3MFQ+p1pgxq/amzq
         qKfrTzGxIRhR99qUw+gIm8dVrDJ/oE8PEO5aFdY28QA6MMKz+5VWRuYseeqEqCGYk11g
         RelWPQpmTJ+w/1f8KnmAvNVuuXPv+VX1OOqD1/vTOLHj0aMKeV5zNDaQsTcN0rx+8+d9
         MLbQ==
X-Gm-Message-State: AGi0PuYfh8+FpRkBENWyE80ew9vx8+XJWfeaHIWKvsGO5xeLi1PRSXzQ
        AFGJtlGjWm5DE/wt/a0izAEUvKx6+wOk9YzlO4cHI40WZ27MPeOFuQ/lqGZCrxVq7kPwJjkUJ9g
        3s9VOcrk0MyYfPPt6xlRq3uC2
X-Received: by 2002:a1c:8149:: with SMTP id c70mr4889609wmd.123.1585755817860;
        Wed, 01 Apr 2020 08:43:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIhfQuR8s78zGF8YpXP2Efx3dCD7iZOWNk26lJSSFVUNBKYcVtqw+hj13k2MVj9GDKsmvQ2Q==
X-Received: by 2002:a1c:8149:: with SMTP id c70mr4889597wmd.123.1585755817641;
        Wed, 01 Apr 2020 08:43:37 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id s2sm2935925wmh.37.2020.04.01.08.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:43:36 -0700 (PDT)
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
Date:   Wed, 1 Apr 2020 16:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331222703.GH2452@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/31/20 11:27 PM, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 04:20:40PM -0500, Josh Poimboeuf wrote:
>> On Tue, Mar 31, 2020 at 04:17:58PM -0500, Josh Poimboeuf wrote:
>>>> I'm not against adding a second/separate hint for this. In fact, I
>>>> almost considered teaching objtool how to interpret the whole IRET frame
>>>> so that we can do it without hints. It's just that that's too much code
>>>> for this one case.
>>>>
>>>> HINT_IRET_SELF ?
>>>
>>> Despite my earlier complaint about stack size knowledge, we could just
>>> forget the hint and make "iretq in C code" equivalent to "reduce stack
>>> size by arch_exception_stack_size()" and keep going.  There's
>>> file->c_file which tells you it's a C file.
>>
>> Or maybe "iretq in an STT_FUNC" is better since this pattern could
>> presumably happen in a callable asm function.
> 
> Like so then?
> 
> ---
> Subject: objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 31 Mar 2020 13:16:52 +0200
> 
> This replaces the SAVE/RESTORE hints with a RET_OFFSET hint that
> applies to any instruction that terminates a function, like: RETURN
> and sibling calls. It allows the stack-frame to be off by @sp_offset,
> ie. it allows stuffing the return stack.
> 
> For ftrace_64.S we split the return path and make sure the
> ftrace_epilogue call is seen as a sibling/tail-call turning it into it's
> own function.
> 
> By splitting the return path every instruction has a unique stack setup
> and ORC can generate correct unwinds. Then employ the RET_OFFSET hint to
> the tail-call exit that has the direct-call (orig_eax) stuffed on the
> return stack.
> 
> For sync_core() we teach objtool that an IRET inside an STT_FUNC
> simply consumes the exception stack and continues.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/orc_types.h       |    9 ++-
>   arch/x86/include/asm/processor.h       |    2
>   arch/x86/include/asm/unwind_hints.h    |   12 +---
>   arch/x86/kernel/ftrace.c               |   12 ++++
>   arch/x86/kernel/ftrace_64.S            |   27 ++++-------
>   tools/arch/x86/include/asm/orc_types.h |    9 ++-
>   tools/objtool/Makefile                 |    2
>   tools/objtool/arch.h                   |    3 +
>   tools/objtool/arch/x86/decode.c        |    5 +-
>   tools/objtool/check.c                  |   80 ++++++++++-----------------------
>   tools/objtool/check.h                  |    4 +
>   11 files changed, 74 insertions(+), 91 deletions(-)
> 

[snip]

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1246,13 +1246,8 @@ static int read_unwind_hints(struct objt
> 
>   		cfa = &insn->state.cfa;
> 
> -		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
> -			insn->save = true;
> -			continue;
> -
> -		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
> -			insn->restore = true;
> -			insn->hint = true;
> +		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
> +			insn->ret_offset = hint->sp_offset;
>   			continue;
>   		}
> 
> @@ -1416,20 +1411,26 @@ static bool is_fentry_call(struct instru
>   	return false;
>   }
> 
> -static bool has_modified_stack_frame(struct insn_state *state)
> +static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
>   {
> +	u8 ret_offset = insn->ret_offset;
>   	int i;
> 
> -	if (state->cfa.base != initial_func_cfi.cfa.base ||
> -	    state->cfa.offset != initial_func_cfi.cfa.offset ||
> -	    state->stack_size != initial_func_cfi.cfa.offset ||
> -	    state->drap)
> +	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
> +		return true;
> +
> +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
> +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))

Isn't that the same thing as "state->cfa.offset != 
initial_func_cfi.cfa.offset + ret_offset" ?

> +		return true;
> +
> +	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
>   		return true;
> 
> -	for (i = 0; i < CFI_NUM_REGS; i++)
> +	for (i = 0; i < CFI_NUM_REGS; i++) {
>   		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>   		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
>   			return true;
> +	}
> 
>   	return false;
>   }
> @@ -1971,7 +1972,7 @@ static int validate_call(struct instruct
> 
>   static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
>   {
> -	if (has_modified_stack_frame(state)) {
> +	if (has_modified_stack_frame(insn, state)) {
>   		WARN_FUNC("sibling call from callable instruction with modified stack frame",
>   				insn->sec, insn->offset);
>   		return 1;
> @@ -2000,7 +2001,7 @@ static int validate_return(struct symbol
>   		return 1;
>   	}
> 
> -	if (func && has_modified_stack_frame(state)) {
> +	if (func && has_modified_stack_frame(insn, state)) {
>   		WARN_FUNC("return with modified stack frame",
>   			  insn->sec, insn->offset);
>   		return 1;
> @@ -2063,47 +2064,9 @@ static int validate_branch(struct objtoo
>   				return 0;
>   		}
> 
> -		if (insn->hint) {
> -			if (insn->restore) {
> -				struct instruction *save_insn, *i;
> -
> -				i = insn;
> -				save_insn = NULL;
> -				sym_for_each_insn_continue_reverse(file, func, i) {
> -					if (i->save) {
> -						save_insn = i;
> -						break;
> -					}
> -				}
> -
> -				if (!save_insn) {
> -					WARN_FUNC("no corresponding CFI save for CFI restore",
> -						  sec, insn->offset);
> -					return 1;
> -				}
> -
> -				if (!save_insn->visited) {
> -					/*
> -					 * Oops, no state to copy yet.
> -					 * Hopefully we can reach this
> -					 * instruction from another branch
> -					 * after the save insn has been
> -					 * visited.
> -					 */
> -					if (insn == first)
> -						return 0;
> -
> -					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> -						  sec, insn->offset);
> -					return 1;
> -				}
> -
> -				insn->state = save_insn->state;
> -			}
> -
> +		if (insn->hint)
>   			state = insn->state;
> -
> -		} else
> +		else
>   			insn->state = state;
> 
>   		insn->visited |= visited;
> @@ -2185,6 +2148,13 @@ static int validate_branch(struct objtoo
> 
>   			break;
> 
> +		case INSN_EXCEPTION_RETURN:
> +			if (func) {
> +				state.stack_size -= arch_exception_frame_size;
> +				break;

Why break instead of returning? Shouldn't an exception return mark the 
end of a branch (whether inside or outside a function) ?

Here it seems it will continue to the next instruction which might have 
been unreachable.

> +			}
> +
> +			/* fallthrough */

What is the purpose of the fallthrough here? If the exception return was 
in a function, it carried on to the next instruction, so it won't use 
the WARN_FUNC(). So, if I'm looking at the right version of the code 
only the "return 0;" will be used. And, unless my previous comment is 
wrong, I'd argue that we should return both for func and !func.

>   		case INSN_CONTEXT_SWITCH:
>   			if (func && (!next_insn || !next_insn->hint)) {
>   				WARN_FUNC("unsupported instruction in callable function",
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -33,9 +33,11 @@ struct instruction {
>   	unsigned int len;
>   	enum insn_type type;
>   	unsigned long immediate;
> -	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> +	bool alt_group, dead_end, ignore, ignore_alts;
> +	bool hint;
>   	bool retpoline_safe;
>   	u8 visited;
> +	u8 ret_offset;
>   	struct symbol *call_dest;
>   	struct instruction *jump_dest;
>   	struct instruction *first_jump_src;
> 
> 

Cheers,

-- 
Julien Thierry

