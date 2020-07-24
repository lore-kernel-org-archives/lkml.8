Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B22063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGXJSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:18:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728133AbgGXJSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:18:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 030DEC63573694F39600;
        Fri, 24 Jul 2020 17:18:03 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 17:17:53 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
Subject: [PATCH 3/4] perf auxtrace: Add new itrace options for ARMv8.3-SPE
Date:   Fri, 24 Jul 2020 17:16:06 +0800
Message-ID: <20200724091607.41903-4-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724091607.41903-1-liwei391@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add two options to synthesize events which are
described as below:

 'u': synthesize unaligned address access events
 'v': synthesize partial/empty predicated SVE events

This two options will be used by ARM SPE as their first consumer.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 8 ++++++++
 tools/perf/util/auxtrace.h          | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index e817179c5027..25bcf3622709 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -13,6 +13,8 @@
 		m	synthesize last level cache events
 		t	synthesize TLB events
 		a	synthesize remote access events
+		u	synthesize unaligned address access events
+		v	synthesize partial/empty predicated SVE events
 		g	synthesize a call chain (use with i or x)
 		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 25c639ac4ad4..2033eb3708ec 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1334,6 +1334,8 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->llc = true;
 	synth_opts->tlb = true;
 	synth_opts->remote_access = true;
+	synth_opts->alignment = true;
+	synth_opts->sve = true;
 
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
@@ -1507,6 +1509,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'a':
 			synth_opts->remote_access = true;
 			break;
+		case 'u':
+			synth_opts->alignment = true;
+			break;
+		case 'v':
+			synth_opts->sve = true;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 142ccf7d34df..972df7b06b0d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -116,6 +116,8 @@ struct itrace_synth_opts {
 	bool			llc;
 	bool			tlb;
 	bool			remote_access;
+	bool			alignment;
+	bool			sve;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
@@ -617,6 +619,8 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				m:	    		synthesize last level cache events\n" \
 "				t:	    		synthesize TLB events\n" \
 "				a:	    		synthesize remote access events\n" \
+"				u:	    		synthesize unaligned address access events\n" \
+"				v:	    		synthesize partial/empty predicated SVE events\n" \
 "				g[len]:     		synthesize a call chain (use with i or x)\n" \
 "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
-- 
2.17.1

