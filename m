Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFACC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EFC20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxd7bAnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgDHRHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:07:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729558AbgDHRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586365627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWnDGOv9qqH3ETycko6yVzSA1l/fA4wz3CeoPgCd9ng=;
        b=Lxd7bAnpao3QW1BP2blanZm7RT+nbAxhUXV/qYn3npbSZUGXdxZi3S+c1LOdmvhrIaOLPR
        3yKfFK6NQ4YaJUhooKIMwQ3ndwyjtEqbt8H5YolcSvl4jY5yCjOTB/TAwVmYUFJyLJBsh/
        x46GL8xDvytMNZl220VIcC2ErbnUwHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-W5uIElpJP6mkNh1pPGMBDw-1; Wed, 08 Apr 2020 13:07:05 -0400
X-MC-Unique: W5uIElpJP6mkNh1pPGMBDw-1
Received: by mail-wr1-f70.google.com with SMTP id u16so4758658wrp.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pWnDGOv9qqH3ETycko6yVzSA1l/fA4wz3CeoPgCd9ng=;
        b=MT2Qw7cgLOs2z6o8fmxaaIa4dynxa8tfgNjpd3Z0OjGReSSd5hvjl+4dtUd7dxgj97
         8lSDmr43KrzyZmTyeoJybYKE0ODFcno6SGr7QXzx8Nzg+AXdghNiMhZ4JRcha44KXeOv
         hkad7+cFpPzx/NRZ1nnovGdA4zd1DqJaRwsw4nlbSwOra/0lYvbkKQakEDobHEHs60Pe
         y4JKDcv9Lj3pJxI73LuBzFBzhG4RF6n1FDaJQpFoPcTAIxlAqI88eUdOlzMWUnXSjmlv
         kg86Us3ufQWFHcOk3SSeeL7mwUbmSmwrdiM9S8o4bo7gvKQUJk2yqT9QVws9/M5f9OXx
         uSpw==
X-Gm-Message-State: AGi0PuaiHm9Etn9sYjZ9PjiP7LysFkWEm+kyUUcCUr/g/5A+pdhMXrFi
        oyXVlC1qc+MbK36SvUnVYkkAOKXdtOjvgZUFjDmsmk7ci7snhhzyxwmMtSf6tmy94E3CY7nJXJz
        1mA1EybrPtPw5AmkdKAKosEbv
X-Received: by 2002:adf:f881:: with SMTP id u1mr5143254wrp.186.1586365624115;
        Wed, 08 Apr 2020 10:07:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3zGjHD4qqs+KQu29mp2cWfHkQoTGPoqS7uYdDkWIYsPQ7HjOyC/OrpZsjKnQ31X9uOLZTMg==
X-Received: by 2002:adf:f881:: with SMTP id u1mr5143200wrp.186.1586365623451;
        Wed, 08 Apr 2020 10:07:03 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id j11sm31597784wro.51.2020.04.08.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 10:07:01 -0700 (PDT)
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
 <981d7f79-3429-776f-7356-345adc6332bf@redhat.com>
 <69cf35b5-8c65-3602-3f03-3eeb42241f33@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <adf5a21b-2b34-9b5d-f832-b1b6575609da@redhat.com>
Date:   Wed, 8 Apr 2020 18:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <69cf35b5-8c65-3602-3f03-3eeb42241f33@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 6:06 PM, Alexandre Chartre wrote:
> 
> 
> On 4/8/20 6:04 PM, Julien Thierry wrote:
>>
>>
>> On 4/8/20 5:03 PM, Alexandre Chartre wrote:
>>>
>>>
>>> On 4/8/20 4:19 PM, Julien Thierry wrote:
>>>>
>>>>
>>>> On 4/8/20 3:06 PM, Alexandre Chartre wrote:
>>>>>
>>>>>
>>>>> On 4/7/20 3:28 PM, Alexandre Chartre wrote:
>>>>>>
>>>>>> On 4/7/20 3:07 PM, Peter Zijlstra wrote:
>>>>>>> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
>>>>>>>
>>>>>>>> index a62e032863a8..7ee1561bf7ad 100644
>>>>>>>> --- a/tools/objtool/arch/x86/decode.c
>>>>>>>> +++ b/tools/objtool/arch/x86/decode.c
>>>>>>>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct 
>>>>>>>> cfi_state *state)
>>>>>>>>       state->regs[16].base = CFI_CFA;
>>>>>>>>       state->regs[16].offset = -8;
>>>>>>>>   }
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +void arch_configure_intra_function_call(struct stack_op *op)
>>>>>>>> +{
>>>>>>>> +    /*
>>>>>>>> +     * For the impact on the stack, make an intra-function
>>>>>>>> +     * call behaves like a push of an immediate value (the
>>>>>>>> +     * return address).
>>>>>>>> +     */
>>>>>>>> +    op->src.type = OP_SRC_CONST;
>>>>>>>> +    op->dest.type = OP_DEST_PUSH;
>>>>>>>> +}
>>>>>>>
>>>>>>> An alternative is to always set up stack ops for CALL/RET on 
>>>>>>> decode, but
>>>>>>> conditionally run update_insn_state() for them.
>>>>>>>
>>>>>>> Not sure that makes more logical sense, but the patch would be 
>>>>>>> simpler I
>>>>>>> think.
>>>>>>
>>>>>> Right, this would avoid adding a new arch dependent function and 
>>>>>> the patch
>>>>>> will be simpler. This probably makes sense as the stack impact is 
>>>>>> the same
>>>>>> for all calls (but objtool will use it only for intra-function 
>>>>>> calls).
>>>>>>
>>>>>
>>>>> Actually the processing of the ret instruction is more complicated 
>>>>> than I
>>>>> anticipated with intra-function calls, and so my implementation is not
>>>>> complete at the moment.
>>>>>
>>>>> The issue is to correctly handle how the ret is going to behave 
>>>>> depending how
>>>>> the stack (or register on arm) is modified before the ret. 
>>>>> Adjusting the stack
>>>>> offset makes the stack state correct, but objtool still needs to 
>>>>> correctly
>>>>> figure out where the ret is going to return and where the code flow 
>>>>> continues.
>>>>>
>>>>
>>>> A hint indicating the target "jump" address could be useful. It could
>>>> be used to add the information on some call/jump dynamic that aren't
>>>> associated with jump tables. Currently when objtool finds a jump
>>>> dynamic, if no branches were added to it, it will just return.
>>>>
>>>> Having such a hint could help make additional links (at least on
>>>> arm64). I don't know what Peter and Josh would think of that (if that
>>>> helps in your case of course).
>>>>
>>>
>>> Yes, I am thinking about tracking intra-function call return address,
>>> and having hints to specify a return address changes. For example,
>>> on x86, when we push the branch address on the stack we overwrite the
>>> last return address (the return address of the last intra-function 
>>> call).
>>> Then the return instruction can figure out where to branch.
>>
>> I see, I was thinking about a more generic hint, that would just
>> indicate "this instruction actually jumps here". So in your case it
>> would just point that a certain return instruction causes to branch
>> somewhere.
> 
> I thought about doing that but the problem is that on x86 the same
> retpoline code can branch differently depending on how it is used.
> Basically we have a return instruction that will branch differently
> based on what's on the stack. So we can just tell that this ret
> instruction will branch/return there.
> 

Oh, I see. Nevermind then!

-- 
Julien Thierry

