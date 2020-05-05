Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C12068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgEEONw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729370AbgEEONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A96C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:48 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKA-0000SA-GY; Tue, 05 May 2020 16:13:30 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id F0E33FFC8D;
        Tue,  5 May 2020 16:13:29 +0200 (CEST)
Message-Id: <20200505134059.369802541@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
Subject: [patch V4 part 1 13/36] x86/kvm: Restrict ASYNC_PF to user space
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async page fault injection into kernel space creates more problems than
it solves. The host has absolutely no knowledge about the state of the
guest if the fault happens in CPL0. The only restriction for the host is
interrupt disabled state. If interrupts are enabled in the guest then the
exception can hit arbitrary code. The HALT based wait in non-preemotible
code is a hacky replacement for a proper hypercall.

For the ongoing work to restrict instrumentation and make the RCU idle
interaction well defined the required extra work for supporting async
pagefault in CPL0 is just not justified and creates complexity for a
dubious benefit.

The CPL3 injection is well defined and does not cause any issues as it is
more or less the same as a regular page fault from CPL3.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/kvm.c |  100 +++-----------------------------------------------
 1 file changed, 7 insertions(+), 93 deletions(-)

--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -75,7 +75,6 @@ struct kvm_task_sleep_node {
 	struct swait_queue_head wq;
 	u32 token;
 	int cpu;
-	bool use_halt;
 };
 
 static struct kvm_task_sleep_head {
@@ -98,8 +97,7 @@ static struct kvm_task_sleep_node *_find
 	return NULL;
 }
 
-static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
-				    struct kvm_task_sleep_node *n)
+static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
 {
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
@@ -117,7 +115,6 @@ static bool kvm_async_pf_queue_task(u32
 
 	n->token = token;
 	n->cpu = smp_processor_id();
-	n->use_halt = use_halt;
 	init_swait_queue_head(&n->wq);
 	hlist_add_head(&n->link, &b->list);
 	raw_spin_unlock(&b->lock);
@@ -138,7 +135,7 @@ void kvm_async_pf_task_wait_schedule(u32
 
 	lockdep_assert_irqs_disabled();
 
-	if (!kvm_async_pf_queue_task(token, false, &n))
+	if (!kvm_async_pf_queue_task(token, &n))
 		return;
 
 	for (;;) {
@@ -154,91 +151,10 @@ void kvm_async_pf_task_wait_schedule(u32
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait_schedule);
 
-/*
- * Invoked from the async page fault handler.
- */
-static void kvm_async_pf_task_wait_halt(u32 token)
-{
-	struct kvm_task_sleep_node n;
-
-	if (!kvm_async_pf_queue_task(token, true, &n))
-		return;
-
-	for (;;) {
-		if (hlist_unhashed(&n.link))
-			break;
-		/*
-		 * No point in doing anything about RCU here. Any RCU read
-		 * side critical section or RCU watching section can be
-		 * interrupted by VMEXITs and the host is free to keep the
-		 * vCPU scheduled out as long as it sees fit. This is not
-		 * any different just because of the halt induced voluntary
-		 * VMEXIT.
-		 *
-		 * Also the async page fault could have interrupted any RCU
-		 * watching context, so invoking rcu_irq_exit()/enter()
-		 * around this is not gaining anything.
-		 */
-		native_safe_halt();
-		local_irq_disable();
-	}
-}
-
-/* Invoked from the async page fault handler */
-static void kvm_async_pf_task_wait(u32 token, bool usermode)
-{
-	bool can_schedule;
-
-	/*
-	 * No need to check whether interrupts were disabled because the
-	 * host will (hopefully) only inject an async page fault into
-	 * interrupt enabled regions.
-	 *
-	 * If CONFIG_PREEMPTION is enabled then check whether the code
-	 * which triggered the page fault is preemptible. This covers user
-	 * mode as well because preempt_count() is obviously 0 there.
-	 *
-	 * The check for rcu_preempt_depth() is also required because
-	 * voluntary scheduling inside a rcu read locked section is not
-	 * allowed.
-	 *
-	 * The idle task is already covered by this because idle always
-	 * has a preempt count > 0.
-	 *
-	 * If CONFIG_PREEMPTION is disabled only allow scheduling when
-	 * coming from user mode as there is no indication whether the
-	 * context which triggered the page fault could schedule or not.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		can_schedule = preempt_count() + rcu_preempt_depth() == 0;
-	else
-		can_schedule = usermode;
-
-	/*
-	 * If the kernel context is allowed to schedule then RCU is
-	 * watching because no preemptible code in the kernel is inside RCU
-	 * idle state. So it can be treated like user mode. User mode is
-	 * safe because the #PF entry invoked enter_from_user_mode().
-	 *
-	 * For the non schedulable case invoke rcu_irq_enter() for
-	 * now. This will be moved out to the pagefault entry code later
-	 * and only invoked when really needed.
-	 */
-	if (can_schedule) {
-		kvm_async_pf_task_wait_schedule(token);
-	} else {
-		rcu_irq_enter();
-		kvm_async_pf_task_wait_halt(token);
-		rcu_irq_exit();
-	}
-}
-
 static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 {
 	hlist_del_init(&n->link);
-	if (n->use_halt)
-		smp_send_reschedule(n->cpu);
-	else if (swq_has_sleeper(&n->wq))
+	if (swq_has_sleeper(&n->wq))
 		swake_up_one(&n->wq);
 }
 
@@ -337,8 +253,10 @@ bool __kvm_handle_async_pf(struct pt_reg
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (reason == KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		/* page is swapped out by the host. */
-		kvm_async_pf_task_wait(token, user_mode(regs));
+		if (unlikely(!(user_mode(regs))))
+			panic("Host injected async #PF in kernel mode\n");
+		/* Page is swapped out by the host. */
+		kvm_async_pf_task_wait_schedule(token);
 	} else {
 		rcu_irq_enter();
 		kvm_async_pf_task_wake(token);
@@ -397,10 +315,6 @@ static void kvm_guest_cpu_init(void)
 		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));
 
 		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
-
-#ifdef CONFIG_PREEMPTION
-		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
-#endif
 		pa |= KVM_ASYNC_PF_ENABLED;
 
 		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))

