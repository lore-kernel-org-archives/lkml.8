Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF97C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F5220734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHJV2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:28:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:25839 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgHJV1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:54 -0400
IronPort-SDR: B75HTd3RW86g5ixneTPYCtJbHm12RauSi8/+owg0X2CuJXp+NDuls4XFSFp83bcsWPgWgAfZuW
 VbHlIbSwDMtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665977"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:54 -0700
IronPort-SDR: k340XRErTHkZApA5yL9J2anilrBltD8oa13tBPX+WDQuEeEWtWUnFDHQS26B7PmOzCHeEkYuBL
 CkiyqAugu5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196826"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:53 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: [PATCH V6 13/16] perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 10 Aug 2020 14:24:33 -0700
Message-Id: <20200810212436.8026-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Adds the infrastructure to sample the code address page size.

Introduce a new --code-page-size option for perf record.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/Documentation/perf-record.txt  | 3 +++
 tools/perf/builtin-record.c               | 2 ++
 tools/perf/util/event.h                   | 1 +
 tools/perf/util/evsel.c                   | 9 +++++++++
 tools/perf/util/perf_event_attr_fprintf.c | 2 +-
 tools/perf/util/record.h                  | 1 +
 tools/perf/util/synthetic-events.c        | 8 ++++++++
 7 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cbc3f7fdf48d..3994318ac5b4 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -292,6 +292,9 @@ OPTIONS
 --data-page-size::
 	Record the sampled data address data page size
 
+--code-page-size::
+	Record the sampled code address (ip) page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 27d8e563fe33..e44da98124ba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2447,6 +2447,8 @@ static struct option __record_options[] = {
 		    "Record the sample physical addresses"),
 	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
 		    "Record the sampled data address data page size"),
+	OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
+		    "Record the sampled code address (ip) page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9db85c515a8b..5bd1b31f7b7f 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -136,6 +136,7 @@ struct perf_sample {
 	u64 data_src;
 	u64 phys_addr;
 	u64 data_page_size;
+	u64 code_page_size;
 	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9e5e986b56bc..f96fdac83a02 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1078,6 +1078,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->sample_data_page_size)
 		evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
 
+	if (opts->sample_code_page_size)
+		evsel__set_sample_bit(evsel, CODE_PAGE_SIZE);
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -2254,6 +2257,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->code_page_size = 0;
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		data->code_page_size = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 68188c7c188a..a97a95f3b1be 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 924fcfbebd18..20141cb7a953 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -23,6 +23,7 @@ struct record_opts {
 	bool	      sample_address;
 	bool	      sample_phys_addr;
 	bool	      sample_data_page_size;
+	bool	      sample_code_page_size;
 	bool	      sample_weight;
 	bool	      sample_time;
 	bool	      sample_time_set;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0de5f8c0b867..88f8f42c6b76 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1409,6 +1409,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1593,6 +1596,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		*array = sample->code_page_size;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
-- 
2.17.1

