Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F4C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBDC20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+u35FCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgDHRCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:02:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:02:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038GiK8A006124;
        Wed, 8 Apr 2020 17:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GshGcmCnGXv2TPPk+GwNOUIRVp630NDUfDDIIOCKVHc=;
 b=n+u35FCI0hx43Rxjlfy95ZAg1ufqdR8IllKkOcSU/bV3160OqBBRLUFJrVue7mOWw5Uw
 uKraEcz3IrJ1MTdpOyoi+qPfwp//fYnn6v2wxaRjejn5aSP8P6bCpGzJ4N+RxsTP5SP9
 9GuTGydXGzK+enQoexaUJzU0rYVTJZK5UJRPUCtHnhsHoRZ2XyvbV+9/czmqXdblEx/p
 YLnC+3nVc+dHZSg7avWqV59MmDjG05J15q32KlL4pkeUR2OmCLru5DX0N/DGLeDU7X8g
 m32MSOmZhjUpHJ4YWZQ0U3s+3fstr4+AyBGWyFPyl90sgh1pDxrXDsFRn9F4g1lKUNyq QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3091m3cu09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 17:02:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038GfnnG116661;
        Wed, 8 Apr 2020 17:02:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3091m4h2aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 17:02:27 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 038H2N4H004712;
        Wed, 8 Apr 2020 17:02:23 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 10:02:23 -0700
Subject: Re: [PATCH V2 5/9] objtool: Add support for intra-function calls
To:     Julien Thierry <jthierry@redhat.com>,
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <69cf35b5-8c65-3602-3f03-3eeb42241f33@oracle.com>
Date:   Wed, 8 Apr 2020 19:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <981d7f79-3429-776f-7356-345adc6332bf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 6:04 PM, Julien Thierry wrote:
> 
> 
> On 4/8/20 5:03 PM, Alexandre Chartre wrote:
>>
>>
>> On 4/8/20 4:19 PM, Julien Thierry wrote:
>>>
>>>
>>> On 4/8/20 3:06 PM, Alexandre Chartre wrote:
>>>>
>>>>
>>>> On 4/7/20 3:28 PM, Alexandre Chartre wrote:
>>>>>
>>>>> On 4/7/20 3:07 PM, Peter Zijlstra wrote:
>>>>>> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
>>>>>>
>>>>>>> index a62e032863a8..7ee1561bf7ad 100644
>>>>>>> --- a/tools/objtool/arch/x86/decode.c
>>>>>>> +++ b/tools/objtool/arch/x86/decode.c
>>>>>>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
>>>>>>>       state->regs[16].base = CFI_CFA;
>>>>>>>       state->regs[16].offset = -8;
>>>>>>>   }
>>>>>>> +
>>>>>>> +
>>>>>>> +void arch_configure_intra_function_call(struct stack_op *op)
>>>>>>> +{
>>>>>>> +    /*
>>>>>>> +     * For the impact on the stack, make an intra-function
>>>>>>> +     * call behaves like a push of an immediate value (the
>>>>>>> +     * return address).
>>>>>>> +     */
>>>>>>> +    op->src.type = OP_SRC_CONST;
>>>>>>> +    op->dest.type = OP_DEST_PUSH;
>>>>>>> +}
>>>>>>
>>>>>> An alternative is to always set up stack ops for CALL/RET on decode, but
>>>>>> conditionally run update_insn_state() for them.
>>>>>>
>>>>>> Not sure that makes more logical sense, but the patch would be simpler I
>>>>>> think.
>>>>>
>>>>> Right, this would avoid adding a new arch dependent function and the patch
>>>>> will be simpler. This probably makes sense as the stack impact is the same
>>>>> for all calls (but objtool will use it only for intra-function calls).
>>>>>
>>>>
>>>> Actually the processing of the ret instruction is more complicated than I
>>>> anticipated with intra-function calls, and so my implementation is not
>>>> complete at the moment.
>>>>
>>>> The issue is to correctly handle how the ret is going to behave depending how
>>>> the stack (or register on arm) is modified before the ret. Adjusting the stack
>>>> offset makes the stack state correct, but objtool still needs to correctly
>>>> figure out where the ret is going to return and where the code flow continues.
>>>>
>>>
>>> A hint indicating the target "jump" address could be useful. It could
>>> be used to add the information on some call/jump dynamic that aren't
>>> associated with jump tables. Currently when objtool finds a jump
>>> dynamic, if no branches were added to it, it will just return.
>>>
>>> Having such a hint could help make additional links (at least on
>>> arm64). I don't know what Peter and Josh would think of that (if that
>>> helps in your case of course).
>>>
>>
>> Yes, I am thinking about tracking intra-function call return address,
>> and having hints to specify a return address changes. For example,
>> on x86, when we push the branch address on the stack we overwrite the
>> last return address (the return address of the last intra-function call).
>> Then the return instruction can figure out where to branch.
> 
> I see, I was thinking about a more generic hint, that would just
> indicate "this instruction actually jumps here". So in your case it
> would just point that a certain return instruction causes to branch
> somewhere.

I thought about doing that but the problem is that on x86 the same
retpoline code can branch differently depending on how it is used.
Basically we have a return instruction that will branch differently
based on what's on the stack. So we can just tell that this ret
instruction will branch/return there.

alex.

> This way the hint could also be used for other instructions (e.g.
> INSN_JUMP_DYNAMIC).
> 
> 
> 
