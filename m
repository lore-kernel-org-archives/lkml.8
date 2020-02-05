Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE8C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D3D218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgBEKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgBEKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:51:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313F021741;
        Wed,  5 Feb 2020 10:51:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izIH3-001NsT-3x; Wed, 05 Feb 2020 05:51:13 -0500
Message-Id: <20200205105113.004907028@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 05:49:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [for-next][PATCH 2/4] tracing: Annotate ftrace_graph_hash pointer with __rcu
References: <20200205104929.313040579@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

Fix following instances of sparse error
kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison

Use rcu_dereference_protected to access the __rcu annotated pointer.

Link: http://lkml.kernel.org/r/20200201072703.17330-1-frextrite@gmail.com

Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0e9612c30995..01d2ecd66161 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5591,7 +5591,7 @@ static const struct file_operations ftrace_notrace_fops = {
 
 static DEFINE_MUTEX(graph_lock);
 
-struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
 struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f5480a2aa334..18ceab59a5ba 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -964,22 +964,25 @@ extern void __trace_graph_return(struct trace_array *tr,
 				 unsigned long flags, int pc);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern struct ftrace_hash *ftrace_graph_hash;
+extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash *ftrace_graph_notrace_hash;
 
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
 	unsigned long addr = trace->func;
 	int ret = 0;
+	struct ftrace_hash *hash;
 
 	preempt_disable_notrace();
 
-	if (ftrace_hash_empty(ftrace_graph_hash)) {
+	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
+
+	if (ftrace_hash_empty(hash)) {
 		ret = 1;
 		goto out;
 	}
 
-	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+	if (ftrace_lookup_ip(hash, addr)) {
 
 		/*
 		 * This needs to be cleared on the return functions
-- 
2.24.1


