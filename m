Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56494C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9B42080C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 09:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDZJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:42:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbgDZJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:42:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E8D061B376164B7FFBA;
        Sun, 26 Apr 2020 17:42:28 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:42:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <heinzelmann.david@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] usb: core: hub: use true,false for bool variable
Date:   Sun, 26 Apr 2020 17:41:47 +0800
Message-ID: <20200426094147.23467-1-yanaijie@huawei.com>
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

drivers/usb/core/hub.c:95:12-28: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2b6565c06c23..8d2f49e92524 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -92,7 +92,7 @@ module_param(old_scheme_first, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(old_scheme_first,
 		 "start with the old device initialization scheme");
 
-static bool use_both_schemes = 1;
+static bool use_both_schemes = true;
 module_param(use_both_schemes, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(use_both_schemes,
 		"try the other device initialization scheme if the "
-- 
2.21.1

