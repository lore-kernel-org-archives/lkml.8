Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400CC204EF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFCVzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:55:35 -0400
Received: from wp148.webpack.hosteurope.de (wp148.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:849b::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C20C08C5C0;
        Wed,  3 Jun 2020 14:55:35 -0700 (PDT)
Received: from ip1f126570.dynamic.kabel-deutschland.de ([31.18.101.112] helo=pengu.fritz.box); authenticated
        by wp148.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jgbM1-0005tH-Io; Wed, 03 Jun 2020 23:55:21 +0200
From:   Roelof Berg <rberg@berg-solutions.de>
Cc:     andrew@lunn.ch, rberg@berg-solutions.de,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lan743x: Use correct MAC_CR configuration for 1 GBit speed
Date:   Wed,  3 Jun 2020 23:54:14 +0200
Message-Id: <20200603215414.3606-1-rberg@berg-solutions.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;rberg@berg-solutions.de;1591221335;66a411b9;
X-HE-SMSGID: 1jgbM1-0005tH-Io
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the MAC_CR configuration bits for 1 GBit operation. The data
sheet allows MAC_CR(2:1) to be 10 and also 11 for 1 GBit/s speed, but
only 10 works correctly.

Devices tested:
Microchip Lan7431, fixed-phy mode
Microchip Lan7430, normal phy mode

Signed-off-by: Roelof Berg <rberg@berg-solutions.de>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 36624e3c633b..c5c5c688b7e2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -985,7 +985,7 @@ static void lan743x_phy_link_status_change(struct net_device *netdev)
 		break;
 		case SPEED_1000:
 			data |= MAC_CR_CFG_H_;
-			data |= MAC_CR_CFG_L_;
+			data &= ~MAC_CR_CFG_L_;
 		break;
 		}
 		lan743x_csr_write(adapter, MAC_CR, data);
-- 
2.25.1

