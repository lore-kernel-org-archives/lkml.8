Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC8C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3E720DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450345;
	bh=7DivgIJa8KlrQzm9I3fP0M/Xt3VH1s8wIxTo1iKGUTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUp7UNAJkQ8FVXM74nj39tiDCAiHTykCTRN0X5nZDgfIAgZ6p6AvxxVY2fTXCsk/E
	 qrIzuSP8sB4IwkqrfMWHIlMS74K/j2irt+wIvQwL79ZW3FaVacw+e6AqLOdcStVwQL
	 hng2DvZW6d9mb/qrRPxYrKXPPNGrTGyA5TUkTGsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIGDpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgIGDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC0C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m8so2098563pgi.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgKa/8P8JpumyV74AKHX3waSKtY+T2XKr+2JUnMHcys=;
        b=hXay9QC9PqqrIzeZyAOUOuX7E7jIwPtvXYbJNcg0h83JL/DQ1yZOo73NB/m/GsStZ+
         Ic68Ib8QHYqs0W4YlCPlLo8TGYXm1iw7HAe4w8Yxgl632dRpEKaUt9XI/ydHXIWu2I4L
         kpVZcySmja6hQxiC4UChgblunlYUVu+mGoLUjto2HTb0tX8jC8e7zeE38RJk5AKa/M/V
         L5Ad8alrfZik8dsFHqzTrwCHq3UeNkI3l68TxE6RZremNSUIKo24zaNfAvTE8JgNfymG
         1IRo3Md8fUG8Ieqdr0NrktR4e4Hi52x/OJbCzwrDfjWxQz2u2o+MGZynFaoIrrmUvIV+
         6I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PgKa/8P8JpumyV74AKHX3waSKtY+T2XKr+2JUnMHcys=;
        b=APJ4Lta7qshPnsBnxmMUbMosLaSazTPnTFGt205nMhJ7qMvjMare6XT8tWJ3GMFw/f
         YMPR/h4Kk2Vl06IjOyXjUtiMhf5qbRyZ1H6fC0wEXeZC2zkmgkw5xLF6nxGylGbEpyMX
         HxSdjz2p6NTzbi4DYIxQNhECIvJqE3l7+sBZR+qQ4E1ZXCJLUYwBl6ruRmfB6t1S2Sjs
         o+j6guHjP49qEZrxlBYuL4FMxT0h84P1Q6JPEbDtyz+8qMV7xUanQXDQFVNdx8VaFk3C
         QXP3Y3MT1Co2J9gxmoa++bBP5t3Doy6Fab127yRX6tLhzV3lzLjnI0ciKLyFCd1jA63s
         wWgw==
X-Gm-Message-State: AOAM530RxbYQRhHSHDFSazKm9PfJia/QZTMgh9YpTzwzkgDwu/uEhhDE
        6YaUhN2bGsiQxXam423wNF4=
X-Google-Smtp-Source: ABdhPJxIilmaMd68Ebk45KbButwTciRD0P9llB0uudsL8TehBQxLVLFR5FX2rG+R/dt5rnyBrDoW0g==
X-Received: by 2002:a62:7809:: with SMTP id t9mr18427096pfc.105.1599450326184;
        Sun, 06 Sep 2020 20:45:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:25 -0700 (PDT)
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
Subject: [PATCH 3/9] perf parse-event: Fix memory leak in evsel->unit
Date:   Mon,  7 Sep 2020 12:44:56 +0900
Message-Id: <20200907034502.753230-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel->unit borrows a pointer of pmu event or alias instead of
owns a string.  But tool event (duration_time) passes a result of
strdup() caused a leak.

It was found by ASAN during metric test:

  Direct leak of 210 byte(s) in 70 object(s) allocated from:
    #0 0x7fe366fca0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x559fbbcc6ea3 in add_event_tool util/parse-events.c:414
    #2 0x559fbbcc6ea3 in parse_events_add_tool util/parse-events.c:1414
    #3 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
    #4 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
    #5 0x559fbbcc95da in __parse_events util/parse-events.c:2141
    #6 0x559fbbc28555 in check_parse_id tests/pmu-events.c:406
    #7 0x559fbbc28555 in check_parse_id tests/pmu-events.c:393
    #8 0x559fbbc28555 in check_parse_cpu tests/pmu-events.c:415
    #9 0x559fbbc28555 in test_parsing tests/pmu-events.c:498
    #10 0x559fbbc0109b in run_test tests/builtin-test.c:410
    #11 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
    #12 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
    #13 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
    #14 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #15 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #16 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #17 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #18 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308

Fixes: f0fbb114e3025 ("perf stat: Implement duration_time as a proper event")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b35e4bb1cecb..ece321ccf599 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -416,7 +416,7 @@ static int add_event_tool(struct list_head *list, int *idx,
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
 	if (tool_event == PERF_TOOL_DURATION_TIME)
-		evsel->unit = strdup("ns");
+		evsel->unit = "ns";
 	return 0;
 }
 
-- 
2.28.0.526.ge36021eeef-goog

