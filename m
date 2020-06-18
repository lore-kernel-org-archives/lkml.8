Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B32820786
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1VJq7A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgFRWQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbgFRWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:16:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565EC0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:16:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o84so7958354ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NkzF2d3LuHRNoA7x1eYCfuV9rs5DwwMiobCx9kU9o6g=;
        b=F1VJq7A0HLPO8Y6ON7OCtOTw8oE9MXRy0NffjofsQV+BSCQsOvzlMfGKBdUFLJ4BOT
         /vTMblG49jOFJnRAtPgY2bFPzyzS2VBr/63S7Cl1TUIOD35Eq1vI9fM8HOguF54e2qqU
         hVZyj9E1JdS66WVVtgIbeks4J+zkSjSsK18m7OovsYxo+1Gv6piQIFnk8iwrRgIfeWPq
         T4gON3yBQZfPZye20fDnLWdkhxXwPCkx0dSV3I37UII0j7L3Ldc58LmWkXfiPpw4QxGM
         PbVq73xSD8O8UpXysvC0sK+VpOQrCPGyEAPo3PnAIM0+xlXzAXfi+nhvZJv1g8RvNH5F
         p/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NkzF2d3LuHRNoA7x1eYCfuV9rs5DwwMiobCx9kU9o6g=;
        b=ET7r6wE90CpuD5DYk+fm1kNO4tvK+WS5ONchHToIW8ny9BvWzwNmQq3RJxRxuKbsY6
         YDQjf/xawnL9ulQbokWHNtSMdz4Cb3oPy6Q40exLuKfQJq+GgGSmg4jXKKHH+n8EDsO+
         r+3s1eiPLuIdiExkOgJbNo/IQMRMEtSLlwM2U2z3/4RnEW+x4Suu2+bKsQcI+DbeLXVJ
         uT/gSYccxLamXGjSqsiw6m+Yfdi6Yer4h/Gohky3keJ4v0Au9d1YJUjWkdrinRJb7s1F
         91vTQPOwUM8AM9sSOch8AmjiCMJnMV5EfTgfpfUWEq/2PV1+m38Q7wNllSXuWI+NRREU
         MjVg==
X-Gm-Message-State: AOAM531kBW/bTkqTrIGyZybZq9w/4kzX8sxUNT40yRWZRBpNbxDZtCVG
        L83tLyxnLHoanCZSZ1qL1YUwzOJqXJs=
X-Google-Smtp-Source: ABdhPJwvDL4nsjgDq9OaVr/kVBUTEXHYVlbcw+5IEmee+JXm6RbbszkdhbqE+0DBfCOQSeQe4i0hxur4eig=
X-Received: by 2002:a25:ac5e:: with SMTP id r30mr1491417ybd.68.1592518597448;
 Thu, 18 Jun 2020 15:16:37 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:15:41 -0700
In-Reply-To: <20200618221541.247643-1-korben@google.com>
Message-Id: <20200618221541.247643-3-korben@google.com>
Mime-Version: 1.0
References: <20200618221541.247643-1-korben@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH 2/2] tests for absolute timestamp
From:   Korben Rusek <korben@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Shier <pshier@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jbehmer@google.com,
        franksie@google.com, Korben Rusek <korben@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested:
kselftest output:

Found regular timestamps when force-abs-timestamp flag is off - [PASS]
Found absolute timestamps when force-abs-timestamp flag is on - [PASS]

Reviewed-by: Peter Shier <pshier@google.com>
Signed-off-by: Korben Rusek <korben@google.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timestamp/Makefile    |  25 +++
 tools/testing/selftests/timestamp/abs-test.sh | 156 ++++++++++++++
 .../selftests/timestamp/abs-timestamp.c       | 198 ++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 tools/testing/selftests/timestamp/Makefile
 create mode 100644 tools/testing/selftests/timestamp/abs-test.sh
 create mode 100644 tools/testing/selftests/timestamp/abs-timestamp.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..bda1cd0a608f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -58,6 +58,7 @@ TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
 endif
