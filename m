Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB33C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006372072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFKBnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:43:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgFKBnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:43:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9E1BA3F63BA7ED3B58AC;
        Thu, 11 Jun 2020 09:42:57 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 11 Jun 2020 09:42:47 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <cj.chengjian@huawei.com>, <chenwandun@huawei.com>
Subject: [PATCH next] perf tools: fix potential memleak in perf events parser
Date:   Thu, 11 Jun 2020 09:42:34 +0800
Message-ID: <20200611014234.24304-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential memory leak in function parse_events_term__sym_hw()
and parse_events_term__clone().

1. Free memory when errors occur.
2. Function new_term may return error, so it is need to free memory
   when the return value is negative.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3decbb203846..3491c18edd71 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2947,6 +2947,7 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 		.config    = config,
 	};
+	int ret;
 
 	if (!temp.config) {
 		temp.config = strdup("event");
@@ -2957,9 +2958,20 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 	sym = &event_symbols_hw[idx];
 
 	str = strdup(sym->symbol);
-	if (!str)
+	if (!str) {
+		if (!config)
+			free(temp.config);
 		return -ENOMEM;
-	return new_term(term, &temp, str, 0);
+	}
+
+	ret = new_term(term, &temp, str, 0);
+	if (ret < 0) {
+		free(str);
+		if (!config)
+			free(temp.config);
+	}
+
+	return ret;
 }
 
 int parse_events_term__clone(struct parse_events_term **new,
@@ -2973,19 +2985,35 @@ int parse_events_term__clone(struct parse_events_term **new,
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
+		if (ret < 0 && term->config)
+			free(temp.config);
+		return ret;
+	}
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		if (term->config)
+			free(temp.config);
 		return -ENOMEM;
-	return new_term(new, &temp, str, 0);
+	}
+
+	ret = new_term(new, &temp, str, 0);
+	if (ret < 0) {
+		free(str);
+		if (term->config)
+			free(temp.config);
+	}
+
+	return ret;
 }
 
 void parse_events_term__delete(struct parse_events_term *term)
-- 
2.17.1

