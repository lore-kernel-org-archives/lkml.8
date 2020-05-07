Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2963DC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E579D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nNzlVErF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEGNlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:41:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgEGNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:41:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047DXNLk106739;
        Thu, 7 May 2020 13:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8kGnhSn5hpXXUErw36JflRncT0TT+ZXqk1Ou29ZGQyk=;
 b=nNzlVErF7jB6eLDdtCRI9/u8Uy2KrV5IJZCIveAWInr4AsKLlZdmdZTc5mtj8y186RS7
 V5kMOlsgF/hQqfmz29y1dDM6qW+GEL3H5A6stvf8HyHabGQhfzwzt2PepAtxP4WTYiyY
 HW9zs8Sz9Xa55fD6TgEMa6caCpSarK7TLH/Nj7p/+Z2RmabNhwXJFqEk0p2XGmK9YArQ
 GTZqIdENonKqC667ml1E2F9HpledINWnGc3PpFu5EBd01QguKf9aLdhfrPp7nTq6o5vu
 pQ+wBZZxjFoVk5vCyru7GLOXRch+2d3Z/woQs+OrtTUXu0WXVUQD+5DkbLQ5DfgZXfwz Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq78qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:40:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047Da4WL130384;
        Thu, 7 May 2020 13:40:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1ranggg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:40:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047DeVYU029600;
        Thu, 7 May 2020 13:40:31 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 06:40:31 -0700
Subject: Re: [patch V4 part 2 04/18] x86/entry/common: Protect against
 instrumentation
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505134112.272268764@linutronix.de>
 <20200505134340.520277507@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <87976f9b-2c36-b4f7-5382-4eba569cc687@oracle.com>
