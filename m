Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C1C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C757621556
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDIIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:53:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgDIIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:53:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D2E4B838DBA7F81E605E;
        Thu,  9 Apr 2020 16:53:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:53:10 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <johan@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] USB: serial: garmin_gps: remove some defined but not used variables
Date:   Thu, 9 Apr 2020 16:51:43 +0800
Message-ID: <20200409085143.46078-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/usb/serial/garmin_gps.c:192:28: warning: ‘PRIVATE_REQ’ defined
but not used [-Wunused-const-variable=]
 static unsigned char const PRIVATE_REQ[]
                            ^~~~~~~~~~~
drivers/usb/serial/garmin_gps.c:186:28: warning: ‘GARMIN_STOP_PVT_REQ’
defined but not used [-Wunused-const-variable=]
 static unsigned char const GARMIN_STOP_PVT_REQ[]
                            ^~~~~~~~~~~~~~~~~~~
drivers/usb/serial/garmin_gps.c:184:28: warning: ‘GARMIN_START_PVT_REQ’
defined but not used [-Wunused-const-variable=]
 static unsigned char const GARMIN_START_PVT_REQ[]
                            ^~~~~~~~~~~~~~~~~~~~
drivers/usb/serial/garmin_gps.c:182:28: warning:
‘GARMIN_APP_LAYER_REPLY’ defined but not used [-Wunused-const-variable=]
 static unsigned char const GARMIN_APP_LAYER_REPLY[]
                            ^~~~~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/serial/garmin_gps.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index ffd984142171..3b39d1e39fbf 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -179,19 +179,10 @@ static unsigned char const GARMIN_START_SESSION_REPLY[]
 	= { 0, 0, 0, 0,  6, 0, 0, 0, 4, 0, 0, 0 };
 static unsigned char const GARMIN_BULK_IN_AVAIL_REPLY[]
 	= { 0, 0, 0, 0,  2, 0, 0, 0, 0, 0, 0, 0 };
-static unsigned char const GARMIN_APP_LAYER_REPLY[]
-	= { 0x14, 0, 0, 0 };
-static unsigned char const GARMIN_START_PVT_REQ[]
-	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 49, 0 };
-static unsigned char const GARMIN_STOP_PVT_REQ[]
-	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 50, 0 };
 static unsigned char const GARMIN_STOP_TRANSFER_REQ[]
 	= { 20, 0, 0, 0,  10, 0, 0, 0, 2, 0, 0, 0, 0, 0 };
 static unsigned char const GARMIN_STOP_TRANSFER_REQ_V2[]
 	= { 20, 0, 0, 0,  10, 0, 0, 0, 1, 0, 0, 0, 0 };
-static unsigned char const PRIVATE_REQ[]
-	=    { 0x4B, 0x6E, 0x10, 0x01,  0xFF, 0, 0, 0, 0xFF, 0, 0, 0 };
-
 
 
 static const struct usb_device_id id_table[] = {
-- 
2.17.2

