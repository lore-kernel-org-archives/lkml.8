Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB392C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC923246CB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgB2JRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgB2JRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEq-0005pN-HP; Sat, 29 Feb 2020 10:16:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2179B1C0243;
        Sat, 29 Feb 2020 10:16:48 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:47 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf config: Document missing config options
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213064306.160480-9-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-9-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158296780778.28353.1161299418025837042.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b0aaf4c8f31feb21de59df723231c286df2d6be3
Gitweb:        https://git.kernel.org/tip/b0aaf4c8f31feb21de59df723231c286df2d6be3
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 13 Feb 2020 12:13:06 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 10:45:19 -03:00

perf config: Document missing config options

While documenting annotate.show_nr_samples config option, I found many
other config options missing in perf-config documentation. Add them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-9-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 44 +++++++++++++++++++++++-
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9dae0df..8ead555 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -518,6 +518,12 @@ top.*::
 		column by default.
 		The default is 'true'.
 
+	top.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'top' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf top' to actually use it,
+		the command line option -g must be specified.
+
 man.*::
 	man.viewer::
 		This option can assign a tool to view manual pages when 'help'
@@ -545,6 +551,16 @@ record.*::
 		But if this option is 'no-cache', it will not update the build-id cache.
 		'skip' skips post-processing and does not update the cache.
 
+	record.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'record' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf record' to actually use it,
+		the command line option -g must be specified.
+
+	record.aio::
+		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
+		mode ('n' default: 1, max: 4).
+
 diff.*::
 	diff.order::
 		This option sets the number of columns to sort the result.
@@ -594,6 +610,11 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
+ftrace.*::
+	ftrace.tracer::
+		Can be used to select the default tracer. Possible values are
+		'function' and 'function_graph'.
+
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
@@ -638,6 +659,29 @@ scripts.*::
 	The script gets the same options passed as a full perf script,
 	in particular -i perfdata file, --cpu, --tid
 
+convert.*::
+
+	convert.queue-size::
+		Limit the size of ordered_events queue, so we could control
+		allocation size of perf data files without proper finished
+		round events.
+
+intel-pt.*::
+
+	intel-pt.cache-divisor::
+
+	intel-pt.mispred-all::
+		If set, Intel PT decoder will set the mispred flag on all
+		branches.
+
+auxtrace.*::
+
+	auxtrace.dumpdir::
+		s390 only. The directory to save the auxiliary trace buffer
+		can be changed using this option. Ex, auxtrace.dumpdir=/tmp.
+		If the directory does not exist or has the wrong file type,
+		the current directory is used.
+
 SEE ALSO
 --------
 linkperf:perf[1]
