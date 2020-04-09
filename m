Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26C4217D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdP23vw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDIIRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:17:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDIIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:17:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0398D2q2150408;
        Thu, 9 Apr 2020 08:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=W3Fcv0vtVlBpP+vayNy1UphJ5VAFqs7bWIftYjvmokA=;
 b=sdP23vw+oDrhMFFx+SNitXNFmxPrcFcQmSLsHfK+hMESQUaUzGvc74EIg32sbubHnwWf
 WYNwDfO/vzqZFVVmXZJdGceh7+85U7AHf7hJPu/rsYhCJ/Sjd5AodX99PC5BhdZQAZD5
 Z4ei3NewcCwCtNzNE+84E2Hp5FyrDc6OPw0gB/NsmMIVTaKZL1WhoSZD0akhxKDzZ4ce
 Jfggv+FP/MaPyC0UgDfrtELH5h468pBWInL9N+ErcRt+GbOy60Cias06kU5quSoeVOaV
 cWykczdJ82SzQ+X1BHknh3uS3xfBs0pDyMTxQMuaCtM0z/XplRO68H7wpfIEIgfbRtrZ Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 309gw4bxts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 08:16:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03987YNS096999;
        Thu, 9 Apr 2020 08:14:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3091m3dpt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 08:14:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0398ESFE027101;
        Thu, 9 Apr 2020 08:14:28 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 01:14:28 -0700
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
 <20200407172739.GI20730@hirez.programming.kicks-ass.net>
 <20200408213508.GA4496@worktop.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <da6efbb5-2610-6721-77ca-9833d13b9398@oracle.com>
Date:   Thu, 9 Apr 2020 10:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200408213508.GA4496@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/20 11:35 PM, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 07:27:39PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 07, 2020 at 11:28:38AM -0500, Josh Poimboeuf wrote:
>>> Again, we should warn on stack changes inside alternatives, and then
>>> look at converting RSB and retpolines to use static branches so they
>>> have deterministic stacks.
>>
>> I don't think we need static brancher, we should just out-of-line the
>> whole thing.
>>
>> Let me sort this CFI error Thomas is getting and then I'll attempt a
>> patch along the lines I outlined in earlier emails.
> 
> Something like so.. seems to build and boot.
> 
> ---
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> Subject: x86: Out-of-line retpoline
> 
> Since GCC generated code already uses out-of-line retpolines and objtool
> has trouble with retpolines in alternatives, out-of-line them entirely.
> 
> This will enable objtool (once it's been taught a few more tricks) to
> generate valid ORC data for the out-of-line copies, which means we can
> correctly and reliably unwind through a retpoline.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/crypto/aesni-intel_asm.S            |  4 +--
>   arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  2 +-
>   arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  2 +-
>   arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 26 ++++++++---------
>   arch/x86/entry/entry_32.S                    |  6 ++--
>   arch/x86/entry/entry_64.S                    |  2 +-
>   arch/x86/include/asm/asm-prototypes.h        |  8 ++++--
>   arch/x86/include/asm/nospec-branch.h         | 42 ++++------------------------
>   arch/x86/kernel/ftrace_32.S                  |  2 +-
>   arch/x86/kernel/ftrace_64.S                  |  4 +--
>   arch/x86/lib/checksum_32.S                   |  4 +--
>   arch/x86/lib/retpoline.S                     | 27 +++++++++++++++---
>   arch/x86/platform/efi/efi_stub_64.S          |  2 +-
>   13 files changed, 62 insertions(+), 69 deletions(-)
> 
...
>   /*
>    * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
>    * indirect jmp/call which may be susceptible to the Spectre variant 2
> @@ -111,10 +83,9 @@
>    */
>   .macro JMP_NOSPEC reg:req
>   #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
> -		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg),	\
> +		__stringify(jmp __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE,	\
> +		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
>   #else
>   	jmp	*\reg
>   #endif
> @@ -122,10 +93,9 @@
> 
>   .macro CALL_NOSPEC reg:req
>   #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
> -		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),	\
> +		__stringify(call __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE,\
> +		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD

For X86_FEATURE_RETPOLINE_AMD, the call won't be aligned like the others,
it will be after the lfence instruction so ORC data won't be at the same
place. I am adding some code in objtool to check that alternatives don't
change the stack, but I should actually be checking if all alternatives
have the same unwind instructions at the same place.

Other than that, my only question would be any impact on performances.
Retpoline code was added with trying to limit performance impact.
Here, JMP_NOSPEC has now an additional (long) jump, and CALL_NOSPEC
is doing a long call instead of a near call. But I have no idea if this
has a visible impact.

alex.
