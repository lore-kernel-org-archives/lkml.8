Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C59C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16132073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="om2AiJld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgDBOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:42:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbgDBOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:42:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032EdbpD085526;
        Thu, 2 Apr 2020 14:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gVIIDzXBEkOdIqFJMswdahombVaA8LnmmRPQy7mZ1/g=;
 b=om2AiJld2KPFAoxN2lmMAFH4rRuZ+zOQaLaWpZrkE96ueN4LVB14XpEhFb/NRsBBIaUh
 kqmKxnyguYc5i+WnWyHmyLmhdO9Txw/O0TOI6bB9ml43NZWm8mzufubF7SULB7jwWZWR
 VLsxEHgRWOfND1S36asMrj/E5HMfwwGEmGU/FRd5bKOQ7BAR0IzaEihT0hpAytFX8DzQ
 zp0vSjKAxrFnIAskJSv1vdQ7CcI1aXZA2U6Ph+i8bIw0O7mci52t4U8AXxJnoA/UeiBH
 I+V7RcjHa6SsgAFm/+ZQb8+vSCGuOQ1kzXYtZvdmduVl5+peow17uf0my7OckXRYq/eh pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yunefgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:41:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032EcTNt012106;
        Thu, 2 Apr 2020 14:41:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 302g4vna3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:41:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 032EfmXC003013;
        Thu, 2 Apr 2020 14:41:48 GMT
