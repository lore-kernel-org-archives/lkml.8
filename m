Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D5620787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:34:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgDJHex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:34:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 58349A7B08DB092E22CC;
        Fri, 10 Apr 2020 15:34:51 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 15:34:43 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] tracing: make some symbols static in tracing_map.c
Date:   Fri, 10 Apr 2020 15:33:12 +0800
Message-ID: <20200410073312.38855-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

kernel/trace/tracing_map.c:286:6: warning: symbol
'tracing_map_array_clear' was not declared. Should it be static?
kernel/trace/tracing_map.c:297:6: warning: symbol
'tracing_map_array_free' was not declared. Should it be static?
kernel/trace/tracing_map.c:319:26: warning: symbol
'tracing_map_array_alloc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 kernel/trace/tracing_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9e31bfc818ff..74738c9856f1 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -283,7 +283,7 @@ int tracing_map_add_key_field(struct tracing_map *map,
 	return idx;
 }
 
-void tracing_map_array_clear(struct tracing_map_array *a)
+static void tracing_map_array_clear(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -294,7 +294,7 @@ void tracing_map_array_clear(struct tracing_map_array *a)
 		memset(a->pages[i], 0, PAGE_SIZE);
 }
 
-void tracing_map_array_free(struct tracing_map_array *a)
+static void tracing_map_array_free(struct tracing_map_array *a)
 {
 	unsigned int i;
 
@@ -316,7 +316,7 @@ void tracing_map_array_free(struct tracing_map_array *a)
 	kfree(a);
 }
 
-struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
+static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 						  unsigned int entry_size)
 {
 	struct tracing_map_array *a;
-- 
2.17.2

