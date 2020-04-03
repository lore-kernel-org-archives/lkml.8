Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9025C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B69206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbgDCBfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:35:06 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3990 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390163AbgDCBfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:35:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e86929b433-664e8; Fri, 03 Apr 2020 09:34:19 +0800 (CST)
X-RM-TRANSID: 2ee55e86929b433-664e8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e8692934ad-0cf03;
        Fri, 03 Apr 2020 09:34:16 +0800 (CST)
X-RM-TRANSID: 2ee25e8692934ad-0cf03
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     jun.nie@linaro.org, shawnguo@kernel.org, linux@armlinux.org.uk
Cc:     Markus.Elfring@web.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ARM:zx:Delete duplicate dev_err message in zx296702_pd_probe()
Date:   Fri,  3 Apr 2020 09:35:41 +0800
Message-Id: <20200403013541.20904-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this place,devm_ioremap_resource() has already contains error
message, so delete the duplicate dev_err message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index 7a08bf9dd..ac44ea8e6 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	}
 
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcubase)) {
-		dev_err(&pdev->dev, "ioremap fail.\n");
+	if (IS_ERR(pcubase))
 		return -EIO;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
 		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
-- 
2.20.1.windows.1



