Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1186206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFCQCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:02:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:45951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCQCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:02:06 -0400
IronPort-SDR: aqmfUHccycENm2P2J1ttk2wcQEZdCH93rleAjnr9PoMKI9L51mJkmFzlim0/WMS49ljsMriat3
 pc5c0yx/gO6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 09:02:05 -0700
IronPort-SDR: 3nol7Ecq3Px0uVAhU0ZRpkQvYskpWNxVEQ7jERy4zqmcNG1PdVQgHcAQ4wIbg24LDKdZXBgpHY
 T8v/JRejY9SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="445159650"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 09:02:05 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id CA37058045A;
        Wed,  3 Jun 2020 09:02:02 -0700 (PDT)
Subject: [PATCH v7 13/13] perf record: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fd6e3937-f268-3561-5c05-86e443824f1a@linux.intel.com>
Date:   Wed, 3 Jun 2020 19:02:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
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
 tools/perf/Documentation/perf-record.txt | 40 ++++++++++++++++++++++++
 tools/perf/builtin-record.c              | 10 ++++++
 tools/perf/util/record.h                 |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index a84376605805..b0e9b7a1761e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -627,6 +627,46 @@ option. The -e option and this one can be mixed and matched.  Events
 can be grouped using the {} notation.
 endif::HAVE_LIBPFM[]
 
+--ctl-fd::
+--ctl-fd-ack::
+Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
+'disable': disable events). Measurements can be started with events disabled using
+--delay=-1 option. Optionally send control command completion ('ack\n') to fd-ack descriptor
+to synchronize with the controlling process. Example of bash shell script to enable and
+disable events during measurements:
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
index 0394e068dde8..8494ce964738 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1749,6 +1749,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
+	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		goto out_child;
+
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1895,6 +1898,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
@@ -2380,6 +2384,8 @@ static struct record record = {
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2581,6 +2587,10 @@ static struct option __record_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
+	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
+		   "Send control command completion ('ack') to fd ack descriptor"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index da138dcb4d34..4cb72a478af1 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -70,6 +70,8 @@ struct record_opts {
 	int	      mmap_flush;
 	unsigned int  comp_level;
 	unsigned int  nr_threads_synthesize;
+	int	      ctl_fd;
+	int	      ctl_fd_ack;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1


