Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318232073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202668;
	bh=zpzci73/WOYggS/ZHbcKp5B5Qj5/qqYf8+daUsf7X+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDcU+hzUUOVi0KGpo/1UVzPG87ithop1SioZgEnCjJ02TJdhBdmSUo95FcsSWbyfl
	 Gshs2RHnDURkGmbFy7QC1f9e2yybwQAe37Vfe8xTlD4NfOsM6oSc+1TICVUncACsen
	 HqRCtNJ3i+KAS9jCI5YJtMbw6sLdCLKzbVTMC+Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgAPQwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgAPQwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:52:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399992073A;
        Thu, 16 Jan 2020 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193565;
        bh=zpzci73/WOYggS/ZHbcKp5B5Qj5/qqYf8+daUsf7X+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oJYVDzJOyuKZVvho3neOYFgWmjuZTt0Lxr+Dtx9U1HGpQo3RcGsTnAud6gnXlMZi
         F4bEvpa5nKs+aQQq5zmygQi5w7yKuq8RNFqpS1diGBWexRjIe5IR6iBQ7cCkLp+HqR
         24iOCpfwgB2b7wEGV9B9tbl8hJU1fEL54iD9ULU0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 109/205] net: axienet: Fix error return code in axienet_probe()
Date:   Thu, 16 Jan 2020 11:41:24 -0500
Message-Id: <20200116164300.6705-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit eb34e98baf4ce269423948dacefea6747e963b48 ]

In the DMA memory resource get failed case, the error is not
set and 0 will be returned. Fix it by removing redundant check
since devm_ioremap_resource() will handle it.

Fixes: 28ef9ebdb64c ("net: axienet: make use of axistream-connected attribute optional")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 676006f32f91..479325eeaf8a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1790,10 +1790,6 @@ static int axienet_probe(struct platform_device *pdev)
 		/* Check for these resources directly on the Ethernet node. */
 		struct resource *res = platform_get_resource(pdev,
 							     IORESOURCE_MEM, 1);
-		if (!res) {
-			dev_err(&pdev->dev, "unable to get DMA memory resource\n");
-			goto free_netdev;
-		}
 		lp->dma_regs = devm_ioremap_resource(&pdev->dev, res);
 		lp->rx_irq = platform_get_irq(pdev, 1);
 		lp->tx_irq = platform_get_irq(pdev, 0);
-- 
2.20.1

