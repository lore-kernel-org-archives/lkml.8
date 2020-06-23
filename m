Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCE3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4F720771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgFWMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:32:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729611AbgFWMcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:32:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4991BC24F155409DC33C;
        Tue, 23 Jun 2020 20:32:02 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 20:31:58 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/2] perf tools: ARM SPE code cleanup
Date:   Tue, 23 Jun 2020 20:31:40 +0800
Message-ID: <20200623123141.27747-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623123141.27747-1-liwei391@huawei.com>
References: <20200623123141.27747-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the useless check code to make it clear.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 0a6e75b8777a..62b7b03d691a 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -57,7 +57,7 @@ struct auxtrace_record
 	struct evsel *evsel;
 	bool found_etm = false;
 	bool found_spe = false;
-	static struct perf_pmu **arm_spe_pmus = NULL;
+	static struct perf_pmu **arm_spe_pmus;
 	static int nr_spes = 0;
 	int i = 0;
 
@@ -65,9 +65,7 @@ struct auxtrace_record
 		return NULL;
 
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
-
-	if (!arm_spe_pmus)
-		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
+	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cs_etm_pmu &&
-- 
2.17.1

