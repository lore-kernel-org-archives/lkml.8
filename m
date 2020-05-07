Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A78C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00252073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588862031;
	bh=wafRwZl9fucQ6Kdo8iS7pAL+wKFsNGDbbPPINuz48ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHEvS8AbBElajfZx1eqsaj0oKnO++VOypJSxZvRxVxmdImbQoiffmDYz/lZFgUUcT
	 ZwUjZXLZhjf1G4xMg8ZJ98Wpm3Zt9DDcuode0x6a96f99yAY9l6YS0qHt1bHtb35Zs
	 Pmrt7QHo/0/NNsSg9cXAf371gW9zeTWwA+0OZGEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgEGOdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgEGO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5919B208D6;
        Thu,  7 May 2020 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861769;
        bh=wafRwZl9fucQ6Kdo8iS7pAL+wKFsNGDbbPPINuz48ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNsTmTN3ybdTWdyvKFHRFCQVNJQj4NQeI1yLmFdx2ZSiUmKc+W0ijlbgMv+6QHErf
         bC+L7qVt1VKQxNWCKHrYnjJVjd0JQP+xZkG06wOxWtGPPyTutdQdaImBT/mYFpHKbU
         yAUIXRTyXMlNb3AwlxMCrgbjf5G9RAjaOUFT9QYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/20] dmaengine: pch_dma.c: Avoid data race between probe and irq handler
Date:   Thu,  7 May 2020 10:29:05 -0400
Message-Id: <20200507142917.26612-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142917.26612-1-sashal@kernel.org>
References: <20200507142917.26612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 2e45676a4d33af47259fa186ea039122ce263ba9 ]

pd->dma.dev is read in irq handler pd_irq().
However, it is set to pdev->dev after request_irq().
Therefore, set pd->dma.dev to pdev->dev before request_irq() to
avoid data race between pch_dma_probe() and pd_irq().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Link: https://lore.kernel.org/r/20200416062335.29223-1-madhuparnabhowmik10@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pch_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index afd8f27bda969..6e91584c36770 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -873,6 +873,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
+	pd->dma.dev = &pdev->dev;
 
 	err = request_irq(pdev->irq, pd_irq, IRQF_SHARED, DRV_NAME, pd);
 	if (err) {
@@ -888,7 +889,6 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		goto err_free_irq;
 	}
 
-	pd->dma.dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&pd->dma.channels);
 
-- 
2.20.1

