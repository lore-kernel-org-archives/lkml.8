Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85720C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654AF21548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbgE1MJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:09:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:6222 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389606AbgE1MJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:09:33 -0400
IronPort-SDR: gYBULXFrKWVOPYFxQeyhyo+/QKmL7+KKZR3RppU535WgSVxVqq7UPumCDPJuczehaa9Uww+6Fj
 Mm6WZEcdnkCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 05:09:32 -0700
IronPort-SDR: yEqBFzBhFJBzCxZe5wTwFWbikt1bebQbKFHccRu7uTwdxRQQfW+uOem1sgQPOBoKeulwstEtwj
 Y8TjfiaqUSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="270831798"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga006.jf.intel.com with ESMTP; 28 May 2020 05:09:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 1/2] perf record: Respect --no-switch-events
Date:   Thu, 28 May 2020 15:08:58 +0300
Message-Id: <20200528120859.21604-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context switch events are added automatically by Intel PT and Coresight.
Make it possible to suppress them. That is useful for tracing the
scheduler without the disturbance that the switch event processing
creates.

Example:

  Prerequisites:

    $ which perf
    ~/bin/perf
    $ sudo setcap "cap_sys_rawio,cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_ipc_lock=ep" ~/bin/perf
    $ sudo chmod +r /proc/kcore

  Before:

    $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.938 MB perf.data ]
    $ perf script -D | grep PERF_RECORD_SWITCH | wc -l
    572

  After:

    $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
    Warning:
    Intel Processor Trace decoding will not be possible except for kernel tracing!
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.838 MB perf.data ]
    $ perf script -D | grep PERF_RECORD_SWITCH | wc -l
    0

    $ sudo chmod go-r /proc/kcore
    $ sudo setcap -r ~/bin/perf

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt | 4 +++-
 tools/perf/arch/arm/util/cs-etm.c        | 3 ++-
 tools/perf/arch/x86/util/intel-pt.c      | 3 ++-
 tools/perf/builtin-record.c              | 5 +++--
 tools/perf/util/record.h                 | 6 ++++++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 561ef55743e2..97b1a866ab22 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -458,7 +458,9 @@ This option sets the time out limit. The default value is 500 ms.
 
 --switch-events::
 Record context switch events i.e. events of type PERF_RECORD_SWITCH or
-PERF_RECORD_SWITCH_CPU_WIDE.
+PERF_RECORD_SWITCH_CPU_WIDE. In some cases (e.g. Intel PT or CoreSight)
+switch events will be enabled automatically, which can be suppressed by
+by the option --no-switch-events.
 
 --clang-path=PATH::
 Path to clang binary to use for compiling BPF scriptlets.
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 607499b41bea..cea5e33d61d2 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -265,7 +265,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
-	if (perf_can_record_switch_events())
+	if (!record_opts__no_switch_events(opts) &&
+	    perf_can_record_switch_events())
 		opts->record_switch_events = true;
 
 	evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index fdb917fcf511..3fc547769707 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -779,7 +779,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !perf_cpu_map__empty(cpus)) {
+	if (have_timing_info && !perf_cpu_map__empty(cpus) &&
+	    !record_opts__no_switch_events(opts)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
 					!target__has_task(&opts->target);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02d85f4e4517..dc6d5ba2fff8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2490,8 +2490,9 @@ static struct option __record_options[] = {
 		    "Record namespaces events"),
 	OPT_BOOLEAN(0, "all-cgroups", &record.opts.record_cgroup,
 		    "Record cgroup events"),
-	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
-		    "Record context switch events"),
+	OPT_BOOLEAN_SET(0, "switch-events", &record.opts.record_switch_events,
+			&record.opts.record_switch_events_set,
+			"Record context switch events"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &record.opts.all_kernel,
 			 "Configure all used events to run in kernel space.",
 			 PARSE_OPT_EXCLUSIVE),
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index dce6332f5071..84dbbc3f0204 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -36,6 +36,7 @@ struct record_opts {
 	bool	      record_namespaces;
 	bool	      record_cgroup;
 	bool	      record_switch_events;
+	bool	      record_switch_events_set;
 	bool	      all_kernel;
 	bool	      all_user;
 	bool	      kernel_callchains;
@@ -77,4 +78,9 @@ extern struct option *record_options;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
 
+static inline bool record_opts__no_switch_events(const struct record_opts *opts)
+{
+	return opts->record_switch_events_set && !opts->record_switch_events;
+}
+
 #endif // _PERF_RECORD_H
-- 
2.17.1

