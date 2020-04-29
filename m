Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995FC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F7021D92
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588165879;
	bh=wTKfMv1L2Q06PbZw4nQc40uhrGNOSNkVDDoDn5nXFQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sm1PeRFPTwDrpc6QEmKr9KRR/YhteBt3jHXx1+r59BR73/wF8K+LfPYhwOpgx3jUa
	 venkYvwwksmBrLV+OK/jqES3zbf7qhqakaqSJTjjb+9NzCKaOughr1oR1I3sWUZKE3
	 6X3NaUAicoBgZR7oqHHWHF41SVI6Pd8DJC4QGM+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgD2NLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgD2NLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:11:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16CA221EC;
        Wed, 29 Apr 2020 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165876;
        bh=wTKfMv1L2Q06PbZw4nQc40uhrGNOSNkVDDoDn5nXFQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4EPzugvtr3/SIsY7UbLSElKB1Z9TgrhIV4IVmcKCipXDQfHFZfs2K8om5WFNa+bT
         mDauxE7cPLv2MrmjZBgtWit+pQNNhGguS0NTKDMsKU/VKYSQovuqZAdZbJDA5l0Ema
         Yy6kY7YN0buIdeWnigiWYOGwS4P/YGzwn8HrhzP8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 1/8] perf record: Move sb_evlist to 'struct record'
Date:   Wed, 29 Apr 2020 10:10:59 -0300
Message-Id: <20200429131106.27974-2-acme@kernel.org>
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

Where state related to a 'perf record' session is grouped.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200427211935.25789-2-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2e8011f179f2..2348c4205e59 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -86,6 +86,7 @@ struct record {
 	struct auxtrace_record	*itr;
 	struct evlist	*evlist;
 	struct perf_session	*session;
+	struct evlist		*sb_evlist;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -1446,7 +1447,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
-	struct evlist *sb_evlist = NULL;
 	int fd;
 	float ratio = 0;
 
@@ -1581,9 +1581,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (!opts->no_bpf_event)
-		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
+		bpf_event__add_sb_event(&rec->sb_evlist, &session->header.env);
 
-	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
 	}
@@ -1857,7 +1857,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(rec->sb_evlist);
 	return status;
 }
 
-- 
2.21.1

