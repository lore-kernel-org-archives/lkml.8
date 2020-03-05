Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3420717
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgCEMWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:22:39 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7367 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgCEMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:22:39 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e60eeef659-ff156; Thu, 05 Mar 2020 20:22:09 +0800 (CST)
X-RM-TRANSID: 2ee65e60eeef659-ff156
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.146.245])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e60eeeec2d-dd790;
        Thu, 05 Mar 2020 20:22:09 +0800 (CST)
X-RM-TRANSID: 2ee65e60eeeec2d-dd790
From:   tangbin <tangbin@cmss.chinamobile.com>
To:     davem@davemloft.net
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ethernet:broadcom:bcm63xx_enet:remove redundant variable definitions
Date:   Thu,  5 Mar 2020 20:22:59 +0800
Message-Id: <20200305122259.6104-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in this function,‘ret’ is always assigned,so this's definition
'ret = 0' make no sense.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 620cd3fc1..ea5087a8e 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1706,7 +1706,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	if (!res_irq || !res_irq_rx || !res_irq_tx)
 		return -ENODEV;
 
-	ret = 0;
 	dev = alloc_etherdev(sizeof(*priv));
 	if (!dev)
 		return -ENOMEM;
-- 
2.20.1.windows.1



