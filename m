Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927E206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ri0l9h8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgDFOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:51:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34624 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgDFOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:51:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036EmsmR135008;
        Mon, 6 Apr 2020 14:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TSq08w3zBJ3WXbaxngAG7bWBdNx8iSe5Zcj/t0FI1rw=;
 b=Ri0l9h8ptsXQDNmrdV0oqlk3PhIRtpT+VA3DLBFX1F3ehnf8e2VpCGQ/3OJbFrQQ+3lM
 oZ6RuOzs06z/VuyoWfJWZifIbj4OH5tfzLnYxxbd4eBuWgEvL+lTXkEj0i1D7YoHH0PL
 Br3BDVsun96eWccBnYX2kuQB1UR4MB1ri8cMKWmdudOwV4mshQM1kZuSq3mp+pMs7hru
 sXffiZevQIyatQWu18WKnaSbQGyEX2EKs45/As/oeHD0MqoazoMTw0fo+I17IbNsUiD0
 w71ktjB+SGvoi10WBOh9OlBi46u37S9k7RZwD2EuxQQZfLWaheodP/VZwK5wJeUtr/mv gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvmy8su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:51:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036ElDtv100043;
        Mon, 6 Apr 2020 14:51:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3073qd9kvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:51:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036EpRta018224;
        Mon, 6 Apr 2020 14:51:27 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 07:51:27 -0700
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <20200402152717.GE20730@hirez.programming.kicks-ass.net>
 <94272807-23c0-3eae-8312-9488607186ca@oracle.com>
Message-ID: <8a33ffae-1926-9c0c-35b2-8276c49cfe5a@oracle.com>
Date:   Mon, 6 Apr 2020 16:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <94272807-23c0-3eae-8312-9488607186ca@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/20 4:34 PM, Alexandre Chartre wrote:
> 
> On 4/2/20 5:27 PM, Peter Zijlstra wrote:
>> On Thu, Apr 02, 2020 at 10:22:17AM +0200, Alexandre Chartre wrote:
>>> With retpoline, the return instruction is used to branch to an address
>>> stored on the stack. So, unlike a regular return instruction, when a
>>> retpoline return instruction is reached the stack has been modified
>>> compared to what we have when the function was entered.
>>>
>>> Provide the mechanism to explicitly call-out such return instruction
>>> so that objtool can correctly handle them.
>>
>> https://lkml.kernel.org/r/20200331222703.GH2452@worktop.programming.kicks-ass.net
>>
>> And also, the split out version:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=core/objtool&id=ec9d9549901dfd2ff411676dfc624e50219e4d5a
>>
> 
> HINT_RET_OFFSET works fine when an immediate value is pushed on the
> stack. However if the value is pushed from a callee-saved register
> (%rbp, %rbx, %r12-%r15) then we still have a "return with modified
> stack frame" warning. That's because objtool checks callee-saved
> registers pushed/popped on the stack, and we have retpoline functions
> built for each register (see arch/x86/lib/retpoline.S)
> 
> So that's why I also added a bool to has_modified_stack_frame() to
> no check registers:
> 
> @@ -1432,7 +1478,8 @@ static bool is_fentry_call(struct instruction *insn)
>       return false;
>   }
> 
> -static bool has_modified_stack_frame(struct insn_state *state)
> +static bool has_modified_stack_frame(struct insn_state *state,
> +                     bool check_registers)
>   {
>       int i;
> 
> @@ -1442,6 +1489,9 @@ static bool has_modified_stack_frame(struct insn_state *state)
>           state->drap)
>           return true;
> 
> +    if (!check_registers)
> +        return false;
> +
>       for (i = 0; i < CFI_NUM_REGS; i++)
>           if (state->regs[i].base != initial_func_cfi.regs[i].base ||
>               state->regs[i].offset != initial_func_cfi.regs[i].offset)
> 
> 

Here is a simple change on top of the UNWIND_HINT_RET_OFFSET patch to prevent
this problem:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dbb2b2187037..97db8f49e06f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1390,6 +1390,14 @@ static bool has_modified_stack_frame(struct instruction *insn,
         if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
                 return true;
  
+       /*
+        * If there is a ret offset hint then don't check registers
+        * because a callee-saved register might have been pushed on
+        * the stack.
+        */
+       if (ret_offset)
+               return false;
+
         for (i = 0; i < CFI_NUM_REGS; i++) {
                 if (state->regs[i].base != initial_func_cfi.regs[i].base ||
                     state->regs[i].offset != initial_func_cfi.regs[i].offset)


alex.

