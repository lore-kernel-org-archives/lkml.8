Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6ACC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C2E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZkbiYaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgBKQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:06:06 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41379 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgBKQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:06:03 -0500
Received: by mail-wm1-f74.google.com with SMTP id s25so1313689wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rjIlJ1mSxL5OyN0zHkfQmfiVb4ET4hnV80pAWbyb5D8=;
        b=RZkbiYaUoOoFM+cbiZx44GmXDJ7bzMR9ztXI0SxyxQuvV8IltyKK9CKClsBpIHA5xC
         Agb6bozdQOPjx80hyUD9JzuIQDp7TIBxZbp4GG3ODCiXykq/Rb0FEWDcLuQU/81uWMjH
         pIqgJPM5U2xDtBq/EZxurOSojipA4jCDRSotUrxkYYFbwLE8H6aAg8fuqTGsuj0j1P7j
         92eYzuatb/+jUQ1rUJQPFspXlWgjkUATe1UQM8aOv1OWE63Pler8RrcUJCG3K/XY7plL
         yXHPgAlUaubyqnyjLt7R6NobMKYQPSgze/3IeoFjZF5FE9O+RuR10LJtcrcyesYJg5/7
         JvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rjIlJ1mSxL5OyN0zHkfQmfiVb4ET4hnV80pAWbyb5D8=;
        b=Y73e1feqw+W7tVURdx8QSiY5xoJPgCAGw8+f+nSTuqRXI2CkRbzRycIcJw5+3s0HE8
         FufnhUkjhkibOHwXvxABXIMivE4hW2J36IYfRCxRwHOpULME3bZAuxAOULJdftfLhhpG
         wI/dOKP7zuM0bXJ5ndDYDP1XLV+o+ljHt9Mbq3uQzj/NhjAE9hGHZjIC4Kw7GX0AHw5C
         MpvoQarTdIUk1N2EL3KeFu4hc4p6akYedKijkHPUGMuA8HpV9YYpcmX1UVy8hXk/KWOr
         EFNt3P7oqreSD4NuiNkTJ8JGxXgqsQGrnKv5j19qs9lSbHmCd+e3f1uAULGLUa4jNrNf
         VD4w==
X-Gm-Message-State: APjAAAVRe8q7FM+r69deG1LmPuu2nAO3UQqbduvx7RPXdbED64gLCZVU
        chTITKwfEaGxWdsJ4kxwnAEf6mxoyw==
X-Google-Smtp-Source: APXvYqz4Fd7LOQSzMQTlo5vI5aqYYPwqTgMiiaoWmZzryJ2ZDYaJvKJtYt6kseDh6IMclyKGID6PSZYGuw==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr8793286wrt.88.1581437158657;
 Tue, 11 Feb 2020 08:05:58 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:04:22 +0100
In-Reply-To: <20200211160423.138870-1-elver@google.com>
Message-Id: <20200211160423.138870-4-elver@google.com>
Mime-Version: 1.0
References: <20200211160423.138870-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 4/5] kcsan: Add kcsan_set_access_mask() support
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

When setting up an access mask with kcsan_set_access_mask(), KCSAN will
only report races if concurrent changes to bits set in access_mask are
observed. Conveying access_mask via a separate call avoids introducing
overhead in the common-case fast-path.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 11 +++++++++
 include/linux/kcsan.h        |  5 +++++
 init/init_task.c             |  1 +
 kernel/kcsan/core.c          | 43 ++++++++++++++++++++++++++++++++----
 kernel/kcsan/kcsan.h         |  5 +++++
 kernel/kcsan/report.c        | 13 ++++++++++-
 6 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 8675411c8dbcd..4ef5233ff3f04 100644
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
index 7a614ca558f65..3b84606e1e675 100644
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
index 2b4fe98b0f095..096191d177d5c 100644
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
index 3f89801161d33..589b1e7f0f253 100644
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
index 83a79b08b550e..892de5120c1b6 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -98,6 +98,11 @@ enum kcsan_value_change {
 	 */
 	KCSAN_VALUE_CHANGE_MAYBE,
 
+	/*
+	 * Did not observe a value-change, and it is invalid to report the race.
+	 */
+	KCSAN_VALUE_CHANGE_FALSE,
+
 	/*
 	 * The value was observed to change, and the race should be reported.
 	 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d871476dc1348..11c791b886f3c 100644
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
2.25.0.225.g125e21ebc7-goog

