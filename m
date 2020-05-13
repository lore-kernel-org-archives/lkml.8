Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011FAC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2522312B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgEMH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:59:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:38680 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgEMH7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:59:05 -0400
IronPort-SDR: wNfIRE1jMljPlmNHm2wdCfDLmpGodOO3PabYxqHlryGZcUVlSffvqb0yZfmUiLfiOCWZMS2S0O
 RY3f6C6ffLbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 00:59:05 -0700
IronPort-SDR: HwCit9R4NWCsaPtekFwG7g6NC6DYhgKo0K6dVebYNbg6R9CfTBVyBMch/MjbMV5RkKnSD7J0D0
 FLrLY/WRUcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="265783587"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2020 00:59:05 -0700
Received: from [10.249.229.18] (abudanko-mobl.ccr.corp.intel.com [10.249.229.18])
        by linux.intel.com (Postfix) with ESMTP id DA127580646;
        Wed, 13 May 2020 00:59:02 -0700 (PDT)
Subject: [PATCH v3 1/9] perf evlist: introduce control file descriptors
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
Message-ID: <3a1ed73d-6d11-eeb1-0897-476c5367369d@linux.intel.com>
Date:   Wed, 13 May 2020 10:59:00 +0300
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


Define and initialize control file descriptors.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 3 +++
 tools/perf/util/evlist.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2a9de6491700..aa61619fa304 100644
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

