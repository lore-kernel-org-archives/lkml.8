Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8779C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48C5206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHIUeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:34:20 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:38942 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgHIUeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 16:34:20 -0400
Received: from localhost.localdomain ([93.22.38.137])
        by mwinf5d52 with ME
        id DYa8230082xYfe503Ya9Dl; Sun, 09 Aug 2020 22:34:17 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2020 22:34:17 +0200
X-ME-IP: 93.22.38.137
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, sumit.semwal@linaro.org,
        colton.w.lewis@protonmail.com, Ori.Messinger@amd.com,
        m.szyprowski@samsung.com, bernard@vivo.com,
        dri-devel@lists.freedesktop.org
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm: amdgpu: Use the correct size when allocating memory
Date:   Sun,  9 Aug 2020 22:34:06 +0200
Message-Id: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When '*sgt' is allocated, we must allocated 'sizeof(**sgt)' bytes instead
of 'sizeof(*sg)'. 'sg' (i.e. struct scatterlist) is smaller than
'sgt' (i.e struct sg_table), so this could lead to memory corruption.

Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 134cc36e30c5..0739e259bf91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -462,7 +462,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	unsigned int pages;
 	int i, r;
 
-	*sgt = kmalloc(sizeof(*sg), GFP_KERNEL);
+	*sgt = kmalloc(sizeof(**sgt), GFP_KERNEL);
 	if (!*sgt)
 		return -ENOMEM;
 
-- 
2.25.1

