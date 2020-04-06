Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD82C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0262080C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BgcaXSUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDFIT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:19:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgDFIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:19:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0368EAql138072;
        Mon, 6 Apr 2020 08:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4sx9ij7QMNxt5XRbdtt4DnqueS7Xi00J/FDyBrUqDRc=;
 b=BgcaXSUgxpKMcJdY8/ezBNa7w1RINeCDKMRO5uQvlOEW4iDkmwV+IwhWY5QZWbSSeDfs
 ASgI2z1hR0Giyz64XxOOMe+YinrdZS8FEYPndv+h0r7FlJ98FIP7D5RRXJxa8eZ+e8mE
 scAuJmYESYEFAIrnPLwauC1+Py5oE2mydr+RPp1i3+M8fdU8Dvy2Ba0LToYdfIhoVha3
 +lqQe6ceNgSTotfjrTRzk22hGS3qsLmhrgmCtTamxeASB93E50M3GiHGu4JvAifSrWIP
 tLxLL5stQyKWAn/lozWObxl6cYQRLD2a/eKIsnXZS4cSF2eru9y0J4nqfsY8g48qAcnx PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 306hnqwbx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 08:17:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0368COpk150977;
        Mon, 6 Apr 2020 08:15:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3073xvp07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 08:15:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0368FW2A016144;
        Mon, 6 Apr 2020 08:15:32 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 01:15:32 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
 <20200404142232.wpn7estahnabfy3z@treble>
 <20200404155126.GF20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <27f433a3-6109-9831-5292-3df4155e10fb@oracle.com>
Date:   Mon, 6 Apr 2020 10:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200404155126.GF20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/20 5:51 PM, Peter Zijlstra wrote:
> On Sat, Apr 04, 2020 at 09:22:32AM -0500, Josh Poimboeuf wrote:
>> On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
>>> On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
>>>>> Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
>>>>> work here?
>>>>
>>>> Yes, it would.
>>>
>>> Sorry, I have reconsidered. While it will shut up objtool, it will not
>>> 'work'. That is, the ORC data generated will not correctly unwind.
>>>
>>> I'll try and write a longer email tonight.
>>
>> Right, that's what I've been trying to say.  The ORC data will be
>> non-deterministic unless we unroll the loop.  Or did you mean something
>> else?
> 
> The below should result in deterministic code.
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 07e95dcb40ad..109ee65f4a11 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -59,8 +59,8 @@
>   	jmp	775b;				\
>   774:						\
>   	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	add	$(BITS_PER_LONG/8) * $2, sp;	\
> +	jnz	771b;
>   
>   #ifdef __ASSEMBLY__

Nice. This works fine and allows to remove ANNOTATE_NOSPEC_ALTERNATIVE when
using __FILL_RETURN_BUFFER. However this is probably less performant because
we now have nr/2 add instructions instead of just 1.

Here is a variant where I unroll half of the loop. This way we have 2
add+dec+jnz instruction instructions instead of nr/2 dec+jnz and 1 add
instruction.

#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
	mov	$1, reg;			\
771:						\
	.rept (nr/2);				\
	call	772f;				\
773:	/* speculation trap */			\
	pause;					\
	lfence;					\
	jmp	773b;				\
772:	;					\
	.endr;					\
	add	$(BITS_PER_LONG/8) * (nr/2), sp; \
	dec	reg;				\
	jnz	771b;


Note that we can't unroll the entire loop: it won't work with nr=32 because
the code is then too large to fit into an alternative (the alternative size
is encoded on only one byte so this allows a maximum size of 255, while with
nr=32 the size is around 390).

alex.
