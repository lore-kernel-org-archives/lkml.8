Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B349C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB52051A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kV/HOgs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDHOET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:04:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgDHOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:04:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038Dw6X1087445;
        Wed, 8 Apr 2020 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hWI6KSBJwhLBPRk58QK/JNaKG+agLjuCHca2NgnWmtI=;
 b=kV/HOgs3XEXgeSot3ajlmAUJGkvf3xT/Zf0t0BerQVQ+0s3KEm4tg6TqPsmpSsIM0HVC
 8JLJLnIh9Ei1/mnO1hwoXtdDpRxW/VgHTGWrBRBV4qj42oq76/Y3QmGZYYIIX8OiIuyE
 jRlCdbZ3T7UmIeorA85EY3U/d5MfnDxRtbac6yC1ABt03qaXTzQMKnGRbBz1YJKqdoaZ
 rKPO3yOavaIewE3vuLsWs+JgBNhsRafqdjPHFqnc16+maF5GJ3A2+o/JTFsA4XKpE/+J
 fZnnZs0UB4cSIU6EHZA+3I2mA8CKrz/l4nt9VUW64JXsae6DqQMWAkOnR52glrD/EnrA sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3091m3br14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 14:03:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038DuYkf107015;
        Wed, 8 Apr 2020 14:01:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3099v92rv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 14:01:55 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 038E1qLg002863;
        Wed, 8 Apr 2020 14:01:53 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 07:01:52 -0700
Subject: Re: [PATCH V2 5/9] objtool: Add support for intra-function calls
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-6-alexandre.chartre@oracle.com>
 <20200407130729.GZ20730@hirez.programming.kicks-ass.net>
 <40b19a8e-ae5e-623e-fb3f-261f9fec2ea5@oracle.com>
Message-ID: <7ba6d4c9-c1dc-fa83-2ade-b7d3fba9e7fb@oracle.com>
Date:   Wed, 8 Apr 2020 16:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <40b19a8e-ae5e-623e-fb3f-261f9fec2ea5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/20 3:28 PM, Alexandre Chartre wrote:
> 
> On 4/7/20 3:07 PM, Peter Zijlstra wrote:
>> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
>>
>>> index a62e032863a8..7ee1561bf7ad 100644
>>> --- a/tools/objtool/arch/x86/decode.c
>>> +++ b/tools/objtool/arch/x86/decode.c
>>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
>>>       state->regs[16].base = CFI_CFA;
>>>       state->regs[16].offset = -8;
>>>   }
>>> +
>>> +
>>> +void arch_configure_intra_function_call(struct stack_op *op)
>>> +{
>>> +    /*
>>> +     * For the impact on the stack, make an intra-function
>>> +     * call behaves like a push of an immediate value (the
>>> +     * return address).
>>> +     */
>>> +    op->src.type = OP_SRC_CONST;
>>> +    op->dest.type = OP_DEST_PUSH;
>>> +}
>>
>> An alternative is to always set up stack ops for CALL/RET on decode, but
>> conditionally run update_insn_state() for them.
>>
>> Not sure that makes more logical sense, but the patch would be simpler I
>> think.
> 
> Right, this would avoid adding a new arch dependent function and the patch
> will be simpler. This probably makes sense as the stack impact is the same
> for all calls (but objtool will use it only for intra-function calls).
> 

Actually the processing of the ret instruction is more complicated than I
anticipated with intra-function calls, and so my implementation is not
complete at the moment.

The issue is to correctly handle how the ret is going to behave depending how
the stack (or register on arm) is modified before the ret. Adjusting the stack
offset makes the stack state correct, but objtool still needs to correctly
figure out where the ret is going to return and where the code flow continues.

alex.
