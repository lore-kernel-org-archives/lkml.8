Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D70C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4A2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9O2+F8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEUoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:44:18 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:35259 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:44:18 -0500
Received: by mail-wm1-f74.google.com with SMTP id z7so1565420wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n91DHyeQsL6KJi+PzY/lmETuokxLoyCiTyEI3zpbN6o=;
        b=N9O2+F8HGRS/N3l/0z0aPzfcPc/uidznZDRae5tYVw2Fz/NyGSezGN2HLMoeE7Zcv4
         /LpXVmdndqNzNWQ5dT8sE5SA6uxR9aYpymvXp3UEEdnEuN6LsiYxovE6Kh1vw137cjtN
         AKS4Ia9tPVjGteqOZnMQ8SG2CL3YCN1KXYx85uXj2fnJwPSfeO5q5wLeP6/C2lszb0+d
         aqwEeviXf6FVJ9zSuitol/oDK3cnM+ho+GyxL/yXtZZsI52F8eqaeqwZgMZj1OguK1p7
         bvhnG98RDI3DdzelfH/kfT0sxqcyOYMA29a8In45ykZ2L2NSUl78TQV2oz7gKsdFefnL
         YK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n91DHyeQsL6KJi+PzY/lmETuokxLoyCiTyEI3zpbN6o=;
        b=mgSNLShFuHp+HRKNCdpQJHHf000tOaCYNvLIzZvxfivIFbAg+MxfFdG0JVATiwH4mw
         MnkNdboNo9E2QM37yvhxsYadNhI5zW8apvnIlpX0iUJW8qqYUQuA+AbdLKt3+tJZO6Io
         XQPE+Fd4wQUzTDbMYoTJzQmqfNI87g6mRBcDYyzplTGHHSd4ecrjIEFT3ZfQZ4saPtlM
         p/GPPtOeMGdAjCUgcLvt2kPLWLZllja5nAxtAscrkpOa+Dv+FNi5DpFSHMlrDf5SuvuZ
         8sGNuYPXvMziBaW2+9bM4VfEX+CRnkE0OrPKPZ+wZbxY/QizLd7zxRkmMPVCBCoovxWx
         I3Dg==
X-Gm-Message-State: APjAAAUsGYdmuU1rNEJTe0t1Z8DOkkcmdxdBgm2xo9fC/bzP6hciWLm4
        LMMuk1esqKbN/FjzX73AAFrfFewHFg==
X-Google-Smtp-Source: APXvYqxa2/gxRWK5q7X/QW4LfYH+GFp5g0UqIlXesfUbgZoo7HF6wQxpey96wrFvE8P4byF+WN8pmppzmQ==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr331765wrx.145.1580935455011;
 Wed, 05 Feb 2020 12:44:15 -0800 (PST)
Date:   Wed,  5 Feb 2020 21:43:31 +0100
Message-Id: <20200205204333.30953-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 1/3] kcsan: Introduce KCSAN_ACCESS_ASSERT access type
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
and writes to assert certain properties of synchronization logic, where
bugs could not be detected as normal data races.

For example, a variable that is only meant to be written by a single
CPU, but may be read (without locking) by other CPUs must still be
marked properly to avoid data races. However, concurrent writes,
regardless if WRITE_ONCE() or not, would be a bug. Using
kcsan_check_access(&x, sizeof(x), KCSAN_ACCESS_ASSERT) would allow
catching such bugs.

Notably, the KCSAN_ACCESS_ASSERT type disables various filters, so that
all races that KCSAN observes are reported.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h |  8 +++++++-
 kernel/kcsan/core.c          | 24 +++++++++++++++++++++---
 kernel/kcsan/report.c        | 11 +++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index ef3ee233a3fa9..21b1d1f214ad5 100644
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
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 82c2bef827d42..190fb5c958fe3 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
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
@@ -307,6 +315,7 @@ static noinline void
 kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 {
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	const bool is_assertion = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
 	union {
 		u8 _1;
@@ -430,12 +439,21 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * No need to increment 'data_races' counter, as the racing
 		 * thread already did.
 		 */
-		kcsan_report(ptr, size, type, size > 8 || value_change,
-			     smp_processor_id(), KCSAN_REPORT_RACE_SIGNAL);
+
+		/*
+		 * - If we were not able to observe a value change due to size
+		 *   constraints, always assume a value change.
+		 * - If the access type is an assertion, we also always assume a
+		 *   value change to always report the race.
+		 */
+		value_change = value_change || size > 8 || is_assertion;
+
+		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
+			     KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change) {
 		/* Inferring a race, since the value should not have changed. */
 		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
-		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN))
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assertion)
 			kcsan_report(ptr, size, type, true,
 				     smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 7cd34285df740..938146104e046 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -178,6 +178,17 @@ static const char *get_access_type(int type)
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
-- 
2.25.0.341.g760bfbb309-goog

