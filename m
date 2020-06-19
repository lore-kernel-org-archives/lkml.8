Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F199A20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581725;
	bh=hS28z6xSWw2sPqJgW7kXj7XRamTjmuW8YLgw81pClG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oh1GMqz60ggwTbOTWhHkDM5BeU3yfniFeHFnx+C+J2dUqREmrKMMZ6S3vNZ12YrKF
	 MshFstA5D0QVVRr6MtoPFAtouh6DrwwljAbr9/UlzfUYcp1dqx/tZZ1YfodOfiTvXX
	 ljkxTbIOynCkPdd5PD/KCo5UZJ8YFCmc5eoXX3yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393413AbgFSPZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393019AbgFSPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:22:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B312158C;
        Fri, 19 Jun 2020 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580154;
        bh=hS28z6xSWw2sPqJgW7kXj7XRamTjmuW8YLgw81pClG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8Ez84T3dspR9oRkAJk2itAWVxEsWj+8/hf/brGZ14Z49Vj2nEiK3ZX0l4/2PGubD
         DX7xU/UAZvEEIoVskIcb/KOFPRaL2f9LowgtgVmC4Nu+1m8a0K2RmATvhOGOIMxohn
         b2TBGuZGLcruEy8dPAv96JjaUbs2x+ZQM0VHrkCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 141/376] octeontx2-pf: Fix error return code in otx2_probe()
Date:   Fri, 19 Jun 2020 16:30:59 +0200
Message-Id: <20200619141717.008834749@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 654cad8b6a17dcb00077070b27bc65873951a568 ]

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 5a6d7c9daef3 ("octeontx2-pf: Mailbox communication with AF")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 411e5ea1031e..64786568af0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1856,13 +1856,17 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	num_vec = pci_msix_vec_count(pdev);
 	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
 					  GFP_KERNEL);
-	if (!hw->irq_name)
+	if (!hw->irq_name) {
+		err = -ENOMEM;
 		goto err_free_netdev;
+	}
 
 	hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
 					 sizeof(cpumask_var_t), GFP_KERNEL);
-	if (!hw->affinity_mask)
+	if (!hw->affinity_mask) {
+		err = -ENOMEM;
 		goto err_free_netdev;
+	}
 
 	/* Map CSRs */
 	pf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
-- 
2.25.1



