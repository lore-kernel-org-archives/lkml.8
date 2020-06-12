Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62041C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEA52081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:59:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgFLJ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:59:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 112A5712528E0DF3EFC4;
        Fri, 12 Jun 2020 17:58:55 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 12 Jun 2020 17:58:47 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jin Yao <yao.jin@linux.intel.com>,
        "Andi Kleen" <ak@linux.intel.com>, <guohanjun@huawei.com>
Subject: [PATCH] perf report TUI: Fix segmentation fault in perf_evsel__hists_browse()
Date:   Fri, 12 Jun 2020 17:43:22 +0800
Message-ID: <20200612094322.39565-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The segmentation fault can be reproduced as following steps:
1) Executing perf report in tui.
2) Typing '/xxxxx' to filter the symbol to get nothing matched.
3) Pressing enter with no entry selected.
Then it will report a segmentation fault.

It is caused by the lack of check of browser->he_selection when
accessing it's member res_samples in perf_evsel__hists_browse().

These processes are meaningful for specified samples, so we can
skip these when nothing is selected.

Fixes: 4968ac8fb7c3 ("perf report: Implement browsing of individual samples")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/ui/browsers/hists.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487e54ef56a9..2101b6b770d8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2288,6 +2288,11 @@ static struct thread *hist_browser__selected_thread(struct hist_browser *browser
 	return browser->he_selection->thread;
 }
 
+static struct res_sample *hist_browser__selected_res_sample(struct hist_browser *browser)
+{
+	return browser->he_selection ? browser->he_selection->res_samples : NULL;
+}
+
 /* Check whether the browser is for 'top' or 'report' */
 static inline bool is_report_browser(void *timer)
 {
@@ -3357,16 +3362,16 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 					     &options[nr_options], NULL, NULL, evsel);
 		nr_options += add_res_sample_opt(browser, &actions[nr_options],
 						 &options[nr_options],
-				 hist_browser__selected_entry(browser)->res_samples,
-				 evsel, A_NORMAL);
+						 hist_browser__selected_res_sample(browser),
+						 evsel, A_NORMAL);
 		nr_options += add_res_sample_opt(browser, &actions[nr_options],
 						 &options[nr_options],
-				 hist_browser__selected_entry(browser)->res_samples,
-				 evsel, A_ASM);
+						 hist_browser__selected_res_sample(browser),
+						 evsel, A_ASM);
 		nr_options += add_res_sample_opt(browser, &actions[nr_options],
 						 &options[nr_options],
-				 hist_browser__selected_entry(browser)->res_samples,
-				 evsel, A_SOURCE);
+						 hist_browser__selected_res_sample(browser),
+						 evsel, A_SOURCE);
 		nr_options += add_switch_opt(browser, &actions[nr_options],
 					     &options[nr_options]);
 skip_scripting:
-- 
2.17.1

