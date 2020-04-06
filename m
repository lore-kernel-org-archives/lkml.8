Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F89C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BD5206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DIRb3j5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDFK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:59:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40226 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:59:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036AwtAp000826;
        Mon, 6 Apr 2020 10:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KZEr6EIzr1OQIdpVcJJGHW4pz4erth0s9VrWc1Y3tBM=;
 b=DIRb3j5+SZpmRrsPf6gnChovNw87rQWEqqfhf4LlR7M9XO6ZtR9YnxzdFQx6vSWrDfxX
 5ihFml08eFNiAGjsJpjbefy3kqLtcdP9mO8XzwFaN9Hbd9TsoSvkk/IU4jFkhQqydzZu
 T7hND+CfdJfAaUym9yLdPl6JVd0lH+vtglY1TTiO7YsusAZPZhcdwmY8h1jVuqbo8nXg
 OlgLk4hsdd9QrqdAziHSE8ppb9yfZZMwyauF+M9RwW2ri2s16EX196OQnrOXmwc3eXEe
 sax4W0B9FDQGA0jtgECOWFlaBb8p9O2qGp7o2yGoHvEfU1Hy2nmqburtCmf24d+3AT/h rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 306j6m6446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 10:59:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036AuZ76129318;
        Mon, 6 Apr 2020 10:59:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3073spq3hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 10:59:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036AxBPC001114;
        Mon, 6 Apr 2020 10:59:12 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 03:59:11 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
 <20200404142232.wpn7estahnabfy3z@treble>
 <20200404155126.GF20730@hirez.programming.kicks-ass.net>
 <27f433a3-6109-9831-5292-3df4155e10fb@oracle.com>
 <20200406093143.GH20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <0e8e9c1f-e03b-207e-a527-cf8deddf82a0@oracle.com>
Date:   Mon, 6 Apr 2020 13:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200406093143.GH20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/20 11:31 AM, Peter Zijlstra wrote:
> On Mon, Apr 06, 2020 at 10:19:56AM +0200, Alexandre Chartre wrote:
>>
>> On 4/4/20 5:51 PM, Peter Zijlstra wrote:
>>> On Sat, Apr 04, 2020 at 09:22:32AM -0500, Josh Poimboeuf wrote:
>>>> On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
>>>>> On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
>>>>>> On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
>>>>>>> Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
>>>>>>> work here?
>>>>>>
>>>>>> Yes, it would.
>>>>>
>>>>> Sorry, I have reconsidered. While it will shut up objtool, it will not
>>>>> 'work'. That is, the ORC data generated will not correctly unwind.
>>>>>
>>>>> I'll try and write a longer email tonight.
>>>>
>>>> Right, that's what I've been trying to say.  The ORC data will be
>>>> non-deterministic unless we unroll the loop.  Or did you mean something
>>>> else?
>>>
>>> The below should result in deterministic code.
>>>
>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>>> index 07e95dcb40ad..109ee65f4a11 100644
>>> --- a/arch/x86/include/asm/nospec-branch.h
>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>> @@ -59,8 +59,8 @@
>>>    	jmp	775b;				\
>>>    774:						\
>>>    	dec	reg;				\
>>> -	jnz	771b;				\
>>> -	add	$(BITS_PER_LONG/8) * nr, sp;
>>> +	add	$(BITS_PER_LONG/8) * $2, sp;	\
>>> +	jnz	771b;
>>>    #ifdef __ASSEMBLY__
>>
>> Nice. This works fine and allows to remove ANNOTATE_NOSPEC_ALTERNATIVE when
>> using __FILL_RETURN_BUFFER. However this is probably less performant because
>> we now have nr/2 add instructions instead of just 1.
> 
> Does it actually matter though? That is, can you measure the difference?
> 

I didn't do any measurement, I am just anticipating concerns others might have
as this code is used during context and vmexit. But I agree this might not be
significant.

alex.
