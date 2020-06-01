Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39154C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E182077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFAM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgFAM2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9544D207FB;
        Mon,  1 Jun 2020 12:28:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjY0-00278s-Ky; Mon, 01 Jun 2020 08:28:08 -0400
Message-ID: <20200601122808.502981485@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 10/12] selftests/ftrace: Distinguish between hist and synthetic event checks
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

With synthetic events now a separate config item as a result of
'tracing: Move synthetic events to a separate file', tests that use
both need to explicitly check for hist trigger support rather than
relying on hist triggers to pull in synthetic events.

Add an additional hist trigger check to all the trigger tests that now
require it, otherwise they'll fail if synthetic events but not hist
triggers are enabled.

Link: http://lkml.kernel.org/r/af36c539006ef2768114b4ed38e6b054f7c7a3bd.1590693308.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/inter-event/trigger-field-variable-support.tc    | 5 +++++
 .../trigger/inter-event/trigger-inter-event-combined-hist.tc | 5 +++++
 .../trigger/inter-event/trigger-multi-actions-accept.tc      | 5 +++++
 .../trigger/inter-event/trigger-onmatch-action-hist.tc       | 5 +++++
 .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc | 5 +++++
 .../test.d/trigger/inter-event/trigger-onmax-action-hist.tc  | 5 +++++
 .../trigger/inter-event/trigger-snapshot-action-hist.tc      | 5 +++++
 .../test.d/trigger/inter-event/trigger-trace-action-hist.tc  | 5 +++++
 8 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 77be6e1f6e7b..e232059a8ab2 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test field variable support"
 
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index f3eb8aacec0e..07cfcb8157b6 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index d281f056f980..73e413c2ca26 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test multiple actions on hist trigger"
 echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 TRIGGER1=events/sched/sched_wakeup/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index a708f0e7858a..ebe0ad827f9f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index dfce6932d8be..2a2ef767249e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 0035995c2194..98d73bfb0296 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index f546c1b66a9b..01b01b9c4e07 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -12,6 +12,11 @@ if [ ! -f set_event ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 if [ ! -f snapshot ]; then
     echo "snapshot is not supported"
     exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index 8021d60aafec..c3baa486aeb4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
 
 echo "Test create synthetic event"
-- 
2.26.2


