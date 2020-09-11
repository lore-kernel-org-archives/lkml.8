Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1312C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F02721D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vghDKLe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIKP5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIKP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:56:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48041C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sLXAoluFDtJ8Zc5CiVOegUS5j1nsglapDNRGh1P5SGM=; b=vghDKLe7g+ASu3Mr4jFooJRrWZ
        cLrBpF37AcDt0qkkZtTe4SYh0SHzOOqdmBED4KfSt+XTTUAJbvw26wX6DZqTHGzntddRq6QkjyZnz
        9JZNKqA9SlETk/er3CWk7UAcJLrp6TBvNfWJPkdrneIZl5UhEFuoL4Yf8kKcbvb6ozV5/0tm5EwdV
        gRZ+PsFsLqsJSUIIyhMrK9TniKdsanM/P56c4WrjxXjh4V/lEIN2qHMNhMY7DJFoUfUQRcJyPF5lP
        Ujgn8C1sADw338oLMOZN83YEgb/85m642vX6L7twC1XmiC0tFxpv7CjtU/R9NQvzC2qS7q3c5WjET
        SJa0k1tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGlP2-0001WH-Ck; Fri, 11 Sep 2020 15:55:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87F66303DA0;
        Fri, 11 Sep 2020 17:55:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69FD52B65D593; Fri, 11 Sep 2020 17:55:55 +0200 (CEST)
Date:   Fri, 11 Sep 2020 17:55:55 +0200
From:   peterz@infradead.org
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, laoar.shao@gmail.com,
        urezki@gmail.com, frederic@kernel.org
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200911155555.GX2674@hirez.programming.kicks-ass.net>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20200909090931.8836-1-qianjun.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2020 at 05:09:31PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When get the pending softirqs, it need to process all the pending
> softirqs in the while loop. If the processing time of each pending
> softirq is need more than 2 msec in this loop, or one of the softirq
> will running a long time, according to the original code logic, it
> will process all the pending softirqs without wakeuping ksoftirqd,
> which will cause a relatively large scheduling delay on the
> corresponding CPU, which we do not wish to see. The patch will check
> the total time to process pending softirq, if the time exceeds 2 ms
> we need to wakeup the ksofirqd to aviod large sched delay.

But what is all that unreadaable gibberish with pending_new_{flag,bit} ?

Random comments below..


> +#define MAX_SOFTIRQ_TIME_NS 2000000

	2*NSEC_PER_MSEC


> +DEFINE_PER_CPU(__u32, pending_new_flag);
> +DEFINE_PER_CPU(__u32, pending_next_bit);

__u32 is for userspace ABI, this is not it, use u32

> +#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> +	u64 end = sched_clock() + MAX_SOFTIRQ_TIME_NS;
>  	unsigned long old_flags = current->flags;
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
>  	bool in_hardirq;
> -	__u32 pending;
> -	int softirq_bit;
> +	__u32 pending, pending_left, pending_new;
> +	int softirq_bit, next_bit;
> +	unsigned long flags;
>  
>  	/*
>  	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
> @@ -277,10 +282,33 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  
>  	h = softirq_vec;
>  
> -	while ((softirq_bit = ffs(pending))) {
> -		unsigned int vec_nr;
> +	next_bit = per_cpu(pending_next_bit, smp_processor_id());
> +	per_cpu(pending_new_flag, smp_processor_id()) = 0;

	__this_cpu_read() / __this_cpu_write()

> +
> +	pending_left = pending &
> +		(SOFTIRQ_PENDING_MASK << next_bit);
> +	pending_new = pending &
> +		(SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));

The second mask is the inverse of the first.

> +	/*
> +	 * In order to be fair, we shold process the pengding bits by the
> +	 * last processing order.
> +	 */
> +	while ((softirq_bit = ffs(pending_left)) ||
> +		(softirq_bit = ffs(pending_new))) {
>  		int prev_count;
> +		unsigned int vec_nr = 0;
>  
> +		/*
> +		 * when the left pengding bits have been handled, we should
> +		 * to reset the h to softirq_vec.
> +		 */
> +		if (!ffs(pending_left)) {
> +			if (per_cpu(pending_new_flag, smp_processor_id()) == 0) {
> +				h = softirq_vec;
> +				per_cpu(pending_new_flag, smp_processor_id()) = 1;
> +			}
> +		}
>  		h += softirq_bit - 1;
>  
>  		vec_nr = h - softirq_vec;
> @@ -298,17 +326,44 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  			preempt_count_set(prev_count);
>  		}
>  		h++;
> -		pending >>= softirq_bit;
> +
> +		if (ffs(pending_left))

This is the _third_ ffs(pending_left), those things are _expensive_ (on
some archs, see include/asm-generic/bitops/__ffs.h).

