Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E30C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653C721D80
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rfvF2iep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgIJD1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbgIJD0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C717C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:26:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 184so3106867pgg.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MD8ea/IkxRwSIEFvRM2gPJ3l2x2PVS2E7Uygw6h8m9k=;
        b=rfvF2iep/LJAN1tl9ytlByh0kIYkrEYjNvwNY8ZdgcSQ+RMDMcI/n9va8fdTgFAPqJ
         7rJYiOuev+olV5L/57furWPSqo2bhbeGJrH85QX0eor8V/ixp8yFslDA884AgBxSw1hm
         uvZBRjg5DfBC46F47lJuAQwxYLGN0eOYinE29+Bo/zEwUJ1+gvhC/ZdjQF6WDTdarQGA
         lgCsD2hGoCrgKdJp0CuLvPfTYmWyzFQ2iQKiQiUuJb/O6MQdvJjczrv20KljqkvD/ks5
         4MEqBKtuurvErMV9n+G9dfMi+yVSZZUdtEA6Dxvo7Rv4ZZx+vAi9tnOK9Pv7WFyC1nxK
         0Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MD8ea/IkxRwSIEFvRM2gPJ3l2x2PVS2E7Uygw6h8m9k=;
        b=LxKsAtgpyImXue/zRWQJY2R7/ISTc7mTGblsDtfEqJ8ip/llrUp4WBePtuGCLNja72
         v/IswhV7ahOXnCMoXMb97MPI1FI15UnlyfWaG7LRHtI/IxLWA9QlKxPej00matab+vg8
         /qIeExxcEL/gNRm2uC4Bihge48BvQBIU7AH2Xqfy7e/wupoelIV6+CV0SDCtZ6jTFs9r
         Ko7EcGq9DJzZYdos1Z1V3G3gcLjX62oJNvvAf0kohnQrP0Fj2sLF34UOl/jkRjo4/L2f
         Ium2NFk7hpeD2t0TFJE/RdoleFi0vP+KLNeFLaF7iZNdtF3nh4Z2Njfd64mRvLjfI7eZ
         N7XA==
X-Gm-Message-State: AOAM5308/ewZxg7ldN8UNe2ccom8qlWyPhMCsx38xcdgCp27YHVFXyMq
        fMjc2WZN6/aiuwoNElIPJsxfQNAibitg
X-Google-Smtp-Source: ABdhPJwj1XuXlyqlo7PExCqXnd8CK49QZhpdhJDj7IzodEeCA8QzCVhC1n9NMxUiPLjH+bTQTl28HRPEqPAV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr285501pjb.0.1599708398338; Wed, 09 Sep 2020 20:26:38 -0700 (PDT)
Date:   Wed,  9 Sep 2020 20:26:31 -0700
In-Reply-To: <20200910032632.511566-1-irogers@google.com>
Message-Id: <20200910032632.511566-2-irogers@google.com>
Mime-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 2/3] perf metricgroup: Fix typo in comment.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing character.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..662f4e8777d5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -150,7 +150,7 @@ static void expr_ids__exit(struct expr_ids *ids)
 }
 
 /**
- * Find a group of events in perf_evlist that correpond to those from a parsed
+ * Find a group of events in perf_evlist that correspond to those from a parsed
  * metric expression. Note, as find_evsel_group is called in the same order as
  * perf_evlist was constructed, metric_no_merge doesn't need to test for
  * underfilling a group.
-- 
2.28.0.526.ge36021eeef-goog

