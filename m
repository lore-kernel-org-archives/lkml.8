Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAA020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780678;
	bh=bXQ23ihSEnUkTp24p0NNHFtzIlF3bdrUPM4liEoYSIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iivQwjTjMoe+T/GULhTzHMhr55mhlA5eXMacPYFhtU7XT9ivcGMxq00yeEpb5vARc
	 Vn+dULKq39FheYTQ5NVHD4OTXEDmeAasMaxecL07TiMUD488nF2hjl330ekTpo/iHG
	 cQ4WkXsWsBcAQ/7yTNT/B5Pl8V7QtbRiicvs/jXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCITEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbgCITE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1810A2464B;
        Mon,  9 Mar 2020 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780668;
        bh=bXQ23ihSEnUkTp24p0NNHFtzIlF3bdrUPM4liEoYSIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbMGV/zpHQnfDssderoDJmNtLiAFL1H82cAMK/HVjWEhO+Xl8475TYl9R4FX2EBre
         ZERqYEu44wgt+TTogWhF9O/ZX7puP0eckzGTT6ZD/KoJGV4q7qG+8NIJC885+UJvV4
         kKf/2Fjm6P2EdxsWYG8fW12px9arT3ZT/uWx+Vmk=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 24/32] kcsan: Add kcsan_set_access_mask() support
Date:   Mon,  9 Mar 2020 12:04:12 -0700
Message-Id: <20200309190420.6100-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

When setting up an access mask with kcsan_set_access_mask(), KCSAN will
only report races if concurrent changes to bits set in access_mask are
observed. Conveying access_mask via a separate call avoids introducing
overhead in the common-case fast-path.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 11 +++++++++++
 include/linux/kcsan.h        |  5 +++++
 init/init_task.c             |  1 +
 kernel/kcsan/core.c          | 43 +++++++++++++++++++++++++++++++++++++++----
 kernel/kcsan/kcsan.h         |  5 +++++
 kernel/kcsan/report.c        | 13 ++++++++++++-
 6 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 8675411..4ef5233 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -68,6 +68,16 @@ void kcsan_flat_atomic_end(void);
  */
 void kcsan_atomic_next(int n);
 
+/**
+ * kcsan_set_access_mask - set access mask
+ *
+ * Set the access mask for all accesses for the current context if non-zero.
+ * Only value changes to bits set in the mask will be reported.
+ *
+ * @mask bitmask
+ */
+void kcsan_set_access_mask(unsigned long mask);
+
 #else /* CONFIG_KCSAN */
 
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
@@ -78,6 +88,7 @@ static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
 static inline void kcsan_flat_atomic_end(void)		{ }
 static inline void kcsan_atomic_next(int n)		{ }
+static inline void kcsan_set_access_mask(unsigned long mask) { }
 
 #endif /* CONFIG_KCSAN */
 
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 7a614ca..3b84606 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -35,6 +35,11 @@ struct kcsan_ctx {
 	 */
 	int atomic_nest_count;
 	bool in_flat_atomic;
+
+	/*
+	 * Access mask for all accesses if non-zero.
+	 */
+	unsigned long access_mask;
 };
 
 /**
diff --git a/init/init_task.c b/init/init_task.c
index 2b4fe98..096191d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -167,6 +167,7 @@ struct task_struct init_task
 		.atomic_next		= 0,
 		.atomic_nest_count	= 0,
 		.in_flat_atomic		= false,
+		.access_mask		= 0,
 	},
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3f89801..589b1e7 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -39,6 +39,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 	.atomic_next		= 0,
 	.atomic_nest_count	= 0,
 	.in_flat_atomic		= false,
+	.access_mask		= 0,
 };
 
 /*
@@ -298,6 +299,15 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 
 	if (!kcsan_is_enabled())
 		return;
+
+	/*
+	 * The access_mask check relies on value-change comparison. To avoid
+	 * reporting a race where e.g. the writer set up the watchpoint, but the
+	 * reader has access_mask!=0, we have to ignore the found watchpoint.
+	 */
+	if (get_ctx()->access_mask != 0)
+		return;
+
 	/*
 	 * Consume the watchpoint as soon as possible, to minimize the chances
 	 * of !consumed. Consuming the watchpoint must always be guarded by
@@ -341,6 +351,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		u32 _4;
 		u64 _8;
 	} expect_value;
+	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
 	unsigned long irq_flags;
@@ -435,18 +446,27 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Re-read value, and check if it is as expected; if not, we infer a
 	 * racy access.
 	 */
