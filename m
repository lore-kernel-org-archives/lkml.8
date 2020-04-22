Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4559C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B1120CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgDVMRm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgDVMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E6C03C1AD;
        Wed, 22 Apr 2020 05:17:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJf-0007kT-JW; Wed, 22 Apr 2020 14:17:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 114601C02FC;
        Wed, 22 Apr 2020 14:17:21 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:20 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Move leader-sampling configuration
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-14-adrian.hunter@intel.com>
References: <20200401101613.6201-14-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784068.28353.2670739462496950321.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5f34278867b78bed77dcbd723056244e9bfc12ef
Gitweb:        https://git.kernel.org/tip/5f34278867b78bed77dcbd723056244e9bfc12ef
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:10 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf evlist: Move leader-sampling configuration

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
index f320ada..8300e8c 100644
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
index 7def661..8870ae4 100644
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
