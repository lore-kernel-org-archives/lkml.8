Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C53C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C89D222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWSOWVyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgBNHv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:51:58 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38003 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgBNHv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:56 -0500
Received: by mail-pf1-f202.google.com with SMTP id 203so5558834pfx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X3y8JgVnk/Y9e0wWlm/DnS2whJ3/NHmhaM/cE8sR5AM=;
        b=UWSOWVyiZEDSHUL+hsZWXqTQHXKv1j/CHtOXetotarbYpgoo7UHWOBBEuy9+7wzbwG
         YJP8dylj/d/8sdZ07ahHGIL+vPtrXSqtILfNjivnvpyn1PlaSPOe78RhAHpIrA5X1eh8
         DypxajFX9JdpSfjhRmAEvFdecLF7T4/7dHup4YRpfXPYJmFaT2xredL40Zg7vrfNvwLe
         +tOq4/NIBr+KmAvR3bPrZWX0hBYrjBBnj4pzE8PmVXnouZ6oAq0fDkrMpJ00wdKTH4Gf
         YkZkhI/0LfuLdVjQPtYzO8C9D6Tbo52JiYPjtClSygMiyhvhuJU6IeIs9SmmXKA0JI9e
         tWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X3y8JgVnk/Y9e0wWlm/DnS2whJ3/NHmhaM/cE8sR5AM=;
        b=DgcIEYNKUznY9DI1UblSHTTfdM5acyy35WSsExB2vWdekeWzSHbAX/w4s/iHNzzdHI
         /68cSdDAubfsyqL5TqIy1uQhqFBnfSC9563P5D2BYxzVCkiv8BSVRoFfB/0ON4NVL4KH
         fhM9oD9PDLXhU9P9IA5GHI7g/pjla8F0iQ5LpTKJIzEgCTJ8efD9m+op6UZaz5OhpDnz
         lnXkN4x940BLnhyzuoFaXYFCP6fWtF2KL7pYMyNfdM/7LvJySuQvjMqQ8X+CrBXjcEvk
         mxvDYfTgamQkT3Lu1qDIW9IHFUgxuihVtW1bQUxP7AbJ0yLOvfVBXCkNKD3AwNbLh+7E
         z5Xg==
X-Gm-Message-State: APjAAAU30cdr+DUAtEo/PcjAaWDfRPGwqxrN59iFJXpBOpcRmuuWf/9X
        pIHz2Mum5OcO3c2h/GFlqV0LM3SQDGl8
X-Google-Smtp-Source: APXvYqzVNdKxwZfStBbO+rtuI9HYXlVwLC98SDq+6OeQ9VvuCkSzbDmRKC1z8pCIdCWEZPpWAdTpcs5Ie4hH
X-Received: by 2002:a63:755:: with SMTP id 82mr2156795pgh.154.1581666715949;
 Thu, 13 Feb 2020 23:51:55 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:33 -0800
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
Message-Id: <20200214075133.181299-7-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 6/6] perf/cgroup: Order events in RB tree by cgroup id
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

If one is monitoring 6 events on 20 cgroups the per-CPU RB tree will
hold 120 events. The scheduling in of the events currently iterates
over all events looking to see which events match the task's cgroup or
its cgroup hierarchy. If a task is in 1 cgroup with 6 events, then 114
events are considered unnecessarily.

