Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452AAC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085E6206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="FLotEYA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBLPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53885 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBLPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so2833399wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7xT5k/FYGx7N/5C+nsY2hbvNfivZ8aBxdpBg8mpNHU=;
        b=FLotEYA67VaNKBky+3tBGMm3yUYok7qLcWQwIJwSICHy8PCokdwggaaSIe2ZNAtX0r
         VeHxpRajI6cgGCqOzqkcknQ+Fr9voAbUl4fd7AJQPCEY15t6fFjovDQ6l+E1Bb+1AZ0V
         LHLM4z6m/9fftAA61KLf+zsl+22Es7vQ3fCGu2B+ynfoJfMJizcxPbfQNaBdmV8eECtf
         VxZ5ApYq5x8sBuoL05dfuva/Cs/EvjTc6lLqgDgNWhMjUhLyIxDiYETFSmstRgB04XWV
         AAyo0u9pEPy7JFXQePsRCCaKWa4DJdClmazlcXopscHdZrC/iJ59cT/pQI/XzuguIj5j
         Hlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=N7xT5k/FYGx7N/5C+nsY2hbvNfivZ8aBxdpBg8mpNHU=;
        b=ElAhFlm4K0wjq2+lAmtsblHc0cYuO4o/t2O+tA+sDE+Ds11sJrlDYRfhAvtNQ5VzrH
         wiqJmPCM2XeXk5Z8yaLzqMVNIqarmkTGBFBwDq1N7jNNOPFEgjImW6Ea8jf0bwJVmM5C
         QSOoSTMw0wnsUQPXuIOc43BTgjXuYICjyAIexhsdkDL8oc9f6nhsuj+wIiU/fJmybMXv
         C07gpb/z/ML/osGQYN+F4k6yjK6KiJbRiLR9Y0qam9m2RyJAexqrHEgjg4oU1x0SX1TD
         EuMB+13tkdvNHQihD2NdtpQBj2erPC8keJrRziWShlcde/JWH/lWC9siVj5XaITeitJr
         a+TQ==
X-Gm-Message-State: APjAAAX0MPb6l29rqIQwvCLklCJeNAKk43v7sko+F3iQ5cs5kQOJx3Ya
        Qo/YKfvaOd53mAwIwEHRPiAkKYR2ltQLCJK/
X-Google-Smtp-Source: APXvYqwn2sUegKlWyXgw8kABVi1PnKlJnBjX+D6JtuMJLdkAr9K3js/zdrMg54kwvfoKTmW3DEjbYw==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr12969094wmb.38.1581522164413;
        Wed, 12 Feb 2020 07:42:44 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u14sm1045583wrm.51.2020.02.12.07.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:43 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall load and store <stefan.asserhall@xilinx.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 7/7] microblaze: Do atomic operations by using exclusive ops
Date:   Wed, 12 Feb 2020 16:42:29 +0100
Message-Id: <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall load and store <stefan.asserhall@xilinx.com>

Implement SMP aware atomic operations.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/atomic.h | 265 +++++++++++++++++++++++++--
 1 file changed, 253 insertions(+), 12 deletions(-)

diff --git a/arch/microblaze/include/asm/atomic.h b/arch/microblaze/include/asm/atomic.h
index 41e9aff23a62..522d704fad63 100644
--- a/arch/microblaze/include/asm/atomic.h
+++ b/arch/microblaze/include/asm/atomic.h
@@ -1,28 +1,269 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013-2020 Xilinx, Inc.
+ */
+
 #ifndef _ASM_MICROBLAZE_ATOMIC_H
 #define _ASM_MICROBLAZE_ATOMIC_H
 
+#include <linux/types.h>
 #include <asm/cmpxchg.h>
