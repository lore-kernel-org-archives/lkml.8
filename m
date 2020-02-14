Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2CC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E38F24654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696983;
	bh=m/otNxC3zvJZKrphncMYDqdLByu/oTw6h9f5kpSGpsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAsqWPPBRPN2vDuqOVmL0vZRng5q4ih5W9WEQVxSzGTkcNyty+TIoS+d5XKapYp6H
	 dFHhbLi4iFqsnRO7IH5X8SXayZ8LMcUVigJLi2husrrAwiATBYANWIiIjVEaWmgtDK
	 doh1yoe7YbWfTFS0WxzAmYRfJeaEicXAQny6flr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392570AbgBNQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404124AbgBNQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511F5246D6;
        Fri, 14 Feb 2020 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696924;
        bh=m/otNxC3zvJZKrphncMYDqdLByu/oTw6h9f5kpSGpsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMMMYzczZflooo1LncFT8nZlGOYvroNP/OdOm0/WMUuUgMqZiMErABLkuwYx6KERs
         h4IwAgToKOwxEP0M1tcREdlZa7LSEvg36x6nfdm0ZLQKoOmCYvX63KtM9YVGvRvZu3
         SApByovQ346lKyoZzwKdTUSzpqqhmYtIiUjT3iiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 171/252] drm/nouveau/drm/ttm: Remove set but not used variable 'mem'
Date:   Fri, 14 Feb 2020 11:10:26 -0500
Message-Id: <20200214161147.15842-171-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 2e4534a22794746b11a794b2229b8d58797eccce ]

drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_vram_manager_new:
drivers/gpu/drm/nouveau/nouveau_ttm.c:66:22: warning: variable mem set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_gart_manager_new:
drivers/gpu/drm/nouveau/nouveau_ttm.c:106:22: warning: variable mem set but not used [-Wunused-but-set-variable]

They are not used any more, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index e4b977cc84528..37715a2a2f3f9 100644
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
2.20.1

