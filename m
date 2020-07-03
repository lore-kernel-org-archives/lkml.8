Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC43C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220F1206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGCHnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:43:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:59496 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCHnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:43:06 -0400
IronPort-SDR: oRoxPi+IzPIA0RAEDk+7gbVgoK5vMz7B0GyJn4LnrtfXMjK90nipU5qARW9yzfA16+0nkE34sb
 oOwYo/0RhNcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="208625248"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="208625248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:43:06 -0700
IronPort-SDR: 8Qmih3QH/RpDAcak/HvY2nMw4NcXX94scNZEqKXz0App8odjnO0Qz/20L2eG56I/CuSsihRdj8
 expNcK/dwpQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="304511534"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2020 00:43:05 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 7E092580784;
        Fri,  3 Jul 2020 00:43:02 -0700 (PDT)
Subject: [PATCH v9 04/15] perf evlist: introduce control file descriptors
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Organization: Intel Corp.
Message-ID: <662b1c03-210a-1945-c02b-ac6c0445c7c7@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:43:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
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
 tools/perf/util/evlist.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7b1beffec6a1..ee545a122b52 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
+	evlist->ctl_fd.fd = -1;
+	evlist->ctl_fd.ack = -1;
+	evlist->ctl_fd.pos = -1;
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 38901c0d1599..2caf19fb87a8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,6 +74,11 @@ struct evlist {
 		pthread_t		th;
 		volatile int		done;
 	} thread;
+	struct {
+		int	fd;
+		int	ack;
+		int	pos;
+	} ctl_fd;
 };
 
 struct evsel_str_handler {
-- 
2.24.1


