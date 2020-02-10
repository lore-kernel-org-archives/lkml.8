Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C4C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B145420715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341671;
	bh=jiH/1NJQ3r99P/MDz9ZrlyzqWg/DeLBz+3yqpz+xsaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IjvZtSm6B3TMurb8iyZ0QMD7Q/VTMRvEfytByPDu16X9nxzkBNoAWY5aiwZNN14Ir
	 8BC5HKuichlFARqQeAOe2+ugJJEtj3XSexlSORyk46vrr1cy7jV6W0EkW/jkNZh5oC
	 oSNa6y1H/5IclqsgTn9mj+FSVSBkNtQ6oJ0pEwyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgBJNeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgBJMf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:29 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A03E20873;
        Mon, 10 Feb 2020 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338128;
        bh=jiH/1NJQ3r99P/MDz9ZrlyzqWg/DeLBz+3yqpz+xsaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sJdqhohVIe8wD7gjcS0mT09yOgBcKIiUqx0tiT207EHPWn+VkBr6lVcX3MH+Zs5a
         6rb8ilug5f9nBkIfgtlPWBYd7OP6M9mXmax7BvO+4nD2HjXwQd/9gZ1w4EmzkpDtnf
         pu/RvH22vsY8uQwDBuDvsZ9j06pAoGBu6n7tl5bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yurii Monakov <monakov.y@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/195] PCI: keystone: Fix link training retries initiation
Date:   Mon, 10 Feb 2020 04:32:07 -0800
Message-Id: <20200210122312.629241648@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
 drivers/pci/controller/dwc/pci-keystone-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
index 0682213328e93..15c612e853afb 100644
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ b/drivers/pci/controller/dwc/pci-keystone-dw.c
@@ -425,7 +425,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 	/* Disable Link training */
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+	ks_dw_app_writel(ks_pcie, CMD_STATUS, val);
 
 	/* Initiate Link Training */
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-- 
2.20.1



