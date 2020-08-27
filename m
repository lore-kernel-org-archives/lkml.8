Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49569207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH0NWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:22:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbgH0NRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:17:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5615799FE8BD911E23F4;
        Thu, 27 Aug 2020 21:01:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 21:01:06 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jgg@ziepe.ca>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/nouveau/svm: remove set but not used 'ret'
Date:   Thu, 27 Aug 2020 21:00:47 +0800
Message-ID: <20200827130047.429089-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/gpu/drm/nouveau/nouveau_svm.c: In function ‘nouveau_pfns_map’:
drivers/gpu/drm/nouveau/nouveau_svm.c:818:6: warning: variable ‘ret’ set
but not used [-Wunused-but-set-variable]
  818 |  int ret;
      |      ^~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 2df1c0460559..7c95ffcbd18f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -815,7 +815,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		 unsigned long addr, u64 *pfns, unsigned long npages)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
-	int ret;
 
 	args->p.addr = addr;
 	args->p.size = npages << PAGE_SHIFT;
@@ -823,8 +822,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 	mutex_lock(&svmm->mutex);
 
 	svmm->vmm->vmm.object.client->super = true;
-	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
-				npages * sizeof(args->p.phys[0]), NULL);
+	nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+			  npages * sizeof(args->p.phys[0]), NULL);
 	svmm->vmm->vmm.object.client->super = false;
 
 	mutex_unlock(&svmm->mutex);
-- 
2.25.4

