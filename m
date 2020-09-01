Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE153C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D3206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975087;
	bh=6v8rcxjk5E46zO64zz2NpKgHnlGR5IMJkXeHxdpH0BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aIm7nLtKo+Z0egWHaEfyF53Jb6h8agnl8TkRjC1kKNLbr37oJAx37jdtm6uK13IUH
	 n1dvuStOEPDqnxZduNnVN4aVdYcOndnWWxroj4ysjZrQ0ydXNxAUWyi/gPcyDw6cZV
	 a6lLG0sJny8yrXxMKQU/2Ms6OBq8vQ+yiGWbKgaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbgIAPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgIAPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:42:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 019102064B;
        Tue,  1 Sep 2020 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974927;
        bh=6v8rcxjk5E46zO64zz2NpKgHnlGR5IMJkXeHxdpH0BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A59D6HAm3H+lxmop8+rw0y0UAXjRhGPU9T0gUFywrcKFZmaTKYcMTZ+GNoD4tlu+U
         4KthePiccbbYdCRYkN+Vpk+WC/S7lwSuAalnZtKwVM6pegEcmX1uu5FM/0mBHNdiBY
         pxP+PTU8acwxtDUpySAa4OhPVI/jSL4mnZsr/6Ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 143/255] scsi: fcoe: Fix I/O path allocation
Date:   Tue,  1 Sep 2020 17:09:59 +0200
Message-Id: <20200901151007.555981504@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit fa39ab5184d64563cd36f2fb5f0d3fbad83a432c ]

ixgbe_fcoe_ddp_setup() can be called from the main I/O path and is called
with a spin_lock held, so we have to use GFP_ATOMIC allocation instead of
GFP_KERNEL.

Link: https://lore.kernel.org/r/1596831813-9839-1-git-send-email-michael.christie@oracle.com
cc: Hannes Reinecke <hare@suse.de>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index ec7a11d13fdc0..9e70b9a674409 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -192,7 +192,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
-- 
2.25.1



