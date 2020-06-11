Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808132075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFKO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:56:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbgFKO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:56:55 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD49488854E444E97BE3;
        Thu, 11 Jun 2020 22:56:40 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 11 Jun 2020 22:56:31 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <Markus.Elfring@web.de>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
Subject: [PATCH next v2 1/2] perf tools: fix potential memleak in perf events parser
Date:   Thu, 11 Jun 2020 22:56:04 +0800
Message-ID: <20200611145605.21427-2-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611145605.21427-1-chenwandun@huawei.com>
References: <20200611145605.21427-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

Fix memory leak of in function parse_events_term__sym_hw()
and parse_events_term__clone() when error occur.

Fixes: b6645a723595 ("perf parse: Ensure config and str in terms are unique")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 tools/perf/util/parse-events.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3decbb203846..6f4dc8a92817 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2957,8 +2957,12 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 	sym = &event_symbols_hw[idx];
 
 	str = strdup(sym->symbol);
-	if (!str)
+	if (!str) {
+		if (!config)
+			free(temp.config);
 		return -ENOMEM;
+	}
+
 	return new_term(term, &temp, str, 0);
 }
 
@@ -2983,8 +2987,12 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		if (term->config)
+			free(temp.config);
 		return -ENOMEM;
+	}
+
 	return new_term(new, &temp, str, 0);
 }
 
-- 
2.17.1

