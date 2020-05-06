Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D520C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5AC2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778663;
	bh=WHEGfYUuRQjnMU6sPLWGhRcy5Indzl5Q+tyL/fQpl+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P5Rq4jSjKyzDIO2HDZz+hgwWLx1r8Jx3YGJZX2duS4AyYapabxU0QjEbr7eemdKWa
	 Eia6IEjApsuGNXXpOEFjqvYe7o6BlDiu8BzqRTbStVP9VSMJtt/wATNiNoKXtHb87R
	 JPKCFx9VUb1sUOF2h4O6iZgtr0B0/6umX+9ebwNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgEFPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgEFPYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EE821841;
        Wed,  6 May 2020 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778659;
        bh=WHEGfYUuRQjnMU6sPLWGhRcy5Indzl5Q+tyL/fQpl+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFz6nbjpYTcTc1UQ3TtCCOfkugrMXVykgpAx0KpCI+CTcTBQ3Rugyr7VtvJmzNwoo
         Z04EjKQTlL3R26lsFvSM1so3rw+MvrriuxbHnlk8KbM/qH4/q94z5FvWc0sVomWUI9
         iaW0JLp5X/Avxjw/JhPOwhdOgX7XoA4fSdkoD9NA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 24/91] perf top: Move sb_evlist to 'struct perf_top'
Date:   Wed,  6 May 2020 12:21:27 -0300
Message-Id: <20200506152234.21977-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where state related to a 'perf top' session is grouped.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-3-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 7 +++----
 tools/perf/util/top.h    | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6b067a5ba1d5..70e1c732db6a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1580,7 +1580,6 @@ int cmd_top(int argc, const char **argv)
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-	struct evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1744,9 +1743,9 @@ int cmd_top(int argc, const char **argv)
 	}
 
 	if (!top.record_opts.no_bpf_event)
-		bpf_event__add_sb_event(&sb_evlist, &perf_env);
+		bpf_event__add_sb_event(&top.sb_evlist, &perf_env);
 
-	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
+	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
 	}
@@ -1754,7 +1753,7 @@ int cmd_top(int argc, const char **argv)
 	status = __cmd_top(&top);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(top.sb_evlist);
 
 out_delete_evlist:
 	evlist__delete(top.evlist);
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 45dc84ddff37..ff8391208ecd 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -18,7 +18,7 @@ struct perf_session;
 
 struct perf_top {
 	struct perf_tool   tool;
-	struct evlist *evlist;
+	struct evlist *evlist, *sb_evlist;
 	struct record_opts record_opts;
 	struct annotation_options annotation_opts;
 	struct evswitch	   evswitch;
-- 
2.21.1

