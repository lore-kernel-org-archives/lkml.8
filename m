Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9FC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B65206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 07:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBWHew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 02:34:52 -0500
Received: from m97134.mail.qiye.163.com ([220.181.97.134]:58741 "EHLO
        m97134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBWHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 02:34:51 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 02:34:50 EST
Received: from localhost.localdomain (unknown [117.136.64.95])
        by smtp5 (Coremail) with SMTP id huCowACXRfTCKVJeJF5lAA--.4940S2;
        Sun, 23 Feb 2020 15:29:07 +0800 (CST)
From:   Yu Chen <chen.yu@easystack.cn>
To:     tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, 33988979@163.com,
        Yu Chen <chen.yu@easystack.cn>
Subject: [PATCH] workqueue: Make workqueue_init*() return void
Date:   Sun, 23 Feb 2020 15:28:52 +0800
Message-Id: <20200223072852.3954-1-chen.yu@easystack.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: huCowACXRfTCKVJeJF5lAA--.4940S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUkWlkUUUUU
X-Originating-IP: [117.136.64.95]
X-CM-SenderInfo: hfkh0h11x6vtxv1v3tlfnou0/1tbihwPSoFtVgbqpuAAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return values of workqueue_init() and workqueue_early_int() are 
always 0, and there is no usage of their return value.  So just make 
them return void.

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
---
 include/linux/workqueue.h | 4 ++--
 kernel/workqueue.c        | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4261d1c6e..c86a7691e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -649,7 +649,7 @@ int workqueue_online_cpu(unsigned int cpu);
 int workqueue_offline_cpu(unsigned int cpu);
 #endif
 
-int __init workqueue_init_early(void);
-int __init workqueue_init(void);
+void __init workqueue_init_early(void);
+void __init workqueue_init(void);
 
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cfc923558..12f491e9c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5896,7 +5896,7 @@ static void __init wq_numa_init(void)
  * items.  Actual work item execution starts only after kthreads can be
  * created and scheduled right before early initcalls.
  */
-int __init workqueue_init_early(void)
+void __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
 	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
@@ -5963,8 +5963,6 @@ int __init workqueue_init_early(void)
 	       !system_unbound_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq);
-
-	return 0;
 }
 
 /**
@@ -5976,7 +5974,7 @@ int __init workqueue_init_early(void)
  * are no kworkers executing the work items yet.  Populate the worker pools
  * with the initial workers and enable future kworker creations.
  */
-int __init workqueue_init(void)
+void __init workqueue_init(void)
 {
 	struct workqueue_struct *wq;
 	struct worker_pool *pool;
@@ -6023,6 +6021,4 @@ int __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
-
-	return 0;
 }
-- 
2.17.1


