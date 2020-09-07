Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E76C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C14021534
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450331;
	bh=3CHEAULpEl18v1s7DBrp5+ak8lApO0Ih7M6GZchdIOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I3lm97BIRpay3rB663vbq71K9TuIBCieZTvSUxbfuVR6HPlWLU1hJjIvgxseg05lx
	 EZGXgxPNDgGIHJMUX6284UIpWeG3N6gHhGTpqRGfQrN+HKVrCUSfqat4lUmQ5MjRTj
	 +XkC4nAcB/cW3YkfMg8cO2Uur5ZVuOE+znBYBBEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIGDpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgIGDpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B012C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so7921898pfi.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCKz8nVuklulWh7GFYMhEjxq6Ekku02F9Z+kP7jt6fk=;
        b=EyVQaIXUO2fxakmEH2ScvEf6gpwcdL7D352Zs2su5yOvIUb0BZJwPbPtMYXm+KM+1K
         zRMgZzL1jmJvOXwmXqX2Zv/eVFXqkVv2ZbD0iIxZ98EQSyuKunJIqm3Yolhzq4ifXg8j
         XxOk7nnf5Np6IeDFS/p9jXJMPagj2UO1j66/NhtazJGvYA8dCPbepFr2XgmO1tG4ZhvM
         h0Tvr/DIL404IG9aw3mZdByhLhD+dTv3L4dxIsKLYrsJqNnbd+Uf/V2IalI3CiY/09Qe
         KPmOzC3PaEBSOROOvWyqYtaqADJ6De7Z89Z1lgm+gAtw1X/aTZghCJaxe7SVg9qswVoy
         9i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aCKz8nVuklulWh7GFYMhEjxq6Ekku02F9Z+kP7jt6fk=;
        b=kT2QMIExp6VFdSjP/iAXYFuavrmtugr9/uMJXQXVAptUNdrzCqWnI651icPNYiaEpg
         8D0uznPQ0nWfwJOfsEn5oD6R5CQITILlMnG+/DZyyWOZwBAC0jprOsxc10bM+h0pbQk6
         3bs0n28dG7b6z3pwnHPjwe5cfyploJUNob4i11aHAe2FaanRAt7h+vTrvJVMvHRwmb0h
         x780EE+qhs/wjhUgOG6sFWJEfuLAJ+PHhla8hBEXDi3+OGJpy9olKXUKln8oZ1+oCKGr
         b2jYHCsILdZ9bgXbJDWfo0VzlkPhFEj7Zl3rTyivjEJ74Rk0x2pU9OPmK6VlTiEWMPzK
         nH9g==
X-Gm-Message-State: AOAM530rJUNd7lvnG9GYZvs78caB8IZvlzAIgc7zPIdZCogjoyh8loB0
        pWL24c11sC0hNs1iJ31hpBc=
X-Google-Smtp-Source: ABdhPJxZUNiVslsQGKD0o0lt7KHS6pGZRXlokcsbuMlXGon7WbSg9bE1S0ORtmSY53iH6qk6CbWlUw==
X-Received: by 2002:aa7:8285:: with SMTP id s5mr19185495pfm.226.1599450321772;
        Sun, 06 Sep 2020 20:45:21 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:21 -0700 (PDT)
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
Subject: [PATCH 2/9] perf parse-event: Fix cpu map leaks
Date:   Mon,  7 Sep 2020 12:44:55 +0900
Message-Id: <20200907034502.753230-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like evlist cpu map, evsel's cpu map should have proper refcount by
releasing the original count after creation.

This fixes the following ASAN report:

  Direct leak of 840 byte(s) in 70 object(s) allocated from:
    #0 0x7fe36703f628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
    #1 0x559fbbf611ca in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x559fbbf6229c in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:237
    #3 0x559fbbcc6c6d in __add_event util/parse-events.c:357
    #4 0x559fbbcc6c6d in add_event_tool util/parse-events.c:408
    #5 0x559fbbcc6c6d in parse_events_add_tool util/parse-events.c:1414
    #6 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
    #7 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
    #8 0x559fbbcc95da in __parse_events util/parse-events.c:2141
    #9 0x559fbbc2788b in check_parse_id tests/pmu-events.c:406
    #10 0x559fbbc2788b in check_parse_id tests/pmu-events.c:393
    #11 0x559fbbc2788b in check_parse_fake tests/pmu-events.c:436
    #12 0x559fbbc2788b in metric_parse_fake tests/pmu-events.c:553
    #13 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:599
    #14 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:574
    #15 0x559fbbc0109b in run_test tests/builtin-test.c:410
    #16 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
    #17 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
    #18 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
    #19 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #20 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #21 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #22 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #23 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308

And I've failed which commit introduced this bug as the code was
heavily changed since then. ;-/

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4d2394e2b2d..b35e4bb1cecb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,8 +360,11 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
+	if (!evsel) {
+		if (!pmu)
+			perf_cpu_map__put(cpus);
 		return NULL;
+	}
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
@@ -369,6 +372,8 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
+	if (!pmu)
+		perf_cpu_map__put(cpus);
 	if (name)
 		evsel->name = strdup(name);
 
-- 
2.28.0.526.ge36021eeef-goog

