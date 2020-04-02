Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E01C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2132078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oq/YYrvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgDBGl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:41:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbgDBGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585809713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vp8T3NOJdA2k/zwZH2Kfq+w4ReMOCQ7AV7O43MaM2x0=;
        b=Oq/YYrvpL7NlKZJbuIDKplEzUOKcKHA10PT97evykUD1f3uP/ENR4yTNQU0M1ur/Qj79pw
        hb9ptmH1Rp2QVeXN1IdMi0O7dEZI/4gVznGL1gVASgYyeuH8OJnUl50LkmEVfvFVCEGfKs
        h5kib47QJj3c/mH0thEEA56UKJOJNNI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-eZyn5DpWNEeJpJboWrsDTw-1; Thu, 02 Apr 2020 02:41:50 -0400
X-MC-Unique: eZyn5DpWNEeJpJboWrsDTw-1
Received: by mail-wr1-f71.google.com with SMTP id r15so992296wrm.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vp8T3NOJdA2k/zwZH2Kfq+w4ReMOCQ7AV7O43MaM2x0=;
        b=KmuZQXvRHDE0+u/4P1DqZGk/p/GLmeGMJpkmAIi4xpy5yO9AaF2PxYdIYIr7FBX4nu
         NY8j8zvjCLKVsBX+ZKKW1ClNUpf9biYef6OGdaN5CFmUoPXnoJCkXLHcVPFo5hcQnIVQ
         2cXNZuBjuhJ4nNGIaLRV8QP9tC2sRShtqjr5fpVdyWJadkG4ZYRa0lTz5zqdLQQi+ae2
         z5WEZ6xPgSSUByEhzUNRcLTHbepqFaca7GZq6APFt5bnZCuiMzvxluOi5+zKn/1LfTAy
         UKyHYTBDFgd8u3QBDB7rfuDtSy84HKuBwQHKBKQqNuFmsvFAk/wy16HIR5ticTBhzrmZ
         jDbg==
X-Gm-Message-State: AGi0PubTmvUJ9jZodyr+1GRv8FYAGBR4fFEFA8X79lOL1StxHYSKETFB
        rNOfLS6IRc7DAhwbCyXsoQmPrK+7+dJDby3FMbrGKKYZg4VblzdfzgEQSpWdEqLt/6AG48D3nhp
        ftEL9Xs9/purA7PzY6l8i3jqZ
X-Received: by 2002:a1c:a145:: with SMTP id k66mr1846973wme.26.1585809708869;
        Wed, 01 Apr 2020 23:41:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfbCUmoGOf9fKCWtsxWv+vB80pUl+ZIaOxbmGFZomkReboA7PDGK591OytjHKUCi3j5A1a3Q==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr1846954wme.26.1585809708628;
        Wed, 01 Apr 2020 23:41:48 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id j188sm6003182wmj.36.2020.04.01.23.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 23:41:48 -0700 (PDT)
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
References: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
Date:   Thu, 2 Apr 2020 07:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401170910.GX20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 6:09 PM, Peter Zijlstra wrote:
> On Wed, Apr 01, 2020 at 04:43:35PM +0100, Julien Thierry wrote:
> 
>>> +static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
>>>    {
>>> +	u8 ret_offset = insn->ret_offset;
>>>    	int i;
>>>
>>> -	if (state->cfa.base != initial_func_cfi.cfa.base ||
>>> -	    state->cfa.offset != initial_func_cfi.cfa.offset ||
>>> -	    state->stack_size != initial_func_cfi.cfa.offset ||
>>> -	    state->drap)
>>> +	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
>>> +		return true;
>>> +
>>> +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
>>> +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))
>>
>> Isn't that the same thing as "state->cfa.offset !=
>> initial_func_cfi.cfa.offset + ret_offset" ?
> 
> I'm confused on what cfa.offset is, sometimes it increase with
> stack_size, sometimes it doesn't.
> 

Steven already replied for me about that :) .

> ISTR that for the ftrace case it was indeed cfa.offset + 8, but for the
> IRET case below (where it is now not used anymore) it was cfa.offset
> (not cfa.offset + 40, which I was expecting).
> 
>>> +		return true;
>>> +
>>> +	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
>>>    		return true;
>>>
>>> -	for (i = 0; i < CFI_NUM_REGS; i++)
>>> +	for (i = 0; i < CFI_NUM_REGS; i++) {
>>>    		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>>>    		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
>>>    			return true;
>>> +	}
>>>
>>>    	return false;
>>>    }
> 
>>> @@ -2185,6 +2148,13 @@ static int validate_branch(struct objtoo
>>>
>>>    			break;
>>>
>>> +		case INSN_EXCEPTION_RETURN:
>>> +			if (func) {
>>> +				state.stack_size -= arch_exception_frame_size;
>>> +				break;
>>
>> Why break instead of returning? Shouldn't an exception return mark the end
>> of a branch (whether inside or outside a function) ?
>>
>> Here it seems it will continue to the next instruction which might have been
>> unreachable.
> 
> The code in question (x86's sync_core()), is an exception return to
> self. It pushes an exception frame that points to right after the
> exception return instruction.
> 
> This is the only usage of IRET in STT_FUNC symbols.
> 
> So rather than teaching objtool how to interpret the whole
> push;push;push;push;push;iret sequence, teach it how big the frame is
> (arch_exception_frame_size) and let it continue.
> 
> All the other (real) IRETs are in STT_NOTYPE in the entry assembly.
> 

Right, I see.. However I'm not completely convinced by this. I must 
admit I haven't followed the whole conversation, but what was the issue 
with the HINT_IRET_SELF? It seemed more elegant, but I might be missing 
some context.

Otherwise, it might be worth having a comment in the code to point that 
this only handles the sync_core() case.


Also, instead of adding a special "arch_exception_frame_size", I could 
suggest:
- Picking this patch [1] from a completely arbitrary source
- Getting rid of INSN_STACK type, any instruction could then include 
stack ops on top of their existing semantics, they can just have an 
empty list if they don't touch SP/BP
- x86 decoder adds a stack_op to the iret to modify the stack pointer by 
the right amount

[1] https://www.spinics.net/lists/kernel/msg3453725.html

Thanks,

-- 
Julien Thierry

