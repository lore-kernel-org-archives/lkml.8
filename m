Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBCDC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53852206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDVHTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:19:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgDVHTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:19:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4199B198215F3CCD6BE7;
        Wed, 22 Apr 2020 15:19:13 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:19:07 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <bernie@plugable.com>, <b.zolnierkie@samsung.com>,
        <yanaijie@huawei.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] video: udlfb: use true,false for bool variables
Date:   Wed, 22 Apr 2020 15:18:36 +0800
Message-ID: <20200422071836.49123-1-yanaijie@huawei.com>
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

drivers/video/fbdev/udlfb.c:67:12-19: WARNING: Assignment of 0/1 to bool
variable
drivers/video/fbdev/udlfb.c:68:12-20: WARNING: Assignment of 0/1 to bool
variable
drivers/video/fbdev/udlfb.c:69:12-18: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/udlfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 07905d385949..5b014b479f83 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -64,9 +64,9 @@ static const struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 /* module options */
-static bool console = 1; /* Allow fbcon to open framebuffer */
-static bool fb_defio = 1;  /* Detect mmap writes using page faults */
-static bool shadow = 1; /* Optionally disable shadow framebuffer */
+static bool console = true; /* Allow fbcon to open framebuffer */
+static bool fb_defio = true;  /* Detect mmap writes using page faults */
+static bool shadow = true; /* Optionally disable shadow framebuffer */
 static int pixel_limit; /* Optionally force a pixel resolution limit */
 
 struct dlfb_deferred_free {
-- 
2.21.1

