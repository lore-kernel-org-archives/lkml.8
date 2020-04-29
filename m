Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C84CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1846E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588165907;
	bh=stuUOuISV3CkSo5BnYCB/B2TBItvawvwtYrGJ0F5Wc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBj5lQRkaviW/0U5D44uFWyimRLxTVkp1GQfGuKp4jtMkIFzPQT2+0vaS+HX9dhqI
	 q9NqjYnRB1OjXF/ZICvZAz26o5VSF0LqKlvsNcuTTbbfFDr/tfanZcUGBoocmXvVja
	 YZq6y3PveFYN1pqfsuYWHACoPf4fcVBNIuXNBkjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgD2NLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgD2NLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:11:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7949F22244;
        Wed, 29 Apr 2020 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165897;
        bh=stuUOuISV3CkSo5BnYCB/B2TBItvawvwtYrGJ0F5Wc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTrcMGBdaLAIWb+LFzdS6vs2ukeEqyR3u84Ib+tgYUJY+2WZcD6tW1ub6JDM4BwfZ
         P0uc+7UUFtkYLoj5akTgYG8ShG/2rRdBD7bl6InnFEfJx54BDoKwS/S5ukR77mDVFQ
         UKFvumVuur6MB+AgNaHnyekmXYXbzHcOTS3Ssu70=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 8/8] perf record: Move side band evlist setup to separate routine
Date:   Wed, 29 Apr 2020 10:11:06 -0300
Message-Id: <20200429131106.27974-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
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
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200428180518.GF5460@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 71 +++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7a6a89972691..bb3d30616bf3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1445,6 +1445,44 @@ static int record__process_signal_event(union perf_event *event __maybe_unused,
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
@@ -1589,36 +1627,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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

