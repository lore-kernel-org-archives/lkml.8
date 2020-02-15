Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB3C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814E82086A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBOVSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:18:31 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34900 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgBOVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:18:02 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9D7EA29ADF; Sat, 15 Feb 2020 16:18:01 -0500 (EST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <c21a6263e31a1d994c1ae02f1f73e51d23dc2101.1581800613.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1581800613.git.fthain@telegraphics.com.au>
References: <cover.1581800613.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net-next 1/7] net/sonic: Remove obsolete comment
Date:   Sun, 16 Feb 2020 08:03:32 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is meaningless since mark_bh() was removed a long time ago.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/sonic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 31be3ba66877..e01273654f81 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -594,11 +594,6 @@ static void sonic_rx(struct net_device *dev)
 
 	if (rbe)
 		SONIC_WRITE(SONIC_ISR, SONIC_INT_RBE);
-	/*
-	 * If any worth-while packets have been received, netif_rx()
-	 * has done a mark_bh(NET_BH) for us and will work on them
-	 * when we get to the bottom-half routine.
-	 */
 }
 
 
-- 
2.24.1

