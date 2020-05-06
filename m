Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC21BC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EC520CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778659;
	bh=J2eKfGcJ625lz3TJzXVprS9ZeeY4NXg6IrpB4wOTLdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHHummz2FhbMmbqOit4l+EjsSg36/KqiN00h+pJnMhShC+qQn69HA2s/GaUTmcUJJ
	 3rtlYOvEQy6SZNJ8YC2YK/OAmYfvtqzucBrQJIL71toU8H3yhuLAqW808CWWC4xsoL
	 7fbKZbIMfm+HBIkh2lxtErRQbvriiCFRUzZr22Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgEFPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgEFPYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E00421775;
        Wed,  6 May 2020 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778656;
        bh=J2eKfGcJ625lz3TJzXVprS9ZeeY4NXg6IrpB4wOTLdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4NLrOu5pVhqjsPWUmdfSjgnEEbkkh/feXRcxSceVedaV/x9NMGWE3rOQJs2CvYjl
         xgtmQ9iODBIEZn++dCS5kJk+/hM1GFFkt57OJ8onBU1m0Wb+F1AwoGt2eL6GmUHeKp
         6gupCh/uHgKS4sSEQS/qxNI4WvSU4CFIXZJfo1rc=
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
Subject: [PATCH 23/91] perf record: Move sb_evlist to 'struct record'
Date:   Wed,  6 May 2020 12:21:26 -0300
Message-Id: <20200506152234.21977-24-acme@kernel.org>
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
index bf3a6f7df463..a6d887d97ceb 100644
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
@@ -1858,7 +1858,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(rec->sb_evlist);
 	return status;
 }
 
-- 
2.21.1

