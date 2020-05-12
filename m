Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24CC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233B8208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F643G+sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgELGiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:38:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59226C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:38:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so5896776pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVp/H5vK1lwJMxz1Tuv0jzbRm/AB7w7GAQub55XuNrw=;
        b=F643G+sjdAIO+h9mo6OtW2S6CZd1iA+QN5WBdXV9zGRi5tcZGajhOCcQQVRcmJ5li5
         Upg9aNEunWw0GJvdpqPombkvyK6QZKAZ+55GNGPnati7XhCn23EoHJjiXyAlNCf974BB
         OZPjBzImZIerq+3dZ+PeS1GzDJDWZdazz9E1Rp2cXQAu39Cfsn4UywyA6SMK8Ex8NwcW
         ZPJ5NiRyVfmS2ySSijsFByBkwLRUHvxSHIh7VmgEnd4uaJJBECx2BVHYRmcv7A+5CgRC
         pW+UEFGCePiJtArRz2vfLGLjQeYY6mVDne5HYIgP7MkM5jU9S8tXEDieG3gToLYBkO7n
         0CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVp/H5vK1lwJMxz1Tuv0jzbRm/AB7w7GAQub55XuNrw=;
        b=ZHfobsroySHgc61NrNbhl4DqO1Fpc5CplqsKv987aWRilhjL5IPCMMZ7JszLORbA49
         8PcGzUmDfiIBwSoUVXrAImlxd0HhjhqfNiCBxZQRHmYRE4nJTI1kvXmUbs3Y1SRXfVXK
         ioMUImF9ZzkwuCJB34yfd7pG3T8bUUW4D0epnBowN6ilt8QvVdnCoBsEOlZFyBH3J0eD
         4GFIzU9W+YxhtzRz8LuKQmi7auG+3MCa5Qa4QFYn1aSEIThCUf1unrqy3omPUyR9zeQL
         y2lHKm3hmN0InKBtRw5GskfewLXAO71FbSqjJb3sez8yowMcEPRSQueU+CniAUnd6iKG
         OKpA==
X-Gm-Message-State: AGi0PuZToZEA+0DxU14t6t0/pNHQGRU90LedVVy4EemJPoK0S1dBzstt
        nN36YfuXkmBFstikapJUV0db0A==
X-Google-Smtp-Source: APiQypLBuU+nD5LrMumbJLMS2ysqhuVlJ2lIgqjQzMgV49TwuzjyR/HNPSYuk0vSKvzrb8DhgKEhUQ==
X-Received: by 2002:a63:5250:: with SMTP id s16mr12868185pgl.115.1589265494672;
        Mon, 11 May 2020 23:38:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id v127sm10885941pfv.77.2020.05.11.23.38.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:38:13 -0700 (PDT)
Date:   Tue, 12 May 2020 14:38:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200512063812.GA20352@leoy-ThinkPad-X240s>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
 <20200511092519.GA3001@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511092519.GA3001@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, May 11, 2020 at 11:25:19AM +0200, Peter Zijlstra wrote:
> On Mon, May 11, 2020 at 11:22:00AM +0200, Peter Zijlstra wrote:
> 
> > (_completely_ untested)
> > 
> > ---
> >  arch/arm64/kernel/perf_event.c | 27 ++++++++++++++++++---------
> >  include/linux/sched_clock.h    | 28 ++++++++++++++++++++++++++++
> >  kernel/time/sched_clock.c      | 41 +++++++++++++----------------------------
> >  3 files changed, 59 insertions(+), 37 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 4d7879484cec..81a49a916660 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -1165,28 +1165,37 @@ device_initcall(armv8_pmu_driver_init)
> >  void arch_perf_update_userpage(struct perf_event *event,
> >  			       struct perf_event_mmap_page *userpg, u64 now)
> >  {
> > -	u32 freq;
> > -	u32 shift;
> > +	struct clock_read_data *rd;
> > +	unsigned int seq;
> >  
> >  	/*
> >  	 * Internal timekeeping for enabled/running/stopped times
> >  	 * is always computed with the sched_clock.
> >  	 */
> > -	freq = arch_timer_get_rate();
> >  	userpg->cap_user_time = 1;
> > +	userpg->cap_user_time_zero = 1;
> > +
> > +	do {
> > +		rd = sched_clock_read_begin(&seq);
> > +
> > +		userpg->time_mult = rd->mult;
> > +		userpg->time_shift = rd->shift;
> > +		userpg->time_offset = rd->epoch_ns;
> 
> 			^^^^^^^ wants to be time_zero
> 
> > +
> > +		userpg->time_zero -= (rd->epoch_cyc * rd->shift) >> rd->shift;
> > +
> > +	} while (sched_clock_read_retry(seq));
> > +
> > +	userpg->time_offset = userpf->time_zero - now;
> >  
> > -	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
> > -			NSEC_PER_SEC, 0);
> 
> And that ^^^ was complete crap.
> 
> >  	/*
> >  	 * time_shift is not expected to be greater than 31 due to
> >  	 * the original published conversion algorithm shifting a
> >  	 * 32-bit value (now specifies a 64-bit value) - refer
> >  	 * perf_event_mmap_page documentation in perf_event.h.
> >  	 */
> > -	if (shift == 32) {
> > -		shift = 31;
> > +	if (userpg->time_shift == 32) {
> > +		userpg->time_shift = 31;
> >  		userpg->time_mult >>= 1;
> >  	}
> > -	userpg->time_shift = (u16)shift;
> > -	userpg->time_offset = -now;
> >  }