-#include <asm-generic/atomic.h>
-#include <asm-generic/atomic64.h>
+
+#define ATOMIC_INIT(i)	{ (i) }
+
+#define atomic_read(v)	READ_ONCE((v)->counter)
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	int result, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1:	lwx	%0, %2, r0;\n"
+		/* attempt store */
+		"	swx	%3, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		/* Outputs: result value */
+		: "=&r" (result), "=&r" (tmp)
+		/* Inputs: counter address */
+		: "r" (&v->counter), "r" (i)
+		: "cc", "memory"
+	);
+}
+#define atomic_set	atomic_set
+
+/* Atomically perform op with v->counter and i, return result */
+#define ATOMIC_OP_RETURN(op, asm)					\
+static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+{									\
+	int result, tmp;						\
+									\
+	__asm__ __volatile__ (						\
+		/* load conditional address in %2 to %0 */		\
+		"1:	lwx	%0, %2, r0;\n"				\
+		/* perform operation and save it to result */		\
+		#asm		" %0, %3, %0;\n"			\
+		/* attempt store */					\
+		"	swx	%0, %2, r0;\n"				\
+		/* checking msr carry flag */				\
+		"	addic	%1, r0, 0;\n"				\
+		/* store failed (MSR[C] set)? try again */		\
+		"	bnei	%1, 1b;\n"				\
+		/* Outputs: result value */				\
+		: "=&r" (result), "=&r" (tmp)				\
+		/* Inputs: counter address */				\
+		: "r"   (&v->counter), "r" (i)				\
+		: "cc", "memory"					\
+	);								\
+									\
+	return result;							\
+}									\
+									\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	atomic_##op##_return_relaxed(i, v);				\
+}
+
+/* Atomically perform op with v->counter and i, return orig v->counter */
+#define ATOMIC_FETCH_OP_RELAXED(op, asm)				\
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+{									\
+	int old, tmp;							\
+									\
+	__asm__ __volatile__ (						\
+		/* load conditional address in %2 to %0 */		\
+		"1:	lwx	%0, %2, r0;\n"				\
+		/* perform operation and save it to tmp */		\
+		#asm		" %1, %3, %0;\n"			\
+		/* attempt store */					\
+		"	swx	%1, %2, r0;\n"				\
+		/* checking msr carry flag */				\
+		"	addic	%1, r0, 0;\n"				\
+		/* store failed (MSR[C] set)? try again */		\
+		"	bnei	%1, 1b;\n"				\
+		/* Outputs: old value */				\
+		: "=&r" (old), "=&r" (tmp)				\
+		/* Inputs: counter address */				\
+		: "r"   (&v->counter), "r" (i)				\
+		: "cc", "memory"					\
+	);								\
+									\
+	return old;							\
+}
+
+#define ATOMIC_OPS(op, asm) \
+	ATOMIC_FETCH_OP_RELAXED(op, asm) \
+	ATOMIC_OP_RETURN(op, asm)
+
+ATOMIC_OPS(and, and)
+#define atomic_and			atomic_and
+#define atomic_and_return_relaxed	atomic_and_return_relaxed
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+
+ATOMIC_OPS(add, add)
+#define atomic_add			atomic_add
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+
+ATOMIC_OPS(xor, xor)
+#define atomic_xor			atomic_xor
+#define atomic_xor_return_relaxed	atomic_xor_return_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+
+ATOMIC_OPS(or, or)
+#define atomic_or			atomic_or
+#define atomic_or_return_relaxed	atomic_or_return_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+
+ATOMIC_OPS(sub, rsub)
+#define atomic_sub			atomic_sub
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
+static inline int atomic_inc_return_relaxed(atomic_t *v)
+{
+	int result, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1:	lwx	%0, %2, r0;\n"
+		/* increment counter by 1 */
+		"	addi	%0, %0, 1;\n"
+		/* attempt store */
+		"	swx	%0, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		/* Outputs: result value */
+		: "=&r" (result), "=&r" (tmp)
+		/* Inputs: counter address */
+		: "r"   (&v->counter)
+		: "cc", "memory"
+	);
+
+	return result;
+}
+#define atomic_inc_return_relaxed	atomic_inc_return_relaxed
+
+#define atomic_inc_and_test(v)	(atomic_inc_return(v) == 0)
+
+static inline int atomic_dec_return(atomic_t *v)
+{
+	int result, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1:	lwx	%0, %2, r0;\n"
+		/* increment counter by -1 */
+		"	addi	%0, %0, -1;\n"
+		/* attempt store */
+		"	swx	%0, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		/* Outputs: result value */
+		: "=&r" (result), "=&r" (tmp)
+		/* Inputs: counter address */
+		: "r"   (&v->counter)
+		: "cc", "memory"
+	);
+
+	return result;
+}
+#define atomic_dec_return	atomic_dec_return
+
+static inline void atomic_dec(atomic_t *v)
+{
+	atomic_dec_return(v);
+}
+#define atomic_dec	atomic_dec
+
+#define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
+#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
+
+#define atomic_cmpxchg(v, o, n)	(cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new)	(xchg(&((v)->counter), new))
+
+/**
+ * atomic_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns the old value of @v.
+ */
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int result, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1: lwx	 %0, %2, r0;\n"
+		/* compare loaded value with old value*/
+		"   cmp   %1, %0, %3;\n"
+		/* equal to u, don't increment */
+		"   beqid %1, 2f;\n"
+		/* increment counter by i */
+		"   add   %1, %0, %4;\n"
+		/* attempt store of new value*/
+		"   swx   %1, %2, r0;\n"
+		/* checking msr carry flag */
+		"   addic %1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"   bnei  %1, 1b;\n"
+		"2:"
+		/* Outputs: result value */
+		: "=&r" (result), "=&r" (tmp)
+		/* Inputs: counter address, old, new */
+		: "r"   (&v->counter), "r" (u), "r" (a)
+		: "cc", "memory"
+	);
+
+	return result;
+}
 
 /*
  * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
  */
 static inline int atomic_dec_if_positive(atomic_t *v)
 {
-	unsigned long flags;
-	int res;
+	int result, tmp;
 
-	local_irq_save(flags);
-	res = v->counter - 1;
-	if (res >= 0)
-		v->counter = res;
-	local_irq_restore(flags);
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1:	lwx	%0, %2, r0;\n"
+		/* decrement counter by 1*/
+		"	addi	%0, %0, -1;\n"
+		/* if < 0 abort (*v was <= 0)*/
+		"	blti	%0, 2f;\n"
+		/* attempt store of new value*/
+		"	swx	%0, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		"2: "
+		/* Outputs: result value */
+		: "=&r" (result), "=&r" (tmp)
+		/* Inputs: counter address */
+		: "r"   (&v->counter)
+		: "cc", "memory"
+	);
 
-	return res;
+	return result;
 }
-#define atomic_dec_if_positive atomic_dec_if_positive
+#define atomic_dec_if_positive	atomic_dec_if_positive
+
+#define atomic_add_negative(i, v)	(atomic_add_return(i, v) < 0)
+
+#include <asm-generic/atomic64.h>
 
 #endif /* _ASM_MICROBLAZE_ATOMIC_H */
-- 
2.25.0

