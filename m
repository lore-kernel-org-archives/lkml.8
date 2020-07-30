Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C68220809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596145241;
	bh=W3lPdRmN/3q0Ol3tNR7FbE+KtH5nw94GbrQiFYMSdHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b4SOiRquzrfQDMH8sva4yIwJyje6WrszlqbT1c4jeGFTIlL8AFxtvvHpHuFFhhcRS
	 2beHGtwcqCgQmiizPHOmqIu5OFE3009vHGdS1v6KWwL3GxxEILlFYT9dghzrcdRZJB
	 xwA5+iK6V/ppMYp9UlZ1NDw+FmjJII00SfcxC2eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgG3Vkk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:40:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728849AbgG3Vkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-N1gGm6DNMDST_RAVGi5cbA-1; Thu, 30 Jul 2020 17:40:32 -0400
X-MC-Unique: N1gGm6DNMDST_RAVGi5cbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7108BB873;
        Thu, 30 Jul 2020 21:40:29 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BC987B03;
        Thu, 30 Jul 2020 21:40:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH 2/6] perf tools: Store clock references for -k/--clockid option
Date:   Thu, 30 Jul 2020 23:39:46 +0200
Message-Id: <20200730213950.1503773-3-jolsa@kernel.org>
In-Reply-To: <20200730213950.1503773-1-jolsa@kernel.org>
References: <20200730213950.1503773-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new CLOCK_DATA feature that stores reference times
when -k/--clockid option is specified.

It contains clock id and its reference time together with
wall clock time taken at the 'same time', both values are
in nanoseconds.

The format of data is as below:

  struct {
       u32 version;  /* version = 1 */
       u32 clockid;
       u64 clockid_time_ns;
       u64 wall_clock_ns;
  };

This clock reference times will be used in following changes
to display wall clock for perf events.

It's available only for recording with clockid specified,
because it's the only case where we can get reference time
to wallclock time. It's can't do that with perf clock yet.

Original-patch-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../Documentation/perf.data-file-format.txt   |  13 ++
 tools/perf/builtin-record.c                   |  41 +++++++
 tools/perf/util/env.h                         |  12 ++
 tools/perf/util/header.c                      | 112 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 5 files changed, 179 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b6472e463284..c484e81987c7 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -389,6 +389,19 @@ struct {
 Example:
  cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
 
+	HEADER_CLOCK_DATA = 29,
+
+	Contains clock id and its reference time together with wall clock
+	time taken at the 'same time', both values are in nanoseconds.
+	The format of data is as below.
+
+struct {
+	u32 version;  /* version = 1 */
+	u32 clockid;
+	u64 clockid_time_ns;
+	u64 wall_clock_ns;
+};
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 468c669519a6..f8280e721e1a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -70,6 +70,7 @@
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 #include <linux/bitmap.h>
+#include <sys/time.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -1203,6 +1204,9 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	if (!rec->opts.use_clockid)
+		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
+
 	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
@@ -1551,6 +1555,40 @@ static int record__setup_sb_evlist(struct record *rec)
 	return 0;
 }
 
+static int record__init_clock(struct record *rec)
+{
+	struct perf_session *session = rec->session;
+	struct timespec ref_clockid;
+	struct timeval ref_tod;
+	u64 ref;
+
+	if (!rec->opts.use_clockid)
+		return 0;
+
+	session->header.env.clock.clockid = rec->opts.clockid;
+
+	if (gettimeofday(&ref_tod, NULL) != 0) {
+		pr_err("gettimeofday failed, cannot set reference time.\n");
+		return -1;
+	}
+
+	if (clock_gettime(rec->opts.clockid, &ref_clockid)) {
+		pr_err("clock_gettime failed, cannot set reference time.\n");
+		return -1;
+	}
+
+	ref = (u64) ref_tod.tv_sec * NSEC_PER_SEC +
+	      (u64) ref_tod.tv_usec * NSEC_PER_USEC;
+
+	session->header.env.clock.clockid_ns = ref;
+
+	ref = (u64) ref_clockid.tv_sec * NSEC_PER_SEC +
+	      (u64) ref_clockid.tv_nsec;
+
+	session->header.env.clock.tod_ns = ref;
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1630,6 +1668,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return -1;
 	}
 
