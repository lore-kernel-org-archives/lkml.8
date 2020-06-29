Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E4C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A5720702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FSZIXoXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgF2DTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgF2DT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:19:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D1C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so795068pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaA9jUuSJfuxXQxYO24v+FgfOdOoJJudQbbX4y1p8G0=;
        b=FSZIXoXXS39bifqbHm+zuXWtJuz6QwKU5GcQ0afKIRP4nNn7gldAGXm+uUYbo3r/S0
         ZL5PuNXLxkT3ezATzbCFYz2eRWHgL9hmxaN7ZE212yoilzt+lKbR6pyKikAj9zjdGCbs
         0DwCgx9t2bGuuyARKrSiRQZexD1+L/4brd8b3f71afegco+kq4U7SNhMQg20g6mcbkoF
         CZAi0zI07jx14xm6psRCSqvI+ecgQJM7TJKBSeEjGq+ACvVr0wBK9wQNpd0F5U8ehuyR
         fyLpVr1tHaHxeMHvgJ/PlIlg0QQ6ePTm+9c7L+cM1KnnozJlKbXSe+dNgT7bff8RJmsU
         91Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaA9jUuSJfuxXQxYO24v+FgfOdOoJJudQbbX4y1p8G0=;
        b=epFFqPeqZbKgk4TPZrSIMG2Gzvm+oowAhTVreTTATSPY2Yfegp89tIMWTvFHxm7ijc
         vRgqGNzmKefqNg4kypk25MvgJuELDiqAqbW5nfGhpqdqrNBvI9OHMePO4nJAknnasGzR
         g0gnS2Rf/J+pCF8fA7tKcznPCP86eMOv3O4YOvCC9/xjVJ/RK18aZxNok69J06e9Y2Hr
         JSPxDI4+OfaooTXjEuRFuGZJkIWZN1Q4oiHleT5NBMpwbNUvLQ5TfkmMqoQmF8hW5S+f
         hYHTn4OtJrUvHFkNm0/vDKGXrKnBEB0cRIzAZcz44LPZMNj1GyzUBLbVV8QQ7f+mGOxq
         MnHw==
X-Gm-Message-State: AOAM532335x24nq/M1jNowdFocsw557wiFUefa0NxaAD/BKKHktPmJX1
        6KXVo8AwprB8nk5XlLLeI5rQLQ==
X-Google-Smtp-Source: ABdhPJwqAHV4Y/B8eXziL2RjxQ7Ie/ERnFbsKQBIA1HBGa0rmRgSRh+V6Rf9OYCO7WKHrCjnWDtbbg==
X-Received: by 2002:a63:a13:: with SMTP id 19mr8456092pgk.100.1593400766742;
        Sun, 28 Jun 2020 20:19:26 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j70sm12876254pfd.208.2020.06.28.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 20:19:26 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 4/6] riscv: perf: Add raw event support
Date:   Mon, 29 Jun 2020 11:19:13 +0800
Message-Id: <8b9f52c19bdb11a4ad741ad1a3695526a1d061b8.1593397455.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
References: <cover.1593397455.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for raw events and hardware cache events. Currently, we set
the events by writing the mhpmeventN CSRs, it would raise an illegal
instruction exception and trap into m-mode to emulate event selector
CSRs access. It doesn't make sense because we shouldn't write the
m-mode CSRs in s-mode, it would be better that set events through SBI
call or the shadow CSRs of s-mode. We would change it later.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/perf_event.h |  65 ++++++---
 arch/riscv/kernel/perf_event.c      | 204 +++++++++++++++++++++++-----
 2 files changed, 215 insertions(+), 54 deletions(-)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index 062efd3a1d5d..41d515a1f331 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -14,39 +14,64 @@
 
 #ifdef CONFIG_RISCV_BASE_PMU
 #define RISCV_BASE_COUNTERS	2
+#define RISCV_EVENT_COUNTERS	29
+#define RISCV_TOTAL_COUNTERS	(RISCV_BASE_COUNTERS + RISCV_EVENT_COUNTERS)
 
 /*
- * The RISCV_MAX_COUNTERS parameter should be specified.
- */
-
-#define RISCV_MAX_COUNTERS	2
-
-/*
- * These are the indexes of bits in counteren register *minus* 1,
- * except for cycle.  It would be coherent if it can directly mapped
- * to counteren bit definition, but there is a *time* register at
- * counteren[1].  Per-cpu structure is scarce resource here.
- *
  * According to the spec, an implementation can support counter up to
  * mhpmcounter31, but many high-end processors has at most 6 general
  * PMCs, we give the definition to MHPMCOUNTER8 here.
  */
