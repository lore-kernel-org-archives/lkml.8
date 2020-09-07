Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83261C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E362137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450381;
	bh=ssKHh5uN8kw02B8JLM4EYrwKl3WmD2+D/wzbJsPfwYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvxlIIqS180E6DOYbgA4ivI871N62B0ls8F8VhQ9CBqwAlro8G0tdkPN7enVtHGRz
	 dFpyEM80qrnIZG3BR01A/RwUZ2hiVeZYSt8TyuZLS3PJOdZugDCYjBSEpcCR9STfUj
	 JBGZnNnTzSWRFeR3HocOeBZA7gmzZ2iZ5j6EJOrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgIGDqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgIGDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C3C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so5995336pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE7QlRciRZZsSqOauKZc/xqjb8BmmJh/ejUA0W7hy9k=;
        b=tRjE2Kb/jRNQHwkoFQDK6wKlLNhWhk0ShcCB5hy7xCdH7e6zDfMhgQ/Xo+pRMmyIb2
         WLTXPUufnzHeFx/3sv10oHZQeQ3b6JhHzrDvqn8Ieys+K7TaS0EW1wQho9ej9cJCCJq5
         vtw3Bdy5LAbGCE6UrD90qZQGdIXZpPIXQMrsW/fCn/lLy+puKr5KCGhAzS2urq41WWMR
         2pjtDv8jsiG2h8IB23uIM6AIAv4pxlRkEEI59xtnmB5uGQohCCTtEbBZ7ij5u2EcAv81
         Klkvpr5BHiBfzbNPsH+OV7661JIxP/t8dKHFDvQjhRsjHddLGZlCALCiQenBS2+oF9Cq
         SogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wE7QlRciRZZsSqOauKZc/xqjb8BmmJh/ejUA0W7hy9k=;
        b=gRicxJkyg8JuB/czkG+VXSQvUnuyCmQVgfFGPugnUlJCugltvbHBcTtyQ9zKMq7Fzv
         h6hSllL9JBGDywibKQgLGwONvTV3caPFUcYEWqJ0nuSK4plO04RIJK59CMdedN58fD+t
         IvsFoMr+IRPvoX0QRO0Af6rjJKYUiH+gyy6NHaWblPnZ8VZHw1RIrPj6uNRCk64m17lU
         5D7q/mwbAOPee6TaCPRUVXs8OUoSWqRrIjjOOvCL6bzwIFY7vcG+kadkJcoa5qLDB5bi
         ReYy2daOq+e9Bdm6Y0OzY1CfwsfT9HBmpsZZ8SQVpQMwxzk/muiC+Eu4qkyDG8BaDs5X
         /zYQ==
X-Gm-Message-State: AOAM532Iq9KwiDRcG3of6ak5wJR0N0dZRw1o3iwxAafeuRJ5Y5Z4oaWQ
        yT7ZXKOvVF6UnlBDo7pGi5Q=
X-Google-Smtp-Source: ABdhPJylD6P5Epk43EB2z74srVVxMa1ddOSrTpkGgG7/WGyzSXrSSMU59UW/ku9taEJGu7DDM5iMRg==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr11166006plq.240.1599450333616;
        Sun, 06 Sep 2020 20:45:33 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:33 -0700 (PDT)
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
Subject: [PATCH 5/9] perf metric: Release expr_parse_ctx after testing
Date:   Mon,  7 Sep 2020 12:44:58 +0900
Message-Id: <20200907034502.753230-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_generic_metric() missed to release entries in the pctx.
Asan reported following leak (and more):

  Direct leak of 128 byte(s) in 1 object(s) allocated from:
    #0 0x7f4c9396980e in calloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10780e)
    #1 0x55f7e748cc14 in hashmap_grow (/home/namhyung/project/linux/tools/perf/perf+0x90cc14)
    #2 0x55f7e748d497 in hashmap__insert (/home/namhyung/project/linux/tools/perf/perf+0x90d497)
    #3 0x55f7e7341667 in hashmap__set /home/namhyung/project/linux/tools/perf/util/hashmap.h:111
    #4 0x55f7e7341667 in expr__add_ref util/expr.c:120
    #5 0x55f7e7292436 in prepare_metric util/stat-shadow.c:783
    #6 0x55f7e729556d in test_generic_metric util/stat-shadow.c:858
    #7 0x55f7e712390b in compute_single tests/parse-metric.c:128
    #8 0x55f7e712390b in __compute_metric tests/parse-metric.c:180
    #9 0x55f7e712446d in compute_metric tests/parse-metric.c:196
    #10 0x55f7e712446d in test_dcache_l2 tests/parse-metric.c:295
    #11 0x55f7e712446d in test__parse_metric tests/parse-metric.c:355
    #12 0x55f7e70be09b in run_test tests/builtin-test.c:410
    #13 0x55f7e70be09b in test_and_print tests/builtin-test.c:440
    #14 0x55f7e70c101a in __cmd_test tests/builtin-test.c:661
    #15 0x55f7e70c101a in cmd_test tests/builtin-test.c:807
    #16 0x55f7e7126214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #17 0x55f7e6fc41a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #18 0x55f7e6fc41a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #19 0x55f7e6fc41a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #20 0x7f4c93492cc9 in __libc_start_main ../csu/libc-start.c:308

Fixes: 6d432c4c8aa56 ("perf tools: Add test_generic_metric function")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e1ba6c1b916a..a5f42c22c484 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -853,14 +853,16 @@ static void generic_metric(struct perf_stat_config *config,
 double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
 {
 	struct expr_parse_ctx pctx;
-	double ratio;
+	double ratio = 0.0;
 
 	if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
-		return 0.;
+		goto out;
 
 	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
-		return 0.;
+		ratio = 0.0;
 
+out:
+	expr__ctx_clear(&pctx);
 	return ratio;
 }
 
-- 
2.28.0.526.ge36021eeef-goog

