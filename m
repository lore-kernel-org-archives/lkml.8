Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE18FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3127221F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7htG83b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgDQTTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:19:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgDQTTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:19:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HJI2q5171302;
        Fri, 17 Apr 2020 19:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DddDipoAKPmmlgvP1sg97Rpg4mv9LGW+C80d1h3W6ec=;
 b=I7htG83bvhKtkA89NMN7DzU2BDXkf96/CG1UCgWrkgvdBT6EvZe239Utpt4nkfn0yDXH
 b+w0qkPPmxaTQJ0s0LcUPyj9K+9j+i44Hgay/mASxQK9lmdUHYDePVcy4tiNojm0ha8P
 mQ4CSwMjP+UzqvVTWKpLsIySCvKMmWjIEMHs27nhfg1w+pXgjjToyLO2WkOoCrWfspbN
 3/vgz8lrtvT95kS8qPO4ozBuULlRpgL5TJiBsxO26KrfaD+EuSBi09ipQPnSwdH+Pimp
 bPVk7wMdkDFx0GImCPVrZFV2FUw7WYV8WOZV0rmw135K9S/ERyxpGyZjEEyTanHLEDfy 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30e0aaecty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 19:19:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HJHadA158293;
        Fri, 17 Apr 2020 19:19:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30dn922stm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 19:19:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03HJJRvC014806;
        Fri, 17 Apr 2020 19:19:27 GMT
Received: from linux-1.home (/10.175.17.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 12:19:26 -0700
Subject: Re: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com
References: <20200416114706.625340212@infradead.org>
 <20200416115118.749606694@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <243918fd-fa54-a8e5-bc70-67bf2d9f16a9@oracle.com>
Date:   Fri, 17 Apr 2020 21:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416115118.749606694@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=790
 suspectscore=2 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=848 mlxscore=0 lowpriorityscore=0
 suspectscore=2 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/20 1:47 PM, Peter Zijlstra wrote:
> The ftrace_regs_caller() trampoline does something 'funny' when there
> is a direct-caller present. In that case it stuffs the 'direct-caller'
> address on the return stack and then exits the function. This then
> results in 'returning' to the direct-caller with the exact registers
> we came in with -- an indirect tail-call without using a register.
> 
> This however (rightfully) confuses objtool because the function shares
> a few instruction in order to have a single exit path, but the stack
> layout is different for them, depending through which path we came
> there.
> 
> This is currently cludged by forcing the stack state to the non-direct
> case, but this generates actively wrong (ORC) unwind information for
> the direct case, leading to potential broken unwinds.
> 
> Fix this issue by fully separating the exit paths. This results in
> having to poke a second RET into the trampoline copy, see
> ftrace_regs_caller_ret.
> 
> This brings us to a second objtool problem, in order for it to
> perceive the 'jmp ftrace_epilogue' as a function exit, it needs to be
> recognised as a tail call. In order to make that happen,
> ftrace_epilogue needs to be the start of an STT_FUNC, so re-arrange
> code to make this so.
> 
> Finally, a third issue is that objtool requires functions to exit with
> the same stack layout they started with, which is obviously violated
> in the direct case, employ the new HINT_RET_OFFSET to tell objtool
> this is an expected exception.
> 
> Together, this results in generating correct ORC unwind information
> for the ftrace_regs_caller() function and it's trampoline copies.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/kernel/ftrace.c    |   12 ++++++++++--
>   arch/x86/kernel/ftrace_64.S |   32 +++++++++++++++-----------------
>   2 files changed, 25 insertions(+), 19 deletions(-)
> 
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -282,7 +282,8 @@ static inline void tramp_free(void *tram
>   
>   /* Defined as markers to the end of the ftrace default trampolines */
>   extern void ftrace_regs_caller_end(void);
> -extern void ftrace_epilogue(void);
> +extern void ftrace_regs_caller_ret(void);
> +extern void ftrace_caller_end(void);
>   extern void ftrace_caller_op_ptr(void);
>   extern void ftrace_regs_caller_op_ptr(void);
>   
> @@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops
>   		call_offset = (unsigned long)ftrace_regs_call;
>   	} else {
>   		start_offset = (unsigned long)ftrace_caller;
> -		end_offset = (unsigned long)ftrace_epilogue;
> +		end_offset = (unsigned long)ftrace_caller_end;
>   		op_offset = (unsigned long)ftrace_caller_op_ptr;
>   		call_offset = (unsigned long)ftrace_call;
>   	}
> @@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
>   	if (WARN_ON(ret < 0))
>   		goto fail;
>   
> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> +		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);

It might be safer to use start_offset instead of ftrace_regs_caller (in
case start_offset is ever changed to something different from ftrace_regs_caller
in the future):

          ip = trampoline + (ftrace_regs_caller_ret - start_offset);

alex.

> +		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> +		if (WARN_ON(ret < 0))
> +			goto fail;
> +	}
> +
>   	/*
>   	 * The address of the ftrace_ops that is used for this trampoline
>   	 * is stored at the end of the trampoline. This will be used to
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -157,8 +157,12 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
>   	 * think twice before adding any new code or changing the
>   	 * layout here.
>   	 */
> -SYM_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
> +SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
>   
> +	jmp ftrace_epilogue
> +SYM_FUNC_END(ftrace_caller);
> +
> +SYM_FUNC_START(ftrace_epilogue)
>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>   SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
>   	jmp ftrace_stub
> @@ -170,14 +174,12 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L
>    */
>   SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
>   	retq
> -SYM_FUNC_END(ftrace_caller)
> +SYM_FUNC_END(ftrace_epilogue)
>   
>   SYM_FUNC_START(ftrace_regs_caller)
>   	/* Save the current flags before any operations that can change them */
>   	pushfq
>   
> -	UNWIND_HINT_SAVE
> -
>   	/* added 8 bytes to save flags */
>   	save_mcount_regs 8
>   	/* save_mcount_regs fills in first two parameters */
> @@ -233,7 +235,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
>   	movq ORIG_RAX(%rsp), %rax
>   	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
>   
> -	/* If ORIG_RAX is anything but zero, make this a call to that */
> +	/*
> +	 * If ORIG_RAX is anything but zero, make this a call to that.
> +	 * See arch_ftrace_set_direct_caller().
> +	 */
>   	movq ORIG_RAX(%rsp), %rax
>   	cmpq	$0, %rax
>   	je	1f
> @@ -244,20 +249,14 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
>   	movq %rax, MCOUNT_REG_SIZE(%rsp)
>   
>   	restore_mcount_regs 8
> +	/* Restore flags */
> +	popfq
>   
> -	jmp	2f
> +SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
> +	UNWIND_HINT_RET_OFFSET
> +	jmp	ftrace_epilogue
>   
>   1:	restore_mcount_regs
> -
> -
> -2:
> -	/*
> -	 * The stack layout is nondetermistic here, depending on which path was
> -	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
> -	 * pretend the stack always looks like the non-direct case.
> -	 */
> -	UNWIND_HINT_RESTORE
> -
>   	/* Restore flags */
>   	popfq
>   
> @@ -268,7 +267,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
>   	 * to the return.
>   	 */
>   SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
> -
>   	jmp ftrace_epilogue
>   
>   SYM_FUNC_END(ftrace_regs_caller)
> 
> 
