Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBADC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C4A221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgDQKqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:46:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729856AbgDQKp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5516EDDB903E51E6C70;
        Fri, 17 Apr 2020 18:45:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>
CC:     <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 01/13] perf parse-events: Fix comparison of evsel and leader pmu name
Date:   Fri, 17 Apr 2020 18:41:12 +0800
Message-ID: <1587120084-18990-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now strdup() the pmu name for the event selector, use strcmp()
instead of pointer equality for comparison.

Fixes: d4953f7ef1a2 ("perf parse-events: Fix 3 use after frees found with clang ASANutil/parse-events.c")
Signed-off-by: John Garry <john.garry@huawei.com>
---

I am not 100% sure that this is the right fix....

 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 10107747b361..90ddade1ba23 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1629,7 +1629,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 		 * event. That can be used to distinguish the leader from
 		 * other members, even they have the same event name.
 		 */
-		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
+		if ((leader != evsel) && !strcmp(leader->pmu_name, evsel->pmu_name)) {
 			is_leader = false;
 			continue;
 		}
-- 
2.16.4

