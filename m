Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92055C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B00206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8fGnG3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgDHPWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:22:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbgDHPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586359337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1txRlmT+72ImlSaHrcTVyVV9rPGbS6nrrn3+UD7QLpI=;
        b=E8fGnG3xf71R9OfRNJIJoKb6ffwTulusG37+cio1YEj+GWlCHYx8jHN/BHeVbkLbbsm+kc
        3FtNsvBMgBv5kmd6riqbV2HcTctbwbNvBFCV6y0n+QYgBbaFWr/AqdA9z2VB+7r/9cWega
        wU5bVRH/cz+5bE1hN+VhMgPD/CTX6wQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-3a2etxdQOD6R8Zka8-SMtw-1; Wed, 08 Apr 2020 11:22:15 -0400
X-MC-Unique: 3a2etxdQOD6R8Zka8-SMtw-1
Received: by mail-lf1-f70.google.com with SMTP id i20so1400978lfl.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1txRlmT+72ImlSaHrcTVyVV9rPGbS6nrrn3+UD7QLpI=;
        b=TApFEK2X8FeNJ+RmfSveXfRO2AOWuQWyb4eJhBo/d0WlYtI4f+3M2fwpCEjMLVALe7
         BLuwvYoG30PZWv9awqECO8yiiztOY2N5QVSa2YApISGHXoLc1Q80xUkfufgiePT7rWke
         zzPxY/zi195WcTB5cIOtddBHdj3xu3r+iIF/rg6YrTleqjAXdCIznHu406a8BaZRcXeD
         3fNITHraHeVn6TvZYGmqrlA9b3xQaDCXprVMJqysrvLA0aHZFvx9LWutZq3ttDz64QXB
         eeOOsq1RP+/Y2BgAWlas9dXPi2lbRkhyEda4f1U027i6IKZJIXmBJ/5Fhpm4ZC0q+lu3
         MA5A==
X-Gm-Message-State: AGi0PuYRqmcr1HYtEVqXJ1S9tJ0TnBKs+tIncGJ9K8kH3Awnz7OzsJY1
        VOAqApFH2ulvhYHbWioioZ+XUYPtNv+ztTYkAU3NjgG8gvQVmN1itxaVvVwD9kIBlzr/QBCLrjJ
        3n5XjcVOryApHT68I2YY2Q3QS
X-Received: by 2002:a2e:330e:: with SMTP id d14mr5352408ljc.153.1586359332735;
        Wed, 08 Apr 2020 08:22:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJdXz3oUttJhWsuebJFdNpeDsyKWPgAW8IH00jWOSlW8PWM08JGzO56MjZfMCAaMit2yGY3xA==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr9186294wrq.16.1586355600423;
        Wed, 08 Apr 2020 07:20:00 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id r20sm6293441wmh.46.2020.04.08.07.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 07:19:59 -0700 (PDT)
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
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <b8d4777e-1c33-7165-33f6-f32007ef7305@redhat.com>
Date:   Wed, 8 Apr 2020 15:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7ba6d4c9-c1dc-fa83-2ade-b7d3fba9e7fb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 3:06 PM, Alexandre Chartre wrote:
> 
> 
> On 4/7/20 3:28 PM, Alexandre Chartre wrote:
>>
>> On 4/7/20 3:07 PM, Peter Zijlstra wrote:
>>> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
>>>
>>>> index a62e032863a8..7ee1561bf7ad 100644
>>>> --- a/tools/objtool/arch/x86/decode.c
>>>> +++ b/tools/objtool/arch/x86/decode.c
>>>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct 
>>>> cfi_state *state)
>>>>       state->regs[16].base = CFI_CFA;
>>>>       state->regs[16].offset = -8;
>>>>   }
>>>> +
>>>> +
>>>> +void arch_configure_intra_function_call(struct stack_op *op)
>>>> +{
>>>> +    /*
>>>> +     * For the impact on the stack, make an intra-function
>>>> +     * call behaves like a push of an immediate value (the
>>>> +     * return address).
>>>> +     */
>>>> +    op->src.type = OP_SRC_CONST;
>>>> +    op->dest.type = OP_DEST_PUSH;
>>>> +}
>>>
>>> An alternative is to always set up stack ops for CALL/RET on decode, but
>>> conditionally run update_insn_state() for them.
>>>
>>> Not sure that makes more logical sense, but the patch would be simpler I
>>> think.
>>
>> Right, this would avoid adding a new arch dependent function and the 
>> patch
>> will be simpler. This probably makes sense as the stack impact is the 
>> same
>> for all calls (but objtool will use it only for intra-function calls).
>>
> 
> Actually the processing of the ret instruction is more complicated than I
> anticipated with intra-function calls, and so my implementation is not
> complete at the moment.
> 
> The issue is to correctly handle how the ret is going to behave 
> depending how
> the stack (or register on arm) is modified before the ret. Adjusting the 
> stack
> offset makes the stack state correct, but objtool still needs to correctly
> figure out where the ret is going to return and where the code flow 
> continues.
> 

A hint indicating the target "jump" address could be useful. It could be 
used to add the information on some call/jump dynamic that aren't 
associated with jump tables. Currently when objtool finds a jump 
dynamic, if no branches were added to it, it will just return.

Having such a hint could help make additional links (at least on arm64). 
I don't know what Peter and Josh would think of that (if that helps in 
your case of course).

-- 
Julien Thierry

