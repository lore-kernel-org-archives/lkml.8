Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A8DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6462084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgAPD3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:29:04 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53451 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAPD3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:29:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TnrNuc._1579145331;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TnrNuc._1579145331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:29:00 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [V2 1/3] firmware: arm_sdei: fix possible deadlock
Date:   Thu, 16 Jan 2020 11:28:49 +0800
Message-Id: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call sdei_reregister_event() with sdei_list_lock held but
_sdei_event_register() and sdei_event_destroy() also acquires
sdei_list_lock thus creating A-A deadlock.

Fixes: da351827240e ("firmware: arm_sdei: Add support for CPU and system
power states")

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a479023..37e9bf0 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -45,8 +45,11 @@ static asmlinkage void (*sdei_firmware_call)(unsigned long function_id,
 static unsigned long sdei_entry_point;
 
 struct sdei_event {
-	/* These three are protected by the sdei_list_lock */
+	/* protected by the sdei_list_lock */
 	struct list_head	list;
+
+	spinlock_t		sdei_event_lock;
+	/* These two are protected by the sdei_event_lock */
 	bool			reregister;
 	bool			reenable;
 
@@ -214,6 +217,7 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&event->list);
+	spin_lock_init(&event->sdei_event_lock);
 	event->event_num = event_num;
 
 	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
@@ -412,9 +416,9 @@ int sdei_event_enable(u32 event_num)
 		return -ENOENT;
 	}
 
-	spin_lock(&sdei_list_lock);
+	spin_lock(&event->sdei_event_lock);
 	event->reenable = true;
-	spin_unlock(&sdei_list_lock);
+	spin_unlock(&event->sdei_event_lock);
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		err = sdei_api_event_enable(event->event_num);
@@ -491,10 +495,10 @@ static int _sdei_event_unregister(struct sdei_event *event)
 {
 	lockdep_assert_held(&sdei_events_lock);
 
-	spin_lock(&sdei_list_lock);
+	spin_lock(&event->sdei_event_lock);
 	event->reregister = false;
 	event->reenable = false;
-	spin_unlock(&sdei_list_lock);
+	spin_unlock(&event->sdei_event_lock);
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		return sdei_api_event_unregister(event->event_num);
@@ -585,9 +589,9 @@ static int _sdei_event_register(struct sdei_event *event)
 
 	lockdep_assert_held(&sdei_events_lock);
 
-	spin_lock(&sdei_list_lock);
+	spin_lock(&event->sdei_event_lock);
 	event->reregister = true;
-	spin_unlock(&sdei_list_lock);
+	spin_unlock(&event->sdei_event_lock);
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		return sdei_api_event_register(event->event_num,
@@ -598,10 +602,10 @@ static int _sdei_event_register(struct sdei_event *event)
 
 	err = sdei_do_cross_call(_local_event_register, event);
 	if (err) {
-		spin_lock(&sdei_list_lock);
+		spin_lock(&event->sdei_event_lock);
 		event->reregister = false;
 		event->reenable = false;
-		spin_unlock(&sdei_list_lock);
+		spin_unlock(&event->sdei_event_lock);
 
 		sdei_do_cross_call(_local_event_unregister, event);
 	}
-- 
1.8.3.1

