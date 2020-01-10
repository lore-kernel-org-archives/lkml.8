Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C040FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820F92082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/cLsYwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAJSua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:50:30 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:38138 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgAJSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:50:26 -0500
Received: by mail-wm1-f73.google.com with SMTP id p2so1184341wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SRBx19RXSNdw51idBzh3Q+Tsvdj/UAcs73kMC/XQ8nE=;
        b=q/cLsYwhCw7fRbpC+hF4EZiNAeNE5WjzE/fpwk7rBgT1UESSAf29WLBhPuzKIrwE57
         B3FVe4bkQEKu8lMlhZ4M15jHJTTpv5ZAG/o0WA5IBZTmE6DPEPUwKW9ZgYocuH4Ogm3d
         bxahxv8f1MxL9iXKrXwKO2Gaer3lvaWb/jJ2DNE5D7kp3viBpwjvcUHhOzjenMTCUBDV
         knsRqByoQK7zNKV/PUKVqg1KpFtqQtJRSjvmqyp+IxyL/gib9jtL6EbTh+TrPovSzM+4
         dy7LINpH2UyeUkESzkMkh9cIblaA+sSwHh0uA+sJb58cEmLbykHCjM0n6MJy0S7QJas+
         eWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SRBx19RXSNdw51idBzh3Q+Tsvdj/UAcs73kMC/XQ8nE=;
        b=kWJNwlmyspvwSfR1r0AUzTXXltt1LIHXNQSjleo6dOgCWNYSYaRHvp9llIIFMV1VHc
         yG2JcSxHo4cKk0Ms0fPGpCw9f+h1iief6qsvcXDBo1Lu8k5C8Tq9dbx1efT5SQ5C8Ude
         qqZoI2nFJh5/ZgvUtrIcSq7TqOA2LAH8nCnyyTxMc2HIW1iTcXGX7f8V/4IMGcxJwD3X
         r6k6C6WYbg38yNlQoScJv/WAbBLg5UHalzSmDggHHHvtyhPq1KD3Fh99Qx7+f0O/nk1u
         08Mk4GANy9qrSAF6i0BuClDByhf2JjTokQKLKIr7bY4O9/ICZfAEyU2PK+yvBdDGKG9R
         bJZg==
X-Gm-Message-State: APjAAAX4c6Bzk+PBOtnVsi7H3YiNCQZcO6P3JCHEXLCFlo49lippjx4Y
        jKDceRNLVq1Dm0FLolSvI7+h6IZMGQ==
X-Google-Smtp-Source: APXvYqxcy1xWT5GPo6nvkStzE6RUxYRdaeQYs1fhRZ/3VHrabhNgsRdWFPk313CihSGx5Z0VcDvUaTVKxg==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr4720679wrj.325.1578682224730;
 Fri, 10 Jan 2020 10:50:24 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:48:34 +0100
In-Reply-To: <20200110184834.192636-1-elver@google.com>
Message-Id: <20200110184834.192636-3-elver@google.com>
Mime-Version: 1.0
References: <20200110184834.192636-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu v2 2/2] kcsan: Rate-limit reporting per data races
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN data-race reports can occur quite frequently, so much so as
to render the system useless.  This commit therefore adds support for
time-based rate-limiting KCSAN reports, with the time interval specified
by a new KCSAN_REPORT_ONCE_IN_MS Kconfig option.  The default is 3000
milliseconds, also known as three seconds.

Because KCSAN must detect data races in allocators and in other contexts
where use of allocation is ill-advised, a fixed-size array is used to
buffer reports during each reporting interval.  To reduce the number of
reports lost due to array overflow, this commit stores only one instance
of duplicate reports, which has the benefit of further reducing KCSAN's
console output rate.

Reported-by: Qian Cai <cai@lca.pw>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
v2:
* Paul E. McKenney: commit message reword.
* Use jiffies instead of ktime -- we want to avoid calling into any
  further complex functions, since KCSAN may also detect data races in
  them, and as a result potentially leading to observing corrupt state
  (e.g. here, observing corrupt ktime_t value).
---
 kernel/kcsan/report.c | 110 ++++++++++++++++++++++++++++++++++++++----
 lib/Kconfig.kcsan     |  10 ++++
 2 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 9f503ca2ff7a..b5b4feea49de 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
@@ -31,12 +32,99 @@ static struct {
 	int			num_stack_entries;
 } other_info = { .ptr = NULL };
 
+/*
+ * Information about reported data races; used to rate limit reporting.
+ */
+struct report_time {
+	/*
+	 * The last time the data race was reported.
+	 */
+	unsigned long time;
+
+	/*
+	 * The frames of the 2 threads; if only 1 thread is known, one frame
+	 * will be 0.
+	 */
+	unsigned long frame1;
+	unsigned long frame2;
+};
+
+/*
+ * Since we also want to be able to debug allocators with KCSAN, to avoid
+ * deadlock, report_times cannot be dynamically resized with krealloc in
+ * rate_limit_report.
+ *
+ * Therefore, we use a fixed-size array, which at most will occupy a page. This
+ * still adequately rate limits reports, assuming that a) number of unique data
+ * races is not excessive, and b) occurrence of unique data races within the
+ * same time window is limited.
+ */
+#define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
+#define REPORT_TIMES_SIZE                                                      \
+	(CONFIG_KCSAN_REPORT_ONCE_IN_MS > REPORT_TIMES_MAX ?                   \
+		 REPORT_TIMES_MAX :                                            \
+		 CONFIG_KCSAN_REPORT_ONCE_IN_MS)
+static struct report_time report_times[REPORT_TIMES_SIZE];
+
 /*
  * This spinlock protects reporting and other_info, since other_info is usually
  * required when reporting.
  */
 static DEFINE_SPINLOCK(report_lock);
 
