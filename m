Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB6CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EF5208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="v88id4FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIIIEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgIIICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:02:30 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB9C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:02:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b54so1245920qtk.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+v/M5QTP1V7FrDLZG+2JGMmNkf6saqE/CnYjYEQaD2o=;
        b=v88id4FNMlY5AAlexK5D7P5hkn5ivbdEs35Nkh4RlMt0y1Pwj9J/bdiPTU01pIACOi
         TlmPMeIhJd6l5lUWOpF0ZPQPi/JA359BYnatQX3oxYaufZNAA4fsEK1jLE+rpjcZ2YFX
         d6R1Gq+9HA6QDciXoif5Iul8NRl2WRC3rlWXK7IS1L801KkX0naHhf7fhdOCvExGsgHf
         K2IjNJVp2F1nUHxVrvtRDAB9tt5bxOFRE9QrVu1Qqfth16Y6ZKnDcvrYHO11wA5ZY15/
         kC1NY68ibbCFwXrXPNNEvTEiTwTejQeV/PEYjdp6PC58WroXgavw2k+CB2ifqHMaxAW9
         GmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+v/M5QTP1V7FrDLZG+2JGMmNkf6saqE/CnYjYEQaD2o=;
        b=FULakEzv+dghYdqIVH7W9TRiczlemQ8G8fEkY8PsR9NH9zQ5PpVJJvxThign86T+Ie
         BwscUenHXC4ugNYAvnVITuDUADej6OIkuL9qMDLVkLHm1Wabt/H6+k1yDmjiD5dn6lIS
         9GcItcTbbQAEXlpvJgGq+1S7vLWV8ff8haueyrIwvCxolaeAa066lUpZnSKmVCaiBT5K
         qzdYtrRTS12PIqQTamawE5ZviwLmqn5D4oIqSDBsvxi6T7Me5KcLOf5VIFXHYh+y8+jO
         l8E7rH50tRfPuFhMt5oXwGAXKrwJGqCXaqSnDF4FtPWYa08Ug/6YRFKoKVAD3yjlSLTN
         rczA==
X-Gm-Message-State: AOAM533JE0KS5vFAfVmmszRlOUxOIifWPV1PdBlwr1221nBORBnH9q15
        bKjNpgIQRP4hLGx4xfafMHZBceaMJvFD
X-Google-Smtp-Source: ABdhPJymIEEr5DdCIlbnDCowSiixeJFbxHW+n13/3Ez3h3r9Tx5dyGirugnHgqGF/XimLScMqDBKPxaRrBvY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:edaa:: with SMTP id
 h10mr2856021qvr.12.1599638548807; Wed, 09 Sep 2020 01:02:28 -0700 (PDT)
Date:   Wed,  9 Sep 2020 01:02:20 -0700
In-Reply-To: <20200909080220.254585-1-irogers@google.com>
Message-Id: <20200909080220.254585-3-irogers@google.com>
Mime-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 3/3] perf metricgroup: Fix typo in comment.
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
        Hongbo Yao <yaohongbo@huawei.com>,
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
index d216a161f41c..050f3404c137 100644
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

