Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D01FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B8120809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596145246;
	bh=1HAZXKaBVaca4zQbok7sW5S670YZv6f1NCkTj03rpm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6NAhplzGHO8j1f4K1CkVrq+DlcvVb3AxKu2GdUZl7X1Z6g10QgzJRgmU2iH8hjxK
	 6rVx1BQxvJRZeXhA9tRW1n2R/U5BDiROyVTcihF4K0JbNb97bIT6AhXknfFrb1NsRd
	 2HCgmZQSKU1wlY1XhNmlRWE7DUE9EliyDINlzN8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgG3Vkn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:40:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730684AbgG3Vkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-JeE0oLJhNG6QCp0fP328ag-1; Thu, 30 Jul 2020 17:40:40 -0400
X-MC-Unique: JeE0oLJhNG6QCp0fP328ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C69101902ED4;
        Thu, 30 Jul 2020 21:40:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8E6F87E1C;
        Thu, 30 Jul 2020 21:40:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH 3/6] perf tools: Move clockid_res_ns under clock struct
Date:   Thu, 30 Jul 2020 23:39:47 +0200
Message-Id: <20200730213950.1503773-4-jolsa@kernel.org>
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

Moving clockid_res_ns under clock struct, so we have
clock related stuff in one place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 6 +++---
 tools/perf/util/env.h       | 2 +-
 tools/perf/util/header.c    | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f8280e721e1a..955c621b0ff7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1565,6 +1565,9 @@ static int record__init_clock(struct record *rec)
 	if (!rec->opts.use_clockid)
 		return 0;
 
+	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
+		session->header.env.clock.clockid_res_ns = rec->opts.clockid_res_ns;
+
 	session->header.env.clock.clockid = rec->opts.clockid;
 
 	if (gettimeofday(&ref_tod, NULL) != 0) {
@@ -1673,9 +1676,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	record__init_features(rec);
 
-	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
-		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
-
 	if (forks) {
 		err = perf_evlist__prepare_workload(rec->evlist, &opts->target,
 						    argv, data->is_pipe,
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4098a63d5e64..d50c0a3354e3 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -77,7 +77,6 @@ struct perf_env {
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
-	u64                     clockid_res_ns;
 
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
@@ -105,6 +104,7 @@ struct perf_env {
 	struct {
 		u64	tod_ns;
 		u64	clockid_ns;
+		u64     clockid_res_ns;
 		int	clockid;
 		/*
 		 * enabled is valid for report mode, and is true if above
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ffe10d8fd5fa..88151c5cf286 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -891,8 +891,8 @@ static int write_auxtrace(struct feat_fd *ff,
 static int write_clockid(struct feat_fd *ff,
 			 struct evlist *evlist __maybe_unused)
 {
-	return do_write(ff, &ff->ph->env.clockid_res_ns,
-			sizeof(ff->ph->env.clockid_res_ns));
+	return do_write(ff, &ff->ph->env.clock.clockid_res_ns,
+			sizeof(ff->ph->env.clock.clockid_res_ns));
 }
 
 static int write_clock_data(struct feat_fd *ff,
@@ -1580,7 +1580,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 static void print_clockid(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# clockid frequency: %"PRIu64" MHz\n",
-		ff->ph->env.clockid_res_ns * 1000);
+		ff->ph->env.clock.clockid_res_ns * 1000);
 }
 
 static void print_clock_data(struct feat_fd *ff, FILE *fp)
@@ -2809,7 +2809,7 @@ static int process_mem_topology(struct feat_fd *ff,
 static int process_clockid(struct feat_fd *ff,
 			   void *data __maybe_unused)
 {
-	if (do_read_u64(ff, &ff->ph->env.clockid_res_ns))
+	if (do_read_u64(ff, &ff->ph->env.clock.clockid_res_ns))
 		return -1;
 
 	return 0;
-- 
2.25.4

