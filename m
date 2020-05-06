Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5AB20747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgEFSSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:18:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:64570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgEFSSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:18:20 -0400
IronPort-SDR: rELez/RorY2Tw/xTGIUBrnLzY8eRR05djToOSkN7t/3DhHK+M7jgOR+gdAgfLY4fFNGDe59dJh
 DYeHdCwxZA6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:18:20 -0700
IronPort-SDR: Kd+IakREx/udPMxc4lSjTj0wbWUhve53xAvj0g7tGbAI8X7ZZZESZ4IKETpp3HzF7MiSrs8J9W
 ZOO5XAwfaahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="304875781"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2020 11:18:19 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id BB25C58048A;
        Wed,  6 May 2020 11:18:17 -0700 (PDT)
Subject: [PATCH v2 01/11] perf evlist: introduce control file descriptors
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
Message-ID: <c8d5c220-6b06-8b2b-bdf7-bc27804e00a9@linux.intel.com>
Date:   Wed, 6 May 2020 21:18:16 +0300
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


Define and initialize control file descriptors.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 3 +++
 tools/perf/util/evlist.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0a0b760d6948..2db4bedc4f81 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
+	evlist->ctl_fd = -1;
+	evlist->ctl_fd_ack = -1;
+	evlist->ctl_fd_pos = -1;
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b6f325dfb4d2..62f259d89b41 100644
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


