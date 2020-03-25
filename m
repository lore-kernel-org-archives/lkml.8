Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4AF20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140372;
	bh=On5XtuneZKQ1pok+Hf2g9qwBGL4WY0A3H5vBq9+8h0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XI4AdRAvvfH7A5tc6R47Qc8VT1oFnIIMtT+wfIUtacmhcI++U5nRA8+DhNfmuOgeX
	 tflYTy5rOrlJ3HSNNENOOKRdupYpe0RWHpqTwnngRwDImCPXYbuOC9DZ8bUuc9EA2a
	 IFJ0AtX3FoyEyd0fYhfp78AKLpVjtNcZPt0kjdSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCYMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45474 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCYMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so750644pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hw5pki8UDdO7CMhfZhMT3uXT6syvxquWurjnaKG4Bc=;
        b=rub+aGJRRCBPRlJW2uWJQiatHLHBubC7aISZhzQ37QnEyF/6rPpOqtTuucpuIICcJe
         8HGnNEovwxnV5kHjUcHvsqgBVXUeOY9E3qeaX6Eqon4lDkCcomrAT/4NcmPfqKLHuPfe
         zTroNAT4zOV0KYhgxZJa9k5yp6kUmSv4/k3p+NfhEKZDaeV6AIcOolDWhajBKOGnQNDm
         y6Z591MWqyaAiSPof0l5HDEWcsZiETh+G53zzvjhrepBRl/E5+PDqlDQTW0/Doya3nAk
         ObW3+7Rjd77YtQyA43Y5Guax0ldmaB/YlwjPzqAqwN1mEnzXHmhGLbCCH1yaWxRPtXuu
         SZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1hw5pki8UDdO7CMhfZhMT3uXT6syvxquWurjnaKG4Bc=;
        b=HfitzdxOJF7gu4k5cCjsHDpQ5kqKZbl0eBU7Pd95Lcpi4VKREIQzAXntnZwKrmVrro
         yIeYS5d6gegONr8KnwQeOy+cURUchbZ4BpSbYWrLfC9smXMEDFYV9yEsUeKk/clfAbRC
         OHTSlAYnhS2GQSgiwCgTy7RxRmTmZqM0AdqMd3Z8gvIO2JuBvZ1DTY8Vui6CudDCuI0I
         gnW5zn0DOaveYtxlTOYOz25X8ZfKxXb0mvs7QpDttVnoZmE9d8jr2GTPjtppGys/mWrI
         2bgiO8NHw6XehUBrj5WtGJOMj5AJSNebP3jAhdMjKKw/Yc/Hsrcw0W52MXC6ZVSpbJUL
         N2EA==
X-Gm-Message-State: ANhLgQ1vJMm3mkaAKLmbXsz9dFU5jKrwFJvpSUkrzIQZXb1vo5RJroiv
        DHHiobkIKLjNiaDupHnDKCY=
X-Google-Smtp-Source: ADFU+vvqmNbjvn5USK2UTdgQ9q05LoyG/Q+OzW524uIb94avVyvVMlbFoAQEOeE+j/LCzdzxu2/EYw==
X-Received: by 2002:a17:90a:3349:: with SMTP id m67mr3431453pjb.175.1585140367682;
        Wed, 25 Mar 2020 05:46:07 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:46:07 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 7/9] perf record: Add --all-cgroups option
Date:   Wed, 25 Mar 2020 21:45:34 +0900
Message-Id: <20200325124536.2800725-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
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
index 7f4db7592467..eba9beec80e6 100644
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
index b766eb608b97..eb880efbce16 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1104,6 +1104,11 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
 
+	if (opts->record_cgroup) {
+		attr->cgroup = track && !perf_missing_features.cgroup;
+		perf_evsel__set_sample_bit(evsel, CGROUP);
+	}
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -1789,7 +1794,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_hw_idx &&
+        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
+		goto out_close;
+        } else if (!perf_missing_features.branch_hw_idx &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
 		perf_missing_features.branch_hw_idx = true;
 		pr_debug2("switching off branch HW index support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 33804740e2ca..53187c501ee8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -120,6 +120,7 @@ struct perf_missing_features {
 	bool bpf;
 	bool aux_output;
 	bool branch_hw_idx;
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
2.25.1.696.g5e7596f4ac-goog

