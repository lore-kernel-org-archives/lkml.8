Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A730221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgDPOmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:42:36 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4376 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394466AbgDPOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:42:00 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e986e99474-87734; Thu, 16 Apr 2020 22:41:32 +0800 (CST)
X-RM-TRANSID: 2ee25e986e99474-87734
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.7])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e986e9a334-6c092;
        Thu, 16 Apr 2020 22:41:32 +0800 (CST)
X-RM-TRANSID: 2ee75e986e9a334-6c092
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] drm/tegra: dc: Omit superfluous error message in tegra_dc_probe()
Date:   Thu, 16 Apr 2020 22:43:17 +0800
Message-Id: <20200416144317.2036-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function tegra_dc_probe(), when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant message
here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/tegra/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 7c70fd31a..d26fb16d6 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2566,10 +2566,8 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->regs);
 
 	dc->irq = platform_get_irq(pdev, 0);
-	if (dc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dc->irq < 0)
 		return -ENXIO;
-	}
 
 	err = tegra_dc_rgb_probe(dc);
 	if (err < 0 && err != -ENODEV) {
-- 
2.20.1.windows.1



