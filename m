Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370962173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596145253;
	bh=0+zk9rSvRzXPGM0CNz16Rg8hHmXrupM6s5q2HwfE2uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nrZpRfX0elkNQA9qcTiJMkrIm9FUxBbg9361oySPOH3tU6pzOIdifckqcIjK5/rEN
	 ZdaY6jnyRcSh2BbFdJVKIVYQ10M74niaSB2XdbC9HIh3exRcaHVdQb+TDlm1uHmx0d
	 45wtQ9zzIpzV/h8VmnV4U+udwGUhsR9K9n4/7P7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgG3Vkw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:40:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728849AbgG3Vkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-q3-UX8z4PuGtJe8X9v73DQ-1; Thu, 30 Jul 2020 17:40:44 -0400
X-MC-Unique: q3-UX8z4PuGtJe8X9v73DQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 184F8804031;
        Thu, 30 Jul 2020 21:40:36 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CC786EF83;
        Thu, 30 Jul 2020 21:40:33 +0000 (UTC)
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
Subject: [PATCH 4/6] perf tools: Add support to store time of day in CTF data conversion
Date:   Thu, 30 Jul 2020 23:39:48 +0200
Message-Id: <20200730213950.1503773-5-jolsa@kernel.org>
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

Adding support to convert and store time of day in CTF
data conversion for 'perf data convert' subcommand.

The perf.data used for conversion needs to have clock data
information - must be recorded with -k/--clockid option).

New --tod option is added to 'perf data convert' subcommand
to convert data with timestamps converted to wall clock time.

Record data with clockid set:
  # perf record -k CLOCK_MONOTONIC kill
  kill: not enough arguments
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.033 MB perf.data (8 samples) ]

Convert data with TOD timestamps:
  # perf data convert --tod --to-ctf ./ctf
  [ perf data convert: Converted 'perf.data' into CTF data './ctf' ]
  [ perf data convert: Converted and wrote 0.000 MB (8 samples) ]

Display data in perf script:
  # perf script -F+tod --ns
            perf 262150 2020-07-13 18:38:50.097678523 153633.958246159:          1 cycles: ...
            perf 262150 2020-07-13 18:38:50.097682941 153633.958250577:          1 cycles: ...
            perf 262150 2020-07-13 18:38:50.097684997 153633.958252633:          7 cycles: ...
  ...

Display data in babeltrace:
  # babeltrace --clock-date  ./ctf
  [2020-07-13 18:38:50.097678523] (+?.?????????) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
  [2020-07-13 18:38:50.097682941] (+0.000004418) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
  [2020-07-13 18:38:50.097684997] (+0.000002056) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
  ...

It's available only for recording with clockid specified,
because it's the only case where we can get reference time
to wallclock time. It's can't do that with perf clock yet.

Error is display if you want to use --tod on data without
clockid specified:

  # perf data convert --tod --to-ctf ./ctf
  Can't provide --tod time, missing clock data. Please record with -k/--clockid option.
  Failed to setup CTF writer.
  Error during conversion setup.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-data.txt |  3 ++
 tools/perf/builtin-data.c              |  1 +
 tools/perf/util/data-convert-bt.c      | 56 +++++++++++++++++---------
 tools/perf/util/data-convert.h         |  1 +
 4 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index c87180764829..726b9bc9e1a7 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -27,6 +27,9 @@ OPTIONS for 'convert'
 --to-ctf::
 	Triggers the CTF conversion, specify the path of CTF data directory.
 
+--tod::
+	Convert time to wall clock time.
+
 -i::
 	Specify input perf data file path.
 
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index ca2fb44874e4..8d23b8d6ee8e 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -65,6 +65,7 @@ static int cmd_data_convert(int argc, const char **argv)
 		OPT_STRING('i', "input", &input_name, "file", "input file name"),
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
 		OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
+		OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
 #endif
 		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 5f36fc6a5578..ded8a9da0fe8 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -31,6 +31,8 @@
 #include "config.h"
 #include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/time64.h>
