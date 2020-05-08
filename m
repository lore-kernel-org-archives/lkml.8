Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D44C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559572070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEHNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgEHNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A2C05BD43;
        Fri,  8 May 2020 06:46:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Km-0001nX-31; Fri, 08 May 2020 15:46:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B60521C0493;
        Fri,  8 May 2020 15:46:35 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:35 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce report access_info and other_info
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559564.8414.746368725737301152.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     135c0872d86948046d11d7083e36c930cc43ac93
Gitweb:        https://git.kernel.org/tip/135c0872d86948046d11d7083e36c930cc43ac93
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 18 Mar 2020 18:38:44 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:10 -07:00

kcsan: Introduce report access_info and other_info

Improve readability by introducing access_info and other_info structs,
and in preparation of the following commit in this series replaces the
single instance of other_info with an array of size 1.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c   |   6 +--
 kernel/kcsan/kcsan.h  |   2 +-
 kernel/kcsan/report.c | 147 ++++++++++++++++++++---------------------
 3 files changed, 77 insertions(+), 78 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index ee82008..f1c3862 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -321,7 +321,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
-		kcsan_report(ptr, size, type, true, raw_smp_processor_id(),
+		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT);
 	} else {
 		/*
@@ -500,8 +500,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
-		kcsan_report(ptr, size, type, value_change, raw_smp_processor_id(),
-			     KCSAN_REPORT_RACE_SIGNAL);
+		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
@@ -511,7 +510,6 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
-				     raw_smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
 	}
 
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index e282f8b..6630dfe 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -135,7 +135,7 @@ enum kcsan_report_type {
  * Print a race report from thread that encountered the race.
  */
 extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change, int cpu_id,
+			 enum kcsan_value_change value_change,
 			 enum kcsan_report_type type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 18f9d3b..de234d1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -19,18 +19,23 @@
  */
 #define NUM_STACK_ENTRIES 64
 
+/* Common access info. */
+struct access_info {
+	const volatile void	*ptr;
+	size_t			size;
+	int			access_type;
+	int			task_pid;
+	int			cpu_id;
+};
+
 /*
  * Other thread info: communicated from other racing thread to thread that set
  * up the watchpoint, which then prints the complete report atomically. Only
  * need one struct, as all threads should to be serialized regardless to print
  * the reports, with reporting being in the slow-path.
  */
-static struct {
-	const volatile void	*ptr;
-	size_t			size;
-	int			access_type;
-	int			task_pid;
-	int			cpu_id;
+struct other_info {
+	struct access_info	ai;
 	unsigned long		stack_entries[NUM_STACK_ENTRIES];
 	int			num_stack_entries;
 
@@ -52,7 +57,9 @@ static struct {
 	 * that populated @other_info until it has been consumed.
 	 */
 	struct task_struct	*task;
-} other_info;
+};
+
+static struct other_info other_infos[1];
 
 /*
  * Information about reported races; used to rate limit reporting.
@@ -238,7 +245,7 @@ static const char *get_thread_desc(int task_id)
 }
 
 /* Helper to skip KCSAN-related functions in stack-trace. */
-static int get_stack_skipnr(unsigned long stack_entries[], int num_entries)
+static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
 {
 	char buf[64];
 	int skip = 0;
@@ -279,9 +286,10 @@ static void print_verbose_info(struct task_struct *task)
 /*
  * Returns true if a report was generated, false otherwise.
  */
-static bool print_report(const volatile void *ptr, size_t size, int access_type,
-			 enum kcsan_value_change value_change, int cpu_id,
-			 enum kcsan_report_type type)
+static bool print_report(enum kcsan_value_change value_change,
+			 enum kcsan_report_type type,
+			 const struct access_info *ai,
+			 const struct other_info *other_info)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
@@ -297,9 +305,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 		return false;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
-		other_skipnr = get_stack_skipnr(other_info.stack_entries,
-						other_info.num_stack_entries);
-		other_frame = other_info.stack_entries[other_skipnr];
+		other_skipnr = get_stack_skipnr(other_info->stack_entries,
+						other_info->num_stack_entries);
+		other_frame = other_info->stack_entries[other_skipnr];
 
 		/* @value_change is only known for the other thread */
 		if (skip_report(value_change, other_frame))
@@ -321,13 +329,13 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 		 */
 		cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
 		pr_err("BUG: KCSAN: %s in %ps / %ps\n",
-		       get_bug_type(access_type | other_info.access_type),
+		       get_bug_type(ai->access_type | other_info->ai.access_type),
 		       (void *)(cmp < 0 ? other_frame : this_frame),
 		       (void *)(cmp < 0 ? this_frame : other_frame));
 	} break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
-		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(access_type),
+		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(ai->access_type),
 		       (void *)this_frame);
 		break;
 
@@ -341,30 +349,28 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	switch (type) {
 	case KCSAN_REPORT_RACE_SIGNAL:
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(other_info.access_type), other_info.ptr,
-		       other_info.size, get_thread_desc(other_info.task_pid),
-		       other_info.cpu_id);
+		       get_access_type(other_info->ai.access_type), other_info->ai.ptr,
+		       other_info->ai.size, get_thread_desc(other_info->ai.task_pid),
+		       other_info->ai.cpu_id);
 
 		/* Print the other thread's stack trace. */
