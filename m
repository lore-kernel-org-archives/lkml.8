Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE27EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D82320B80
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592625316;
	bh=p498IFqQEqFxR3CQd9uyNIDEFRHE5ANadc1sTtnL6wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WC/qmIVJ/c60hsEMLWj1zqyngkA2SXtbxuTVleerNXjiNNMeBp1PkdrVvfgg1Rgi9
	 oTiaoeQZBMd7nHJQQF0qikjesLQrf0xGootLl1FXz6eqJkw2lZFqFSSMVLHTwfesMe
	 CZe9tdYpsbupiJU7IJW1oknGAKJWwmhFreCbwoAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFTDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTDzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:55:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D701F222B8;
        Sat, 20 Jun 2020 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592624767;
        bh=p498IFqQEqFxR3CQd9uyNIDEFRHE5ANadc1sTtnL6wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fggCmaHezkPbfYr1T9OgsskEZqeALL34/Y+whMd+h5L7RXIkxnIZYbI8jUdRrvy7T
         RhxDKI7mblY6YqcN5rc6sq27O4zcr3yIQp9n6um0TUIge1UY/ds8FDbE+xYzd5PXXE
         xd7x2+4XDBrKw23rxDlFvGsClOEqYT8w3H2inK7Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/2] tracing: Fix event trigger to accept redundant spaces
Date:   Sat, 20 Jun 2020 12:46:03 +0900
Message-Id: <159262476352.185015.5261566783045364186.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159262474473.185015.177609153974879988.stgit@devnote2>
References: <159262474473.185015.177609153974879988.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 85f2b08268c0 ("tracing: Add basic event trigger framework")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_trigger.c |   21 +++++++++++++++++++--
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

