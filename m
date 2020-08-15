Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404BC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AFF20657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529515;
	bh=HHwsOMYRXp/2zFYaM9FuF5Q2zzb3dRLWaEJ0btmxQ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nF5rcGtEKFWOPsjlnV9ojv9vToi4R2SI/bz03DP/ISlBTWG3F1F3aUR9fS9GydX5W
	 0/f/xs/DuMWYWUXkh5Twifln+EOKjsHYoNq7+/rotOw5kP9GGNmoRgt3+/j+E3ApFM
	 pwNNpijhAadX/2sQM28sgtqD+Jc8xjcfecvu8XnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgHOWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB5823131;
        Sat, 15 Aug 2020 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500118;
        bh=HHwsOMYRXp/2zFYaM9FuF5Q2zzb3dRLWaEJ0btmxQ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MREOgeX655lWEbK4oorCWNvX2n9I4MRapmcmny7TsJ/+HRkSk0/Zs50CV458Kk/A
         iQfx1BUBmR4ITnlqKzUp5X5s1f53lm42HLwcszU4e/nlN/2U6VmzDkNUlSGZHfuvTj
         Tnkv3Zm9QuobhRRtdt7tyJVN9wtlZ3FTb2miNNZA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 6/6] tools/bootconfig: Add --init option for bconf2ftrace.sh
Date:   Sat, 15 Aug 2020 23:01:55 +0900
Message-Id: <159750011530.202708.5601308431073416960.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159750006069.202708.12439674123720173666.stgit@devnote2>
References: <159750006069.202708.12439674123720173666.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ftrace current setting may conflict with the new setting
from bootconfig, add the --init option to initialize ftrace before
setting for bconf2ftrace.sh.

E.g.
 $ bconf2ftrace.sh --init boottrace.bconf

This initialization method copied from selftests/ftrace.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |   12 +++
 tools/bootconfig/scripts/ftrace.sh       |  109 ++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 tools/bootconfig/scripts/ftrace.sh

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index a46e984fb2ff..595e164dc352 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -3,8 +3,9 @@
 
 usage() {
 	echo "Ftrace boottime trace test tool"
-	echo "Usage: $0 [--apply] [--debug] BOOTCONFIG-FILE"
+	echo "Usage: $0 [--apply|--init] [--debug] BOOTCONFIG-FILE"
 	echo "    --apply: Test actual apply to tracefs (need sudo)"
+	echo "    --init:  Initialize ftrace before applying (imply --apply)"
 	exit 1
 }
 
@@ -13,12 +14,16 @@ usage() {
 BCONF=
 DEBUG=
 APPLY=
+INIT=
 while [ x"$1" != x ]; do
 	case "$1" in
 	"--debug")
 		DEBUG=$1;;
 	"--apply")
 		APPLY=$1;;
+	"--init")
+		APPLY=$1
+		INIT=$1;;
 	*)
 		[ ! -f $1 ] && usage
 		BCONF=$1;;
@@ -57,6 +62,11 @@ if [ -z "$TRACEFS" ]; then
 	fi
 fi
 
+if [ x"$INIT" != x ]; then
+	. `dirname $0`/ftrace.sh
+	(cd $TRACEFS; initialize_ftrace)
+fi
+
 . `dirname $0`/xbc.sh
 
 ######## main #########
diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
new file mode 100644
index 000000000000..186eed923041
--- /dev/null
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+clear_trace() { # reset trace output
+    echo > trace
+}
+
+disable_tracing() { # stop trace recording
+    echo 0 > tracing_on
+}
+
+enable_tracing() { # start trace recording
+    echo 1 > tracing_on
+}
+
+reset_tracer() { # reset the current tracer
+    echo nop > current_tracer
+}
+
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
+    done
+}
+
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
+reset_events_filter() { # reset all current setting filters
+    grep -v ^none events/*/*/filter |
+    while read line; do
+	echo 0 > `echo $line | cut -f1 -d:`
+    done
+}
+
+reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+    if [ ! -f set_ftrace_filter ]; then
+      return 0
+    fi
+    echo > set_ftrace_filter
+    grep -v '^#' set_ftrace_filter | while read t; do
+	tr=`echo $t | cut -d: -f2`
+	if [ "$tr" = "" ]; then
+	    continue
+	fi
+	if ! grep -q "$t" set_ftrace_filter; then
+		continue;
+	fi
+	name=`echo $t | cut -d: -f1 | cut -d' ' -f1`
+	if [ $tr = "enable_event" -o $tr = "disable_event" ]; then
+	    tr=`echo $t | cut -d: -f2-4`
+	    limit=`echo $t | cut -d: -f5`
+	else
+	    tr=`echo $t | cut -d: -f2`
+	    limit=`echo $t | cut -d: -f3`
+	fi
+	if [ "$limit" != "unlimited" ]; then
+	    tr="$tr:$limit"
+	fi
+	echo "!$name:$tr" > set_ftrace_filter
+    done
+}
+
+disable_events() {
+    echo 0 > events/enable
+}
+
+clear_synthetic_events() { # reset all current synthetic events
+    grep -v ^# synthetic_events |
+    while read line; do
+        echo "!$line" >> synthetic_events
+    done
+}
+
+initialize_ftrace() { # Reset ftrace to initial-state
+# As the initial state, ftrace will be set to nop tracer,
+# no events, no triggers, no filters, no function filters,
+# no probes, and tracing on.
+    disable_tracing
+    reset_tracer
+    reset_trigger
+    reset_events_filter
+    reset_ftrace_filter
+    disable_events
+    [ -f set_event_pid ] && echo > set_event_pid
+    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
+    [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
+    [ -f set_graph_function ] && echo | tee set_graph_*
+    [ -f stack_trace_filter ] && echo > stack_trace_filter
+    [ -f kprobe_events ] && echo > kprobe_events
+    [ -f uprobe_events ] && echo > uprobe_events
+    [ -f synthetic_events ] && echo > synthetic_events
+    [ -f snapshot ] && echo 0 > snapshot
+    clear_trace
+    enable_tracing
+}

