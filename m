Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF5CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0EF2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596620339;
	bh=ni8nL40KM7GrdWCjoiXe7R6AXjZzNTxkhYvPvL6NNzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvtHKawewKGLSWdSdl9ynriwlZ3RzDqOs7I2c7nncoki1yy5yg094enXXF10+xwgX
	 JP+8qzvNgZH+b4+S9dRqXwLGlY/OZPLQEblG51qdT/aejEsCrSZ3TH2o4iPjHCQnaL
	 /FIBg8IoORbRqqquoGqUfveZ12yFA/R1bBZjygl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHEJiz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:38:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24443 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728366AbgHEJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:35:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-wM9pjQ9HP-KG5JbeMQ70XA-1; Wed, 05 Aug 2020 05:35:08 -0400
X-MC-Unique: wM9pjQ9HP-KG5JbeMQ70XA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F169800685;
        Wed,  5 Aug 2020 09:35:06 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9E257193A;
        Wed,  5 Aug 2020 09:35:02 +0000 (UTC)
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
Subject: [PATCH v2 4/7] perf tools: Move clockid_res_ns under clock struct
Date:   Wed,  5 Aug 2020 11:34:41 +0200
Message-Id: <20200805093444.314999-5-jolsa@kernel.org>
In-Reply-To: <20200805093444.314999-1-jolsa@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index 48d721af0096..c0f845021a16 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1566,6 +1566,9 @@ static int record__init_clock(struct record *rec)
 	if (!rec->opts.use_clockid)
 		return 0;
 
+	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
+		session->header.env.clock.clockid_res_ns = rec->opts.clockid_res_ns;
+
 	session->header.env.clock.clockid = rec->opts.clockid;
 
 	if (gettimeofday(&ref_tod, NULL) != 0) {
@@ -1674,9 +1677,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	record__init_features(rec);
 
-	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
-		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
-
 	if (forks) {
 		err = perf_evlist__prepare_workload(rec->evlist, &opts->target,
 						    argv, data->is_pipe,
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 7218f7db57af..a12972652006 100644
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
index eece94cf6f86..251faa9a5789 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -892,8 +892,8 @@ static int write_auxtrace(struct feat_fd *ff,
 static int write_clockid(struct feat_fd *ff,
 			 struct evlist *evlist __maybe_unused)
 {
-	return do_write(ff, &ff->ph->env.clockid_res_ns,
-			sizeof(ff->ph->env.clockid_res_ns));
+	return do_write(ff, &ff->ph->env.clock.clockid_res_ns,
+			sizeof(ff->ph->env.clock.clockid_res_ns));
 }
 
 static int write_clock_data(struct feat_fd *ff,
@@ -1581,7 +1581,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 static void print_clockid(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# clockid frequency: %"PRIu64" MHz\n",
-		ff->ph->env.clockid_res_ns * 1000);
+		ff->ph->env.clock.clockid_res_ns * 1000);
 }
 
 static void print_clock_data(struct feat_fd *ff, FILE *fp)
@@ -2810,7 +2810,7 @@ static int process_mem_topology(struct feat_fd *ff,
 static int process_clockid(struct feat_fd *ff,
 			   void *data __maybe_unused)
 {
-	if (do_read_u64(ff, &ff->ph->env.clockid_res_ns))
+	if (do_read_u64(ff, &ff->ph->env.clock.clockid_res_ns))
 		return -1;
 
 	return 0;
-- 
2.25.4

