Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F53C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C2206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIhgZV01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390313AbgDCIBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:01:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbgDCIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585900911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsBzvnpYz4f+Oue6jUVYPkRL5iE2RlTfH/8UEWbiijA=;
        b=WIhgZV01KuWnd2s6Bkd0k3BkeZCcSgA9Jm5OnbiT7nnCwQtt0yiYdk7/0sxi+xCH+2Bdfm
        8AvxWDixbAMMzEvM+WRLOhi0oKcR+4uWLAsPtIbt0FArJsujb3vr3DBbiXtCxrlqU48EAw
        IxlOacrm7Woz0gb0TYYyWgg51sKMLzo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-SkzrbWYBPh2vvz2ASvwFYQ-1; Fri, 03 Apr 2020 04:01:49 -0400
X-MC-Unique: SkzrbWYBPh2vvz2ASvwFYQ-1
Received: by mail-wm1-f71.google.com with SMTP id t65so2456745wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lsBzvnpYz4f+Oue6jUVYPkRL5iE2RlTfH/8UEWbiijA=;
        b=k3OAWtPPTdRVGw2fu0x4hZosWka6TOHZ89sySZTK36N2c0zurL/mfS8pUSgQG1Fxij
         jbzAP9KCke8cXuR8UDuBmtc166gVDGOXvrylTZlhmn97wJkALNu2whh7+KOtibdXcfRf
         QAorBVKkD0CiPb8OH9U1NoZfIRvDe9EZtABVlc3HlpsytWH3uyxqGZGdakg75tKCqLQb
         ylN7B8y9p3t4pptiyYjSNcgDV7lZRjVSoR9KSCYBPfuVQOKl7P0crT+qWLPPXiOxpk3A
         r9yJ6hOL/tVM1EnKiDFsHMRum9SWE9hicesHYdntjx9ylASFDt+uhu2hHkg82MqKdjNB
         O0kg==
X-Gm-Message-State: AGi0PuaAILCavouw6hkEE75s2u4SH7nzPC3JnN1Lmru2LY6yoUfAYxxF
        Hqm3CU3yHdYyt+vu7MqmphPNsDIdtouDEW+cjC+N4JLOEkMR0EJRS7XyijeTBCrjyMFJoixGDQq
        n89Uv2OjbxNnmYgxz2HmXA/QJ
X-Received: by 2002:a5d:40ce:: with SMTP id b14mr1588280wrq.414.1585900908394;
        Fri, 03 Apr 2020 01:01:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJQVFGdWtp3aWk3Dg5yEbOAfGHh4/ffY0mjzN0BPu586loesXwLM2se4u++rDlWKus3co2LFg==
X-Received: by 2002:a5d:40ce:: with SMTP id b14mr1588262wrq.414.1585900908157;
        Fri, 03 Apr 2020 01:01:48 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id d18sm11437380wrn.9.2020.04.03.01.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:01:47 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] objtool: Support multiple stack_op per
 instruction
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-11-jthierry@redhat.com>
 <20200402175426.77houvk46xhcxxmn@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3b3f07b3-172b-0560-96c7-d9386e3cab23@redhat.com>
Date:   Fri, 3 Apr 2020 09:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402175426.77houvk46xhcxxmn@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 6:54 PM, Josh Poimboeuf wrote:
> On Fri, Mar 27, 2020 at 03:28:47PM +0000, Julien Thierry wrote:
>> @@ -127,6 +129,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>>   	if (insn.sib.nbytes)
>>   		sib = insn.sib.bytes[0];
>>   
>> +	op = calloc(1, sizeof(*op));
>> +	if (!op)
>> +		return -1;
>> +
> 
> Why not malloc()?
> 

It's just that previsously, stack_op was part of the instruction 
structure and was initialized to all 0 in decode_instructions(). Now 
that it's created here, I assumed it would be better to have the same 
thing here and initialized the new stack_op to all 0.

Do you prefer to have an explicit malloc() + memset()?

>> +static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
>> +{
>> +	struct stack_op *op;
>> +
>> +	list_for_each_entry(op, &insn->stack_ops, list) {
>> +		int res;
>> +
>> +		res = update_insn_state(insn, state, op);
>> +		if (res)
>> +			return res;
> 
> This should probably be like:
> 
> 		if (update_insn_state(insn, state, op))
> 			return 1;
> 
> That way the error codes are converted to non-fatal warnings like before
> (which I admit is confusing...)
> 

Right, I'll change this.

>> @@ -2205,29 +2244,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>   			return 0;
>>   
>>   		case INSN_STACK:
>> -			if (update_insn_state(insn, &state))
>> +			if (handle_insn_ops(insn, &state))
>>   				return 1;
> 
> How about "handle_stack_ops"?
> 

Works for me!

Thanks,

-- 
Julien Thierry

