Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87357C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F9623102
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678250;
	bh=pHYlclpSKjbiZNMgPJarljjkUereLNLSMpnfdT7p3Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlT5pwYRPv7AcE3FtliDe4e6z+XcnkaKHb0jtbzUQ/vbPgu/5MbzVm24FXejKadMi
	 RfbcwxW9JqBE5B3/NGAeJ0BR8G2qmZVGwAO0bKJMw7IqNyviFNv24F4bUlqpM6zzix
	 S4kWmZ11PkkoblW14AViwWVaKIyPwtNv2uv9cHd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgHQPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgHQP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE7923BDB;
        Mon, 17 Aug 2020 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678109;
        bh=pHYlclpSKjbiZNMgPJarljjkUereLNLSMpnfdT7p3Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUD/XY0/MBiralYET8YUBUsO3PY9+eWkSSvAOxNtEmMdmH0iLTQyzwjJkdRXuQCuI
         +ijFHEhFLMJXPmUa3zR76Yb3JhO9ovVItlGVWejxT63ScC4l4xJBXjv4oFaSNJuOhv
         pwrhgeoHSn88P+wSG9ePxwJWpIbRmI8lM5cwoJEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 191/464] tracing: Move pipe reference to trace array instead of current_tracer
Date:   Mon, 17 Aug 2020 17:12:24 +0200
Message-Id: <20200817143842.971050640@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit 7ef282e05132d56b6f6b71e3873f317664bea78b ]

If a process has the trace_pipe open on a trace_array, the current tracer
for that trace array should not be changed. This was original enforced by a
global lock, but when instances were introduced, it was moved to the
current_trace. But this structure is shared by all instances, and a
trace_pipe is for a single instance. There's no reason that a process that
has trace_pipe open on one instance should prevent another instance from
changing its current tracer. Move the reference counter to the trace_array
instead.

This is marked as "Fixes" but is more of a clean up than a true fix.
Backport if you want, but its not critical.

Fixes: cf6ab6d9143b1 ("tracing: Add ref count to tracer for when they are being read by pipe")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 12 ++++++------
 kernel/trace/trace.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5f..6fc6da55b94e2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5887,7 +5887,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	}
 
 	/* If trace pipe files are being read, we can't change the tracer */
-	if (tr->current_trace->ref) {
+	if (tr->trace_ref) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -6103,7 +6103,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	nonseekable_open(inode, filp);
 
-	tr->current_trace->ref++;
+	tr->trace_ref++;
 out:
 	mutex_unlock(&trace_types_lock);
 	return ret;
@@ -6122,7 +6122,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	mutex_lock(&trace_types_lock);
 
-	tr->current_trace->ref--;
+	tr->trace_ref--;
 
 	if (iter->trace->pipe_close)
 		iter->trace->pipe_close(iter);
@@ -7424,7 +7424,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = info;
 
-	tr->current_trace->ref++;
+	tr->trace_ref++;
 
 	mutex_unlock(&trace_types_lock);
 
@@ -7525,7 +7525,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&trace_types_lock);
 
-	iter->tr->current_trace->ref--;
+	iter->tr->trace_ref--;
 
 	__trace_array_put(iter->tr);
 
@@ -8733,7 +8733,7 @@ static int __remove_instance(struct trace_array *tr)
 	int i;
 
 	/* Reference counter for a newly created trace array = 1. */
-	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
+	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
 		return -EBUSY;
 
 	list_del(&tr->list);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 13db4000af3fe..f21607f871891 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -356,6 +356,7 @@ struct trace_array {
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	int			ref;
+	int			trace_ref;
 #ifdef CONFIG_FUNCTION_TRACER
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
@@ -547,7 +548,6 @@ struct tracer {
 	struct tracer		*next;
 	struct tracer_flags	*flags;
 	int			enabled;
-	int			ref;
 	bool			print_max;
 	bool			allow_instances;
 #ifdef CONFIG_TRACER_MAX_TRACE
-- 
2.25.1