+	if (record__init_clock(rec))
+		return -1;
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 1ab2682d5d2b..4098a63d5e64 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -100,6 +100,18 @@ struct perf_env {
 	/* For fast cpu to numa node lookup via perf_env__numa_node */
 	int			*numa_map;
 	int			 nr_numa_map;
+
+	/* For real clock time refference. */
+	struct {
+		u64	tod_ns;
+		u64	clockid_ns;
+		int	clockid;
+		/*
+		 * enabled is valid for report mode, and is true if above
+		 * values are set, it's set in process_clock_data
+		 */
+		bool	enabled;
+	} clock;
 };
 
 enum perf_compress_type {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7a67d017d72c..ffe10d8fd5fa 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -895,6 +895,40 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_clock_data(struct feat_fd *ff,
+			    struct evlist *evlist __maybe_unused)
+{
+	u64 *data64;
+	u32 data32;
+	int ret;
+
+	/* version */
+	data32 = 1;
+
+	ret = do_write(ff, &data32, sizeof(data32));
+	if (ret < 0)
+		return ret;
+
+	/* clockid */
+	data32 = ff->ph->env.clock.clockid;
+
+	ret = do_write(ff, &data32, sizeof(data32));
+	if (ret < 0)
+		return ret;
+
+	/* TOD ref time */
+	data64 = &ff->ph->env.clock.clockid_ns;
+
+	ret = do_write(ff, data64, sizeof(*data64));
+	if (ret < 0)
+		return ret;
+
+	/* clockid ref time */
+	data64 = &ff->ph->env.clock.tod_ns;
+
+	return do_write(ff, data64, sizeof(*data64));
+}
+
 static int write_dir_format(struct feat_fd *ff,
 			    struct evlist *evlist __maybe_unused)
 {
@@ -1549,6 +1583,49 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_clock_data(struct feat_fd *ff, FILE *fp)
+{
+	struct timespec clockid_ns;
+	char tstr[64], date[64];
+	struct timeval tod_ns;
+	clockid_t clockid;
+	struct tm ltime;
+	u64 ref;
+
+	if (!ff->ph->env.clock.enabled) {
+		fprintf(fp, "# reference time disabled\n");
+		return;
+	}
+
+	/* Compute TOD time. */
+	ref = ff->ph->env.clock.tod_ns;
+	tod_ns.tv_sec = ref / NSEC_PER_SEC;
+	ref -= tod_ns.tv_sec * NSEC_PER_SEC;
+	tod_ns.tv_usec = ref / NSEC_PER_USEC;
+
+	/* Compute clockid time. */
+	ref = ff->ph->env.clock.clockid_ns;
+	clockid_ns.tv_sec = ref / NSEC_PER_SEC;
+	ref -= clockid_ns.tv_sec * NSEC_PER_SEC;
+	clockid_ns.tv_nsec = ref;
+
+	clockid = ff->ph->env.clock.clockid;
+
+	if (localtime_r(&tod_ns.tv_sec, &ltime) == NULL)
+		snprintf(tstr, sizeof(tstr), "<error>");
+	else {
+		strftime(date, sizeof(date), "%F %T", &ltime);
+		scnprintf(tstr, sizeof(tstr), "%s.%06d",
+			  date, (int) tod_ns.tv_usec);
+	}
+
+	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
+	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%ld (%s)\n",
+		    tstr, tod_ns.tv_sec, (int) tod_ns.tv_usec,
+		    clockid_ns.tv_sec, clockid_ns.tv_nsec,
+		    clockid_name(clockid));
+}
+
 static void print_dir_format(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_session *session;
@@ -2738,6 +2815,40 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_clock_data(struct feat_fd *ff,
+			      void *_data __maybe_unused)
+{
+	u32 data32;
+	u64 data64;
+
+	/* version */
+	if (do_read_u32(ff, &data32))
+		return -1;
+
+	if (data32 != 1)
+		return -1;
+
+	/* clockid */
+	if (do_read_u32(ff, &data32))
+		return -1;
+
+	ff->ph->env.clock.clockid = data32;
+
+	/* TOD ref time */
+	if (do_read_u64(ff, &data64))
+		return -1;
+
+	ff->ph->env.clock.tod_ns = data64;
+
+	/* clockid ref time */
+	if (do_read_u64(ff, &data64))
+		return -1;
+
+	ff->ph->env.clock.clockid_ns = data64;
+	ff->ph->env.clock.enabled = true;
+	return 0;
+}
+
 static int process_dir_format(struct feat_fd *ff,
 			      void *_data __maybe_unused)
 {
@@ -3008,6 +3119,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
 	FEAT_OPR(COMPRESSED,	compressed,	false),
 	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
+	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 650bd1c7a99b..2aca71763ecf 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -44,6 +44,7 @@ enum {
 	HEADER_BPF_BTF,
 	HEADER_COMPRESSED,
 	HEADER_CPU_PMU_CAPS,
+	HEADER_CLOCK_DATA,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.25.4

