Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ACDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B8120678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvFbM7Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbgDBPbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:31:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389125AbgDBPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585841470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8go+XmW7aV++71D9Zfcx9rh3RfL3DnAWTnY8WVwCfu0=;
        b=YvFbM7CpzdN0kbT+SFNn/mFukuZwAvQNW7nR5Y8m1h3wDSKUcev1MlP/YF4Z6OmUWQqBMs
        c9rd4mPnecWDxjNgj2oUQ4NlO6amKpiCf1nFx7ua9bj08z2ZPf+4oYQBoRv2UNrA10v9TO
        NSomxJbOPD+4inGqLkqRnxCo5XkNIXI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-6h0Sq0ZAMae-mK0FHN3q3Q-1; Thu, 02 Apr 2020 11:31:08 -0400
X-MC-Unique: 6h0Sq0ZAMae-mK0FHN3q3Q-1
Received: by mail-wr1-f70.google.com with SMTP id y1so1629602wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8go+XmW7aV++71D9Zfcx9rh3RfL3DnAWTnY8WVwCfu0=;
        b=GU3oOWjcXX4WdgvMeZ8j+4v8W8GjI9uPgumEYSpS0ZhFFYE5Cv/oIX/n2rw4n8Umfp
         Ly4u6pzD1S1a+6borWrjtvVYgWVmMTKCWvc33naOMcWtqDwz/2x55kNKhgmdh1eTufi5
         PA/QbSyHNEn8a5zQAtkS36L6V1lyAlKrZb6Pe+AzpfSxcbtkfxJafRbVK5++HGddaBtL
         xX+/KZcQMYt1pYXAe5EC1MUA2rgrn/kg3q9c3CnxH01qwUZYnDehflq1EDCFGyAd1H0V
         X5t0uW9FjiaP7930+RMBNWoMj916qG+vX8Y86KOBOZSylYDUI2TLN/9M9vZ3KEuY9uLT
         10Eg==
X-Gm-Message-State: AGi0Puar0U3rVxFfu3Er01xO+J6adP7err1cygjoxsMLdhrVVPwIESs2
        axo8b3Hg0JQOeX0q4RrdIhpwvUsQIMrH056QjnQp8X2YlA20s2UUvFQYyRPz4IVGFktK5ZRoe+9
        kci+5SjJvA+VQJC6ZxTN8PrBx
