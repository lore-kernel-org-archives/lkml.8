Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6323E21941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIJChB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:37:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbgIJCeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:34:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6ED9E922509EC3D6151A;
        Thu, 10 Sep 2020 10:33:59 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 10:33:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/ttm/agp: Fix Wunused-variable warning
Date:   Thu, 10 Sep 2020 10:33:45 +0800
Message-ID: <20200910023345.20428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_AGP is not set, gcc warns:

drivers/gpu/drm/radeon/radeon_ttm.c: In function ‘radeon_ttm_tt_bind’:
drivers/gpu/drm/radeon/radeon_ttm.c:692:24: warning: unused variable ‘rdev’ [-Wunused-variable]
  struct radeon_device *rdev = radeon_get_rdev(bdev);
                        ^~~~

Move it to ifdef block to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 31c63d339629..449e77eb75f9 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -689,9 +689,9 @@ static int radeon_ttm_tt_bind(struct ttm_bo_device *bdev,
 			      struct ttm_tt *ttm,
 			      struct ttm_resource *bo_mem)
 {
+#if IS_ENABLED(CONFIG_AGP)
 	struct radeon_device *rdev = radeon_get_rdev(bdev);
 
-#if IS_ENABLED(CONFIG_AGP)
 	if (rdev->flags & RADEON_IS_AGP)
 		return ttm_agp_bind(ttm, bo_mem);
 #endif
-- 
2.17.1


