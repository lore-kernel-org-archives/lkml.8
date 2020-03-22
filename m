Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B47C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400D820719
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MrYynLtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCVKTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:19:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 06:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XPxgT8B/yYVHMvQLI4I3V9JmK0biKdpc9n7Ogrw49D0=; b=MrYynLtNAkyj4hG2jZQsZjP7e9
        h4GDKfO0xG1XImB/gJkGp7eTJ159O/oLKhVyGen9Nqq3Gwfw1Hii/u9/1bVqlShfFs3GDc3ZeVlRR
        cHXrHKSy48Ocn98nNQ3aCoWe2H9VIGUJyRXECl+rf8gVk0iSUBpu85raqzmvgFslO62jaTc63N6YV
        qGsdo7NNN3SywwjPIYIQa30L8nop+cOrSqrQP7/sNS9uAk+4WANQV1YOMRCWMMtPyFl+CKs0F/pi/
        +cAeghC1m9wc/lnLLMY1tbZcNz005GOrUEwWNpE0AH0USm9zfQGJ06nIpDAyHV6Kkf00GtUHvKLEj
        6sI2O8LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFxgy-0000NK-1S; Sun, 22 Mar 2020 10:18:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E23AB983500; Sun, 22 Mar 2020 11:18:48 +0100 (CET)
Date:   Sun, 22 Mar 2020 11:18:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf test x86: address multiplexing in rdpmc test
Message-ID: <20200322101848.GF2452@worktop.programming.kicks-ass.net>
References: <20200321173710.127770-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321173710.127770-1-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 10:37:10AM -0700, Ian Rogers wrote:

> +static u64 mmap_read_self(void *addr, u64 *running)
>  {
>  	struct perf_event_mmap_page *pc = addr;
>  	u32 seq, idx, time_mult = 0, time_shift = 0;
> -	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> +	u64 count, cyc = 0, time_offset = 0, enabled, delta;
>  
>  	do {
>  		seq = pc->lock;
>  		barrier();
>  
>  		enabled = pc->time_enabled;
> -		running = pc->time_running;
> -
> -		if (enabled != running) {
> +		*running = pc->time_running;
> +
> +		if (*running == 0) {
> +			/*
> +			 * Counter won't have a value as due to multiplexing the
> +			 * event wasn't scheduled.
> +			 */
> +			return 0;
> +		}

I still think adding code for an error case here is a bad idea. And only
passing running as an argument is inconsistent.

Also, then I had a look at what the compiler made of that function and
cried.

Here's something a little better. Much of it copied from linux/math64.h
and asm/div64.h.

---
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..386a6dacb21e 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -34,20 +34,98 @@ static u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }

-static u64 mmap_read_self(void *addr)
+#ifdef __x86_64__
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 q;
+
+	asm ("mulq %2; divq %3" : "=a" (q)
+				: "a" (a), "rm" (b), "rm" (c)
+				: "rdx");
+
+	return q;
+}
+#define mul_u64_u64_div64 mul_u64_u64_div64
+#endif
+
+#ifdef __SIZEOF_INT128__
+
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	return (u64)(((unsigned __int128)a * b) >> shift);
+}
+
+#ifndef mul_u64_u64_div64
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	unsigned __int128 m = a;
+	m *= b;
+	return m / c;
+}
+#endif
+
+#else
+
+#ifdef __i386__
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	u32 high, low;
+
+	asm ("mull %[b]" : "=a" (low), "=d" (high)
+			 : [a] "a" (a), [b] "rm" (b) );
+
+	return low | ((u64)high) << 32;
+}
+#else
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#endif
+
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	u32 ah, al;
+	u64 ret;
+
+	al = a;
+	ah = a >> 32;
+
+	ret = mul_u32_u32(al, mul) >> shift;
+	if (ah)
+		ret += mul_u32_u32(ah, mul) << (32 - shift);
+
+	return ret;
+}
+
+#ifndef mul_u64_u64_div64
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 quot, rem;
+
+	quot = a / c;
+	rem = a % c;
+
+	return qout * b + (rem * b) / c;
+}
+#endif
+
+#endif
+
+static u64 mmap_read_self(void *addr, u64 *enabled, u64 *running)
 {
 	struct perf_event_mmap_page *pc = addr;
 	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
+	u64 count, cyc = 0, time_offset = 0;

 	do {
 		seq = pc->lock;
 		barrier();

-		enabled = pc->time_enabled;
-		running = pc->time_running;
+		*enabled = pc->time_enabled;
+		*running = pc->time_running;

-		if (enabled != running) {
+		if (*enabled != *running) {
 			cyc = rdtsc();
 			time_mult = pc->time_mult;
 			time_shift = pc->time_shift;
@@ -62,21 +140,13 @@ static u64 mmap_read_self(void *addr)
 		barrier();
 	} while (pc->lock != seq);

-	if (enabled != running) {
-		u64 quot, rem;
-
-		quot = (cyc >> time_shift);
-		rem = cyc & (((u64)1 << time_shift) - 1);
-		delta = time_offset + quot * time_mult +
-			((rem * time_mult) >> time_shift);
-
-		enabled += delta;
+	if (*enabled != *running) {
+		u64 delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
+		*enabled += delta;
 		if (idx)
-			running += delta;
+			*running += delta;

-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
+		count = mul_u64_u64_div64(count, *enabled, *running);
 	}

 	return count;
@@ -130,14 +200,18 @@ static int __test__rdpmc(void)
 	}

 	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
+		u64 stamp, now, delta, enabled, running;

-		stamp = mmap_read_self(addr);
+		stamp = mmap_read_self(addr, &enabled, &running);

 		for (i = 0; i < loops; i++)
 			tmp++;

-		now = mmap_read_self(addr);
+		now = mmap_read_self(addr, &enabled, &running);
+
+		if (enabled && !running)
+			goto out_error;
+
 		loops *= 10;

 		delta = now - stamp;
@@ -155,6 +229,11 @@ static int __test__rdpmc(void)
 		return -1;

 	return 0;
+
+out_error:
+	close(fd);
+	pr_err("counter never ran; you loose\n");
+	return -1;
 }

 int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)

