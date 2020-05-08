Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3683C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993A620870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEHKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:53:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:39631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgEHKxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:53:22 -0400
IronPort-SDR: pZ4a/3DS3OJRyv61tBJoRRgfd7cAxnIoQ59p+kTOtP9YmQimsMWsk1cRo1ZTMoMylzLLofy4Bt
 soxMuyiUxjvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:53:22 -0700
IronPort-SDR: 8McVCCELIja3m7yiNksP4+DOph/HgK89isJSHPrBAM9Jg0r9nDfcx6gtr0KH5h80TRGvQI29CF
 vuUvTK4aOd8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="250365776"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2020 03:53:22 -0700
Received: from [10.249.224.104] (abudanko-mobl.ccr.corp.intel.com [10.249.224.104])
        by linux.intel.com (Postfix) with ESMTP id 3E0815805B4;
        Fri,  8 May 2020 03:53:20 -0700 (PDT)
Subject: [PATCH v3 8/9] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
Organization: Intel Corp.
Message-ID: <26304bd6-33b1-2104-51e3-f9f75c577058@linux.intel.com>
Date:   Fri, 8 May 2020 13:53:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
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
index 44fba34bc5aa..3ed352508b83 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1496,6 +1496,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1793,8 +1794,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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


