Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE257C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5082077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034957;
	bh=74mmgenOw4MmKp1UIPKTZunpiAwuag71URypgKevze8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDWNy2W7O32sVrxiHMc0W/k2KmAjF+hcLR/tzwUM7VdFVFGwPA2Z3L+gyOjM/1tHn
	 +OUJEGaAIeUNTycNs4usnqoIGkX4FaLl++aspTjXR/A/u3TxyznsbzG/T7P25wVr2z
	 rjqWiqvsdNQUgtI08ZmvGKCIKVp3cqHldUbdpkd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgFASJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbgFASJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:09:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A5A21531;
        Mon,  1 Jun 2020 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034953;
        bh=74mmgenOw4MmKp1UIPKTZunpiAwuag71URypgKevze8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2qkOodMwz+twJ4CAHA3qN+hGaI7tsFgA539Mk/rqE5HYFcpqvhMCbsvUbowXJBy4
         3ZB/t9QBPan+wbmOWUdWvc4xqteuQnoh8Ga0gs19V7GlNgxXgm12KTP3hdOT8UywAT
         uoujZISDvEEpp0Od3Ji8EPsgu1BJOODi+OXREd9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 086/142] RDMA/pvrdma: Fix missing pci disable in pvrdma_pci_probe()
Date:   Mon,  1 Jun 2020 19:54:04 +0200
Message-Id: <20200601174046.833868195@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit db857e6ae548f0f4f4a0f63fffeeedf3cca21f9d ]

In function pvrdma_pci_probe(), pdev was not disabled in one error
path. Thus replace the jump target “err_free_device” by
"err_disable_pdev".

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Link: https://lore.kernel.org/r/20200523030457.16160-1-wu000273@umn.edu
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index e580ae9cc55a..780fd2dfc07e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -829,7 +829,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	    !(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "PCI BAR region not MMIO\n");
 		ret = -ENOMEM;
-		goto err_free_device;
+		goto err_disable_pdev;
 	}
 
 	ret = pci_request_regions(pdev, DRV_NAME);
-- 
2.25.1



