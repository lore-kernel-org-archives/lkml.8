Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01589C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D205D21D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUEtWuzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393100AbgDPOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:39:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405776AbgDPOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:39:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GEc1Gj127181;
        Thu, 16 Apr 2020 14:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=k7Izfo/QNElByY6sB7IwedfWSbgNNCCpEV2qFXzdMog=;
 b=DUEtWuzoYwcnv0EAW44aTm50bOMZT/HTUnOwhsptQ0ztQqxSq49KwW/FmrB0V4LuZu8k
 +hkEi7qjLkAuFl7MDpiSb9FrOQUKHBZhf+qQYLrspSscXDXs6CdF0waMn1KA/X8/4U4K
 jIQEEUVpLEZrrqGkJPti1a/YLBtISy6BskkgRNJSltnmy/SgLb+MKVingFoqQqfwbZX8
 LiKNiXxNeFufO9mZXMS4LBCnk3YdnS1/HrNIrj3YgFMqzrt7+YD7IfbSRm9C8fgTWe3c
 cqIfinWnq+aYKE46B6VInwmRVpVvxkHm4wv5Tk/XYWtKuVC2bDHPw9CgsZCtQ257xvu2 Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30emejhker-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 14:38:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GEc1qu078177;
        Thu, 16 Apr 2020 14:38:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30dynyv93c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 14:38:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03GEciwI017010;
        Thu, 16 Apr 2020 14:38:44 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 07:38:43 -0700
Subject: Re: [PATCH V3 6/9] objtool: Report inconsistent stack changes in
 alternative
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-7-alexandre.chartre@oracle.com>
 <20200416141843.GP20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <806684aa-dcba-644e-540a-c88055b0d936@oracle.com>
Date:   Thu, 16 Apr 2020 16:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416141843.GP20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/20 4:18 PM, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 12:36:15PM +0200, Alexandre Chartre wrote:
>> To allow a valid stack unwinding, an alternative should have code
>> where the same stack changes happens at the same places as in the
>> original code. Add a check in objtool to validate that stack changes
>> in alternative are effectively consitent with the original code.
> 
> This thing is completely buggered, it warns all over the place, even for
> obviously correct alternatives like:
> 
> 0000000000000310 <return_to_handler>:
>   310:   48 83 ec 18             sub    $0x18,%rsp
>   314:   48 89 04 24             mov    %rax,(%rsp)
>   318:   48 89 54 24 08          mov    %rdx,0x8(%rsp)
>   31d:   48 89 ef                mov    %rbp,%rdi
>   320:   e8 00 00 00 00          callq  325 <return_to_handler+0x15>
>                          321: R_X86_64_PLT32     ftrace_return_to_handler-0x4
>   325:   48 89 c7                mov    %rax,%rdi
>   328:   48 8b 54 24 08          mov    0x8(%rsp),%rdx
>   32d:   48 8b 04 24             mov    (%rsp),%rax
>   331:   48 83 c4 18             add    $0x18,%rsp
>   335:   ff e7                   jmpq   *%rdi
>   337:   90                      nop
>   338:   90                      nop
>   339:   90                      nop
> 
> 
> Where 335 has two alternatives:
> 
>     0:   e9 00 00 00 00          jmpq   5 <.altinstr_replacement+0x5>
>                          1: R_X86_64_PLT32       __x86_retpoline_rdi-0x4
> 
> and
> 
>     5:   0f ae e8                lfence
>     8:   ff e7                   jmpq   *%rdi
> 
> 
> And it then comes back with:
> 
>    defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .entry.text+0x335: error in alternative
>    defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .altinstr_replacement+0x5: in alternative 2
>    defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .altinstr_replacement+0x8: misaligned alternative state change
> 
> which is just utter crap, JMP has no (CFI) state change.

I think that's because the original nop instructions are not reached, so
they probably have an undefined stack state. Hence there's a different
stack state between 335 (jmpq *%rdi) and 337 (nop).

With the alternative, we have:

335:         lfence
338:         jmpq *%rdi

So now instruction 338 is reached with the stack state we had at 335
which is different from the original stack state at 338 (undefined)
with the unreached instruction.

Don't we have a state change recorded at 337 because the instruction
is seen as not reached?


alex.
