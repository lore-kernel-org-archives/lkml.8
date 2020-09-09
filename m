Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C45C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DE4218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="daO+rZwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIIIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgIIIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:02:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:02:28 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dj20so870594qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U3gtMTs4RaPxKkemS+hEa5GYd0PVVdeUUZrMo+S/CQA=;
        b=daO+rZwYFEwQs44LRCfWnJJQCUNW+cwSlz3veM95Ylwi6qoaKXXBahDbvGla/5qFr1
         vdouYzgB0skYs5WgZdC6DNjsxBlCKH5Rxx4RO4CSymZWfYIdaNmCF3MG1pIGk/Y7gnBV
         cGY87IP096UNUg1tYEA2L0mcHtoPKqDDQ2YRaeRLSMrVSGw3gQ2m6gplhH3m0gefCfc9
         UrmSfK4rEdxw2XHF0Ugwe0XvcTh4XL39Wk90exHPi6tsjuFgBJXcI8kf6yINouGIE2/S
         Ck42feKhE8rl4PVufTrNCa5LKOhRvxaGt2fqleTVnqQ83rKTAjZXS/PTjE3lzFzzr0RL
         vF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U3gtMTs4RaPxKkemS+hEa5GYd0PVVdeUUZrMo+S/CQA=;
        b=CKo8nJgv/PhQzJ1zsmPg2ltMsOAE1WdU7mm6M7LVrKnF4l0wsQF+qaNOEQHO7uMYN1
         CVjy/udOQUlj+4ehi9iGrBClJm9lPYDsf+i/CcT3q1YfyZvOvXvuVejLrj8BJm/UbbY6
         tqt1ESqJ+6oE0fyrVMi1BTpjyYlsEiVtss3SlaAJMT/a49mshB4kvrWBwiFi4o6GCbyG
         qYIx79eokzfxKyNzPdi1SSypTsI/trXPgYSchdz2/tw0PmktJ/+oqMRf+h/HbAtxX2Hp
         qP6Wm1p6DWKs6P4PsF//A+EQ0BDZ+cL2WSChTsPlZ1MSbjXfZKof8Tn5c0CqVFjpQjrn
         8vPw==
X-Gm-Message-State: AOAM531g1s7AdOG7tlinRFe4eN9CALanxbkG8HzJW8RqMBh3HfmNBTR5
        gOE5R/Ny1ZnnNYn5h9WDzH6vCcq+ubVB
X-Google-Smtp-Source: ABdhPJxEMcFtk/tjUkTXVVu3KpcQ1kD7FVod5OGDRCLcpomjQ1rzU3Sv+GBCDMzZZHuxxiqxpkzP2jovYSpM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:a085:: with SMTP id
 c5mr2939791qva.15.1599638546860; Wed, 09 Sep 2020 01:02:26 -0700 (PDT)
Date:   Wed,  9 Sep 2020 01:02:19 -0700
In-Reply-To: <20200909080220.254585-1-irogers@google.com>
Message-Id: <20200909080220.254585-2-irogers@google.com>
Mime-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 2/3] perf metricgroup: Fix uncore metric expressions
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
        Ian Rogers <irogers@google.com>, Jin@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
and uncore_imc/case_count_write/. These events open 6 events per socket
with pmu names of uncore_imc_[0-5]. The current metric setup code in
find_evsel_group assumes one ID will map to 1 event to be recorded in
metric_events. For events with multiple matches, the first event is
recorded in metric_events (avoiding matching >1 event with the same
name) and the evlist_used updated so that duplicate events aren't
removed when the evlist has unused events removed.

Before this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

             41.14 MiB  uncore_imc/cas_count_read/
     1,002,614,251 ns   duration_time

       1.002614251 seconds time elapsed

After this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
            126.97 MiB  uncore_imc/cas_count_write/
     1,003,019,728 ns   duration_time

Erroneous duplication introduced in:
commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").

Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
Reported-by: Jin, Yao <yao.jin@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..d216a161f41c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -206,6 +206,18 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				sizeof(struct evsel *) * idnum);
 			current_leader = ev->leader;
 		}
+		/*
+		 * Check for duplicate events with the same name. For example,
+		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
+		 * on skylakex. Only the first such event is placed in
+		 * metric_events.
+		 */
+		for (i = 0; i < matched_events; i++) {
+			if (!strcmp(metric_events[i]->name, ev->name))
+				break;
+		}
+		if (i != matched_events)
+			continue;
 		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
 			if (has_constraint) {
 				/*
@@ -248,6 +260,16 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		ev = metric_events[i];
 		ev->metric_leader = ev;
 		set_bit(ev->idx, evlist_used);
+		/*
+		 * Mark two events with identical names in the same group as
+		 * being in use as uncore events may be duplicated for each pmu.
+		 */
+		evlist__for_each_entry(perf_evlist, ev) {
+			if (metric_events[i]->leader == ev->leader &&
+			    !strcmp(metric_events[i]->name, ev->name)) {
+				set_bit(ev->idx, evlist_used);
+			}
+		}
 	}
 
 	return metric_events[0];
-- 
2.28.0.526.ge36021eeef-goog

