Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB084C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D039920767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406469AbgFYWVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403905AbgFYWVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:21:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FCB20767;
        Thu, 25 Jun 2020 22:21:51 +0000 (UTC)
Date:   Thu, 25 Jun 2020 18:21:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fixes for 5.8-rc2
Message-ID: <20200625182149.4af86715@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: Four small fixes

 - Fixed a ringbuffer bug for nested events having time go backwards
 - Fix a config dependency for boot time tracing to depend on synthetic
   events instead of histograms.
 - Fix trigger format parsing to handle multiple spaces
 - Fix bootconfig to handle failures in multiple events


Please pull the latest trace-v5.8-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.8-rc2

Tag SHA1: 505666efa90d05aaf57972795fcaac6305b40d2a
Head SHA1: 20dc3847cc2fc886ee4eb9112e6e2fad9419b0c7


Masami Hiramatsu (2):
      tracing/boot: Fix config dependency for synthedic event
      tracing: Fix event trigger to accept redundant spaces

Sascha Ortmann (1):
      tracing/boottime: Fix kprobe multiple events

Steven Rostedt (VMware) (1):
      ring-buffer: Zero out time extend if it is nested and not absolute

----
 kernel/trace/ring_buffer.c          |  2 +-
 kernel/trace/trace_boot.c           | 10 +++++++---
 kernel/trace/trace_events_trigger.c | 21 +++++++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e1ca48be50..00867ff82412 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2427,7 +2427,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	if (unlikely(info->add_timestamp)) {
 		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
 
-		event = rb_add_time_stamp(event, info->delta, abs);
+		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
 	}
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 9de29bb45a27..fa0fc08c6ef8 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -101,12 +101,16 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
 
 		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
-		if (ret)
+		if (ret) {
+			pr_err("Failed to generate probe: %s\n", buf);
 			break;
+		}
 
 		ret = kprobe_event_gen_cmd_end(&cmd);
-		if (ret)
+		if (ret) {
 			pr_err("Failed to add probe: %s\n", buf);
+			break;
+		}
 	}
 
 	return ret;
@@ -120,7 +124,7 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 }
 #endif
 
-#ifdef CONFIG_HIST_TRIGGERS
+#ifdef CONFIG_SYNTH_EVENTS
 static int __init
 trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 {
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
