Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAF920823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSgRjTzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgETUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:15:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52952 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgETUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vGYLD4Cni5M9CK3uoOXYgFf41AEDAEgPVaZ/0V765OQ=; b=VSgRjTzyAQQbW4lY+svSnjlCAX
        RL6soiS99O7rFAjN5R4CfyeU3Jju9R8Zk9B47+X0+U5cSgcXIhKni+KNiA9TDo/P9tznMgQLZRVpj
        tIpZ6pzs+tkZwjQG7hgh6P/j5+nEI73JNfHjCDDNkdYbr1SPPYWuogEl5+ot63MK17ROlM9QadJIH
        dgPMiwJinkUPve3j3GGJwNb+NWzSG2boImWndt/Z1Yf5QqFAm8kgKjM0yzj8B60ST0L65zEYvC8hL
        cE4fbbRWoqz+nIc2nU5WZw9RUWjHNWMp75UhS30RAr0/JyQ0U0uRmoGU4x9v4yawK2gCECBpbINBH
        XM8WBjrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbV2w-0003Pt-G1; Wed, 20 May 2020 20:10:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32558301A80;
        Wed, 20 May 2020 22:10:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F14921ABED2A; Wed, 20 May 2020 22:10:33 +0200 (CEST)
Date:   Wed, 20 May 2020 22:10:33 +0200
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
Message-ID: <20200520201033.GA325303@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
 <20200520152439.GC26470@redhat.com>
 <20200520153603.GP317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520153603.GP317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:36:03PM +0200, Peter Zijlstra wrote:
> On Wed, May 20, 2020 at 05:24:40PM +0200, Oleg Nesterov wrote:
> > Nevermind, I agree with your version. Will you send this patch or do you
> > want me to make V3 ?
> 
> I got stuck at writing a Changelog, am more scatter brained than usual,
> due to lack of sleep. If you have Changelog that includes information
> rather than links to it, feel free to send it along and I'll frob the
> thing together, or just send a v3 with everything on.
> 
> Otherwise, I'll try again tomorrow :-)

I had a another go; I ended up with this...

---
Subject: sched/cputime: Improve cputime_adjust()
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 19 May 2020 19:25:06 +0200

From: Oleg Nesterov <oleg@redhat.com>

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
---
 arch/x86/include/asm/div64.h |   13 ++++++++++--
 include/linux/math64.h       |    2 +
 kernel/sched/cputime.c       |   46 -------------------------------------------
 lib/math/div64.c             |   39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 47 deletions(-)

--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -74,16 +74,25 @@ static inline u64 mul_u32_u32(u32 a, u32
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
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -263,6 +263,8 @@ static inline u64 mul_u64_u32_div(u64 a,
 }
 #endif /* mul_u64_u32_div */
 
+u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
+
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -520,50 +520,6 @@ void account_idle_ticks(unsigned long ti
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
@@ -622,7 +578,7 @@ void cputime_adjust(struct task_cputime
 		goto update;
 	}
 
-	stime = scale_stime(stime, rtime, stime + utime);
+	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
 
 update:
 	/*
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -190,3 +190,42 @@ u32 iter_div_u64_rem(u64 dividend, u32 d
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
