Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D518C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2952081E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgASMS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 07:18:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgASMS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:18:28 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A20637D8C28224291A16;
        Sun, 19 Jan 2020 20:18:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 20:18:19 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>, <b.zolnierkie@samsung.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 4/4] video: fbdev: remove set but not used variable 'bytpp'
Date:   Sun, 19 Jan 2020 20:17:30 +0800
Message-ID: <20200119121730.10701-5-yukuai3@huawei.com>
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
drivers/video/fbdev/aty/radeon_base.c:1660:32: warning:
variable ‘bytpp’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 7d2ee889ffcd..22b3ee4f2ffa 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1657,7 +1657,7 @@ static int radeonfb_set_par(struct fb_info *info)
 	int i, freq;
 	int format = 0;
 	int nopllcalc = 0;
-	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
+	int hsync_start, hsync_fudge, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 	int use_rmx = 0;
@@ -1731,7 +1731,6 @@ static int radeonfb_set_par(struct fb_info *info)
 		vsync_wid = 0x1f;
 
 	format = radeon_get_dstbpp(depth);
-	bytpp = mode->bits_per_pixel >> 3;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD))
 		hsync_fudge = hsync_fudge_fp[format-1];
-- 
2.17.2