-		stack_trace_print(other_info.stack_entries + other_skipnr,
-				  other_info.num_stack_entries - other_skipnr,
+		stack_trace_print(other_info->stack_entries + other_skipnr,
+				  other_info->num_stack_entries - other_skipnr,
 				  0);
 
 		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
-			print_verbose_info(other_info.task);
+			print_verbose_info(other_info->task);
 
 		pr_err("\n");
 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(access_type), ptr, size,
-		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
-		       cpu_id);
+		       get_access_type(ai->access_type), ai->ptr, ai->size,
+		       get_thread_desc(ai->task_pid), ai->cpu_id);
 		break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
 		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
-		       get_access_type(access_type), ptr, size,
-		       get_thread_desc(in_task() ? task_pid_nr(current) : -1),
-		       cpu_id);
+		       get_access_type(ai->access_type), ai->ptr, ai->size,
+		       get_thread_desc(ai->task_pid), ai->cpu_id);
 		break;
 
 	default:
@@ -386,22 +392,23 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	return true;
 }
 
-static void release_report(unsigned long *flags, enum kcsan_report_type type)
+static void release_report(unsigned long *flags, struct other_info *other_info)
 {
-	if (type == KCSAN_REPORT_RACE_SIGNAL)
-		other_info.ptr = NULL; /* mark for reuse */
+	if (other_info)
+		other_info->ai.ptr = NULL; /* Mark for reuse. */
 
 	spin_unlock_irqrestore(&report_lock, *flags);
 }
 
 /*
- * Sets @other_info.task and awaits consumption of @other_info.
+ * Sets @other_info->task and awaits consumption of @other_info.
  *
  * Precondition: report_lock is held.
  * Postcondition: report_lock is held.
  */
-static void
-set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
+static void set_other_info_task_blocking(unsigned long *flags,
+					 const struct access_info *ai,
+					 struct other_info *other_info)
 {
 	/*
 	 * We may be instrumenting a code-path where current->state is already
@@ -418,7 +425,7 @@ set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
 	 */
 	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
 
-	other_info.task = current;
+	other_info->task = current;
 	do {
 		if (is_running) {
 			/*
@@ -438,19 +445,19 @@ set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
 		spin_lock_irqsave(&report_lock, *flags);
 		if (timeout-- < 0) {
 			/*
-			 * Abort. Reset other_info.task to NULL, since it
+			 * Abort. Reset @other_info->task to NULL, since it
 			 * appears the other thread is still going to consume
 			 * it. It will result in no verbose info printed for
 			 * this task.
 			 */
-			other_info.task = NULL;
+			other_info->task = NULL;
 			break;
 		}
 		/*
 		 * If @ptr nor @current matches, then our information has been
 		 * consumed and we may continue. If not, retry.
 		 */
-	} while (other_info.ptr == ptr && other_info.task == current);
+	} while (other_info->ai.ptr == ai->ptr && other_info->task == current);
 	if (is_running)
 		set_current_state(TASK_RUNNING);
 }
@@ -460,9 +467,8 @@ set_other_info_task_blocking(unsigned long *flags, const volatile void *ptr)
  * acquires the matching other_info and returns true. If other_info is not
  * required for the report type, simply acquires report_lock and returns true.
  */
