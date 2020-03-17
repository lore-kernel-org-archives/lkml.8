Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E58EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6397320658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442867;
	bh=ORNsf8ifWYNyfXskgtLojG9pXI7P4qlT0Mdcgsoa344=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXAwi09hcZTivgxoaZrwsvsLjN7hFf0D6K+Q41p0IBOkMxrZI9fzeqq4b0eUXEpO1
	 y4yWVXv8CQRRwzKxHDgueA6O3AsElLUNWa7cXyeVlS9CTKnJjYvvOpfqAUHEPaKFht
	 7EQOAKI212LiVrOCp1QMOHOI/BPkT06KnMmir/uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCQLBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCQLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51DE20735;
        Tue, 17 Mar 2020 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442858;
        bh=ORNsf8ifWYNyfXskgtLojG9pXI7P4qlT0Mdcgsoa344=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDuK1qxfdRIH+bFRs3DcZjeSpbXCvI1Zv0WT2icqR3w2Mn27eAvxRIv5KVs7dyzzJ
         6w4DqPT8TYtz5qBMwgA5zR/rGaVX2RX5ldTw8fq+U3ZGwnyAVsOlgoVd5K1F/3yuG9
         gvDskzxxdWm87cU4UipXfzffInEJg1pTFHB5gCMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 016/123] net: fec: validate the new settings in fec_enet_set_coalesce()
Date:   Tue, 17 Mar 2020 11:54:03 +0100
Message-Id: <20200317103309.387625321@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ab14961d10d02d20767612c78ce148f6eb85bd58 ]

fec_enet_set_coalesce() validates the previously set params
and if they are within range proceeds to apply the new ones.
The new ones, however, are not validated. This seems backwards,
probably a copy-paste error?

Compile tested only.

Fixes: d851b47b22fc ("net: fec: add interrupt coalescence feature support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2529,15 +2529,15 @@ fec_enet_set_coalesce(struct net_device
 		return -EINVAL;
 	}
 
-	cycle = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->rx_coalesce_usecs);
 	if (cycle > 0xFFFF) {
 		dev_err(dev, "Rx coalesced usec exceed hardware limitation\n");
 		return -EINVAL;
 	}
 
-	cycle = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->tx_coalesce_usecs);
 	if (cycle > 0xFFFF) {
-		dev_err(dev, "Rx coalesced usec exceed hardware limitation\n");
+		dev_err(dev, "Tx coalesced usec exceed hardware limitation\n");
 		return -EINVAL;
 	}
 


