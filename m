Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF723C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89D3206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgDVHTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:19:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbgDVHT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:19:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 962E14C4598441586B28;
        Wed, 22 Apr 2020 15:19:25 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:19:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <spock@gentoo.org>, <b.zolnierkie@samsung.com>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] video: uvesafb: use true,false for bool variables
Date:   Wed, 22 Apr 2020 15:18:45 +0800
Message-ID: <20200422071845.403-1-yanaijie@huawei.com>
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

drivers/video/fbdev/uvesafb.c:48:12-17: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1827:3-13: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1829:3-13: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1835:3-9: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1837:3-9: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1839:3-8: WARNING: Assignment of 0/1 to
bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/uvesafb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 1b385cf76110..bee29aadc646 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -45,7 +45,7 @@ static const struct fb_fix_screeninfo uvesafb_fix = {
 };
 
 static int mtrr		= 3;	/* enable mtrr by default */
-static bool blank	= 1;	/* enable blanking by default */
+static bool blank	= true;	/* enable blanking by default */
 static int ypan		= 1;	/* 0: scroll, 1: ypan, 2: ywrap */
 static bool pmi_setpal	= true; /* use PMI for palette changes */
 static bool nocrtc;		/* ignore CRTC settings */
@@ -1824,19 +1824,19 @@ static int uvesafb_setup(char *options)
 		else if (!strcmp(this_opt, "ywrap"))
 			ypan = 2;
 		else if (!strcmp(this_opt, "vgapal"))
-			pmi_setpal = 0;
+			pmi_setpal = false;
 		else if (!strcmp(this_opt, "pmipal"))
-			pmi_setpal = 1;
+			pmi_setpal = true;
 		else if (!strncmp(this_opt, "mtrr:", 5))
 			mtrr = simple_strtoul(this_opt+5, NULL, 0);
 		else if (!strcmp(this_opt, "nomtrr"))
 			mtrr = 0;
 		else if (!strcmp(this_opt, "nocrtc"))
-			nocrtc = 1;
+			nocrtc = true;
 		else if (!strcmp(this_opt, "noedid"))
-			noedid = 1;
+			noedid = true;
 		else if (!strcmp(this_opt, "noblank"))
-			blank = 0;
+			blank = true;
 		else if (!strncmp(this_opt, "vtotal:", 7))
 			vram_total = simple_strtoul(this_opt + 7, NULL, 0);
 		else if (!strncmp(this_opt, "vremap:", 7))
-- 
2.21.1

