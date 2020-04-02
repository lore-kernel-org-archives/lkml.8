Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D463C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8D120784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3fnQmcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgDBG40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:56:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbgDBG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585810583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx2VybBnSB0PadqR8NQBZq/bdCkgPc0XAu0oYogAFqc=;
        b=A3fnQmcHXyb0kX1e6k6LI6gEfx5k4r9O9YwoIDUTRx6X+J5lCJGcWtL/1lYCzXOX7fy1I/
        GP51FJbl71VjYJgzB/DagUbh6kL2MQ5HTrISE6d6DmLvxrPqQhSlzcNSEe+YvsPpRKHHPG
        krhE3ZormnfsDRqn7sIB0pW6gzBRdFU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-YslmaDgwNciwGz_izrjg9w-1; Thu, 02 Apr 2020 02:56:22 -0400
X-MC-Unique: YslmaDgwNciwGz_izrjg9w-1
Received: by mail-wr1-f70.google.com with SMTP id l17so1034388wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xx2VybBnSB0PadqR8NQBZq/bdCkgPc0XAu0oYogAFqc=;
        b=tTEiflgX/A2t5m9uy4nyTfsJMC1BvWsFX1cMaoOSVZwawNxLsqywV02Z7zO0o2LJWP
         1o3/gI9XVEr3gRcZ5VL3OsxadGHHQ+c1tq2lkcDCNMYbMTkh24TjdhPmVDFmd0eGjb4B
         KFdX6gMHLU3pbfeO5onyMEzfNL2Qu17A4ywuVlAvYdBHS4aBb5cKY7yIr2gkg+syW/86
         MoAZhIMKQG9UvsloPeNPFw4IibbTVQRKTLJDAwvFX8HBBePl70joY45EZfqn+GEp4DMO
         0WuP4HavbAkj+lwQdEavxYnVeYvfbCAnsoYIr5oM8lpVgH8H410PbkMxAxLVUZT95YUO
         HoFw==
X-Gm-Message-State: AGi0PuYpk2AkOqTFnTPiug/t58/Asoar5q7KNthFbxJWtE0cy31OfqX7
        IsQSbWcPejcCIZoHYaB7yeeEZdVQvwI44TIR7MN3VBJEDMPF+YwU80naMwBN92aelEpEnXv/K8k
        a2MFwtyH7sRKkStpV/4dI+AKi
X-Received: by 2002:a1c:5414:: with SMTP id i20mr1867625wmb.109.1585810580792;
        Wed, 01 Apr 2020 23:56:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4A16p6z1S5KYWSWAnINXDik00zxuCzxwmMZ2FrXieqengc/9MqE//TvmBZew759MUiJLu4A==
X-Received: by 2002:a1c:5414:: with SMTP id i20mr1867608wmb.109.1585810580561;
        Wed, 01 Apr 2020 23:56:20 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id y189sm5910154wmb.26.2020.04.01.23.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 23:56:20 -0700 (PDT)
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
From:   Julien Thierry <jthierry@redhat.com>
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
 <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
Message-ID: <39ab6c97-bdab-bc39-7a3c-864cad2bc2de@redhat.com>
Date:   Thu, 2 Apr 2020 07:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 7:41 AM, Julien Thierry wrote:
> 
> 
> On 4/1/20 6:09 PM, Peter Zijlstra wrote:
>> On Wed, Apr 01, 2020 at 04:43:35PM +0100, Julien Thierry wrote:
>>>> +        return true;
>>>> +
>>>> +    if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
>>>>            return true;
>>>>
>>>> -    for (i = 0; i < CFI_NUM_REGS; i++)
>>>> +    for (i = 0; i < CFI_NUM_REGS; i++) {
>>>>            if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>>>>                state->regs[i].offset != 
>>>> initial_func_cfi.regs[i].offset)
>>>>                return true;
>>>> +    }
>>>>
>>>>        return false;
>>>>    }
>>
>>>> @@ -2185,6 +2148,13 @@ static int validate_branch(struct objtoo
>>>>
>>>>                break;
>>>>
>>>> +        case INSN_EXCEPTION_RETURN:
>>>> +            if (func) {
>>>> +                state.stack_size -= arch_exception_frame_size;
>>>> +                break;
>>>
>>> Why break instead of returning? Shouldn't an exception return mark 
>>> the end
>>> of a branch (whether inside or outside a function) ?
>>>
>>> Here it seems it will continue to the next instruction which might 
>>> have been
>>> unreachable.
>>
>> The code in question (x86's sync_core()), is an exception return to
>> self. It pushes an exception frame that points to right after the
>> exception return instruction.
>>
>> This is the only usage of IRET in STT_FUNC symbols.
>>
>> So rather than teaching objtool how to interpret the whole
>> push;push;push;push;push;iret sequence, teach it how big the frame is
>> (arch_exception_frame_size) and let it continue.
>>
>> All the other (real) IRETs are in STT_NOTYPE in the entry assembly.
>>
> 
> Right, I see.. However I'm not completely convinced by this. I must 
> admit I haven't followed the whole conversation, but what was the issue 
> with the HINT_IRET_SELF? It seemed more elegant, but I might be missing 
> some context.
> 
> Otherwise, it might be worth having a comment in the code to point that 
> this only handles the sync_core() case.
> 
> 
> Also, instead of adding a special "arch_exception_frame_size", I could 
> suggest:
> - Picking this patch [1] from a completely arbitrary source
> - Getting rid of INSN_STACK type, any instruction could then include 
> stack ops on top of their existing semantics, they can just have an 
> empty list if they don't touch SP/BP
> - x86 decoder adds a stack_op to the iret to modify the stack pointer by 
> the right amount
> 

And the x86 decode could also lookup the symbol containing an IRET and 
chose whether its type should be INSN_CONTEXT_SWITCH or INSN_OTHER 
depending on whether the symbol is a function or not.

This would avoid having the arch specific pattern detected the generic 
stack validation part of objtool.

-- 
Julien Thierry

