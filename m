Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4451222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/kTp2ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgBNHvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:51:55 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42246 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:52 -0500
Received: by mail-pg1-f201.google.com with SMTP id 193so5568849pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ONMMzRQWR/7iPU/3JrNrGKX25Ix0G1ZblD3y7AsZ1e0=;
        b=r/kTp2efL/NiDxNxQMXuwpR/lmjVVZ/IOPnC3ERG2PZcq4tCKch1/aXiKGqD9CdZKe
         BR4bqgWGKlR83WlQb6xn/svJnlHJT4qfAburHpjmarm3nyHLBzJeVG93lwcw4BPyJKIh
         hNepX73x9oB27Zp//xUv087JW0zcAkzJw7qHAgo1Oj6ZXw9JMq8T5fQDhVTPx8yMvn3D
         wU46ooq4gXPo+x6jzWdeh+GUJVG2WCkfKaZYb2Ug79CjI+Fn5kfuz8WFoVvyZNyRtQai
         vueO+2Fh7Z2JYiLl6BAIbW4sbs7n6bqvDgk77UjQiNcl8uLa4aiUvMnueybQDTK0detb
         qwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ONMMzRQWR/7iPU/3JrNrGKX25Ix0G1ZblD3y7AsZ1e0=;
        b=ZCZ28jiL6rut6yYJ0rMeILIjflFdQv1ydeJ/7UtNHFgwNwd5hSIEIo0jss4Hh+Sc2n
         AZ6Ezagby/dQBGicTOTMn2mOxWmAgAQH//GllacxGkzjGqEzbAO1RoNozLbz1jumpNid
         VTLXS1ddqC/N+6Lonv2TbdCJed8+tv5rOsACJ60VPjShpH0u71q1W22ziEsO0oHg9xwS
         /fFmJSRpCz/0rOSTYg363R6ggUEkyEAzisAB6s3jiiSheygVXepR7sYzqA2qoDTqpWFv
         x8l6kH3G/jnOEU2gWU4aXE3eBbE6l00Vg9JGo59heSeFFOrJ968iB+v7cv+ez8u+2nzB
         zkVA==
X-Gm-Message-State: APjAAAWNbpvmiU9P75IsmLC6T44jGGfIgQCkDlDNsMA4JbM+QJOAn8B6
        1pKqTvi1OfD1+L9BCUqiaKvMsWSKOuEh
X-Google-Smtp-Source: APXvYqxjE1V06uEMRM7SMEIaa7/XYXaXJdHVwNzbCq+5o/eulBRwqr/tGsRNsmEI1qim4Xzg/lTQCPcwvBTB
X-Received: by 2002:a63:e405:: with SMTP id a5mr2119161pgi.320.1581666711143;
 Thu, 13 Feb 2020 23:51:51 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:31 -0800
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
Message-Id: <20200214075133.181299-5-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 4/6] perf: Add per perf_cpu_context min_heap storage
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The storage required for visit_groups_merge's min heap needs to vary in
order to support more iterators, such as when multiple nested cgroups'
events are being visited. This change allows for 2 iterators and doesn't
support growth.
Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  7 +++++
 kernel/events/core.c       | 53 ++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 68e21e828893..5060e31b32cc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -862,6 +862,13 @@ struct perf_cpu_context {
 	int				sched_cb_usage;
 
 	int				online;
+	/*
+	 * Per-CPU storage for iterators used in visit_groups_merge. The default
+	 * storage is of size 2 to hold the CPU and any CPU event iterators.
+	 */
+	int				itr_storage_cap;
+	struct perf_event		**itr_storage;
+	struct perf_event		*itr_default[2];
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 832e2a56a663..18e4bb871d85 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3419,36 +3419,48 @@ static void __heap_add(struct min_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_event_groups *groups,
-				int cpu,
+static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+				struct perf_event_groups *groups, int cpu,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
-	struct min_heap event_heap = {
-		.data = itrs,
-		.size = 0,
-		.cap = ARRAY_SIZE(itrs),
-	};
+	struct min_heap event_heap;
+	struct perf_event **evt;
 	struct perf_event *next;
 	int ret;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	if (cpuctx) {
+		event_heap = (struct min_heap){
+			.data = cpuctx->itr_storage,
+			.size = 0,
+			.cap = cpuctx->itr_storage_cap,
+		};
+	} else {
+		event_heap = (struct min_heap){
+			.data = itrs,
+			.size = 0,
+			.cap = ARRAY_SIZE(itrs),
+		};
+		/* Events not within a CPU context may be on any CPU. */
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	}
+	evt = event_heap.data;
+
 	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
 	min_heapify_all(&event_heap, &perf_min_heap);
 
 	while (event_heap.size) {
-		ret = func(itrs[0], data);
+		ret = func(*evt, data);
 		if (ret)
 			return ret;
 
-		next = perf_event_groups_next(itrs[0]);
-		if (next) {
-			min_heap_pop_push(&event_heap, &next,
-					&perf_min_heap);
-		} else
+		next = perf_event_groups_next(*evt);
+		if (next)
+			min_heap_pop_push(&event_heap, &next, &perf_min_heap);
+		else
 			min_heap_pop(&event_heap, &perf_min_heap);
 	}
 
@@ -3519,7 +3531,10 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->pinned_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->pinned_groups,
 			   smp_processor_id(),
 			   pinned_sched_in, &sid);
 }
@@ -3534,7 +3549,10 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		.can_add_hw = 1,
 	};
 
-	visit_groups_merge(&ctx->flexible_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->flexible_groups,
 			   smp_processor_id(),
 			   flexible_sched_in, &sid);
 }
@@ -10395,6 +10413,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
 		__perf_mux_hrtimer_init(cpuctx, cpu);
+
+		cpuctx->itr_storage_cap = ARRAY_SIZE(cpuctx->itr_default);
+		cpuctx->itr_storage = cpuctx->itr_default;
 	}
 
 got_cpu_context:
-- 
2.25.0.265.gbab2e86ba0-goog

