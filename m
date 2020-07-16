Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB57C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CC4207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt773ugE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGPFMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:11:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:11:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so3347302pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZudUuOTNYLjrn927Wl/0yhsw+jXTcOSpfU/HEVcjSaU=;
        b=Gt773ugE0h5EgoccjmZl2Lzgz6qbZQF7ighWOfIN6A3dQJnKxXJTf185l8MbquwkH3
         A3+XGKXQKfOqQSFhrCa1bopgyeKqM0oKMe2twwL7IkCP8d9+QlGYBdOryOLalN4+pQPz
         IwdoyQj455gQ21EVTpL8VZ9ZFKuk7aOM+muj+xJV3nA+tnIzKQ9Fxw3QmBcMDNKDnsW7
         KCgGh2vQQF69RT8FkDYELw2fVMBW78CdrIZvnieOJ5pX66eEAKt0fdlk2PlTDi7TNEoc
         4SrCSCkMBcJPbPI3ktSXHbeZ8MbcQa++cZT4ln3YNWt4nvwMfLtGsq6smxxCsh2MZG2F
         w0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZudUuOTNYLjrn927Wl/0yhsw+jXTcOSpfU/HEVcjSaU=;
        b=Qaj+ixVF3+K+inuELSsksgHYub1YmBiMz8QaiLv5Cq3fpk4Ax+U4ce7fYoLiyiNNJJ
         zJQCUUx7/6eBEcQRJWRg8zfUcM9Mj5DXumadsbMZhl+dJuqTtJ3ed0Pfh8xXs8oWvol9
         3u4k14ic+IrUfNfoD5WkdFg3qY70DqrQOAhuC0QzngsmbdA6xba3hZtxmkUDijrUxY0N
         8l7pwokqrb1E8q+Qt/BOQg8u2V5Ctq8vJWFx04CW3j++P5gFUgRgt6I4Vl1P3GH0yA1k
         o74+0EGRBc0E0vru29e+hda0dUZZKl6/dD+8k52oeKtduAiKbabWpb9r8jocTRL6YyZ+
         G+xA==
X-Gm-Message-State: AOAM530P9u9Fr5NQVAmDCbMYQWX4vzL+wLAkwX7fIl9y2pCMagEkk/5t
        63zFSK6ABYqDxQogjLhkulkldg==
X-Google-Smtp-Source: ABdhPJxLGTY7dEuWAlIYrXYOh6qTVtPq90fdCUjRoXKAII2jiuebeKM7/zHYlSqnZ/kmm1PEMSqrCg==
X-Received: by 2002:a17:90a:7406:: with SMTP id a6mr2798818pjg.152.1594876319114;
        Wed, 15 Jul 2020 22:11:59 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id l17sm3701086pgn.48.2020.07.15.22.11.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:11:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/7] sched_clock: Expose struct clock_read_data
Date:   Thu, 16 Jul 2020 13:11:24 +0800
Message-Id: <20200716051130.4359-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In order to support perf_event_mmap_page::cap_time features, an
architecture needs, aside from a userspace readable counter register,
to expose the exact clock data so that userspace can convert the
counter register into a correct timestamp.

Provide struct clock_read_data and two (seqcount) helpers so that
architectures (arm64 in specific) can expose the numbers to userspace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 include/linux/sched_clock.h | 28 +++++++++++++++++++++++++
 kernel/time/sched_clock.c   | 41 ++++++++++++-------------------------
 2 files changed, 41 insertions(+), 28 deletions(-)

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
-- 
2.17.1

