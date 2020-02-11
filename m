Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5038C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8819421569
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSbEWpRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgBKQGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:06:00 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:60379 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgBKQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:05:59 -0500
Received: by mail-wm1-f73.google.com with SMTP id 7so1618901wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IEWEaZDheAZ38OwM/O2k0lFvb0/Si6DRYRmVuatFxC8=;
        b=NSbEWpRsJdao3ZyytFQrCU0167AuURj1ON1Tn17eE0IP2dcLng+akx29qr0oqxHDUg
         llGP0uHv9Q/xelid3Hzl9xCfFOAgH5L+DMi46H4pEnH9KQdbfE5hwz3hNowFwcwW/jnu
         4DYB4MssaeI1BKYYf0RfTAPz2Ryb0bzPvZvawxli1PxsoapsU47jVi3XzHbZ5X2DaC10
         Yu7YAeB7YGKAmF+JmumGnD1mfAHviEepXXq6CRUahGcwYKlS6P20ZsWR2W7OOWgDmjrf
         FYtAL8VNjcLbTLXa6odJfRiLVWRrKX27hrL0zswTGs+QqEvu1fD7IPcgQlpzimhvO5om
         /+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IEWEaZDheAZ38OwM/O2k0lFvb0/Si6DRYRmVuatFxC8=;
        b=BI2p5akIPVgaj1VFnLJLfPDaF2sUrbPvI4+NJsSqCAHFjFqKDEXor4pf1tG8VVX9YI
         BoBk1l3P6tkvkWDJxm7Wdk4fs8T5IufnisDxoZHwGI3s0qsGdoa5/4PGooPjomAc0ngV
         +gSPF+jYiKu40T8oNxDe23LAFTz+OX8vP7O/3tmBYzZj+t+O/FSOkWPLFGaIBvTOd+6y
         SEZlGtE9prkN2OmoiL27PKtU3NcLdMo4kM69T19NOF98ciLIUbVZKoriFBtk+QISQ3kz
         gzw7kv6nz3/u6+u6G+N4XPZHvQJvFBhczuchf7R2ibFOenROibcD1fJpyoAY4iLBY1wh
         zyCw==
X-Gm-Message-State: APjAAAXtZlENHLx5HxouL8ni6QWQJ07GDrgGSw6ZWYYwmhCImfsbUZ8W
        Z99QU7SzzwgFN1EOM98Kq36+CSk8eg==
X-Google-Smtp-Source: APXvYqxYuY4G9cYXtCLUO7gMmnJelDez7R3/XOTStuWfsTmC0/KZUov2Z3S+ezfSspwkaJ53+zvW7QymNQ==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr9816005wrx.103.1581437155723;
 Tue, 11 Feb 2020 08:05:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:04:21 +0100
In-Reply-To: <20200211160423.138870-1-elver@google.com>
Message-Id: <20200211160423.138870-3-elver@google.com>
Mime-Version: 1.0
References: <20200211160423.138870-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 3/5] kcsan: Introduce kcsan_value_change type
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

Introduces kcsan_value_change type, which explicitly points out if we
either observed a value-change (TRUE), or we could not observe one but
cannot rule out a value-change happened (MAYBE). The MAYBE state can
either be reported or not, depending on configuration preferences.

A follow-up patch introduces the FALSE state, which should never be
reported.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c   | 38 ++++++++++++++++++++++----------------
 kernel/kcsan/kcsan.h  | 19 ++++++++++++++++++-
 kernel/kcsan/report.c | 26 ++++++++++++++------------
 3 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 498b1eb3c1cda..3f89801161d33 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -341,7 +341,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		u32 _4;
 		u64 _8;
 	} expect_value;
-	bool value_change = false;
+	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
 	unsigned long irq_flags;
 
