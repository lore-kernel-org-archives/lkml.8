Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8DCC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E863D206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519121;
	bh=SH5WV4YDFnSxTVWTQGXizFsyIfx2TN8LCmZ4jrGciQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OO6oDyMoQHlhde55206F47UZ0go+Seq73DwfOuNqzCFgNp4LrcgCtX8N/oZXS66Zt
	 FENtogPFg/kPojHeA2ydtAMut3lc2kv/WpsQvw3nTP6XTmDwQMLVdsM591bAW+ycAD
	 Ow0oRThv1b9FzlsJ/ncDNNyhY9jitiUAc+DhKALw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXEib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40929 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgBXEi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so4690484pfb.7;
        Sun, 23 Feb 2020 20:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HThnidRWUfs4k078ofnDDi6WrbTl8wZ5xAS/ZyzJAhw=;
        b=qEsM+STn3dRtsXhQqKrjnwJOMm+bUmEW8G3Vl/jZVoMZm2A8GV+eekw5YAv6s8bQgW
         fWwbngc884j89XzkgNwF9tzWYWTb/BSbb+M0GHGch4fzodByES/j+GuKKOGKGFxRFtDd
         +oCNCLoNi7hkGOvGabzpmqNH95+0AJtEqGDggVvoVkN0YUcRWX3UE2YpgPmqFZvpLR2G
         7rbVmGiSoG+fOssp9tYwSS+Yiy6XsVEdetsF1OaQdB0x1PRhUCHrc8YJ5P8flDmGCy9h
         ycHS37Dm7HbhGn9BpCnIhOpaqpCTwuDfGe9yofQR4ffYpu24amRgvktv8KD7pbOumpwA
         5hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HThnidRWUfs4k078ofnDDi6WrbTl8wZ5xAS/ZyzJAhw=;
        b=qpAkHQ3ZG0tG7GGJYAciGqW5QDkoKDJseR0lUHkmr0R+Gu6TXHp2hdKrcx+bg2wO5q
         lJJgQfZIdZ3SPlB3hb0TrPfX2yL685rul4Bkb+D3VIaDOSsASbCRwx0K0YqbrgUlb0SQ
         +EcgmWN0I8wuaUOp1psxvFuepqvQz6SWmMPb6t7HXVAZZwCv+DdYlrvrl7N8m2DPgsYD
         r4Vff44/Bs63pDWdjdOM7/uXgKoPs6oGvLP2Btx1qmG/2jBcKDSVOX9ETL1yEEJcVP02
         f1nAW+TkxqDfEu9pHe93+Ihgr/ClPXl1ip/lT1d0kTmkakrHxBJBL48MXO+sYYMEO0CQ
         TNJQ==
X-Gm-Message-State: APjAAAUJ8Y2TQXMXgrv4KM9adfA576dGSxAbQG5V0l+59Md/pPq3RCO7
        E8pYoarWPHELWRq/KeSxx3o=
X-Google-Smtp-Source: APXvYqxqotoa7fd4hFfZ1WIVBrfncSJku5hDGAlegMBWeDmBRQQce8MXY7FeNVLhXlGFVmyaFmnXSA==
X-Received: by 2002:a65:5905:: with SMTP id f5mr14342418pgu.87.1582519106423;
        Sun, 23 Feb 2020 20:38:26 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:25 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 08/10] perf record: Add --all-cgroups option
Date:   Mon, 24 Feb 2020 13:37:47 +0900
Message-Id: <20200224043749.69466-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 ++++-
 tools/perf/builtin-record.c              |  5 +++++
 tools/perf/util/evsel.c                  | 11 ++++++++++-
 tools/perf/util/evsel.h                  |  1 +
 tools/perf/util/record.h                 |  1 +
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b23a4012a606..6dd9d69d7dee 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -385,7 +385,10 @@ displayed with the weight and local_weight sort keys.  This currently works for
 abort events and some memory events in precise mode on modern Intel CPUs.
 
 --namespaces::
-Record events of type PERF_RECORD_NAMESPACES.
+Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
+
+--all-cgroups::
+Record events of type PERF_RECORD_CGROUP.  This enables 'cgroup' sort key.
 
 --transaction::
 Record transaction flags for transaction related events.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2802de9538ff..7d7912e121d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1433,6 +1433,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->opts.record_namespaces)
 		tool->namespace_events = true;
 
+	if (rec->opts.record_cgroup)
+		tool->cgroup_events = true;
+
 	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
 		signal(SIGUSR2, snapshot_sig_handler);
 		if (rec->opts.auxtrace_snapshot_mode)
@@ -2363,6 +2366,8 @@ static struct option __record_options[] = {
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &record.opts.record_cgroup,
+		    "Record cgroup events"),
 	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
 		    "Record context switch events"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &record.opts.all_kernel,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fcafa1c5c931..9c6707ccd805 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1102,6 +1102,11 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
 
+	if (opts->record_cgroup) {
+		attr->cgroup = track && !perf_missing_features.cgroup;
+		perf_evsel__set_sample_bit(evsel, CGROUP);
+	}
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -1784,7 +1789,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..df71b530740b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool cgroup;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 5421fd2ad383..24316458be20 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -34,6 +34,7 @@ struct record_opts {
 	bool	      auxtrace_snapshot_on_exit;
 	bool	      auxtrace_sample_mode;
 	bool	      record_namespaces;
+	bool	      record_cgroup;
 	bool	      record_switch_events;
 	bool	      all_kernel;
 	bool	      all_user;
-- 
2.25.0.265.gbab2e86ba0-goog

