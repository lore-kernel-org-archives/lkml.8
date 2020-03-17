Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A306C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481C520663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443798;
	bh=ORNsf8ifWYNyfXskgtLojG9pXI7P4qlT0Mdcgsoa344=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foBlqu87k7JtTIQ7rRj5eKvyqU/jTvOVwNGmEyYS8u8WDZ4B+XcyXG/mSNwFxBbDe
	 MiQGGqU7l/3XEHPuQeccv5u+nrSgXLGROaMWWNiQXxqYKU6BVgLWClqS6DqJtcAeqB
	 o44tgzupgcvdhkH0Ehl/fJKn2oN97LyGNvslunbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgCQLQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgCQLJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B18EE2071C;
        Tue, 17 Mar 2020 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443350;
        bh=ORNsf8ifWYNyfXskgtLojG9pXI7P4qlT0Mdcgsoa344=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPWA2AxaJkF8xPxd9WzQOer+MS/NXlqVKTZQTtvaXwD4huGAQUsx4HdAyclES3KT3
         D6Tl/HYG6RdjBjb4vLz8LCrDpfEgcbQYxfh0k0dXPywbRKiV3nYKu+Fb9Xe8mdRDES
         e7lAChaBVPyt/V7akSgZI20d5t+w+oUNpFncxxiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 017/151] net: fec: validate the new settings in fec_enet_set_coalesce()
Date:   Tue, 17 Mar 2020 11:53:47 +0100
Message-Id: <20200317103327.646741667@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
 


