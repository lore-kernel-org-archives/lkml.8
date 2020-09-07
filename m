Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E126C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176612137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450356;
	bh=/ezLOUjEb1sybaeNg6XSgQUZreC01ojuo7OkRbB+S0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cu/UB4yyM9D6uiJUjhThEaaizyseEMaqjtRDLOGXOLLs30n0pizXhr/gcicbHE19
	 IMYVsPisVHohFQ30f4u6QNFyxm7dJrtP2+RiS6v3sMS5dpIN9Us8ZXA3zrmLPsCB5/
	 tKuB7jArrDhd9d88NX+3hZ2uSTe1TTWsIfEESTXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIGDpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgIGDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF57C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j34so2001801pgi.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COmd0QhRwTcOdkv6a/fr3ZA4O+22//SNbc2QK6yqgUE=;
        b=rkxeeaWdH44GqtT3OvLRW9OM0OvULSN1K1wvHJ+cynx4So3gVTWf359iGpeJ4O5eYd
         2QMRHiqOv3UkBdwjncU7rq3qpS/hvhK4CMtHyjxxE3MdVaQvKqfqDI7GLIG4V+bW3sjp
         IGyInY3V1wYNuFL06FEI7GERIOoglVGJssCsyaGKnZJt5LIUpSmReIsXed5pKI3b9Dg0
         ozQ6SFyCv9MTZyPbLiBn9tDEwGL2zzAEVZPS8LuA4z/M8AnbywMBIL66CdOmKRcsqZpu
         qPdO0iYDAOdHDUnLp64H7O8T+I4rV7J0c88/5wGs+S7aNsFkaUacWTKWR12ZOgQCawri
         NtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=COmd0QhRwTcOdkv6a/fr3ZA4O+22//SNbc2QK6yqgUE=;
        b=dcM7J3y9J+Yr4yaBunICEI9jNyiHG5p9w/FNH0byQKY7yrbadz5zxV03N44WNIPUWB
         mT0xkwl2W1y4hOoomyQk8b6cXXDZeiyvCv5gH6wcffruOcaGa+Befl2CS26R6iKXnBu2
         Vh0ELiH2eqIowj76RcKvjMCExxjHgomL0V1PTVaueXtiK+OBnVBwof4XVrz0e9d1wxwY
         zUEexnGyFLC1uwSfQGxyF03FDF2q5HDneS5+Er6tmFi5HEXS9J6M7ENbHmcTdAOwB+6W
         m+bLOqNad7NUwb2BG2SbxvZDPbtOKouHwFazW+j27iS+pawIt72cxDsCpoRhnZucm2UY
         LUjg==
X-Gm-Message-State: AOAM530L/l0T3ULii9hsDnomCRITiNK06PGUmazipVx53UrIrmgN0DhQ
        0haOxbg3wcTxDS+vr4oTDlNtV+bs6f2Zzg==
X-Google-Smtp-Source: ABdhPJxk/FdanmKzh6rIvUN4xwhCsGa/gxFKWfUTz1Z3oB4HoiZevMH0rTwKLbG6rAluB3nLzC+9Ew==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr7280832pgc.297.1599450337563;
        Sun, 06 Sep 2020 20:45:37 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:37 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCH 6/9] perf metric: Free metric when it failed to resolve
Date:   Mon,  7 Sep 2020 12:44:59 +0900
Message-Id: <20200907034502.753230-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metricgroup__add_metric() can find multiple match for a metric
group and it's possible to fail.  Also it can fail in the middle like
in resolve_metric() even for single metric.

In those cases, the intermediate list and ids will be leaked like:

  Direct leak of 3 byte(s) in 1 object(s) allocated from:
    #0 0x7f4c938f40b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x55f7e71c1bef in __add_metric util/metricgroup.c:683
    #2 0x55f7e71c31d0 in add_metric util/metricgroup.c:906
    #3 0x55f7e71c3844 in metricgroup__add_metric util/metricgroup.c:940
    #4 0x55f7e71c488d in metricgroup__add_metric_list util/metricgroup.c:993
    #5 0x55f7e71c488d in parse_groups util/metricgroup.c:1045
    #6 0x55f7e71c60a4 in metricgroup__parse_groups_test util/metricgroup.c:1087
    #7 0x55f7e71235ae in __compute_metric tests/parse-metric.c:164
    #8 0x55f7e7124650 in compute_metric tests/parse-metric.c:196
    #9 0x55f7e7124650 in test_recursion_fail tests/parse-metric.c:318
    #10 0x55f7e7124650 in test__parse_metric tests/parse-metric.c:356
    #11 0x55f7e70be09b in run_test tests/builtin-test.c:410
    #12 0x55f7e70be09b in test_and_print tests/builtin-test.c:440
    #13 0x55f7e70c101a in __cmd_test tests/builtin-test.c:661
    #14 0x55f7e70c101a in cmd_test tests/builtin-test.c:807
    #15 0x55f7e7126214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #16 0x55f7e6fc41a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #17 0x55f7e6fc41a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #18 0x55f7e6fc41a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #19 0x7f4c93492cc9 in __libc_start_main ../csu/libc-start.c:308

Fixes: 83de0b7d535de ("perf metric: Collect referenced metrics in struct metric_ref_node")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b28c09447c10..c8904e471a71 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -939,7 +939,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 		ret = add_metric(&list, pe, metric_no_group, &m, NULL, &ids);
 		if (ret)
-			return ret;
+			goto out;
 
 		/*
 		 * Process any possible referenced metrics
@@ -948,12 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		ret = resolve_metric(metric_no_group,
 				     &list, map, &ids);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* End of pmu events. */
-	if (!has_match)
-		return -EINVAL;
+	if (!has_match) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	list_for_each_entry(m, &list, nd) {
 		if (events->len > 0)
@@ -968,9 +970,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 
+out:
+	/*
+	 * add to metric_list so that they can be released
+	 * even if it's failed
+	 */
 	list_splice(&list, metric_list);
 	expr_ids__exit(&ids);
-	return 0;
+	return ret;
 }
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
-- 
2.28.0.526.ge36021eeef-goog

