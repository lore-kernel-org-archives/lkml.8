Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F80C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEB206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f+Yj3W5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbgDCRNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:13:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:13:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033HCo7R182205;
        Fri, 3 Apr 2020 17:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uGbUpFfl0qVTnP9ktxreBx1NL/9h1m1x3Y14q+I9Ovw=;
 b=f+Yj3W5Q7pu8Ol8VJgiEztivPc8ZMzWu1dqObv8BEJa5DEfjSkSrV6mTEdzHl7LNSm7C
 tqm3Sy8ImGXcOBRSJwLVoylLbhPonOA2L130p6Xb2Ba7e6lxwRNt0mcaQ9W7KaC9PG55
 OvSrLVw8zm00vNmZdCqVumg7v4FQOasYi5gSNY1z7n6g3sQjMWC3P/9UgJYFVO+4EU8S
 ksKG+goGYr3x1l/LIdWYhECW+3N6yeXCcEgFvSIM9qO8/joO9+qIvLBfUkJFtg55S4+N
 8lbag/v41wOdbPtqgLKbienzVLb32XI3BpjCz8MG9sRNNPnVog/ar1g7+Mc+PVhS4PRz 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqj2rnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 17:12:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033H7AXP181933;
        Fri, 3 Apr 2020 17:10:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2nj7yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 17:10:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033HAkii021843;
        Fri, 3 Apr 2020 17:10:46 GMT
Received: from linux-1.home (/92.157.90.160) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Fri, 03 Apr 2020 10:10:30 -0700
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <2c615bae-6002-80b7-493d-b24ec48f69c9@oracle.com>
Date:   Fri, 3 Apr 2020 10:14:49 -0700 (PDT)
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
 <20200403160538.qwu237amhanr6pyi@treble>
 <20200403161607.jxz6duaz7dud22wf@treble>
In-Reply-To: <20200403161607.jxz6duaz7dud22wf@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 6:16 PM, Josh Poimboeuf wrote:
> On Fri, Apr 03, 2020 at 11:05:38AM -0500, Josh Poimboeuf wrote:
>> On Thu, Apr 02, 2020 at 10:22:18AM +0200, Alexandre Chartre wrote:
>>>   .macro RETPOLINE_JMP reg:req
>>> -	call	.Ldo_rop_\@
>>> +	INTRA_FUNCTION_CALL .Ldo_rop_\@
>>>   .Lspec_trap_\@:
>>>   	pause
>>>   	lfence
>>> @@ -102,7 +116,7 @@
>>>   .Ldo_retpoline_jmp_\@:
>>>   	RETPOLINE_JMP \reg
>>>   .Ldo_call_\@:
>>> -	call	.Ldo_retpoline_jmp_\@
>>> +	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
>>>   .endm
>>
>> There's a catch: this is part of an alternative.  Which means if
>> X86_FEATURE_RETPOLINE isn't set at runtime, then the retpoline won't be
>> there and the ORC data will be wrong.
>>
>> In fact objtool should probably be made smart enough to warn about this
>> situation, when an alternative changes the stack state.
>>
>> The only way I can think of to fix this is to have ORC alternatives :-/

So that means that any alternative that does a stack manipulation isn't
currently supported?

alex.

> Or they could be converted to use static branches instead of
> alternatives.
> 
