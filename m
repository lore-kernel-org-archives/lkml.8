Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD9A214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgFPMWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgFPMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3AC08C5C2;
        Tue, 16 Jun 2020 05:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbQ-0004n3-Ks; Tue, 16 Jun 2020 14:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 404981C0823;
        Tue, 16 Jun 2020 14:21:57 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:56 -0000
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Improve cputime_adjust()
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200519172506.GA317395@hirez.programming.kicks-ass.net>
References: <20200519172506.GA317395@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159231011694.16989.16351419333851309713.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3dc167ba5729ddd2d8e3fa1841653792c295d3f1
Gitweb:        https://git.kernel.org/tip/3dc167ba5729ddd2d8e3fa1841653792c295d3f1
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 19 May 2020 19:25:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:00 +02:00

sched/cputime: Improve cputime_adjust()

People report that utime and stime from /proc/<pid>/stat become very
wrong when the numbers are big enough, especially if you watch these
counters incrementally.

Specifically, the current implementation of: stime*rtime/total,
results in a saw-tooth function on top of the desired line, where the
teeth grow in size the larger the values become. IOW, it has a
relative error.

The result is that, when watching incrementally as time progresses
(for large values), we'll see periods of pure stime or utime increase,
irrespective of the actual ratio we're striving for.

Replace scale_stime() with a math64.h helper: mul_u64_u64_div_u64()
that is far more accurate. This also allows architectures to override
the implementation -- for instance they can opt for the old algorithm
if this new one turns out to be too expensive for them.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200519172506.GA317395@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/div64.h | 14 +++++++++--
 include/linux/math64.h       |  2 ++-
 kernel/sched/cputime.c       | 46 +-----------------------------------
 lib/math/div64.c             | 41 +++++++++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9b8cb50..b8f1dc0 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -74,16 +74,26 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 #else
 # include <asm-generic/div64.h>
 
-static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
+/*
+ * Will generate an #DE when the result doesn't fit u64, could fix with an
+ * __ex_table[] entry when it becomes an issue.
+ */
+static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
 {
 	u64 q;
 
 	asm ("mulq %2; divq %3" : "=a" (q)
-				: "a" (a), "rm" ((u64)mul), "rm" ((u64)div)
+				: "a" (a), "rm" (mul), "rm" (div)
 				: "rdx");
 
 	return q;
 }
+#define mul_u64_u64_div_u64 mul_u64_u64_div_u64
+
+static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
+{
+	return mul_u64_u64_div_u64(a, mul, div);
+}
 #define mul_u64_u32_div	mul_u64_u32_div
 
 #endif /* CONFIG_X86_32 */
diff --git a/include/linux/math64.h b/include/linux/math64.h
index 11a2674..d097119 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -263,6 +263,8 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
+
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ff9435d..5a55d23 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -520,50 +520,6 @@ void account_idle_ticks(unsigned long ticks)
 }
 
 /*
- * Perform (stime * rtime) / total, but avoid multiplication overflow by
- * losing precision when the numbers are big.
- */
-static u64 scale_stime(u64 stime, u64 rtime, u64 total)
-{
-	u64 scaled;
-
-	for (;;) {
-		/* Make sure "rtime" is the bigger of stime/rtime */
-		if (stime > rtime)
-			swap(rtime, stime);
-
-		/* Make sure 'total' fits in 32 bits */
-		if (total >> 32)
-			goto drop_precision;
-
-		/* Does rtime (and thus stime) fit in 32 bits? */
-		if (!(rtime >> 32))
-			break;
-
-		/* Can we just balance rtime/stime rather than dropping bits? */
-		if (stime >> 31)
-			goto drop_precision;
-
-		/* We can grow stime and shrink rtime and try to make them both fit */
-		stime <<= 1;
-		rtime >>= 1;
-		continue;
-
-drop_precision:
-		/* We drop from rtime, it has more bits than stime */
-		rtime >>= 1;
-		total >>= 1;
-	}
-
-	/*
-	 * Make sure gcc understands that this is a 32x32->64 multiply,
-	 * followed by a 64/32->64 divide.
-	 */
-	scaled = div_u64((u64) (u32) stime * (u64) (u32) rtime, (u32)total);
-	return scaled;
-}
-
-/*
  * Adjust tick based cputime random precision against scheduler runtime
  * accounting.
  *
@@ -622,7 +578,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		goto update;
 	}
 
-	stime = scale_stime(stime, rtime, stime + utime);
+	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
 
 update:
 	/*
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 368ca7f..3952a07 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -190,3 +190,44 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return __iter_div_u64_rem(dividend, divisor, remainder);
 }
 EXPORT_SYMBOL(iter_div_u64_rem);
+
+#ifndef mul_u64_u64_div_u64
+u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+{
+	u64 res = 0, div, rem;
+	int shift;
+
+	/* can a * b overflow ? */
+	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * (b * a) / c is equal to
+		 *
+		 *      (b / c) * a +
+		 *      (b % c) * a / c
+		 *
+		 * if nothing overflows. Can the 1st multiplication
+		 * overflow? Yes, but we do not care: this can only
+		 * happen if the end result can't fit in u64 anyway.
+		 *
+		 * So the code below does
+		 *
+		 *      res = (b / c) * a;
+		 *      b = b % c;
+		 */
+		div = div64_u64_rem(b, c, &rem);
+		res = div * a;
+		b = rem;
+
+		shift = ilog2(a) + ilog2(b) - 62;
+		if (shift > 0) {
+			/* drop precision */
+			b >>= shift;
+			c >>= shift;
+			if (!c)
+				return res;
+		}
+	}
+
+	return res + div64_u64(a * b, c);
+}
+#endif
