Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95BAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3AB20643
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P99HOglq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgEFPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:38:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:38:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Fbi0p052060;
        Wed, 6 May 2020 15:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=j1Xe1r0jUzWMXNoigXzq+GaoW22b0gC2NvzvR16qr2Q=;
 b=P99HOglqOP07Lr6/hHy/jBpu++dHXQZ4yBthI2A2BX5gB5CP9UP6fYwQO8p705VMfUMc
 BXxokfjcwMc2AycCqWtX12PQh+qzSAxjJcJztRAPG4jhbrQRp9iUve2mZZubp5TSb8Gq
 zJL5sWg6rWpuvAHGTtzV3VS2XdDtEryWRA1LJUhBHIsdx48DjoWriILGlzo/YNfPRV5x
 yh9PGZAQyMXVpBr/rZBItSvO4hHQ1ysqWCZ+6kRmvJgGZvEK6IfiHrKw2hE0UUJUAOrB
 GlE4TQ6zYuX/i7UOST+bjqVUKfy/TMkeUBFiWZ3DS/kWHjIFcYAYgIErUcaKOkKjiqLI fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gnaxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:37:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FIdjS085335;
        Wed, 6 May 2020 15:35:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7n0e43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:35:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046FZfS9030023;
        Wed, 6 May 2020 15:35:42 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:35:41 -0700
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of
 ist_begin/end_non_atomic()
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
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.462640294@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e0037089-113c-d262-bae0-1beacf4198d8@oracle.com>
Date:   Wed, 6 May 2020 17:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.462640294@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> This is completely overengineered and definitely not an interface which
> should be made available to anything else than this particular MCE case.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/include/asm/traps.h   |    2 --
>   arch/x86/kernel/cpu/mce/core.c |    6 ++++--
>   arch/x86/kernel/traps.c        |   37 -------------------------------------
>   3 files changed, 4 insertions(+), 41 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -120,8 +120,6 @@ asmlinkage void smp_irq_move_cleanup_int
>   
>   extern void ist_enter(struct pt_regs *regs);
>   extern void ist_exit(struct pt_regs *regs);
> -extern void ist_begin_non_atomic(struct pt_regs *regs);
> -extern void ist_end_non_atomic(void);
>   
>   #ifdef CONFIG_VMAP_STACK
>   void __noreturn handle_stack_overflow(const char *message,
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1352,13 +1352,15 @@ void notrace do_machine_check(struct pt_
>   
>   	/* Fault was in user mode and we need to take some action */
>   	if ((m.cs & 3) == 3) {
> -		ist_begin_non_atomic(regs);
> +		/* If this triggers there is no way to recover. Die hard. */
> +		BUG_ON(!on_thread_stack() || !user_mode(regs));
>   		local_irq_enable();
> +		preempt_enable();
>   
>   		if (kill_it || do_memory_failure(&m))
>   			force_sig(SIGBUS);
> +		preempt_disable();
>   		local_irq_disable();
> -		ist_end_non_atomic();
>   	} else {
>   		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
>   			mce_panic("Failed kernel mode recovery", &m, msg);
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -117,43 +117,6 @@ void ist_exit(struct pt_regs *regs)
>   		rcu_nmi_exit();
>   }
>   
> -/**
> - * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
> - * @regs:	regs passed to the IST exception handler
> - *
> - * IST exception handlers normally cannot schedule.  As a special
> - * exception, if the exception interrupted userspace code (i.e.
> - * user_mode(regs) would return true) and the exception was not
> - * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
> - * begins a non-atomic section within an ist_enter()/ist_exit() region.
> - * Callers are responsible for enabling interrupts themselves inside
> - * the non-atomic section, and callers must call ist_end_non_atomic()
> - * before ist_exit().
> - */
> -void ist_begin_non_atomic(struct pt_regs *regs)
> -{
> -	BUG_ON(!user_mode(regs));
> -
> -	/*
> -	 * Sanity check: we need to be on the normal thread stack.  This
> -	 * will catch asm bugs and any attempt to use ist_preempt_enable
> -	 * from double_fault.
> -	 */
> -	BUG_ON(!on_thread_stack());
> -
> -	preempt_enable_no_resched();
> -}
> -
> -/**
> - * ist_end_non_atomic() - begin a non-atomic section in an IST exception
> - *
> - * Ends a non-atomic section started with ist_begin_non_atomic().
> - */
> -void ist_end_non_atomic(void)
> -{
> -	preempt_disable();
> -}
> -
>   int is_valid_bugaddr(unsigned long addr)
>   {
>   	unsigned short ud;
> 
