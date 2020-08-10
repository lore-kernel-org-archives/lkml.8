Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41062073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Qz89oKOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgHJHYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:24:48 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:41362 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgHJHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:24:46 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6319A2E148C;
        Mon, 10 Aug 2020 10:24:37 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id eplW9mMzEm-OavW9D1P;
        Mon, 10 Aug 2020 10:24:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1597044277; bh=vbf8E50bAMn2mMcslKfEYc1hfR34ZPwQ7ks+FfOd7Aw=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=Qz89oKOR3pBO9A/C1nklYJzkqb1kf9ABYnhKinmZEBnZWYgTcevJwEtXhmNXpeCcq
         0VFYJ+EUB0BNGsctz9cJdFam/RLJ9LUGCcyoxdRDRi8fcOsk2hkzq5QbxzpDN5DA6G
         Ot/ojGvVjtfyRLGIT5K3NQe3C1m6ZrUqbq3fhOa4=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id d9H7pBQLnC-OalSKWCS;
        Mon, 10 Aug 2020 10:24:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     koct9i@gmail.com, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH 1/2] lib/test_lockup.c: add measure_alloc_pages_wait option
Date:   Mon, 10 Aug 2020 07:24:25 +0000
Message-Id: <20200810072426.7180-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

measure_alloc_pages_wait=Y  measure maximum page allocation wait time

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 lib/test_lockup.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 0f81252..867b2f4 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -77,6 +77,10 @@ static bool call_cond_resched;
 module_param(call_cond_resched, bool, 0600);
 MODULE_PARM_DESC(call_cond_resched, "call cond_resched() between iterations");
 
+static bool measure_alloc_pages_wait;
+module_param(measure_alloc_pages_wait, bool, 0400);
+MODULE_PARM_DESC(measure_alloc_pages_wait, "measure page allocation wait time");
+
 static bool measure_lock_wait;
 module_param(measure_lock_wait, bool, 0400);
 MODULE_PARM_DESC(measure_lock_wait, "measure lock wait time");
@@ -162,6 +166,7 @@ MODULE_PARM_DESC(lock_sb_umount, "lock file -> sb -> s_umount");
 static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
 
 static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
+static atomic64_t max_alloc_pages_wait = ATOMIC64_INIT(0);
 
 static struct task_struct *main_task;
 static int master_cpu;
@@ -305,6 +310,10 @@ static void test_alloc_pages(struct list_head *pages)
 {
 	struct page *page;
 	unsigned int i;
+	u64 wait_start;
+
+	if (measure_alloc_pages_wait)
+		wait_start = local_clock();
 
 	for (i = 0; i < alloc_pages_nr; i++) {
 		page = alloc_pages(alloc_pages_gfp, alloc_pages_order);
@@ -314,6 +323,17 @@ static void test_alloc_pages(struct list_head *pages)
 		}
 		list_add(&page->lru, pages);
 	}
+	if (measure_alloc_pages_wait) {
+		s64 cur_wait = local_clock() - wait_start;
+		s64 max_wait = atomic64_read(&max_alloc_pages_wait);
+
+		do {
+			if (cur_wait < max_wait)
+				break;
+			max_wait = atomic64_cmpxchg(&max_alloc_pages_wait,
+						    max_wait, cur_wait);
+		} while (max_wait != cur_wait);
+	}
 }
 
 static void test_free_pages(struct list_head *pages)
@@ -578,10 +598,13 @@ static int __init test_lockup_init(void)
 		pr_notice("Maximum lock wait: %lld ns\n",
 			  atomic64_read(&max_lock_wait));
 
-	if (alloc_pages_nr)
+	if (alloc_pages_nr) {
 		pr_notice("Page allocation failed %u times\n",
 			  atomic_read(&alloc_pages_failed));
-
+		if (measure_alloc_pages_wait)
+			pr_notice("Maximum pages allocation wait: %lld ns\n",
+				  atomic64_read(&max_alloc_pages_wait));
+	}
 	pr_notice("FINISH in %llu ns\n", local_clock() - test_start);
 
 	if (test_file)
-- 
2.7.4

