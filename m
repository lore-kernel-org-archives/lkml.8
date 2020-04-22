Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1578D206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVHTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:19:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2831 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgDVHTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:19:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84F806D9E9DBBCAC755F;
        Wed, 22 Apr 2020 15:19:07 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:18:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <adaplas@gmail.com>, <b.zolnierkie@samsung.com>,
        <yanaijie@huawei.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] video: fbdev: i810: use true,false for bool variables
Date:   Wed, 22 Apr 2020 15:18:26 +0800
Message-ID: <20200422071826.49038-1-yanaijie@huawei.com>
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

drivers/video/fbdev/i810/i810_main.c:1969:3-7: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/i810/i810_main.c:1971:3-8: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/i810/i810_main.c:1973:3-9: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/i810/i810_main.c:1975:3-7: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/i810/i810_main.c:2001:3-9: WARNING: Assignment of
0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/i810/i810_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index aa7583d963ac..13bbf7fe13bf 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -1966,13 +1966,13 @@ static int i810fb_setup(char *options)
 	
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "mtrr", 4))
-			mtrr = 1;
+			mtrr = true;
 		else if (!strncmp(this_opt, "accel", 5))
-			accel = 1;
+			accel = true;
 		else if (!strncmp(this_opt, "extvga", 6))
-			extvga = 1;
+			extvga = true;
 		else if (!strncmp(this_opt, "sync", 4))
-			sync = 1;
+			sync = true;
 		else if (!strncmp(this_opt, "vram:", 5))
 			vram = (simple_strtoul(this_opt+5, NULL, 0));
 		else if (!strncmp(this_opt, "voffset:", 8))
@@ -1998,7 +1998,7 @@ static int i810fb_setup(char *options)
 		else if (!strncmp(this_opt, "vsync2:", 7))
 			vsync2 = simple_strtoul(this_opt+7, NULL, 0);
 		else if (!strncmp(this_opt, "dcolor", 6))
-			dcolor = 1;
+			dcolor = true;
 		else if (!strncmp(this_opt, "ddc3", 4))
 			ddc3 = true;
 		else
-- 
2.21.1

