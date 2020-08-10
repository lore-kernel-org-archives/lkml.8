Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C99BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E352D2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHJV1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:27:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:25819 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgHJV1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:46 -0400
IronPort-SDR: vtCGU6XiI5P0ueBy0tbzqGH8XLkV1W6pVqXNdrWDBP/kRwo9C8lIDb/v9SEM0G2OHsqvBzLnu5
 XRUifrt53XKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665947"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:45 -0700
IronPort-SDR: KmueluvHo94h2BPNvlnYw4HejcvxW4CSMcoAOWffLaEzUlIOxwEkLX/Nbc6coH48vihDeMu8ud
 cagTdsdWv4KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196777"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:45 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 05/16] perf record: Support new sample type for data page size
Date:   Mon, 10 Aug 2020 14:24:25 -0700
Message-Id: <20200810212436.8026-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.

Add new option --data-page-size to record sample data page size.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
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
index fa8a5fcd27ab..cbc3f7fdf48d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -289,6 +289,9 @@ OPTIONS
 --phys-data::
 	Record the sample physical addresses.
 
+--data-page-size::
+	Record the sampled data address data page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a37e7910e9e9..27d8e563fe33 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2445,6 +2445,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
 	OPT_BOOLEAN(0, "phys-data", &record.opts.sample_phys_addr,
 		    "Record the sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
+		    "Record the sampled data address data page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 6ae01c3c2ffa..69cdf14c23fa 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -135,6 +135,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 data_page_size;
 	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef802f6d40c1..9e5e986b56bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1075,6 +1075,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__set_sample_bit(evsel, CGROUP);
 	}
 
+	if (opts->sample_data_page_size)
+		evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -2245,6 +2248,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->data_page_size = 0;
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		data->data_page_size = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index b94fa07f5d32..68188c7c188a 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 39d1de4b2a36..924fcfbebd18 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -22,6 +22,7 @@ struct record_opts {
 	bool	      raw_samples;
 	bool	      sample_address;
 	bool	      sample_phys_addr;
+	bool	      sample_data_page_size;
 	bool	      sample_weight;
 	bool	      sample_time;
 	bool	      sample_time_set;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 89b390623b63..0de5f8c0b867 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1406,6 +1406,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_CGROUP)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1585,6 +1588,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		*array = sample->data_page_size;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
-- 
2.17.1

