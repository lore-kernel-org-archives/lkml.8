Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BAC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281B2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TlK8Ew1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgB0QNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:13:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgB0QNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:13:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RG3763156137;
        Thu, 27 Feb 2020 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=45wiAcSNUuECCbJIdY1aSyZ/D+NV2Uo34TsQEImaUlM=;
 b=TlK8Ew1hZL2/K76FwU+3sZU+wU/M5tM4oD1rmsbYuEZPW8VEwd5ff/YBUqjlaNh1oBHE
 ftLZT6wBskO61l2Es43SNSgHvKs2M/EAYgkPShE0eaDYgPRSQCYgSRVgq1ryb0vOE4jb
 h+JKM0aJetoDxL5AroZXXcToEmB/y7X6BaR/wj4SaLRnmc+4X1nOg6w/GSN9uwePAiRP
 INvERBRSlrZskt64IVlJ77W6GCJK8/ovBj4h+Dn5SbHIAmDHUmbABi4iTmuPuGRs7gB2
 CSlyxyK3rHOGodwbj7KVVZVoLX4XOYE66WXPx+oij1vyfPZypdacd+cNCRfrDtOwTErV lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct3bypf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:12:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RG2opX137720;
        Thu, 27 Feb 2020 16:12:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ydcs9nk3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:12:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RGCIGn009870;
        Thu, 27 Feb 2020 16:12:18 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 08:12:18 -0800
Subject: Re: [patch 6/8] x86/entry: Move irq tracing to syscall_slow_exit_work
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.813084267@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <721a30c9-4a28-6a2c-cbb2-4291e600d6e9@oracle.com>
Date:   Thu, 27 Feb 2020 17:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.813084267@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:08 PM, Thomas Gleixner wrote:
> which removes the ASM IRQ tracepoints.

This moves irq tracing to syscall_return_slowpath, not syscall_slow_exit_work,
right?

alex.

  
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c   |    2 ++
>   arch/x86/entry/entry_32.S |    3 ++-
>   arch/x86/entry/entry_64.S |    3 ---
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -299,6 +299,8 @@ static void syscall_slow_exit_work(struc
>   
>   	local_irq_disable();
>   	__prepare_exit_to_usermode(regs);
> +	/* Return to user space enables interrupts */
> +	trace_hardirqs_on();
>   }
>   NOKPROBE_SYMBOL(syscall_return_slowpath);
>   
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -812,7 +812,7 @@ SYM_CODE_START(ret_from_fork)
>   	movl    %esp, %eax
>   	call    syscall_return_slowpath
>   	STACKLEAK_ERASE
> -	jmp     restore_all
> +	jmp     restore_all_switch_stack
>   
>   	/* kernel thread */
>   1:	movl	%edi, %eax
> @@ -1077,6 +1077,7 @@ SYM_FUNC_START(entry_INT80_32)
>   
>   restore_all:
>   	TRACE_IRQS_IRET
> +restore_all_switch_stack:
>   	SWITCH_TO_ENTRY_STACK
>   	CHECK_AND_APPLY_ESPFIX
>   .Lrestore_nocheck:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -172,8 +172,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
>   	movq	%rsp, %rsi
>   	call	do_syscall_64		/* returns with IRQs disabled */
>   
> -	TRACE_IRQS_ON			/* return enables interrupts */
> -
>   	/*
>   	 * Try to use SYSRET instead of IRET if we're returning to
>   	 * a completely clean 64-bit userspace context.  If we're not,
> @@ -340,7 +338,6 @@ SYM_CODE_START(ret_from_fork)
>   	UNWIND_HINT_REGS
>   	movq	%rsp, %rdi
>   	call	syscall_return_slowpath	/* returns with IRQs disabled */
> -	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
>   	jmp	swapgs_restore_regs_and_return_to_usermode
>   
>   1:
> 
