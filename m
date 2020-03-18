Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284BDC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29C620714
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCRUTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:19:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58130 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgCRUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:19:33 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEf9s-0004wk-AH; Wed, 18 Mar 2020 21:19:20 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 72D521040C5; Wed, 18 Mar 2020 21:19:15 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kyung Min Park <kyung.min.park@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        ak@linux.intel.com, tony.luck@intel.com, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com
Subject: Re: [PATCH 1/2] x86/asm: Define a few helpers in delay_waitx()
In-Reply-To: <1582744258-42744-2-git-send-email-kyung.min.park@intel.com>
References: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com> <1582744258-42744-2-git-send-email-kyung.min.park@intel.com>
Date:   Wed, 18 Mar 2020 21:19:15 +0100
Message-ID: <87lfnxa01o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kyung Min Park <kyung.min.park@intel.com> writes:

The subsystem prefix wants to be 'x86/delay:' please. This has nothing to
do with asm. Applies to both patches.

"Define a few helpers in delay_waitx()" misses 'm' before 'wait' and is
not really a precise short description of the change. Something like:

  x86/delay: Refactor delay_mwaitx() for TPAUSE support

makes it pretty clear what this is about, right?

> -static void delay_mwaitx(unsigned long __loops)
> +static void mwaitx(u64 unused, u64 loops)

This is just wrong. mwaitx() is not what this function does. mwaitx is
associated to the actual instruction name. The original name was pretty
clear what this function does. Ditto for the tpause() implementation.
See below.

>  {

Also the loops argument/variable names are really misleading. It is TSC
cycles here. I know you just moved code around, but there is nothing
wrong with cleaning it up while at it.

> -	u64 start, end, delay, loops = __loops;
> +	u64 delay;
> +
> +	delay = min_t(u64, MWAITX_MAX_LOOPS, loops);

MAX_LOOPS is equally bogus. Yes I know it's not your fault ...

> +	/*
> +	 * Use cpu_tss_rw as a cacheline-aligned, seldomly
> +	 * accessed per-cpu variable as the monitor target.
> +	 */
> +	__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
> +
> +	/*
> +	 * AMD, like Intel, supports the EAX hint and EAX=0xf
> +	 * means, do not enter any deep C-state and we use it
> +	 * here in delay() to minimize wakeup latency.

You moved the comments one indentation level up. So the comments can use
the full width now, right?

> +	 */
> +	__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
> +}
> +
> +static void (*wait_func)(u64, u64);

This really wants to be named so it's obvious what this is for. And the
arguments should have names as well.  Aside of that it wants to be
marked __ro_after_init and both function pointers moved to one place and
not randomly sprinkled into the code.

> +
> +/*
> + * Call a vendor specific function to delay for a given
> + * amount of time. Because these functions may return
> + * earlier than requested, check for actual elapsed time
> + * and call again until done.

Comments can use the full width.

> + */
> +static void delay_iterate(unsigned long __loops)

delay_iterate() is weird. Granted, it iterates, but it's still a delay
variant.

Contrary to delay_loop() and delay_tsc() it halts the CPU. The iteration
is an implementation detail required to deal with early return from the
halting instruction.

As this is based on halting the CPU the obvious function name is
delay_halt(). Then the new function pointer becomes delay_halt_fn. And
the actual functions are delay_halt_mwaitx() and then
delay_halt_tpause(). So it's all consistent.

Hmm?


