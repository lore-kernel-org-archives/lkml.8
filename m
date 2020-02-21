Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB0C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD0324697
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273450;
	bh=m/otNxC3zvJZKrphncMYDqdLByu/oTw6h9f5kpSGpsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTHO4mjInWn5Vkg8qqD2XkWkQCRKqaWPEg2BTMWF6p0cHNcNv2/4S/4BgRelygxAR
	 Ft9J7/+k77f2jqjCi69i/23kXKZHTV57IUCx0wFtSwpkmIF+mI29VGecFbYpW4h3Mh
	 NuqYPz+dffkuBBzcnZ67mreGZT4FaXR51WHHFkPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgBUIYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388287AbgBUIYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC51A206ED;
        Fri, 21 Feb 2020 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273443;
        bh=m/otNxC3zvJZKrphncMYDqdLByu/oTw6h9f5kpSGpsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiNPEteuG9/lB4JPEevXiL5LxgctTsYcVYpDA6jhcFnmJzHkdiwMhzIhbTpDRkfb+
         de7DqTVsuJvx2cA/U9u+YfMrJ/QAtPL5XJb0q7ScIEt+SEmNcvtcJPK/L8WOHPaFHm
         OUIF5SWUPjtaG+2Acbo42xXrbVIuy/gclO49zV80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 126/191] drm/nouveau/drm/ttm: Remove set but not used variable mem
Date:   Fri, 21 Feb 2020 08:41:39 +0100
Message-Id: <20200221072306.079147050@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



