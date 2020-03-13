Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B16E2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dle5S5K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCMXC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:02:57 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54172 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCMXC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:02:56 -0400
Received: by mail-pg1-f202.google.com with SMTP id c33so6962337pgl.20
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u6W8EPudCxoS1C+Gxr8h5SKLukwTLV40TMQzqhE2icg=;
        b=Dle5S5K+y36+frHurRqiaRO5zBtsrs1pm49+PtG4VbQFQlHXmMdPjxNDUGCNQJkee8
         NhMpB8nIkBkQ5Sh9ptwLz1epP6A6dNKVsNiG9S8W506AZ9Bq849CsHouSry6093kVuC6
         M9em74UD4HUQz6rfZtamAsPXNV3qCptA8bTOfkCkWbLxpkm2NJIiqEd9gMp9bBTYuC8O
         w0YuoCMNKx7AT0P536RAKPUpoZ+TyUN6l2/8odjxqIU2rFhfi5IvqVw6PoeRAzTwGUew
         Uv5q5ueNqDouvY/j/xcFjM3ckvU+GDDQ35tExT3Q6IEDOWSILXrrQps5XMfd2Ik++ADm
         oV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u6W8EPudCxoS1C+Gxr8h5SKLukwTLV40TMQzqhE2icg=;
        b=SKVyBnHcKCJtHX2jnp39BmErd6mmq3cqovM48tRVrNk3pw8zd/yiKhjK5MtYeTXfxx
         M7TO4GNwMDe0sB5KE36OejC5s4IFEHfc7qlbZXRw+kLEwo+ps17meiVrbhAPyk6P7LZs
         PkyYWWQxzczE6nKH2J/5shkt1n237lmDogdhiuyz8ooitnBTBcAbdEFYHnbljzqnMUl0
         FaE533rhe0VjbBFDb+5ydR1DuCSywHD4A/E4QJAY9uBF9sgr0HKCmVvju84jRg4JNTLO
         +NsSf8R3c5ldXKNmb2U+VPEvJOEdbMLFSOXQ/SY85ijGicXlzBbVz73cAclAiEzvSltq
         BJCQ==
X-Gm-Message-State: ANhLgQ2d5/XU5euMbMzpTTwdOvNZ2WPIiDe/aUt9EvEw3aluVaIcc7jS
        ftSP326SMtmhnbLkl7AawljAmwdFJodP
X-Google-Smtp-Source: ADFU+vuy3ZEDEBn9mrZ+kHWul/1Viuc3dqdBxNUlcbugY+w11L+dRnHCC/nchc62Xd6BCHEwfWay7wPNnPqg
X-Received: by 2002:a65:5306:: with SMTP id m6mr15467704pgq.5.1584140573528;
 Fri, 13 Mar 2020 16:02:53 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:02:49 -0700
Message-Id: <20200313230249.78825-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] perf parse-events: fix 3 use after frees
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reproducible with a clang asan build and then running perf test in
particular 'Parse event definition strings'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a14995835d85..593b6b03785d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
 				    auto_merge_stats, NULL);
 		if (evsel) {
-			evsel->pmu_name = name;
+			evsel->pmu_name = name ? strdup(name) : NULL;
 			evsel->use_uncore_alias = use_uncore_alias;
 			return 0;
 		} else {
@@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->snapshot = info.snapshot;
 		evsel->metric_expr = info.metric_expr;
 		evsel->metric_name = info.metric_name;
-		evsel->pmu_name = name;
+		evsel->pmu_name = name ? strdup(name) : NULL;
 		evsel->use_uncore_alias = use_uncore_alias;
 		evsel->percore = config_term_percore(&evsel->config_terms);
 	}
@@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, head,
 							  true, true)) {
-					pr_debug("%s -> %s/%s/\n", config,
+					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
 				}
-- 
2.25.1.481.gfbce0eb801-goog

