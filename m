Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C654208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHLnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:43:50 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:44222 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgEHLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:43:50 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35eb545e604b-59572; Fri, 08 May 2020 19:43:35 +0800 (CST)
X-RM-TRANSID: 2ee35eb545e604b-59572
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95eb545e4639-9cc7f;
        Fri, 08 May 2020 19:43:35 +0800 (CST)
X-RM-TRANSID: 2ee95eb545e4639-9cc7f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] USB: EHCI: ehci-mv: Fix unused assignment in mv_ehci_probe()
Date:   Fri,  8 May 2020 19:44:09 +0800
Message-Id: <20200508114409.12704-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value, because 'retval' will be assigined
by the function mv_ehci_enable().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ehci-mv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index bd4f6ef53..1c079953e 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -108,7 +108,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	struct ehci_hcd *ehci;
 	struct ehci_hcd_mv *ehci_mv;
 	struct resource *r;
-	int retval = -ENODEV;
+	int retval;
 	u32 offset;
 
 	if (usb_disabled())
@@ -142,8 +142,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ehci_mv->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(ehci_mv->base)) {
-- 
2.20.1.windows.1



