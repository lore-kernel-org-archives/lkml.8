Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB10C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A90420717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0Iuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:50:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:8312 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgC0Iuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:50:32 -0400
IronPort-SDR: jnQwyytBsfJTrd6pZT4l5AQD3kqYNatVjoCUv5AuOA9oyQ9r/npsTGbKYLWWHPVydXglAORg3Z
 Ht5XPw0t8plg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:50:31 -0700
IronPort-SDR: Uisx96pK35clw9YgyfO/QLv+sU+bBHhXMMvK/yJZU1YAmdsQemiqJFJkEYlZRePanbxN4mUZXH
 xcqIWN7gxt6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="448940722"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2020 01:50:31 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id E4F885803E3;
        Fri, 27 Mar 2020 01:50:28 -0700 (PDT)
Subject: [PATCH v1 7/8] perf record: implement resume and pause control
 commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b4daca98-812c-3da3-3a75-85dbc7ef32be@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:50:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of events coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f99751943b40..ae6f7d08e472 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1418,6 +1418,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct evlist *sb_evlist = NULL;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1620,6 +1621,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
+	perf_evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack);
+
 	if (opts->initial_delay) {
 		pr_info(PERF_EVLIST__PAUSED_MSG);
 		if (opts->initial_delay > 0) {
@@ -1710,8 +1713,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
-			if (err > 0 || (err < 0 && errno == EINTR))
+			if (err > 0 || (err < 0 && errno == EINTR)) {
 				err = 0;
+				if (perf_evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
+					switch (cmd) {
+					case CTL_CMD_RESUME:
+						pr_info(PERF_EVLIST__RESUMED_MSG);
+						break;
+					case CTL_CMD_PAUSE:
+						pr_info(PERF_EVLIST__PAUSED_MSG);
+						break;
+					case CTL_CMD_ACK:
+					case CTL_CMD_UNSUPPORTED:
+					default:
+						break;
+					}
+				}
+			}
 			waking++;
 
 			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
@@ -1751,6 +1769,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	perf_evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
-- 
2.24.1


