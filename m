Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D6720758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MtSGQvIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgESTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESTMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:12:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE379C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GjBFpoyqijPTDxinrjDWXYNyaw2KQR2J7AqFdwF4g6k=; b=MtSGQvIvgH1Tss3DC3hYhNeTxT
        q2lE+Al8EsD8UNBIbnrxNJ900THPIoGRJrNE9iEA6ypKcHiBnadMf+Nf2fp8uPgPZ9N1EYhSMa8Pz
        HycnpOYhuwGijVtD7azMpJrBvMZdSLIFxc9i8h+M3Ed/RlZ1EyEFsg8bw8OQmaPDeDlCdYq81Nm8d
        gcJeVXJwHRolBcXSkaCz2ZZ460P7qT/KHuwE/1HAJHxYpJjHP9IwbFiL7wqhIMuXKQA1zxScvZN5Y
        NuGSFUfOxMAyL/TmfTe+c01F9h6Yqml9nu9qCMMGLfDUgaF043z/7lQ8tUSc35ne4hj9cdkJfjpaC
        9Ti738XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb7eg-0007Ns-LZ; Tue, 19 May 2020 19:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DF4130067C;
        Tue, 19 May 2020 21:11:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5935825D60CB1; Tue, 19 May 2020 21:11:56 +0200 (CEST)
Date:   Tue, 19 May 2020 21:11:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200519191156.GA325280@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
 <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:33:34AM -0700, Linus Torvalds wrote:
> So I'd much rather see it as a weak function defined in
> lib/math/div64.c, and then architectures don't even need to override
> it at all. Just let them define their own (inline or not) function,
> and we have this as a weak fallback.

My compiler doesn't like overriding a __weak with a static inline. It
complains about redefinitions.

It works with extern inline though; but that is fairly rare in the
kernel. Still it compiles and generates the right code.

---
 arch/x86/include/asm/div64.h | 13 +++++++++++--
 include/linux/math64.h       |  2 ++
 kernel/sched/cputime.c       | 46 +-------------------------------------------
 lib/math/div64.c             | 39 +++++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9b8cb50768c2..320508d797de 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -74,16 +74,25 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 #else
 # include <asm-generic/div64.h>
 
-static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
+/*
+ * Will generate an #DE when the result doesn't fit u64, could fix with an
+ * __ex_table[] entry when it becomes an issue.
+ */
+extern __always_inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
 {
 	u64 q;
 
 	asm ("mulq %2; divq %3" : "=a" (q)
-				: "a" (a), "rm" ((u64)mul), "rm" ((u64)div)
+				: "a" (a), "rm" (mul), "rm" (div)
 				: "rdx");
 
 	return q;
 }
+
+static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
+{
+	return mul_u64_u64_div_u64(a, mul, div);
+}
 #define mul_u64_u32_div	mul_u64_u32_div
 
 #endif /* CONFIG_X86_32 */
diff --git a/include/linux/math64.h b/include/linux/math64.h
index 11a267413e8e..d097119419e6 100644
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
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 368ca7fd0d82..200a151e1be9 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -190,3 +190,42 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return __iter_div_u64_rem(dividend, divisor, remainder);
 }
 EXPORT_SYMBOL(iter_div_u64_rem);
+
+__weak u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
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
