Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1443C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F08420714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFOBgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 21:36:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbgFOBgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:36:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E072FC3246322CC7ADBA;
        Mon, 15 Jun 2020 09:36:40 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 15 Jun 2020 09:36:33 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <Markus.Elfring@web.de>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
Subject: [PATCH next v3 2/2] perf tools: fix potential memleak in perf events parser
Date:   Mon, 15 Jun 2020 09:36:14 +0800
Message-ID: <20200615013614.8646-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615013614.8646-1-chenwandun@huawei.com>
References: <20200615013614.8646-1-chenwandun@huawei.com>
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
What's more, add jump targets so that a configuration object and
a duplicated string are released after a call of the function
"strdup" or "new_term" failed.

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

