Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5985C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977C920781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgGWD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:26:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729401AbgGWD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:26:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 75FB77FF8DAD8F8D1986;
        Thu, 23 Jul 2020 11:26:14 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:26:10 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] drm: Remove redundant NULL check
Date:   Thu, 23 Jul 2020 11:27:42 +0800
Message-ID: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/gpu/drm/drm_drv.c:819:2-7: WARNING: NULL check before some freeing functions is not needed.

Fixes: 5dad34f3c444 ("drm: Cleanups after drmm_add_final_kfree rollout")
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/gpu/drm/drm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index bc38322..13068fd 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -815,8 +815,7 @@ static void drm_dev_release(struct kref *ref)
 
 	drm_managed_release(dev);
 
-	if (dev->managed.final_kfree)
-		kfree(dev->managed.final_kfree);
+	kfree(dev->managed.final_kfree);
 }
 
 /**
-- 
2.7.4

