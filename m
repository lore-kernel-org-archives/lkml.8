Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6F420855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgHTMVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:21:00 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:12052 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgHTMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:20:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85f3e6a814ba-e3f62; Thu, 20 Aug 2020 20:20:18 +0800 (CST)
X-RM-TRANSID: 2ee85f3e6a814ba-e3f62
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75f3e6a7f13e-2fed8;
        Thu, 20 Aug 2020 20:20:17 +0800 (CST)
X-RM-TRANSID: 2ee75f3e6a7f13e-2fed8
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: hcd: fix the error check
Date:   Thu, 20 Aug 2020 20:20:38 +0800
Message-Id: <20200820122038.18704-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function usb_add_hcd(), usb_phy_roothub_alloc()
can return NULL in some cases, so IS_ERR() doesn't meet
the requirements. Thus fix it.
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/core/hcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index aa45840d8..b73a92ee1 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2633,8 +2633,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
-		if (IS_ERR(hcd->phy_roothub))
-			return PTR_ERR(hcd->phy_roothub);
+		if (IS_ERR_OR_NULL(hcd->phy_roothub))
+			return hcd->phy_roothub ?
+					PTR_ERR(hcd->phy_roothub) : -ENODEV;
 
 		retval = usb_phy_roothub_init(hcd->phy_roothub);
 		if (retval)
-- 
2.20.1.windows.1