+/*
+ * Checks if the data race identified by thread frames frame1 and frame2 has
+ * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
+ */
+static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
+{
+	struct report_time *use_entry = &report_times[0];
+	unsigned long invalid_before;
+	int i;
+
+	BUILD_BUG_ON(CONFIG_KCSAN_REPORT_ONCE_IN_MS != 0 && REPORT_TIMES_SIZE == 0);
+
+	if (CONFIG_KCSAN_REPORT_ONCE_IN_MS == 0)
+		return false;
+
+	invalid_before = jiffies - msecs_to_jiffies(CONFIG_KCSAN_REPORT_ONCE_IN_MS);
+
+	/* Check if a matching data race report exists. */
+	for (i = 0; i < REPORT_TIMES_SIZE; ++i) {
+		struct report_time *rt = &report_times[i];
+
+		/*
+		 * Must always select an entry for use to store info as we
+		 * cannot resize report_times; at the end of the scan, use_entry
+		 * will be the oldest entry, which ideally also happened before
+		 * KCSAN_REPORT_ONCE_IN_MS ago.
+		 */
+		if (time_before(rt->time, use_entry->time))
+			use_entry = rt;
+
+		/*
+		 * Initially, no need to check any further as this entry as well
+		 * as following entries have never been used.
+		 */
+		if (rt->time == 0)
+			break;
+
+		/* Check if entry expired. */
+		if (time_before(rt->time, invalid_before))
+			continue; /* before KCSAN_REPORT_ONCE_IN_MS ago */
+
+		/* Reported recently, check if data race matches. */
+		if ((rt->frame1 == frame1 && rt->frame2 == frame2) ||
+		    (rt->frame1 == frame2 && rt->frame2 == frame1))
+			return true;
+	}
+
+	use_entry->time = jiffies;
+	use_entry->frame1 = frame1;
+	use_entry->frame2 = frame2;
+	return false;
+}
+
 /*
  * Special rules to skip reporting.
  */
@@ -132,7 +220,9 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
 	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
 	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
-	int other_skipnr;
+	unsigned long this_frame = stack_entries[skipnr];
+	unsigned long other_frame = 0;
+	int other_skipnr = 0; /* silence uninit warnings */
 
 	/*
 	 * Must check report filter rules before starting to print.
@@ -143,34 +233,34 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
 		other_skipnr = get_stack_skipnr(other_info.stack_entries,
 						other_info.num_stack_entries);
+		other_frame = other_info.stack_entries[other_skipnr];
 
 		/* @value_change is only known for the other thread */
-		if (skip_report(other_info.access_type, value_change,
-				other_info.stack_entries[other_skipnr]))
+		if (skip_report(other_info.access_type, value_change, other_frame))
 			return false;
 	}
 
+	if (rate_limit_report(this_frame, other_frame))
+		return false;
+
 	/* Print report header. */
 	pr_err("==================================================================\n");
 	switch (type) {
 	case KCSAN_REPORT_RACE_SIGNAL: {
-		void *this_fn = (void *)stack_entries[skipnr];
-		void *other_fn = (void *)other_info.stack_entries[other_skipnr];
 		int cmp;
 
 		/*
 		 * Order functions lexographically for consistent bug titles.
 		 * Do not print offset of functions to keep title short.
 		 */
-		cmp = sym_strcmp(other_fn, this_fn);
+		cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
 		pr_err("BUG: KCSAN: data-race in %ps / %ps\n",
-		       cmp < 0 ? other_fn : this_fn,
-		       cmp < 0 ? this_fn : other_fn);
+		       (void *)(cmp < 0 ? other_frame : this_frame),
+		       (void *)(cmp < 0 ? this_frame : other_frame));
 	} break;
 
 	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
-		pr_err("BUG: KCSAN: data-race in %pS\n",
-		       (void *)stack_entries[skipnr]);
+		pr_err("BUG: KCSAN: data-race in %pS\n", (void *)this_frame);
 		break;
 
 	default:
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3f78b1434375..3552990abcfe 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -81,6 +81,16 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP. If false, the chosen value is always
 	  KCSAN_WATCH_SKIP.
 
+config KCSAN_REPORT_ONCE_IN_MS
+	int "Duration in milliseconds, in which any given data race is only reported once"
+	default 3000
+	help
+	  Any given data race is only reported once in the defined time window.
+	  Different data races may still generate reports within a duration
+	  that is smaller than the duration defined here. This allows rate
+	  limiting reporting to avoid flooding the console with reports.
+	  Setting this to 0 disables rate limiting.
+
 # Note that, while some of the below options could be turned into boot
 # parameters, to optimize for the common use-case, we avoid this because: (a)
 # it would impact performance (and we want to avoid static branch for all
-- 
2.25.0.rc1.283.g88dfdc4193-goog

