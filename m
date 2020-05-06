Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBDEC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368BD20575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XXDepUHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEFPdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:33:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgEFPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:33:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FHpZL018896;
        Wed, 6 May 2020 15:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ksWL2BImAjFMUrmJfBHK8PrGlLoejtqO0zw1LKE1nTk=;
 b=XXDepUHrWUuluSxTMil7fnxBAMLCwtCKwFJiZi61Rsp19x9GyCZsKoFQxYpnetlKIQCd
 whjCJNJCW5KjBdgVc+PpMSb4mh+obkRUXznbaPmf4/WLRtZKn2zFyedYma5yB8732Tpw
 VrCPQLln0w03FaSdNltgWNJ5aSg5X5LShFE/A6xuv8/igvga+0Wq4ibxWgasV63b0OET
 dUuhAV3KmN0NXefDZuOM8+ib8vaTNNbh7qcUyMrSdx49YOa1EaPea0f6hgJlM6ktY2Gn
 ItT82Y4H2D0RhO8y9MsMkMEyhZR1rAE5SRuKHA9yWAf0QKLvG0BH2YjmtdEiFMvWudHz kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gnawuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:32:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FHTn9076493;
        Wed, 6 May 2020 15:30:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnjt13k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:30:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046FUVtm007437;
        Wed, 6 May 2020 15:30:31 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:30:31 -0700
Subject: Re: [patch V4 part 1 13/36] x86/kvm: Restrict ASYNC_PF to user space
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
 <20200505134059.369802541@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <f52c0df3-943b-ef1a-092b-fa9621454d46@oracle.com>
