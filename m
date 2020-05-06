Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865ACC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC42078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgEFSaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:30:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:8173 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbgEFSaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:30:01 -0400
IronPort-SDR: LqA7mPMj3NDnLfJI6xFfyNyKxJkNixKrsBPjtDQpOo7zCtFVQldqzG0i39NfTt5jbk35PctAok
 peqM4D9KTVlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:30:00 -0700
IronPort-SDR: 7xU5fC797kZq1Q8BLkfF4baR70umvgpfV9sBP+oV3Y5rcDCnJi8Rwwt1VAh4G9bGxVykaR1YeM
 QVgfNJ9Mmdsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="295428909"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2020 11:29:59 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id B95B358043A;
        Wed,  6 May 2020 11:29:57 -0700 (PDT)
Subject: [PATCH v2 10/11] perf record: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <bf4188e2-d0c8-03be-1864-bfebe8e0c32a@linux.intel.com>
Date:   Wed, 6 May 2020 21:29:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --ctl-fd[-ack] options to pass open file descriptors
numbers from command line.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 9 +++++++++
 tools/perf/util/record.h    | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2278a3efc747..9cf738ff1cae 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1704,6 +1704,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
+	perf_evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack);
+
 	if (opts->initial_delay) {
 		pr_info(PERF_EVLIST__DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1850,6 +1852,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	perf_evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
@@ -2331,6 +2334,8 @@ static struct record record = {
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2526,6 +2531,10 @@ static struct option __record_options[] = {
 	OPT_UINTEGER(0, "num-thread-synthesize",
 		     &record.opts.nr_threads_synthesize,
 		     "number of threads to run for event synthesis"),
+	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('e': enable events, 'd': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
+		    "Send control command completion ('a') to fd ack descriptor"),
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


