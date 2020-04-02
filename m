Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8420EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596C7206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgDBL6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:58:54 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:4025 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgDBL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:58:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95e85d353400-5e391; Thu, 02 Apr 2020 19:58:13 +0800 (CST)
X-RM-TRANSID: 2ee95e85d353400-5e391
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e85d352867-4b2fc;
        Thu, 02 Apr 2020 19:58:12 +0800 (CST)
X-RM-TRANSID: 2ee35e85d352867-4b2fc
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] perf:Avoid duplicate printouts
Date:   Thu,  2 Apr 2020 19:59:40 +0800
Message-Id: <20200402115940.4928-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because platform_get_irq() has dev_err(),so this place
should be removed.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/perf/arm_dsu_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 70968c8c0..518d0603e 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -690,10 +690,8 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_warn(&pdev->dev, "Failed to find IRQ\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_%d",
 				PMUNAME, atomic_inc_return(&pmu_idx));
-- 
2.20.1.windows.1



