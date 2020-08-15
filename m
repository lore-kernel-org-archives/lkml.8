Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341B7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA7E20658
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529513;
	bh=4BSR689DcTtffCAXQrwEP55IGcmgIVBSQnQXz56FHvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzXAH/G/rSAA1W5jhHRiVcchp1UnsYwg780hB5ntuNSQT+u8tC809F7SYrB6udOmV
	 2KX6uH8baXewnvhY1zk+odK6NRPNPkDoNNge1WoCG96nS7R/kuCMTyOcoYDJbcikyn
	 Dbep79UAd9qvwULeD7T4bmuFSILg5DDtU852t/E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgHOWLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B796C2312F;
        Sat, 15 Aug 2020 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500109;
        bh=4BSR689DcTtffCAXQrwEP55IGcmgIVBSQnQXz56FHvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M7ks6+eGToHZwjOlHYZQypu2mSpDIcjBtFPQg6OIkHikuWdxPaNeBCk8WhS4/j48
         1rpthFfNrWWyU29Tv4j0gSJQ91QXaDcRV8kvYra+xiVvou+2qj984nxPDXfX3m1JvH
         UFW7lpzBSCF/D41eELhYCTBaj80wkLKAf+0d8+xU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 5/6] tools/bootconfig: Add a script to generates bootconfig from ftrace
Date:   Sat, 15 Aug 2020 23:01:46 +0900
Message-Id: <159750010629.202708.8848502299805801653.stgit@devnote2>
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

Add a ftrace2bconf.sh under tools/bootconfig/scripts which generates
a bootconfig file from the current ftrace settings.

To read the ftrace settings, ftrace2bconf.sh requires the root
privilege (or sudo). The ftrace2bconf.sh will output the bootconfig
to stdout and error messages to stderr, so usually you'll run it as

 # ftrace2bconf.sh > ftrace.bconf

