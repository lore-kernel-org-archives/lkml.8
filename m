Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C567C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB520684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199255;
	bh=ZqBmkNKNIAGdrCvpviL0rMZ9lGAJ38uw6Vtvogqa+MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFoWSEfPf+xSUzZPkDSIZtctnSGFHe8OVKBhvjDfq1vpTvQBtspd4sIZERT5SSj+U
	 b0ZnO9gWbrFHcxeD9mUZs5oOh/r+P5SPNp/pOoRQW0ZVbeOnqswHE8q3Y8TA8c46Xj
	 H5P2v9FEBJSPV2aHl2eb8KxScAUeVOLdJ1CapuwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgAPR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392286AbgAPR0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD27246CD;
        Thu, 16 Jan 2020 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195578;
        bh=ZqBmkNKNIAGdrCvpviL0rMZ9lGAJ38uw6Vtvogqa+MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aInXhrP79BDL9exGSw/rLRkbNo9oNHCDZrLEW7tn9nfLHykWqFDhZcZwTab+52wLz
         0rKtp1Wa1wKM+4wOxe6S2NM7IvM104O0VDMqF6dBZCio7xE9mh7Cu4aVPpUzdWWTcg
         Yv8jSq4G7B/qhVIEQRJCaQcpoKWiffkRg+iO1SS0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 160/371] ARM: pxa: ssp: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Thu, 16 Jan 2020 12:20:32 -0500
Message-Id: <20200116172403.18149-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 9ee8578d953023cc57e7e736ae48502c707c0210 ]

Since commit 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
kfree, iounmap, clk_put etc are not needed anymore in remove path.

Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
[ commit message spelling fix ]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-pxa/ssp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index b92673efffff..97bd43c16cd8 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -230,18 +230,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 static int pxa_ssp_remove(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct ssp_device *ssp;
 
 	ssp = platform_get_drvdata(pdev);
 	if (ssp == NULL)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	clk_put(ssp->clk);
-
 	mutex_lock(&ssp_lock);
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
-- 
2.20.1

