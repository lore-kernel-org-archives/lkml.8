Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4052250E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODV/TbzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgGaHBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:01:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45180 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731419AbgGaHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596178863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RG/GMSG5hY2CeM2IJpEsZvrBScs2dfYRmekwad6Ke8k=;
        b=ODV/TbzT5IXpao5+JUxGsp2oMa+pXksS7JjnLQ9TPnB+bvNy0edzlz4XMKGF9NEKEh1c/y
        szFJgXIckgHmE1msgyZ3Tlbguy5VndXGmD4n9I1hY1ZtYqGLYUCXioqUYPKrueGuJFgRvL
        MAfYhfuwCQ261FRjO87iaZ7AtR+9b5w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-qBFxMeToOO-GZ9oDhHP9OQ-1; Fri, 31 Jul 2020 03:01:01 -0400
X-MC-Unique: qBFxMeToOO-GZ9oDhHP9OQ-1
Received: by mail-wr1-f72.google.com with SMTP id v4so8847640wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RG/GMSG5hY2CeM2IJpEsZvrBScs2dfYRmekwad6Ke8k=;
        b=SA9JaysKNVLPiA3Jv9+EkQYh6z1VOeWH2nZT8GRuOiS40csdieyXlky/oQRyN6qdBH
         pKrN0J2Idfj8XeXv1MsF3rEGdPa8UupYw/hJ6EwZAAJP+IHmBNF7gE9PKrvYLLmD8zXo
         QgI+Tgy7luHkMb+1E1bWYxYrH/zNohjmaICYVqsYuUZs3DbaooxoupblX7vY29/pPAwf
         M1ROu/P5ecoG/1LEB0YnmWmLBizejIdyOZXHdJUDJrHpM/z+mYjXJQO285KBY69SuOQc
         ptjYPmZyxjFuItPFB8HQkf3zdxvQBmdvRptCXZF220THDmXAskW9qlVFSmrczcKJiSoE
         8Gqg==
X-Gm-Message-State: AOAM5321vVAII/+3jZEQttt9YnANoWS0Mq+iol6Axd68UshfNNbKyBzO
        uuTVNGEzYzXgzSRbCeZ+gc9K7JBGHWCpM+GuSeZLXDgtuGXZuAL0WrmF0bMfUDNvaI95pmxwuh0
        1FFv1PWjw+k0Yt0fbYXVSLh2W
X-Received: by 2002:a5d:6646:: with SMTP id f6mr2106892wrw.155.1596178860254;
        Fri, 31 Jul 2020 00:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXLMyyQ4Xr0ILUXquInQ8nQDbiyL3LOTLbIfxJsIlHlYVnzeA5yLC0XjZw/lAM8IS+HW+GiA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr2106870wrw.155.1596178860048;
        Fri, 31 Jul 2020 00:01:00 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id b139sm13191578wmd.19.2020.07.31.00.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:00:59 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
Date:   Fri, 31 Jul 2020 08:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730150341.udqnykbw7yfsjvin@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 4:03 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 10:46:52AM +0100, Julien Thierry wrote:
>> The type of unwind hints and the semantics associated with them depend
>> on the architecture. Let arch specific code convert unwind hints into
>> objtool stack state descriptions.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/arch.h            |  5 +--
>>   tools/objtool/arch/x86/decode.c | 54 ++++++++++++++++++++++++++++++
>>   tools/objtool/cfi.h             |  3 +-
>>   tools/objtool/check.c           | 58 +++++----------------------------
>>   tools/objtool/orc_gen.c         |  4 ++-
>>   5 files changed, 71 insertions(+), 53 deletions(-)
>>
>> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
>> index 2e2ce089b0e9..44107e9aab71 100644
>> --- a/tools/objtool/arch.h
>> +++ b/tools/objtool/arch.h
>> @@ -7,12 +7,11 @@
>>   #define _ARCH_H
>>   
>>   #include <stdbool.h>
>> +#include <linux/frame.h>
>>   #include <linux/list.h>
>>   #include "objtool.h"
>>   #include "cfi.h"
>>   
>> -#include <asm/orc_types.h>
>> -
>>   enum insn_type {
>>   	INSN_JUMP_CONDITIONAL,
>>   	INSN_JUMP_UNCONDITIONAL,
>> @@ -86,4 +85,6 @@ unsigned long arch_dest_reloc_offset(int addend);
>>   
>>   const char *arch_nop_insn(int len);
>>   
>> +int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint);
>> +
>>   #endif /* _ARCH_H */
>> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
>> index 1967370440b3..2099809925af 100644
>> --- a/tools/objtool/arch/x86/decode.c
>> +++ b/tools/objtool/arch/x86/decode.c
>> @@ -6,6 +6,8 @@
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   
>> +#include <linux/frame.h>
>> +
>>   #define unlikely(cond) (cond)
>>   #include <asm/insn.h>
>>   #include "../../../arch/x86/lib/inat.c"
>> @@ -15,6 +17,7 @@
>>   #include "../../elf.h"
>>   #include "../../arch.h"
>>   #include "../../warn.h"
>> +#include <asm/orc_types.h>
>>   
>>   static unsigned char op_to_cfi_reg[][2] = {
>>   	{CFI_AX, CFI_R8},
>> @@ -583,3 +586,54 @@ const char *arch_nop_insn(int len)
>>   
>>   	return nops[len-1];
>>   }
>> +
>> +int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint)
>> +{
>> +	struct cfi_reg *cfa = &insn->cfi.cfa;
>> +
>> +	if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
>> +		insn->ret_offset = hint->sp_offset;
>> +		return 0;
>> +	}
>> +
>> +	insn->hint = true;
>> +
>> +	switch (hint->sp_reg) {
>> +	case ORC_REG_UNDEFINED:
>> +		cfa->base = CFI_UNDEFINED;
>> +		break;
>> +	case ORC_REG_SP:
>> +		cfa->base = CFI_SP;
>> +		break;
>> +	case ORC_REG_BP:
>> +		cfa->base = CFI_BP;
>> +		break;
>> +	case ORC_REG_SP_INDIRECT:
>> +		cfa->base = CFI_SP_INDIRECT;
>> +		break;
>> +	case ORC_REG_R10:
>> +		cfa->base = CFI_R10;
>> +		break;
>> +	case ORC_REG_R13:
>> +		cfa->base = CFI_R13;
>> +		break;
>> +	case ORC_REG_DI:
>> +		cfa->base = CFI_DI;
>> +		break;
>> +	case ORC_REG_DX:
>> +		cfa->base = CFI_DX;
>> +		break;
>> +	default:
>> +		WARN_FUNC("unsupported unwind_hint sp base reg %d",
>> +			  insn->sec, insn->offset, hint->sp_reg);
>> +		return -1;
>> +	}
>> +
>> +	cfa->offset = hint->sp_offset;
>> +	insn->cfi.hint_type = hint->type;
>> +	insn->cfi.end = hint->end;
>> +
>> +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
> 
> What does "sp" mean here in sp_only?
>

Stack pointer, like in CFI_SP. When objtool encounters one of these 
hints, it starts to only track the stack frame with the stack pointer 
(no BP, no drap register, no move to temporary registers). Just trying 
to make some sense of this corner case.

>> +		if (arch_decode_insn_hint(insn, hint)) {
>> +			WARN_FUNC("Bad unwind hint", insn->sec, insn->offset);
> 
> No need for a warning here, since the arch-specific function already
> prints one.
> 

Right.

Thanks,

-- 
Julien Thierry

