Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED83C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FD720E65
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgICMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:43:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:55278 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgICMav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:30:51 -0400
IronPort-SDR: Ofz3ZdC5LRUtYMC+m/gUIbBcBgP130Mm7euUe4zWeeMCEqtDeUEYNFZzQ0zcXgvTd8FnfL6aPQ
 PqZfhiUm7g7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137614624"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="137614624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:30:01 -0700
IronPort-SDR: nojt4O6m0aBQvrt7t33ViU653ibmOtA3Rp2ONtuAC3oM1tAzDRPPqa9U/nBORtyWAj6gjIk73H
 Y+H0HI/0iqLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="315456912"
Received: from slisovsk-lenovo-ideapad-720s-13ikb.fi.intel.com (HELO ahunter-Desktop.fi.intel.com) ([10.237.72.190])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2020 05:29:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Consolidate close_control_option()'s into one function
Date:   Thu,  3 Sep 2020 15:29:37 +0300
Message-Id: <20200903122937.25691-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e4d294a9-9d97-2cb0-c43d-926fbf90b819@intel.com>
References: <e4d294a9-9d97-2cb0-c43d-926fbf90b819@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate control option fifo closing into one function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


This patch is on top of patch:
"perf tools: Add FIFO file names as alternative options to --control"


 tools/perf/builtin-record.c | 12 +-----------
 tools/perf/builtin-stat.c   | 12 +-----------
 tools/perf/util/evlist.c    | 10 ++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 476b34ff3152..9db3901e6561 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2253,16 +2253,6 @@ static int parse_control_option(const struct option *opt,
 	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack, &opts->ctl_fd_close);
 }
 
-static void close_control_option(struct record_opts *opts)
-{
-	if (opts->ctl_fd_close) {
-		opts->ctl_fd_close = false;
-		close(opts->ctl_fd);
-		if (opts->ctl_fd_ack >= 0)
-			close(opts->ctl_fd_ack);
-	}
-}
-
 static void switch_output_size_warn(struct record *rec)
 {
 	u64 wakeup_size = evlist__mmap_size(rec->opts.mmap_pages);
@@ -2849,7 +2839,7 @@ int cmd_record(int argc, const char **argv)
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
-	close_control_option(&rec->opts);
+	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
 	return err;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 21424ed0734b..68d4bdf15635 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1051,16 +1051,6 @@ static int parse_control_option(const struct option *opt,
 	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack, &config->ctl_fd_close);
 }
 
-static void close_control_option(struct perf_stat_config *config)
-{
-	if (config->ctl_fd_close) {
-		config->ctl_fd_close = false;
-		close(config->ctl_fd);
-		if (config->ctl_fd_ack >= 0)
-			close(config->ctl_fd_ack);
-	}
-}
-
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -2408,7 +2398,7 @@ int cmd_stat(int argc, const char **argv)
 
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	runtime_stat_delete(&stat_config);
-	close_control_option(&stat_config);
+	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
 	return status;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e72ff7e78dec..ee7b576d3b12 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1802,6 +1802,16 @@ int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *c
 	return 0;
 }
 
+void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close)
+{
+	if (*ctl_fd_close) {
+		*ctl_fd_close = false;
+		close(ctl_fd);
+		if (ctl_fd_ack >= 0)
+			close(ctl_fd_ack);
+	}
+}
+
 int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
 {
 	if (fd == -1) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 91d1da6e1fe3..bc38a53f6a1a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -376,6 +376,7 @@ enum evlist_ctl_cmd {
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
+void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
-- 
2.17.1

