Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69FEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA292071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbgEYOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:23:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:46655 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403968AbgEYOXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:23:09 -0400
IronPort-SDR: dOZ2r4ip5fYrWWUr07pD81MO+vKgFfhQ9pslAd9xjiXLrO2r1WItXpGBX85GRxSGPTNooyBpbN
 ZTWb+Pz6jVHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:23:07 -0700
IronPort-SDR: CiyCL70qIehdpzsAeNpC5I0Mrs8zvoafG8AiGtMU9s0QGajGtjgoibzJSJjODWTqnW74vbIUS4
 Gq+pi/Imh22A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="441746220"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 25 May 2020 07:23:08 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 25A7558056A;
        Mon, 25 May 2020 07:23:05 -0700 (PDT)
Subject: [PATCH v4 09/10] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e885da31-6f25-5061-e20b-6f257203a174@linux.intel.com>
Date:   Mon, 25 May 2020 17:23:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
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
index 8c3ec29e7e80..1ff3b7a77283 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1526,6 +1526,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1842,6 +1843,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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