+TARGETS += timestamp
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
diff --git a/tools/testing/selftests/timestamp/Makefile b/tools/testing/selftests/timestamp/Makefile
new file mode 100644
index 000000000000..a8aa3b7278cf
--- /dev/null
+++ b/tools/testing/selftests/timestamp/Makefile
@@ -0,0 +1,25 @@
+TEST_PROGS := abs-test.sh
+
+.PHONY: all clean
+
+include ../lib.mk
+
+override define RUN_TESTS
+	@cd $(OUTPUT); ./abs-test.sh
+endef
+
+override define INSTALL_RULE
+	mkdir -p $(INSTALL_PATH)
+	$(CC) -o $(INSTALL_PATH)/abs-timestamp abs-timestamp.c -static
+	echo $(INSTALL_PATH)
+	cp abs-test.sh $(INSTALL_PATH)/abs-test.sh
+	chmod u+x $(INSTALL_PATH)/abs-test.sh
+endef
+
+override define CLEAN
+	rm -f abs-timestamp
+endef
+
+override define EMIT_TESTS
+	echo "./abs-test.sh"
+endef
diff --git a/tools/testing/selftests/timestamp/abs-test.sh b/tools/testing/selftests/timestamp/abs-test.sh
new file mode 100644
index 000000000000..067a09c2e77d
--- /dev/null
+++ b/tools/testing/selftests/timestamp/abs-test.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event tracing - enable/disable abs_timestamp option
+
+TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
+# Parameters
+DEBUGFS_DIR=`grep debugfs /proc/mounts | cut -f2 -d' ' | head -1`
+if [ -z "$DEBUGFS_DIR" ]; then
+	TRACING_DIR=`grep tracefs /proc/mounts | cut -f2 -d' ' | head -1`
+else
+	TRACING_DIR=$DEBUGFS_DIR/tracing
+fi
+
+clear_trace() {
+	echo > $TRACING_DIR/trace
+}
+
+disable_tracing() {
+	echo 0 > $TRACING_DIR/tracing_on
+}
+
+enable_tracing() {
+	echo 1 > $TRACING_DIR/tracing_on
+}
+
+reset_tracer() {
+	echo nop > $TRACING_DIR/current_tracer
+}
+
+do_reset() {
+	clear_trace
+	echo > $TRACING_DIR/set_event
+}
+
+exit_fail() {
+	exit 1
+}
+
+if [ -z `grep "force-abs-timestamp" $TRACING_DIR/trace_options` ]; then
+	echo "force-abs-timestamp is unsupported - [FAIL]"
+	exit 2
+fi
+
+# select all supported event types
+available=$( cat $TRACING_DIR/available_events | tr "\n" " " )
+events=($available)
+
+BUFSIZEK=1024
+
+emit_events() {
+	# give the system several opportunities to emit trace events
+	ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+}
+
+check_absolute_timestamps() {
+	pids=()
+	PAGE_SIZE=`tail -n 1 $TRACING_DIR/events/header_page | awk -F";" '{print $3}' | awk -F":" '{print $2}'`
+	CORRECT=0
+	ERROR=0
+	FAILURE=""
+	for cf in $TRACING_DIR/per_cpu/cpu*
+	do
+		cpuname="${cf##*/}"
+		touch "${TMPDIR}/${cpuname}"
+		cat "${cf}/trace_pipe_raw" > "${TMPDIR}/${cpuname}" &
+		pids+=($!)
+		disown
+
+		RET=`./abs-timestamp "${TMPDIR}/${cpuname}" "$PAGE_SIZE" $1`
+		if [ $RET != $1 ]; then
+			if [ $RET != "empty" ]; then
+				ERROR=1
+				FAILURE=$cpuname
+			fi
+		fi
+		if [ "$RET" == "$1" ]; then
+			CORRECT=1
+		fi
+	done
+
+	if [ $ERROR == "1" ]; then
+		echo $FAILURE
+	elif [ $CORRECT == "1" ]; then
+		rm $TMPDIR/$cpuname
+		echo "SUCCESS"
+	else
+		echo "EMPTY"
+	fi
+}
+
+clean() {
+	do_reset
+	rm -rf $TMPDIR
+}
+
+fail() {
+	clean
+	echo $1
+	exit_fail
+}
+
+disable_tracing
+
+reset_tracer
+
+# Set buffer size
+echo ${BUFSIZEK} > $TRACING_DIR/buffer_size_kb
+# Remove newest events when the buffer overflows instead of oldest.
+echo "overwrite" > $TRACING_DIR/trace_options
+# Turn off absolute timestamp option
+echo "noforce-abs-timestamp" > $TRACING_DIR/trace_options
+# Enable events
+echo > $TRACING_DIR/set_event
+for event in "${events[@]}"
+do
+	echo "${event}" >> $TRACING_DIR/set_event
+done
+
+clear_trace
+enable_tracing
+emit_events
+disable_tracing
+RET=`check_absolute_timestamps "noabs-timestamp"`
+if [ $RET == "EMPTY" ]; then
+	echo "No traces found when force-abs-timestamp flag is off - [UNRESOLVED]"
+elif [ "$RET" != "SUCCESS" ]; then
+	fail "found unexpected absolute timestamps with noforce-abs-timestamp - [FAIL]"
+else
+	echo "Found regular timestamps when force-abs-timestamp flag is off - [PASS]"
+fi
+
+rm -rf $TMPDIR/*
+
+# Turn on absolute timestamp option
+echo "force-abs-timestamp" > $TRACING_DIR/trace_options
+for event in "${events[@]}"
+do
+	echo "${event}" >> $TRACING_DIR/set_event
+done
+
+clear_trace
+enable_tracing
+emit_events
+disable_tracing
+
+RET=`check_absolute_timestamps "abs-timestamp"`
+if [ $RET == "EMPTY" ]; then
+	echo "No traces found when force-abs-timestamp flag is on - [UNRESOLVED]"
+elif [ $RET != "SUCCESS" ]; then
+  echo $RET
+	fail "did not find absolute timestamps - [FAIL]"
+else
+	echo "Found absolute timestamps when force-abs-timestamp flag is on - [PASS]"
+fi
+
+clean
diff --git a/tools/testing/selftests/timestamp/abs-timestamp.c b/tools/testing/selftests/timestamp/abs-timestamp.c
new file mode 100644
index 000000000000..134268464a5a
--- /dev/null
+++ b/tools/testing/selftests/timestamp/abs-timestamp.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ftrace absolute timestamp test helper.
+ *
+ * ./abs-timestamp [FILE] [PAGE_SIZE] [METHOD]
+ *
+ *  - FILE: path to a raw cpu trace
+ *  - PAGE_SIZE: expected page size for the trace
+ *  - METHOD: should be either abs-timestamp or noabs-timestamp
+ *
+ * This program reads the trace data in [FILE]. It checks whether
+ * every data element contains an absolute timestamp element
+ * before it. If this is the case for every event it prints
+ * "abs-timestamp" otherwise it prints "noabs-timestamp".
+ * If no data is found then "no-data" is printed.
+ *
+ * It returns 0 if METHOD matches what is found or if no
+ * data is found.
+ */
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define INT32_SIZE 4
+
+#define EVENT_TYPE_VARIABLE_SIZE 0
+#define EVENT_TYPE_LEN_MAX 28
+#define EVENT_TYPE_PADDING 29
+#define EVENT_TYPE_EXTEND 30
+#define EVENT_TYPE_ABSTIME 31
+
+#define EVENT_TYPE_MASK 0b11111
+
+#define MINIMUM_EVENT_SIZE 16
+
+#define PAGE_HEADER_SIZE 16
+
+#define RET_PASS	 0
+#define RET_FAIL	-2
+
+int page_size = 4080 + PAGE_HEADER_SIZE;
+
+int skip_bytes(int bytes, FILE *file)
+{
+	return fseek(file, bytes, SEEK_CUR) == 0;
+}
+
+unsigned long read_int64(FILE *file)
+{
+	unsigned long data;
+
+	if (!fread(&data, 8, 1, file))
+		return 0;
+	return data;
+}
+
+unsigned int read_int32(FILE *file)
+{
+	unsigned int data;
+
+	fread(&data, 4, 1, file);
+	return data;
+}
+
+char peek_byte(FILE *file)
+{
+	char byte;
+
+	fread(&byte, 1, 1, file);
+	skip_bytes(-1, file);
+	return byte;
+}
+
+int peek_event_type(FILE *file)
+{
+	if (feof(file))
+		return -1;
+	return peek_byte(file) & EVENT_TYPE_MASK;
+}
+
+// Extract the length of the page data from the page header. This length does
+// not include the size of the header (16 bytes).
+unsigned long page_data_length(FILE *file)
+{
+	unsigned long position = ftell(file);
+
+	if (position) {
+		int remaining =
+			(page_size - (position % page_size)) % page_size;
+
+		if (!skip_bytes(remaining, file))
+			return -1;
+	}
+	if (feof(file))
+		return 0;
+	if (!skip_bytes(8, file))
+		return 0;
+	return read_int64(file) & 0xFFFFF;
+}
+
+// Move to the next page if it exists. If successful the ending position of the
+// page is returned. It returns zero if there are no more pages.
+int move_next_page(FILE *file)
+{
+	unsigned long length = page_data_length(file);
+
+	if (length == 0)
+		return 0;
+	return ftell(file) + length;
+}
+
+void skip_event(int type, FILE *file)
+{
+	switch (type) {
+	// Time extend and absolute timestamp events are fixed length.
+	case EVENT_TYPE_EXTEND:
+	case EVENT_TYPE_ABSTIME:
+		skip_bytes(8, file);
+		return;
+	// Padding events and event type 0 are both variable length events where
+	// the next 32 bits indicate the length of the event. We also skip the
+	// next 4 bytes which indicate timestamp delta.
+	case EVENT_TYPE_PADDING:
+	case EVENT_TYPE_VARIABLE_SIZE: {
+		skip_bytes(4, file);
+		unsigned int length = read_int32(file);
+
+		skip_bytes(length - INT32_SIZE, file);
+		return;
+	}
+	// Other events (type 1...32) have a length of 4*type. We also skip the
+	// next 4 bytes which indicate timestamp delta.
+	default: {
+		skip_bytes(4, file);
+		unsigned int length = type << 2;
+
+		skip_bytes(length, file);
+		return;
+	}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	char absolute[] = "abs-timestamp";
+	FILE *file = fopen(argv[1], "r");
+	unsigned long page_end = page_data_length(file) + PAGE_HEADER_SIZE;
+	bool checking_abs = (argc > 3) && (strcmp(absolute, argv[3]) == 0);
+	bool satisfies_abs = true;
+	bool unaccounted_abs = false;
+	bool data_seen = false;
+
+	if (argc > 2) {
+		int base_page_size = strtol(argv[2], NULL, 10);
+
+		if (!base_page_size) {
+			printf("invalid format - header size missing");
+			return RET_FAIL;
+		}
+		page_size = base_page_size + PAGE_HEADER_SIZE;
+	}
+
+	while (!feof(file)) {
+		int type;
+
+		type = peek_event_type(file);
+		if (type == EVENT_TYPE_ABSTIME) {
+			unaccounted_abs = true;
+		} else if (type <= EVENT_TYPE_LEN_MAX) {
+			data_seen = true;
+			satisfies_abs = unaccounted_abs;
+			unaccounted_abs = false;
+		}
+		if (!satisfies_abs)
+			break;
+
+		skip_event(type, file);
+
+		if (ftell(file) + MINIMUM_EVENT_SIZE > page_end) {
+			page_end = move_next_page(file);
+			if (!page_end)
+				break;
+		}
+	}
+
+	if (!data_seen) {
+		printf("empty");
+		return RET_PASS;
+	}
+	if (satisfies_abs)
+		printf("abs-timestamp");
+	else
+		printf("noabs-timestamp");
+
+	if (satisfies_abs == checking_abs)
+		return RET_PASS;
+	return RET_FAIL;
+}
+
-- 
2.27.0.290.gba653c62da-goog

