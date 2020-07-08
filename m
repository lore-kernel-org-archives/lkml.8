Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B4F20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGHHzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:55:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:12563 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGHHzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:55:20 -0400
IronPort-SDR: jZHns877+h40aypTnq8RNRSI05FxbRHrV1O9+wPXRYpNcFfa0MT+sfgvsV9YXZ5/VIqUgL1I1n
 kmFIBSp2cQwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145857998"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145857998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:55:20 -0700
IronPort-SDR: t7DUjuQf/NlmouXDZxrWiZV3bFDWJDVLa7CVOqmZOOTm2VHNnjFVBcPtlvy+vKHf0rJGA6f4l0
 F86i8wd33CNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="457420768"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 00:55:20 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id C9DFE5807FC;
        Wed,  8 Jul 2020 00:55:17 -0700 (PDT)
Subject: [PATCH v10 14/15] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e42423d5-23e2-aa12-6335-12997af357c4@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:55:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
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
index cd1892c4844b..632e61fe70bd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1527,6 +1527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1846,6 +1847,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				draining = true;
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
 		/*
 		 * When perf is starting the traced process, at the end events
 		 * die with the process and we wait for that. Thus no need to
-- 
2.24.1


