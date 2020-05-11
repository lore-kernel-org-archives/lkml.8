Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E719CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E6C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M8H02oxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgEKJW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgEKJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:22:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D739C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rKzfrZPpJA1DJFRHcWafqulnttP8M0DdbunYLC4g23o=; b=M8H02oxp1YN5m9oPjQQBE/bEhA
        JcNaMKejpE4mwC39qOcDUZbbq6QLdGeeXVqCFuNBAMwYjG5uyftpMNKqoh5gA+1ELiS7PtOdfX+Sz
        pgCWWIzUDEZOgcJ4XXGBeRBtvLJPHQ/KgPcqr2IaFxT4kOHpr7gU5vsSx8ZhSqopziw3ZhcNbwPJA
        5oiCxcn1emL+esxo0pCoaFDSFDD6wkIjcPixTA09h5nkKfEnljb38J3dce/4legI0sv4PlgHGdFqK
        2jinCZe42a0DGHHgCelRqhOs6kluC39tsrdeGdfoLdI2VgN5a/EF44ujSgbxYp9MKn/T9gRla5rSi
        /nxJn0eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY4dP-0003WK-9b; Mon, 11 May 2020 09:22:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C4DF300261;
        Mon, 11 May 2020 11:22:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FC6B20961017; Mon, 11 May 2020 11:22:00 +0200 (CEST)
Date:   Mon, 11 May 2020 11:22:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20200511092200.GF2957@hirez.programming.kicks-ass.net>
References: <20200505135544.6003-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505135544.6003-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 09:55:41PM +0800, Leo Yan wrote:
> This patch set is to fix time offset prior to epoch for Arm arch timer.
> This series is mainly following on suggestions on LKML [1].
> 
> To acheive the accurate time offset for a clock source prior to epoch,
> patch 01 adds a new variant sched_clock_register_epoch() which allows to
> output an extra argument for time offset prior to sched clock's
> registration.
> 
> Patch 02 is to add handling for time offset in Arm arch timer driver, As
> Will Deacon suggested to "disable the perf userpage if sched_clock
> changes clocksource too" [2], after thinking about this suggestion, the
> race condition doesn't exist between sched_clock's registration and perf
> userpage.  The reason is sched_clock's registration is finished in
> system's initialisation phase and at this point it has no chance to use
> any userpage by Perf tool.  For this reason let's keep the code simple
> and don't acquire all Perf events' seqlock during sched_clock's
> registration.
> 

AFAICT that's still completely buggered. The fact that the clock starts
late is completely irrelevant, and might just be confusing you.

How this?

(_completely_ untested)

---
 arch/arm64/kernel/perf_event.c | 27 ++++++++++++++++++---------
 include/linux/sched_clock.h    | 28 ++++++++++++++++++++++++++++
 kernel/time/sched_clock.c      | 41 +++++++++++++----------------------------
 3 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..81a49a916660 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1165,28 +1165,37 @@ device_initcall(armv8_pmu_driver_init)
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
+
+	do {
+		rd = sched_clock_read_begin(&seq);
+
+		userpg->time_mult = rd->mult;
+		userpg->time_shift = rd->shift;
+		userpg->time_offset = rd->epoch_ns;
+
+		userpg->time_zero -= (rd->epoch_cyc * rd->shift) >> rd->shift;
+
+	} while (sched_clock_read_retry(seq));
+
+	userpg->time_offset = userpf->time_zero - now;
 
-	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
-			NSEC_PER_SEC, 0);
 	/*
 	 * time_shift is not expected to be greater than 31 due to
 	 * the original published conversion algorithm shifting a
 	 * 32-bit value (now specifies a 64-bit value) - refer
 	 * perf_event_mmap_page documentation in perf_event.h.
 	 */
-	if (shift == 32) {
-		shift = 31;
+	if (userpg->time_shift == 32) {
+		userpg->time_shift = 31;
 		userpg->time_mult >>= 1;
 	}
-	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
 }
diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 0bb04a96a6d4..939dfbcd3289 100644
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
+extern bool sched_clock_read_retry(unsigned int seq);
+
 extern void generic_sched_clock_init(void);
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fa3f800d7d76..c6d63b0d2999 100644
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
+	*seq = raw_read_seqcount(&cs.seq);
+	return cs.read_data + (seq & 1);
+}
+
+struct bool sched_clock_read_retry(unsigned int seq)
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