-#define RISCV_PMU_CYCLE		0
-#define RISCV_PMU_INSTRET	1
-#define RISCV_PMU_MHPMCOUNTER3	2
-#define RISCV_PMU_MHPMCOUNTER4	3
-#define RISCV_PMU_MHPMCOUNTER5	4
-#define RISCV_PMU_MHPMCOUNTER6	5
-#define RISCV_PMU_MHPMCOUNTER7	6
-#define RISCV_PMU_MHPMCOUNTER8	7
+#define RISCV_PMU_CYCLE			0
+#define RISCV_PMU_INSTRET		2
+#define RISCV_PMU_HPMCOUNTER3		3
+#define RISCV_PMU_HPMCOUNTER4		4
+#define RISCV_PMU_HPMCOUNTER5		5
+#define RISCV_PMU_HPMCOUNTER6		6
+#define RISCV_PMU_HPMCOUNTER7		7
+#define RISCV_PMU_HPMCOUNTER8		8
+
+#define RISCV_PMU_HPMCOUNTER_FIRST	3
+#define RISCV_PMU_HPMCOUNTER_LAST					\
+	(RISCV_PMU_HPMCOUNTER_FIRST + riscv_pmu->num_counters - 1)
 
 #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
 
+/* Hardware cache event encoding */
+#define PERF_HW_CACHE_TYPE		0
+#define PERF_HW_CACHE_OP		8
+#define PERF_HW_CACHE_RESULT		16
+#define PERF_HW_CACHE_MASK		0xff
+
+/* config_base encoding */
+#define RISCV_PMU_TYPE_MASK		0x3
+#define RISCV_PMU_TYPE_BASE		0x1
+#define RISCV_PMU_TYPE_EVENT		0x2
+#define RISCV_PMU_EXCLUDE_MASK		0xc
+#define RISCV_PMU_EXCLUDE_USER		0x3
+#define RISCV_PMU_EXCLUDE_KERNEL	0x4
+
+/*
+ * Currently, machine-mode supports emulation of mhpmeventN. Setting mhpmeventN
+ * to raise an illegal instruction exception to set event types in machine-mode.
+ * Eventually, we should set event types through standard SBI call or the shadow
+ * CSRs of supervisor-mode, because it is weird for writing CSR of machine-mode
+ * explicitly in supervisor-mode. These macro should be removed in the future.
+ */
+#define CSR_MHPMEVENT3	0x323
+#define CSR_MHPMEVENT4	0x324
+#define CSR_MHPMEVENT5	0x325
+#define CSR_MHPMEVENT6	0x326
+#define CSR_MHPMEVENT7	0x327
+#define CSR_MHPMEVENT8	0x328
+
 struct cpu_hw_events {
 	/* # currently enabled events*/
 	int			n_events;
 	/* currently enabled events */
-	struct perf_event	*events[RISCV_MAX_COUNTERS];
+	struct perf_event	*events[RISCV_EVENT_COUNTERS];
+	/* bitmap of used event counters */
+	unsigned long		used_cntr_mask;
 	/* vendor-defined PMU data */
 	void			*platform;
 };
diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index c835f0362d94..0cfcd6f1e57b 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -139,6 +139,53 @@ static const int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
 	},
 };
 
