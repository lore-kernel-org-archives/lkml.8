Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B181C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473A820714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0Ipm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:45:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:4632 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Ipm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:45:42 -0400
IronPort-SDR: u+QRmxAWTWeK5KX9XlPNdTjCs2FFgpS0dSK2gvmjZa8F4eWzvyiDkx94UmtgvipaZpVVjCgkqD
 PQ240+fxgDWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:45:41 -0700
IronPort-SDR: a6NT259l81OjGF2jCfp9ZtBYHTbQC4MIdQN8e07YDaSjj1h+3PK/cNb57NyuFbXWu49SYjYIu8
 6Sh0z3NJmv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="293876602"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 01:45:41 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id 057B85803E3;
        Fri, 27 Mar 2020 01:45:38 -0700 (PDT)
Subject: [PATCH v1 1/8] perf evlist: introduce control file descriptors
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
Message-ID: <61540ab8-bb20-911b-6a2e-8d7b83829d9b@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:45:37 +0300
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


Define and initialize control file descriptors.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 3 +++
 tools/perf/util/evlist.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237b6558..1afd87cfa027 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -62,6 +62,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
+	evlist->ctl_fd = -1;
+	evlist->ctl_fd_ack = -1;
+	evlist->ctl_fd_pos = -1;
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..ac3dd895ef8f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,6 +74,9 @@ struct evlist {
 		pthread_t		th;
 		volatile int		done;
 	} thread;
+	int		ctl_fd;
+	int		ctl_fd_ack;
+	int		ctl_fd_pos;
 };
 
 struct evsel_str_handler {
-- 
2.24.1

