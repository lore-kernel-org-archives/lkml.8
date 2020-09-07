Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EE220757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450342;
	bh=0+0Vvbj81Gp70nb3wYVTNi4iarmSiC3AiyE1uqXE1dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HgR0EKSgzP7KoQIOkEn3S9Cp9bwcMEUxEH4xa5ecw2vtDD1EnDIyu3Y3eES8Mqt1k
	 f62KGf6eWj7yYF3lDc67MUicljIGCxBYKx7FazuMq2Ta/lxL4NSfATPBjqzS0XUVhr
	 lp+/Hu7lS7g1K2Cr60adxm498SMtnjw4H03vvcMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIGDpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIGDpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D6FC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so1636071pfd.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZ4LiZcr/xMAl+g7xoKICV2ZxATqOC5KJ/neXJrOlzE=;
        b=Q2K36ugy8neaa61UIr4Krp2NwsfQlOkmnL3yr43cvh8ommaxVexBwwimFRQF9A9RBt
         +auDmE9sD+BQeZTDBuHM5BvEpxhLDw1AxIlS1P3LzbMKxvA4IaxrTnuqMD++Q3Kutl/g
         /DfP5tkB81KEkcPJAs+cmGidJ280upAH1FEORh6ROCAkhruHOUcuWMstDpdlKAbQkuMH
         APN7hw+ugY+ghsgFXFmOb9ZY0CQzEbonH7JqQKPmOIUGFd17td6fyxiMDd8fJMT1rc2X
         1iSB/bgx7MI49C/BRGsTaHMALUVTXxLmNIZCeQyg2GJEodbummcnDTrqU6x/wY9U10Te
         SZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sZ4LiZcr/xMAl+g7xoKICV2ZxATqOC5KJ/neXJrOlzE=;
        b=milOm6aEeJ7y1Z3oSR9BNYz3uUHB0TQh8EURqm+x0ui+z91MT/IGShO7l0mhTwOUg8
         nGjri0lvnH1cgxNXAW/TFcZwdHCI1D4oynHkb/c/6+K/v+msSP53acrnvx67TcN1czfV
         6YEPvr8UAFGOzXRszY1ULY5CFRQQorlq/XpuQhpzMVDiao4lcjQJH98E591R2GhQTPCj
         YUqwJUxIyT4K1EzLhGRZiULsUyp9IRC69rSdAddMqf9hIERPJpGL0MXSQh6kK2RLr55o
         OyRSbWkyxrl2RUtSDXZBuqtRcyCqRKrfkMDFuFnKcEDGgXmYQ4/LUavOj/Pwy8U8e70E
         EycQ==
X-Gm-Message-State: AOAM532DQWgvAHuPTynflzH32aqPBiq1j70SGRx7/sjlz36GFBR4EDwH
        QxpEUxjJKdw6Fm4Wye0mV/k=
X-Google-Smtp-Source: ABdhPJzmIYC0lAm7XOwUj90g6nHUo5Gvh036BzXK9IAHfbnthXsD/3bcactiBx/hnPIHjLtIuREbeQ==
X-Received: by 2002:a63:146:: with SMTP id 67mr1963678pgb.331.1599450330054;
        Sun, 06 Sep 2020 20:45:30 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:29 -0700 (PDT)
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
Subject: [PATCH 4/9] perf test: Fix memory leaks in parse-metric test
Date:   Mon,  7 Sep 2020 12:44:57 +0900
Message-Id: <20200907034502.753230-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It didn't release resources when there's an error so the
test_recursion_fail() will leak some memory.

Fixes: 0a507af9c681a ("perf tests: Add parse metric test for ipc metric")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/parse-metric.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 23db8acc492d..cd7331aac3bd 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -153,8 +153,10 @@ static int __compute_metric(const char *name, struct value *vals,
 		return -ENOMEM;
 
 	cpus = perf_cpu_map__new("0");
-	if (!cpus)
+	if (!cpus) {
+		evlist__delete(evlist);
 		return -ENOMEM;
+	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
@@ -163,10 +165,11 @@ static int __compute_metric(const char *name, struct value *vals,
 					     false, false,
 					     &metric_events);
 	if (err)
-		return err;
+		goto out;
 
-	if (perf_evlist__alloc_stats(evlist, false))
-		return -1;
+	err = perf_evlist__alloc_stats(evlist, false);
+	if (err)
+		goto out;
 
 	/* Load the runtime stats with given numbers for events. */
 	runtime_stat__init(&st);
@@ -178,13 +181,14 @@ static int __compute_metric(const char *name, struct value *vals,
 	if (name2 && ratio2)
 		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
 
+out:
 	/* ... clenup. */
 	metricgroup__rblist_exit(&metric_events);
 	runtime_stat__exit(&st);
 	perf_evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
-	return 0;
+	return err;
 }
 
 static int compute_metric(const char *name, struct value *vals, double *ratio)
-- 
2.28.0.526.ge36021eeef-goog

