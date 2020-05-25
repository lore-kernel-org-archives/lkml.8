Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25212071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbgEYOXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:23:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:48355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403968AbgEYOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:23:46 -0400
IronPort-SDR: ruLdy5swEE/2d4RvLKZ8hmFmd9p8dtqPfFJAfuG6yZPbQgOiKVpGb5Zor5plDXFuwtajThqiJR
 NkxEd6s1RjIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:23:45 -0700
IronPort-SDR: OPyBsouvKa8AD2Txw7SuAE1s4MmAZmX2ONkzBVFRgS8qZMkRhd5EjjEHYqpwTwRUFvAt7oRADa
 HTEXIYr7n/dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="344900713"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2020 07:23:45 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 43DCC580101;
        Mon, 25 May 2020 07:23:43 -0700 (PDT)
Subject: [PATCH v4 10/10] perf record: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cd791bc8-2609-a136-a833-1dab6df68ff2@linux.intel.com>
Date:   Mon, 25 May 2020 17:23:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
from command line. Extend perf-record.txt file with --ctl-fd[-ack]
options description. Document possible usage model introduced by
--ctl-fd[-ack] options by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
 tools/perf/builtin-record.c              | 10 ++++++
 tools/perf/util/record.h                 |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c2c4ce7ccee2..5c012cfe68a4 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -614,6 +614,45 @@ appended unit character - B/K/M/G
 	The number of threads to run when synthesizing events for existing processes.
 	By default, the number of threads equals 1.
 
+--ctl-fd::
+--ctl-fd-ack::
+Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
+'disable': disable events. Optionally send control command completion ('ack') to fd-ack
+descriptor to synchronize with the controlling process. Example of bash shell script
+to enable and disable events during measurements:
+
+#!/bin/bash
+
+ctl_dir=/tmp/
+
+ctl_fifo=${ctl_dir}perf_ctl.fifo
+test -p ${ctl_fifo} && unlink ${ctl_fifo}
+mkfifo ${ctl_fifo}
+exec {ctl_fd}<>${ctl_fifo}
+
+ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+mkfifo ${ctl_ack_fifo}
+exec {ctl_fd_ack}<>${ctl_ack_fifo}
+
+perf record -D -1 -e cpu-cycles -a                        \
+            --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
+            -- sleep 30 &
+perf_pid=$!
+
+sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+
+exec {ctl_fd_ack}>&-
+unlink ${ctl_ack_fifo}
+
+exec {ctl_fd}>&-
+unlink ${ctl_fifo}
+
+wait -n ${perf_pid}
+exit $?
+
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ff3b7a77283..e057a2be42b7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1761,6 +1761,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
+	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		goto out_child;
+
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1907,6 +1910,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
@@ -2392,6 +2396,8 @@ static struct record record = {
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2587,6 +2593,10 @@ static struct option __record_options[] = {
 	OPT_UINTEGER(0, "num-thread-synthesize",
 		     &record.opts.nr_threads_synthesize,
 		     "number of threads to run for event synthesis"),
+	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
+		    "Send control command completion ('ack') to fd ack descriptor"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 96a73bbd8cd4..da18aeca3623 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -69,6 +69,8 @@ struct record_opts {
 	int	      mmap_flush;
 	unsigned int  comp_level;
 	unsigned int  nr_threads_synthesize;
+	int	      ctl_fd;
+	int	      ctl_fd_ack;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1

