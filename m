Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F28C10DAA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593B62137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450360;
	bh=jOrY6qXMfnu5bZICCJi2nHtuUskKGfjxFtbjnrKRwbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BofmH80Pu5wuWK007iq3QsN9HqpYymFbnyS5SIOUjks0/akC0SXwSM9sQruvAxY/o
	 5/c/nyOCJhPnt2H19rq3VDwBjAnJJMPR6FMIooVa3BrtR1IOUsreTt2kDZYnfCCJ8k
	 kPiiaz2bEx/4WNlW9NUQXwnzDcerFgxJ330BT7J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIGDp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIGDpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75622C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so858359pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTlcu/2luaGCL/RLv/AOF68hjXPRVqBoWMqe+lz0jaE=;
        b=CBsCcxpnDHWFo5f9UejHLh7LFnTD6pgtGQRhArjkjyfZC45FELInjbHubOEyIsmfdJ
         YTso06KPhQUcoi3ye2lgQDp4KvSne+B2ECxbKtPBewyaCq381o8NoXz+eRMkgKHtxN8F
         H3jwIUC43IpXQ0LTwkBxz1dXGyYwdjpXJHwmJUSyZRinQYRL4W55SPV07XqyWPXK59hG
         2xV/BZeF6SAhVSv6KASzm3xnJMaCzn998NGOIn7xEJtL6IU0dFAFeLH+VGr8qpwcNmj/
         TIU4wDr3wWHdSxj87srp8mMyylR0fh/jNkTSeGGttCVM9h2W7ctsFmZ7fFdcLzyODQTX
         /4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QTlcu/2luaGCL/RLv/AOF68hjXPRVqBoWMqe+lz0jaE=;
        b=bxRAwfcG1Ls2JRl5nx7wg1a/a59ieuTpWLZLsniFxPZrJcoBK1RcevDToGRE/ERKnf
         2McqHa4dlKyPHJBaPB4x0VGMRKUQuAlffuWa+chNbYV2ueb7nnqIOONJvB/0vFyqka19
         D6M+zKOZzmooaTCfNRkoQ+abGQIUnAc6ag4t6m2LbR1XsImoc5OMTuhVRvCyfiyryhLp
         D4nHL4EnnWyz3q5EpLEMSGhwVtqzLeL6d340w0Eorh5xAuNTEQsw2iOcRAw3KF8nGGgq
         m8oN/2FecXJ/6QHFCgXvHggYXkuOlVGLJsTM+2hIMscQ4JxCOFsCAOk/flrbG07HXFVR
         SThQ==
X-Gm-Message-State: AOAM5328PASvQebYb2T6kd6sgcWv3s7Ae2SsOfgPF2bWCPjCiR63kq6S
        CBjcytVOz2pHRWhvFFohyzF64ZN2Q8i5+w==
X-Google-Smtp-Source: ABdhPJz9ZaQsAE7mcOWu6puNmHYCFKwiqTKczTBi7IBHbDRCgfEEXGq0O8rzLZK5kRsx1NurHe488g==
X-Received: by 2002:a62:63c6:: with SMTP id x189mr19206761pfb.216.1599450347009;
        Sun, 06 Sep 2020 20:45:47 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:46 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 8/9] perf test: Free aliases for PMU event map aliases test
Date:   Mon,  7 Sep 2020 12:45:01 +0900
Message-Id: <20200907034502.753230-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aliases were never released causing the following leaks:

  Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
    #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
    #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
    #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
    #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
    #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
    #5 0x56332c76a09b in run_test tests/builtin-test.c:410
    #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
    #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
    #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
    #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308

Cc: John Garry <john.garry@huawei.com>
Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pmu-events.c | 5 +++++
 tools/perf/util/pmu.c         | 2 +-
 tools/perf/util/pmu.h         | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index eb19f9a0bc15..d3517a74d95e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 	int res = 0;
 	bool use_uncore_table;
 	struct pmu_events_map *map = __test_pmu_get_events_map();
+	struct perf_pmu_alias *a, *tmp;
 
 	if (!map)
 		return -1;
@@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 			  pmu_name, alias->name);
 	}
 
+	list_for_each_entry_safe(a, tmp, &aliases, list) {
+		list_del(&a->list);
+		perf_pmu_free_alias(a);
+	}
 	free(pmu);
 	return res;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f1688e1f6ed7..555cb3524c25 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -274,7 +274,7 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
 }
 
 /* Delete an alias entry. */
-static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
+void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 {
 	zfree(&newalias->name);
 	zfree(&newalias->desc);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 44ccbdbb1c37..b63c4c5e335e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -113,6 +113,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
+void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
-- 
2.28.0.526.ge36021eeef-goog

