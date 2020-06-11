Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916E720792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFKO4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:56:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728344AbgFKO4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:56:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00A9E489A0EC382B33C9;
        Thu, 11 Jun 2020 22:56:46 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 11 Jun 2020 22:56:38 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <Markus.Elfring@web.de>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
Subject: [PATCH next v2 2/2] perf tools: fix potential memleak in perf events parser
Date:   Thu, 11 Jun 2020 22:56:05 +0800
Message-ID: <20200611145605.21427-3-chenwandun@huawei.com>
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

Fix potential memory leak. Function new_term may return error, so
it is need to free memory when the return value is negative.

Fixes: b6645a723595 ("perf parse: Ensure config and str in terms are unique")

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 tools/perf/util/parse-events.c | 47 ++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f4dc8a92817..a9f32032af08 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2947,6 +2947,7 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 		.config    = config,
 	};
+	int ret;
 
 	if (!temp.config) {
 		temp.config = strdup("event");
@@ -2958,12 +2959,23 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 
 	str = strdup(sym->symbol);
 	if (!str) {
-		if (!config)
-			free(temp.config);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_config;
 	}
 
-	return new_term(term, &temp, str, 0);
+	ret = new_term(term, &temp, str, 0);
+	if (ret)
+		goto free_str;
+
+	return 0;
+
+free_str:
+	free(str);
+free_config:
+	if (!config)
+		free(temp.config);
+
+	return ret;
 }
 
 int parse_events_term__clone(struct parse_events_term **new,
@@ -2977,23 +2989,38 @@ int parse_events_term__clone(struct parse_events_term **new,
 		.err_term  = term->err_term,
 		.err_val   = term->err_val,
 	};
+	int ret;
 
 	if (term->config) {
 		temp.config = strdup(term->config);
 		if (!temp.config)
 			return -ENOMEM;
 	}
-	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
-		return new_term(new, &temp, NULL, term->val.num);
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+		ret = new_term(new, &temp, NULL, term->val.num);
+		if (ret)
+			goto free_config;
+	}
 
 	str = strdup(term->val.str);
 	if (!str) {
-		if (term->config)
-			free(temp.config);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_config;
 	}
 
-	return new_term(new, &temp, str, 0);
+	ret = new_term(new, &temp, str, 0);
+	if (ret)
+		goto free_str;
+
+	return 0;
+
+free_str:
+	free(str);
+free_config:
+	if (term->config)
+		free(temp.config);
+
+	return ret;
 }
 
 void parse_events_term__delete(struct parse_events_term *term)
-- 
2.17.1

