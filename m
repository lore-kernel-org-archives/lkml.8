Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED49BC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A229D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4ko0QwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBFPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:50:32 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:39693 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgBFPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:50:31 -0500
Received: by mail-wr1-f74.google.com with SMTP id 90so3628640wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3Gfnz+tIXog3sdZ5QXRWp8P2M7Buzp6H7vTqH3O8Vf8=;
        b=T4ko0QwIeXfQIW+1u/UJhREGHiEtJmDHxkuB60dRzVJ17qH8YAKImd4KgypKE277hs
         N6/7+0iDnD7176iVGTx4Gx8iZ6cJUFv+krL6zOY0jSYLCxvbRMNGPF4G7caNkUKlIXri
         1sF+p0Iq7QpC/jkaBd6yNVG7H7FYKBiIN76qzFqXqfZb8UreIMK2vFsetUEQNjL/Ht7x
         YZqfjD0svqveh8J4ZgqDVIquiF6KbpK/HJoaryHslN+BCvouKtuifyEmDKmeQ3Xo+SG4
         2ggUIuxBO/US5m79fPCTTUzbs3uhfjCxB+Bl/dIhN4kr4Otr+Mm752GYheHnFLTW5iUS
         l5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3Gfnz+tIXog3sdZ5QXRWp8P2M7Buzp6H7vTqH3O8Vf8=;
        b=MDXOU5Kx169emR+ODbZkWG1SMv7xpiGROUdI3/XWivKgUN3JRIiUnMtR2x7SdlTZAf
         YnNVpizZ3xkYALKxqCxtLs8Qw4ibgqwdJjTaDA/2X1LiQB2J6zjhdT0i/sQo8dFF9VZR
         EXGqevIgKzEBL8azhCVYg9Zb5yWTFlbfkpQMmGtmFkSJFnzwj9RMFvrCtl3VHcvjCRJq
         GuAVsI6r9h2paW44ZPvIMiFHoKHBp/c0Uz+MfhA4PdOQuaFy9OFDM08eX3J66Ccj5wMv
         4idJp96Z3yGIRgpfxiporGEwbjhMk5olqld82XtEbM5oWRG6hgUC+XCqObwfCP6CMjC+
         uxHg==
X-Gm-Message-State: APjAAAVdJ57GMAzKJbEmpBpmLyxoRgSRXbvurVl0YSnyXNWoebetUoZV
        xbqkhs3NFwAUdgMDT+jfT212Lv5Akg==
X-Google-Smtp-Source: APXvYqysGKs9JLoCN3P65itJJ1S4KuNOPsuvQkXMG3SVPSgAMm9ZjE12WeWC3kEe3tE6HjXUiYpDU8lAdg==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr4662654wrh.371.1581004228065;
 Thu, 06 Feb 2020 07:50:28 -0800 (PST)
Date:   Thu,  6 Feb 2020 16:46:24 +0100
Message-Id: <20200206154626.243230-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/3] kcsan: Introduce KCSAN_ACCESS_ASSERT access type
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KCSAN_ACCESS_ASSERT access type may be used to introduce dummy reads
and writes to assert certain properties of concurrent code, where bugs
could not be detected as normal data races.

For example, a variable that is only meant to be written by a single
CPU, but may be read (without locking) by other CPUs must still be
marked properly to avoid data races. However, concurrent writes,
regardless if WRITE_ONCE() or not, would be a bug. Using
kcsan_check_access(&x, sizeof(x), KCSAN_ACCESS_ASSERT) would allow
catching such bugs.

To support KCSAN_ACCESS_ASSERT the following notable changes were made:
  * If an access is of type KCSAN_ASSERT_ACCESS, disable various filters
    that only apply to data races, so that all races that KCSAN observes are
    reported.
  * Bug reports that involve an ASSERT access type will be reported as
    "KCSAN: assert: race in ..." instead of "data-race"; this will help
    more easily distinguish them.
  * Update a few comments to just mention 'races' where we do not always
    mean pure data races.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Update comments to just say 'races' where we do not just mean data races.
* Distinguish bug-type in title of reports.
* Count assertion failures separately.
* Update comment on skip_report.
---
 include/linux/kcsan-checks.h | 18 ++++++++++-----
 kernel/kcsan/core.c          | 44 +++++++++++++++++++++++++++++++-----
 kernel/kcsan/debugfs.c       |  1 +
 kernel/kcsan/kcsan.h         |  7 ++++++
 kernel/kcsan/report.c        | 43 +++++++++++++++++++++++++----------
 lib/Kconfig.kcsan            | 24 ++++++++++++--------
 6 files changed, 103 insertions(+), 34 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index ef3ee233a3fa9..5dcadc221026e 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -6,10 +6,16 @@
 #include <linux/types.h>
 
 /*
- * Access type modifiers.
+ * ACCESS TYPE MODIFIERS
+ *
+ *   <none>: normal read access;
+ *   WRITE : write access;
+ *   ATOMIC: access is atomic;
+ *   ASSERT: access is not a regular access, but an assertion;
  */
 #define KCSAN_ACCESS_WRITE  0x1
 #define KCSAN_ACCESS_ATOMIC 0x2
