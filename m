Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3029C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A754324970
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgEHNFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730507AbgEHNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA5C05BD43;
        Fri,  8 May 2020 06:05:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gr-0007e1-34; Fri, 08 May 2020 15:05:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E6671C085A;
        Fri,  8 May 2020 15:05:03 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Move side band evlist setup to separate routine
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429131106.27974-9-acme@kernel.org>
References: <20200429131106.27974-9-acme@kernel.org>
MIME-Version: 1.0
Message-ID: <158894310346.8414.8485365390466335042.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     23cbb41c939a09a4b51eabacdb1f68af210c084d
Gitweb:        https://git.kernel.org/tip/23cbb41c939a09a4b51eabacdb1f68af210c084d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 28 Apr 2020 14:58:29 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf record: Move side band evlist setup to separate routine

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
 tools/perf/builtin-record.c | 71 ++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bb5b4d2..cfb9a69 100644
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
