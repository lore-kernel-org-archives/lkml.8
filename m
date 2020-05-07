Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB91C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FF320736
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEGLIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:08:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3841 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:08:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C346672F08BDD45CEBE;
        Thu,  7 May 2020 19:08:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:07:53 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux-graphics-maintainer@vmware.com>, <thellstrom@vmware.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <sumit.semwal@linaro.org>,
        <chris@chris-wilson.co.uk>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/vmwgfx: Return true in function vmw_fence_obj_signaled()
Date:   Thu, 7 May 2020 19:07:14 +0800
Message-ID: <20200507110714.37589-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/gpu/drm/vmwgfx/vmwgfx_fence.c:518:9-10: WARNING: return of 0/1
in function 'vmw_fence_obj_signaled' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 178a6cd1a06f..0f8d29397157 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -515,7 +515,7 @@ bool vmw_fence_obj_signaled(struct vmw_fence_obj *fence)
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
 	if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->base.flags))
-		return 1;
+		return true;
 
 	vmw_fences_update(fman);
 
-- 
2.21.1