+#define KCSAN_ACCESS_ASSERT 0x4
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
@@ -18,7 +24,7 @@
  */
 #ifdef CONFIG_KCSAN
 /**
- * __kcsan_check_access - check generic access for data races
+ * __kcsan_check_access - check generic access for races
  *
  * @ptr address of access
  * @size size of access
@@ -43,7 +49,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #endif
 
 /**
- * __kcsan_check_read - check regular read access for data races
+ * __kcsan_check_read - check regular read access for races
  *
  * @ptr address of access
  * @size size of access
@@ -51,7 +57,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
 
 /**
- * __kcsan_check_write - check regular write access for data races
+ * __kcsan_check_write - check regular write access for races
  *
  * @ptr address of access
  * @size size of access
@@ -60,7 +66,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
 /**
- * kcsan_check_read - check regular read access for data races
+ * kcsan_check_read - check regular read access for races
  *
  * @ptr address of access
  * @size size of access
@@ -68,7 +74,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
 
 /**
- * kcsan_check_write - check regular write access for data races
+ * kcsan_check_write - check regular write access for races
  *
  * @ptr address of access
  * @size size of access
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 82c2bef827d42..87ef01e40199d 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -56,7 +56,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 
 /*
  * SLOT_IDX_FAST is used in the fast-path. Not first checking the address's primary
- * slot (middle) is fine if we assume that data races occur rarely. The set of
+ * slot (middle) is fine if we assume that races occur rarely. The set of
  * indices {SLOT_IDX(slot, i) | i in [0, NUM_SLOTS)} is equivalent to
  * {SLOT_IDX_FAST(slot, i) | i in [0, NUM_SLOTS)}.
  */
@@ -178,6 +178,14 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
 		return true;
 
+	/*
+	 * Unless explicitly declared atomic, never consider an assertion access
+	 * as atomic. This allows using them also in atomic regions, such as
+	 * seqlocks, without implicitly changing their semantics.
+	 */
+	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+		return false;
+
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
 	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
 	    IS_ALIGNED((unsigned long)ptr, size))
@@ -298,7 +306,11 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		 */
 		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
 	}
-	kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+
+	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+		kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+	else
+		kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
 
 	user_access_restore(flags);
 }
@@ -307,6 +319,7 @@ static noinline void
 kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 {
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
 	union {
 		u8 _1;
@@ -429,13 +442,32 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		/*
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
+		 *
+		 * Count 'assert_failures' for each failed ASSERT access,
+		 * therefore both this thread and the racing thread may
+		 * increment this counter.
 		 */
-		kcsan_report(ptr, size, type, size > 8 || value_change,
-			     smp_processor_id(), KCSAN_REPORT_RACE_SIGNAL);
+		if (is_assert)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		/*
+		 * - If we were not able to observe a value change due to size
+		 *   constraints, always assume a value change.
+		 * - If the access type is an assertion, we also always assume a
+		 *   value change to always report the race.
+		 */
+		value_change = value_change || size > 8 || is_assert;
+
+		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
+			     KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change) {
 		/* Inferring a race, since the value should not have changed. */
+
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
-		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN))
+		if (is_assert)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, true,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
@@ -471,7 +503,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 				     &encoded_watchpoint);
 	/*
 	 * It is safe to check kcsan_is_enabled() after find_watchpoint in the
-	 * slow-path, as long as no state changes that cause a data race to be
+	 * slow-path, as long as no state changes that cause a race to be
 	 * detected and reported have occurred until kcsan_is_enabled() is
 	 * checked.
 	 */
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index bec42dab32ee8..a9dad44130e62 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -44,6 +44,7 @@ static const char *counter_to_name(enum kcsan_counter_id id)
 	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
 	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
 	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
+	case KCSAN_COUNTER_ASSERT_FAILURES:		return "assert_failures";
 	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
 	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
 	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 8492da45494bf..50078e7d43c32 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -39,6 +39,13 @@ enum kcsan_counter_id {
 	 */
 	KCSAN_COUNTER_DATA_RACES,
 
+	/*
+	 * Total number of ASSERT failures due to races. If the observed race is
+	 * due to two conflicting ASSERT type accesses, then both will be
+	 * counted.
+	 */
+	KCSAN_COUNTER_ASSERT_FAILURES,
+
 	/*
 	 * Number of times no watchpoints were available.
 	 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 7cd34285df740..3bc590e6be7e3 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -34,11 +34,11 @@ static struct {
 } other_info = { .ptr = NULL };
 
 /*
- * Information about reported data races; used to rate limit reporting.
+ * Information about reported races; used to rate limit reporting.
  */
 struct report_time {
 	/*
-	 * The last time the data race was reported.
+	 * The last time the race was reported.
 	 */
 	unsigned long time;
 
@@ -57,7 +57,7 @@ struct report_time {
  *
  * Therefore, we use a fixed-size array, which at most will occupy a page. This
  * still adequately rate limits reports, assuming that a) number of unique data
- * races is not excessive, and b) occurrence of unique data races within the
+ * races is not excessive, and b) occurrence of unique races within the
  * same time window is limited.
  */
 #define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