Note that some ftrace configurations are not supported. For example,
function-call/callgraph trace/notrace settings are not supported because
the wildcard has been expanded and lost in the ftrace anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh |  244 ++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
new file mode 100755
index 000000000000..6c0d4b61e0c2
--- /dev/null
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -0,0 +1,244 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+usage() {
+	echo "Dump boot-time tracing bootconfig from ftrace"
+	echo "Usage: $0 [--debug] [ > BOOTCONFIG-FILE]"
+	exit 1
+}
+
+DEBUG=
+while [ x"$1" != x ]; do
+	case "$1" in
+	"--debug")
+		DEBUG=$1;;
+	-*)
+		usage
+		;;
+	esac
+	shift 1
+done
+
+if [ x"$DEBUG" != x ]; then
+	set -x
+fi
+
+TRACEFS=`grep -m 1 -w tracefs /proc/mounts | cut -f 2 -d " "`
+if [ -z "$TRACEFS" ]; then
+	if ! grep -wq debugfs /proc/mounts; then
+		echo "Error: No tracefs/debugfs was mounted."
+		exit 1
+	fi
+	TRACEFS=`grep -m 1 -w debugfs /proc/mounts | cut -f 2 -d " "`/tracing
+	if [ ! -d $TRACEFS ]; then
+		echo "Error: ftrace is not enabled on this kernel." 1>&2
+		exit 1
+	fi
+fi
+
+######## main #########
+
+set -e
+
+emit_kv() { # key =|+= value
+	echo "$@"
+}
+
+global_options() {
+	val=`cat $TRACEFS/max_graph_depth`
+	[ $val != 0 ] && emit_kv kernel.fgraph_max_depth = $val
+	if grep -qv "^#" $TRACEFS/set_graph_function $TRACEFS/set_graph_notrace ; then
+		cat 1>&2 << EOF
+# WARN: kernel.fgraph_filters and kernel.fgraph_notrace are not supported, since the wild card expression was expanded and lost from memory.
+EOF
+	fi
+}
+
+kprobe_event_options() {
+	cat $TRACEFS/kprobe_events | while read p args; do
+		case $p in
+		r*)
+		cat 1>&2 << EOF
+# WARN: A return probe found but it is not supported by bootconfig. Skip it.
+EOF
+		continue;;
+		esac
+		p=${p#*:}
+		event=${p#*/}
+		group=${p%/*}
+		if [ $group != "kprobes" ]; then
+			cat 1>&2 << EOF
+# WARN: kprobes group name $group is changed to "kprobes" for bootconfig.
+EOF
+		fi
+		emit_kv $PREFIX.event.kprobes.$event.probes += $args
+	done
+}
+
+synth_event_options() {
+	cat $TRACEFS/synthetic_events | while read event fields; do
+		emit_kv $PREFIX.event.synthetic.$event.fields = `echo $fields | sed "s/;/,/g"`
+	done
+}
+
+# Variables resolver
+DEFINED_VARS=
+UNRESOLVED_EVENTS=
+
+defined_vars() { # event-dir
+	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9]*='
+}
+referred_vars() {
+	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9]*'
+}
+
+per_event_options() { # event-dir
+	evdir=$1
+	# Check the special event which has no filter and no trigger
+	[ ! -f $evdir/filter ] && return
+
+	if grep -q "^hist:" $evdir/trigger; then
+		# hist action can refer the undefined variables
+		__vars=`defined_vars $evdir`
+		for v in `referred_vars $evdir`; do
+			if echo $DEFINED_VARS $__vars | grep -vqw ${v#$}; then
+				# $v is not defined yet, defer it
+				UNRESOLVED_EVENTS="$UNRESOLVED_EVENTS $evdir"
+				return;
+			fi
+		done
+		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
+	fi
+	grep -v "^#" $evdir/trigger | while read action active; do
+		emit_kv $PREFIX.event.$group.$event.actions += \'$action\'
+	done
+
+	# enable is not checked; this is done by set_event in the instance.
+	val=`cat $evdir/filter`
+	if [ "$val" != "none" ]; then
+		emit_kv $PREFIX.event.$group.$event.filter = "$val"
+	fi
+}
+
+retry_unresolved() {
+	unresolved=$UNRESOLVED_EVENTS
+	UNRESOLVED_EVENTS=
+	for evdir in $unresolved; do
+		event=${evdir##*/}
+		group=${evdir%/*}; group=${group##*/}
+		per_event_options $evdir
+	done
+}
+
+event_options() {
+	# PREFIX and INSTANCE must be set
+	if [ $PREFIX = "ftrace" ]; then
+		# define the dynamic events
+		kprobe_event_options
+		synth_event_options
+	fi
+	for group in `ls $INSTANCE/events/` ; do
+		[ ! -d $INSTANCE/events/$group ] && continue
+		for event in `ls $INSTANCE/events/$group/` ;do
+			[ ! -d $INSTANCE/events/$group/$event ] && continue
+			per_event_options $INSTANCE/events/$group/$event
+		done
+	done
+	retry=0
+	while [ $retry -lt 3 ]; do
+		retry_unresolved
+		retry=$((retry + 1))
+	done
+	if [ "$UNRESOLVED_EVENTS" ]; then
+		cat 1>&2 << EOF
+! ERROR: hist triggers in $UNRESOLVED_EVENTS use some undefined variables.
+EOF
+	fi
+}
+
+is_default_trace_option() { # option
+grep -qw $1 << EOF
+print-parent
+nosym-offset
+nosym-addr
+noverbose
+noraw
+nohex
+nobin
+noblock
+trace_printk
+annotate
+nouserstacktrace
+nosym-userobj
+noprintk-msg-only
+context-info
+nolatency-format
+record-cmd
+norecord-tgid
+overwrite
+nodisable_on_free
+irq-info
+markers
+noevent-fork
+nopause-on-trace
+function-trace
+nofunction-fork
+nodisplay-graph
+nostacktrace
+notest_nop_accept
+notest_nop_refuse
+EOF
+}
+
+instance_options() { # [instance-name]
+	if [ $# -eq 0 ]; then
+		PREFIX="ftrace"
+		INSTANCE=$TRACEFS
+	else
+		PREFIX="ftrace.instance.$1"
+		INSTANCE=$TRACEFS/instances/$1
+	fi
+	val=
+	for i in `cat $INSTANCE/trace_options`; do
+		is_default_trace_option $i && continue
+		val="$val, $i"
+	done
+	[ "$val" ] && emit_kv $PREFIX.options = "${val#,}"
+	val="local"
+	for i in `cat $INSTANCE/trace_clock` ; do
+		[ "${i#*]}" ] && continue
+		i=${i%]}; val=${i#[}
+	done
+	[ $val != "local" ] && emit_kv $PREFIX.trace_clock = $val
+	val=`cat $INSTANCE/buffer_size_kb`
+	if echo $val | grep -vq "expanded" ; then
+		emit_kv $PREFIX.buffer_size = $val"KB"
+	fi
+	if grep -q "is allocated" $INSTANCE/snapshot ; then
+		emit_kv $PREFIX.alloc_snapshot
+	fi
+	val=`cat $INSTANCE/tracing_cpumask`
+	if [ `echo $val | sed -e s/f//g`x != x ]; then
+		emit_kv $PREFIX.cpumask = $val
+	fi
+
+	val=
+	for i in `cat $INSTANCE/set_event`; do
+		val="$val, $i"
+	done
+	[ "$val" ] && emit_kv $PREFIX.events = "${val#,}"
+	val=`cat $INSTANCE/current_tracer`
+	[ $val != nop ] && emit_kv $PREFIX.tracer = $val
+	if grep -qv "^#" $INSTANCE/set_ftrace_filter $INSTANCE/set_ftrace_notrace; then
+		cat 1>&2 << EOF
+# WARN: kernel.ftrace.filters and kernel.ftrace.notrace are not supported, since the wild card expression was expanded and lost from memory.
+EOF
+	fi
+	event_options
+}
+
+global_options
+instance_options
+for i in `ls $TRACEFS/instances` ; do
+	instance_options $i
+done

