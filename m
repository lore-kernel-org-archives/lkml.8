Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B12080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJ5JSEUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEFRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:11:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:11:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046H7ej3030352;
        Wed, 6 May 2020 17:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Gh/bK3Ozxr+vWT2YLDN3MVNexDkHsD1zfFjnuMYLraY=;
 b=bJ5JSEUHz2V1KrFRLwAaLoL3zQkcfkOhfsJHe1Kjino4+BEOTrYXnL2iAPpKgEEbvPWA
 PkctDI9k12t1btxIo+fVxWHgnHFuJEFA0tjv2crFkguMV4Ncs3BGSdFD6v0QNnm+CTul
 VvQzQGYpYlXPTJGLzDEvABEzcxJJzKW7Idca1Ye4sHMAUM5zMVO75HH6etryCasAp8gA
 7lMvZQryayMetQChY3vlMg64fZyr5AIC6r4PMdweIq4lZ6pVBqHycr3nvxu5t8iHhZYj
 6yLkohqoZI1HFqnxIOyMoGysClPmt0/miMOfFArjuUmLm6/m85gtHcJGVWo2MhWSfgDA dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09rbpwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 17:10:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046H6oCO017727;
        Wed, 6 May 2020 17:10:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdvxuuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 17:10:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046HAc2n018609;
        Wed, 6 May 2020 17:10:38 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 10:10:38 -0700
Subject: Re: [patch V4 part 1 36/36] rcu: Make RCU IRQ enter/exit functions
 rely on in_nmi()
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134101.617130349@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <8c963392-0f43-3867-7f31-1644ac1592c9@oracle.com>
Date:   Wed, 6 May 2020 19:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134101.617130349@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> "irq" parameter that indicates whether these functions are invoked from
> an irq handler (irq==true) or an NMI handler (irq==false).  However,
> recent changes have applied notrace to a few critical functions such
> that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> on in_nmi().  Note that in_nmi() works no differently than before,
> but rather that tracing is now prohibited in code regions where in_nmi()
> would incorrectly report NMI state.
> 
> Therefore remove the "irq" parameter and inlines rcu_nmi_enter_common() and
> rcu_nmi_exit_common() into rcu_nmi_enter() and rcu_nmi_exit(),
> respectively.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/rcu/tree.c |   47 +++++++++++++++--------------------------------
>   1 file changed, 15 insertions(+), 32 deletions(-)

I already sent a RB for the first patches for this serie, and went through the
remaining of them (20-36). I am not very familiar with some these areas so for
what it's worth:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -627,16 +627,18 @@ noinstr void rcu_user_enter(void)
>   }
>   #endif /* CONFIG_NO_HZ_FULL */
>   
> -/*
> +/**
> + * rcu_nmi_exit - inform RCU of exit from NMI context
> + *
>    * If we are returning from the outermost NMI handler that interrupted an
>    * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
>    * to let the RCU grace-period handling know that the CPU is back to
>    * being RCU-idle.
>    *
> - * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_exit(), be sure to test
>    * with CONFIG_RCU_EQS_DEBUG=y.
>    */
> -static __always_inline void rcu_nmi_exit_common(bool irq)
> +noinstr void rcu_nmi_exit(void)
>   {
>   	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>   
> @@ -667,7 +669,7 @@ static __always_inline void rcu_nmi_exit
>   	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>   	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>   
> -	if (irq)
> +	if (!in_nmi())
>   		rcu_prepare_for_idle();
>   	instr_end();
>   
> @@ -675,22 +677,11 @@ static __always_inline void rcu_nmi_exit
>   	rcu_dynticks_eqs_enter();
>   	// ... but is no longer watching here.
>   
> -	if (irq)
> +	if (!in_nmi())
>   		rcu_dynticks_task_enter();
>   }
>   
>   /**
> - * rcu_nmi_exit - inform RCU of exit from NMI context
> - *
> - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> - * with CONFIG_RCU_EQS_DEBUG=y.
> - */
> -void noinstr rcu_nmi_exit(void)
> -{
> -	rcu_nmi_exit_common(false);
> -}
> -
> -/**
>    * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
>    *
>    * Exit from an interrupt handler, which might possibly result in entering
> @@ -712,7 +703,7 @@ void noinstr rcu_nmi_exit(void)
>   void noinstr rcu_irq_exit(void)
>   {
>   	lockdep_assert_irqs_disabled();
> -	rcu_nmi_exit_common(true);
> +	rcu_nmi_exit();
>   }
>   
>   /*
> @@ -801,7 +792,7 @@ void noinstr rcu_user_exit(void)
>   #endif /* CONFIG_NO_HZ_FULL */
>   
>   /**
> - * rcu_nmi_enter_common - inform RCU of entry to NMI context
> + * rcu_nmi_enter - inform RCU of entry to NMI context
>    * @irq: Is this call from rcu_irq_enter?
>    *
>    * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> @@ -810,10 +801,10 @@ void noinstr rcu_user_exit(void)
>    * long as the nesting level does not overflow an int.  (You will probably
>    * run out of stack space first.)
>    *
> - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_enter(), be sure to test
>    * with CONFIG_RCU_EQS_DEBUG=y.
>    */
> -static __always_inline void rcu_nmi_enter_common(bool irq)
> +noinstr void rcu_nmi_enter(void)
>   {
>   	long incby = 2;
>   	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> @@ -831,18 +822,18 @@ static __always_inline void rcu_nmi_ente
>   	 */
>   	if (rcu_dynticks_curr_cpu_in_eqs()) {
>   
> -		if (irq)
> +		if (!in_nmi())
>   			rcu_dynticks_task_exit();
>   
>   		// RCU is not watching here ...
>   		rcu_dynticks_eqs_exit();
>   		// ... but is watching here.
>   
> -		if (irq)
> +		if (!in_nmi())
>   			rcu_cleanup_after_idle();
>   
>   		incby = 1;
> -	} else if (irq) {
> +	} else if (!in_nmi()) {
>   		instr_begin();
>   		if (tick_nohz_full_cpu(rdp->cpu) &&
>   		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> @@ -877,14 +868,6 @@ static __always_inline void rcu_nmi_ente
>   }
>   
>   /**
> - * rcu_nmi_enter - inform RCU of entry to NMI context
> - */
> -noinstr void rcu_nmi_enter(void)
> -{
> -	rcu_nmi_enter_common(false);
> -}
> -
> -/**
>    * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
>    *
>    * Enter an interrupt handler, which might possibly result in exiting
> @@ -909,7 +892,7 @@ noinstr void rcu_nmi_enter(void)
>   noinstr void rcu_irq_enter(void)
>   {
>   	lockdep_assert_irqs_disabled();
> -	rcu_nmi_enter_common(true);
> +	rcu_nmi_enter();
>   }
>   
>   /*
> 
