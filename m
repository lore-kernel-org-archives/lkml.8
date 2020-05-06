Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CFAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B121206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEFGSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:18:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgEFGSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:18:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3A1678CC74D9F94A02ED;
        Wed,  6 May 2020 14:18:30 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 14:18:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <b.zolnierkie@samsung.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] video: fbdev: pxa168fb: make pxa168fb_init_mode() return void
Date:   Wed, 6 May 2020 14:17:45 +0800
Message-ID: <20200506061745.19451-1-yanaijie@huawei.com>
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

No other functions use the return value of pxa168fb_init_mode() and the
return value is always 0 now. Make it return void. This fixes the
following coccicheck warning:

drivers/video/fbdev/pxa168fb.c:565:5-8: Unneeded variable: "ret". Return
"0" on line 597

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/pxa168fb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index aef8a3042590..eedfbd3572a8 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -557,12 +557,11 @@ static const struct fb_ops pxa168fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int pxa168fb_init_mode(struct fb_info *info,
+static void pxa168fb_init_mode(struct fb_info *info,
 			      struct pxa168fb_mach_info *mi)
 {
 	struct pxa168fb_info *fbi = info->par;
 	struct fb_var_screeninfo *var = &info->var;
-	int ret = 0;
 	u32 total_w, total_h, refresh;
 	u64 div_result;
 	const struct fb_videomode *m;
@@ -593,8 +592,6 @@ static int pxa168fb_init_mode(struct fb_info *info,
 	div_result = 1000000000000ll;
 	do_div(div_result, total_w * total_h * refresh);
 	var->pixclock = (u32)div_result;
-
-	return ret;
 }
 
 static int pxa168fb_probe(struct platform_device *pdev)
-- 
2.21.1

