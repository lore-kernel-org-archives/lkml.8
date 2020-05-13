Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D74C47077
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD40A20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgEMIE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:04:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:36955 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:04:29 -0400
IronPort-SDR: rzNmS4yBbc0OB0qugDU3l6drX7lfMDjXsdSHJXUHn4nYeqMNsrzUkEBfFFVjkzOWnUaVS8OzyU
 x+IrNt9Hl+bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 01:04:29 -0700
IronPort-SDR: hvfmiW9n/dexrwztqT/5I5mS1V6ijzXjhh41vo0KbnBPK7m+JfGf1zzjs6OwR1n5vzONKWeoT4
 GpTjzuNT0z7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="463844698"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2020 01:04:29 -0700
Received: from [10.249.229.18] (abudanko-mobl.ccr.corp.intel.com [10.249.229.18])
        by linux.intel.com (Postfix) with ESMTP id 1198F5804B6;
        Wed, 13 May 2020 01:04:26 -0700 (PDT)
Subject: [PATCH v3 8/9] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <25f98682-5ef2-4257-f302-93b29da707a9@linux.intel.com>
Date:   Wed, 13 May 2020 11:04:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
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
index 50dc2fe626e5..72f388623364 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1505,6 +1505,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1802,8 +1803,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
-			if (err > 0 || (err < 0 && errno == EINTR))
+			if (err > 0 || (err < 0 && errno == EINTR)) {
 				err = 0;
+				if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
+					switch (cmd) {
+					case EVLIST_CTL_CMD_ENABLE:
+						pr_info(EVLIST_ENABLED_MSG);
+						break;
+					case EVLIST_CTL_CMD_DISABLE:
+						pr_info(EVLIST_DISABLED_MSG);
+						break;
+					case EVLIST_CTL_CMD_ACK:
+					case EVLIST_CTL_CMD_UNSUPPORTED:
+					default:
+						break;
+					}
+				}
+			}
 			waking++;
 
 			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
-- 
2.24.1


