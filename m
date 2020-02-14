Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D2C3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079AB222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4/hsDNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgBNHwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:52:00 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33922 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNHvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:55 -0500
Received: by mail-pg1-f202.google.com with SMTP id w5so5594776pgw.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJIU9tX854lhy6h2O96kfNSZrrlnQeGNtNeBWGcSC2Y=;
        b=J4/hsDNnoNkqjs9ygo79ngl9d/RQu/9NvHgpQhgEKZM1DY8hHBkVuAO0nkKvyRAWrZ
         dnWLh+lGWAC4uWuir63I4sE4yohchKKAkZzL7jliiO80f3oQpP32FYXQ35M2/ImrknL+
         7TLypmZMVQRwGCzdJa1sePKhop0GqbVabWCyMfPrDxM696+spk4H/Ou6jHqdKvU6uiay
         ztk9lp5iPrZI4why5BNfhZHjVTCZQrS4wjdjYHvxIuF64vOPqHaTS+6Kt+8aaHQvnBm7
         uVckeJhdmTEJnTnzmf3K71XEszHQDTTkjb6TzvmIpY4tXKHFaEEOnNVnO/SKZgfli+Nc
         UGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJIU9tX854lhy6h2O96kfNSZrrlnQeGNtNeBWGcSC2Y=;
        b=OOt+TIvXVOaA7sY1aikmeDfvitD7GzSuc8TGu4Nz6ZEOAQYS4VEdEUGQ7buaFhwSjk
         BYNFWTNaFQ6FH/biXyyzHIb/7q6HF/D58SePP/j9l3HJJ+SH2Dbyp2Ftv6BIfGGFhMxE
         xHALkuTs4HcoTPSQAA3PrklhEbciDBlk98HMVHEj2bJV1GxiGBGOFQ1ygHvpmVMwZjKK
         JP9rfwkqSFAc6r7208VhpXB3biGsnkb59DORioQPyFrceKFB878/gEaPeA89eCwwD2Vu
         63x6RMFK+CCMFNvMmhZGNIRGS6x1YcDp58RLe7Lvi+YpbwFCKuCM8PPs29vsBuHw9RGX
         nuFQ==
X-Gm-Message-State: APjAAAUfXka8MsDPhvLIu/IK1q2NvgRbAdKBOFha86Tspm4YJawGmFya
        c0ruchgJye4/AS7PBcwmGWRmK5k8EOQt
X-Google-Smtp-Source: APXvYqxj5sFzjwUDNiYJSHWBa3zlGwGFUwq+VJ+lxvfGWBZLsS2FBDIVpqWEzfo28M8Cx9yKw/G0RJm2Wyhf
X-Received: by 2002:a63:1a21:: with SMTP id a33mr2140030pga.421.1581666713637;
 Thu, 13 Feb 2020 23:51:53 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:32 -0800
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
Message-Id: <20200214075133.181299-6-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 5/6] perf/cgroup: Grow per perf_cpu_context heap storage
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

Allow the per-CPU min heap storage to have sufficient space for per-cgroup
iterators.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 18e4bb871d85..4eb4e67463bf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -892,6 +892,47 @@ static inline void perf_cgroup_sched_in(struct task_struct *prev,
 	rcu_read_unlock();
 }
 
+static int perf_cgroup_ensure_storage(struct perf_event *event,
+				struct cgroup_subsys_state *css)
+{
+	struct perf_cpu_context *cpuctx;
+	struct perf_event **storage;
+	int cpu, itr_cap, ret = 0;
+
+	/*
+	 * Allow storage to have sufficent space for an iterator for each
+	 * possibly nested cgroup plus an iterator for events with no cgroup.
+	 */
+	for (itr_cap = 1; css; css = css->parent)
+		itr_cap++;
+
+	for_each_possible_cpu(cpu) {
+		cpuctx = per_cpu_ptr(event->pmu->pmu_cpu_context, cpu);
+		if (itr_cap <= cpuctx->itr_storage_cap)
+			continue;
+
+		storage = kmalloc_node(itr_cap * sizeof(struct perf_event *),
+				       GFP_KERNEL, cpu_to_node(cpu));
+		if (!storage) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		raw_spin_lock_irq(&cpuctx->ctx.lock);
+		if (cpuctx->itr_storage_cap < itr_cap) {
+			swap(cpuctx->itr_storage, storage);
+			if (storage == cpuctx->itr_default)
+				storage = NULL;
+			cpuctx->itr_storage_cap = itr_cap;
+		}
+		raw_spin_unlock_irq(&cpuctx->ctx.lock);
+
+		kfree(storage);
+	}
+
+	return ret;
+}
+
 static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -911,6 +952,10 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 		goto out;
 	}
 
+	ret = perf_cgroup_ensure_storage(event, css);
+	if (ret)
+		goto out;
+
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
@@ -3437,6 +3482,8 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.size = 0,
 			.cap = cpuctx->itr_storage_cap,
 		};
+
+		lockdep_assert_held(&cpuctx->ctx.lock);
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
-- 
2.25.0.265.gbab2e86ba0-goog

