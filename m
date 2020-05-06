Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C117C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95442192A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgEFS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:29:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:60991 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgEFS3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:29:10 -0400
IronPort-SDR: rOul27SXoC24q3Y0tiTVz2nJb8pIEJCSbx3B5Uid7jT49VetsoF9LLlluQGVuNHBLA/ygyxyTN
 J/spM7dRj/7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:29:09 -0700
IronPort-SDR: EK5bpHvrmLWRKas6QxOzKpS2y34lxOHVL0qgTYpkLCnwfjykOx0JYEFVvi7XnZR3PwA+U8mK+/
 2YfSX8z0PAiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="339090730"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2020 11:29:09 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id 51FD758043A;
        Wed,  6 May 2020 11:29:07 -0700 (PDT)
Subject: [PATCH v2 09/11] perf record: implement control commands handling
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
Message-ID: <db9bb4c3-14d2-aa9f-c281-f81ca698913d@linux.intel.com>
Date:   Wed, 6 May 2020 21:29:05 +0300
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


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8a14e68b86ad..2278a3efc747 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1496,6 +1496,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1793,8 +1794,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
-			if (err > 0 || (err < 0 && errno == EINTR))
+			if (err > 0 || (err < 0 && errno == EINTR)) {
 				err = 0;
+				if (perf_evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
+					switch (cmd) {
+					case CTL_CMD_ENABLE:
+						pr_info(PERF_EVLIST__ENABLED_MSG);
+						break;
+					case CTL_CMD_DISABLE:
+						pr_info(PERF_EVLIST__DISABLED_MSG);
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
-- 
2.24.1


