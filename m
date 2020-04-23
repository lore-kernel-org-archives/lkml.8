Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D67520784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgDWXbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgDWXbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:31:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D93F20736;
        Thu, 23 Apr 2020 23:31:11 +0000 (UTC)
Date:   Thu, 23 Apr 2020 19:31:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few fixes for v5.7
Message-ID: <20200423193109.26721533@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A few tracing fixes:

 - Two fixes that fix memory leaks detected by kmemleak
 - Removal of some dead code
 - A few local functions turned to static


Please pull the latest trace-v5.7-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7-rc2

Tag SHA1: 575108b02f8dfcff6e1b13bfa64a403b5a93615f
Head SHA1: d013496f99c5608e0f80afd67acb1ba93c4144ea


Jason Yan (1):
      tracing: Convert local functions in tracing_map.c to static

Nikolay Borisov (1):
      tracing: Remove DECLARE_TRACE_NOARGS

Steven Rostedt (VMware) (1):
      ftrace: Fix memory leak caused by not freeing entry in unregister_ftrace_direct()

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leaks in trace_events_hist.c

----
 include/linux/tracepoint.h       | 22 +---------------------
 kernel/trace/ftrace.c            |  1 +
 kernel/trace/trace_events_hist.c |  7 +++++++
 kernel/trace/tracing_map.c       |  6 +++---
 4 files changed, 12 insertions(+), 24 deletions(-)
---------------------------
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..a1fecf311621 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -156,8 +156,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * Note, the proto and args passed in includes "__data" as the first parameter.
  * The reason for this is to handle the "void" prototype. If a tracepoint
  * has a "void" prototype, then it is invalid to declare a function
- * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
- * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
+ * as "(void *, void)".
  */
 #define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
 	do {								\
@@ -373,25 +372,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 # define __tracepoint_string
 #endif
 
-/*
- * The need for the DECLARE_TRACE_NOARGS() is to handle the prototype
- * (void). "void" is a special value in a function prototype and can
- * not be combined with other arguments. Since the DECLARE_TRACE()
- * macro adds a data element at the beginning of the prototype,
- * we need a way to differentiate "(void *data, proto)" from
- * "(void *data, void)". The second prototype is invalid.
- *
- * DECLARE_TRACE_NOARGS() passes "void" as the tracepoint prototype
- * and "void *__data" as the callback prototype.
- *
- * DECLARE_TRACE() passes "proto" as the tracepoint protoype and
- * "void *__data, proto" as the callback prototype.
- */
-#define DECLARE_TRACE_NOARGS(name)					\
-	__DECLARE_TRACE(name, void, ,					\
-			cpu_online(raw_smp_processor_id()),		\
-			void *__data, __data)
-
 #define DECLARE_TRACE(name, proto, args)				\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 041694a1eb74..bd030b1b9514 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5165,6 +5165,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 			list_del_rcu(&direct->next);
 			synchronize_rcu_tasks();
 			kfree(direct);
+			kfree(entry);
 			ftrace_direct_func_count--;
 		}
 	}
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f6834a2bf41..fcab11cc6833 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3320,6 +3320,9 @@ static void __destroy_hist_field(struct hist_field *hist_field)
 	kfree(hist_field->name);
 	kfree(hist_field->type);
 
+	kfree(hist_field->system);
+	kfree(hist_field->event_name);
+
 	kfree(hist_field);
 }
 
@@ -4382,6 +4385,7 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;
@@ -5011,6 +5015,9 @@ static void destroy_field_vars(struct hist_trigger_data *hist_data)
 
 	for (i = 0; i < hist_data->n_field_vars; i++)
 		destroy_field_var(hist_data->field_vars[i]);
+
+	for (i = 0; i < hist_data->n_save_vars; i++)
+		destroy_field_var(hist_data->save_vars[i]);
 }
 
 static void save_field_var(struct hist_trigger_data *hist_data,
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9e31bfc818ff..74738c9856f1 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -283,7 +283,7 @@ int tracing_map_add_key_field(struct tracing_map *map,
 	return idx;
 }
 
-void tracing_map_array_clear(struct tracing_map_array *a)
+static void tracing_map_array_clear(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -294,7 +294,7 @@ void tracing_map_array_clear(struct tracing_map_array *a)
 		memset(a->pages[i], 0, PAGE_SIZE);
 }
 
-void tracing_map_array_free(struct tracing_map_array *a)
+static void tracing_map_array_free(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -316,7 +316,7 @@ void tracing_map_array_free(struct tracing_map_array *a)
 	kfree(a);
 }
 
-struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
+static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 						  unsigned int entry_size)
 {
 	struct tracing_map_array *a;
