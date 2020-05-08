Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6B5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F71424970
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgEHNJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730483AbgEHNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB8C05BD43;
        Fri,  8 May 2020 06:05:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gj-0007XI-AU; Fri, 08 May 2020 15:05:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 37D5C1C0823;
        Fri,  8 May 2020 15:04:58 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:58 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Add support for synthesized branch stack
 sample type
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-6-adrian.hunter@intel.com>
References: <20200429150751.12570-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309814.8414.14429126818171355994.tip-bot2@tip-bot2>
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

Commit-ID:     6cd2cbfc6865589c64ac37ec48937e93725622f1
Gitweb:        https://git.kernel.org/tip/6cd2cbfc6865589c64ac37ec48937e93725622f1
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:47 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf evsel: Add support for synthesized branch stack sample type

Allow for a synthesized branch stack to be added to samples. As with
synthesized call chains, the sample type cannot be changed because it is
needed to continue to parse events. So add and use helper function
evsel__has_br_stack() to indicate a branch stack, whether original or
synthesized.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h   | 10 ++++++++++
 tools/perf/util/session.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a463bc6..bf999e3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -417,6 +417,16 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline bool evsel__has_br_stack(const struct evsel *evsel)
+{
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded branch
+	 * stack or a branch stack synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK ||
+	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5..2b5a08a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1243,7 +1243,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+	if (evsel__has_br_stack(evsel))
 		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
