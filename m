Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E301AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA32621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394451AbgDPOl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:41:28 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3502 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394437AbgDPOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:41:09 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e986e74448-87478; Thu, 16 Apr 2020 22:40:57 +0800 (CST)
X-RM-TRANSID: 2ee15e986e74448-87478
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.7])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e986e750b1-26b7b;
        Thu, 16 Apr 2020 22:40:57 +0800 (CST)
X-RM-TRANSID: 2ee45e986e750b1-26b7b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] drm/tegra: dc: Use devm_platform_ioremap_resource() to simplify code
Date:   Thu, 16 Apr 2020 22:42:40 +0800
Message-Id: <20200416144240.20184-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() instead of 
platform_get_resource()+ devm_ioremap_resource().

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/tegra/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index d26fb16d6..72c952b1a 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2503,7 +2503,6 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 
 static int tegra_dc_probe(struct platform_device *pdev)
 {
-	struct resource *regs;
 	struct tegra_dc *dc;
 	int err;
 
@@ -2560,8 +2559,7 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		tegra_powergate_power_off(dc->powergate);
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dc->regs = devm_ioremap_resource(&pdev->dev, regs);
+	dc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dc->regs))
 		return PTR_ERR(dc->regs);
 
-- 
2.20.1.windows.1



