Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D3924681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221108;
	bh=CwfZ1H8X1p7Fd8B1m8P4+3t8bxY1BM74FU8/Es5lOLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nMfVlF4/Xhk61Mx34kpa4/YnPMYMF14d6Dlzsr3FMsGb0ELU6eBB74Wcl1Z2JdqHA
	 pE2WL581Hh6YI/5FpGQ+CIKshbommwkfbO1adCBiz/EC5wVUHJw5YxpYQZYHDgMOrE
	 v8IMIbxztDZflndv0AEz+t5NNLLYTOUmrqOOayqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgA1OS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbgA1OSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:18:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD3224681;
        Tue, 28 Jan 2020 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221101;
        bh=CwfZ1H8X1p7Fd8B1m8P4+3t8bxY1BM74FU8/Es5lOLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVfCKm/n9fubO+eby+9wOfe+++2s5p3apPot2ssemvWj7qAOZQzddAHIJi/R1hFe5
         D7Vxdbvb9dRNw850fU4cv3t7i9coMnGLWhSjP09WxSEkheaq1i4S+ZwtOnz8xQShpp
         tH0mT/FuVFXboHjvXUg3nwSGIgJQSwOX+uVB2G5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 089/271] mmc: sdhci-brcmstb: handle mmc_of_parse() errors during probe
Date:   Tue, 28 Jan 2020 15:03:58 +0100
Message-Id: <20200128135859.210530362@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 1e20186e706da8446f9435f2924cd65ab1397e73 ]

We need to handle mmc_of_parse() errors during probe otherwise the
MMC driver could start without proper initialization (e.g. power sequence).

Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 159f6f64c68e7..ed6473731b458 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -90,7 +90,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 
 	sdhci_get_of_property(pdev);
-	mmc_of_parse(host->mmc);
+	res = mmc_of_parse(host->mmc);
+	if (res)
+		goto err;
 
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
-- 
2.20.1



