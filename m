Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEB0206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610220;
	bh=ab0r9IfkDtKpMoh/GQIVN/80yR8gGf7AoyAWkiwtcGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=giciP/o3A+PnvWqpCwCoI1lZOXCGdPSkpoV4e0wn2FTEylqKmU+3NGIIWR1r6pjiR
	 ZXpDtALQmMs/jkPrl5ivsPfS7lEa15LlD/NC6E/HFZ+X6UUNeEaft7N6qrdKgi/f49
	 /W8SwOxovfhE95q7JVrttpA69INJuh3EB7t8Dtj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBMPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgBMPW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:29 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99DA246A3;
        Thu, 13 Feb 2020 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607348;
        bh=ab0r9IfkDtKpMoh/GQIVN/80yR8gGf7AoyAWkiwtcGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAZagJP9z7Cu3v0afPMoPbt9d+FYIHDTeHQtycNRnsuU2DXiSS2CyqMmfAzADzhpP
         Fa+S/P5mhROd7Q41rXXLq6QO7X+5XvBe14oO/tEIUSzxl1YRpcQ7wJDsqolu923zlH
         xeUNwjtCTKHemZ4pftxTssfChWvECiX17Sdbk1wA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yurii Monakov <monakov.y@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 20/91] PCI: keystone: Fix link training retries initiation
Date:   Thu, 13 Feb 2020 07:19:37 -0800
Message-Id: <20200213151829.461773737@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yurii Monakov <monakov.y@gmail.com>

[ Upstream commit 6df19872d881641e6394f93ef2938cffcbdae5bb ]

ks_pcie_stop_link() function does not clear LTSSM_EN_VAL bit so
link training was not triggered more than once after startup.
In configurations where link can be unstable during early boot,
for example, under low temperature, it will never be established.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Andrew Murray <andrew.murray@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pci-keystone-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 6153853ca9c31..988e7e7350c74 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -450,7 +450,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 	/* Disable Link training */
 	val = readl(ks_pcie->va_app_base + CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
+	writel(val,  ks_pcie->va_app_base + CMD_STATUS);
 
 	/* Initiate Link Training */
 	val = readl(ks_pcie->va_app_base + CMD_STATUS);
-- 
2.20.1



