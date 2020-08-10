Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BC720716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597048519;
	bh=1RRwYK3/OxCm9AMWwdkeCxClckrglMfUOB9WB7Z9NZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uLAVwE9ErTZr4+95Nyc+hCQqjV9ATwBU17ewM36ukLXi8DSt2PaHWhiIbVS55mUu
	 0KDPhHJABPc+eBhIJFaXnHDSXWevdY5F8bq3RXa62XQtt9H00dOPqkw4c3N/CwzpxV
	 7sYoHN7GY0M8hcfxkMR3QhscgKNHevMrItEqVLTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHJIfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:35:17 -0400
Received: from localhost.localdomain (unknown [180.22.250.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FF020709;
        Mon, 10 Aug 2020 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597048516;
        bh=1RRwYK3/OxCm9AMWwdkeCxClckrglMfUOB9WB7Z9NZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXLy1bsrsa4Xc1DEiWSBGX2nvm0+oQRVgXJzFv27eIbGyT19Sr+8HcbsH4f/LrSQ7
         bpjZSDGSG6IB9PlpTyqNkKjrKLUAKOO5Md/aodWFTfBsnSwCyhxiwFWDe9lEjQjQ+0
         m31AtvB6qI/Ns7zoR0ltCNlq9x0RYzrbSVa7GugU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/6] tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
Date:   Mon, 10 Aug 2020 17:35:11 +0900
Message-Id: <159704851101.175360.15119132351139842345.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159704847064.175360.3292152056631660862.stgit@devnote2>
References: <159704847064.175360.3292152056631660862.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bconf2ftrace.sh under tools/bootconfig/scripts which generates
a shell script to setup boot-time trace from bootconfig file for testing
the bootconfig.

bconf2ftrace.sh will take a bootconfig file (includes boot-time tracing)
and convert it into a shell-script which is almost same as the boot-time
tracer does.
If --apply option is given, it also tries to apply those command to the
running kernel, which requires the root privilege (or sudo).

For example, if you just want to confirm the shell commands, save
the output as below.

 # bconf2ftrace.sh ftrace.bconf > ftrace.sh

Or, you can apply it directly.

 # bconf2ftrace.sh --apply ftrace.bconf

Note that some boot-time tracing parameters under kernel.* are not able
to set via tracefs nor procfs (e.g. tp_printk, traceoff_on_warning.),
so those are ignored.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |  189 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |   56 +++++++++
 2 files changed, 245 insertions(+)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..fbe066d58eef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6506,6 +6506,7 @@ F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
 F:	lib/bootconfig.c
 F:	tools/bootconfig/*
+F:	tools/bootconfig/scripts/*
 
 EXYNOS DP DRIVER
 M:	Jingoo Han <jingoohan1@gmail.com>
diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
new file mode 100755
index 000000000000..a46e984fb2ff
--- /dev/null
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -0,0 +1,189 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+usage() {
+	echo "Ftrace boottime trace test tool"
+	echo "Usage: $0 [--apply] [--debug] BOOTCONFIG-FILE"
+	echo "    --apply: Test actual apply to tracefs (need sudo)"
+	exit 1
+}
+
+[ $# -eq 0 ] && usage
+
+BCONF=
+DEBUG=
+APPLY=
+while [ x"$1" != x ]; do
+	case "$1" in
+	"--debug")
+		DEBUG=$1;;
+	"--apply")
+		APPLY=$1;;
+	*)
+		[ ! -f $1 ] && usage
+		BCONF=$1;;
+	esac
+	shift 1
+done
+
+if [ x"$APPLY" != x ]; then
+	if [ `id -u` -ne 0 ]; then
+		echo "This must be run by root user. Try sudo." 1>&2
+		exec sudo $0 $DEBUG $APPLY $BCONF
+	fi
+fi
+
+run_cmd() { # command
+	echo "$*"
+	if [ x"$APPLY" != x ]; then # apply command
+		eval $*
+	fi
+}
+
+if [ x"$DEBUG" != x ]; then
+	set -x
+fi
+
+TRACEFS=`grep -m 1 -w tracefs /proc/mounts | cut -f 2 -d " "`
+if [ -z "$TRACEFS" ]; then
+	if ! grep -wq debugfs /proc/mounts; then
+		echo "Error: No tracefs/debugfs was mounted." 1>&2
+		exit 1
+	fi
+	TRACEFS=`grep -m 1 -w debugfs /proc/mounts | cut -f 2 -d " "`/tracing
+	if [ ! -d $TRACEFS ]; then
+		echo "Error: ftrace is not enabled on this kernel." 1>&2
+		exit 1
+	fi
+fi
+
+. `dirname $0`/xbc.sh
+
+######## main #########
+set -e
+
+xbc_init $BCONF
+
+set_value_of() { # key file
+	if xbc_has_key $1; then
+		val=`xbc_get_val $1 1`
+		run_cmd "echo '$val' >> $2"
+	fi
+}
+
+set_array_of() { # key file
+	if xbc_has_key $1; then
+		xbc_get_val $1 | while read line; do
+			run_cmd "echo '$line' >> $2"
+		done
+	fi
+}
+
+compose_synth() { # event_name branch
+	echo -n "$1 "
+	xbc_get_val $2 | while read field; do echo -n "$field; "; done
+}
+
+setup_event() { # prefix group event [instance]
+	branch=$1.$2.$3
+	if [ "$4" ]; then
+		eventdir="$TRACEFS/instances/$4/events/$2/$3"
+	else
+		eventdir="$TRACEFS/events/$2/$3"
+	fi
+	case $2 in
+	kprobes)
+		xbc_get_val ${branch}.probes | while read line; do
+			run_cmd "echo 'p:kprobes/$3 $line' >> $TRACEFS/kprobe_events"
+		done
+		;;
+	synthetic)
+		run_cmd "echo '`compose_synth $3 ${branch}.fields`' >> $TRACEFS/synthetic_events"
+		;;
+	esac
+
+	set_value_of ${branch}.filter ${eventdir}/filter
+	set_array_of ${branch}.actions ${eventdir}/trigger
+
+	if xbc_has_key ${branch}.enable; then
+		run_cmd "echo 1 > ${eventdir}/enable"
+	fi
+}
+
+setup_events() { # prefix("ftrace" or "ftrace.instance.INSTANCE") [instance]
+	prefix="${1}.event"
+	if xbc_has_branch ${1}.event; then
+		for grpev in `xbc_subkeys ${1}.event 2`; do
+			setup_event $prefix ${grpev%.*} ${grpev#*.} $2
+		done
+	fi
+}
+
+size2kb() { # size[KB|MB]
+	case $1 in
+	*KB)
+		echo ${1%KB};;
+	*MB)
+		expr ${1%MB} \* 1024;;
+	*)
+		expr $1 / 1024 ;;
+	esac
+}
+
+setup_instance() { # [instance]
+	if [ "$1" ]; then
+		instance="ftrace.instance.${1}"
+		instancedir=$TRACEFS/instances/$1
+	else
+		instance="ftrace"
+		instancedir=$TRACEFS
+	fi
+
+	set_array_of ${instance}.options ${instancedir}/trace_options
+	set_value_of ${instance}.trace_clock ${instancedir}/trace_clock
+	set_value_of ${instance}.cpumask ${instancedir}/tracing_cpumask
+	set_value_of ${instance}.tracer ${instancedir}/current_tracer
+	set_array_of ${instance}.ftrace.filters \
+		${instancedir}/set_ftrace_filter
+	set_array_of ${instance}.ftrace.notrace \
+		${instancedir}/set_ftrace_notrace
+
+	if xbc_has_key ${instance}.alloc_snapshot; then
+		run_cmd "echo 1 > ${instancedir}/snapshot"
+	fi
+
+	if xbc_has_key ${instance}.buffer_size; then
+		size=`xbc_get_val ${instance}.buffer_size 1`
+		size=`eval size2kb $size`
+		run_cmd "echo $size >> ${instancedir}/buffer_size_kb"
+	fi
+
+	setup_events ${instance} $1
+	set_array_of ${instance}.events ${instancedir}/set_event
+}
+
+# ftrace global configs (kernel.*)
+if xbc_has_key "kernel.dump_on_oops"; then
+	dump_mode=`xbc_get_val "kernel.dump_on_oops" 1`
+	[ "$dump_mode" ] && dump_mode=`eval echo $dump_mode` || dump_mode=1
+	run_cmd "echo \"$dump_mode\" > /proc/sys/kernel/ftrace_dump_on_oops"
+fi
+
+set_value_of kernel.fgraph_max_depth $TRACEFS/max_graph_depth
+set_array_of kernel.fgraph_filters $TRACEFS/set_graph_function
+set_array_of kernel.fgraph_notraces $TRACEFS/set_graph_notrace
+
+# Per-instance/per-event configs
+if ! xbc_has_branch "ftrace" ; then
+	exit 0
+fi
+
+setup_instance # root instance
+
+if xbc_has_branch "ftrace.instance"; then
+	for i in `xbc_subkeys "ftrace.instance" 1`; do
+		run_cmd "mkdir -p $TRACEFS/instances/$i"
+		setup_instance $i
+	done
+fi
+
diff --git a/tools/bootconfig/scripts/xbc.sh b/tools/bootconfig/scripts/xbc.sh
new file mode 100644
index 000000000000..b8c84e654556
--- /dev/null
+++ b/tools/bootconfig/scripts/xbc.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+# bootconfig utility functions
+
+XBC_TMPFILE=
+XBC_BASEDIR=`dirname $0`
+BOOTCONFIG=${BOOTCONFIG:=$XBC_BASEDIR/../bootconfig}
+if [ ! -x "$BOOTCONFIG" ]; then
+	BOOTCONFIG=`which bootconfig`
+	if [ -z "$BOOTCONFIG" ]; then
+		echo "Erorr: bootconfig command is not found" 1>&2
+		exit 1
+	fi
+fi
+
+xbc_cleanup() {
+	if [ "$XBC_TMPFILE" ]; then
+		rm -f "$XBC_TMPFILE"
+	fi
+}
+
+xbc_init() { # bootconfig-file
+	xbc_cleanup
+	XBC_TMPFILE=`mktemp bconf-XXXX`
+	trap xbc_cleanup EXIT TERM
+
+	$BOOTCONFIG -l $1 > $XBC_TMPFILE || exit 1
+}
+
+nr_args() { # args
+	echo $#
+}
+
+xbc_get_val() { # key [maxnum]
+	if [ "$2" ]; then
+		MAXOPT="-L $2"
+	fi
+	grep "^$1 =" $XBC_TMPFILE | cut -d= -f2- | \
+		sed -e 's/", /" /g' -e "s/',/' /g" | \
+		xargs $MAXOPT -n 1 echo
+}
+
+xbc_has_key() { # key
+	grep -q "^$1 =" $XBC_TMPFILE
+}
+
+xbc_has_branch() { # prefix-key
+	grep -q "^$1" $XBC_TMPFILE
+}
+
+xbc_subkeys() { # prefix-key depth
+	__keys=`echo $1 | sed "s/\./ /g"`
+	__s=`nr_args $__keys`
+	grep "^$1" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
+}

