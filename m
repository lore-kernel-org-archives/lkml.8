Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55DA20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnA+CeS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbgDBNit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:38:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32055 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388520AbgDBNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5Y5+3LAZfEoxMNhr+FKlyAHig3oUUM0JOH/x4EvsOc=;
        b=dnA+CeS5ukJ3I4X8qIIAfhfOpoDYlPQG9TCNNob2yLlKqcgDVRfu7USMsFc8fe6bs3yaLc
        gDqFmkU509ZaTV5QFiMOYU8ImWXjuEzDER1K0bHNaVvIJqFeRPI6NaRUuXBSwug7vxUcNI
        XZv2aSjjTy0m7zw3Gfhvs95d6HiLL14=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-FGFnEw1WNfqOB3cUBceDWQ-1; Thu, 02 Apr 2020 09:38:46 -0400
X-MC-Unique: FGFnEw1WNfqOB3cUBceDWQ-1
Received: by mail-wr1-f69.google.com with SMTP id y1so1498850wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5Y5+3LAZfEoxMNhr+FKlyAHig3oUUM0JOH/x4EvsOc=;
        b=FH2MakGLsyQ7rA/JBVzzq9OMKXUHFKLgpSZReZABcGnORPCzqw9oXg6x6rJRGWmzUe
         Q/rdNdKwDmMYNwpF5nDZgT4RnF1dxJFKwGfhhxCB161hXxWoVjemVcE6DzRlLU0n8+Ch
         Gjj0jNVOBGaRld6Eosf5keF70SFv+yFUvJ4W1mxOrpNmUkTqkG8+3aWo7LuYhtjPJglR
         8/yE+gZIb+lplT/05sO/CrgFxkwcYM0UqG4oa5MQrMG4SKnI8qWnIxsNF22FdFI9TYwy
         BaUkwJv60PK1L6+xB7DnTkeYgEfBLs6J5yHZ8swEeH58WPIK2G9JCeaGAmozoJHneA0b
         L0cg==
