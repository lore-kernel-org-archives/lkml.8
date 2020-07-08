Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C74F207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgGHPTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:19:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:64868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:19:15 -0400
IronPort-SDR: orgXKM0ubBzlIvKoPVEgMjIdsmQOm31znvIKqw1cFkM31s+iPvk6ZD1RuE91pdM10J/7Z64Wxi
 WS5VM/jnSnEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="165929591"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="165929591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 08:16:52 -0700
IronPort-SDR: pP+sLT+2z0Lg6Uaugp5k5B1KPH93QawhY9jKSVIHo+xMC+0AhsSKkDquRToajkg3d4LSy5Tiwc
 MwBz981nBA/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="283827393"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2020 08:16:49 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Date:   Wed,  8 Jul 2020 18:16:34 +0300
Message-Id: <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, perf requires one file descriptor per event. In large groups,
this may mean running into the limit on open file descriptors. However,
the sibling events in a group only need file descriptors for the initial
configuration stage, after which they may not be needed any more.

This adds an opt-in flag to the perf_event_open() syscall to retain
sibling events after their file descriptors are closed. In this case, the
actual events will be closed with the group leader.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
---
 include/linux/perf_event.h      |   7 ++
 include/uapi/linux/perf_event.h |   1 +
 kernel/events/core.c            | 149 +++++++++++++++++++++++---------
 3 files changed, 115 insertions(+), 42 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3b22db08b6fb..46666ce2c303 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -623,6 +623,11 @@ struct perf_event {
 	 * either sufficies for read.
 	 */
 	struct list_head		sibling_list;
+	/*
+	 * ALLOW_CLOSED siblings that were actually closed; when the group
+	 * leader goes, so should they.
+	 */
+	struct list_head		closed_list;
 	struct list_head		active_list;
 	/*
 	 * Node on the pinned or flexible tree located at the event context;
@@ -644,6 +649,8 @@ struct perf_event {
 	int				event_caps;
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
+	unsigned			allow_close	: 1,
+					closed		: 1;
 
 	struct perf_event		*group_leader;
 	struct pmu			*pmu;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 52ca2093831c..69823c0e3cbd 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1093,6 +1093,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
+#define PERF_FLAG_ALLOW_CLOSE		(1UL << 4) /* retain the event past fd close */
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c436d705fbd..e61be9cfce98 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -352,7 +352,8 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\
 		       PERF_FLAG_FD_OUTPUT  |\
 		       PERF_FLAG_PID_CGROUP |\
-		       PERF_FLAG_FD_CLOEXEC)
+		       PERF_FLAG_FD_CLOEXEC |\
+		       PERF_FLAG_ALLOW_CLOSE)
 
 /*
  * branch priv levels that need permission checks
@@ -2165,6 +2166,15 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
+		if (sibling->closed) {
+			list_move(&sibling->sibling_list, &event->closed_list);
+			event->nr_siblings--;
+			continue;
+		}
+
+		/* Proceed as if it was an ordinary sibling */
+		if (sibling->allow_close)
+			sibling->allow_close = 0;
 
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
@@ -2313,6 +2323,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	unsigned long flags = (unsigned long)info;
+	struct perf_event *sibling;
 
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
@@ -2332,6 +2343,10 @@ __perf_remove_from_context(struct perf_event *event,
 			cpuctx->task_ctx = NULL;
 		}
 	}
+
+	flags &= ~DETACH_GROUP;
+	list_for_each_entry(sibling, &event->closed_list, sibling_list)
+		__perf_remove_from_context(sibling, cpuctx, ctx, (void *)flags);
 }
 
 /*
@@ -4906,51 +4921,12 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 }
 
-/*
- * Kill an event dead; while event:refcount will preserve the event
- * object, it will not preserve its functionality. Once the last 'user'
- * gives up the object, we'll destroy the thing.
- */
-int perf_event_release_kernel(struct perf_event *event)
+static void perf_event_free_children(struct perf_event *event)
 {
-	struct perf_event_context *ctx = event->ctx;
 	struct perf_event *child, *tmp;
+	struct perf_event_context *ctx;
 	LIST_HEAD(free_list);
 
-	/*
-	 * If we got here through err_file: fput(event_file); we will not have
-	 * attached to a context yet.
-	 */
-	if (!ctx) {
-		WARN_ON_ONCE(event->attach_state &
-				(PERF_ATTACH_CONTEXT|PERF_ATTACH_GROUP));
-		goto no_ctx;
-	}
-
-	if (!is_kernel_event(event))
-		perf_remove_from_owner(event);
-
-	ctx = perf_event_ctx_lock(event);
-	WARN_ON_ONCE(ctx->parent_ctx);
-	perf_remove_from_context(event, DETACH_GROUP);
-
-	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Mark this event as STATE_DEAD, there is no external reference to it
-	 * anymore.
-	 *
-	 * Anybody acquiring event->child_mutex after the below loop _must_
-	 * also see this, most importantly inherit_event() which will avoid
-	 * placing more children on the list.
-	 *
-	 * Thus this guarantees that we will in fact observe and kill _ALL_
-	 * child events.
-	 */
-	event->state = PERF_EVENT_STATE_DEAD;
-	raw_spin_unlock_irq(&ctx->lock);
-
-	perf_event_ctx_unlock(event, ctx);
-
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
@@ -5016,6 +4992,82 @@ int perf_event_release_kernel(struct perf_event *event)
 		smp_mb(); /* pairs with wait_var_event() */
 		wake_up_var(var);
 	}
