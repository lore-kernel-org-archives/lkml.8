Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6869024691
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xBEy4Zn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgB1KnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:43:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34202 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:43:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SAWjkV162788;
        Fri, 28 Feb 2020 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8h08No6Pad7B0x9/8mIAR65fMB9heGYx2CEJ1o/H0wI=;
 b=xBEy4Zn/NZZtQCFcagVqHdaDfQTYOR3Ixj1DPJ9zxzBGQ8F7d0ORgCWXWCedldfL3uP3
 inb62l7fNuzyr83JP1uY9SEM9LWri5pnPwhLQNlZ6iVEgFhBGs/uDGURDSt0rH/LrYXn
 gBTOIpyDHEqJuxgNUOSvI9nskLYUagvdXrThiwnwK3hijqmjESnESe+StNzwEh0wSGUD
 vSYzw0bI6hKR3i7UELghE82kHLmGPu7PaQfhdGjba3nl4UUGwZTflUFhl5yMOj+7i1sn
 7a8ADiY+u1b7vRQrceQD59SSUhx1e2VWyIL2MluPFw7A1Om6PsT9XW8itBdXFoxZzCZq gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3j2a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 10:42:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SAgLMw089073;
        Fri, 28 Feb 2020 10:42:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ydcs859xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 10:42:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SAg8Kg009450;
        Fri, 28 Feb 2020 10:42:08 GMT
Received: from [10.39.209.75] (/10.39.209.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 02:42:08 -0800
Subject: Re: [patch 06/24] x86/idtentry: Provide macros to define/declare IDT
 entry points
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.772492410@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <9382db5c-90e2-f5bc-279e-9c92e282b0b3@oracle.com>
Date:   Fri, 28 Feb 2020 11:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.772492410@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=973 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:16 PM, Thomas Gleixner wrote:
> Provide DECLARE/DEFINE_IDTENTRY() macros.
> 
> DEFINE_IDTENTRY() provides a wrapper which acts as the function
> definition. The exception handler body is just appended to it with curly
> brackets. The entry point is marked notrace/noprobe so that irq tracing and
> the enter_from_user_mode() can be moved into the C-entry point. As all
> C-entries use the same macro (or a later variant) the necessary entry
> handling can be implemented at one central place.
> 
> DECLARE_IDTENTRY() provides the function prototypes:
>    - The C entry point 	    	cfunc
>    - The ASM entry point		asm_cfunc
>    - The XEN/PV entry point	xen_asm_cfunc
> 
> They all follow the same naming convention.
> 
> When included from ASM code DECLARE_IDTENTRY() is a macro which emits the
> low level entry point in assembly by instantiating idtentry.
> 
> IDTENTRY is the simplest variant which just has a pt_regs argument. It's
> going to be used for all exceptions which have no error code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S       |    6 +++
>   arch/x86/entry/entry_64.S       |    6 +++
>   arch/x86/include/asm/idtentry.h |   79 ++++++++++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/traps.h    |    2 -
>   4 files changed, 92 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -769,6 +769,12 @@ SYM_CODE_END(\asmsym)
>   .endm
>   
>   /*
> + * Include the defines which emit the idt entries which are shared
> + * shared between 32 and 64 bit.
> + */
> +#include <asm/idtentry.h>
> +
> +/*
>    * %eax: prev task
>    * %edx: next task
>    */
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -688,6 +688,12 @@ SYM_CODE_END(\asmsym)
>   .endm
>   
>   /*
> + * Include the defines which emit the idt entries which are shared
> + * shared between 32 and 64 bit.
> + */
> +#include <asm/idtentry.h>
> +
> +/*
>    * Interrupt entry helper function.
>    *
>    * Entry runs with interrupts off. Stack layout at entry:
> --- /dev/null
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_IDTENTRY_H
> +#define _ASM_X86_IDTENTRY_H
> +
> +/* Interrupts/Exceptions */
> +#include <asm/trapnr.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +/**
> + * idtentry_enter - Handle state tracking on idtentry
> + * @regs:	Pointer to pt_regs of interrupted context
> + *
> + * Place holder for now.
> + */
> +static __always_inline void idtentry_enter(struct pt_regs *regs)
> +{
> +}
> +
> +/**
> + * idtentry_exit - Prepare returning to low level ASM code
> + *
> + * Place holder for now.
> + */
> +static __always_inline void idtentry_exit(struct pt_regs *regs)
> +{
> +}
> +
> +/**
> + * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
> + *		      No error code pushed by hardware
> + * @vector:	Vector number (ignored for C)
> + * @func:	Function name of the entry point
> + *
> + * Declares three functions:
> + * - The ASM entry point: asm_##func
> + * - The XEN PV trap entry point: xen_##func (maybe unused)
> + * - The C handler called from the ASM entry point
> + */
> +#define DECLARE_IDTENTRY(vector, func)					\
> +	asmlinkage void asm_##func(void);				\
> +	asmlinkage void xen_asm_##func(void);				\
> +	__visible void func(struct pt_regs *regs)
> +
> +/**
> + * DEFINE_IDTENTRY - Emit code for simple IDT entry points
> + * @func:	Function name of the entry point
> + *
> + * @func is called from ASM entry code with interrupts disabled.
> + *
> + * The macro is written so it acts as function definition. Append the
> + * body with a pair of curly brackets.
> + *
> + * idtentry_enter() contains common code which has to be invoked before
> + * arbitrary code in the body. idtentry_exit() contains common code
> + * which has to run before returning to the low level assembly code.
> + */
> +#define DEFINE_IDTENTRY(func)						\
> +static __always_inline void __##func(struct pt_regs *regs);		\
> +									\
> +__visible notrace void func(struct pt_regs *regs)			\
> +{									\
> +	idtentry_enter(regs);						\
> +	__##func (regs);						\
> +	idtentry_exit(regs);						\
> +}									\
> +NOKPROBE_SYMBOL(func);							\
> +									\
> +static __always_inline void __##func(struct pt_regs *regs)
> +
> +#else /* !__ASSEMBLY__ */
> +
> +/* Defines for ASM code to construct the IDT entries */
> +#define DECLARE_IDTENTRY(vector, func)				\
> +	idtentry vector asm_##func func has_error_code=0

Should be DEFINE_IDENTRY(), no? Like the comment says: "Defines for ..."

In that case, the commit comment also needs to be updated.

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> +#endif /* __ASSEMBLY__ */
> +
> +#endif
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -6,8 +6,8 @@
>   #include <linux/kprobes.h>
>   
>   #include <asm/debugreg.h>
> +#include <asm/idtentry.h>
>   #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
> -#include <asm/trapnr.h>
>   
>   #define dotraplinkage __visible
>   
> 
> 
