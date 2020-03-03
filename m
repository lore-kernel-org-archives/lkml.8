Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45705C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3A821556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgCCJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:30:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbgCCJa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:30:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63E242D7F5A184E362CF;
        Tue,  3 Mar 2020 17:30:22 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 17:30:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hverkuil@xs4all.nl>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>,
        <tglx@linutronix.de>
CC:     <linux-media@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: media: usbvision: Add missing MEDIA_USB_SUPPORT dependency
Date:   Tue, 3 Mar 2020 17:27:47 +0800
Message-ID: <20200303092747.28360-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_USBVISION driver depends on MEDIA_USB_SUPPORT

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8fb12ce2ec9d ("media: usbvision: deprecate driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/media/usbvision/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/usbvision/Kconfig b/drivers/staging/media/usbvision/Kconfig
index 7903f55..c6e1afb 100644
--- a/drivers/staging/media/usbvision/Kconfig
+++ b/drivers/staging/media/usbvision/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_USBVISION
 	tristate "USB video devices based on Nogatech NT1003/1004/1005 (Deprecated)"
-	depends on I2C && VIDEO_V4L2
+	depends on MEDIA_USB_SUPPORT && I2C && VIDEO_V4L2
 	select VIDEO_TUNER
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	help
-- 
2.7.4


