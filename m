Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E4C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDEB20825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgH2Kvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:51:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:17383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgH2Ku5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:50:57 -0400
IronPort-SDR: xSaM9ctF+UEyQasXg8G8HJMkcUPTKR9cZITcoTiiQyvtU6ny4q9+LjLUaA1K6gAah+vn2cgr6z
 UxonRbDj4jwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174838398"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="174838398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:50:55 -0700
IronPort-SDR: VWn4Yg3cyuIHOORm74P78TuhQ9ESqU1W3YnovAwt9Bjv3pzwxx/Wi1M6pMkBCNzNR4MvMc6zES
 oRpwgOjVDZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="313853148"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2020 03:50:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] perf tools: Consolidate --control option parsing into one function
Date:   Sat, 29 Aug 2020 13:50:10 +0300
Message-Id: <20200829105015.10800-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829105015.10800-1-adrian.hunter@intel.com>
References: <20200829105015.10800-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate --control option parsing into one function, in preparation for
adding FIFO file name options.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 22 ++--------------------
 tools/perf/builtin-stat.c   | 22 ++--------------------
 tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f91352f847c0..f2ab5bd7e2ba 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2234,27 +2234,9 @@ static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
 {
-	char *comma = NULL, *endptr = NULL;
-	struct record_opts *config = (struct record_opts *)opt->value;
-
-	if (strncmp(str, "fd:", 3))
-		return -EINVAL;
-
-	config->ctl_fd = strtoul(&str[3], &endptr, 0);
-	if (endptr == &str[3])
-		return -EINVAL;
-
-	comma = strchr(str, ',');
-	if (comma) {
-		if (endptr != comma)
-			return -EINVAL;
-
-		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
-		if (endptr == comma + 1 || *endptr != '\0')
-			return -EINVAL;
-	}
+	struct record_opts *opts = opt->value;
 
-	return 0;
+	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack);
 }
 
 static void switch_output_size_warn(struct record *rec)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..12ce5cf2b10e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1045,27 +1045,9 @@ static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
 {
-	char *comma = NULL, *endptr = NULL;
-	struct perf_stat_config *config = (struct perf_stat_config *)opt->value;
+	struct perf_stat_config *config = opt->value;
 
-	if (strncmp(str, "fd:", 3))
-		return -EINVAL;
-
-	config->ctl_fd = strtoul(&str[3], &endptr, 0);
-	if (endptr == &str[3])
-		return -EINVAL;
-
-	comma = strchr(str, ',');
-	if (comma) {
-		if (endptr != comma)
-			return -EINVAL;
-
-		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
-		if (endptr == comma + 1 || *endptr != '\0')
-			return -EINVAL;
-	}
-
-	return 0;
+	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack);
 }
 
 static struct option stat_options[] = {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e3fa3bf7498a..62e3f87547ce 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1727,6 +1727,30 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	return leader;
 }
 
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack)
+{
+	char *comma = NULL, *endptr = NULL;
+
+	if (strncmp(str, "fd:", 3))
+		return -EINVAL;
+
+	*ctl_fd = strtoul(&str[3], &endptr, 0);
+	if (endptr == &str[3])
+		return -EINVAL;
+
+	comma = strchr(str, ',');
+	if (comma) {
+		if (endptr != comma)
+			return -EINVAL;
+
+		*ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
+		if (endptr == comma + 1 || *endptr != '\0')
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
 {
 	if (fd == -1) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c73f7f7f120b..a5a5a07d5c55 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -373,6 +373,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_ACK
 };
 
+int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
-- 
2.17.1

