Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB371C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9663218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgBYNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:05:30 -0500
Received: from foss.arm.com ([217.140.110.172]:50534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgBYNFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:05:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B085E11B3;
        Tue, 25 Feb 2020 03:57:55 -0800 (PST)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.36.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFE943F6CF;
        Tue, 25 Feb 2020 03:57:52 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     adrian.hunter@intel.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v5 3/4] perf report: Add SPE options to --itrace argument
Date:   Tue, 25 Feb 2020 11:57:38 +0000
Message-Id: <20200225115739.18740-4-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225115739.18740-1-james.clark@arm.com>
References: <768a33f2-8694-270e-d3e8-3da4c65e96b3@intel.com>
 <20200225115739.18740-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss, remote_access). This patch
adds their help instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
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
 tools/perf/Documentation/itrace.txt | 5 ++++-
 tools/perf/util/auxtrace.h          | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7dad40c2..da3e5ccc039e 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,5 +1,5 @@
 		i	synthesize instructions events
-		b	synthesize branches events
+		b	synthesize branches events (branch misses on Arm)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
@@ -9,6 +9,9 @@
 			of aux-output (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
+		m	synthesize LLC miss events
+		t	synthesize TLB miss events
+		a	synthesize remote access events
 		g	synthesize a call chain (use with i or x)
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 80617b0d044d..52e148eea7f8 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -587,7 +587,7 @@ void auxtrace__free(struct perf_session *session);
 
 #define ITRACE_HELP \
 "				i:	    		synthesize instructions events\n"		\
-"				b:	    		synthesize branches events\n"		\
+"				b:	    		synthesize branches events (branch misses on Arm)\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
 "				x:	    		synthesize transactions events\n"		\
@@ -595,6 +595,9 @@ void auxtrace__free(struct perf_session *session);
 "				p:	    		synthesize power events\n"			\
 "				e:	    		synthesize error events\n"			\
 "				d:	    		create a debug log\n"			\
+"				m:	    		synthesize LLC miss events\n" \
+"				t:	    		synthesize TLB miss events\n" \
+"				a:	    		synthesize remote access events\n" \
 "				g[len]:     		synthesize a call chain (use with i or x)\n" \
 "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
-- 
2.17.1

