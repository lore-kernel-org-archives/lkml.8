Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C561BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ADD2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFAQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:05:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:34246 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:05:09 -0400
IronPort-SDR: 2FpO9/WGhY5hW3v9UNvEockSeDi3kq0yvjGMBTcHQDGZ95KXA/LMRooR37PdPfJcgEG7A10PQ4
 eiHERzHLBilw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:05:08 -0700
IronPort-SDR: /75Xv6ldvsQH3t0rXKxpWyUwIfEkS1LKFoISrqLBSZ7WmC4XXYoxDKdAsmQBAjWdktr+Th7EqR
 CuODwSLE2Rbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="293240866"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2020 09:05:08 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 18245580378;
        Mon,  1 Jun 2020 09:05:05 -0700 (PDT)
Subject: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
Date:   Mon, 1 Jun 2020 19:05:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
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
 tools/perf/builtin-record.c | 6 ++++++
 tools/perf/util/record.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0394e068dde8..fbe5069eb5d7 100644
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


