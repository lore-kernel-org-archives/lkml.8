Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4205C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD467221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIJVWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:22:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731093AbgIJOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D10AC4939D9A164253A6;
        Thu, 10 Sep 2020 22:06:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:06:37 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <timur@kernel.org>, <b.zolnierkie@samsung.com>,
        <gustavoars@kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] video: fbdev: fsl-diu-fb: remove unneeded variable 'res'
Date:   Thu, 10 Sep 2020 22:05:58 +0800
Message-ID: <20200910140558.1191423-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/video/fbdev/fsl-diu-fb.c:1428:5-8: Unneeded variable: "res".
Return "0" on line 1450

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index a547c21c7e92..e332017c6af6 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1425,7 +1425,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
 static int fsl_diu_release(struct fb_info *info, int user)
 {
 	struct mfb_info *mfbi = info->par;
-	int res = 0;
 
 	spin_lock(&diu_lock);
 	mfbi->count--;
@@ -1447,7 +1446,7 @@ static int fsl_diu_release(struct fb_info *info, int user)
 	}
 
 	spin_unlock(&diu_lock);
-	return res;
+	return 0;
 }
 
 static const struct fb_ops fsl_diu_ops = {
-- 
2.25.4

