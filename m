Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A24C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4CF20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBfmujPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGOCFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA235C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so1297701pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hMCjz+92Go61XkKZ2KMP8Y2GkwrHTA5+Bwzj3gXnH/0=;
        b=MBfmujPeyn0IdrSwOHGVo9a3VpMNRn6TeZf7/RFd0B0J6XD9VPV0WJMHnmgGXrF3zJ
         a5cmGVYTCxM6wTojk8M78+v6KQa+5illqo07dzRaUED0a27GxkDvtLTf1Jy8EV3fPmKI
         uoD4X/LECFe7OZQbLUC4qeBmYgpOkOoESsQpf4kSLdesuSmOLwvUIhnZzk06XVuajbBZ
         4XXE45D+qYtwLmi17ipzwzDkCGBFBWaQkgC88SvkOFSMphMWklW1sXp1o6iKenfVJDpj
         ciclauAccDb4jB166FCuZSiYxDKciO36aOfGo72e2ZOVhKXyy6ZfQZwMVumPlJXqi4ep
         nEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hMCjz+92Go61XkKZ2KMP8Y2GkwrHTA5+Bwzj3gXnH/0=;
        b=KdTczizfP2yQWr/SkDszpJ1adATjHjX7NCM6yG9allnVtxQA20nI6RwQDWX6GcVpJE
         DhGL3gfHVcGbprHwF2aqi2V43ynUVPK/o14+RzpkMygJxjMq20r6ia66bFjufXBS/Exj
         mfmGSMDN7F3lyaIqC8PQvZQEcM20BIpMJf1/ghCrBkH7Q/q7DenrCzex7+zYDj0i/YxD
         FBARisCfw42QlVKQ+pdqaYwyAHpJGd+3ZK0s0OtYNkBC+q+hpqR7d/gpl9t7USr+rBmA
         4eOvVXSJuqzZMQI5Z65ijMuiYKfAu69pkWD6LdAnLpEm9gJjjfGs0NzyS8iuyK35z0zI
         e03A==
X-Gm-Message-State: AOAM5322ScYP729f9qXw6FY7hjh99Z9swfDVdyCrJmPnPf4M0w6xv99T
        IIz6P8jA6htbPAdCMp15JA/Cyg==
X-Google-Smtp-Source: ABdhPJweKUBha3SLMEvJ8s2uZ+OFHY4WBgN+V4lhlk4NpJLYQnE4We4H9eumEdWXhqvcTPSS4e/8sQ==
X-Received: by 2002:a17:90a:bc98:: with SMTP id x24mr6851187pjr.63.1594778733247;
        Tue, 14 Jul 2020 19:05:33 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id h7sm374726pfq.15.2020.07.14.19.05.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:05:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Date:   Wed, 15 Jul 2020 10:05:07 +0800
Message-Id: <20200715020512.20991-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
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