@@ -398,6 +398,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
+	expect_value._8 = 0;
 	switch (size) {
 	case 1:
 		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
@@ -436,23 +437,36 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 */
 	switch (size) {
 	case 1:
-		value_change = expect_value._1 != READ_ONCE(*(const u8 *)ptr);
+		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		value_change = expect_value._2 != READ_ONCE(*(const u16 *)ptr);
+		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		value_change = expect_value._4 != READ_ONCE(*(const u32 *)ptr);
+		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		value_change = expect_value._8 != READ_ONCE(*(const u64 *)ptr);
+		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
 	}
 
+	/* Were we able to observe a value-change? */
+	if (expect_value._8 != 0)
+		value_change = KCSAN_VALUE_CHANGE_TRUE;
+
 	/* Check if this access raced with another. */
 	if (!remove_watchpoint(watchpoint)) {
+		/*
+		 * Depending on the access type, map a value_change of MAYBE to
+		 * TRUE (require reporting).
+		 */
+		if (value_change == KCSAN_VALUE_CHANGE_MAYBE && (size > 8 || is_assert)) {
+			/* Always assume a value-change. */
+			value_change = KCSAN_VALUE_CHANGE_TRUE;
+		}
+
 		/*
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
@@ -461,20 +475,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * therefore both this thread and the racing thread may
 		 * increment this counter.
 		 */
-		if (is_assert)
+		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
-		/*
-		 * - If we were not able to observe a value change due to size
-		 *   constraints, always assume a value change.
-		 * - If the access type is an assertion, we also always assume a
-		 *   value change to always report the race.
-		 */
-		value_change = value_change || size > 8 || is_assert;
-
 		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
 			     KCSAN_REPORT_RACE_SIGNAL);
-	} else if (value_change) {
+	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
@@ -482,7 +488,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report(ptr, size, type, true,
+			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
 	}
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 50078e7d43c32..83a79b08b550e 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -88,6 +88,22 @@ extern void kcsan_counter_dec(enum kcsan_counter_id id);
  */
 extern bool kcsan_skip_report_debugfs(unsigned long func_addr);
 
+/*
+ * Value-change states.
+ */
+enum kcsan_value_change {
+	/*
+	 * Did not observe a value-change, however, it is valid to report the
+	 * race, depending on preferences.
+	 */
+	KCSAN_VALUE_CHANGE_MAYBE,
+
+	/*
+	 * The value was observed to change, and the race should be reported.
+	 */
+	KCSAN_VALUE_CHANGE_TRUE,
+};
+
 enum kcsan_report_type {
 	/*
 	 * The thread that set up the watchpoint and briefly stalled was
@@ -111,6 +127,7 @@ enum kcsan_report_type {
  * Print a race report from thread that encountered the race.
  */
 extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-			 bool value_change, int cpu_id, enum kcsan_report_type type);
+			 enum kcsan_value_change value_change, int cpu_id,
+			 enum kcsan_report_type type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index abf6852dff72f..d871476dc1348 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -130,26 +130,27 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
  * Special rules to skip reporting.
  */
 static bool
-skip_report(bool value_change, unsigned long top_frame)
+skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 {
 	/*
-	 * The first call to skip_report always has value_change==true, since we
+	 * The first call to skip_report always has value_change==TRUE, since we
 	 * cannot know the value written of an instrumented access. For the 2nd
 	 * call there are 6 cases with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY:
 	 *
-	 * 1. read watchpoint, conflicting write (value_change==true): report;
-	 * 2. read watchpoint, conflicting write (value_change==false): skip;
-	 * 3. write watchpoint, conflicting write (value_change==true): report;
-	 * 4. write watchpoint, conflicting write (value_change==false): skip;
-	 * 5. write watchpoint, conflicting read (value_change==false): skip;
-	 * 6. write watchpoint, conflicting read (value_change==true): report;
+	 * 1. read watchpoint, conflicting write (value_change==TRUE): report;
+	 * 2. read watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 3. write watchpoint, conflicting write (value_change==TRUE): report;
+	 * 4. write watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 5. write watchpoint, conflicting read (value_change==MAYBE): skip;
+	 * 6. write watchpoint, conflicting read (value_change==TRUE): report;
 	 *
 	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
 	 * data races where the write may have rewritten the same value; case 6
 	 * is possible either if the size is larger than what we check value
 	 * changes for or the access type is KCSAN_ACCESS_ASSERT.
 	 */
-	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && !value_change) {
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) &&
+	    value_change == KCSAN_VALUE_CHANGE_MAYBE) {
 		/*
 		 * The access is a write, but the data value did not change.
 		 *
@@ -245,7 +246,7 @@ static int sym_strcmp(void *addr1, void *addr2)
  * Returns true if a report was generated, false otherwise.
  */
 static bool print_report(const volatile void *ptr, size_t size, int access_type,
-			 bool value_change, int cpu_id,
+			 enum kcsan_value_change value_change, int cpu_id,
 			 enum kcsan_report_type type)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
@@ -258,7 +259,7 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	/*
 	 * Must check report filter rules before starting to print.
 	 */
-	if (skip_report(true, stack_entries[skipnr]))
+	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
 		return false;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
@@ -477,7 +478,8 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 }
 
 void kcsan_report(const volatile void *ptr, size_t size, int access_type,
-		  bool value_change, int cpu_id, enum kcsan_report_type type)
+		  enum kcsan_value_change value_change, int cpu_id,
+		  enum kcsan_report_type type)
 {
 	unsigned long flags = 0;
 
-- 
2.25.0.225.g125e21ebc7-goog