@@ -74,7 +74,7 @@ static struct report_time report_times[REPORT_TIMES_SIZE];
 static DEFINE_SPINLOCK(report_lock);
 
 /*
- * Checks if the data race identified by thread frames frame1 and frame2 has
+ * Checks if the race identified by thread frames frame1 and frame2 has
  * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
  */
 static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
@@ -90,7 +90,7 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
 
 	invalid_before = jiffies - msecs_to_jiffies(CONFIG_KCSAN_REPORT_ONCE_IN_MS);
 
-	/* Check if a matching data race report exists. */
+	/* Check if a matching race report exists. */
 	for (i = 0; i < REPORT_TIMES_SIZE; ++i) {
 		struct report_time *rt = &report_times[i];
 
@@ -114,7 +114,7 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
 		if (time_before(rt->time, invalid_before))
 			continue; /* before KCSAN_REPORT_ONCE_IN_MS ago */
 
-		/* Reported recently, check if data race matches. */
+		/* Reported recently, check if race matches. */
 		if ((rt->frame1 == frame1 && rt->frame2 == frame2) ||
 		    (rt->frame1 == frame2 && rt->frame2 == frame1))
 			return true;
@@ -142,11 +142,12 @@ skip_report(bool value_change, unsigned long top_frame)
 	 * 3. write watchpoint, conflicting write (value_change==true): report;
 	 * 4. write watchpoint, conflicting write (value_change==false): skip;
 	 * 5. write watchpoint, conflicting read (value_change==false): skip;
-	 * 6. write watchpoint, conflicting read (value_change==true): impossible;
+	 * 6. write watchpoint, conflicting read (value_change==true): report;
 	 *
 	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
-	 * data races where the write may have rewritten the same value; and
-	 * case 6 is simply impossible.
+	 * data races where the write may have rewritten the same value; case 6
+	 * is possible either if the size is larger than what we check value
+	 * changes for or the access type is KCSAN_ACCESS_ASSERT.
 	 */
 	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && !value_change) {
 		/*
@@ -178,11 +179,27 @@ static const char *get_access_type(int type)
 		return "write";
 	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked)";
+
+	/*
+	 * ASSERT variants:
+	 */
+	case KCSAN_ACCESS_ASSERT:
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_ATOMIC:
+		return "assert no writes";
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE:
+	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "assert no accesses";
+
 	default:
 		BUG();
 	}
 }
 
+static const char *get_bug_type(int type)
+{
+	return (type & KCSAN_ACCESS_ASSERT) != 0 ? "assert: race" : "data-race";
+}
+
 /* Return thread description: in task or interrupt. */
 static const char *get_thread_desc(int task_id)
 {
@@ -268,13 +285,15 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 		 * Do not print offset of functions to keep title short.
 		 */
 		cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
-		pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
+		pr_err("BUG: KCSAN: %s in %ps / %ps\n",
+		       get_bug_type(access_type | other_info.access_type),
 		       (void *)(cmp < 0 ? other_frame : this_frame),
 		       (void *)(cmp < 0 ? this_frame : other_frame));
 	} break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
-		pr_err("BUG: KCSAN: data-race in %pS\n", (void *)this_frame);
+		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(access_type),
+		       (void *)this_frame);
 		break;
 
 	default:
@@ -427,7 +446,7 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 	/*
 	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
 	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a data race in utilities used by
+	 * into lockdep via KCSAN if we detect a race in utilities used by
 	 * lockdep.
 	 */
 	lockdep_off();
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 9785bbf9a1d11..f0b791143c6ab 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,13 +4,17 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: dynamic data race detector"
+	bool "KCSAN: dynamic race detector"
 	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
 	select STACKTRACE
 	help
-	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic data race
-	  detector, which relies on compile-time instrumentation, and uses a
-	  watchpoint-based sampling approach to detect data races.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector,
+	  which relies on compile-time instrumentation, and uses a
+	  watchpoint-based sampling approach to detect races.
+
+	  KCSAN's primary purpose is to detect data races. KCSAN can also be
+	  used to check properties, with the help of provided assertions, of
+	  concurrent code where bugs do not manifest as data races.
 
 	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
@@ -85,14 +89,14 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP.
 
 config KCSAN_REPORT_ONCE_IN_MS
-	int "Duration in milliseconds, in which any given data race is only reported once"
+	int "Duration in milliseconds, in which any given race is only reported once"
 	default 3000
 	help
-	  Any given data race is only reported once in the defined time window.
-	  Different data races may still generate reports within a duration
-	  that is smaller than the duration defined here. This allows rate
-	  limiting reporting to avoid flooding the console with reports.
-	  Setting this to 0 disables rate limiting.
+	  Any given race is only reported once in the defined time window.
+	  Different races may still generate reports within a duration that is
+	  smaller than the duration defined here. This allows rate limiting
+	  reporting to avoid flooding the console with reports.  Setting this
+	  to 0 disables rate limiting.
 
 # The main purpose of the below options is to control reported data races (e.g.
 # in fuzzer configs), and are not expected to be switched frequently by other
-- 
2.25.0.341.g760bfbb309-goog

