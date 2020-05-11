Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031C1C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E6C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229784;
	bh=Pq18jh+dBO+5MVurPUTV7sJ+HQII+LY1UCZPrtlXpZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrzYPUGrKP1MBaDEDusOA6I784K9jI8ShHTUHaVEppbyMC+wXAC9HcN5oE5XMnbwO
	 ADGEALbqeQ3fig6JlA3gkUJRxtdIbwi+JEUOmASVsQwreqgQk+b0C74CfbgEyG6yB/
	 +jnvfHQnLVWpFSXVNxuWD1/7tVr/UdgE5xVFrUpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgEKUnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731907AbgEKUnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:43:02 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112C6206A3;
        Mon, 11 May 2020 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229781;
        bh=Pq18jh+dBO+5MVurPUTV7sJ+HQII+LY1UCZPrtlXpZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN4J+XnjVOiqN8cznGqBaIotz/EsEqUyAFo5x++BzfcdufV0sFA3OnvEr8/NBs+me
         LfUclYiWqck+lHWnVkv24s9TNi4taqz//M4oOADwasOcaUEpuFYIIGMU4w/foYrz2p
         uUZJanhtAAvxlS91EoBBWS1x5WgTtRI0thRR1nEI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 17/18] READ_ONCE: Use data_race() to avoid KCSAN instrumentation
Date:   Mon, 11 May 2020 21:41:49 +0100
Message-Id: <20200511204150.27858-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather then open-code the disabling/enabling of KCSAN across the guts of
{READ,WRITE}_ONCE(), defer to the data_race() macro instead.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h | 53 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f2a64195ee8e..d21a823e73c6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -199,6 +199,26 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design.
+ *
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.
+ */
+#define data_race(expr)							\
+({									\
+	__kcsan_disable_current();					\
+	({								\
+		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
+		__kcsan_enable_current();				\
+		__v;							\
+	});								\
+})
+
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
  * atomicity or dependency ordering guarantees. Note that this may result
@@ -209,14 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
+	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
-	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);	\
-		__kcsan_enable_current();				\
-		smp_read_barrier_depends();				\
-		(typeof(x))__x;						\
-	});								\
+	smp_read_barrier_depends();					\
+	(typeof(x))__x;							\
 })
 
 #define READ_ONCE(x)							\
@@ -234,9 +250,7 @@ do {									\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	__kcsan_disable_current();					\
-	__WRITE_ONCE(*__xp, val);					\
-	__kcsan_enable_current();					\
+	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
@@ -304,25 +318,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-/**
- * data_race - mark an expression as containing intentional data races
- *
- * This data_race() macro is useful for situations in which data races
- * should be forgiven.  One example is diagnostic code that accesses
- * shared variables but is not a part of the core synchronization design.
- *
- * This macro *does not* affect normal code generation, but is a hint
- * to tooling that data races here are to be ignored.
- */
-#define data_race(expr)							\
-({									\
-	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
-		__kcsan_enable_current();				\
-		__v;							\
-	});								\
-})
 #else
 
 #endif /* __KERNEL__ */
-- 
2.26.2.645.ge9eca65c58-goog

