Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31637C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C72074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgFAUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:19:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:5984 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbgFAUTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:19:42 -0400
IronPort-SDR: 3HJUq6djVQskMHb9oQ39g36mr0y3UP5xvNyaoBsqXav1+11GT0g6c2lWHiot/7zlXLC9Mpb1v4
 XVcWgmUIWkEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 13:19:42 -0700
IronPort-SDR: a8YMb+FJ9tPSjLYmd5K79DoorFtWuCmkFWZLLaYdKvN0U7qScfq1UZDdD52EdMxsiFY7xB+NXW
 62Cyk6HEZO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="286391443"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2020 13:19:42 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 9145658010E;
        Mon,  1 Jun 2020 13:19:40 -0700 (PDT)
Subject: [PATCH v6 12/13] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f17814ad-a846-0172-b8f0-99f89d952b39@linux.intel.com>
Date:   Mon, 1 Jun 2020 23:19:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
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

