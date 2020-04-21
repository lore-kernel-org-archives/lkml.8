Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B7C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBA22070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgDUMb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:31:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728316AbgDUMbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:31:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE4F6D2A0D9CBF5A7CAF;
        Tue, 21 Apr 2020 20:31:20 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Apr 2020 20:31:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/nouveau/acr: Use kmemdup instead of kmalloc and memcpy
Date:   Tue, 21 Apr 2020 20:37:31 +0800
Message-ID: <1587472651-105308-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c:103:23-30: WARNING opportunity for kmemdup
drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c:113:22-29: WARNING opportunity for kmemdup

Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
index aecce2d..667fa01 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
@@ -100,25 +100,21 @@ nvkm_acr_hsfw_load_image(struct nvkm_acr *acr, const char *name, int ver,
 	hsfw->data_size = lhdr->data_size;
 
 	hsfw->sig.prod.size = fwhdr->sig_prod_size;
-	hsfw->sig.prod.data = kmalloc(hsfw->sig.prod.size, GFP_KERNEL);
+	hsfw->sig.prod.data = kmemdup(fw->data + fwhdr->sig_prod_offset + sig,
+				      hsfw->sig.prod.size, GFP_KERNEL);
 	if (!hsfw->sig.prod.data) {
 		ret = -ENOMEM;
 		goto done;
 	}
 
-	memcpy(hsfw->sig.prod.data, fw->data + fwhdr->sig_prod_offset + sig,
-	       hsfw->sig.prod.size);
-
 	hsfw->sig.dbg.size = fwhdr->sig_dbg_size;
-	hsfw->sig.dbg.data = kmalloc(hsfw->sig.dbg.size, GFP_KERNEL);
+	hsfw->sig.dbg.data = kmemdup(fw->data + fwhdr->sig_dbg_offset + sig,
+				     hsfw->sig.dbg.size, GFP_KERNEL);
 	if (!hsfw->sig.dbg.data) {
 		ret = -ENOMEM;
 		goto done;
 	}
 
-	memcpy(hsfw->sig.dbg.data, fw->data + fwhdr->sig_dbg_offset + sig,
-	       hsfw->sig.dbg.size);
-
 	hsfw->sig.patch_loc = loc;
 done:
 	nvkm_firmware_put(fw);
-- 
2.6.2

