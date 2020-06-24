Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C626C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652B820B80
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbgFXDjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbgFXDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:39:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D9E20857;
        Wed, 24 Jun 2020 03:39:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jnwG5-003u9Z-Tq; Tue, 23 Jun 2020 23:39:33 -0400
Message-ID: <20200624033933.804769956@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 23:39:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 3/4] tracing: Fix event trigger to accept redundant spaces
References: <20200624033858.651927570@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix the event trigger to accept redundant spaces in
the trigger input.

For example, these return -EINVAL

echo " traceon" > events/ftrace/print/trigger
echo "traceon  if common_pid == 0" > events/ftrace/print/trigger
echo "disable_event:kmem:kmalloc " > events/ftrace/print/trigger

But these are hard to find what is wrong.

To fix this issue, use skip_spaces() to remove spaces
in front of actual tokens, and set NULL if there is no
token.

Link: http://lkml.kernel.org/r/159262476352.185015.5261566783045364186.stgit@devnote2

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 85f2b08268c0 ("tracing: Add basic event trigger framework")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3a74736da363..f725802160c0 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -216,11 +216,17 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 
 int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
-	char *command, *next = buff;
+	char *command, *next;
 	struct event_command *p;
 	int ret = -EINVAL;
 
+	next = buff = skip_spaces(buff);
 	command = strsep(&next, ": \t");
+	if (next) {
+		next = skip_spaces(next);
+		if (!*next)
+			next = NULL;
+	}
 	command = (command[0] != '!') ? command : command + 1;
 
 	mutex_lock(&trigger_cmd_mutex);
@@ -630,8 +636,14 @@ event_trigger_callback(struct event_command *cmd_ops,
 	int ret;
 
 	/* separate the trigger from the filter (t:n [if filter]) */
-	if (param && isdigit(param[0]))
+	if (param && isdigit(param[0])) {
 		trigger = strsep(&param, " \t");
+		if (param) {
+			param = skip_spaces(param);
+			if (!*param)
+				param = NULL;
+		}
+	}
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
 
@@ -1368,6 +1380,11 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 	trigger = strsep(&param, " \t");
 	if (!trigger)
 		return -EINVAL;
+	if (param) {
+		param = skip_spaces(param);
+		if (!*param)
+			param = NULL;
+	}
 
 	system = strsep(&trigger, ":");
 	if (!trigger)
-- 
2.26.2


