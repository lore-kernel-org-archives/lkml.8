Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FF922CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678970;
	bh=S77HsE32xw75YMJY8MhWSvUCv7M5y/Urn5gHgTo7HQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnJivtzSe0S2AUlRgnrDaUHKvS8FYio5t+tbviS0q3viBw1tVn73KecAj9kfTC5G8
	 6fKvO/5Jx1hKkI8XsaKhlZV7mOmh5YCsbE+vttX7GP0DqTmLGeF5YI90E93L0QIZ+3
	 ceeDbAWVQDpvQpHwOoH8C7qeNHBNXmm5qbKKXXFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgHQPmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbgHQPgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:36:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2DA22E02;
        Mon, 17 Aug 2020 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678583;
        bh=S77HsE32xw75YMJY8MhWSvUCv7M5y/Urn5gHgTo7HQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVIojPJOTebDzIBOS1FuX9YOhnNqAZESCRES/5r0REjt8RadArzmE/k7kLsonTYDR
         YO68/WfoHaE2eU5DmSZQzCpUstuTZ0fw++4SXnP26E5A5P2UH5n9tsdO4SF5EZ89+i
         du5/wBHZJ8A9GFCY8BJYq6CfGOomn/w/fgCOWrq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 354/464] ftrace: Fix ftrace_trace_task return value
Date:   Mon, 17 Aug 2020 17:15:07 +0200
Message-Id: <20200817143850.724302013@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit c58b6b0372de0d4cd0536d6585addd1b36b151ae ]

I was attempting to use pid filtering with function_graph, but it wasn't
allowing anything to make it through.  Turns out ftrace_trace_task
returns false if ftrace_ignore_pid is not-empty, which isn't correct
anymore.  We're now setting it to FTRACE_PID_IGNORE if we need to ignore
that pid, otherwise it's set to the pid (which is weird considering the
name) or to FTRACE_PID_TRACE.  Fix the check to check for !=
FTRACE_PID_IGNORE.  With this we can now use function_graph with pid
filtering.

Link: https://lkml.kernel.org/r/20200725005048.1790-1-josef@toxicpanda.com

Fixes: 717e3f5ebc82 ("ftrace: Make function trace pid filtering a bit more exact")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 3 ---
 kernel/trace/trace.h  | 7 ++++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6ebc..7d879fae3777f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -139,9 +139,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
-#define FTRACE_PID_IGNORE	-1
-#define FTRACE_PID_TRACE	-2
-
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f21607f871891..610d21355526d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1103,6 +1103,10 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 extern struct list_head ftrace_pids;
 
 #ifdef CONFIG_FUNCTION_TRACER
+
+#define FTRACE_PID_IGNORE	-1
+#define FTRACE_PID_TRACE	-2
+
 struct ftrace_func_command {
 	struct list_head	list;
 	char			*name;
@@ -1114,7 +1118,8 @@ struct ftrace_func_command {
 extern bool ftrace_filter_param __initdata;
 static inline int ftrace_trace_task(struct trace_array *tr)
 {
-	return !this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
+	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
+		FTRACE_PID_IGNORE;
 }
 extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
-- 
2.25.1



