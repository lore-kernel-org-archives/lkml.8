Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE2C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1220679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgASMS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 07:18:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgASMS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:18:28 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D748BB7BBD5755883CC;
        Sun, 19 Jan 2020 20:18:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 20:18:17 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>, <b.zolnierkie@samsung.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/4] video: fbdev: remove set but not used variable 'hSyncPol'
Date:   Sun, 19 Jan 2020 20:17:27 +0800
Message-ID: <20200119121730.10701-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200119121730.10701-1-yukuai3@huawei.com>
References: <20200119121730.10701-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/aty/radeon_base.c: In function
‘radeonfb_set_par’:
drivers/video/fbdev/aty/radeon_base.c:1653:6: warning: variable
‘hSyncPol’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 3af00e3b965e..d2e68ec580c2 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *mode = &info->var;
 	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
-	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
+	    vSyncStart, vSyncEnd, vSyncPol, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
 	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
@@ -1730,7 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
 	else if (vsync_wid > 0x1f)	/* max */
 		vsync_wid = 0x1f;
 
-	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
 	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
 
 	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
-- 
2.17.2

