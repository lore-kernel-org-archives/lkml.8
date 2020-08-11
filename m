Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871AF2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c46YpCUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgHKHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgHKHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:41:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1ur41PMwJaDcTMSo/nD4VartbQ+qRn6j+If8bFfsJQ=; b=c46YpCUa2s205EbeyhBAihRmIf
        we1pk0/2FhtINa1I7UTqooymivlx2sWDXjCXl7aZq9WiGO/XUe6gFoZenjEgui0n8Vc39imW8dpq3
        z6Kw9H2UA0hazMrlRwc8DbBtCEV+Uw/fesllEZ+CFwmCMjBU8Z0fROMqjyBn6dVNpLJ4PAtgRROaZ
        bWkYfbAs8rQUnFXX+2pdOgFMJO++0RalqOA5G6LJ9cSdNrqE0RiU16cteiv7ve3XiOqTz+AEFG60L
        IYrY2X2R96usta9vFjHZxW6m6wREEQ4jgy7Ctwk/unVsVD3y1o9idNOBAXN5+CxZaa+131KsUwryJ
        in8m3+mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5OuZ-00067x-1O; Tue, 11 Aug 2020 07:41:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56841980C9D; Tue, 11 Aug 2020 09:41:27 +0200 (CEST)
Date:   Tue, 11 Aug 2020 09:41:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200811074127.GR3982@worktop.programming.kicks-ass.net>
References: <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807151903.GA1263469@elver.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:19:03PM +0200, Marco Elver wrote:

> My hypothesis here is simply that kvm_wait() may be called in a place
> where we get the same case I mentioned to Peter,
> 
> 	raw_local_irq_save(); /* or other IRQs off without tracing */
> 	...
> 	kvm_wait() /* IRQ state tracing gets confused */
> 	...
> 	raw_local_irq_restore();
> 
> and therefore, using raw variants in kvm_wait() works. It's also safe
> because it doesn't call any other libraries that would result in corrupt

Yes, this is definitely an issue.

Tracing, we also musn't call into tracing when using raw_local_irq_*().
Because then we re-intoduce this same issue all over again.

Both halt() and safe_halt() are more paravirt calls, but given we're in
a KVM paravirt call already, I suppose we can directly use native_*()
here.

Something like so then... I suppose, but then the Xen variants need TLC
too.

---
 arch/x86/include/asm/irqflags.h |  4 ++--
 arch/x86/include/asm/kvm_para.h | 18 +++++++++---------
 arch/x86/kernel/kvm.c           | 14 +++++++-------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 02a0cf547d7b..7c614db25274 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -54,13 +54,13 @@ static __always_inline void native_irq_enable(void)
 	asm volatile("sti": : :"memory");
 }

-static inline __cpuidle void native_safe_halt(void)
+static __always_inline __cpuidle void native_safe_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
 }

-static inline __cpuidle void native_halt(void)
+static __always_inline __cpuidle void native_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 49d3a9edb06f..90f7ea58ebb0 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -30,7 +30,7 @@ static inline bool kvm_check_and_clear_guest_paused(void)
  * noted by the particular hypercall.
  */

-static inline long kvm_hypercall0(unsigned int nr)
+static __always_inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
 	asm volatile(KVM_HYPERCALL
@@ -40,7 +40,7 @@ static inline long kvm_hypercall0(unsigned int nr)
 	return ret;
 }

-static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
+static __always_inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 {
 	long ret;
 	asm volatile(KVM_HYPERCALL
@@ -50,8 +50,8 @@ static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 	return ret;
 }

-static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
-				  unsigned long p2)
+static __always_inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
+					   unsigned long p2)
 {
 	long ret;
 	asm volatile(KVM_HYPERCALL
@@ -61,8 +61,8 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 	return ret;
 }

-static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
-				  unsigned long p2, unsigned long p3)
+static __always_inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
+					   unsigned long p2, unsigned long p3)
 {
 	long ret;
 	asm volatile(KVM_HYPERCALL
@@ -72,9 +72,9 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
 	return ret;
 }

-static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
-				  unsigned long p2, unsigned long p3,
-				  unsigned long p4)
+static __always_inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
+					   unsigned long p2, unsigned long p3,
+					   unsigned long p4)
 {
 	long ret;
 	asm volatile(KVM_HYPERCALL
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 233c77d056c9..15f8dfd8812d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -779,7 +779,7 @@ arch_initcall(kvm_alloc_cpumask);
 #ifdef CONFIG_PARAVIRT_SPINLOCKS

 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
-static void kvm_kick_cpu(int cpu)
+static notrace kvm_kick_cpu(int cpu)
 {
 	int apicid;
 	unsigned long flags = 0;
@@ -790,14 +790,14 @@ static void kvm_kick_cpu(int cpu)

 #include <asm/qspinlock.h>

-static void kvm_wait(u8 *ptr, u8 val)
+static notrace kvm_wait(u8 *ptr, u8 val)
 {
 	unsigned long flags;

 	if (in_nmi())
 		return;

-	local_irq_save(flags);
+	raw_local_irq_save(flags);

 	if (READ_ONCE(*ptr) != val)
 		goto out;
@@ -808,16 +808,16 @@ static void kvm_wait(u8 *ptr, u8 val)
 	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
 	 */
 	if (arch_irqs_disabled_flags(flags))
-		halt();
+		native_halt();
 	else
-		safe_halt();
+		native_safe_halt();

 out:
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }

 #ifdef CONFIG_X86_32
-__visible bool __kvm_vcpu_is_preempted(long cpu)
+__visible notrace bool __kvm_vcpu_is_preempted(long cpu)
 {
 	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);