Received: from linux-1.home (/10.175.46.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 07:41:48 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
Date:   Thu, 2 Apr 2020 16:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 3:26 PM, Julien Thierry wrote:
> Hi Alexandre,
> 
> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>> With retpoline, the return instruction is used to branch to an address
>> stored on the stack. So, unlike a regular return instruction, when a
>> retpoline return instruction is reached the stack has been modified
>> compared to what we have when the function was entered.
>>
>> Provide the mechanism to explicitly call-out such return instruction
>> so that objtool can correctly handle them.
>>
>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> ---
>>   tools/objtool/check.c | 78 +++++++++++++++++++++++++++++++++++++++++--
>>   tools/objtool/check.h |  1 +
>>   2 files changed, 76 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 0cec91291d46..ed8e3ea1d8da 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -1344,6 +1344,48 @@ static int read_intra_function_call(struct objtool_file *file)
>>       return 0;
>>   }
>> +static int read_retpoline_ret(struct objtool_file *file)
>> +{
>> +    struct section *sec;
>> +    struct instruction *insn;
>> +    struct rela *rela;
>> +
>> +    sec = find_section_by_name(file->elf, ".rela.discard.retpoline_ret");
>> +    if (!sec)
>> +        return 0;
>> +
>> +    list_for_each_entry(rela, &sec->rela_list, list) {
>> +        if (rela->sym->type != STT_SECTION) {
>> +            WARN("unexpected relocation symbol type in %s",
>> +                 sec->name);
>> +            return -1;
>> +        }
>> +
>> +        insn = find_insn(file, rela->sym->sec, rela->addend);
>> +        if (!insn) {
>> +            WARN("bad .discard.retpoline_ret entry");
>> +            return -1;
>> +        }
>> +
>> +        if (insn->type != INSN_RETURN) {
>> +            WARN_FUNC("retpoline_ret not a return",
>> +                  insn->sec, insn->offset);
>> +            return -1;
>> +        }
>> +
>> +        insn->retpoline_ret = true;
>> +        /*
>> +         * For the impact on the stack, make a return trampoline
>> +         * behaves like a pop of the return address.
>> +         */
>> +        insn->stack_op.src.type = OP_SRC_POP;
>> +        insn->stack_op.dest.type = OP_DEST_REG;
>> +        insn->stack_op.dest.reg = CFI_RA;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static void mark_rodata(struct objtool_file *file)
>>   {
>>       struct section *sec;
>> @@ -1403,6 +1445,10 @@ static int decode_sections(struct objtool_file *file)
>>       if (ret)
>>           return ret;
>> +    ret = read_retpoline_ret(file);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = add_call_destinations(file);
>>       if (ret)
>>           return ret;
>> @@ -1432,7 +1478,8 @@ static bool is_fentry_call(struct instruction *insn)
>>       return false;
>>   }
>> -static bool has_modified_stack_frame(struct insn_state *state)
>> +static bool has_modified_stack_frame(struct insn_state *state,
>> +                     bool check_registers)
>>   {
>>       int i;
>> @@ -1442,6 +1489,9 @@ static bool has_modified_stack_frame(struct insn_state *state)
>>           state->drap)
>>           return true;
>> +    if (!check_registers)
>> +        return false;
>> +
>>       for (i = 0; i < CFI_NUM_REGS; i++)
>>           if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>>               state->regs[i].offset != initial_func_cfi.regs[i].offset)
>> @@ -1987,7 +2037,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
>>   static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
>>   {
>> -    if (has_modified_stack_frame(state)) {
>> +    if (has_modified_stack_frame(state, true)) {
>>           WARN_FUNC("sibling call from callable instruction with modified stack frame",
>>                   insn->sec, insn->offset);
>>           return 1;
>> @@ -2009,6 +2059,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>       struct alternative *alt;
>>       struct instruction *insn, *next_insn;
>>       struct section *sec;
>> +    bool check_registers;
>>       u8 visited;
>>       int ret;
>> @@ -2130,7 +2181,28 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>                   return 1;
>>               }
>> -            if (func && has_modified_stack_frame(&state)) {
>> +            /*
>> +             * With retpoline, the return instruction is used
>> +             * to branch to an address stored on the stack.
>> +             * So when we reach the ret instruction, the stack
>> +             * frame has been modified with the address to
>> +             * branch to and we need update the stack state.
>> +             *
>> +             * The retpoline address to branch to is typically
>> +             * pushed on the stack from a register, but this
>> +             * confuses the logic which checks callee saved
>> +             * registers. So we don't check if registers have
>> +             * been modified if we have a return trampoline.
> 
> I think there are two different things to consider here.
> 
> First, the update of the stack frame which I believe should be done
> when returning from intra_function_calls, as it undoes what the call
> instruction did (push more stuff on the stack in the case of x86).

The problem is that an intra-function call is not necessarily going
to return. With retpoline (or RSB stuffing) intra-function calls are
basically fake calls only present to fill the RSB buffer. Such calls
won't return, the stack pointer is just adjusted to cancel the impact
of these calls on the stack.

> This might mean that intra_function_call should be part of the state
> (as intra_function_calls pass a modified state to validate_branch()).
> 
> Second is supporting retpoline_ret which is just accepting that the
> return address in the stack frame has changed.
With retpoline_ret, the stack just has an extra address we are going to
jump to (this will be like an indirect jump). If we remove that extra
address from the stack, we should have the regular stack we have at
the end of a function. This is precisely what the code is doing here.

alex.

>> +             */
>> +            if (insn->retpoline_ret) {
>> +                update_insn_state(insn, &state);
>> +                check_registers = false;
>> +            } else {
>> +                check_registers = true;
>> +            }
>> +
>> +            if (func && has_modified_stack_frame(&state,
>> +                                 check_registers)) {
>>                   WARN_FUNC("return with modified stack frame",
>>                         sec, insn->offset);
>>                   return 1;
>> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
>> index 2bd6d2f46baa..5ecd16ad71a8 100644
>> --- a/tools/objtool/check.h
>> +++ b/tools/objtool/check.h
>> @@ -37,6 +37,7 @@ struct instruction {
>>       bool dead_end, ignore, hint, save, restore, ignore_alts;
>>       bool intra_function_call;
>>       bool retpoline_safe;
>> +    bool retpoline_ret;
>>       u8 visited;
>>       struct symbol *call_dest;
>>       struct instruction *jump_dest;
>>
> 
> Cheers,
> 
