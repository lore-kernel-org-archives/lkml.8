Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED61EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DB220734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFAQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:04:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:42453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:04:26 -0400
IronPort-SDR: ECeWUsvYUkis8UlWAlgimbDwpGVqTi33tKnNHImI6YzIipc2sDWSAttx8E4MVll7c//9bObgcE
 11C97Jnyzahg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:04:26 -0700
IronPort-SDR: c9ZLe/ZhlXwCIhd9QfMVvTGzy9s+IfERzadwRcesC00Uy/mAtdl4r8rPpxJh25xuyyNZVZD6QI
 p8qtfsMb4xMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="286323897"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2020 09:04:25 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 1EBA9580646;
        Mon,  1 Jun 2020 09:04:23 -0700 (PDT)
Subject: [PATCH v5 12/13] perf record: implement control commands handling
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
Message-ID: <141431de-49c9-093b-b784-b67b81e31b56@linux.intel.com>
Date:   Mon, 1 Jun 2020 19:04:23 +0300
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


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d0b29a1070a0..0394e068dde8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1527,6 +1527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1830,6 +1831,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				alarm(rec->switch_output.time);
 		}
 
+		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
+			switch (cmd) {
+			case EVLIST_CTL_CMD_ENABLE:
+				pr_info(EVLIST_ENABLED_MSG);
+				break;
+			case EVLIST_CTL_CMD_DISABLE:
+				pr_info(EVLIST_DISABLED_MSG);
+				break;
+			case EVLIST_CTL_CMD_ACK:
+			case EVLIST_CTL_CMD_UNSUPPORTED:
+			default:
+				break;
+			}
+		}
+
 		if (hits == rec->samples) {
 			if (done || draining)
 				break;
-- 
2.24.1