+	access_mask = get_ctx()->access_mask;
 	switch (size) {
 	case 1:
 		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
+		if (access_mask)
+			expect_value._1 &= (u8)access_mask;
 		break;
 	case 2:
 		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
+		if (access_mask)
+			expect_value._2 &= (u16)access_mask;
 		break;
 	case 4:
 		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
+		if (access_mask)
+			expect_value._4 &= (u32)access_mask;
 		break;
 	case 8:
 		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
+		if (access_mask)
+			expect_value._8 &= (u64)access_mask;
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
@@ -460,11 +480,20 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	if (!remove_watchpoint(watchpoint)) {
 		/*
 		 * Depending on the access type, map a value_change of MAYBE to
-		 * TRUE (require reporting).
+		 * TRUE (always report) or FALSE (never report).
 		 */
-		if (value_change == KCSAN_VALUE_CHANGE_MAYBE && (size > 8 || is_assert)) {
-			/* Always assume a value-change. */
-			value_change = KCSAN_VALUE_CHANGE_TRUE;
+		if (value_change == KCSAN_VALUE_CHANGE_MAYBE) {
+			if (access_mask != 0) {
+				/*
+				 * For access with access_mask, we require a
+				 * value-change, as it is likely that races on
+				 * ~access_mask bits are expected.
+				 */
+				value_change = KCSAN_VALUE_CHANGE_FALSE;
+			} else if (size > 8 || is_assert) {
+				/* Always assume a value-change. */
+				value_change = KCSAN_VALUE_CHANGE_TRUE;
+			}
 		}
 
 		/*
@@ -622,6 +651,12 @@ void kcsan_atomic_next(int n)
 }
 EXPORT_SYMBOL(kcsan_atomic_next);
 
+void kcsan_set_access_mask(unsigned long mask)
+{
+	get_ctx()->access_mask = mask;
+}
+EXPORT_SYMBOL(kcsan_set_access_mask);
+
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
 {
 	check_access(ptr, size, type);
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 83a79b0..892de51 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -99,6 +99,11 @@ enum kcsan_value_change {
 	KCSAN_VALUE_CHANGE_MAYBE,
 
 	/*
+	 * Did not observe a value-change, and it is invalid to report the race.
+	 */
+	KCSAN_VALUE_CHANGE_FALSE,
+
+	/*
 	 * The value was observed to change, and the race should be reported.
 	 */
 	KCSAN_VALUE_CHANGE_TRUE,
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d871476..11c791b 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -132,6 +132,9 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
 static bool
 skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 {
+	/* Should never get here if value_change==FALSE. */
+	WARN_ON_ONCE(value_change == KCSAN_VALUE_CHANGE_FALSE);
+
 	/*
 	 * The first call to skip_report always has value_change==TRUE, since we
 	 * cannot know the value written of an instrumented access. For the 2nd
@@ -493,7 +496,15 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 
 	kcsan_disable_current();
 	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
-		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
+		/*
+		 * Never report if value_change is FALSE, only if we it is
+		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
+		 * be done once we know the full stack trace in print_report().
+		 */
+		bool reported = value_change != KCSAN_VALUE_CHANGE_FALSE &&
+				print_report(ptr, size, access_type, value_change, cpu_id, type);
+
+		if (reported && panic_on_warn)
 			panic("panic_on_warn set ...\n");
 
 		release_report(&flags, type);
-- 
2.9.5

