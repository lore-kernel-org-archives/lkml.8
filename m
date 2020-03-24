Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF96C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D888208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgCXNUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:20:09 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7074 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgCXNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:20:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e7a08d2db9-91b8d; Tue, 24 Mar 2020 21:19:14 +0800 (CST)
X-RM-TRANSID: 2ee85e7a08d2db9-91b8d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.174.174])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e7a08cfa0f-0ed6c;
        Tue, 24 Mar 2020 21:19:14 +0800 (CST)
X-RM-TRANSID: 2ee85e7a08cfa0f-0ed6c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     cernekee@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        sergei.shtylyov@cogentembedded.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]usb: gadget: bcm63xx_udc:remove redundant variable assignment
Date:   Tue, 24 Mar 2020 21:20:29 +0800
Message-Id: <20200324132029.16296-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v1------------------------------------
In this function, the variable 'rc' is assigned after this place,
so the definition is invalid.

--v2------------------------------------
In this function, the variable 'rc' will be assigned by the function
'usb_add_gadget_udc()',so the assignment here is redundant,we should
remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/bcm63xx_udc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 54501814d..a7afa8c35 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2321,8 +2321,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = -ENXIO;
-
 	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.20.1.windows.1



