Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DBC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887A5206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDVHTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:19:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbgDVHTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:19:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6001DDB4B78D23B552C1;
        Wed, 22 Apr 2020 15:19:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:19:25 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <b.zolnierkie@samsung.com>, <arnd@arndb.de>,
        <jrdr.linux@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] fbdev: aty: use true,false for bool variables in atyfb_base.c
Date:   Wed, 22 Apr 2020 15:18:54 +0800
Message-ID: <20200422071854.513-1-yanaijie@huawei.com>
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

drivers/video/fbdev/aty/atyfb_base.c:3822:3-10: WARNING: Assignment of
0/1 to bool variable
drivers/video/fbdev/aty/atyfb_base.c:3824:3-9: WARNING: Assignment of
0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 49d192869cf5..b0ac895e5ac9 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3819,9 +3819,9 @@ static int __init atyfb_setup(char *options)
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "noaccel", 7)) {
-			noaccel = 1;
+			noaccel = true;
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
-			nomtrr = 1;
+			nomtrr = true;
 		} else if (!strncmp(this_opt, "vram:", 5))
 			vram = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
-- 
2.21.1