> +			pending_left >>= softirq_bit;
> +		else
> +			pending_new >>= softirq_bit;
> +
> +		/*
> +		 * the softirq's action has been run too much time,
> +		 * so it may need to wakeup the ksoftirqd
> +		 */
> +		if (need_resched() && sched_clock() > end) {
> +			/*
> +			 * Ensure that the remaining pending bits will be
> +			 * handled.
> +			 */
> +			local_irq_save(flags);
> +			if (ffs(pending_left))

*fourth*...

> +				or_softirq_pending((pending_left << (vec_nr + 1)) |
> +							pending_new);
> +			else
> +				or_softirq_pending(pending_new << (vec_nr + 1));
> +			local_irq_restore(flags);
> +			per_cpu(pending_next_bit, smp_processor_id()) = vec_nr + 1;
> +			break;
> +		}
>  	}
>  
> +	/* reset the pending_next_bit */
> +	per_cpu(pending_next_bit, smp_processor_id()) = 0;
> +
>  	if (__this_cpu_read(ksoftirqd) == current)
>  		rcu_softirq_qs();
>  	local_irq_disable();
>  
>  	pending = local_softirq_pending();
>  	if (pending) {
> -		if (time_before(jiffies, end) && !need_resched() &&
> -		    --max_restart)
> +		if (!need_resched() && --max_restart &&
> +		    sched_clock() <= end)
>  			goto restart;
>  
>  		wakeup_softirqd();

This really wants to be a number of separate patches; and I quickly lost
the plot in your code. Instead of cleaning things up, you're making an
even bigger mess of things.

That said, I _think_ I've managed to decode what you want. See the
completely untested patches attached.



--ALfTUftag+2gvp1h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-softirq-fix-loop.patch"

Subject: softirq: Rewrite softirq processing loop
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:00:03 CEST 2020

Simplify the softirq processing loop by using the bitmap APIs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/softirq.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -258,9 +258,9 @@ asmlinkage __visible void __softirq_entr
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	unsigned long pending;
+	unsigned int vec_nr;
 	bool in_hardirq;
-	__u32 pending;
-	int softirq_bit;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -281,15 +281,13 @@ asmlinkage __visible void __softirq_entr
 
 	local_irq_enable();
 
-	h = softirq_vec;
+	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
+		unsigned int prev_count;
 
-	while ((softirq_bit = ffs(pending))) {
-		unsigned int vec_nr;
-		int prev_count;
+		__clear_bit(vec_nr, &pending);
 
-		h += softirq_bit - 1;
+		h = softirq_vec + vec_nr;
 
-		vec_nr = h - softirq_vec;
 		prev_count = preempt_count();
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
@@ -303,8 +301,6 @@ asmlinkage __visible void __softirq_entr
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
-		h++;
-		pending >>= softirq_bit;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)

--ALfTUftag+2gvp1h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-softirq-timo.patch"

Subject: softirq: Use sched_clock() based timeout
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:30:01 CEST 2020

Replace the jiffies based timeout with a sched_clock() based one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/softirq.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched/clock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -216,7 +217,7 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME	2*NSEC_PER_MSEC
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -254,9 +255,9 @@ static inline void lockdep_softirq_end(b
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
+	u64 start = sched_clock();
 	struct softirq_action *h;
 	unsigned long pending;
 	unsigned int vec_nr;
@@ -309,7 +310,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
+		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
 		    --max_restart)
 			goto restart;
 

--ALfTUftag+2gvp1h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-softirq-needs-break.patch"

Subject: softirq: Factor loop termination condition
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:17:20 CEST 2020


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/softirq.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -204,22 +204,6 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-/*
- * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
- *
- * These limits have been established via experimentation.
- * The two things to balance is latency against fairness -
- * we want to handle softirqs as soon as possible, but they
- * should not be able to lock up the box.
- */
-#define MAX_SOFTIRQ_TIME	2*NSEC_PER_MSEC
-#define MAX_SOFTIRQ_RESTART 10
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 /*
  * When we run softirqs from irq_exit() and thus on the hardirq stack we need
@@ -253,10 +237,33 @@ static inline bool lockdep_softirq_start
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+/*
+ * We restart softirq processing but break the loop if need_resched() is set or
+ * after 2 ms. The MAX_SOFTIRQ_RESTART guarantees a loop termination if
+ * sched_clock() were ever to stall.
+ *
+ * These limits have been established via experimentation.  The two things to
+ * balance is latency against fairness - we want to handle softirqs as soon as
+ * possible, but they should not be able to lock up the box.
+ */
+#define MAX_SOFTIRQ_TIME	2*NSEC_PER_MSEC
+#define MAX_SOFTIRQ_RESTART	10
+
+static inline bool __softirq_needs_break(u64 start)
+{
+	if (need_resched())
+		return true;
+
+	if (sched_clock() - start >= MAX_SOFTIRQ_TIME)
+		return true;
+
+	return false;
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
+	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	unsigned long old_flags = current->flags;
-	int max_restart = MAX_SOFTIRQ_RESTART;
 	u64 start = sched_clock();
 	struct softirq_action *h;
 	unsigned long pending;
@@ -310,8 +317,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
-		    --max_restart)
+		if (!__softirq_needs_break(start) && --max_restart)
 			goto restart;
 
 		wakeup_softirqd();

--ALfTUftag+2gvp1h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-softirq-break-more.patch"

Subject: softirq: Allow early break
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 17:50:17 CEST 2020

Allow terminating the softirq processing loop without finishing the
vectors.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/softirq.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -309,19 +309,23 @@ asmlinkage __visible void __softirq_entr
 			       prev_count, preempt_count());
 			preempt_count_set(prev_count);
 		}
+
+		if (pending && __softirq_needs_break(start))
+			break;
 	}
 
 	if (__this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
-	if (pending) {
-		if (!__softirq_needs_break(start) && --max_restart)
-			goto restart;
+	if (pending)
+		or_softirq_pending(pending);
+	else if ((pending = local_softirq_pending()) &&
+		 !__softirq_needs_break(start) &&
+		 --max_restart)
+		goto restart;
 
-		wakeup_softirqd();
-	}
+	wakeup_softirqd();
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);

--ALfTUftag+2gvp1h--
