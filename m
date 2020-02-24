Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B91C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B902920675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519102;
	bh=UNH1fQY8oBfgoXc0eGQmv6BEBI09Z9KciFBwaFEhU10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4akl/g16hNUDuCIMOa+wSmlq095p+96pbMC6VyVeRBo7Z9NzU/cwDrp0Wq58Ni0p
	 lfgSylIBR80JKfEh1gnDPZaE+yn/Kncm4I1AZKoupRf79JUTUdu4kPfScEeuH3qR4C
	 Kb7qwopV2fq5GyDTQlRbrViRfJTHBrwh/cEJwbjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBXEiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37242 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBXEiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so3602405pjb.2;
        Sun, 23 Feb 2020 20:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PENbxmbb3Q7B9ptYvuFY3GrmRDhS2gUqlJlchHnDQY=;
        b=lyNFfE0CoEfDRjElurh9uiwK57fU8SDUIXZEZQ+ZDic5fiTgFpyhwk3SfvA3xXlsSU
         Chm6IyCjj6WkINTh03u7xZEdkJ2pd1eExAh5tAOThuARYXFaqQkqYYPBtIlA6OVKmzkE
         O+Va2U19UOQL20mYH+w//2c1kXjh5oonYZgVcDixRXsJay+V3QBekxghwwgfSVrqqqSe
         lfkPxF7rMFJZfAS+oJ9B40NNQkkkGz92KLcX7xSgykGBazoTZmeD4Xypp56ZZ9h73vSa
         mupjJXy56wXRnXAPKnjc8HhMCRCw7IQOyLBIAAgEJbnrByNrYecpURgUQ44uY9TDm6gd
         JzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6PENbxmbb3Q7B9ptYvuFY3GrmRDhS2gUqlJlchHnDQY=;
        b=PHZ705gkUi0PjTn/VrqeBQeAWouhxAyOu9YUwpPR5Pw6fs7EZpDmoN+g1WWnsb3Awn
         amosCVy7AO55izZnRhYSzx4Wuls2tj7orxNmfNfT74ikVKQOa2EXclIYZADeUcAk22W5
         xLIRxf+sWGDX5EcsjVFrJwLWljVS5QbNuYSa+sorGmFnQ2tBweDN9A2WCrPUWPr/tq4V
         VSQ1dOKhyI/qQkMiJiKwZZwatVOwJHYjzBDWhvDKybg7O63WXXa2iuMJbC4wPlSFRIbn
         Ox2u9Wn/cKNPh6yHNpOQG2meLF8cOGW94b5lJrwVtwVTWyy/5mlXUU9P+8gh+2tk3crR
         KH3A==
X-Gm-Message-State: APjAAAWtwVKHrmoVQsaI3fRQEagIbKoWsBGaSWBeWWyMqkIKdCtzimzI
        u0IM6Ns+roDYRNvrjfR9Rec=
X-Google-Smtp-Source: APXvYqzCylQePqpO5bxOBQU/SXqjWDCQHAP1apYAd4eONUbM8EpR9P3MxCEt6d4bVwRehgpTqGJZKQ==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr48651533plo.260.1582519094182;
        Sun, 23 Feb 2020 20:38:14 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:13 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH 04/10] perf tools: Basic support for CGROUP event
