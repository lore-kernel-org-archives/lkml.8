Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD3920719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1VPA4l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgDGNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:24:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:24:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DMX9S132958;
        Tue, 7 Apr 2020 13:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HUw+iF3lmkPYdLpCfY3zJ8y3YywDPB2OUxVRgTbL+5w=;
 b=C1VPA4l1iKpGlFUKd75dJWscvpQww4PyN8f9x9/DNZJUSEa/zSlsejjgZg8Q9ejahPNT
 F4t5eyLRrBNLEVd5z5uaP/uRbUOmxMerGjYUKv787gSbdS9HaqZAXix4xpp+dkU9RpAt
 Vnzu1r4/Wk3bC/SpmA+NRMFNV46SKn+F4M6YiqWIhd9jJKhhfYPMOd9PXIDOA2D1J2v1
 Fkw8WYJy33gNqmjLJnz0POpPGBwkp3vbdFry6UFTtLuBsOKDXbPDAE4KyJYlT1+Z23x/
 qK+GyFsvO7WnPe5C2GEC6lFf4bxyv7GoUJcCVhJjoSqiCTzUmcDJdvxxmJbUe+f6WeLX IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 308ffdawqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:23:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DMUSd010700;
        Tue, 7 Apr 2020 13:23:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30839tbkup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:23:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037DNtoV003956;
        Tue, 7 Apr 2020 13:23:56 GMT
Received: from linux-1.home (/10.175.58.13)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 06:23:55 -0700
Subject: Re: [PATCH V2 5/9] objtool: Add support for intra-function calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-6-alexandre.chartre@oracle.com>
 <20200407130729.GZ20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <40b19a8e-ae5e-623e-fb3f-261f9fec2ea5@oracle.com>
Date:   Tue, 7 Apr 2020 15:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407130729.GZ20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 3:07 PM, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 09:31:38AM +0200, Alexandre Chartre wrote:
> 
>> index a62e032863a8..7ee1561bf7ad 100644
>> --- a/tools/objtool/arch/x86/decode.c
>> +++ b/tools/objtool/arch/x86/decode.c
>> @@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
>>   	state->regs[16].base = CFI_CFA;
>>   	state->regs[16].offset = -8;
>>   }
>> +
>> +
>> +void arch_configure_intra_function_call(struct stack_op *op)
>> +{
>> +	/*
>> +	 * For the impact on the stack, make an intra-function
>> +	 * call behaves like a push of an immediate value (the
>> +	 * return address).
>> +	 */
>> +	op->src.type = OP_SRC_CONST;
>> +	op->dest.type = OP_DEST_PUSH;
>> +}
> 
> An alternative is to always set up stack ops for CALL/RET on decode, but
> conditionally run update_insn_state() for them.
> 
> Not sure that makes more logical sense, but the patch would be simpler I
> think.

Right, this would avoid adding a new arch dependent function and the patch
will be simpler. This probably makes sense as the stack impact is the same
for all calls (but objtool will use it only for intra-function calls).

Thanks,

alex.