> +{
> +	u64 start, end, loops = __loops;

Same comment vs. loops / cycles

>  
> @@ -134,22 +149,23 @@ static void delay_mwaitx(unsigned long __loops)
>   * Since we calibrate only once at boot, this
>   * function should be set once at boot and not changed
>   */
> -static void (*delay_fn)(unsigned long) = delay_loop;
> +static void (*delay_platform)(unsigned long) = delay_loop;

What's wrong with delay_fn?

delay_platform does not make any sense to me. How is delay_loop or
delay_tsc a platform? Naming really wants to be self explaining.

Also that variable wants to be __ro_after_init and the comment above it
wants to be cleaned up as well. 'should be set' is just wrong. It is
only set once at boot time.

In patch 2/2:

> +	/* Hard code the deeper (C0.2) sleep state because exit latency is
> +	 * small compared to the "microseconds" that usleep() will delay.
> +	 */

Please use proper comment style. This is not networking code.

Find below a cleanup patch for the file which wants to go before these
changes.

Thanks,

        tglx
----
Subject: x86/delay: Preparatory code cleanup
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 18 Mar 2020 17:01:31 +0100

The naming conventions in the delay code are confusing at best.

All delay variants use a loops argument and or variable which originates
from the original delay_loop() implementation. But all variants except
delay_loop() are based on TSC cycles.

Rename the argument to cycles and make it type u64 to avoid these weird
expansions to u64 in the functions.

Rename MWAITX_MAX_LOOPS to MWAITX_MAX_WAIT_CYCLES for the same reason and
fixup the comment of delay_mwaitx() as well.

Mark the delay_fn function pointer __ro_after_init and fixup the comment
for it.

No functional change and preparation for the upcoming TPAUSE based delay
variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mwait.h |    2 +-
 arch/x86/lib/delay.c         |   43 +++++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -20,7 +20,7 @@
 
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
-#define MWAITX_MAX_LOOPS		((u32)-1)
+#define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
 #define MWAITX_DISABLE_CSTATES		0xf0
 
 static inline void __monitor(const void *eax, unsigned long ecx,
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -27,9 +27,19 @@
 # include <asm/smp.h>
 #endif
 
+static void delay_loop(u64 __loops);
+
+/*
+ * Calibration and selection of the delay mechanism happens only once
+ * during boot.
+ */
+static void (*delay_fn)(u64) __ro_after_init = delay_loop;
+
 /* simple loop based delay: */
-static void delay_loop(unsigned long loops)
+static void delay_loop(u64 __loops)
 {
+	unsigned long loops = (unsigned long) __loops;
+
 	asm volatile(
 		"	test %0,%0	\n"
 		"	jz 3f		\n"
@@ -49,9 +59,9 @@ static void delay_loop(unsigned long loo
 }
 
 /* TSC based delay: */
-static void delay_tsc(unsigned long __loops)
+static void delay_tsc(u64 cycles)
 {
-	u64 bclock, now, loops = __loops;
+	u64 bclock, now;
 	int cpu;
 
 	preempt_disable();
@@ -59,7 +69,7 @@ static void delay_tsc(unsigned long __lo
 	bclock = rdtsc_ordered();
 	for (;;) {
 		now = rdtsc_ordered();
-		if ((now - bclock) >= loops)
+		if ((now - bclock) >= cycles)
 			break;
 
 		/* Allow RT tasks to run */
@@ -77,7 +87,7 @@ static void delay_tsc(unsigned long __lo
 		 * counter for this CPU.
 		 */
 		if (unlikely(cpu != smp_processor_id())) {
-			loops -= (now - bclock);
+			cycles -= (now - bclock);
 			cpu = smp_processor_id();
 			bclock = rdtsc_ordered();
 		}
@@ -87,24 +97,24 @@ static void delay_tsc(unsigned long __lo
 
 /*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
- * counts with TSC frequency. The input value is the loop of the
- * counter, it will exit when the timer expires.
+ * counts with TSC frequency. The input value is the number of TSC cycles
+ * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(unsigned long __loops)
+static void delay_mwaitx(u64 cycles)
 {
-	u64 start, end, delay, loops = __loops;
+	u64 start, end, delay;
 
 	/*
 	 * Timer value of 0 causes MWAITX to wait indefinitely, unless there
 	 * is a store on the memory monitored by MONITORX.
 	 */
-	if (loops == 0)
+	if (!cycles)
 		return;
 
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_LOOPS, loops);
+		delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
 
 		/*
 		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
@@ -121,21 +131,14 @@ static void delay_mwaitx(unsigned long _
 
 		end = rdtsc_ordered();
 
-		if (loops <= end - start)
+		if (cycles <= end - start)
 			break;
 
-		loops -= end - start;
-
+		cycles -= end - start;
 		start = end;
 	}
 }
 
-/*
- * Since we calibrate only once at boot, this
- * function should be set once at boot and not changed
- */
-static void (*delay_fn)(unsigned long) = delay_loop;
-
 void use_tsc_delay(void)
 {
 	if (delay_fn == delay_loop)
