Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A610C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E601D2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPioROHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgESRZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:25:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7762C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SjP1uMhWBw/6xZhHDTNvZUcC/abN8dgUqEJ8glGr2bU=; b=PPioROHRw7DMkCWBrrEPy9cqnu
        1rdjjyqQiLLA+hZ5MlWKTIXPG8IbTYdkyQMauAT5rsfXULxJA9N5q9+Jq43iJqZ28OdK29jv/Nll0
        Zp/JiH1bvmlAALT4c6NybUasfAZQEr6ybV3NkocaULuemvSRp31Rx75TtdXgBaiqd/sCUuE/1eONB
        y0bBZgjgFjBS6WKzMOUWDNKW41hK7A+D/VGuP58lUte7Z0hSVVIoSEo0kDvONShlN0D8uB8NC8Lou
        x0Ijm5HN2teNh+mt8KOb3VPLPpKyIvKiSiOWtiLJ5A1sGyisCBR0+q4Au3JJmOLKzQOUr0PRQko4l
        cMuRmh9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb5zJ-0001xX-LW; Tue, 19 May 2020 17:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16F2E30067C;
        Tue, 19 May 2020 19:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0DE62141CF09; Tue, 19 May 2020 19:25:06 +0200 (CEST)
Date:   Tue, 19 May 2020 19:25:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200519172506.GA317395@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127122817.GA10957@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 01:28:17PM +0100, Oleg Nesterov wrote:
> People report that utime and stime from /proc/<pid>/stat become very
> wrong when the numbers are big enough, especially if you watch these
> counters incrementally.
> 
> Say, if the monitored process runs 100 days 50/50 in user/kernel mode
> it looks as if it runs 20 minutes entirely in kernel mode, then 20
> minutes in user mode. See the test-case which tries to demonstrate this
> behaviour:
> 
> 	https://lore.kernel.org/lkml/20200124154215.GA14714@redhat.com/
> 
> The new implementation does the additional div64_u64_rem() but according
> to my naive measurements it is faster on x86_64, much faster if rtime/etc
> are big enough. See
> 
> 	https://lore.kernel.org/lkml/20200123130541.GA30620@redhat.com/

Right, so -m32 when ran on x86_64 CPUs isn't really fair, because then
it still has hardware fls() for ilog2() and a massively fast mult and
division instruction. Try and run this on a puny 32bit ARM that maybe
has a hardware multiplier on.

Anyway, how about we write it like the below and then when some puny
architecture comes complaining we can use Linus' original algorithm for
their arch implementation.

Hmm?

---
 arch/x86/include/asm/div64.h | 14 ++++++++++++--
 include/linux/math64.h       | 41 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/cputime.c       | 46 +-------------------------------------------
 3 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9b8cb50768c2..b8f1dc0761e4 100644
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
index 11a267413e8e..22b6f173dccb 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -263,6 +263,47 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+#ifndef mul_u64_u64_div_u64
+static inline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+{
+	u64 res = 0, div, rem;
+	int shift;
+
+	/* can a * b overflow ? */
+	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * (b * a) / c is equal to
+		 *
+		 *	(b / c) * a +
+		 *	(b % c) * a / c
+		 *
+		 * if nothing overflows. Can the 1st multiplication
+		 * overflow? Yes, but we do not care: this can only
+		 * happen if the end result can't fit in u64 anyway.
+		 *
+		 * So the code below does
+		 *
+		 *	res = (b / c) * a;
+		 *	b = b % c;
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
+#endif /* mul_u64_u64_div_u64 */
+
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ff9435dee1df..5a55d2300452 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -519,50 +519,6 @@ void account_idle_ticks(unsigned long ticks)
 	account_idle_time(cputime);
 }
 
-/*
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
 /*
  * Adjust tick based cputime random precision against scheduler runtime
  * accounting.
@@ -622,7 +578,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		goto update;
 	}
 
-	stime = scale_stime(stime, rtime, stime + utime);
+	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
 
 update:
 	/*