-static bool prepare_report(unsigned long *flags, const volatile void *ptr,
-			   size_t size, int access_type, int cpu_id,
-			   enum kcsan_report_type type)
+static bool prepare_report(unsigned long *flags, enum kcsan_report_type type,
+			   const struct access_info *ai, struct other_info *other_info)
 {
 	if (type != KCSAN_REPORT_CONSUMED_WATCHPOINT &&
 	    type != KCSAN_REPORT_RACE_SIGNAL) {
@@ -476,18 +482,14 @@ retry:
 
 	switch (type) {
 	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
-		if (other_info.ptr != NULL)
+		if (other_info->ai.ptr)
 			break; /* still in use, retry */
 
-		other_info.ptr			= ptr;
-		other_info.size			= size;
-		other_info.access_type		= access_type;
-		other_info.task_pid		= in_task() ? task_pid_nr(current) : -1;
-		other_info.cpu_id		= cpu_id;
-		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
+		other_info->ai = *ai;
+		other_info->num_stack_entries = stack_trace_save(other_info->stack_entries, NUM_STACK_ENTRIES, 1);
 
 		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
-			set_other_info_task_blocking(flags, ptr);
+			set_other_info_task_blocking(flags, ai, other_info);
 
 		spin_unlock_irqrestore(&report_lock, *flags);
 
@@ -498,37 +500,31 @@ retry:
 		return false;
 
 	case KCSAN_REPORT_RACE_SIGNAL:
-		if (other_info.ptr == NULL)
+		if (!other_info->ai.ptr)
 			break; /* no data available yet, retry */
 
 		/*
 		 * First check if this is the other_info we are expecting, i.e.
 		 * matches based on how watchpoint was encoded.
 		 */
-		if (!matching_access((unsigned long)other_info.ptr &
-					     WATCHPOINT_ADDR_MASK,
-				     other_info.size,
-				     (unsigned long)ptr & WATCHPOINT_ADDR_MASK,
-				     size))
+		if (!matching_access((unsigned long)other_info->ai.ptr & WATCHPOINT_ADDR_MASK, other_info->ai.size,
+				     (unsigned long)ai->ptr & WATCHPOINT_ADDR_MASK, ai->size))
 			break; /* mismatching watchpoint, retry */
 
-		if (!matching_access((unsigned long)other_info.ptr,
-				     other_info.size, (unsigned long)ptr,
-				     size)) {
+		if (!matching_access((unsigned long)other_info->ai.ptr, other_info->ai.size,
+				     (unsigned long)ai->ptr, ai->size)) {
 			/*
 			 * If the actual accesses to not match, this was a false
 			 * positive due to watchpoint encoding.
 			 */
-			kcsan_counter_inc(
-				KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+			kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
 
 			/* discard this other_info */
-			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
+			release_report(flags, other_info);
 			return false;
 		}
 
-		access_type |= other_info.access_type;
-		if ((access_type & KCSAN_ACCESS_WRITE) == 0) {
+		if (!((ai->access_type | other_info->ai.access_type) & KCSAN_ACCESS_WRITE)) {
 			/*
 			 * While the address matches, this is not the other_info
 			 * from the thread that consumed our watchpoint, since
@@ -561,15 +557,11 @@ retry:
 			 * data, and at this point the likelihood that we
 			 * re-report the same race again is high.
 			 */
-			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
+			release_report(flags, other_info);
 			return false;
 		}
 
-		/*
-		 * Matching & usable access in other_info: keep other_info_lock
-		 * locked, as this thread consumes it to print the full report;
-		 * unlocked in release_report.
-		 */
+		/* Matching access in other_info. */
 		return true;
 
 	default:
@@ -582,10 +574,19 @@ retry:
 }
 
 void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-		  enum kcsan_value_change value_change, int cpu_id,
+		  enum kcsan_value_change value_change,
 		  enum kcsan_report_type type)
 {
 	unsigned long flags = 0;
+	const struct access_info ai = {
+		.ptr		= ptr,
+		.size		= size,
+		.access_type	= access_type,
+		.task_pid	= in_task() ? task_pid_nr(current) : -1,
+		.cpu_id		= raw_smp_processor_id()
+	};
+	struct other_info *other_info = type == KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
+					? NULL : &other_infos[0];
 
 	/*
 	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
@@ -596,19 +597,19 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	lockdep_off();
 
 	kcsan_disable_current();
-	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
+	if (prepare_report(&flags, type, &ai, other_info)) {
 		/*
 		 * Never report if value_change is FALSE, only if we it is
 		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
 		 * be done once we know the full stack trace in print_report().
 		 */
 		bool reported = value_change != KCSAN_VALUE_CHANGE_FALSE &&
-				print_report(ptr, size, access_type, value_change, cpu_id, type);
+				print_report(value_change, type, &ai, other_info);
 
 		if (reported && panic_on_warn)
 			panic("panic_on_warn set ...\n");
 
-		release_report(&flags, type);
+		release_report(&flags, other_info);
 	}
 	kcsan_enable_current();
 
