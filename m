Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D36C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1687D206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCYMxy00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbgDBOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:51:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbgDBOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:51:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032EdbqJ085526;
        Thu, 2 Apr 2020 14:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lfWQ1seaU/IAiXka8+vc6MT9iskGioeScSsheiFp/eM=;
 b=HCYMxy00RiEKwAAMTq3O71H4HPJHIMEZlgADDxKBoTsp5+gkgW52CoiqNpT6bOzbro+P
 E1C31lNliN9gPXs6eGnQLHlxPBR9VgYy3+d4aROCs3V1GuSSQ5sS2Vw7T9PHY53Q0LNL
 mGA1y9V/eac5YrRjqXuEMZay9PsUNfnEPKBgj75gBhfDa4djEjGsBz+ZP1oh2tHLiDxR
 UETKomZOXfVbWAc8fEM8Lk0SHCIwSurzJYlatcowXAP8cNMiNch/Ca6kI83bAnGXagJN
 fg0LJkVBLtJjGaZnWpkpLZhn8E+x23PvJmnsESJtXCmKNXtPUUPbUGRfnUHUMb8uNjSQ Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yunehg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:51:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032EcGld072351;
        Thu, 2 Apr 2020 14:51:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 302ga2jnpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 14:51:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032Epgid007765;
        Thu, 2 Apr 2020 14:51:42 GMT
Received: from linux-1.home (/10.175.46.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 07:51:41 -0700
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
To:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
 <fb382993-ca80-5d77-db99-93d30753e6f4@redhat.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <a30d5b03-3338-3d6c-0968-242d85144028@oracle.com>
Date:   Thu, 2 Apr 2020 16:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fb382993-ca80-5d77-db99-93d30753e6f4@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
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


On 4/2/20 3:38 PM, Julien Thierry wrote:
> 
> 
> On 4/2/20 2:24 PM, Alexandre Chartre wrote:
>>
>>
>> On 4/2/20 2:53 PM, Julien Thierry wrote:
>>> Hi Alexandre,
>>>
>>> I ran into the limitation of intra-function call for the arm64
>>> support but didn't take the time to make a clean patch to support
>>> them properly.
>>>
>>> Nice to see you've gone through that work :) .
>>>
>>> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>>>> Change objtool to support intra-function calls. An intra-function call
>>>> is represented in objtool as a push onto the stack (of the return
>>>
>>> I have to disagree a bit with that. The push onto the stack is true
>>> on x86, but other architectures might not have that (arm/arm64 have a
>>> link register that gets set by "bl" instructions and do not modify
>>> the stack).
>>
>> Correct, this is x86 specific.
>>
>>>
>>>> address), and a jump to the destination address. That way the stack
>>>> information is correctly updated and the call flow is still accurate.
>>>>
>>>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>>> ---
>>>>   tools/objtool/check.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
>>>>   tools/objtool/check.h |  1 +
>>>>   2 files changed, 73 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>>>> index 214809ac2776..0cec91291d46 100644
>>>> --- a/tools/objtool/check.c
>>>> +++ b/tools/objtool/check.c
>>>> @@ -657,6 +657,18 @@ static int add_call_destinations(struct objtool_file *file)
>>>>           if (insn->type != INSN_CALL)
>>>>               continue;
>>>> +        if (insn->intra_function_call) {
>>>> +            dest_off = insn->offset + insn->len + insn->immediate;
>>>> +            insn->jump_dest = find_insn(file, insn->sec, dest_off);
>>>> +            if (insn->jump_dest)
>>>> +                continue;
>>>> +
>>>> +            WARN_FUNC("can't find call dest at %s+0x%lx",
>>>> +                  insn->sec, insn->offset,
>>>> +                  insn->sec->name, dest_off);
>>>> +            return -1;
>>>> +        }
>>>> +
>>>>           rela = find_rela_by_dest_range(insn->sec, insn->offset,
>>>>                              insn->len);
>>>>           if (!rela) {
>>>> @@ -1289,6 +1301,49 @@ static int read_retpoline_hints(struct objtool_file *file)
>>>>       return 0;
>>>>   }
>>>> +static int read_intra_function_call(struct objtool_file *file)
>>>> +{
>>>> +    struct section *sec;
>>>> +    struct instruction *insn;
>>>> +    struct rela *rela;
>>>> +
>>>> +    sec = find_section_by_name(file->elf,
>>>> +                   ".rela.discard.intra_function_call");
>>>
>>> I'm wondering, do we really need to annotate the intra_function_call
>>> and group the in a section?
>>>
>>> Would it be a problem to consider all (static) call instructions with
>>> a destination that is not the start offset of a symbol to be an
>>> intra-function call (and set insn->intra_function_call and
>>> insn->jump_dest accordingly)?
>>
>> Correct, we could automatically detect intra-function calls instead of
>> having to annotate them. However, I choose to annotate them because I don't
>> think that's not an expected construct in a "normal" code flow (at least
>> on x86). So objtool would still issue a warning on intra-function calls
>> by default, and you can annotate them to indicate if they are expected.
>>
>> If intra-function calls are frequent on arm then I can add an option to
>> objtool so it automatically detects them. This way, we won't use the option
>> on x86 and we have to annotate intra-function call on x86, and you can
>> use it on arm to automatically detect intra-function calls.
>>
> 
> That makes sense. Maybe we can just allow them in !file->c_file, I
> don't think gcc generates such call on arm64, so I think we'd only
> have that in assembly.

We can have also intra-function call in C file with the asm directive, for
example with retpoline. Actually I think I forgot to check that as this is
only on 32bit on x86.

> If people prefer to keep the annotation, would you mind having a
> "ANNOTATE_INTRA_FUNCTION_CALL" macro in include/linux/frame.h to add
> the label and the reference to the right section?
>
> This way it could be reused for other archs.

Sure, I will do that.

alex.
  
>>
>>> Other than that the logic would stay the same.
>>>
>>>> +    if (!sec)
>>>> +        return 0;
>>>> +
>>>> +    list_for_each_entry(rela, &sec->rela_list, list) {
>>>> +        if (rela->sym->type != STT_SECTION) {
>>>> +            WARN("unexpected relocation symbol type in %s",
>>>> +                 sec->name);
>>>> +            return -1;
>>>> +        }
>>>> +
>>>> +        insn = find_insn(file, rela->sym->sec, rela->addend);
>>>> +        if (!insn) {
>>>> +            WARN("bad .discard.intra_function_call entry");
>>>> +            return -1;
>>>> +        }
>>>> +
>>>> +        if (insn->type != INSN_CALL) {
>>>> +            WARN_FUNC("intra_function_call not a call",
>>>> +                  insn->sec, insn->offset);
>>>
>>> Nit: This could be slightly confusing with INSN_CALL_DYNAMIC. Maybe just:
>>>      "unsupported instruction for intra-function call " ?
>>
>> Right, I will change that: "intra_function_call not a direct call"
>>
>>>> +            return -1;
>>>> +        }
>>>> +
>>>> +        insn->intra_function_call = true;
>>>> +        /*
>>>> +         * For the impact on the stack, make an intra-function
>>>> +         * call behaves like a push of an immediate value (the
>>>> +         * return address).
>>>> +         */
>>>> +        insn->stack_op.src.type = OP_SRC_CONST;
>>>> +        insn->stack_op.dest.type = OP_DEST_PUSH;
>>>
>>> As commented above, this should be arch dependent.
>>
>> I will add a arch dependent call. I will also do that for the return
>> trampoline call case (patch 4).
>>
> 
> Thank you!
> 
