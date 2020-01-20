Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F97C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AC8208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgATI11 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:27:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgATI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:27:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itSOz-0002uc-TQ; Mon, 20 Jan 2020 09:27:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C99F1C1A3D;
        Mon, 20 Jan 2020 09:27:14 +0100 (CET)
Date:   Mon, 20 Jan 2020 08:27:14 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Support --prefix/--prefix-strip
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157950883427.396.3928162486983105129.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3b0b16bf8cb92ae67968c1abb7b335032b899b33
Gitweb:        https://git.kernel.org/tip/3b0b16bf8cb92ae67968c1abb7b335032b899b33
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Tue, 07 Jan 2020 13:04:44 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Jan 2020 12:02:19 -03:00

perf tools: Support --prefix/--prefix-strip

The objdump utility has useful --prefix / --prefix-strip options to
allow changing source code file names hardcoded into executables' debug
info. Add options to 'perf report', 'perf top' and 'perf annotate',
which are then passed to objdump.

  $ mkdir foo
  $ echo 'main() { for (;;); }' > foo/foo.c
  $ gcc -g foo/foo.c
  foo/foo.c:1:1: warning: return type defaults to ‘int’ [-Wimplicit-int]
      1 | main() { for (;;); }
        | ^~~~
  $ perf record ./a.out
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.230 MB perf.data (5721 samples) ]
  $ mv foo bar
  $ perf annotate
  <does not show source code>
  $ perf annotate --prefix=/home/ak/lsrc/git/bar --prefix-strip=5
  <does show source code>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 20200107210444.214071-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  6 ++++++
 tools/perf/Documentation/perf-report.txt   |  6 ++++++
 tools/perf/Documentation/perf-top.txt      |  6 ++++++
 tools/perf/builtin-annotate.c              |  7 +++++++
 tools/perf/builtin-report.c                |  7 +++++++
 tools/perf/builtin-top.c                   |  7 +++++++
 tools/perf/util/annotate.c                 | 19 +++++++++++++++++--
 tools/perf/util/annotate.h                 |  5 +++++
 8 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index e8c972f..1b5042f 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -112,6 +112,12 @@ OPTIONS
 --objdump=<path>::
         Path to objdump binary.
 
+--prefix=PREFIX::
+--prefix-strip=N::
+	Remove first N entries from source file path names in executables
+	and add PREFIX. This allows to display source code compiled on systems
+	with different file system layout.
+
 --skip-missing::
 	Skip symbols that cannot be annotated.
 
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8dbe211..db61f16 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -367,6 +367,12 @@ OPTIONS
 --objdump=<path>::
         Path to objdump binary.
 
+--prefix=PREFIX::
+--prefix-strip=N::
+	Remove first N entries from source file path names in executables
+	and add PREFIX. This allows to display source code compiled on systems
+	with different file system layout.
+
 --group::
 	Show event group information together. It forces group output also
 	if there are no groups defined in data file.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129..324b6b5 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -158,6 +158,12 @@ Default is to monitor all CPUS.
 -M::
 --disassembler-style=:: Set disassembler style for objdump.
 
+--prefix=PREFIX::
+--prefix-strip=N::
+        Remove first N entries from source file path names in executables
+        and add PREFIX. This allows to display source code compiled on systems
+        with different file system layout.
+
 --source::
 	Interleave source code with assembly code. Enabled by default,
 	disable with --no-source.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5898662..ff61795 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -535,6 +535,10 @@ int cmd_annotate(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
+	OPT_STRING(0, "prefix", &annotate.opts.prefix, "prefix",
+		    "Add prefix to source file path names in programs (with --prefix-strip)"),
+	OPT_STRING(0, "prefix-strip", &annotate.opts.prefix_strip, "N",
+		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
@@ -574,6 +578,9 @@ int cmd_annotate(int argc, const char **argv)
 		annotate.sym_hist_filter = argv[0];
 	}
 
+	if (annotate_check_args(&annotate.opts) < 0)
+		return -EINVAL;
+
 	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
 		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
 		return ret;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3048c1b..627bb65 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1208,6 +1208,10 @@ int cmd_report(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &report.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
+	OPT_STRING(0, "prefix", &report.annotation_opts.prefix, "prefix",
+		    "Add prefix to source file path names in programs (with --prefix-strip)"),
+	OPT_STRING(0, "prefix-strip", &report.annotation_opts.prefix_strip, "N",
+		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &report.group_set,
@@ -1287,6 +1291,9 @@ int cmd_report(int argc, const char **argv)
 		report.symbol_filter_str = argv[0];
 	}
 
+	if (annotate_check_args(&report.annotation_opts) < 0)
+		return -EINVAL;
+
 	if (report.mmaps_mode)
 		report.tasks_mode = true;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 795e353..8affcab 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1512,6 +1512,10 @@ int cmd_top(int argc, const char **argv)
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
+	OPT_STRING(0, "prefix", &top.annotation_opts.prefix, "prefix",
+		    "Add prefix to source file path names in programs (with --prefix-strip)"),
+	OPT_STRING(0, "prefix-strip", &top.annotation_opts.prefix_strip, "N",
+		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
@@ -1582,6 +1586,9 @@ int cmd_top(int argc, const char **argv)
 	if (argc)
 		usage_with_options(top_usage, options);
 
+	if (annotate_check_args(&top.annotation_opts) < 0)
+		goto out_delete_evlist;
+
 	if (!top.evlist->core.nr_entries &&
 	    perf_evlist__add_default(top.evlist) < 0) {
 		pr_err("Not enough memory for event selector list\n");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f5e77ed..ca73fb7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1966,14 +1966,20 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"$1\"",
+		 " -l -d %s %s %s %c%s%c %s%s -C \"$1\"",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw-insn",
-		 opts->annotate_src ? "-S" : "");
+		 opts->annotate_src ? "-S" : "",
+		 opts->prefix ? "--prefix " : "",
+		 opts->prefix ? '"' : ' ',
+		 opts->prefix ?: "",
+		 opts->prefix ? '"' : ' ',
+		 opts->prefix_strip ? "--prefix-strip=" : "",
+		 opts->prefix_strip ?: "");
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
@@ -3204,3 +3210,12 @@ out:
 	free(str1);
 	return err;
 }
+
+int annotate_check_args(struct annotation_options *args)
+{
+	if (args->prefix_strip && !args->prefix) {
+		pr_err("--prefix-strip requires --prefix\n");
+		return -1;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7075d98..455403e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -94,6 +94,8 @@ struct annotation_options {
 	int  context;
 	const char *objdump_path;
 	const char *disassembler_style;
+	const char *prefix;
+	const char *prefix_strip;
 	unsigned int percent_type;
 };
 
@@ -415,4 +417,7 @@ void annotation_config__init(void);
 
 int annotate_parse_percent_type(const struct option *opt, const char *_str,
 				int unset);
+
+int annotate_check_args(struct annotation_options *args);
+
 #endif	/* __PERF_ANNOTATE_H */