X-Received: by 2002:a5d:6847:: with SMTP id o7mr4003921wrw.274.1585841467760;
        Thu, 02 Apr 2020 08:31:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmW+n29VyWMNvUZC3b0K01TfQQRNymQo6XGLC96/B0VA0Qj/dhPdQ6IzB/bNFcQPQVQ1/XKw==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr4003903wrw.274.1585841467485;
        Thu, 02 Apr 2020 08:31:07 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id a7sm7245427wmm.34.2020.04.02.08.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:31:06 -0700 (PDT)
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
Date:   Thu, 2 Apr 2020 16:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 3:46 PM, Alexandre Chartre wrote:
> 
> On 4/2/20 3:26 PM, Julien Thierry wrote:
>> Hi Alexandre,
>>
>> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>>> With retpoline, the return instruction is used to branch to an address
>>> stored on the stack. So, unlike a regular return instruction, when a
>>> retpoline return instruction is reached the stack has been modified
>>> compared to what we have when the function was entered.
>>>
>>> Provide the mechanism to explicitly call-out such return instruction
>>> so that objtool can correctly handle them.
>>>
>>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>> ---
>>>   tools/objtool/check.c | 78 +++++++++++++++++++++++++++++++++++++++++--
>>>   tools/objtool/check.h |  1 +
>>>   2 files changed, 76 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>>> index 0cec91291d46..ed8e3ea1d8da 100644
>>> --- a/tools/objtool/check.c
>>> +++ b/tools/objtool/check.c
>>> @@ -1344,6 +1344,48 @@ static int read_intra_function_call(struct 
>>> objtool_file *file)
>>>       return 0;
>>>   }
>>> +static int read_retpoline_ret(struct objtool_file *file)
>>> +{
>>> +    struct section *sec;
>>> +    struct instruction *insn;
>>> +    struct rela *rela;
>>> +
>>> +    sec = find_section_by_name(file->elf, 
>>> ".rela.discard.retpoline_ret");
>>> +    if (!sec)
>>> +        return 0;
>>> +
>>> +    list_for_each_entry(rela, &sec->rela_list, list) {
>>> +        if (rela->sym->type != STT_SECTION) {
>>> +            WARN("unexpected relocation symbol type in %s",
>>> +                 sec->name);
>>> +            return -1;
>>> +        }
>>> +
>>> +        insn = find_insn(file, rela->sym->sec, rela->addend);
>>> +        if (!insn) {
>>> +            WARN("bad .discard.retpoline_ret entry");
>>> +            return -1;
>>> +        }
>>> +
>>> +        if (insn->type != INSN_RETURN) {
>>> +            WARN_FUNC("retpoline_ret not a return",
>>> +                  insn->sec, insn->offset);
>>> +            return -1;
>>> +        }
>>> +
>>> +        insn->retpoline_ret = true;
>>> +        /*
>>> +         * For the impact on the stack, make a return trampoline
>>> +         * behaves like a pop of the return address.
>>> +         */
>>> +        insn->stack_op.src.type = OP_SRC_POP;
>>> +        insn->stack_op.dest.type = OP_DEST_REG;
>>> +        insn->stack_op.dest.reg = CFI_RA;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static void mark_rodata(struct objtool_file *file)
>>>   {
>>>       struct section *sec;
>>> @@ -1403,6 +1445,10 @@ static int decode_sections(struct objtool_file 
>>> *file)
>>>       if (ret)
>>>           return ret;
>>> +    ret = read_retpoline_ret(file);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>>       ret = add_call_destinations(file);
>>>       if (ret)
>>>           return ret;
>>> @@ -1432,7 +1478,8 @@ static bool is_fentry_call(struct instruction 
>>> *insn)
>>>       return false;
>>>   }
>>> -static bool has_modified_stack_frame(struct insn_state *state)
>>> +static bool has_modified_stack_frame(struct insn_state *state,
>>> +                     bool check_registers)
>>>   {
>>>       int i;
>>> @@ -1442,6 +1489,9 @@ static bool has_modified_stack_frame(struct 
>>> insn_state *state)
>>>           state->drap)
>>>           return true;
>>> +    if (!check_registers)
>>> +        return false;
>>> +
>>>       for (i = 0; i < CFI_NUM_REGS; i++)
>>>           if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>>>               state->regs[i].offset != initial_func_cfi.regs[i].offset)
>>> @@ -1987,7 +2037,7 @@ static int validate_call(struct instruction 
>>> *insn, struct insn_state *state)
>>>   static int validate_sibling_call(struct instruction *insn, struct 
>>> insn_state *state)
>>>   {
>>> -    if (has_modified_stack_frame(state)) {
>>> +    if (has_modified_stack_frame(state, true)) {
>>>           WARN_FUNC("sibling call from callable instruction with 
>>> modified stack frame",
>>>                   insn->sec, insn->offset);
>>>           return 1;
>>> @@ -2009,6 +2059,7 @@ static int validate_branch(struct objtool_file 
>>> *file, struct symbol *func,
>>>       struct alternative *alt;
>>>       struct instruction *insn, *next_insn;
>>>       struct section *sec;
>>> +    bool check_registers;
>>>       u8 visited;
>>>       int ret;
>>> @@ -2130,7 +2181,28 @@ static int validate_branch(struct objtool_file 
>>> *file, struct symbol *func,
>>>                   return 1;
>>>               }
>>> -            if (func && has_modified_stack_frame(&state)) {
>>> +            /*
>>> +             * With retpoline, the return instruction is used
>>> +             * to branch to an address stored on the stack.
>>> +             * So when we reach the ret instruction, the stack
>>> +             * frame has been modified with the address to
>>> +             * branch to and we need update the stack state.
>>> +             *
>>> +             * The retpoline address to branch to is typically
>>> +             * pushed on the stack from a register, but this
>>> +             * confuses the logic which checks callee saved
>>> +             * registers. So we don't check if registers have
>>> +             * been modified if we have a return trampoline.
>>
>> I think there are two different things to consider here.
>>
>> First, the update of the stack frame which I believe should be done
>> when returning from intra_function_calls, as it undoes what the call
>> instruction did (push more stuff on the stack in the case of x86).
> 
> The problem is that an intra-function call is not necessarily going
> to return. With retpoline (or RSB stuffing) intra-function calls are
> basically fake calls only present to fill the RSB buffer. Such calls
> won't return, the stack pointer is just adjusted to cancel the impact
> of these calls on the stack.
> 

Right, but running into an intra-function call will start a validate 
branch with a modified stack frame.

So, starting from an intra-function call, if we run into a return, I 
guess objtool will complain about a return with modified stack frame.

My understanding is that once you find an intra-function call, either 
you hit a return, ending the branch, so the return should undo the 
modification the intra-function call did (whether is it a retpoline 
return or not). Otherwise, the intra-function call branch will need to 
reach an end in some way (e.g. hitting a CONTEXT_SWITCH instruction, 
calling a dead_end_function).

Am I missing something?

-- 
Julien Thierry

