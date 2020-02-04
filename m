Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BCC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7342087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBDRpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:45:17 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:14426 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgBDRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:45:17 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 12:45:17 EST
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48BsNc0x4QzQlBW;
        Tue,  4 Feb 2020 18:38:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id r-FS5AX31atR; Tue,  4 Feb 2020 18:38:04 +0100 (CET)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf script: introduce deltatime option
Date:   Tue,  4 Feb 2020 18:37:09 +0100
Message-Id: <20200204173709.489161-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some kind of analysis a deltatime output is more human friendly and reduce
the cognitive load for further analysis.

The following output demonstrate the new option "deltatime": calculate
the time difference in relation to the previous event.

$ perf script --deltatime
test  2525 [001]     0.000000:            sdt_libev:ev_add: (5635e72a5ebd)
test  2525 [001]     0.000091:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     1.000051: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
test  2525 [001]     0.000685:            sdt_libev:ev_add: (5635e72a5ebd)
test  2525 [001]     0.000048:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     1.000104: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
test  2525 [001]     0.003895:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     0.996034: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
test  2525 [001]     0.000058:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     1.000004: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
test  2525 [001]     0.000064:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     0.999934: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
test  2525 [001]     0.000056:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
test  2525 [001]     0.999930: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
---
 tools/perf/builtin-script.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2406b291c1c..d5566b121159 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,7 +63,9 @@
 static char const		*script_name;
 static char const		*generate_script_lang;
 static bool			reltime;
+static bool			deltatime;
 static u64			initial_time;
+static u64			previous_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -704,6 +706,13 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			if (!initial_time)
 				initial_time = sample->time;
 			t = sample->time - initial_time;
+		} else if (deltatime) {
+			if (previous_time)
+				t = sample->time - previous_time;
+			else {
+				t = 0;
+			}
+			previous_time = sample->time;
 		}
 		nsecs = t;
 		secs = nsecs / NSEC_PER_SEC;
@@ -3551,6 +3560,7 @@ int cmd_script(int argc, const char **argv)
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
 	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
+	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3647,6 +3657,13 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (reltime && deltatime) {
+		fprintf(stderr,
+			"reltime and deltatime - the two don't get along well. "
+			"Please limit to --reltime or --deltatime.\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
-- 
2.24.1