+/*
+ * Methods for checking and getting PMU information
+ */
+
+static inline int is_base_counter(int idx)
+{
+	return (idx == RISCV_PMU_CYCLE || idx == RISCV_PMU_INSTRET);
+}
+
+static inline int is_event_counter(int idx)
+{
+	return (idx >= RISCV_PMU_HPMCOUNTER_FIRST &&
+		idx <= RISCV_PMU_HPMCOUNTER_LAST);
+}
+
+static inline int get_available_counter(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long config_base = hwc->config_base & RISCV_PMU_TYPE_MASK;
+	unsigned long mask;
+	int ret;
+
+	switch (config_base) {
+	case RISCV_PMU_TYPE_BASE:
+		ret = hwc->config;
+		if (WARN_ON_ONCE(!is_base_counter(ret)))
+			return -ENOSPC;
+		break;
+	case RISCV_PMU_TYPE_EVENT:
+		mask = ~cpuc->used_cntr_mask;
+		ret = find_next_bit(&mask, RISCV_PMU_HPMCOUNTER_LAST, 3);
+		if (WARN_ON_ONCE(!is_event_counter(ret)))
+			return -ENOSPC;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	__set_bit(ret, &cpuc->used_cntr_mask);
+
+	return ret;
+}
+
+/*
+ * Map generic hardware event
+ */
 static int riscv_map_hw_event(u64 config)
 {
 	if (config >= riscv_pmu->max_events)
@@ -147,32 +194,28 @@ static int riscv_map_hw_event(u64 config)
 	return riscv_pmu->hw_events[config];
 }
 
-static int riscv_map_cache_decode(u64 config, unsigned int *type,
-			   unsigned int *op, unsigned int *result)
-{
-	return -ENOENT;
-}
-
+/*
+ * Map generic hardware cache event
+ */
 static int riscv_map_cache_event(u64 config)
 {
 	unsigned int type, op, result;
-	int err = -ENOENT;
-		int code;
+	int ret;
 
-	err = riscv_map_cache_decode(config, &type, &op, &result);
-	if (!riscv_pmu->cache_events || err)
-		return err;
+	type	= (config >> PERF_HW_CACHE_TYPE) & PERF_HW_CACHE_MASK;
+	op	= (config >> PERF_HW_CACHE_OP) & PERF_HW_CACHE_MASK;
+	result	= (config >> PERF_HW_CACHE_RESULT) & PERF_HW_CACHE_MASK;
 
 	if (type >= PERF_COUNT_HW_CACHE_MAX ||
 	    op >= PERF_COUNT_HW_CACHE_OP_MAX ||
 	    result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
 
-	code = (*riscv_pmu->cache_events)[type][op][result];
-	if (code == RISCV_OP_UNSUPP)
+	ret = riscv_cache_event_map[type][op][result];
+	if (ret == RISCV_OP_UNSUPP)
 		return -EINVAL;
 
-	return code;
+	return ret == RISCV_OP_UNSUPP ? -ENOENT : ret;
 }
 
 /*
@@ -190,8 +233,27 @@ static inline u64 read_counter(int idx)
 	case RISCV_PMU_INSTRET:
 		val = csr_read(CSR_INSTRET);
 		break;
+	case RISCV_PMU_HPMCOUNTER3:
+		val = csr_read(CSR_HPMCOUNTER3);
+		break;
+	case RISCV_PMU_HPMCOUNTER4:
+		val = csr_read(CSR_HPMCOUNTER4);
+		break;
+	case RISCV_PMU_HPMCOUNTER5:
+		val = csr_read(CSR_HPMCOUNTER5);
+		break;
+	case RISCV_PMU_HPMCOUNTER6:
+		val = csr_read(CSR_HPMCOUNTER6);
+		break;
+	case RISCV_PMU_HPMCOUNTER7:
+		val = csr_read(CSR_HPMCOUNTER7);
+		break;
+	case RISCV_PMU_HPMCOUNTER8:
+		val = csr_read(CSR_HPMCOUNTER8);
+		break;
 	default:
-		WARN_ON_ONCE(idx < 0 ||	idx > RISCV_MAX_COUNTERS);
+		WARN_ON_ONCE(idx < RISCV_PMU_CYCLE ||
+			     idx > RISCV_TOTAL_COUNTERS);
 		return -EINVAL;
 	}
 
@@ -204,6 +266,68 @@ static inline void write_counter(int idx, u64 value)
 	WARN_ON_ONCE(1);
 }
 
+static inline void write_event(int idx, u64 value)
+{
+	/* TODO: We shouldn't write CSR of m-mode explicitly here. Ideally,
+	 * it need to set the event selector by SBI call or the s-mode
+	 * shadow CSRs of them. Exploit illegal instruction exception to
+	 * emulate mhpmcounterN access in m-mode.
+	 */
+	switch (idx) {
+	case RISCV_PMU_HPMCOUNTER3:
+		csr_write(CSR_MHPMEVENT3, value);
+		break;
+	case RISCV_PMU_HPMCOUNTER4:
+		csr_write(CSR_MHPMEVENT4, value);
+		break;
+	case RISCV_PMU_HPMCOUNTER5:
+		csr_write(CSR_MHPMEVENT5, value);
+		break;
+	case RISCV_PMU_HPMCOUNTER6:
+		csr_write(CSR_MHPMEVENT6, value);
+		break;
+	case RISCV_PMU_HPMCOUNTER7:
+		csr_write(CSR_MHPMEVENT7, value);
+		break;
+	case RISCV_PMU_HPMCOUNTER8:
+		csr_write(CSR_MHPMEVENT8, value);
+		break;
+	default:
+		WARN_ON_ONCE(idx < RISCV_PMU_HPMCOUNTER3 ||
+			     idx > RISCV_TOTAL_COUNTERS);
+		return;
+	}
+}
+
+/*
+ * Enable and disable event counters
+ */
+
+static inline void riscv_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (is_event_counter(idx))
+		write_event(idx, hwc->config);
+
+	/*
+	 * Since we cannot write to counters, this serves as an initialization
+	 * to the delta-mechanism in pmu->read(); otherwise, the delta would be
+	 * wrong when pmu->read is called for the first time.
+	 */
+	local64_set(&hwc->prev_count, read_counter(hwc->idx));
+}
+
+static inline void riscv_pmu_disable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (is_event_counter(idx))
+		write_event(idx, 0);
+}
+
 /*
  * pmu->read: read and update the counter
  *
@@ -232,6 +356,7 @@ static void riscv_pmu_read(struct perf_event *event)
 	 */
 	delta = (new_raw_count - prev_raw_count) &
 		((1ULL << riscv_pmu->counter_width) - 1);
