Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D2C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6BD2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfmBwyq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCSCbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:31:12 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47307 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSCbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:31:11 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so450400ply.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q6qKeMViIFe6EBqVnaB/dOU7RJkl3dVROSC+c5uk8Z0=;
        b=vfmBwyq9fjU9JbgvPE0u2IhjHNme9Ilvu2k+gzRdVZCHQgVkESrdgJqpXIuKFVYgBj
         iVw0o8B+qgHwkwI9zkPQCTWbszaTUbMcm0gcyuDOgO3XtXRBLRzEGV/S6q/mA+j7auUe
         SQOSqMKiAsT6JPwGC7JsAcjXDCT+1kl5weAf54CW71bhYTkjYiLOXiDDYESwthEY92z7
         R7Q54ecQClizRcIbh8zO4VW/xM+gfiEB5ZFTN5kw9tUn5vlJnzkWvQY4vljZvKKm9ua3
         KJ17KA76Hdf6l7HKDibwfKJAUCkrcoE6idvPwGEvUf/hLIqqmxiwLvZo9QIO0/6lsQQs
         xhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q6qKeMViIFe6EBqVnaB/dOU7RJkl3dVROSC+c5uk8Z0=;
        b=WpdJ4ZYF678e+d0sTd+uf0Jxr0bo2kKoV8NHwK8OeC+W8k0cinJ6x86P4ZPJPswTnt
         BfRylwQ99MlEBgnYUrUJ6oP51sNi6gBM01Og30Kso5L7w8+96vh36a/A91PpTIPiLDb9
         hexCyZDoG4D29CbYMilGhT34H0L2Q3gRzqfmPBuM865G1kAHGqcInr76c+f/MFzSrIp5
         l9wavza+nHHWbMcFDg2Tew85AgUJmMmYSmFsTX914K3qdkFOAbaiWSy5beRRceJg7UnK
         L0U8+4QNFUVlA045pyQ2SS3eJs4rwM7V6fq4nU7eIhuze2u9uNFznrBXPtw/kuSX6cIX
         ybJg==
X-Gm-Message-State: ANhLgQ1OAuFtR6SQGvknZFiaU/YWTNvE8/j4UJne4mA5IQ9zjeLJcWUC
        CJxpMN0qIyijmWqjKlX+xg8ySQPysTuV
X-Google-Smtp-Source: ADFU+vvnvaTJZq/znCQMl/lT+vmB14sCXf7IljGSBFhmrPuO+K9pAGIZg4aDF3ZUU7aDFH1strwtkqTmVIy6
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr1433427pja.132.1584585068936;
 Wed, 18 Mar 2020 19:31:08 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:31:01 -0700
In-Reply-To: <20200319023101.82458-1-irogers@google.com>
Message-Id: <20200319023101.82458-2-irogers@google.com>
Mime-Version: 1.0
References: <20200319023101.82458-1-irogers@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 2/2] libperf evlist: fix memory leaks
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

Memory leaks found by applying LLVM's libfuzzer on the tools/perf
parse_events function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.25.1.696.g5e7596f4ac-goog

