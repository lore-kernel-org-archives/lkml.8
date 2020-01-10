Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C4C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03A02072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgAJHci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:32:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgAJHch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:32:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2915527788F637AE5125;
        Fri, 10 Jan 2020 15:32:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 15:32:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/ttm: Remove set but not used variable 'mem'
Date:   Fri, 10 Jan 2020 15:28:37 +0800
Message-ID: <20200110072837.48060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_vram_manager_new:
drivers/gpu/drm/nouveau/nouveau_ttm.c:66:22: warning: variable mem set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_gart_manager_new:
drivers/gpu/drm/nouveau/nouveau_ttm.c:106:22: warning: variable mem set but not used [-Wunused-but-set-variable]

They are not used any more, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 77a0c6a..7ca0a24 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -63,14 +63,12 @@ nouveau_vram_manager_new(struct ttm_mem_type_manager *man,
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
-	struct nouveau_mem *mem;
 	int ret;
 
 	if (drm->client.device.info.ram_size == 0)
 		return -ENOMEM;
 
 	ret = nouveau_mem_new(&drm->master, nvbo->kind, nvbo->comp, reg);
-	mem = nouveau_mem(reg);
 	if (ret)
 		return ret;
 
@@ -103,11 +101,9 @@ nouveau_gart_manager_new(struct ttm_mem_type_manager *man,
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
-	struct nouveau_mem *mem;
 	int ret;
 
 	ret = nouveau_mem_new(&drm->master, nvbo->kind, nvbo->comp, reg);
-	mem = nouveau_mem(reg);
 	if (ret)
 		return ret;
 
-- 
2.7.4


