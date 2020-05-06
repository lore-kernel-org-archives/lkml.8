Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D20C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416252068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778685;
	bh=MVonwGigjV0jPpVWJaH/x/eIAwOScbckew/swx8pnWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kn0bJeyGLmjSUnNAxLVSbgauHcfgFJ+/pIeiHsQCM92XDUTNIOIX5croM2RDtYdd2
	 CmWcvDALPkD28WkC5QWKa2IRe3ju6ASVOeuVEtweYRk2a6BR0LCP0Oe7gaowJHwSKf
	 GYpiGW6vHdbdDZTwfOP5JHcnC2jc6+aR7+eC36Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgEFPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbgEFPYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36EB221775;
        Wed,  6 May 2020 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778679;
        bh=MVonwGigjV0jPpVWJaH/x/eIAwOScbckew/swx8pnWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTUs+uKC9/gmtKgl4l7bxldLyLNhHLHRDc/u6bPEf126ovC5tTjkGN/r0RmpH/5Wr
         gEl1bYJBPrzccZTiz2mdw7xTRFLoJo0nSPkPitNwzByU/OzLSnD96CfQ9EwTSLxOGb
         zkzCFNq5yj5jAE+antFqZbMbbCXUqNfsJfZLZgQU=
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
Subject: [PATCH 31/91] perf record: Move side band evlist setup to separate routine
Date:   Wed,  6 May 2020 12:21:34 -0300
Message-Id: <20200506152234.21977-32-acme@kernel.org>
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

It is quite big by now, move that code to a separate
record__setup_sb_evlist() routine.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-9-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 71 +++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bb5b4d2fc32b..cfb9a69a42dd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1446,6 +1446,44 @@ static int record__process_signal_event(union perf_event *event __maybe_unused,
 	return 0;
 }
 
+static int record__setup_sb_evlist(struct record *rec)
+{
+	struct record_opts *opts = &rec->opts;
+
+	if (rec->sb_evlist != NULL) {
+		/*
+		 * We get here if --switch-output-event populated the
+		 * sb_evlist, so associate a callback that will send a SIGUSR2
+		 * to the main thread.
+		 */
+		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
+		rec->thread_id = pthread_self();
+	}
+
+	if (!opts->no_bpf_event) {
+		if (rec->sb_evlist == NULL) {
+			rec->sb_evlist = evlist__new();
+
+			if (rec->sb_evlist == NULL) {
+				pr_err("Couldn't create side band evlist.\n.");
+				return -1;
+			}
+		}
+
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			return -1;
+		}
+	}
+
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1590,36 +1628,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (rec->sb_evlist != NULL) {
-		/*
-		 * We get here if --switch-output-event populated the
-		 * sb_evlist, so associate a callback that will send a SIGUSR2
-		 * to the main thread.
-		 */
-		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
-		rec->thread_id = pthread_self();
-	}
-
-	if (!opts->no_bpf_event) {
-		if (rec->sb_evlist == NULL) {
-			rec->sb_evlist = evlist__new();
-
-			if (rec->sb_evlist == NULL) {
-				pr_err("Couldn't create side band evlist.\n.");
-				goto out_child;
-			}
-		}
-
-		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
-			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
-			goto out_child;
-		}
-	}
-
-	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
-		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
-		opts->no_bpf_event = true;
-	}
+	err = record__setup_sb_evlist(rec);
+	if (err)
+		goto out_child;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
-- 
2.21.1

