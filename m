Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327BDC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002DF20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPlIfRpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgAQFzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:55:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAQFy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:54:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so9405821plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cJRwCEmirG6Qk7nYW+0FE/1CNK6//qT3tTI8E5PNpMA=;
        b=lPlIfRpToRKgwDkPLokcX3NialrfQAvg9asfk1gs2Zx1kn3jO2wHdJLtP7kOjDx1vo
         DzcMnLR+5lt3t6kDZfMBPC+btbYiD3Zt+gHLYr+/iFxh43hpbFKFRNG/HJyYDyNZ1jGL
         S+z0oRu2dis/qFoPJ2R/s1LD81i8c4eVvgMdL7EKOJtMaE6mx/b20uo4sSiGTj9ZWAf1
         L1TzFtdMZ52szOnTUbuEvcmycdR/Bh9qyz4ntN3GmlyaxrQfCtFdV7jnAcOcy9lW+n/C
         SH/21uf//u7pbhOxPgcOxzPk4UwBAFacNesNvX9EYlwe3BCdjcEvxn896i33hVxP2Feu
         bFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cJRwCEmirG6Qk7nYW+0FE/1CNK6//qT3tTI8E5PNpMA=;
        b=Lq2WfJSNIv36IuxETsY8jcOvX9dOZVaNbp5xSaivzxMHo4gIJRk411wdgKRfM2mj0D
         mMLa906o3bK3G/BsbxSHgvSg3SeNiXn/KxAq37KYVRxZKTuxiNfqwAHWOv+5WpglbJUJ
         8cq2QOCcWzDY8kOsBmjts0s60acT1ueJkr65ycRCiZybBLhJi2sDPK8hvQqFj96xjewQ
         EjdMx0o2LE57OeB1Qdj0XTdung4fB4vLCLREH0ah/U8vdD91iF+PNqm+4bomZ+70W9nU
         ulSvs5y1UigGFdlmjA/vM3Pb/n+S66n6F/c2QhwsDxw439FtiCKjB35RFG8tmI2iG4hs
         ItNQ==
X-Gm-Message-State: APjAAAUzh26OArWdgcW98QGYPwRtTlxWCgABXnmT2oI4ylTYIL9yzkCD
        Bgr28E7/27piaOZVtAnrlqTpcw==
X-Google-Smtp-Source: APXvYqyeWf6hLgPEdGlQtK3uj/y/j+bNPfn5Psp4slZjMK15FqcEaoQ97V8/BD11DRWuoBQSV3NTlw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr36778643pls.285.1579240499250;
        Thu, 16 Jan 2020 21:54:59 -0800 (PST)
Received: from localhost.localdomain (li96-55.members.linode.com. [74.207.254.55])
        by smtp.gmail.com with ESMTPSA id u7sm27578364pfh.128.2020.01.16.21.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 21:54:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 2/2] perf parse: Copy string to perf_evsel_config_term
Date:   Fri, 17 Jan 2020 13:52:51 +0800
Message-Id: <20200117055251.24058-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117055251.24058-1-leo.yan@linaro.org>
References: <20200117055251.24058-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf with CoreSight fails to record trace data with command:

  perf record -e cs_etm/@tmc_etr0/u --per-thread ls
  failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
  directory)/perf/

This failure is root caused with the commit 1dc925568f01 ("perf
parse: Add a deep delete for parse event terms").

The log shows, cs_etm fails to parse the sink attribution; cs_etm event
relies on the event configuration to pass sink name, but the event
specific configuration data cannot be passed properly with flow:

  get_config_terms()
    ADD_CONFIG_TERM(DRV_CFG, term->val.str);
      __t->val.str = term->val.str;
        `> __t->val.str is assigned to term->val.str;

  parse_events_terms__purge()
    parse_events_term__delete()
      zfree(&term->val.str);
        `> term->val.str is freed and assigned to NULL pointer;

  cs_etm_set_sink_attr()
    sink = __t->val.str;
      `> sink string has been freed.

To fix this issue, in the function get_config_terms(), this patch
changes to use strdup() for allocation a new duplicate string rather
than directly assignment string pointer.

This patch addes a new field 'free_str' in the data structure
perf_evsel_config_term; 'free_str' is set to true when the union is used
as a string pointer; thus it can tell perf_evsel__free_config_terms() to
free the string.

Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c        | 2 ++
 tools/perf/util/evsel_config.h | 1 +
 tools/perf/util/parse-events.c | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 549abd43816f..6fe9e28180e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
 		list_del_init(&term->list);
+		if (term->free_str)
+			free(term->val.str);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index b4a65201e4f7..e026ab67b008 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -32,6 +32,7 @@ enum evsel_term_type {
 struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
+	bool		      free_str;
 	union {
 		u64	      period;
 		u64	      freq;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f59f3c8da473..c01ba6f8fdad 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1240,7 +1240,12 @@ do {								\
 #define ADD_CONFIG_TERM_STR(__type, __val)			\
 do {								\
 	ADD_CONFIG_TERM(__type);				\
-	__t->val.str = __val;					\
+	__t->val.str = strdup(__val);				\
+	if (!__t->val.str) {					\
+		zfree(&__t);					\
+		return -ENOMEM;					\
+	}							\
+	__t->free_str = true;					\
 } while (0)
 
 	struct parse_events_term *term;
-- 
2.17.1