X-Gm-Message-State: AGi0Pua2FEYHwh6pdlIp+4HYoO9wWQD1my57Vz5K6BB9PgJt+LvAp0rP
        pg8/LwiGVw/Ewb7Z/bTDfU+xM/YSwtDI6eRHj8arPoihnsAb0tt4HLSADSaL9exXWZhbm6BLqr0
        RLjqEQ2zeGJPb40Kv8HezY6/p
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr1972784wme.176.1585834723978;
        Thu, 02 Apr 2020 06:38:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypJsP32e+OrbAjcLobr4Z86BLIwLJWgz/rSrVaqy2pCVen/XB/YhWMP7/UfFR31v3M++wmhslg==
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr1972758wme.176.1585834723698;
        Thu, 02 Apr 2020 06:38:43 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id j188sm7492993wmj.36.2020.04.02.06.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:38:42 -0700 (PDT)
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <fb382993-ca80-5d77-db99-93d30753e6f4@redhat.com>
Date:   Thu, 2 Apr 2020 14:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 2:24 PM, Alexandre Chartre wrote:
> 
> 
> On 4/2/20 2:53 PM, Julien Thierry wrote:
>> Hi Alexandre,
>>
>> I ran into the limitation of intra-function call for the arm64
>> support but didn't take the time to make a clean patch to support
>> them properly.
>>
>> Nice to see you've gone through that work :) .
>>
>> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>>> Change objtool to support intra-function calls. An intra-function call
>>> is represented in objtool as a push onto the stack (of the return
>>
>> I have to disagree a bit with that. The push onto the stack is true
>> on x86, but other architectures might not have that (arm/arm64 have a
>> link register that gets set by "bl" instructions and do not modify
>> the stack).
> 
> Correct, this is x86 specific.
> 
>>
>>> address), and a jump to the destination address. That way the stack
>>> information is correctly updated and the call flow is still accurate.
>>>
>>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>> ---
>>>   tools/objtool/check.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
>>>   tools/objtool/check.h |  1 +
>>>   2 files changed, 73 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>>> index 214809ac2776..0cec91291d46 100644
>>> --- a/tools/objtool/check.c
>>> +++ b/tools/objtool/check.c
>>> @@ -657,6 +657,18 @@ static int add_call_destinations(struct 
>>> objtool_file *file)
>>>           if (insn->type != INSN_CALL)
>>>               continue;
>>> +        if (insn->intra_function_call) {
>>> +            dest_off = insn->offset + insn->len + insn->immediate;
>>> +            insn->jump_dest = find_insn(file, insn->sec, dest_off);
>>> +            if (insn->jump_dest)
>>> +                continue;
>>> +
>>> +            WARN_FUNC("can't find call dest at %s+0x%lx",
>>> +                  insn->sec, insn->offset,
>>> +                  insn->sec->name, dest_off);
>>> +            return -1;
>>> +        }
>>> +
>>>           rela = find_rela_by_dest_range(insn->sec, insn->offset,
>>>                              insn->len);
>>>           if (!rela) {
>>> @@ -1289,6 +1301,49 @@ static int read_retpoline_hints(struct 
>>> objtool_file *file)
>>>       return 0;
>>>   }
>>> +static int read_intra_function_call(struct objtool_file *file)
>>> +{
>>> +    struct section *sec;
>>> +    struct instruction *insn;
>>> +    struct rela *rela;
>>> +
>>> +    sec = find_section_by_name(file->elf,
>>> +                   ".rela.discard.intra_function_call");
>>
>> I'm wondering, do we really need to annotate the intra_function_call
>> and group the in a section?
>>
>> Would it be a problem to consider all (static) call instructions with
>> a destination that is not the start offset of a symbol to be an
>> intra-function call (and set insn->intra_function_call and
>> insn->jump_dest accordingly)?
> 
> Correct, we could automatically detect intra-function calls instead of
> having to annotate them. However, I choose to annotate them because I don't
> think that's not an expected construct in a "normal" code flow (at least
> on x86). So objtool would still issue a warning on intra-function calls
> by default, and you can annotate them to indicate if they are expected.
> 
> If intra-function calls are frequent on arm then I can add an option to
> objtool so it automatically detects them. This way, we won't use the option
> on x86 and we have to annotate intra-function call on x86, and you can
> use it on arm to automatically detect intra-function calls.
> 

That makes sense. Maybe we can just allow them in !file->c_file, I don't 
think gcc generates such call on arm64, so I think we'd only have that 
in assembly.

If people prefer to keep the annotation, would you mind having a 
"ANNOTATE_INTRA_FUNCTION_CALL" macro in include/linux/frame.h to add the 
label and the reference to the right section?
This way it could be reused for other archs.

> 
>> Other than that the logic would stay the same.
>>
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
>>> +            WARN("bad .discard.intra_function_call entry");
>>> +            return -1;
>>> +        }
>>> +
>>> +        if (insn->type != INSN_CALL) {
>>> +            WARN_FUNC("intra_function_call not a call",
>>> +                  insn->sec, insn->offset);
>>
>> Nit: This could be slightly confusing with INSN_CALL_DYNAMIC. Maybe just:
>>      "unsupported instruction for intra-function call " ?
> 
> Right, I will change that: "intra_function_call not a direct call"
> 
>>> +            return -1;
>>> +        }
>>> +
>>> +        insn->intra_function_call = true;
>>> +        /*
>>> +         * For the impact on the stack, make an intra-function
>>> +         * call behaves like a push of an immediate value (the
>>> +         * return address).
>>> +         */
>>> +        insn->stack_op.src.type = OP_SRC_CONST;
>>> +        insn->stack_op.dest.type = OP_DEST_PUSH;
>>
>> As commented above, this should be arch dependent.
> 
> I will add a arch dependent call. I will also do that for the return
> trampoline call case (patch 4).
> 

Thank you!

-- 
Julien Thierry