+}
+
+/*
+ * Kill an event dead; while event:refcount will preserve the event
+ * object, it will not preserve its functionality. Once the last 'user'
+ * gives up the object, we'll destroy the thing.
+ */
+int perf_event_release_kernel(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_event *sibling;
+
+	/*
+	 * If we got here through err_file: fput(event_file); we will not have
+	 * attached to a context yet.
+	 */
+	if (!ctx) {
+		WARN_ON_ONCE(event->attach_state &
+				(PERF_ATTACH_CONTEXT|PERF_ATTACH_GROUP));
+		goto no_ctx;
+	}
+
+	if (!is_kernel_event(event))
+		perf_remove_from_owner(event);
+
+	ctx = perf_event_ctx_lock(event);
+	WARN_ON_ONCE(ctx->parent_ctx);
+
+	if (event->allow_close && !event->closed) {
+		event->closed = 1;
+		perf_event_ctx_unlock(event, ctx);
+		return 0;
+	}
+
+	/*
+	 * The below will also move all closed siblings to the closed_list,
+	 * so that we can reap their children and remove them from the owner.
+	 */
+	perf_remove_from_context(event, DETACH_GROUP);
+
+	raw_spin_lock_irq(&ctx->lock);
+	/*
+	 * Mark this event as STATE_DEAD, there is no external reference to it
+	 * anymore.
+	 *
+	 * Anybody acquiring event->child_mutex after the below loop _must_
+	 * also see this, most importantly inherit_event() which will avoid
+	 * placing more children on the list. It will also skip over closed
+	 * siblings, as they are also going away together with their leader.
+	 *
+	 * Thus this guarantees that we will in fact observe and kill _ALL_
+	 * child events.
+	 */
+	event->state = PERF_EVENT_STATE_DEAD;
+	raw_spin_unlock_irq(&ctx->lock);
+
+	perf_event_ctx_unlock(event, ctx);
+
+	perf_event_free_children(event);
+
+	/*
+	 * The events on the closed_list are former closed siblings; they
+	 * don't have file descriptors, so this is their teardown.
+	 */
+	list_for_each_entry(sibling, &event->closed_list, sibling_list) {
+		if (!is_kernel_event(sibling))
+			perf_remove_from_owner(sibling);
+		perf_event_free_children(sibling);
+		/*
+		 * The below may be last, or it may be raced for it
+		 * by the perf_event_exit_event() path; we can do better
+		 * and ensure one way or the other, but it doesn't matter,
+		 * the other path is fully equipped to free events.
+		 */
+		put_event(sibling);
+	}
 
 no_ctx:
 	put_event(event); /* Must be the 'last' reference */
@@ -11118,6 +11170,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	INIT_LIST_HEAD(&event->event_entry);
 	INIT_LIST_HEAD(&event->sibling_list);
+	INIT_LIST_HEAD(&event->closed_list);
 	INIT_LIST_HEAD(&event->active_list);
 	init_event_group(event);
 	INIT_LIST_HEAD(&event->rb_entry);
@@ -11718,6 +11771,14 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (flags & PERF_FLAG_ALLOW_CLOSE) {
+		if (!group_leader || group_leader->group_leader != group_leader) {
+			err = -EINVAL;
+			goto err_task;
+		}
+		event->allow_close = 1;
+	}
+
 	/*
 	 * Special case software events and allow them to be part of
 	 * any hardware group.
@@ -12498,6 +12559,10 @@ inherit_event(struct perf_event *parent_event,
 	if (parent_event->parent)
 		parent_event = parent_event->parent;
 
+	/* If group leader is getting closed, ignore its closed siblings */
+	if (!group_leader && parent_event->closed)
+		return NULL;
+
 	child_event = perf_event_alloc(&parent_event->attr,
 					   parent_event->cpu,
 					   child,
-- 
2.27.0