+#include "util.h"
 
 #define pr_N(n, fmt, ...) \
 	eprintf(n, debug_data_convert, fmt, ##__VA_ARGS__)
@@ -1381,11 +1383,26 @@ do {									\
 	return 0;
 }
 
-static int ctf_writer__setup_clock(struct ctf_writer *cw)
+static int ctf_writer__setup_clock(struct ctf_writer *cw,
+				   struct perf_session *session,
+				   bool tod)
 {
 	struct bt_ctf_clock *clock = cw->clock;
+	const char *desc = "perf clock";
+	int64_t offset = 0;
 
-	bt_ctf_clock_set_description(clock, "perf clock");
+	if (tod) {
+		struct perf_env *env = &session->header.env;
+
+		if (!env->clock.enabled) {
+			pr_err("Can't provide --tod time, missing clock data. "
+			       "Please record with -k/--clockid option.\n");
+			return -1;
+		}
+
+		desc   = clockid_name(env->clock.clockid);
+		offset = env->clock.tod_ns - env->clock.clockid_ns;
+	}
 
 #define SET(__n, __v)				\
 do {						\
@@ -1394,8 +1411,8 @@ do {						\
 } while (0)
 
 	SET(frequency,   1000000000);
-	SET(offset_s,    0);
-	SET(offset,      0);
+	SET(offset,      offset);
+	SET(description, desc);
 	SET(precision,   10);
 	SET(is_absolute, 0);
 
@@ -1481,7 +1498,8 @@ static void ctf_writer__cleanup(struct ctf_writer *cw)
 	memset(cw, 0, sizeof(*cw));
 }
 
-static int ctf_writer__init(struct ctf_writer *cw, const char *path)
+static int ctf_writer__init(struct ctf_writer *cw, const char *path,
+			    struct perf_session *session, bool tod)
 {
 	struct bt_ctf_writer		*writer;
 	struct bt_ctf_stream_class	*stream_class;
@@ -1505,7 +1523,7 @@ static int ctf_writer__init(struct ctf_writer *cw, const char *path)
 
 	cw->clock = clock;
 
-	if (ctf_writer__setup_clock(cw)) {
+	if (ctf_writer__setup_clock(cw, session, tod)) {
 		pr("Failed to setup CTF clock.\n");
 		goto err_cleanup;
 	}
@@ -1613,17 +1631,15 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	if (err)
 		return err;
 
-	/* CTF writer */
-	if (ctf_writer__init(cw, path))
-		return -1;
-
 	err = -1;
 	/* perf.data session */
 	session = perf_session__new(&data, 0, &c.tool);
-	if (IS_ERR(session)) {
-		err = PTR_ERR(session);
-		goto free_writer;
-	}
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	/* CTF writer */
+	if (ctf_writer__init(cw, path, session, opts->tod))
+		goto free_session;
 
 	if (c.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
@@ -1632,17 +1648,17 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 
 	/* CTF writer env/clock setup  */
 	if (ctf_writer__setup_env(cw, session))
-		goto free_session;
+		goto free_writer;
 
 	/* CTF events setup */
 	if (setup_events(cw, session))
-		goto free_session;
+		goto free_writer;
 
 	if (opts->all && setup_non_sample_events(cw, session))
-		goto free_session;
+		goto free_writer;
 
 	if (setup_streams(cw, session))
-		goto free_session;
+		goto free_writer;
 
 	err = perf_session__process_events(session);
 	if (!err)
@@ -1670,10 +1686,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 
 	return err;
 
-free_session:
-	perf_session__delete(session);
 free_writer:
 	ctf_writer__cleanup(cw);
+free_session:
+	perf_session__delete(session);
 	pr_err("Error during conversion setup.\n");
 	return err;
 }
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index af90b6076c06..feab5f114e37 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -5,6 +5,7 @@
 struct perf_data_convert_opts {
 	bool force;
 	bool all;
+	bool tod;
 };
 
 #endif /* __DATA_CONVERT_H */
-- 
2.25.4

