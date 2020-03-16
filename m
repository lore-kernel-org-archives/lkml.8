Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04947C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82C205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDSPa+99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgCPEOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:14:37 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45546 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgCPEOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:14:37 -0400
Received: by mail-pl1-f202.google.com with SMTP id s6so9461908plp.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8nA2hScnF6v2G0I1bnw6Oj3DivH5BnpkZl+mne8j+kA=;
        b=mDSPa+99rw2JNjwNjr26acFFK1NJzZRajAx1Lm9aNgJq2lvXu5mNLw9qFWlShEJfJq
         fr+nR3uxre7PdoWj+nyPCHjH01Lrfjcb2yGd+2vbyouGvINQRY4gUkD36YmYjHk8moHZ
         WE8EnCK75nN+fQdwDWsgkeieS1PeQnuIm32Oey6etPYPpy2S50dcGLQUuK6Vr26up6p/
         VJu8+oGPOH+3AWrXdvQoWxyJTwrtUy9pQ3c0qttC+bpqi7c+IyQVn1a+iZwp+fONGMC4
         SZkrL1Iv7b1bv/6XvZli9pfxEdZ94CZ8Km6pBspTFjEE/Yx5w9WX0Bo9fvx83jlxEUoS
         LAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8nA2hScnF6v2G0I1bnw6Oj3DivH5BnpkZl+mne8j+kA=;
        b=W2w5RN2W2BaDfDq7rfsmSByDOn2ESrTKLToc9nL06PBFZoGtFp0tLSAK+ccPOIhwZG
         j45Vc0pSfs0g/D4/qgr+p+pvdImU03/OcHZm1Zp8hOfw2Mnnh0F1IEx9wGanpDzIEsym
         i81rOD4oBn/wK7IgC1OL5T9KO4CbnkkMYOkv9UiiAaCM33u+q2JyzX7mNvbuLFlvevhw
         6b4rbJW8pPbzEPV/Qctg+i69NOMhpYUGMLPWQF3tnftGwQglY/C/BorJVOXUFQo3xU3N
         LIQKj2+KKiLbYBynx6XlArd23irfXx94pTL7a/SPxlPpTur0Ba+I/abHkx6n6x6JJstd
         FqFg==
X-Gm-Message-State: ANhLgQ0Q65/6xWW8Ybr517W6XNxHeGJ7kU+1zeIwNlQw5k9PoCSZSq5W
        o4ZGcyf3GWn34qvuBfUm+sZdMgSI5x60
X-Google-Smtp-Source: ADFU+vt6yXQTbYWIKiMlO0L+FzEhOR/V+hFczzaycNV4sxjMKth8glR6Azdh13s6nmbVLuk+VhB0WkfM7arL
X-Received: by 2002:a17:90a:7309:: with SMTP id m9mr22987108pjk.52.1584332075593;
 Sun, 15 Mar 2020 21:14:35 -0700 (PDT)
Date:   Sun, 15 Mar 2020 21:14:31 -0700
Message-Id: <20200316041431.19607-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] perf parse-events: fix memory leaks found on parse_events
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

Memory leaks found by applying LLVM's libfuzzer on the parse_events
function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c        | 2 ++
 tools/perf/util/parse-events.c | 2 ++
 tools/perf/util/parse-events.y | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5b9f2ca50591..6485d1438f75 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -125,8 +125,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->cpus);
+	perf_cpu_map__put(evlist->all_cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a14995835d85..997862224292 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
 			list_del_init(&pos->list);
+			if (pos->free_str)
+				free(pos->val.str);
 			free(pos);
 		}
 		return -EINVAL;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 94f8bcd83582..8212cc771667 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 
 	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
 		list_del_init(&evsel->core.node);
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 	free(list_evsel);
 }
@@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
 	}
 	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
+	free(pattern);
 	free($1);
 	$$ = list;
 #undef CLEANUP_YYABORT
-- 
2.25.1.481.gfbce0eb801-goog

