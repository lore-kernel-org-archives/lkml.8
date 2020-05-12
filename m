Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C2DC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82B0206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLMgyOgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgELMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgELMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2ACC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tCoP+0lzwb1Jj2Eij2DmHRu9bXTx0d6Wvl13asWaG0w=; b=YLMgyOgWrtMRmh+Io8OH17q3t1
        Nyy26fDC1tsktWz0jkXhVfiUh7hVd4wjTYuXshBSfpwENSdPVhXdhpSGW9LrbeQoVJQ5hFnLIniDO
        yocKJq3Mpc7W1evSt8xNKORTtfc2he0IyhX/ut9jmT3qq5YJCR9WPPNk/0nqAZ/pI+QBVsNyTZzwq
        JPQUxmvyG+WVyWNcDbHGVdVYL3f5hzzlbe4fTJmRqFPmVx8dLjPC+gDiaJqVfuYwPyEV3dOMJUqKd
        td0N3Y3mpTtQyNwOdqeBgTmdS3C2RJ5PpYAKndy1JEyaBdel45YRCm0UWabuZFPLPIU7rlajd/ONJ
        15UP/cxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJE-0007C2-1u; Tue, 12 May 2020 12:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 468BD305F2E;
        Tue, 12 May 2020 14:46:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 27BD920962E28; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124450.745021268@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:40:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 1/5] sched_clock: Expose struct clock_read_data
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support perf_event_mmap_page::cap_time features, an
architecture needs, aside from a userspace readable counter register,
to expose the exact clock data so that userspace can convert the
counter register into a correct timestamp.

Provide struct clock_read_data and two (seqcount) helpers so that
architectures (arm64 in specific) can expose the numbers to userspace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched_clock.h |   28 ++++++++++++++++++++++++++++
 kernel/time/sched_clock.c   |   41 +++++++++++++----------------------------
 2 files changed, 41 insertions(+), 28 deletions(-)

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
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -20,31 +20,6 @@
 #include "timekeeping.h"
 
 /**
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
-/**
  * struct clock_data - all data needed for sched_clock() (including
  *                     registration of a new clock source)
  *
@@ -93,6 +68,17 @@ static inline u64 notrace cyc_to_ns(u64
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
@@ -100,13 +86,12 @@ unsigned long long notrace sched_clock(v
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


