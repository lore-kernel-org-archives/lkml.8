Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B968206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgEHNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730521AbgEHNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF945C05BD43;
        Fri,  8 May 2020 06:05:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gr-0007j2-Jo; Fri, 08 May 2020 15:05:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B25691C0864;
        Fri,  8 May 2020 15:05:06 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:06 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Move sb_evlist to 'struct record'
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429131106.27974-2-acme@kernel.org>
References: <20200429131106.27974-2-acme@kernel.org>
MIME-Version: 1.0
Message-ID: <158894310663.8414.4035173088687971785.tip-bot2@tip-bot2>
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

Commit-ID:     bc477d7983e345262757568ec27be0395dc2fe73
Gitweb:        https://git.kernel.org/tip/bc477d7983e345262757568ec27be0395dc2fe73
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 24 Apr 2020 10:24:04 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:28 -03:00

perf record: Move sb_evlist to 'struct record'

Where state related to a 'perf record' session is grouped.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-2-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf3a6f7..a6d887d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -87,6 +87,7 @@ struct record {
 	struct auxtrace_record	*itr;
 	struct evlist	*evlist;
 	struct perf_session	*session;
+	struct evlist		*sb_evlist;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -1447,7 +1448,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
-	struct evlist *sb_evlist = NULL;
 	int fd;
 	float ratio = 0;
 
@@ -1582,9 +1582,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (!opts->no_bpf_event)
-		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
+		bpf_event__add_sb_event(&rec->sb_evlist, &session->header.env);
 
-	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
 	}
@@ -1858,7 +1858,7 @@ out_delete_session:
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(rec->sb_evlist);
 	return status;
 }
 