This change orders events in the RB tree by cgroup id if it is present.
This means scheduling in may go directly to events associated with the
task's cgroup if one is present. The per-CPU iterator storage in
visit_groups_merge is sized sufficent for an iterator per cgroup depth,
where different iterators are needed for the task's cgroup and parent
cgroups. By considering the set of iterators when visiting, the lowest
group_index event may be selected and the insertion order group_index
property is maintained. This also allows event rotation to function
correctly, as although events are grouped into a cgroup, rotation always
selects the lowest group_index event to rotate (delete/insert into the
tree) and the min heap of iterators make it so that the group_index order
is maintained.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20190724223746.153620-3-irogers@google.com
---
 kernel/events/core.c | 97 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4eb4e67463bf..2eb17c2be5fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1577,6 +1577,30 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp != right->cgrp) {
+		if (!left->cgrp || !left->cgrp->css.cgroup) {
+			/*
+			 * Left has no cgroup but right does, no cgroups come
+			 * first.
+			 */
+			return true;
+		}
+		if (!right->cgrp || right->cgrp->css.cgroup) {
+			/*
+			 * Right has no cgroup but left does, no cgroups come
+			 * first.
+			 */
+			return false;
+		}
+		/* Two dissimilar cgroups, order by id. */
+		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
+			return true;
+
+		return false;
+	}
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1656,25 +1680,48 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the @cpu subtree.
+ * Get the leftmost event in the cpu/cgroup subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu,
+			struct cgroup *cgrp)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
+#ifdef CONFIG_CGROUP_PERF
+	u64 node_cgrp_id, cgrp_id = 0;
+
+	if (cgrp)
+		cgrp_id = cgrp->kn->id;
+#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
 
 		if (cpu < node_event->cpu) {
 			node = node->rb_left;
-		} else if (cpu > node_event->cpu) {
+			continue;
+		}
+		if (cpu > node_event->cpu) {
 			node = node->rb_right;
-		} else {
-			match = node_event;
+			continue;
+		}
+#ifdef CONFIG_CGROUP_PERF
+		node_cgrp_id = 0;
+		if (node_event->cgrp && node_event->cgrp->css.cgroup)
+			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
+
+		if (cgrp_id < node_cgrp_id) {
 			node = node->rb_left;
+			continue;
+		}
+		if (cgrp_id > node_cgrp_id) {
+			node = node->rb_right;
+			continue;
 		}
+#endif
+		match = node_event;
+		node = node->rb_left;
 	}
 
 	return match;
@@ -1687,12 +1734,26 @@ static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
 	struct perf_event *next;
+#ifdef CONFIG_CGROUP_PERF
+	u64 curr_cgrp_id = 0;
+	u64 next_cgrp_id = 0;
+#endif
 
 	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next && next->cpu == event->cpu)
-		return next;
+	if (next == NULL || next->cpu != event->cpu)
+		return NULL;
 
-	return NULL;
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp && event->cgrp->css.cgroup)
+		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
+
+	if (next->cgrp && next->cgrp->css.cgroup)
+		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
+
+	if (curr_cgrp_id != next_cgrp_id)
+		return NULL;
+#endif
+	return next;
 }
 
 /*
@@ -3469,6 +3530,9 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
+#ifdef CONFIG_CGROUP_PERF
+	struct cgroup_subsys_state *css = NULL;
+#endif
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
 	struct min_heap event_heap;
@@ -3484,6 +3548,11 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 		};
 
 		lockdep_assert_held(&cpuctx->ctx.lock);
+
+#ifdef CONFIG_CGROUP_PERF
+		if (cpuctx->cgrp)
+			css = &cpuctx->cgrp->css;
+#endif
 	} else {
 		event_heap = (struct min_heap){
 			.data = itrs,
@@ -3491,11 +3560,19 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 			.cap = ARRAY_SIZE(itrs),
 		};
 		/* Events not within a CPU context may be on any CPU. */
-		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1,
+									NULL));
 	}
 	evt = event_heap.data;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
+	__heap_add(&event_heap, perf_event_groups_first(groups, cpu, NULL));
+
+#ifdef CONFIG_CGROUP_PERF
+	for (; css; css = css->parent) {
+		__heap_add(&event_heap, perf_event_groups_first(groups, cpu,
+								css->cgroup));
+	}
+#endif
 
 	min_heapify_all(&event_heap, &perf_min_heap);
 
-- 
2.25.0.265.gbab2e86ba0-goog