Date:   Wed, 6 May 2020 17:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.369802541@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> The async page fault injection into kernel space creates more problems than
> it solves. The host has absolutely no knowledge about the state of the
> guest if the fault happens in CPL0. The only restriction for the host is
> interrupt disabled state. If interrupts are enabled in the guest then the
> exception can hit arbitrary code. The HALT based wait in non-preemotible
> code is a hacky replacement for a proper hypercall.
> 
> For the ongoing work to restrict instrumentation and make the RCU idle
> interaction well defined the required extra work for supporting async
> pagefault in CPL0 is just not justified and creates complexity for a
> dubious benefit.
> 
> The CPL3 injection is well defined and does not cause any issues as it is
> more or less the same as a regular page fault from CPL3.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/kvm.c |  100 +++-----------------------------------------------
>   1 file changed, 7 insertions(+), 93 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -75,7 +75,6 @@ struct kvm_task_sleep_node {
>   	struct swait_queue_head wq;
>   	u32 token;
>   	int cpu;
> -	bool use_halt;
>   };
>   
>   static struct kvm_task_sleep_head {
> @@ -98,8 +97,7 @@ static struct kvm_task_sleep_node *_find
>   	return NULL;
>   }
>   
> -static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
> -				    struct kvm_task_sleep_node *n)
> +static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
>   {
>   	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
>   	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
> @@ -117,7 +115,6 @@ static bool kvm_async_pf_queue_task(u32
>   
>   	n->token = token;
>   	n->cpu = smp_processor_id();
> -	n->use_halt = use_halt;
>   	init_swait_queue_head(&n->wq);
>   	hlist_add_head(&n->link, &b->list);
>   	raw_spin_unlock(&b->lock);
> @@ -138,7 +135,7 @@ void kvm_async_pf_task_wait_schedule(u32
>   
>   	lockdep_assert_irqs_disabled();
>   
> -	if (!kvm_async_pf_queue_task(token, false, &n))
> +	if (!kvm_async_pf_queue_task(token, &n))
>   		return;
>   
>   	for (;;) {
> @@ -154,91 +151,10 @@ void kvm_async_pf_task_wait_schedule(u32
>   }
>   EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait_schedule);
>   
> -/*
> - * Invoked from the async page fault handler.
> - */
> -static void kvm_async_pf_task_wait_halt(u32 token)
> -{
> -	struct kvm_task_sleep_node n;
> -
> -	if (!kvm_async_pf_queue_task(token, true, &n))
> -		return;
> -
> -	for (;;) {
> -		if (hlist_unhashed(&n.link))
> -			break;
> -		/*
> -		 * No point in doing anything about RCU here. Any RCU read
> -		 * side critical section or RCU watching section can be
> -		 * interrupted by VMEXITs and the host is free to keep the
> -		 * vCPU scheduled out as long as it sees fit. This is not
> -		 * any different just because of the halt induced voluntary
> -		 * VMEXIT.
> -		 *
> -		 * Also the async page fault could have interrupted any RCU
> -		 * watching context, so invoking rcu_irq_exit()/enter()
> -		 * around this is not gaining anything.
> -		 */
> -		native_safe_halt();
> -		local_irq_disable();
> -	}
> -}
> -
> -/* Invoked from the async page fault handler */
> -static void kvm_async_pf_task_wait(u32 token, bool usermode)
> -{
> -	bool can_schedule;
> -
> -	/*
> -	 * No need to check whether interrupts were disabled because the
> -	 * host will (hopefully) only inject an async page fault into
> -	 * interrupt enabled regions.
> -	 *
> -	 * If CONFIG_PREEMPTION is enabled then check whether the code
> -	 * which triggered the page fault is preemptible. This covers user
> -	 * mode as well because preempt_count() is obviously 0 there.
> -	 *
> -	 * The check for rcu_preempt_depth() is also required because
> -	 * voluntary scheduling inside a rcu read locked section is not
> -	 * allowed.
> -	 *
> -	 * The idle task is already covered by this because idle always
> -	 * has a preempt count > 0.
> -	 *
> -	 * If CONFIG_PREEMPTION is disabled only allow scheduling when
> -	 * coming from user mode as there is no indication whether the
> -	 * context which triggered the page fault could schedule or not.
> -	 */
> -	if (IS_ENABLED(CONFIG_PREEMPTION))
> -		can_schedule = preempt_count() + rcu_preempt_depth() == 0;
> -	else
> -		can_schedule = usermode;
> -
> -	/*
> -	 * If the kernel context is allowed to schedule then RCU is
> -	 * watching because no preemptible code in the kernel is inside RCU
> -	 * idle state. So it can be treated like user mode. User mode is
> -	 * safe because the #PF entry invoked enter_from_user_mode().
> -	 *
> -	 * For the non schedulable case invoke rcu_irq_enter() for
> -	 * now. This will be moved out to the pagefault entry code later
> -	 * and only invoked when really needed.
> -	 */
> -	if (can_schedule) {
> -		kvm_async_pf_task_wait_schedule(token);
> -	} else {
> -		rcu_irq_enter();
> -		kvm_async_pf_task_wait_halt(token);
> -		rcu_irq_exit();
> -	}
> -}
> -
>   static void apf_task_wake_one(struct kvm_task_sleep_node *n)
>   {
>   	hlist_del_init(&n->link);
> -	if (n->use_halt)
> -		smp_send_reschedule(n->cpu);
> -	else if (swq_has_sleeper(&n->wq))
> +	if (swq_has_sleeper(&n->wq))
>   		swake_up_one(&n->wq);
>   }
>   
> @@ -337,8 +253,10 @@ bool __kvm_handle_async_pf(struct pt_reg
>   		panic("Host injected async #PF in interrupt disabled region\n");
>   
>   	if (reason == KVM_PV_REASON_PAGE_NOT_PRESENT) {
> -		/* page is swapped out by the host. */
> -		kvm_async_pf_task_wait(token, user_mode(regs));
> +		if (unlikely(!(user_mode(regs))))
> +			panic("Host injected async #PF in kernel mode\n");
> +		/* Page is swapped out by the host. */
> +		kvm_async_pf_task_wait_schedule(token);
>   	} else {
>   		rcu_irq_enter();
>   		kvm_async_pf_task_wake(token);
> @@ -397,10 +315,6 @@ static void kvm_guest_cpu_init(void)
>   		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));
>   
>   		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
> -
> -#ifdef CONFIG_PREEMPTION
> -		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
> -#endif
>   		pa |= KVM_ASYNC_PF_ENABLED;
>   
>   		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
> 
