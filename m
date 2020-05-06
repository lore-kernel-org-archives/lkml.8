Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8677C214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778897;
	bh=zLdhcspapBUGzeJ1MYD7n/7vKJkmWMiKes8X3/WeI30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FF3jdDaTD3kRWG4UK5M27yOTjSHMFFwiHejd1HptEtCGp6hMyrdx5kzuLnHqnvmoy
	 IRDV4FaW89ztI9FHqDmFDFznm/YX1SxVHhErDtpzzYlRafl6BUw9T+2vqEqg1mmaoR
	 v9bjL+SJ5C5i8ycBxYhPJcY48pDvAq7kWPH/JIj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEFP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbgEFP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3930020A8B;
        Wed,  6 May 2020 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778810;
        bh=zLdhcspapBUGzeJ1MYD7n/7vKJkmWMiKes8X3/WeI30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UA69WWSQvMxKaoBav4w9pqkUz0QQ+hWupt3zzRbf7wGEzadG1lJNPm688t18JCSsD
         WSxXbZwqodXp1pO1cxK9DN40jNcEZtOmonP5dCUtY2G3zNb8chng2WrO4MCziSGh4b
         0SeVpkw8yTrECDdk6c66vqr2OyFpI9U07yOohScM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 72/91] perf evsel: Rename perf_evsel__has*() to evsel__has*()
Date:   Wed,  6 May 2020 12:22:15 -0300
Message-Id: <20200506152234.21977-73-acme@kernel.org>
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

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c   | 2 +-
 tools/perf/util/evsel.h   | 4 ++--
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/session.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b63d9eebe42f..909e993b4dcd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2159,7 +2159,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			return -EFAULT;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
-		if (perf_evsel__has_branch_hw_idx(evsel))
+		if (evsel__has_branch_hw_idx(evsel))
 			sz += sizeof(u64);
 		else
 			data->no_hw_idx = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a84a4f6bcf31..101cfff647c7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -372,12 +372,12 @@ for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
-static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
+static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
-static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
+static inline bool evsel__has_branch_hw_idx(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5ac32cabe4e6..da630e9339d3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2618,7 +2618,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain)
 		chain_nr = chain->nr;
 
-	if (perf_evsel__has_branch_callstack(evsel)) {
+	if (evsel__has_branch_callstack(evsel)) {
 		struct perf_env *env = perf_evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7f7d3a1989fd..c11d89e0ee55 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1059,7 +1059,7 @@ static void callchain__printf(struct evsel *evsel,
 	unsigned int i;
 	struct ip_callchain *callchain = sample->callchain;
 
-	if (perf_evsel__has_branch_callstack(evsel))
+	if (evsel__has_branch_callstack(evsel))
 		callchain__lbr_callstack_printf(sample);
 
 	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
@@ -1244,7 +1244,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		callchain__printf(evsel, sample);
 
 	if (evsel__has_br_stack(evsel))
-		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
+		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample);
-- 
2.21.1

