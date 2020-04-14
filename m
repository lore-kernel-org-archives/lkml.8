Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882E920575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sc/miCdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503987AbgDNS3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:29:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgDNS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:29:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EIAB7L076596;
        Tue, 14 Apr 2020 18:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cimUPVtfjS/Wbbbse4n50p0R0R56tjhdBkxdd46cVqM=;
 b=Sc/miCdLt8x6mNA4jz4sZWit/VDyixzBlI6uaAhsuguWUD7Fy498rQ14g1zoPrzXIx3r
 bCgA6A9uj91TYQwU5RWZsX3Lc3R2l2DoysZ0WMNF9mXoVikSO8+ggv/ph4OH31w6zSfo
 9VIhbkNidopHpnJ5KoOfmJ4ZWqBOkI4rGf3Y7P3cT1CN1HiXsgBPHVJwn2AFyzR3n1sO
 f+Dxrd/EfAqyu/r6iNqdKFS0TuTlKcz2Zz7jPJLAvw+s+fCFukqARmR/wkW3UKVtS6qY
 Je5KdnB23CfEudqUKxRGumDiUpuYSi/9cQafyoLtsyk4ZLibYcBfE1V80Eg+GBww2C19 gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30b5um6kp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:28:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EI7DvV129643;
        Tue, 14 Apr 2020 18:26:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30ctaav76x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 18:26:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EIQnTT010384;
        Tue, 14 Apr 2020 18:26:49 GMT
Received: from linux-1.home (/10.175.33.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 11:26:49 -0700
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
 <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
 <20200414175604.GD2483@worktop.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e9e1c4cd-193f-fd5e-65c4-cc9fb159d861@oracle.com>
Date:   Tue, 14 Apr 2020 20:31:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414175604.GD2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 7:56 PM, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 06:40:12PM +0200, Alexandre Chartre wrote:
>>
>> On 4/14/20 6:16 PM, Peter Zijlstra wrote:
>>> On Tue, Apr 14, 2020 at 12:36:14PM +0200, Alexandre Chartre wrote:
>>>> Add the UNWIND_HINT_RADDR_DELETE and UNWIND_HINT_RADDR_ALTER unwind
>>>> hint macros to flag instructions which remove or modify return
>>>> addresses.
>>>
>>> I'm confused by this thing; why? AFAICT the rest of the patches are
>>> actually simpler without this one.
>>>
>>
>> This is required to indicate to objtool that assembly instructions are
>> changing return addresses. For example, in patch 8:
>>
>> For retpoline:
>>
>> @@ -88,6 +96,7 @@
>>   	lfence
>>   	jmp	.Lspec_trap_\@
>>   .Ldo_rop_\@:
>> +	UNWIND_HINT_RADDR_ALTER
>>   	mov	\reg, (%_ASM_SP)
>>   	ret
>>   .endm
>>
>> The unwind hint indicates that the return address has been altered, so the
>> code won't return to the return address which was on the stack.
> 
> But if you hadn't added that return stack stuff in the first place,
> you'd not have needed that HINT.
> 
> So what actual problem is it solving?
> 

The return stack stuff is here to correctly handle intra-function call so that
we can figure out where the ret of an intra-function call should return. We
don't have this challenge with regular functions because we know that a ret
inside such function just indicates the end of the function.

But when there's an intra-function call, a ret instruction can either:
   - continue after the intra-function call (if the stack was unchanged)
   - jump somewhere else (if the return address was changed) and eventually
     return to the next return address
   - indicate the end of the function (if the return address was removed).

So, all this is needed to correctly follow the flow of the code and properly
record stack changes.

alex.

