Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A959C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AF2207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIBOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:14:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgIBOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:06:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5C9FB6ECADA063E1451C;
        Wed,  2 Sep 2020 22:05:39 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 22:05:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf bench: fix return value check in do_run_multi_threaded()
Date:   Wed, 2 Sep 2020 22:05:26 +0800
Message-ID: <20200902140526.26916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function perf_session__new() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR()

Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/perf/bench/synthesize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 8d624aea1c5e..e39daa609db2 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
 		session = perf_session__new(NULL, false, NULL);
-		if (!session)
-			return -ENOMEM;
+		if (IS_ERR(session)) {
+			return PTR_ERR(session);
 
 		atomic_set(&event_count, 0);
 		gettimeofday(&start, NULL);
-- 
2.17.1