+
 	local64_add(delta, &event->count);
 	/*
 	 * Something like local64_sub(delta, &hwc->period_left) here is
@@ -252,6 +377,11 @@ static void riscv_pmu_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
+	if (WARN_ON_ONCE(hwc->idx == -1))
+		return;
+
+	riscv_pmu_disable_event(event);
+
 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
 
@@ -271,6 +401,9 @@ static void riscv_pmu_start(struct perf_event *event, int flags)
 	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
 		return;
 
+	if (WARN_ON_ONCE(hwc->idx == -1))
+		return;
+
 	if (flags & PERF_EF_RELOAD) {
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
 
@@ -281,14 +414,10 @@ static void riscv_pmu_start(struct perf_event *event, int flags)
 	}
 
 	hwc->state = 0;
-	perf_event_update_userpage(event);
 
-	/*
-	 * Since we cannot write to counters, this serves as an initialization
-	 * to the delta-mechanism in pmu->read(); otherwise, the delta would be
-	 * wrong when pmu->read is called for the first time.
-	 */
-	local64_set(&hwc->prev_count, read_counter(hwc->idx));
+	riscv_pmu_enable_event(event);
+
+	perf_event_update_userpage(event);
 }
 
 /*
@@ -298,21 +427,18 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
+	int count_idx;
 
 	if (cpuc->n_events == riscv_pmu->num_counters)
 		return -ENOSPC;
 
-	/*
-	 * We don't have general conunters, so no binding-event-to-counter
-	 * process here.
-	 *
-	 * Indexing using hwc->config generally not works, since config may
-	 * contain extra information, but here the only info we have in
-	 * hwc->config is the event index.
-	 */
-	hwc->idx = hwc->config;
-	cpuc->events[hwc->idx] = event;
+	count_idx = get_available_counter(event);
+	if (count_idx < 0)
+		return -ENOSPC;
+
 	cpuc->n_events++;
+	hwc->idx = count_idx;
+	cpuc->events[hwc->idx] = event;
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
@@ -330,8 +456,10 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	cpuc->events[hwc->idx] = NULL;
 	cpuc->n_events--;
+	__clear_bit(hwc->idx, &cpuc->used_cntr_mask);
+
+	cpuc->events[hwc->idx] = NULL;
 	riscv_pmu->pmu->stop(event, PERF_EF_UPDATE);
 	perf_event_update_userpage(event);
 }
@@ -385,6 +513,7 @@ static int riscv_event_init(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	struct hw_perf_event *hwc = &event->hw;
+	unsigned long config_base = 0;
 	int err;
 	int code;
 
@@ -406,11 +535,17 @@ static int riscv_event_init(struct perf_event *event)
 		code = riscv_pmu->map_cache_event(attr->config);
 		break;
 	case PERF_TYPE_RAW:
-		return -EOPNOTSUPP;
+		code = attr->config;
+		break;
 	default:
 		return -ENOENT;
 	}
 
+	if (is_base_counter(code))
+		config_base |= RISCV_PMU_TYPE_BASE;
+	else
+		config_base |= RISCV_PMU_TYPE_EVENT;
+
 	event->destroy = riscv_event_destroy;
 	if (code < 0) {
 		event->destroy(event);
@@ -424,6 +559,7 @@ static int riscv_event_init(struct perf_event *event)
 	 * But since we don't have such support, later in pmu->add(), we just
 	 * use hwc->config as the index instead.
 	 */
+	hwc->config_base = config_base;
 	hwc->config = code;
 	hwc->idx = -1;
 
-- 
2.27.0

