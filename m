Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE3C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6391C20768
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwhlomgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCSCbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:31:08 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33211 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:31:08 -0400
Received: by mail-pl1-f202.google.com with SMTP id b10so479356pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0M5yDwMnWT3eGZaAP87ZabJ+9eP1uwNT7JZCCK6lZ+Y=;
        b=PwhlomgHR1+g2Hz328zTELcv/E8xMN4kqTsk1VLMjmk75iZK+oIKmEK7MJahYHG5BP
         kcPC9l41zCjZ341/knu7ZZw5WBtcev9Ml3kfmcvwY9VKthfE+buc7N50eI6UQTffu46G
         PnCl7GJneUqZIaujSqeFrYK1hpjkFbTh+66qqeDqgAvpehiayerXDZ8li+XJTCzPfaPj
         2eLhBAwd9ebNTtB2F7t79w8lvl/DJriXaIh7BV/2g71ArBBAQ3wDMJjzi6k6XAA7/lP3
         urAkVMH1vSGSNOJ9ZIFhRbnM1KyIC5jO2l7LhSSdmNLlzA+aT4RahJNmqWJ8g03hp6OB
         G8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0M5yDwMnWT3eGZaAP87ZabJ+9eP1uwNT7JZCCK6lZ+Y=;
        b=sL4P/kheEQwT5736bvM5kkQowFZq4W9jduxV/KbvSxFS+wKyMckKTPquUXM++1FKPZ
         XuSS8Ykp1I2fklmWPXo3d/JCIUY+Kl6bsKjs0OHFkL8b2+B3omUKP171/aBYLnT6gduk
         zXZqjhlMM9w+7mGLdNLQBRD7n/NO+a4RlSp/2f7bT/kmI94DNgPtfcq38om5KFSqyZRC
         UDGNWNcWoy/hphQpeACsK8xmvzNt3KXAzovbL9AVt+/8kaLCHx38e5OnZlxfzqAXaQ42
         S7/b1pk5CLBIyWqaIK9xiVixM6bZXZ72uqWjZY7pCBUiyq+a3zd0cQep/Dy+9IKTRwr8
         UWBg==
X-Gm-Message-State: ANhLgQ3VG0yjs6O897X9S+M1LJbBOyVXC66dnxXdbbs4OWdXiyK7IHkC
        ZEiRIrv6kGfPOnYJk2BqiXs9w3EN/svf
X-Google-Smtp-Source: ADFU+vvuKQO4fHtyUgZCAFTgWocS2aZxTI5FzOLz1r8YgDx7IcsM5NaTIMynat5PaF6uan/j14po6BysyzlF
X-Received: by 2002:a63:7359:: with SMTP id d25mr881791pgn.2.1584585066575;
 Wed, 18 Mar 2020 19:31:06 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:31:00 -0700
Message-Id: <20200319023101.82458-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 1/2] perf parse-events: fix memory leaks found on parse_events
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
 tools/perf/util/parse-events.c | 2 ++
 tools/perf/util/parse-events.y | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 593b6b03785d..1e0bec5c0846 100644
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
2.25.1.696.g5e7596f4ac-goog