Date:   Mon, 24 Feb 2020 13:37:43 +0900
Message-Id: <20200224043749.69466-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement basic functionality to support cgroup tracking.  Each cgroup
can be identified by inode number which can be read from userspace
too.  The actual cgroup processing will come in the later patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
[fix perf test failure on sampling parsing]
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h     | 16 ++++++++++++++--
 tools/lib/perf/include/perf/event.h       |  7 +++++++
 tools/perf/builtin-diff.c                 |  1 +
 tools/perf/builtin-report.c               |  1 +
 tools/perf/tests/sample-parsing.c         |  6 +++++-
 tools/perf/util/event.c                   | 18 ++++++++++++++++++
 tools/perf/util/event.h                   |  6 ++++++
 tools/perf/util/evsel.c                   |  6 ++++++
 tools/perf/util/machine.c                 | 12 ++++++++++++
 tools/perf/util/machine.h                 |  3 +++
 tools/perf/util/perf_event_attr_fprintf.c |  2 ++
 tools/perf/util/session.c                 |  4 ++++
 tools/perf/util/synthetic-events.c        |  8 ++++++++
 tools/perf/util/tool.h                    |  1 +
 14 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 377d794d3105..3a81e9806cb1 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -377,7 +378,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1006,6 +1008,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 18106899cb4e..69b44d2cc0f5 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -105,6 +105,12 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_cgroup {
+	struct perf_event_header header;
+	__u64			 id;
+	char			 path[PATH_MAX];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -352,6 +358,7 @@ union perf_event {
 	struct perf_record_mmap2		mmap2;
 	struct perf_record_comm			comm;
 	struct perf_record_namespaces		namespaces;
+	struct perf_record_cgroup		cgroup;
 	struct perf_record_fork			fork;
 	struct perf_record_lost			lost;
 	struct perf_record_lost_samples		lost_samples;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8b6ae557d8b..83d4094bf152 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -455,6 +455,7 @@ static struct perf_diff pdiff = {
 		.fork	= perf_event__process_fork,
 		.lost	= perf_event__process_lost,
 		.namespaces = perf_event__process_namespaces,
+		.cgroup = perf_event__process_cgroup,
 		.ordered_events = true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9483b3f0cae3..ad650f6103e4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1094,6 +1094,7 @@ int cmd_report(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.lost		 = perf_event__process_lost,
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 2762e1155238..a8ff7d2df118 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -150,6 +150,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_CGROUP)
+		COMP(cgroup);
+
 	if (type & PERF_SAMPLE_AUX) {
 		COMP(aux_sample.size);
 		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
@@ -228,6 +231,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.regs	= regs,
 		},
 		.phys_addr	= 113,
+		.cgroup		= 114,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -331,7 +335,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_AUX << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CGROUP << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c5447ff516a2..824c038e5c33 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -54,6 +54,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
+	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -180,6 +181,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
 	return ret;
 }
 
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
+		       event->cgroup.id, event->cgroup.path);
+}
+
 int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -196,6 +203,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
 	return machine__process_namespaces_event(machine, event, sample);
 }
 
+int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	return machine__process_cgroup_event(machine, event, sample);
+}
+
 int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -417,6 +432,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_NAMESPACES:
 		ret += perf_event__fprintf_namespaces(event, fp);
 		break;
+	case PERF_RECORD_CGROUP:
+		ret += perf_event__fprintf_cgroup(event, fp);
+		break;
 	case PERF_RECORD_MMAP2:
 		ret += perf_event__fprintf_mmap2(event, fp);
 		break;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 85223159737c..0ad3ba22817d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -135,6 +135,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
@@ -321,6 +322,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine);
+int perf_event__process_cgroup(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 int perf_event__process_mmap(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -376,6 +381,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c8dc4450884c..fcafa1c5c931 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2252,6 +2252,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->cgroup = 0;
+	if (type & PERF_SAMPLE_CGROUP) {
+		data->cgroup = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..2c3223bec561 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -654,6 +654,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
+int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cgroup(event, stdout);
+
+	return 0;
+}
+
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
@@ -1880,6 +1890,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_mmap_event(machine, event, sample); break;
 	case PERF_RECORD_NAMESPACES:
 		ret = machine__process_namespaces_event(machine, event, sample); break;
+	case PERF_RECORD_CGROUP:
+		ret = machine__process_cgroup_event(machine, event, sample); break;
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index be0a930eca89..fa1be9ea00fa 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -128,6 +128,9 @@ int machine__process_switch_event(struct machine *machine,
 int machine__process_namespaces_event(struct machine *machine,
 				      union perf_event *event,
 				      struct perf_sample *sample);
+int machine__process_cgroup_event(struct machine *machine,
+				  union perf_event *event,
+				  struct perf_sample *sample);
 int machine__process_mmap_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 651203126c71..a37a89c747d8 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,6 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
+		bit_name(CGROUP),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -131,6 +132,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
+	PRINT_ATTRf(cgroup, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0d7d25b23e3..6b4c12d48c3f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -471,6 +471,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->comm = process_event_stub;
 	if (tool->namespaces == NULL)
 		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
 	if (tool->fork == NULL)
 		tool->fork = process_event_stub;
 	if (tool->exit == NULL)
@@ -1434,6 +1436,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
+	case PERF_RECORD_CGROUP:
+		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
 		return tool->fork(tool, event, sample, machine);
 	case PERF_RECORD_EXIT:
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c423298fe62d..cd336eb8886b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1228,6 +1228,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CGROUP)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1401,6 +1404,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_CGROUP) {
+		*array = sample->cgroup;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2abbf668b8de..472ef5eb4068 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -46,6 +46,7 @@ struct perf_tool {
 			mmap2,
 			comm,
 			namespaces,
+			cgroup,
 			fork,
 			exit,
 			lost,
-- 
2.25.0.265.gbab2e86ba0-goog

