Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8EB20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778957;
	bh=P3BVdaUZubBAxh7LQN52hM6ONtdBKHbQXhlgcqKF8Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRtUSFPGhAlpzaxLSahwPX3PMIqAE8wLLwxuM0Zn9YTWGIB79IhZM4geqvw9yELa+
	 XS1LIYTbZvRtt6BdVL2BVlR0hZ668bsJ7kD0So5BqE+TgurngWIzBYhEEsY7J6gkpe
	 0ZUum2KX2bax2bQtV9em/8gAmL7+ZHPm6/eRMVGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgEFPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbgEFPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20E821744;
        Wed,  6 May 2020 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778720;
        bh=P3BVdaUZubBAxh7LQN52hM6ONtdBKHbQXhlgcqKF8Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wdvw3Nda8jheB9fhINRGw/SAmRhAz2vn4EP3PmFR3RiAi5JFJaAGMs6vhPYVHdwtY
         M3Ck79wCUmNNAoFFxUhlqhupHk3k9rftEqTlEQnXoSEemcuWERVJnkA37Zf8MFpl5R
         fkjnXmke1ipoTPAMzhz3YuflrTDs66vw/wMP3ECI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 43/91] perf evsel: Add support for synthesized branch stack sample type
Date:   Wed,  6 May 2020 12:21:46 -0300
Message-Id: <20200506152234.21977-44-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
index a463bc65b001..bf999e3c50c7 100644
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
index 0b0bfe5bef17..2b5a08a92ce5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1243,7 +1243,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+	if (evsel__has_br_stack(evsel))
 		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-- 
2.21.1

