Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D192071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383804;
	bh=L4fCkw4wcUNDKM1z6zcR2gZPg/nQnBY5Exx8Dq3WD5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ip5fWntMmUhyyuh9egVHgKw66XPpUqGfMGbCEGvKln+hqEcLfDJ8ny2IR++dWNSRC
	 QCeEbc05Kg9CXv9LYs6oUi0L1Kt7r832uksmLOYU+umofwUfojUFsub9DCNDarghO2
	 XHuhQMRZZa4vhBiwfZ7a51Ymt1pqWjyyIgD3DKgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgDTL4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgDTL4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DD82223D;
        Mon, 20 Apr 2020 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383775;
        bh=L4fCkw4wcUNDKM1z6zcR2gZPg/nQnBY5Exx8Dq3WD5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7t/Qlawv7s6t0QzwrWtdeOdbHM7LXBvkHfrCdfeZty9S/IDb5INuw2Dbb5BGz2ju
         ex093KLmWnymhmo1R7jZ5UpUx6LoAphfNb6BFM4mfs8FwH9W2swV+n82lpgODh54vF
         H/xDSk6wowx2lNgoo2L8qOpARnlmRfoyvCfQ0wIY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/60] perf evlist: Move leader-sampling configuration
Date:   Mon, 20 Apr 2020 08:52:54 -0300
Message-Id: <20200420115316.18781-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move leader-sampling configuration in preparation for adding support for
leader sampling with AUX area events.

Committer notes:

It only makes sense when configuring an evsel that is part of an evlist,
so the only case where it is called outside perf_evlist__config(), in
some 'perf test' entry, is safe, and even there we should just use
perf_evlist__config(), but since in that case we have just one evsel in
the evlist, it is equivalent.

Also fixed up this problem:

  util/record.c: In function ‘perf_evlist__config’:
  util/record.c:223:3: error: too many arguments to function ‘perf_evsel__config_leader_sampling’
    223 |   perf_evsel__config_leader_sampling(evsel, evlist);
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/record.c:170:13: note: declared here
    170 | static void perf_evsel__config_leader_sampling(struct evsel *evsel)
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 19 -------------------
 tools/perf/util/record.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f320adaf1326..8300e8c7aea8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1002,25 +1002,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		}
 	}
 
-	/*
-	 * Disable sampling for all group members other
-	 * than leader in case leader 'leads' the sampling.
-	 */
-	if ((leader != evsel) && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
-
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
-
 	if (opts->no_samples)
 		attr->sample_freq = 0;
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 7def66168503..8870ae451cac 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -167,6 +167,31 @@ bool perf_can_aux_sample(void)
 	return true;
 }
 
+static void perf_evsel__config_leader_sampling(struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel *leader = evsel->leader;
+
+	/*
+	 * Disable sampling for all group members other
+	 * than leader in case leader 'leads' the sampling.
+	 */
+	if (leader != evsel && leader->sample_read) {
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->core.attr.sample_type;
+	}
+}
+
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
@@ -193,6 +218,10 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			evsel->core.attr.comm_exec = 1;
 	}
 
+	/* Configure leader sampling here now that the sample type is known */
+	evlist__for_each_entry(evlist, evsel)
+		perf_evsel__config_leader_sampling(evsel);
+
 	if (opts->full_auxtrace) {
 		/*
 		 * Need to be able to synthesize and parse selected events with
-- 
2.21.1

