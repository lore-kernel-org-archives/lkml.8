Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6733BC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C74206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgDBL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:26:34 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5389 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:26:33 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e85cbd7fa3-5e0c4; Thu, 02 Apr 2020 19:26:16 +0800 (CST)
X-RM-TRANSID: 2eea5e85cbd7fa3-5e0c4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e85cbd6d65-4831c;
        Thu, 02 Apr 2020 19:26:16 +0800 (CST)
X-RM-TRANSID: 2ee35e85cbd6d65-4831c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     thor.thayer@linux.intel.com, bp@alien8.de
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] EDAC/altera:Use platform_get_irq_optional()
Date:   Thu,  2 Apr 2020 19:27:40 +0800
Message-Id: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simply code,because platform_get_irq() already has
dev_err() message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e91cf1147..e12bad148 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2099,7 +2099,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	edac->sb_irq = platform_get_irq(pdev, 0);
+	edac->sb_irq = platform_get_irq_optional(pdev, 0);
 	if (edac->sb_irq < 0) {
 		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
 		return edac->sb_irq;
@@ -2134,7 +2134,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		}
 	}
 #else
-	edac->db_irq = platform_get_irq(pdev, 1);
+	edac->db_irq = platform_get_irq_optional(pdev, 1);
 	if (edac->db_irq < 0) {
 		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
 		return edac->db_irq;
-- 
2.20.1.windows.1



