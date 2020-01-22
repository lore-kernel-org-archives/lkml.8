Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4D24683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579663414;
	bh=ZrACMldnKCBblDjYLsYsmY8S44LP1hRUmCQUZbufUlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggf93HJXVSARBnPfDYeO3Em61/gyL8EaM1lM8mbpFMerqZp6oYPCcb72Rp5TGCqg+
	 GkfE9kHisTQpAIARA5ixSYHAIWx7PlJtuBgXlD0PILZPN7GV/GYnePeVUjH1hGh2nE
	 QIr3PxMUDsWckYMhonqNyWm0b5yTqZNlkG3zzRPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgAVDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgAVDXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:23:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BF02467A;
        Wed, 22 Jan 2020 03:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579663411;
        bh=ZrACMldnKCBblDjYLsYsmY8S44LP1hRUmCQUZbufUlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvwlKDCLtIet2RDdfq2WfLNeEOOvkOXdZvM7/anem9XujUvmLbC4DYxfOFSF1Og8v
         5Chsw68noDC7mvq+mgJRZCjdEPn6oLvD+Js8JokpOI550w/k4+RYMu7m6MaBCooTPE
         x3IXwAN/ytJs2y2r0SkxFCwoMlDBmLOGnUAfB5a8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tracing/uprobe: Fix to make trace_uprobe_filter alignment safe
Date:   Wed, 22 Jan 2020 12:23:25 +0900
Message-Id: <157966340499.5107.10978352478952144902.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122120843.493c7bd2718371af25787206@kernel.org>
References: <20200122120843.493c7bd2718371af25787206@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 99c9a923e97a ("tracing/uprobe: Fix double perf_event
linking on multiprobe uprobe") moved trace_uprobe_filter on
trace_probe_event. However, since it introduced a flexible
data structure with char array and type casting, the
alignment of trace_uprobe_filter can be broken.

This changes the type of the array to trace_uprobe_filter
data strucure to fix it.

Fixes: 99c9a923e97a ("tracing/uprobe: Fix double perf_event linking on multiprobe uprobe")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix build errors against pointer-field mistaking.
---
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.c  |    9 ++++++---
 kernel/trace/trace_probe.h  |   10 ++++++++--
 kernel/trace/trace_uprobe.c |   29 +++++++----------------------
 4 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3e5f9c7d939c..3f54dc2f6e1c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -290,7 +290,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 	INIT_HLIST_NODE(&tk->rp.kp.hlist);
 	INIT_LIST_HEAD(&tk->rp.kp.list);
 
-	ret = trace_probe_init(&tk->tp, event, group, 0);
+	ret = trace_probe_init(&tk->tp, event, group, false);
 	if (ret < 0)
 		goto error;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bba18cf44a30..9ae87be422f2 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -984,16 +984,19 @@ void trace_probe_cleanup(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, size_t event_data_size)
+		     const char *group, bool alloc_filter)
 {
 	struct trace_event_call *call;
+	size_t size = sizeof(struct trace_probe_event);
 	int ret = 0;
 
 	if (!event || !group)
 		return -EINVAL;
 
-	tp->event = kzalloc(sizeof(struct trace_probe_event) + event_data_size,
-			    GFP_KERNEL);
+	if (alloc_filter)
+		size += sizeof(struct trace_uprobe_filter);
+
+	tp->event = kzalloc(size, GFP_KERNEL);
 	if (!tp->event)
 		return -ENOMEM;
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 03e4e180058d..a0ff9e200ef6 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -223,6 +223,12 @@ struct probe_arg {
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
+struct trace_uprobe_filter {
+	rwlock_t		rwlock;
+	int			nr_systemwide;
+	struct list_head	perf_events;
+};
+
 /* Event call and class holder */
 struct trace_probe_event {
 	unsigned int			flags;	/* For TP_FLAG_* */
@@ -230,7 +236,7 @@ struct trace_probe_event {
 	struct trace_event_call		call;
 	struct list_head 		files;
 	struct list_head		probes;
-	char				data[0];
+	struct trace_uprobe_filter	filter[0];
 };
 
 struct trace_probe {
@@ -323,7 +329,7 @@ static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,
-		     const char *group, size_t event_data_size);
+		     const char *group, bool alloc_filter);
 void trace_probe_cleanup(struct trace_probe *tp);
 int trace_probe_append(struct trace_probe *tp, struct trace_probe *to);
 void trace_probe_unlink(struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f66e202fec13..2619bc5ed520 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -34,12 +34,6 @@ struct uprobe_trace_entry_head {
 #define DATAOF_TRACE_ENTRY(entry, is_return)		\
 	((void*)(entry) + SIZEOF_TRACE_ENTRY(is_return))
 
-struct trace_uprobe_filter {
-	rwlock_t		rwlock;
-	int			nr_systemwide;
-	struct list_head	perf_events;
-};
-
 static int trace_uprobe_create(int argc, const char **argv);
 static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_uprobe_release(struct dyn_event *ev);
@@ -263,14 +257,6 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 }
 NOKPROBE_SYMBOL(process_fetch_insn)
 
-static struct trace_uprobe_filter *
-trace_uprobe_get_filter(struct trace_uprobe *tu)
-{
-	struct trace_probe_event *event = tu->tp.event;
-
-	return (struct trace_uprobe_filter *)&event->data[0];
-}
-
 static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
 {
 	rwlock_init(&filter->rwlock);
@@ -358,8 +344,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	if (!tu)
 		return ERR_PTR(-ENOMEM);
 
-	ret = trace_probe_init(&tu->tp, event, group,
-				sizeof(struct trace_uprobe_filter));
+	ret = trace_probe_init(&tu->tp, event, group, true);
 	if (ret < 0)
 		goto error;
 
@@ -367,7 +352,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 	tu->consumer.handler = uprobe_dispatcher;
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
-	init_trace_uprobe_filter(trace_uprobe_get_filter(tu));
+	init_trace_uprobe_filter(tu->tp.event->filter);
 	return tu;
 
 error:
@@ -1076,7 +1061,7 @@ static void __probe_event_disable(struct trace_probe *tp)
 	struct trace_uprobe *tu;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
-	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
+	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
 		tu = container_of(pos, struct trace_uprobe, tp);
@@ -1117,7 +1102,7 @@ static int probe_event_enable(struct trace_event_call *call,
 	}
 
 	tu = container_of(tp, struct trace_uprobe, tp);
-	WARN_ON(!uprobe_filter_is_empty(trace_uprobe_get_filter(tu)));
+	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
 	if (enabled)
 		return 0;
@@ -1281,7 +1266,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 		return -ENODEV;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
-	if (trace_uprobe_filter_remove(trace_uprobe_get_filter(tu), event))
+	if (trace_uprobe_filter_remove(tu->tp.event->filter, event))
 		return 0;
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
@@ -1306,7 +1291,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return -ENODEV;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
-	if (trace_uprobe_filter_add(trace_uprobe_get_filter(tu), event))
+	if (trace_uprobe_filter_add(tu->tp.event->filter, event))
 		return 0;
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
@@ -1328,7 +1313,7 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 	int ret;
 
 	tu = container_of(uc, struct trace_uprobe, consumer);
-	filter = trace_uprobe_get_filter(tu);
+	filter = tu->tp.event->filter;
 
 	read_lock(&filter->rwlock);
 	ret = __uprobe_perf_filter(filter, mm);