I have verified this change, it works as expected on my Arm64 board.
Also paste the updated code which makes building success with minor
fixing.

I am not sure how to proceed, will you merge this?  Or you want me to
send out formal patches (or only for the Arm64 part)?

P.s. it's shame I still missed you guys suggestion in prvious thread
even though you have provide enough ifno, and thank you for the helping!

---8<---

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..5a34e9264c5b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
@@ -1165,28 +1166,26 @@ device_initcall(armv8_pmu_driver_init)
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
-	u32 freq;
-	u32 shift;
+	struct clock_read_data *rd;
+	unsigned int seq;
 
 	/*
 	 * Internal timekeeping for enabled/running/stopped times
 	 * is always computed with the sched_clock.
 	 */
-	freq = arch_timer_get_rate();
 	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
 
-	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
-			NSEC_PER_SEC, 0);
-	/*
-	 * time_shift is not expected to be greater than 31 due to
-	 * the original published conversion algorithm shifting a
-	 * 32-bit value (now specifies a 64-bit value) - refer
-	 * perf_event_mmap_page documentation in perf_event.h.
-	 */
-	if (shift == 32) {
-		shift = 31;
-		userpg->time_mult >>= 1;
-	}
-	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
+	do {
+		rd = sched_clock_read_begin(&seq);
+
+		userpg->time_mult = rd->mult;
+		userpg->time_shift = rd->shift;
+		userpg->time_zero = rd->epoch_ns;
+
+		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
+
+	} while (sched_clock_read_retry(seq));
+
+	userpg->time_offset = userpg->time_zero - now;
 }
diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 0bb04a96a6d4..528718e4ed52 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -6,6 +6,34 @@
 #define LINUX_SCHED_CLOCK
 
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
+/**
+ * struct clock_read_data - data required to read from sched_clock()
+ *
+ * @epoch_ns:		sched_clock() value at last update
+ * @epoch_cyc:		Clock cycle value at last update.
+ * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
+ *			clocks.
+ * @read_sched_clock:	Current clock source (or dummy source when suspended).
+ * @mult:		Multipler for scaled math conversion.
+ * @shift:		Shift value for scaled math conversion.
+ *
+ * Care must be taken when updating this structure; it is read by
+ * some very hot code paths. It occupies <=40 bytes and, when combined
+ * with the seqcount used to synchronize access, comfortably fits into
+ * a 64 byte cache line.
+ */
+struct clock_read_data {
+	u64 epoch_ns;
+	u64 epoch_cyc;
+	u64 sched_clock_mask;
+	u64 (*read_sched_clock)(void);
+	u32 mult;
+	u32 shift;
+};
+
+extern struct clock_read_data *sched_clock_read_begin(unsigned int *seq);
+extern int sched_clock_read_retry(unsigned int seq);
+
 extern void generic_sched_clock_init(void);
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fa3f800d7d76..0acaadc3156c 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -19,31 +19,6 @@
 
 #include "timekeeping.h"
 
-/**
- * struct clock_read_data - data required to read from sched_clock()
- *
- * @epoch_ns:		sched_clock() value at last update
- * @epoch_cyc:		Clock cycle value at last update.
- * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
- *			clocks.
- * @read_sched_clock:	Current clock source (or dummy source when suspended).
- * @mult:		Multipler for scaled math conversion.
- * @shift:		Shift value for scaled math conversion.
- *
- * Care must be taken when updating this structure; it is read by
- * some very hot code paths. It occupies <=40 bytes and, when combined
- * with the seqcount used to synchronize access, comfortably fits into
- * a 64 byte cache line.
- */
-struct clock_read_data {
-	u64 epoch_ns;
-	u64 epoch_cyc;
-	u64 sched_clock_mask;
-	u64 (*read_sched_clock)(void);
-	u32 mult;
-	u32 shift;
-};
-
 /**
  * struct clock_data - all data needed for sched_clock() (including
  *                     registration of a new clock source)
@@ -93,6 +68,17 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 	return (cyc * mult) >> shift;
 }
 
+struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
+{
+	*seq = raw_read_seqcount(&cd.seq);
+	return cd.read_data + (*seq & 1);
+}
+
+int sched_clock_read_retry(unsigned int seq)
+{
+	return read_seqcount_retry(&cd.seq, seq);
+}
+
 unsigned long long notrace sched_clock(void)
 {
 	u64 cyc, res;
@@ -100,13 +86,12 @@ unsigned long long notrace sched_clock(void)
 	struct clock_read_data *rd;
 
 	do {
-		seq = raw_read_seqcount(&cd.seq);
-		rd = cd.read_data + (seq & 1);
+		rd = sched_clock_read_begin(&seq);
 
 		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
 		      rd->sched_clock_mask;
 		res = rd->epoch_ns + cyc_to_ns(cyc, rd->mult, rd->shift);
-	} while (read_seqcount_retry(&cd.seq, seq));
+	} while (sched_clock_read_retry(seq));
 
 	return res;
 }
