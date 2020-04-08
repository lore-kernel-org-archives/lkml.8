Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36315C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069902075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi0XegoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgDHQE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:04:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729686AbgDHQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586361893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8cdbHwMPX0L7w/r7EIcNZQtT2x1Zng3ah3sHIrwDA8=;
        b=Hi0XegoS7GstWykSY+vIhVE0v2hypJNs6uuR88Yma8/mHZRNzvx3zoW/JFkBHCw3v+9o16
        oYkRZYh3vwG/20KZV2yK7oCyqBf+hUp5IyB7q7S9ir2e1m6A7xqapjn/aZ8AKtdmBChaqh
        OMrO7nWlqIWvgyosnIJ1opt028NQHAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-T9KN9jtoOCuJ9cUN33s8FQ-1; Wed, 08 Apr 2020 12:04:52 -0400
X-MC-Unique: T9KN9jtoOCuJ9cUN33s8FQ-1
Received: by mail-wr1-f69.google.com with SMTP id m15so4520171wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y8cdbHwMPX0L7w/r7EIcNZQtT2x1Zng3ah3sHIrwDA8=;
        b=X/eq79gWem8+S3RfoEIulOqJ90KXHEBSZKrgKOC3Df54ja6m30atMj+UtNablC24E+
         Vkd530Y3ZbPCyYNI7nCUffxyEsm0/Tj5AccVUTpWWtThfQ4pQDQoHuy0YUaqAobYtb5K
         waIYDaKlf6jAGlEXobaaKwv3FIwnoxu2qc8iFjd9YqDDyK09NRuhE/0I9c/VqEPf4B/g
         fi4KXZLYHK4KcvP0UMUk1jndSGHq0oH1nz9DRhxnhqullSmM2aAjZ2nTCv5PDzXGJvh2
         r5SMHA5X+naTMyIr/jgxGc38ZMsBG6NFxS/yD9LXv8hh0HFVxaZJz6SEXHNrRWfbms2s
         laFA==
X-Gm-Message-State: AGi0PuYQOwkSw6iHyt1W/VmH4PpPPGbFAECK50Q9dsI+bDMP5qzn0Whv
        YucDjl9RiVg/VGsR+D88JJm8pMsgV5bzqexMLj/H5WhroyDkR5+fe8QkJfbe/ZgFPpMiGrryLp/
        n2zmFXEfRjpY6Hqq9KrW4BHhF
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr5257748wme.18.1586361890774;
        Wed, 08 Apr 2020 09:04:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJorMTd2Ou0V5GE1PBO4npEfOlfP4EeYVktw3VOtonDVsBtJKP1IAXFP1M8viALw+oSnJW0mg==
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr5257727wme.18.1586361890533;
        Wed, 08 Apr 2020 09:04:50 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id t124sm16359wmf.19.2020.04.08.09.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:04:48 -0700 (PDT)
Subject: Re: [PATCH V2 5/9] objtool: Add support for intra-function calls
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-6-alexandre.chartre@oracle.com>
 <20200407130729.GZ20730@hirez.programming.kicks-ass.net>
 <40b19a8e-ae5e-623e-fb3f-261f9fec2ea5@oracle.com>
 <7ba6d4c9-c1dc-fa83-2ade-b7d3fba9e7fb@oracle.com>
 <b8d4777e-1c33-7165-33f6-f32007ef7305@redhat.com>
 <cb04c823-3b93-4fe3-9d78-17040b802f82@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <981d7f79-3429-776f-7356-345adc6332bf@redhat.com>
Date:   Wed, 8 Apr 2020 17:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cb04c823-3b93-4fe3-9d78-17040b802f82@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 5:03 PM, Alexandre Chartre wrote:
> 
> 
> On 4/8/20 4:19 PM, Julien Thierry wrote:
>>
>>
>> On 4/8/20 3:06 PM, Alexandre Chartre wrote:
>>>
>>>
>>> On 4/7/20 3:28 PM, Alexandre Chartre wrote:
>>>>
>>>> On 4/7/20 3:07 PM, Peter Zijlstra wrote:
>>>>> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
>>>>>
>>>>>> index a62e032863a8..7ee1561bf7ad 100644
>>>>>> --- a/tools/objtool/arch/x86/decode.c
>>>>>> +++ b/tools/objtool/arch/x86/decode.c
>>>>>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct 
>>>>>> cfi_state *state)
>>>>>>       state->regs[16].base = CFI_CFA;
>>>>>>       state->regs[16].offset = -8;
>>>>>>   }
>>>>>> +
>>>>>> +
>>>>>> +void arch_configure_intra_function_call(struct stack_op *op)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * For the impact on the stack, make an intra-function
>>>>>> +     * call behaves like a push of an immediate value (the
>>>>>> +     * return address).
>>>>>> +     */
>>>>>> +    op->src.type = OP_SRC_CONST;
>>>>>> +    op->dest.type = OP_DEST_PUSH;
>>>>>> +}
>>>>>
>>>>> An alternative is to always set up stack ops for CALL/RET on 
>>>>> decode, but
>>>>> conditionally run update_insn_state() for them.
>>>>>
>>>>> Not sure that makes more logical sense, but the patch would be 
>>>>> simpler I
>>>>> think.
>>>>
>>>> Right, this would avoid adding a new arch dependent function and the 
>>>> patch
>>>> will be simpler. This probably makes sense as the stack impact is 
>>>> the same
>>>> for all calls (but objtool will use it only for intra-function calls).
>>>>
>>>
>>> Actually the processing of the ret instruction is more complicated 
>>> than I
>>> anticipated with intra-function calls, and so my implementation is not
>>> complete at the moment.
>>>
>>> The issue is to correctly handle how the ret is going to behave 
>>> depending how
>>> the stack (or register on arm) is modified before the ret. Adjusting 
>>> the stack
>>> offset makes the stack state correct, but objtool still needs to 
>>> correctly
>>> figure out where the ret is going to return and where the code flow 
>>> continues.
>>>
>>
>> A hint indicating the target "jump" address could be useful. It could
>> be used to add the information on some call/jump dynamic that aren't
>> associated with jump tables. Currently when objtool finds a jump
>> dynamic, if no branches were added to it, it will just return.
>>
>> Having such a hint could help make additional links (at least on
>> arm64). I don't know what Peter and Josh would think of that (if that
>> helps in your case of course).
>>
> 
> Yes, I am thinking about tracking intra-function call return address,
> and having hints to specify a return address changes. For example,
> on x86, when we push the branch address on the stack we overwrite the
> last return address (the return address of the last intra-function call).
> Then the return instruction can figure out where to branch.

I see, I was thinking about a more generic hint, that would just 
indicate "this instruction actually jumps here". So in your case it 
would just point that a certain return instruction causes to branch 
somewhere.

This way the hint could also be used for other instructions (e.g. 
INSN_JUMP_DYNAMIC).



-- 
Julien Thierry

