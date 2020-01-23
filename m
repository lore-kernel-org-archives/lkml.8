Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2586921835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAWQIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:08:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:08:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BDE51FB;
        Thu, 23 Jan 2020 08:08:35 -0800 (PST)
Received: from e112479-lin.arm.com (unknown [10.37.9.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D503F68E;
        Thu, 23 Jan 2020 08:08:24 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, gengdongjiu@huawei.com,
        wxf.wang@hisilicon.com, liwei391@huawei.com,
        liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 5/7] perf tools: add perf_evlist__terminate() for terminate
Date:   Thu, 23 Jan 2020 16:07:32 +0000
Message-Id: <20200123160734.3775-6-james.clark@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123160734.3775-1-james.clark@arm.com>
References: <20200123160734.3775-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
be set and the event list will be disabled by perf_evlist__disable()
once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

Mark the evlist's state as terminated, preparing for the following fix.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/util/evlist.c    | 14 ++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 tools/perf/util/evsel.h     |  1 +
 4 files changed, 17 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..e7c917f9534d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1722,6 +1722,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
 			evlist__disable(rec->evlist);
+			evlist__terminate(rec->evlist);
 			disabled = true;
 		}
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b9c7e5271611..b04794cd8586 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -377,6 +377,20 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 	return true;
 }
 
+void evlist__terminate(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+			continue;
+		evsel__disable(pos);
+		pos->terminated = true;
+	}
+
+	evlist->enabled = false;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..9fbd0ce2a1c4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -206,6 +206,7 @@ void evlist__munmap(struct evlist *evlist);
 
 size_t evlist__mmap_size(unsigned long pages);
 
+void evlist__terminate(struct evlist *evlist);
 void evlist__disable(struct evlist *evlist);
 void evlist__enable(struct evlist *evlist);
 void perf_evlist__toggle_enable(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..8e8a2cb41de8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,7 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	bool			terminated;
 };
 
 struct perf_missing_features {
-- 
2.25.0