Date:   Thu, 7 May 2020 15:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134340.520277507@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:41 PM, Thomas Gleixner wrote:
> Mark the various syscall entries with noinstr to protect them against
> instrumentation and add the noinstr_begin()/end() annotations to mark the
> parts of the functions which are safe to call out into instrumentable code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c |  135 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 90 insertions(+), 45 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -41,15 +41,26 @@
>   
>   #ifdef CONFIG_CONTEXT_TRACKING
>   /* Called on entry from user mode with IRQs off. */
> -__visible inline noinstr void enter_from_user_mode(void)
> +__visible noinstr void enter_from_user_mode(void)
>   {
> -	CT_WARN_ON(ct_state() != CONTEXT_USER);
> +	enum ctx_state state = ct_state();
> +
>   	user_exit_irqoff();
> +
> +	instr_begin();
> +	CT_WARN_ON(state != CONTEXT_USER);
> +	instr_end();
>   }
>   #else
>   static inline void enter_from_user_mode(void) {}
>   #endif
>   
> +static noinstr void exit_to_user_mode(void)
> +{
> +	user_enter_irqoff();
> +	mds_user_clear_cpu_buffers();
> +}
> +
>   static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
>   {
>   #ifdef CONFIG_X86_64
> @@ -179,8 +190,7 @@ static void exit_to_usermode_loop(struct
>   	}
>   }
>   
> -/* Called with IRQs disabled. */
> -__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
> +static void __prepare_exit_to_usermode(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags;
> @@ -219,10 +229,14 @@ static void exit_to_usermode_loop(struct
>   	 */
>   	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
>   #endif
> +}
>   
> -	user_enter_irqoff();
> -
> -	mds_user_clear_cpu_buffers();
> +__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
> +{
> +	instr_begin();
> +	__prepare_exit_to_usermode(regs);
> +	instr_end();
> +	exit_to_user_mode();
>   }
>   
>   #define SYSCALL_EXIT_WORK_FLAGS				\
> @@ -251,11 +265,7 @@ static void syscall_slow_exit_work(struc
>   		tracehook_report_syscall_exit(regs, step);
>   }
>   
> -/*
> - * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
> - * state such that we can immediately switch to user mode.
> - */
> -__visible inline void syscall_return_slowpath(struct pt_regs *regs)
> +static void __syscall_return_slowpath(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags = READ_ONCE(ti->flags);
> @@ -276,15 +286,29 @@ static void syscall_slow_exit_work(struc
>   		syscall_slow_exit_work(regs, cached_flags);
>   
>   	local_irq_disable();
> -	prepare_exit_to_usermode(regs);
> +	__prepare_exit_to_usermode(regs);
> +}
> +
> +/*
> + * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
> + * state such that we can immediately switch to user mode.
> + */
> +__visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
> +{
> +	instr_begin();
> +	__syscall_return_slowpath(regs);
> +	instr_end();
> +	exit_to_user_mode();
>   }
>   
>   #ifdef CONFIG_X86_64
> -__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
> +__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>   {
>   	struct thread_info *ti;
>   
>   	enter_from_user_mode();
> +	instr_begin();
> +
>   	local_irq_enable();
>   	ti = current_thread_info();
>   	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
> @@ -301,8 +325,10 @@ static void syscall_slow_exit_work(struc
>   		regs->ax = x32_sys_call_table[nr](regs);
>   #endif
>   	}
> +	__syscall_return_slowpath(regs);
>   
> -	syscall_return_slowpath(regs);
> +	instr_end();
> +	exit_to_user_mode();
>   }
>   #endif
>   
> @@ -310,10 +336,10 @@ static void syscall_slow_exit_work(struc
>   /*
>    * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
>    * all entry and exit work and returns with IRQs off.  This function is
> - * extremely hot in workloads that use it, and it's usually called from
> + * ex2tremely hot in workloads that use it, and it's usually called from

typo: "ex2tremely"

alex.


>    * do_fast_syscall_32, so forcibly inline it to improve performance.
>    */
> -static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
> +static void do_syscall_32_irqs_on(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	unsigned int nr = (unsigned int)regs->orig_ax;
> @@ -337,27 +363,62 @@ static __always_inline void do_syscall_3
>   		regs->ax = ia32_sys_call_table[nr](regs);
>   	}
>   
> -	syscall_return_slowpath(regs);
> +	__syscall_return_slowpath(regs);
>   }
>   
>   /* Handles int $0x80 */
> -__visible void do_int80_syscall_32(struct pt_regs *regs)
> +__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
>   {
>   	enter_from_user_mode();
> +	instr_begin();
> +
>   	local_irq_enable();
>   	do_syscall_32_irqs_on(regs);
> +
> +	instr_end();
> +	exit_to_user_mode();
> +}
> +
> +static bool __do_fast_syscall_32(struct pt_regs *regs)
> +{
> +	int res;
> +
> +	/* Fetch EBP from where the vDSO stashed it. */
> +	if (IS_ENABLED(CONFIG_X86_64)) {
> +		/*
> +		 * Micro-optimization: the pointer we're following is
> +		 * explicitly 32 bits, so it can't be out of range.
> +		 */
> +		res = __get_user(*(u32 *)&regs->bp,
> +			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
> +	} else {
> +		res = get_user(*(u32 *)&regs->bp,
> +		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
> +	}
> +
> +	if (res) {
> +		/* User code screwed up. */
> +		regs->ax = -EFAULT;
> +		local_irq_disable();
> +		__prepare_exit_to_usermode(regs);
> +		return false;
> +	}
> +
> +	/* Now this is just like a normal syscall. */
> +	do_syscall_32_irqs_on(regs);
> +	return true;
>   }
>   
>   /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
> -__visible long do_fast_syscall_32(struct pt_regs *regs)
> +__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
>   {
>   	/*
>   	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
>   	 * convention.  Adjust regs so it looks like we entered using int80.
>   	 */
> -
>   	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
> -		vdso_image_32.sym_int80_landing_pad;
> +					vdso_image_32.sym_int80_landing_pad;
> +	bool success;
>   
>   	/*
>   	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
> @@ -367,33 +428,17 @@ static __always_inline void do_syscall_3
>   	regs->ip = landing_pad;
>   
>   	enter_from_user_mode();
> +	instr_begin();
>   
>   	local_irq_enable();
> +	success = __do_fast_syscall_32(regs);
>   
> -	/* Fetch EBP from where the vDSO stashed it. */
> -	if (
> -#ifdef CONFIG_X86_64
> -		/*
> -		 * Micro-optimization: the pointer we're following is explicitly
> -		 * 32 bits, so it can't be out of range.
> -		 */
> -		__get_user(*(u32 *)&regs->bp,
> -			    (u32 __user __force *)(unsigned long)(u32)regs->sp)
> -#else
> -		get_user(*(u32 *)&regs->bp,
> -			 (u32 __user __force *)(unsigned long)(u32)regs->sp)
> -#endif
> -		) {
> -
> -		/* User code screwed up. */
> -		local_irq_disable();
> -		regs->ax = -EFAULT;
> -		prepare_exit_to_usermode(regs);
> -		return 0;	/* Keep it simple: use IRET. */
> -	}
> +	instr_end();
> +	exit_to_user_mode();
>   
> -	/* Now this is just like a normal syscall. */
> -	do_syscall_32_irqs_on(regs);
> +	/* If it failed, keep it simple: use IRET. */
> +	if (!success)
> +		return 0;
>   
>   #ifdef CONFIG_X86_64
>   	/*
> 
